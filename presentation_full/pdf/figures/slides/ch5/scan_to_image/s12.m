clear all
close all

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

pose = [0,0,0];
tip = pose(1,1:2) + [cos(pose(1,3)) sin(pose(1,3))];
arrow = [pose(1,1:2) tip];

figure
plot(x1,y1, 'o', 'color', 'b')
hold on
h = drawArrow (arrow, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [h.body; h.wing(:)], 'b',1,1);
set(h.body, 'linewidth', 3);
set(h.wing, 'linewidth', 3);
axis equal
axis off

figure
plot(x2,y2, 'o', 'color', 'r')
hold on
h = drawArrow (arrow, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [h.body; h.wing(:)], 'r',1,1);
set(h.body, 'linewidth', 3);
set(h.wing, 'linewidth', 3);
axis equal
axis off

figure
plot(x1,y1, 'color', 'b')
axis equal
axis off

figure
plot(x2,y2, 'color', 'r')
axis equal
axis off
