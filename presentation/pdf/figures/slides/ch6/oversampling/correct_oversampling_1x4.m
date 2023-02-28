clear all;
close all;

% store figures?
store = true;
graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");

map;
scans_correct_os;

rc_zm = [4.62 4.82 11.30 11.50];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Zoom in on a non-linear segment and show that detail
%% Overscan 4 times ONLY THE map and show both the original real scan (as should
%% be) and the virtual scan. In the case of non-linear surfaces all is well
%% when overscanning the map and leaving the real scan as is.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ry = ry(309:311);
rx = rx(309:311);

vx = vx(1104:1112);
vy = vy(1104:1112);

% Custom colours
GY = [0.8,0.8,0.8];
GR = [0.4660, 0.7740, 0.2880];
OR = [0.6500, 0.3250, 0.1980];
PU = [0.4940, 0.1840, 0.5560];
BL1 = [1 0 0];
BL2 = [0.95 0 0];
BL3 = [0.9 0 0];
BL4 = [0.85 0 0];


%h = figure;
%set(h,'position',[1 1 250 250]);

x0 = 0.03; y0 = 0.5;
x1 = 0.52; y1 = 0.5;
x2 = 0.03; y2 = 0.01;
x3 = 0.52; y3 = 0.01;
h = 0.45;
w = 0.45;

ex = 0.005;
ey = 0.0;

colours = [[0, 0.4470, 0.7410]; [1,0,0]];


h = figure;
set(h,'position',[1 1 125 125]);
%subplot(2,2,1, 'position', [x0 y0 h w])
plot(mx,my, 'color', 'k', 'linewidth', 4);
axis equal
hold on;
scatter(rx,ry, 80, colours(1,:), '.');
scatter(vx,vy, 80, colours(2,:), '.');


