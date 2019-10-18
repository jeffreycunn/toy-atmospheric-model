function [ zu,zw,xu,xs ] = griddef(nz,nx,dz,dx,zu,zw,xu,xs)
#UNTITLED2 Summary of this function goes here
#   Detailed explanation goes here


# Assign height values to u-scalar heights


for k = 1 : nz
  zu[k] = (k - 1.5)*dz;
end

# Assign height values to w heights

for k = 2 : nz
  zw[k] = dz*(k-2);
end

# Assign x-dist values to u on the x grid-pt

for i = 2 : nx

    xu[i] = dx*(i-2);

end

# Assign x-dist values to scalars on the x grid-pt

# xs(1) = dx/2;

for i = 2 : nx

#    xs(i) = dx/2 + dx*(i-1);
     xs[i] = (i-1.5)*dx;

end

end
