function [ varm,var,varp ] = asselin( varm,var,varp,asscoef,nx,nz )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here


% Apply Asselin filtering for 2dt filtering
for k = 2 : nz-1
  for i = 2 : nx-1


var[i,k] = var[i,k] + asscoef*(varp[i,k]-2*var[i,k]+varm[i,k]);

  end
end


end
