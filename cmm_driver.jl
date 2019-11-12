function CMM_driver(modeloutputpathandfilename,dtoutput)

include("user_settings.jl")
#import Pkg.add("user_settings.jl")
# Define User_Settings

#using user_settings

# Define Constants

include("constants.jl")

# Define Grid

[ zu,zw,xu,xs ] = griddef(nz,nx,dz,dx,zu,zw,xu,xs);

# Initialize the Base State
[ tb,qb,qbs,tbv,pisfc, pib, rhou, rhow,rhb,ub,um,u ] = ...
    base( profile_method,nx,nz,dz,psurf,qsurf,q4km,ztr,temptr,ttr,tsurf,p0,cp,g,...
    rd,xk,c_v,zu,rhow,rhou,tb,tbv,qb,qbs,rhb,pib,ub,um,u);

# Set Initial Conditions

[ th,thm,pim,pic,pprt] = cmm_init(xs,g,nx,nz,zu,dx,dz,zcnt,xcnt,radz,radx,trigpi,...
    cp,rhou,tb,qb,thermamp,th,thm,pim,pic,pprt,bubble_switch);


# Integrate the Model

integ(tbv,pib,p0,lv,rd,ub, g, cp, c_sound,rhow,rhou,tb, zu, zw,xu,xs,x_dist_in, ...
    latdmpcoef,raydmpcoef,raydmpz,trigpi,qb,um,u,up,wm,w,wp,thm,th,thp,pim,pic,pip,pprt,...
    qvtot,qvm,qv,qvp,qcm,qc,qcp,qrainm,qrain,qrainp,dx,dz,nt,nz,nx,dt,asscoef,cmixh,cmixv,...
    qc0,k1,k2,thvm,thv,thvp,modeloutputpathandfilename,dtoutput);

# Save Model Data to Output File

# save (modeloutputpathandfilename)

end
