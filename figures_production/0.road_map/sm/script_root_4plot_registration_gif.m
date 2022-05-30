clear all
close all

store = true;

graphics_toolkit("gnuplot")

logs_dir5 = '/media/li9i/var/elements/PhD/Articles/07.fsm_paper/fsm_paper_icra_X/presentation-video/figures_production/odom_test/logs_bak/';
scripts_dir = '/media/li9i/var/elements/PhD/dissertation/figures_production/0.road_map/sm';
print_dir = '/media/li9i/var/elements/PhD/dissertation/figures_production/0.road_map/sm/pngs/';

alg_id = {'CSM', 'NDT', 'FMT'};
alg_id_txt = {'CSM', 'NDT', 'FSM'};


fmt_confs = {
'1_20_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000',
};

csm_confs = {
'1_1_0.200000_0.786000_0.000000_0.000000_0.000000_0.000000',
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

% Load pose, position, and orientation errors
load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{1}));
load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{2}));
load(strcat(logs_dir5, '/CSM/', csm_confs{1}, '/', metrics_dirs{3}));
pose_errors_csm5 = pose_errors';
position_errors_csm5 = position_errors';
orientation_errors_csm5 = orientation_errors';


% Get the map
map;
mx = [mx,mx(1)];
my = [my,my(2)];

% Get actual robot trajectory for odom_test_5
run(strcat(scripts_dir, '/generate_poses_for_odom_test.m'));
trj5 = trj;

trj_errors_fmt5 = [position_errors_fmt5; orientation_errors_fmt5];
trj_errors_csm5 = [position_errors_csm5; orientation_errors_csm5];


% Position estimates
% Accumulate the position errors first; then add them to the trajectory
cumm_trj_errors_fmt5 = cumsum(trj_errors_fmt5,2);
cumm_trj_errors_fmt5 = [[0;0;0], cumm_trj_errors_fmt5];
hat_trj_fmt5 = trj5 + cumm_trj_errors_fmt5;

cumm_trj_errors_csm5 = cumsum(trj_errors_csm5,2);
cumm_trj_errors_csm5 = [[0;0;0], cumm_trj_errors_csm5];
hat_trj_csm5 = trj5 + cumm_trj_errors_csm5;


trj_diff = diff(trj,1,2);

% wrap angle
trj_diff(3,:) = rem(trj_diff(3,:)+5*pi, 2*pi) - pi;

trj_d = [[0;0;0], cumsum(abs(trj_diff),2)];

if ~store
  return;
end


% PLOT -------------------------------------------------------------------------
%colours = [228,26,28; 55,126,184; 77,175,74]/255;
colours = [208,2,27; 31,119,180; 185,185,185]/255;
w = 500;
h = 500;

% fmt
cs_x_fmt5 = cumsum(abs(position_errors_fmt5(1,:)));
cs_y_fmt5 = cumsum(abs(position_errors_fmt5(2,:)));

o_fmt5 = abs(orientation_errors_fmt5);
cs_o_fmt5 = cumsum(o_fmt5);

cs_x_fmt5 = [[0], cs_x_fmt5];
cs_y_fmt5 = [[0], cs_y_fmt5];
cs_o_fmt5 = [[0], cs_o_fmt5];


% csm
cs_x_csm5 = cumsum(abs(position_errors_csm5(1,:)));
cs_y_csm5 = cumsum(abs(position_errors_csm5(2,:)));

o_csm5 = abs(orientation_errors_csm5);
cs_o_csm5 = cumsum(o_csm5);

cs_x_csm5 = [[0], cs_x_csm5];
cs_y_csm5 = [[0], cs_y_csm5];
cs_o_csm5 = [[0], cs_o_csm5];


arr = 0.25;


f = figure(1, 'position', [1 1 w h]);

plot(mx,my, 'color', 'k', 'linewidth', 10);
hold on

% Plot trajectory
plot(trj5(1,1:end), trj5(2,1:end), 'color', 'k', 'linewidth', 5);
plot(hat_trj_csm5(1,1:end), hat_trj_csm5(2,1:end), 'color', [colours(3,:)], 'linewidth', 5);
%scatter(hat_trj_csm5(1,1:end), hat_trj_csm5(2,1:end), 40, [colours(4,:)], 'filled');
scatter(4.363912, 8.0715, 140, [colours(2,:)], 'filled');
scatter(4.705145, 8.1518, 140, [colours(1,:)], 'filled');

set(gca, 'xtick', [-2 0 2 4 6], 'xticklabel', {'$-2.0$', '$0.0$','$2.0$','$4.0$','$6.0$'});
set(gca, 'ytick', [6 8 10 12 14 16], 'yticklabel', {'$6.0$', '$8.0$','$10.0$','$12.0$','$14.0$','$16.0$'});
axis equal
axis([-2.7 6.5 5.7 17])

ids = my >= +5.7 & my <= 17;
my_ = my(ids);
mx_ = mx(ids);

a = [mx_', my_',[trj5(1,1:end)'; repmat(trj5(1,end)',54,1)], ...
             [trj5(2,1:end)'; repmat(trj5(2,end)',54,1)], ...
             [hat_trj_csm5(1,1:end)'; repmat(hat_trj_csm5(1,end)',54,1)], ...
             [hat_trj_csm5(2,1:end)'; repmat(hat_trj_csm5(2,end)',54,1)], ...
             repmat([4.183260, 8.0715], 175,1), ...
             repmat([4.544565, 8.0916], 175,1)];

csvwrite (strcat(print_dir,'sm2.csv'), a);



% PRINT TO .png WITH LATEX IN IT
% http://wiki.octave.org/Printing_with_FLTK

if (store)
  cd pngs

  img_file_base = strcat(print_dir, 'img_end');
  img_file = strcat(img_file_base, '.tex');
  print (img_file, '-depslatexstandalone');

  %## process generated files with pdflatex
  % how to insert space in concatenation of strings (without strcat)
  %https://www.mathworks.com/matlabcentral/answers/251996-how-to-insert-space-between-strings-while-doing-strcat
  inst1 = sprintf('%s %s', 'latex', img_file);
  system (inst1);

  %## dvi to ps
  inst2 = sprintf('%s %s', 'dvips', strcat(img_file_base, '.dvi'));
  system (inst2);


  %## convert to png for wiki page
  str1 = 'gs -dNOPAUSE -dBATCH -dSAFER -sDEVICE=png16m -dTextAlphaBits=4 -dGraphicsAlphaBits=4';
  str2 = strcat("-r", num2str(300), 'x', num2str(300));
  str3 = '-dEPSCrop -sOutputFile=';
  str4 = strcat(img_file_base, '.png');
  str5 = strcat(img_file_base, '.ps');
  inst3 = sprintf('%s %s %s%s %s', str1, str2, str3, str4, str5);
  system (inst3);

  cd ..
  clf
end
