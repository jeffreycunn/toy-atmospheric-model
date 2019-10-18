function [ th,thm,pim,pic,pprt] = cmm_init(xs,g,nx,nz,zu,dx,dz,zcnt,xcnt,radz,radx,trigpi,...
    cp,rhou,tb,qb,thermamp,th,thm,pim,pic,pprt,bubble_switch)
#UNTITLED6 Summary of this function goes here
#   Detailed explanation goes here

## bubble

if bubble_switch == 1
#  add a bubble-shaped potential temperature perturbation
      for i = 2:nx-1
        for k = 2 : nz-1
          rad = sqrt(((zu[k]-zcnt)/radz)^2 + ((xs[i]-xcnt)/radx)^2);
          if(rad <= 1.0)
            th[i,k] = 0.5*thermamp*(1.0 + cos(rad*trigpi));
          else
            th[i,k] = 0.0;
          end
#  make crude assumption that first two time levels are the same
          thm[i,k] = th[i,k];
        end
#  apply lower BC
        thm[i,1]=thm[i,2];
        th[i,1]=th[i,2];
      end


#  add a pressure field in hydrostatic balance with the initial bubble
        for i = 2:nx-1
#  assume pressure perturbation is zero at model top and integrate down
          pic[i,nz-1] = 0.0;
          for k = nz-2:-1:2
            tup = th[i,k+1]/(tb[k+1]^2) ;
            tdn = th[i,k]  /(tb[k]^2) ;
            pic[i,k] = pic[i,k+1] - (g/cp)*0.5*(tup+tdn)*dz;
#  make crude assumption that first two time levels are the same
            pim[i,k] = pic[i,k];
          end
#  get the aritifical point below the grid (eventually move this to BBC code?)
          pic[i,1] = pic[i,2];
          pim[i,1] = pim[i,2];
        end

##
# pic(:,:) = 0;
# pim(:,:) = 0;

elseif bubble_switch == 0

th[:,:] .= 0;
thm[:,:] .= 0;

end

##




end
