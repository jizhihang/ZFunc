function z_drawCircle(x,y,r,draw_color)
% hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit, yunit, 'linewidth',2,'color', draw_color);
% hold off