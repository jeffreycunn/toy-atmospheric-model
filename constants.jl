#########################################################################
#  Physical and mathematical constants

g = 9.8;   # gravitational acceleration: m/s^2
cp = 1004.0;  # specific heat at constant p: J/(kg K)
rd = 287.0;  # dry gas constant:  J/(kg K)
c_v = cp-rd;  # specific heat at constant V: J/(kg K)
xk = rd/cp;  # kappa, the ratio of rd/cp
p0 = 100000.0;  # reference pressure:  Pa
lv = 2500000.0;  # latent heat of vaporization:  J/kg
trigpi = pi; # trigonmetric pi
rhol = 1000.0; # Density of Rain drop (1000 kg/m^3)

#########################################################################

## Initialize Variable Arrays

zw = zeros(1,nz);
zu = zeros(1,nz);
xu = zeros(1,nx);
xs = zeros(1,nx);
rhow=zeros(1,nz);
rhou=zeros(1,nz);
tbv=zeros(1,nz);
ub=zeros(1,nz);
tb=zeros(1,nz);
qb=zeros(1,nz);
pib=zeros(1,nz);
qbs=zeros(1,nz);
rhb=zeros(1,nz);
qvm=zeros(nx,nz);
qv=zeros(nx,nz);
qvp=zeros(nx,nz);
qvtot = zeros(nx,nz);
qcm=zeros(nx,nz);
qc=zeros(nx,nz);
qcp=zeros(nx,nz);
qrainm=zeros(nx,nz);
qrain=zeros(nx,nz);
qrainp=zeros(nx,nz);
thm=zeros(nx,nz);
th=zeros(nx,nz);
thp=zeros(nx,nz);
thvm=zeros(nx,nz);
thv=zeros(nx,nz);
thvp=zeros(nx,nz);
um=zeros(nx,nz);
u=zeros(nx,nz);
up=zeros(nx,nz);
wm=zeros(nx,nz);
w=zeros(nx,nz);
wp=zeros(nx,nz);
pim=zeros(nx,nz);
pic=zeros(nx,nz);
pip=zeros(nx,nz);
pprt=zeros(nx,nz);
