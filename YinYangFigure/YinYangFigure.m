function YinYangFigure()

pad = 0.05;

% Figure window
gcf = figure(1);
set(gcf, 'Position', [100, 100, 1400, 600]);

% Resolution of grid (# of points in latitudinal direction)
np = 16;
halo = 1;

% Generate points on Yin grid
dlat = pi/2/np;
yinlatp = dlat*[0:np+2*halo]'-pi/4-dlat*halo;
yinlonp = dlat*[0:3*np+2*halo]'-3*pi/4-dlat*halo;

nlat = length(yinlatp);
nlon = length(yinlonp);

[yinlon, yinlat] = meshgrid(yinlonp, yinlatp);

yinx = cos(yinlat) .* cos(yinlon);
yiny = cos(yinlat) .* sin(yinlon);
yinz = sin(yinlat);

ax1 = axes('Position',[pad/3 pad-0.02 1/3-2/3*pad 1-2*pad], 'Visible', 'off');
annotation('textbox', [0.14 0.97 0 0], 'string', 'Yin', 'FontSize', 36);
draw3_cartesian_mesh(ax1, yinx, yiny, yinz, 'r');

% Generate points on Yang grid
yangx = -yinx;
yangy = yinz;
yangz = yiny;

ax2 = axes('Position',[0.3+pad/3 pad-0.02 1/3-2/3*pad 1-2*pad], 'Visible', 'off');
annotation('textbox', [0.44 0.97 0 0], 'string', 'Yang', 'FontSize', 36);
draw3_cartesian_mesh(ax2, yangx, yangy, yangz, 'b');

ax3 = axes('Position',[2/3+pad/3 pad-0.02 1/3-2/3*pad 1-2*pad], 'Visible', 'off');
annotation('textbox', [0.78 0.97 0 0], 'string', 'Yin-Yang', 'FontSize', 36)
draw3_cartesian_mesh(ax3, yinx, yiny, yinz, 'r');
draw3_cartesian_mesh(ax3, yangx, yangy, yangz, 'b');

end

% Draw a Cartesian mesh in 3D using the given x,y,z coordinates of mesh
% vertices.
function draw3_cartesian_mesh(ax,x,y,z,colorspec)

latp = size(x,1);
lonp = size(x,2);

axis(ax,[-1 1 -1 1 -1 1]);
view(ax,[-180 25]);
hold on;
for i=1:latp-1
for j=1:lonp-1
    fill3(ax,[x(i,j),x(i+1,j),x(i+1,j+1),x(i,j+1)], ...
          [y(i,j),y(i+1,j),y(i+1,j+1),y(i,j+1)], ...
          [z(i,j),z(i+1,j),z(i+1,j+1),z(i,j+1)],'w','EdgeColor',colorspec,'LineWidth',2);
end
end
plot3(ax,x(:,1),y(:,1),z(:,1),colorspec,'LineWidth',4);
plot3(ax,x(1,:),y(1,:),z(1,:),colorspec,'LineWidth',4);
plot3(ax,x(:,lonp),y(:,lonp),z(:,lonp),colorspec,'LineWidth',4);
plot3(ax,x(latp,:),y(latp,:),z(latp,:),colorspec,'LineWidth',4);
hold off;

end
