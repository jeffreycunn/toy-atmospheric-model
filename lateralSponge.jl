function [ varp ] = lateralSponge(varp,varb,x_loc,x_dist_in,dx,nx,trigpi,latdmpcoef,u_switch)
%UNTITLED2 Summary of this function goes here


%  by default, make the sponging layer 10% of the total domain width
      xwidth=0.1*(nx-1)*dx;

      coef=0.0;

%  if we're within the west sponge zone, then apply damping
        if x_loc <= xwidth
          coef =  0.5*(1.-cos(trigpi*(xwidth-x_loc))/xwidth);
        end

%  if we're within the east sponge zone, then apply damping
        if x_loc >= ((nx-1)*dx-xwidth)
          coef =  0.5*(1.-cos(trigpi*         ...
                       (x_loc-(nx-1)*dx-xwidth))/xwidth);
        end

%  apply sponge to slowly remove perturbations
        if coef > 0.0
          varp = varp - coef*(varp-varb);
        end




end
