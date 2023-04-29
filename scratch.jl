using PyPlot

test_case = "test21"
dtoutput = 100  # Seconds
modeloutputpathandfilename = test_case * ".mat"
CMM_driver(modeloutputpathandfilename, dtoutput)
CMM_graphics(modeloutputpathandfilename, 10, test_case, dtoutput)

CMM_graphics(modeloutputpathandfilename, 1, test_case, dtoutput)
CMM_graphics(modeloutputpathandfilename, 3, test_case, dtoutput)
CMM_graphics(modeloutputpathandfilename, 5, test_case, dtoutput)
CMM_graphics(modeloutputpathandfilename, 6, test_case, dtoutput)
CMM_graphics(modeloutputpathandfilename, 7, test_case, dtoutput)
CMM_graphics(modeloutputpathandfilename, 8, test_case, dtoutput)

##
title_in = "Perturbation Potential Temperature (K) at t = "
title_in = "Pressure Perturbation (Pa) at t = "
title_in = "W-wind (m/s) at t ="
title_in = "U-wind (m/s) at t = "
title_in = "Water Vapor Mixing Ratio (kg/kg) at t = "
title_in = "Cloud Water Mixing Ratio (kg/kg) at t = "
title_in = "Rain Water Mixing Ratio (kg/kg) at t = "

b_mat = [900 2400 3600]
for b in b_mat
    var_input = "qrain"
    test_case = "test21"
    modeloutputpathandfilename = test_case * ".mat"
    n = b
    CMM_graphics_v3(modeloutputpathandfilename, title_in, var_input, test_case, n)
end


modeloutputpathandfilename = "test15.mat"
x_interval = dx/1000
x_end = (dx/1000)*(nx-1)
y_begin = dz/2000
y_interval = dz/1000
y_end = (dz*nz/1000)-(dz/2000)
x = range(0.0, stop=x_end, step=x_interval)
y = range(y_begin, stop=y_end, step=y_interval)
u_qv = fliplr(rot90(u_3600, (1, 2)))
w_qv = fliplr(rot90(w_3600, (1, 2)))
th_tot=zeros(nx, nz)
for k in 1:nz
    for i in 1:nx
        th_tot[i,k] = tb[k] + th_3600[i,k]
    end
end

for i in 1:3:nx-3
    u_qv[:,i] = 0
    u_qv[:,i+2] = 0
    w_qv[:,i] = 0
    w_qv[:,i+2] = 0
end

for i in 1:2:nz-2
    u_qv[i,:] = 0
    u_qv[i+2,:] = 0
    w_qv[i,:] = 0
    w_qv[i+2,:] = 0
end

mask=zeros(nx, nz)
mask[260:340, 1:3] .= 5000
mask[270:330, 4:7] .= 5000
mask[280:320, 8
