close all
clear all
pkg load io
pkg load geometry

s1;
s2;

t = -pi:2*pi/(numel(s1)-1):pi;

x1 = [];
x2 = [];
y1 = [];
y2 = [];

for i=1:numel(s1)
  x1 = [x1, s1(i)*cos(t(i))];
  y1 = [y1, s1(i)*sin(t(i))];
end

for i=1:numel(s2)
  x2 = [x2, s2(i)*cos(t(i))];
  y2 = [y2, s2(i)*sin(t(i))];
end

t = -43.6660856562*pi/180;

R = [cos(t), -sin(t); sin(t), cos(t)];

V = [x2;y2];
V_ = R*V;

figure
hold on
plot(x1,y1,'b')
plot(V_(1,:), V_(2,:), 'r')
axis equal
axis off

figure
hold on
plot(x1,y1,'o', 'color', 'b')
plot(V_(1,:), V_(2,:), 'o', 'color', 'r')

pose = [0,0,0];
tip = pose(1,1:2) + [cos(pose(1,3)) sin(pose(1,3))];
arrow = [pose(1,1:2) tip];

hr = drawArrow (arrow, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hr.body; hr.wing(:)], 'b',1,1);
set(hr.body, 'linewidth', 3);
set(hr.wing, 'linewidth', 3);

[xc_r,yc_r] = centroid(x1,y1);
[xc_v,yc_v] = centroid(V_(1,:),V_(2,:));

% approx
dy = xc_v-xc_r;
dx = yc_v-yc_r;


pose = [dx,dy-0.05,0];
tip = pose(1,1:2) + [cos(pose(1,3)) sin(pose(1,3))];
arrow = [pose(1,1:2) tip];

hr = drawArrow (arrow, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hr.body; hr.wing(:)], 'r',1,1);
set(hr.body, 'linewidth', 3);
set(hr.wing, 'linewidth', 3);

axis equal
axis off
