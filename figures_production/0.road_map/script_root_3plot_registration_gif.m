clear all
close all

store = false;

graphics_toolkit("gnuplot")

logs_dir5 = '/media/li9i/elements/PhD/Articles/07.fsm_paper/presentation-video (without asymeon)/figures_production/odom_test/logs_bak/';
print_dir = '/media/li9i/elements/PhD/dissertation/figures_production/0.road_map/';

alg_id = {'CSM', 'NDT', 'FMT'};
alg_id_txt = {'CSM', 'NDT', 'FSM'};


fmt_confs = {
'1_20_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000',
};



metrics_dirs = {'errors/pose_errors.txt',
'errors/orientation_errors.txt',
'errors/position_errors.txt',
'scans/scan_'
};


% Load pose, position, and orientation errors
load(strcat(logs_dir5, '/FMT/', fmt_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir5, '/FMT/', fmt_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir5, '/FMT/', fmt_confs{1}, '/', metrics_dirs{3}));
pose_errors_fmt5 = pose_errors';
position_errors_fmt5 = position_errors';
orientation_errors_fmt5 = orientation_errors';

% Load the scans for visualisation
rs_x = [];
rs_y = [];
vs_x = [];
vs_y = [];
for i=0:size(pose_errors,1)-1
  run(strcat(logs_dir5, 'FMT/', fmt_confs{1}, '/', metrics_dirs{4}, num2str(i), '.m'));
  rs_x = [rs_x; rx];
  rs_y = [rs_y; ry];
  vs_x = [vs_x; vx];
  vs_y = [vs_y; vy];
end


generate_poses_for_odom_test;



% Get the 44-th scan-matching's scans, which are in xy coords
s = 44;
s0_xy = [vs_x(s,:)-x(s); vs_y(s,:)-y(s)];
s1_xy = [rs_x(s,:)-x(s+1); rs_y(s,:)-y(s+1)];

% Make range scans from these
s0 = norm(s0_xy, 2, 'cols');
s1 = norm(s1_xy, 2, 'cols');

s0_xy_ = [];
s1_xy_ = [];
for i=1:size(s0,2)
  xx = s0(i) * cos(2*pi*(i-1)/size(s0,2) -pi);
  yy = s0(i) * sin(2*pi*(i-1)/size(s0,2) -pi);

  s0_xy_ = [s0_xy_, [xx;yy]];

  xx = s1(i) * cos(2*pi*(i-1)/size(s1,2) -pi);
  yy = s1(i) * sin(2*pi*(i-1)/size(s1,2) -pi);

  s1_xy_ = [s1_xy_, [xx;yy]];
end

s0_xy_ = [s0_xy_, s0_xy_(:,1)];
s1_xy_ = [s1_xy_, s1_xy_(:,1)];

colours = [55,126,184; 228,26,28]/255;

figure(1, 'position', [0.1 0.1 250 250])
hold on
plot(s0_xy_(1,:), s0_xy_(2,:), 'color', [colours(1,:)])
scatter(s0_xy_(1,:), s0_xy_(2,:), 40, [colours(1,:)], 'filled')
plot(s1_xy_(1,:), s1_xy_(2,:), 'color', [colours(2,:)])
scatter(s1_xy_(1,:), s1_xy_(2,:), 40, [colours(2,:)], 'filled')
%set(gca, 'xtick', [], 'xticklabel', [])
%set(gca, 'ytick', [], 'yticklabel', [])
%box off
axis equal
grid


% Show the 44-th scan-matching
s = 44;

T = [position_errors_fmt5(:,s);orientation_errors_fmt5(s)];

M0 = [cos(t(s)) -sin(t(s)) x(s); ...
      sin(t(s)) +cos(t(s)) y(s); ...
      0       0        1];

M1 = [cos(t(s+1)+T(3)) -sin(t(s+1)+T(3)) x(s+1)+T(1); ...
      sin(t(s+1)+T(3)) +cos(t(s+1)+T(3)) y(s+1)+T(2); ...
      0       0        1];


ss0 = [s0_xy_; ones(1,size(s0_xy_,2))];
ss1 = [s1_xy_; ones(1,size(s1_xy_,2))];
ss0_ = ss0;
ss1_ = inv(M0) * M1 * ss1;


figure(6, 'position', [0.1 0.1 250 250])
hold on
plot(ss0_(1,:), ss0_(2,:), 'color', [colours(1,:)])
scatter(ss0_(1,:), ss0_(2,:), 40, [colours(1,:)], 'filled')
plot(ss1_(1,:), ss1_(2,:), 'color', [colours(2,:)])
scatter(ss1_(1,:), ss1_(2,:), 40, [colours(2,:)], 'filled')
%set(gca, 'xtick', [], 'xticklabel', [])
%set(gca, 'ytick', [], 'yticklabel', [])
%box off
axis equal
grid


a = [s0_xy_(1,:)', s0_xy_(2,:)', s1_xy_(1,:)', s1_xy_(2,:)', ss1_(1,:)', ss1_(2,:)'];

csvwrite (strcat(print_dir,'reg_scans.csv'), a);
