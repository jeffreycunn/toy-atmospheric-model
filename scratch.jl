clear
close all

test_case = 'test21'
dtoutput = 100;  # Seconds
modeloutputpathandfilename = [test_case '.mat']
CMM_driver(modeloutputpathandfilename,dtoutput)
CMM_graphics(modeloutputpathandfilename,10,test_case,dtoutput)

CMM_graphics(modeloutputpathandfilename,1,test_case,dtoutput)
CMM_graphics(modeloutputpathandfilename,3,test_case,dtoutput)
CMM_graphics(modeloutputpathandfilename,5,test_case,dtoutput)
CMM_graphics(modeloutputpathandfilename,6,test_case,dtoutput)
CMM_graphics(modeloutputpathandfilename,7,test_case,dtoutput)
CMM_graphics(modeloutputpathandfilename,8,test_case,dtoutput)

##
title_in = 'Perturbation Potential Temperature (K) at t = '
title_in = 'Pressure Perturbation (Pa) at t = '
title_in = 'W-wind (m/s) at t ='
title_in = 'U-wind (m/s) at t = '
title_in = 'Water Vapor Mixing Ratio (kg/kg) at t = '
title_in = 'Cloud Water Mixing Ratio (kg/kg) at t = '
title_in = 'Rain Water Mixing Ratio (kg/kg) at t = '

b_mat = [900 2400 3600];
for b=1:3
var_input = 'qrain'
test_case = 'test21'
modeloutputpathandfilename = [test_case '.mat']
n = b_mat(b)
CMM_graphics_v3(modeloutputpathandfilename,title_in,var_input,test_case,n)
end


clear
load test15.mat
x_interval = dx/1000;
x_end = (dx/1000)*(nx-1);
y_begin = dz/2000;
y_interval = dz/1000;
y_end = (dz*nz/1000)-(dz/2000);
x=0.0:x_interval:x_end;
y=y_begin:y_interval:y_end;
u_qv = fliplr(rot90(u_3600,3));
w_qv = fliplr(rot90(w_3600,3));
th_tot=zeros(nx,nz);
for k = 1 : nz
    for i = 1 : nx

th_tot(i,k) = tb(k) + th_3600(i,k);
    end
end

for i=1:3:nx-3
        u_qv(:,i) = 0;
        u_qv(:,i+2) = 0;
        w_qv(:,i) = 0;
        w_qv(:,i+2) = 0;
end

for i=1:2:nz-2
        u_qv(i,:) = 0;
        u_qv(i+2,:) = 0;
        w_qv(i,:) = 0;
        w_qv(i+2,:) = 0;
end

mask=zeros(nx,nz);
mask(260:340,1:3) = 5000;
mask(270:330,4:7) = 5000;
mask(280:320,8:11) = 5000;
mask(290:310,12:14) = 5000;

f = figure('Visible','on');
  [C, h]= contourf(x,y,fliplr(rot90(pprt_3600,3)),[-500:5:500]);
  caxis([-500 500])
  colorbar
  hold on
  quiver(x,y,u_qv,w_qv,3,'k')
  [C2,h2] = contourf(x,y,fliplr(rot90(mask,3)),[0 5000]);
  ch = get(h2,'child');alpha(ch,.9);
  grid on
  xlabel('x (km)')
  ylabel('z (km)')
  clabel(C,h)
  title_str = ['Wind Vectors and Perturbation Pressure (Pa) at t = 3600 s'];
  title(title_str)
  hold off
  str_print= ['print ' '-dpng ' '-f  forpaper_pressureandwinds_case1_3600s.png'];
  eval(str_print);
  close






##
# ## Quiver Plots
# clear
# load kessler.mat
# x_interval = dx/1000;
# x_end = (dx/1000)*(nx-1);
# y_begin = dz/2000;
# y_interval = dz/1000;
# y_end = (dz*nz/1000)-(dz/2000);
# x=0.0:x_interval:x_end;
# y=y_begin:y_interval:y_end;
#
# u_qv = fliplr(rot90(alltimes_u(:,:,670),3));
# w_qv = fliplr(rot90(alltimes_w(:,:,670),3));
#
# for i=1:3:nx-3
#         u_qv(:,i) = 0;
#         u_qv(:,i+2) = 0;
#         w_qv(:,i) = 0;
#         w_qv(:,i+2) = 0;
# end
#
# for i=1:2:nz-2
#         u_qv(i,:) = 0;
#         u_qv(i+2,:) = 0;
#         w_qv(i,:) = 0;
#         w_qv(i+2,:) = 0;
# end
#
#
# f = figure('Visible','on');
#   [C, h]= contour(x,y,fliplr(rot90(alltimes_th(:,:,670),3)),[-10:.25:10]);
#   colorbar
#   hold on
#   quiver(x,y,u_qv,w_qv,3)
#   grid on
#   xlabel('x (km)')
#   ylabel('z (km)')
#   clabel(C,h)
#   title_str = ['Perturbation Potential Temperature (K) at t = 670 s'];
#   title(title_str)
#   hold off
#   str_print= ['print ' '-dpng ' '-f' ' ' ...
#   nametosave '_theta_0secs.png'];
#   eval(str_print);
#   close
#
#   ## Hovmoller Plots
#
#  for n = 1:1200
#    reorg(:,n) = alltimes_th(:,4,n);
#  end
#
#   figure
#   contour(xs/1000,t(1:1200),flipud(rot90(reorg)))
#   colorbar
#
#
# ## Filled Contour Plots
# clear
# load kessler_test.mat
# x_interval = dx/1000;
# x_end = (dx/1000)*(nx-1);
# y_begin = dz/2000;
# y_interval = dz/1000;
# y_end = (dz*nz/1000)-(dz/2000);
# x=0.0:x_interval:x_end;
# y=y_begin:y_interval:y_end;
#
# f = figure('Visible','on');
#   [C, h]= contourf(x,y,fliplr(rot90(alltimes_th(:,:,1500),3)),[-18:1:18]);
#   colorbar
#   grid on
#   xlabel('x (km)')
#   ylabel('z (km)')
#
#
#
# f = figure('Visible','on');
#   [C, h]= contourf(x,y,fliplr(rot90(alltimes_qrain(:,:,1200),3)),[0.0:.001:015]);
#   colorbar
#   grid on
#   xlabel('x (km)')
#   ylabel('z (km)')
#
#   clabel(C,h)
#   title_str = ['Perturbation Potential Temperature (K) at t = 670 s'];
#   title(title_str)
#
#   str_print= ['print ' '-dpng ' '-f' ' ' ...
#   nametosave '_theta_0secs.png'];
#   eval(str_print);
#   close
#
#
#   
