close all
clear all

store = false;

if store
  graphics_toolkit("gnuplot")
end

logs_dir5 = strcat(pwd,'/tests/odom_test_5');
logs_dir6 = strcat(pwd,'/tests/odom_test_6');

alg_id = {'CSM', 'NDT', 'FMT'};
alg_id_txt = {'CSM', 'NDT', 'FSM'};


csm_confs = {
'1_1_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000'
};

fmt_confs = {
'1_50_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000',
};

ndt_confs = {
'1_1_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000',
};


metrics_dirs = {'errors/pose_errors.txt',
'errors/orientation_errors.txt',
'errors/position_errors.txt',
};

load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{3}));
pose_errors_csm5 = pose_errors';
position_errors_csm5 = position_errors';
orientation_errors_csm5 = orientation_errors';

load(strcat(logs_dir5, '/NDT/', ndt_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir5, '/NDT/', ndt_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir5, '/NDT/', ndt_confs{1}, '/', metrics_dirs{3}));
pose_errors_ndt5 = pose_errors';
position_errors_ndt5 = position_errors';
orientation_errors_ndt5 = orientation_errors';

load(strcat(logs_dir5, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir5, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir5, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{3}));
pose_errors_fmt5 = pose_errors';
position_errors_fmt5 = position_errors';
orientation_errors_fmt5 = orientation_errors';


load(strcat(logs_dir6, '/CSM/', csm_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir6, '/CSM/', csm_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir6, '/CSM/', csm_confs{1}, '/', metrics_dirs{3}));
pose_errors_csm6 = pose_errors';
position_errors_csm6 = position_errors';
orientation_errors_csm6 = orientation_errors';

load(strcat(logs_dir6, '/NDT/', ndt_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir6, '/NDT/', ndt_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir6, '/NDT/', ndt_confs{1}, '/', metrics_dirs{3}));
pose_errors_ndt6 = pose_errors';
position_errors_ndt6 = position_errors';
orientation_errors_ndt6 = orientation_errors';

load(strcat(logs_dir6, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir6, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir6, '/ni=2/FMT/', fmt_confs{1}, '/', metrics_dirs{3}));
pose_errors_fmt6 = pose_errors';
position_errors_fmt6 = position_errors';
orientation_errors_fmt6 = orientation_errors';






% Get the map
map;
mx = [mx,mx(1)];
my = [my,my(2)];

% Get actual robot trajectory for odom_test_5
run(strcat(logs_dir5, '/generate_poses_for_odom_test.m'));
trj5 = trj;

trj_errors_csm5 = [position_errors_csm5; orientation_errors_csm5];
trj_errors_ndt5 = [position_errors_ndt5; orientation_errors_ndt5];
trj_errors_fmt5 = [position_errors_fmt5; orientation_errors_fmt5];


% Position estimates
% Accumulate the position errors first; then add them to the trajectory
cumm_trj_errors_csm5 = cumsum(trj_errors_csm5,2);
cumm_trj_errors_ndt5 = cumsum(trj_errors_ndt5,2);
cumm_trj_errors_fmt5 = cumsum(trj_errors_fmt5,2);

cumm_trj_errors_csm5 = [[0;0;0], cumm_trj_errors_csm5];
cumm_trj_errors_ndt5 = [[0;0;0], cumm_trj_errors_ndt5];
cumm_trj_errors_fmt5 = [[0;0;0], cumm_trj_errors_fmt5];

hat_trj_csm5 = trj5 + cumm_trj_errors_csm5;
hat_trj_ndt5 = trj5 + cumm_trj_errors_ndt5;
hat_trj_fmt5 = trj5 + cumm_trj_errors_fmt5;

% Get actual robot trajectory for odom_test_6
run(strcat(logs_dir6, '/generate_poses_for_odom_test'));
trj6 = trj;

trj_errors_csm6 = [position_errors_csm6; orientation_errors_csm6];
trj_errors_ndt6 = [position_errors_ndt6; orientation_errors_ndt6];
trj_errors_fmt6 = [position_errors_fmt6; orientation_errors_fmt6];


% Position estimates
% Accumulate the position errors first; then add them to the trajectory
cumm_trj_errors_csm6 = cumsum(trj_errors_csm6,2);
cumm_trj_errors_ndt6 = cumsum(trj_errors_ndt6,2);
cumm_trj_errors_fmt6 = cumsum(trj_errors_fmt6,2);

cumm_trj_errors_csm6 = [[0;0;0], cumm_trj_errors_csm6];
cumm_trj_errors_ndt6 = [[0;0;0], cumm_trj_errors_ndt6];
cumm_trj_errors_fmt6 = [[0;0;0], cumm_trj_errors_fmt6];

hat_trj_csm6 = trj6 + cumm_trj_errors_csm6;
hat_trj_ndt6 = trj6 + cumm_trj_errors_ndt6;
hat_trj_fmt6 = trj6 + cumm_trj_errors_fmt6;


% Break down scans
% ... load them first
load(strcat(logs_dir5, '/ni=2/conf_5_scans.txt'));
load(strcat(logs_dir6, '/ni=2/conf_6_scans.txt'));

S5 = reshape(conf_5_scans, 360, 120)';
S6 = reshape(conf_6_scans, 360, 59)';


x5 = {};
y5 = {};
for i=1:size(S5,1)
  [a,b] = function_project(S5(i,:), hat_trj_fmt5(:,i));
  x5 = [x5, a];
  y5 = [y5, b];
end

x6 = {};
y6 = {};
for i=1:size(S6,1)
  [a,b] = function_project(S6(i,:), hat_trj_fmt6(:,i));
  x6 = [x6, a];
  y6 = [y6, b];
end

x = {};
y = {};
for i=1:size(S6,1)
  [a,b] = function_project(S6(i,:), trj6(:,i));
  x = [x, a];
  y = [y, b];
end




% PLOT -------------------------------------------------------------------------
colours = function_get_nine_colours();
colours = [colours(1,:); colours(2,:); colours(9,:)];

figure(1)
hold on
for i=1:size(S5,1)

  plot(x5{i},y5{i}, '.', 'color', 'b')
  plot(hat_trj_fmt5(1,1:i), hat_trj_fmt5(2,1:i))


  if store
    img_file = strcat(pwd, '/imgs/odom_test_5_vs_6_sr_000_scans_', num2str(i), '.eps');
    drawnow ("epslatex", img_file, '');
  end
end
axis equal

figure(2)
hold on
for i=1:size(S6,1)

  plot(x6{i},y6{i}, '.', 'color', 'b')
  plot(hat_trj_fmt6(1,1:i), hat_trj_fmt6(2,1:i))


  if store
    img_file = strcat(pwd, '/imgs/odom_test_5_vs_6_sr_000_scans_', num2str(i), '.eps');
    drawnow ("epslatex", img_file, '');
  end
end
axis equal

figure(3)
hold on
for i=1:size(S6,1)

  plot(x{i},y{i}, '.', 'color', 'b')
  plot(trj6(1,1:i), trj6(2,1:i))


  if store
    img_file = strcat(pwd, '/imgs/odom_test_5_vs_6_sr_000_scans_', num2str(i), '.eps');
    drawnow ("epslatex", img_file, '');
  end
end
axis equal
