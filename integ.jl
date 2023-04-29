#some of the functions were matlab functions that ive changed to julia friendly
function integ(tbv, pib, p0, lv, rd, ub, g, cp, c_sound, rhow, rhou, tb, zu, zw, xu, xs, x_dist_in,
    latdmpcoef, raydmpcoef, raydmpz, trigpi, qb, um, u, up, wm, w, wp, thm, th, thp, pim, pic, pip, pprt,
    qvtot, qvm, qv, qvp, qcm, qc, qcp, qrainm, qrain, qrainp, dx, dz, nt, nz, nx, dt, asscoef, cmixh,
    cmixv, qc0, k1, k2, thvm, thv, thvp, modeloutputpathandfilename, dtoutput)

VT = zeros(nx, nz)
ql = zeros(nx, nz)
tv = zeros(nx, nz)

# Set Variable name for a given timestep
thisdump = dtoutput

# Set var_0 equal to var_init
th_0 = th
u_0 = u
w_0 = w
pi_0 = pic
pprt_0 = pprt
qv_0 = qv
qc_0 = qc
qrain_0 = qrain

th_str = "th_0"
u_str = "u_0"
w_str = "w_0"
pi_str = "pi_0"
pprt_str = "pprt_0"
qv_str = "qv_0"
qc_str = "qc_0"
qrain_str = "qrain_0"
dt_str = "dt"
dx_str = "dx"
dz_str = "dz"
nz_str = "nz"
nx_str = "nx"
nt_str = "nt"
qb_str = "qb"
zu_str = "zu"
zw_str = "zw"
xu_str = "xu"
xs_str = "xs"
tb_str = "tb"

# Append New Timesteps to .mat file.
full_str = "save $modeloutputpathandfilename $th_str $u_str $w_str $pi_str $pprt_str $qv_str $qc_str $qrain_str $dt_str $dx_str $dz_str $nt_str $nx_str $nz_str $qb_str $zu_str $zw_str $xu_str $xs_str $tb_str"
eval(full_str)

# um[:, :] = ub
# u[:, :] = ub
wm[:, :] .= 0.0
w[:, :] .= 0.0
# pic[:, :] = 0.0         # Uncomment to make the initial step non-hydrostatic
# pim = pic
thm = th
moist = 2
# mtncenter = 25000;

u[260:340, 1:3] .= 0
w[260:340, 1:3] .= 0
u[270:330, 4:7] .= 0
w[270:330, 4:7] .= 0
u[280:320, 8:11] .= 0
w[280:320, 8:11] .= 0
u[290:310, 12:14] .= 0
w[290
