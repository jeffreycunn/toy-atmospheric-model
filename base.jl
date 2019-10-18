function [ tb,qb,qbs,tbv,pisfc, pib, rhou, rhow,rhb, ub,um,u ] = ...
    base( profile_method,nx,nz,dz,psurf,qsurf,q4km,ztr,temptr,ttr,tsurf,p0,cp,g,...
    rd,xk,c_v,zu,rhow,rhou,tb,tbv,qb,qbs,rhb,pib,ub,um,u)
#UNTITLED5 Summary of this function goes here
#   Detailed explanation goes here

if profile_method == 1
    #########################################
    # Define a dry and neutral environment

    # Set base state theta to 300 K and mixing ratio to 0 kg/kg

    for k = 2 : nz - 1
        tb[k] = 300.0;
        qb[k] = 0.0;
        tbv[k] = tb(k)*(1 + 0.61*qb(k));

    end

    # Assign pi
    pisfc = (psurf / p0)^xk;
    pib[2] = pisfc - g*0.5*dz/(cp*tbv(2));

    for k = 3 : nz - 1

        tbvavg[k] = 0.5*(tbv(k) + tbv(k-1));
        pib[k] = pib(k-1) - g*dz/(cp*tbvavg(k));

    end

    for k = 2 : nz - 1
        #  Assign mean state density at u point

        rhou[k] = (p0*pib(k)^(c_v/rd))/(rd*tbv(k));

        # Assign mean state density at w point

        rhow[k] = 0.5*(rhou(k) + rhou(k-1));

    end
    #Ensure there is no gradient at the boundaries
    tb[1] = tb(2);
    tb[nz] = tb(nz-1);
    pib[1] = pib(2);
    pib[nz] = pib(nz-1);
    rhou[1] = rhou(2);
    rhou[nz] = rhou(nz-1);
    rhow[2] = 1.15;
    rhow[1] = rhow(2);
    rhow[nz] = rhow(nz-1);

elseif profile_method == 2
    ## fovellwk82soundingdef
    # define a sounding on the u/scalar points

    # Assign Values to vertical grid

    for k = 2 : nz - 1

        # Assign water vapor mixing ratio
        if(zu[k] <= 4000.0)
            qb[k] = qsurf - (qsurf - q4km)*zu(k)/4000.0;
        elseif (zu[k] <= 8000.0)
            qb[k] = q4km - q4km*(zu(k)-4000.0)/4000.0;
        else
            qb[k] = 0.0;
        end

        # Assign potential temperature
        if(zu[k]<= ztr)
            tb[k] = tsurf + (ttr - tsurf)*(zu(k)/ztr)^1.25;
        else
            tb[k] = ttr*exp(g*(zu(k) - ztr)/(cp*temptr));
        end

        # Assign virtual potential temperature
        tbv[k] = tb(k)*(1 + 0.61*qb(k));

    end

    # Assign pi
    pisfc = (psurf / p0)^xk;
    pib[2] = pisfc - g*0.5*dz/(cp*tbv(2));

    for k = 3 : nz - 1

        tbvavg[k] = 0.5*(tbv(k) + tbv(k-1));
        pib[k] = pib(k-1) - g*dz/(cp*tbvavg(k));

    end

    #  Assign mean state density at u point
    for k = 2 : nz-1

        rhou[k] = (p0*pib(k)^(c_v/rd))/(rd*tbv(k));


        # Assign mean water vapor saturation mixing ratio

        t[k] = tb(k)*pib(k);
        p[k] = p0*pib(k)^(cp/rd);
        qbs[k] = (380.0/p(k))*exp(17.27*(t(k)-273.0)/(t(k)-36.0));

        # Calculate and Assign RH

        rhb[k] = qb(k)/qbs(k);

    end

    #  define density at the true surface from known information
    pisfc = (psurf/p0)^xk;
    rhow[2] = p0*(pisfc^(c_v/rd))/(rd*tsurf);

    #  define density at the other w points by interpolating from u/scalar points
    for k=3:nz-1
        rhow[k] = 0.5*(rhou(k) + rhou(k-1));
    end

elseif profile_method == 3


        #  define the Weisman Klemp sounding on the u/scalar points

        for k=2 : nz-1
            #  assign potential temperatures and relative humidities
            if zu[k]<= ztr
                tb[k] = tsurf + (ttr-tsurf)*(zu[k]/ztr)^1.25;
                rhb[k] = 1 - 0.02*(zu[k]/ztr)^1.25;
            elseif zu[k] > ztr
                tb[k] = ttr*exp(g*(zu[k]-ztr)/(cp*temptr));
                rhb[k] = 0.98;
            end
            #  first guess sans moisture
            tbv[k] = tb[k];
        end

        #  compute the non-dimensional pressure profile as a first guess
        #    (needed for qvs below)
        pisfc = (psurf / p0)^xk;
        pib[2] = pisfc - g*0.5*dz/(cp*tbv[2]);

        for k = 3 : nz - 1
            tbvavg = 0.5*(tbv[k] + tbv[k-1]);
            pib[k] = pib[k-1] - g*dz/(cp*tbvavg);
        end

        #  convert to mixing ratios
        for k=2 : nz-1
            p = p0*pib[k]^(cp/rd);
            temp = tb[k]*pib[k];
            qvs = (380.0/p) * exp((17.27*(temp-273.0))/(temp-36.0));