rl1 = line(gca,[rx(1) r00(1)], [ry(1) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl2 = line(gca,[rx(2) r00(1)], [ry(2) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl3 = line(gca,[rx(3) r00(1)], [ry(3) r00(2)], 'color', colours(1,:), 'linewidth', 3);

for i=1:size(vx,2)
  if mod(i,4) != 2
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', GY, 'linestyle', '-', 'linewidth', 2);
    scatter(vx(i),vy(i), 80, GY, '.'); % purple
  end
end

bl1 = line([vx(2) v00(1)], [vy(2) v00(2)], 'color', BL1, 'linestyle', '-', 'linewidth', 3);
scatter(vx(2),vy(2), 80, BL1, '.'); % blue
bl2 = line([vx(6) v00(1)], [vy(6) v00(2)], 'color', BL1, 'linestyle', '-', 'linewidth', 3);
scatter(vx(6),vy(6), 80, BL1, '.'); % blue

text(vx(2)+0.015, vy(2), 'PD$_0 = 0.96$', 'color', BL1);

xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

set(gca(),'ytick',[]);
set(gca(),'xtick',[]);

%lg = legend([rl1 bl1], '$\mathcal{S}_R$', '$\mathcal{S}_V^0(\hat{\theta}+0\frac{\gamma}{2^2})$');
%legend boxoff
%set(lg, 'fontsize', 13);

if store
  img_file = strcat(pwd, '/correct_oversampling_1.eps');
  drawnow ("epslatex", img_file, '');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = figure;
set(h,'position',[1 1 125 125]);
%subplot(2,2,2, 'position', [x1 y1 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 4);
axis equal
hold on;
scatter(rx,ry, 80, colours(1,:), '.');
scatter(vx,vy, 80, colours(2,:), '.');


rl1 = line(gca,[rx(1) r00(1)], [ry(1) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl2 = line(gca,[rx(2) r00(1)], [ry(2) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl3 = line(gca,[rx(3) r00(1)], [ry(3) r00(2)], 'color', colours(1,:), 'linewidth', 3);


for i=1:size(vx,2)
  if mod(i,4) ~=3
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', GY, 'linestyle', '-', 'linewidth', 2);
    scatter(vx(i),vy(i), 80, GY, '.'); % blue
  end
end


ol1 = line([vx(3) v00(1)], [vy(3) v00(2)], 'color', BL2, 'linestyle', '-', 'linewidth', 3);
scatter(vx(3),vy(3), 80, BL2, '.'); % orange
ol2 = line([vx(7) v00(1)], [vy(7) v00(2)], 'color', BL2, 'linestyle', '-', 'linewidth', 3);
scatter(vx(7),vy(7), 80, BL2, '.'); % orange


%lg = legend([rl1 ol1], '$\mathcal{S}_R$', '$\mathcal{S}_V^1(\hat{\theta}+1\frac{\gamma}{2^2})$');
%legend boxoff
%set(lg, 'fontsize', 13);

text(vx(2)+0.015, vy(2), 'PD$_1 = 0.90$', 'color', BL2);


xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

set(gca,'xtick',[])
set(gca,'ytick',[])

if store
  img_file = strcat(pwd, '/correct_oversampling_2.eps');
  drawnow ("epslatex", img_file, '');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = figure;
set(h,'position',[1 1 125 125]);
%subplot(2,2,3, 'position', [x2 y2 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 4);
axis equal
hold on;
scatter(rx,ry, 80, colours(1,:), '.');
scatter(vx,vy, 80, colours(2,:), '.');


rl1 = line(gca,[rx(1) r00(1)], [ry(1) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl2 = line(gca,[rx(2) r00(1)], [ry(2) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl3 = line(gca,[rx(3) r00(1)], [ry(3) r00(2)], 'color', colours(1,:), 'linewidth', 3);


for i=1:size(vx,2)
  if mod(i,4) ~= 0
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', GY, 'linestyle', '-', 'linewidth', 2);
    scatter(vx(i),vy(i), 80, GY, '.'); % blue
  end
end


gl1 = line([vx(4) v00(1)], [vy(4) v00(2)], 'color', BL3, 'linestyle', '-', 'linewidth', 3);
scatter(vx(4),vy(4), 80, BL3, '.'); % green
gl2 = line([vx(8) v00(1)], [vy(8) v00(2)], 'color', BL3, 'linestyle', '-', 'linewidth', 3);
scatter(vx(8),vy(8), 80, BL3, '.'); % green

%lg = legend([rl1 gl1], '$\mathcal{S}_R$', '$\mathcal{S}_V^2(\hat{\theta}+2\frac{\gamma}{2^2})$');
%legend boxoff
%set(lg, 'fontsize', 13);

text(vx(2)+0.015, vy(2), 'PD$_2 = 0.92$', 'color', BL3);

xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

set(gca,'xtick',[])
set(gca,'ytick',[])

if store
  img_file = strcat(pwd, '/correct_oversampling_3.eps');
  drawnow ("epslatex", img_file, '');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = figure;
set(h,'position',[1 1 125 125]);
%subplot(2,2,4, 'position', [x3 y3 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 4);
axis equal
hold on;
scatter(rx,ry, 80, colours(1,:), '.');
scatter(vx,vy, 80, colours(2,:), '.');


rl1 = line(gca,[rx(1) r00(1)], [ry(1) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl2 = line(gca,[rx(2) r00(1)], [ry(2) r00(2)], 'color', colours(1,:), 'linewidth', 3);
rl3 = line(gca,[rx(3) r00(1)], [ry(3) r00(2)], 'color', colours(1,:), 'linewidth', 3);


for i=1:size(vx,2)
  if mod(i,4) ~= 1
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', GY, 'linestyle', '-', 'linewidth', 2);
    scatter(vx(i),vy(i), 80, GY, '.'); % blue
  end
end


pl1 = line([vx(1) v00(1)], [vy(1) v00(2)], 'color', BL4, 'linestyle', '-', 'linewidth', 3);
scatter(vx(1),vy(1), 80, BL4, '.'); % purple
pl2 = line([vx(5) v00(1)], [vy(5) v00(2)], 'color', BL4, 'linestyle', '-', 'linewidth', 3);
scatter(vx(5),vy(5), 80, BL4, '.'); % purple
pl3 = line([vx(9) v00(1)], [vy(9) v00(2)], 'color', BL4, 'linestyle', '-', 'linewidth', 3);
scatter(vx(9),vy(9), 80, BL4, '.'); % purple

%lg = legend([rl1 pl1], '$\mathcal{S}_R$', '$\mathcal{S}_V^3(\hat{\theta}+3\frac{\gamma}{2^2})$');
%legend boxoff
%set(lg, 'fontsize', 13);

text(vx(2)+0.015, vy(2), 'PD$_3 = 0.99$', 'color', BL4);

xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])


set(gca,'xtick',[])
set(gca,'ytick',[])




if store
  img_file = strcat(pwd, '/correct_oversampling_4.eps');
  drawnow ("epslatex", img_file, '');
end
