function [ varp,varm ] = diffusion(varb,varp,varm,cmixh,cmixv,dx,dz,dt,nx,nz)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

% Horizontal Diffusion

kmixh=cmixh*dx*dx/dt;

for k = 2 : nz-1
  for i = 2 : nx-1
varp[i,k] = varp[i,k] + 2.0*dt*kmixh*(varm[i+1,k]-2.0*varm[i,k]+varm[i-1,k])/(dx*dx);


  end
end

% Vertical Diffusion
kmixv=cmixv*dz*dz/dt;

for k = 3 : nz-1
  for i = 2 : nx-1

varp(i,k) = varp[i,k] + 2*dt*(kmixv*((varm[i,k+1]-varb[k+1])     ...
                 -2.0*(varm[i,k]-varb[k])                        ...
                 +(varm[i,k-1]-varb[k-1]) )/(dz*dz));



  end
end


end
