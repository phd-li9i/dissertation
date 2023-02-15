close all
clear all
pkg load io
pkg load geometry

print_dir = strcat(pwd, '/s12_rot_and_trans/');

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

R = [x1;y1];

tr = -43.6660856562*pi/180;

M = [cos(tr), -sin(tr); sin(tr), cos(tr)];

V = [x2;y2];
V_ = M*V;


% Now turn to the map's frame
t = -101*pi/180;
M = [cos(t), -sin(t); sin(t), cos(t)];
R = M * R;
V_ = M * V_;





[xc_r,yc_r] = centroid(R(1,:),R(2,:))
[xc_v,yc_v] = centroid(V_(1,:),V_(2,:))

t_map = t;
pr = [-0.18, 0.09537, t_map]
pv = [pr(1)-(xc_r-xc_v), pr(2)-(yc_r-yc_v), t_map]




figure(1)
hold on
plot(R(1,:), R(2,:), 'o', 'color','b')
plot(V_(1,:), V_(2,:), 'o', 'color', 'r')
tipr = pr(1,1:2) + [cos(pr(1,3)) sin(pr(1,3))];
arrowr = [pr(1,1:2) tipr];
tipv = pv(1,1:2) + [cos(pv(1,3)) sin(pv(1,3))];
arrowv = [pv(1,1:2) tipv];
hv = drawArrow (arrowv, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hv.body; hv.wing(:)], 'r',1,1);
set(hv.body, 'linewidth', 3);
set(hv.wing, 'linewidth', 3);
hr = drawArrow (arrowr, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hr.body; hr.wing(:)], 'b',1,1);
set(hr.body, 'linewidth', 3);
set(hr.wing, 'linewidth', 3);
axis equal
axis off

img_file = strcat(print_dir, 'both_1.png');
print(img_file);

figure(1+20)
hold on
plot(V_(1,:), V_(2,:),  'o', 'color', 'r')
axis equal
axis off

img_file = strcat(print_dir, 'sv_1.png');
print(img_file);




V__ = V_;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V__ = V__+ [xc_r-xc_v;yc_r-yc_v];
pr = [-0.18, 0.09537, t_map]
pv = [pr(1)-(xc_r-xc_v), pr(2)-(yc_r-yc_v), t_map]
figure(2)
hold on
plot(R(1,:), R(2,:),  'o', 'color','b')
plot(V__(1,:), V__(2,:),  'o', 'color','r')
tipr = pr(1,1:2) + [cos(pr(1,3)) sin(pr(1,3))];
arrowr = [pr(1,1:2) tipr];
tipv = pv(1,1:2) + [cos(pv(1,3)) sin(pv(1,3))];
arrowv = [pv(1,1:2) tipv];
hv = drawArrow (arrowv, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hv.body; hv.wing(:)], 'r',1,1);
set(hv.body, 'linewidth', 3);
set(hv.wing, 'linewidth', 3);
hr = drawArrow (arrowr, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [hr.body; hr.wing(:)], 'b',1,1);
set(hr.body, 'linewidth', 3);
set(hr.wing, 'linewidth', 3);
axis equal
axis off

img_file = strcat(print_dir, 'both_2.png');
print(img_file);

figure(2+20)
hold on
plot(V__(1,:), V__(2,:),  'o', 'color', 'r')
axis equal
axis off

img_file = strcat(print_dir, 'sv_2.png');
print(img_file);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=3:13
  [xc_r,yc_r] = centroid(R(1,:),R(2,:));
  [xc_v,yc_v] = centroid(V__(1,:),V__(2,:));
  V__ = (R+V__)./2;



  figure(i)
  hold on
  plot(R(1,:), R(2,:),  'o', 'color','b')
  plot(V__(1,:), V__(2,:),  'o', 'color', 'r')
  tipr = pr(1,1:2) + [cos(pr(1,3)) sin(pr(1,3))];
  arrowr = [pr(1,1:2) tipr];
  tipv = pv(1,1:2) + [cos(pv(1,3)) sin(pv(1,3))];
  arrowv = [pv(1,1:2) tipv];
  hr = drawArrow (arrowr, 1, 0.5 , 0.1);
  arrayfun(@(x,y)set(x,'color',y), [hr.body; hr.wing(:)], 'b',1,1);
  set(hr.body, 'linewidth', 3);
  set(hr.wing, 'linewidth', 3);
  hv = drawArrow (arrowv, 1, 0.5 , 0.1);
  arrayfun(@(x,y)set(x,'color',y), [hv.body; hv.wing(:)], 'r',1,1);
  set(hv.body, 'linewidth', 3);
  set(hv.wing, 'linewidth', 3);
  axis equal
  axis off

  img_file = strcat(print_dir, strcat('both_', num2str(i), '.png'));
  print(img_file);


  figure(i+20)
  hold on
  plot(V__(1,:), V__(2,:),  'o', 'color', 'r')
  axis equal
  axis off

  img_file = strcat(print_dir, strcat('sv_', num2str(i), '.png'));
  print(img_file);


  pr = [-0.18, 0.09537, t_map]
  pv = [pr(1)-(xc_r-xc_v), pr(2)-(yc_r-yc_v), t_map]

  V__ = V__ + [xc_r-xc_v;yc_r-yc_v];
end