#             if zu(k) < 20000
            qb[k] = min(qsurf,qvs*rhb[k]);
#             else
#             qb(k) = 0;
#             end
            #  define virtual potential temperatures
            tbv[k] = tb[k]*(1 + 0.61*qb[k]);

        #   if k==98 || k == 99 || k == 100
        #     display(k)
        #     display(p)
        #     display(temp)
        #     display(qvs)
        #     display('qb')
        #     display(qb(k))
        #     display('tbv')
        #     display(tbv(k))
        #     display('rhb')
        #     display(rhb(k))
        #   end
        # end

        #  go back and recompute the non-dimensional pressure profile now that
        #    we have humidity included
        pisfc = (psurf / p0)^xk;
        pib[2] = pisfc - g*0.5*dz/(cp*tbv[2]);

        for k = 3 : nz - 1

            tbvavg = 0.5*(tbv[k] + tbv[k-1]);
            pib[k] = pib[k-1] - g*dz/(cp*tbvavg);

        end

        #  compute the density profile
        pisfc = (psurf/p0)^xk;
        rhow[2] = p0*(pisfc^(c_v/rd))/(rd*tsurf);

        #  define density at the other w points by interpolating from u/scalar points
        #  define density at u/scalar points
      for k=2:nz-1
        rhou[k] = p0*(pib[k]^(c_v/rd))/(rd*tbv[k]);
      end

#  define density at the true surface from known information
      pisfc = (psurf/p0)^xk;
      rhow[2] = p0*(pisfc^(c_v/rd))/(rd*tsurf);

#  define density at the other w points by interpolating from u/scalar points
      for k=3:nz-1
        rhow[k] = 0.5*(rhou[k] + rhou[k-1]);
      end

        #  compute the profiles of saturation mixing ratio and relative humidity
       #  define saturation mixing ratio on u/scalar points
      for k=2: nz-1
        p = p0*pib[k]^(cp/rd);
        temp = tb[k]*pib[k];
#  use Teten's formula (see Pielke's text, 2nd ed., p. 257-258 for more info)
        qbs[k] = (380.0/p) * exp((17.27*(temp-273.0))/(temp-36.0));
        rhb[k] = qb[k] / qbs[k];
      end



 end # End Method If Statement



    #Ensure there is no gradient at the boundaries
    tb[1] = tb[2];
    tb[nz] = tb[nz-1];
    tbv[1] = tbv[2];
    tbv[nz] = tbv[nz-1];
    pib[1] = pib[2];
    pib[nz] = pib[nz-1];
    rhou[1] = rhou[2];
    rhou[nz] = rhou[nz-1];
    rhow[1] = rhow[2];
    rhow[nz] = rhow[nz-1];
    qb[1] = qb[2];
    qb[nz] = qb[nz-1];

## Define U base

# Uniform Flow

    ub[:] .= -10;
    um[:,:] .= -10;
    u[:,:] .= -10;

############################################################
# High Surface Wind decreasing as altitude increases

#     usfc=-10.0;  # u-wind at the surface (m/s)
#     # * for initwinds=1 (only)
#     deltau=10.0;  # u-wind change over the layer (m/s)
#     # * for initwinds=1 (only)
#     shrdepth=3000.0;  # depth of deltau layer (m)
#     #  * for initwinds=1 (only)
#
#
#     for k=2:nz-1
#         #  assign base state values
#         if zu(k)<shrdepth
#             ub(k) = usfc + zu(k)*deltau/shrdepth;
#         else
#             ub(k) = usfc + deltau;
#         end
#         for i= 1 :nx
#             #  copy base state values into prognosed u array
#             u(i,k) = ub(k);
#             um(i,k) = ub(k);
#         end
#     end

###################################################################

# Low-Level Jet at a given z height (given by shrdepth)
#
#     usfc=0;  # u-wind at the surface (m/s)
#     # * for initwinds=1 (only)
#     deltau=-10.0;  # u-wind change over the layer (m/s)
#     # * for initwinds=1 (only)
#     shrdepth=2000.0;  # depth of deltau layer (m)
#     #  * for initwinds=1 (only)
#
#     for k=2:nz-1
#         #  assign base state values
#         if zu(k)<=shrdepth
#             ub(k) = usfc + zu(k)*deltau/shrdepth;
#         elseif zu(k) <= 2*shrdepth
#             ub(k) = 2*deltau  - deltau*(zu(k)/(shrdepth));
#         else
#             ub(k) = 0;
#         end
#     for i= 1 :nx
#             #  copy base state values into prognosed u array
#             u(i,k) = ub(k);
#             um(i,k) = ub(k);
#      end
#      end
######################################################################
    #  handle boundaries
    for i=1:nx
        u[i,1] = ub[2];
        up[i,1] = ub[2];
        um[i,1] = ub[2];
        u[i,nz] = ub[nz-1];
        up[i,nz] = ub[nz-1];
        um[i,nz] = ub[nz-1];
    end







end
