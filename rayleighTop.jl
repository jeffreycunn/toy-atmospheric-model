function [ varp ] = rayleighTop(varz,varztop,varp,varb,raydmpcoef,raydmpz,trigpi,i,k)
%UNTITLED2 Summary of this function goes here
%   Set varb to 0 for w,th,and pic


  % Compute Local Damping Coefficient
coef = raydmpcoef*0.5*(1-cos(trigpi*(varz-raydmpz)/(varztop-raydmpz)));


% Apply Sponge to Slowly Remove Perturbations
varp = varp - coef*(varp-varb);

end
