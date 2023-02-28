clear all;
close all;

% store figure?
store = true;
graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");

map;


h = figure;
set(h,'position',[1 1 250 250]);

x0 = 0.03;
y0 = 0.5;
x1 = 0.52;
y1 = 0.5;
x2 = 0.03;
y2 = 0.01;
x3 = 0.52;
y3 = 0.01;
h = 0.45;
w = 0.45;


% 2,: for real; 1,: for virtual
colours = [[1 0 0]; [0, 0.4470, 0.7410]];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scans_no_os;

subplot(2,2,1, 'position', [x0 y0 h w])
plot(mx,my, 'color', 'k', 'linewidth', 3);
axis equal
hold on;
scatter(rx,ry, 80, colours(2,:), '.');
scatter(vx,vy, 80, colours(1,:), '.');


for i=1:size(rx,2)
  line(gca,[rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linewidth', 2);
  line(gca,[vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linewidth', 2);
end


rc_zm = [4.57 4.67 7.76 7.86];
xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])


set(gca(),'ytick',[]);
set(gca(),'xtick',[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scans_incorrect_os;

subplot(2,2,2, 'position', [x1 y1 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 3);
axis equal
hold on;
scatter(vx,vy, 80, colours(1,:), '.');

for i=1:size(rx,2)
  if mod(i,4) == 1
    scatter(rx(i),ry(i), 80, colours(2,:), '.');
    line([rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linewidth', 2);
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linewidth', 2);
  else
    scatter(rx(i),ry(i), 80, colours(2,:), '.');
    line([rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linestyle', '--');
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linestyle', '-.');
  end
end

rc_zm = [4.57 4.67 7.76 7.86];
xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

rectangle ("Position", [rc_zm(1), rc_zm(3), (rc_zm(2)-rc_zm(1)), (rc_zm(4)-rc_zm(3))], "Curvature", [0.0, 0.0], "EdgeColor", 'g', 'linewidth',8);

set(gca,'xtick',[])
set(gca,'ytick',[])

if store
  img_file = strcat(pwd, '/false_oversampling_1.eps');
  drawnow ("epslatex", img_file, strcat(img_file,'.gp'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scans_no_os;

subplot(2,2,3, 'position', [x2 y2 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 3);
axis equal
hold on;
scatter(rx,ry, 80, colours(2,:), '.');
scatter(vx,vy, 80, colours(1,:), '.');

for i=1:size(rx,2)
  line([rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linewidth', 2);
  line([vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linewidth', 2);
end

rc_zm = [4.64 4.8 11.32 11.48];
xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

set(gca,'xtick',[])
set(gca,'ytick',[])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scans_incorrect_os;

subplot(2,2,4, 'position', [x3 y3 h w]);
plot(mx,my, 'color', 'k', 'linewidth', 3);
axis equal
hold on;
scatter(vx,vy, 80, colours(1,:), '.');

for i=1:size(rx,2)
  if mod(i,4) == 1
    scatter(rx(i),ry(i), 80, colours(2,:), '.');
    line([rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linewidth', 2);
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linewidth', 2);
  else
    scatter(rx(i),ry(i), 80, colours(2,:), '.');
    line([rx(i) r00(1)], [ry(i) r00(2)], 'color', colours(2,:), 'linestyle', '--');
    line([vx(i) v00(1)], [vy(i) v00(2)], 'color', colours(1,:), 'linestyle', '-.');
  end
end

rc_zm = [4.64 4.8 11.32 11.48];
xlim([rc_zm(1) rc_zm(2)])
ylim([rc_zm(3) rc_zm(4)])

rectangle ("Position", [rc_zm(1), rc_zm(3), (rc_zm(2)-rc_zm(1)), (rc_zm(4)-rc_zm(3))], "Curvature", [0.0, 0.0], "EdgeColor", colours(2,:), 'linewidth',8);

set(gca,'xtick',[])
set(gca,'ytick',[])

if store
  img_file = strcat(pwd, '/false_oversampling_2.eps');
  drawnow ("epslatex", img_file, strcat(img_file,'.gp'));
end
