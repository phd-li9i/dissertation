clear all
close all

store = true;

if store
  graphics_toolkit("gnuplot")
end

logs_dir5 = strcat(pwd,'/tests/odom_test_5');
logs_dir6 = strcat(pwd,'/tests/odom_test_6');

alg_id = {'CSM', 'NDT', 'FMT'};
alg_id_txt = {'CSM', 'NDT', 'FSM'};


csm_confs = {
'1_1_0.200000_0.786000_0.050000_0.000000_0.000000_0.000000'
};

fmt_confs = {
'1_50_0.200000_0.786000_0.050000_0.000000_0.000000_0.000000',
};

ndt_confs = {
'1_1_0.200000_0.786000_0.050000_0.000000_0.000000_0.000000',
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




% PLOT -------------------------------------------------------------------------
colours = function_get_nine_colours();
colours = [colours(1,:); colours(2,:); colours(9,:)];

x0 = 0.06; y0 = 0.3;
x1 = 0.49; y1 = 0.3;
h = 0.48;
w = 0.48;
linewidth = 3;
fin5 = 110;
fin6 = 55;

c1 = 1;
c2 = 1;


for i=1:fin5

  figure(1, 'position', [1 1 350 350])
  subplot(1,2,1, 'position', [x0 y0 h w])
  plot(mx,my, 'color', 'k', 'linewidth', 4);
  hold on
  plot(trj5(1,1:c1), trj5(2,1:c1), 'color', 'k', 'linewidth', linewidth);
  plot(hat_trj_csm5(1,1:c1), hat_trj_csm5(2,1:c1), 'color', [colours(1,:)], 'linewidth', linewidth);
  plot(hat_trj_ndt5(1,1:c1), hat_trj_ndt5(2,1:c1), 'color', [colours(2,:)], 'linewidth', linewidth);
  plot(hat_trj_fmt5(1,1:c1), hat_trj_fmt5(2,1:c1), 'color', [colours(3,:)], 'linewidth', linewidth);
  set(gca, 'xtick', [-2 0 2 4 6])
  axis equal
  axis([-2.7 6.5 5.7 17])
  set(gca, "linewidth", 3)

  subplot(1,2,2, 'position', [x1 y1 h w])
  plot(mx,my, 'color', 'k', 'linewidth', 4);
  hold on
  plot(trj6(1,1:c2), trj6(2,1:c2), 'color', 'k', 'linewidth', linewidth);
  plot(hat_trj_csm6(1,1:c2), hat_trj_csm6(2,1:c2), 'color', [colours(1,:)], 'linewidth', linewidth);
  plot(hat_trj_ndt6(1,1:c2), hat_trj_ndt6(2,1:c2), 'color', [colours(2,:)], 'linewidth', linewidth);
  plot(hat_trj_fmt6(1,1:c2), hat_trj_fmt6(2,1:c2), 'color', [colours(3,:)], 'linewidth', linewidth);
  set(gca, 'xtick', [-2 0 2 4 6])
  axis equal
  axis([-2.7 6.5 5.7 17])
  set(gca(), 'ytick', [], 'yticklabel', [])
  set(gca, "linewidth", 3)

  c1 = c1 + 1;

  if rem(i,2) == 0
    c2 = c2 + 1;
  end

  if c1 > fin5
    c1 = fin5;
  end
  if c2 > fin6
    c2 = fin6;
  end



  if store
    img_file = strcat(pwd, '/imgs/odom_test_5_vs_6_sr_005_', num2str(i), '.eps');
    drawnow ("epslatex", img_file, '');
  end

end
