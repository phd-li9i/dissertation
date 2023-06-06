%clear all
%close all
%pkg load io
%pkg load geometry

%colours = colours2();
%here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



 %map
%map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/corridor');
%ms = csv2cell(map_str);
%map_x = ms(2:end, 1);
%map_y = ms(2:end, 2);
%map_x = cell2mat(map_x);
%map_y = cell2mat(map_y);


 %experiment data
%fmt_corridor_base_str = 'vault/fmt/Centroid-based/noise_s=125/corridor/';
%csm_corridor_base_str = 'vault/csm/corridor/';

%fmt_corridor_pose_1_dir_2 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.01/2020-03-02_13:43:25');
%fmt_corridor_pose_1_dir_3 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.02/2020-03-02_17:49:43');
%fmt_corridor_pose_1_dir_4 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.05/2020-03-02_22:07:58');

%fmt_corridor_pose_2_dir_2 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_00:39:06');
%fmt_corridor_pose_2_dir_3 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-11_18:52:08');
%fmt_corridor_pose_2_dir_4 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-11_14:58:25');

%fmt_corridor_pose_3_dir_2 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-19_00:19:00');
%fmt_corridor_pose_3_dir_3 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-18_20:27:08');
%fmt_corridor_pose_3_dir_4 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_15:58:54');

%fmt_corridor_pose_1_dirs = {fmt_corridor_pose_1_dir_2, fmt_corridor_pose_1_dir_3, fmt_corridor_pose_1_dir_4};
%fmt_corridor_pose_2_dirs = {fmt_corridor_pose_2_dir_2, fmt_corridor_pose_2_dir_3, fmt_corridor_pose_2_dir_4};
%fmt_corridor_pose_3_dirs = {fmt_corridor_pose_3_dir_2, fmt_corridor_pose_3_dir_3, fmt_corridor_pose_3_dir_4};
%fmt_corridor_poses = {fmt_corridor_pose_1_dirs; fmt_corridor_pose_2_dirs; fmt_corridor_pose_3_dirs};

%csm_corridor_pose_1_dir_2 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.01/2020-02-04_10:27:18');
%csm_corridor_pose_1_dir_3 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.02/2020-02-06_15:27:04');
%csm_corridor_pose_1_dir_4 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.05/2020-02-04_12:34:10');

%csm_corridor_pose_2_dir_2 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_18:13:57');
%csm_corridor_pose_2_dir_3 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-12_22:10:31');
%csm_corridor_pose_2_dir_4 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-13_09:28:56');

%csm_corridor_pose_3_dir_2 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-17_14:58:06');
%csm_corridor_pose_3_dir_3 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-17_18:47:18');
%csm_corridor_pose_3_dir_4 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_00:57:45');

%csm_corridor_pose_1_dirs = {csm_corridor_pose_1_dir_2, csm_corridor_pose_1_dir_3, csm_corridor_pose_1_dir_4};
%csm_corridor_pose_2_dirs = {csm_corridor_pose_2_dir_2, csm_corridor_pose_2_dir_3, csm_corridor_pose_2_dir_4};
%csm_corridor_pose_3_dirs = {csm_corridor_pose_3_dir_2, csm_corridor_pose_3_dir_3, csm_corridor_pose_3_dir_4};
%csm_corridor_poses = {csm_corridor_pose_1_dirs; csm_corridor_pose_2_dirs; csm_corridor_pose_3_dirs};

%fmt_corridor_xy_errors = [];
%fmt_corridor_t_errors = [];
%fmt_corridor_outliers = [];
%fmt_corridor_exec_time = [];

%csm_corridor_xy_errors = [];
%csm_corridor_t_errors = [];
%csm_corridor_outliers = [];
%csm_corridor_exec_time = [];


%for r=1:size(fmt_corridor_poses,1)
  %fmt_corridor_xy_errors_row = [];
  %fmt_corridor_t_errors_row = [];
  %fmt_corridor_outliers_row = [];
  %fmt_corridor_exec_time_row = [];
  %csm_corridor_xy_errors_row = [];
  %csm_corridor_t_errors_row = [];
  %csm_corridor_outliers_row = [];
  %csm_corridor_exec_time_row = [];

  %for c=1:size(fmt_corridor_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_corridor_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_corridor_poses{r}{c});

    %fmt_corridor_xy_errors_row = [fmt_corridor_xy_errors_row, fmt_xy];
    %fmt_corridor_t_errors_row = [fmt_corridor_t_errors_row, fmt_t];
    %fmt_corridor_outliers_row = [fmt_corridor_outliers_row, fmt_o];
    %fmt_corridor_exec_time_row = [fmt_corridor_exec_time_row, fmt_et-0.7];

    %csm_corridor_xy_errors_row = [csm_corridor_xy_errors_row, csm_xy];
    %csm_corridor_t_errors_row = [csm_corridor_t_errors_row, csm_t];
    %csm_corridor_outliers_row = [csm_corridor_outliers_row, csm_o];
    %csm_corridor_exec_time_row = [csm_corridor_exec_time_row, csm_et];

  %end
  %fmt_corridor_xy_errors = [fmt_corridor_xy_errors; fmt_corridor_xy_errors_row];
  %fmt_corridor_t_errors = [fmt_corridor_t_errors; fmt_corridor_t_errors_row];
  %fmt_corridor_outliers = [fmt_corridor_outliers; fmt_corridor_outliers_row];
  %fmt_corridor_exec_time = [fmt_corridor_exec_time; fmt_corridor_exec_time_row];

  %csm_corridor_xy_errors = [csm_corridor_xy_errors; csm_corridor_xy_errors_row];
  %csm_corridor_t_errors = [csm_corridor_t_errors; csm_corridor_t_errors_row];
  %csm_corridor_outliers = [csm_corridor_outliers; csm_corridor_outliers_row];
  %csm_corridor_exec_time = [csm_corridor_exec_time; csm_corridor_exec_time_row];

%end


%fmt_corridor_pose_errors = [];
%csm_corridor_pose_errors = [];
%for r=1:size(fmt_corridor_poses,1)
  %fmt_corridor_pose_errors = sqrt(fmt_corridor_xy_errors .* fmt_corridor_xy_errors + fmt_corridor_t_errors .* fmt_corridor_t_errors);
  %csm_corridor_pose_errors = sqrt(csm_corridor_xy_errors .* csm_corridor_xy_errors + csm_corridor_t_errors .* csm_corridor_t_errors);
%end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

M = [map_x map_y];
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');


pose_1 = [11.56 12.2 -0.78692];
pose_2 = [12.06 8.2 2.012487];
pose_3 = [8.06 9.2 -3.279462];

tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];

h = {};
arrow_1 = [pose_1(1,1:2) tip_1];
h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

arrow_2 = [pose_2(1,1:2) tip_2];
h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

arrow_3 = [pose_3(1,1:2) tip_3];
h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");


for i = 1:length(h)
  set(h{i}.body, 'color', [colours{i}(2,:)]);
  set(h{i}.wing, 'color', [colours{i}(2,:)]);
  set(h{i}.body, 'linewidth', 3);
  set(h{i}.wing, 'linewidth', 3);
end

axis equal
axis([2 15 3 15])






% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:3
  for p = 1:3
    h = bar([8*i+2*p], csm_corridor_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 30+2])
set(gca, 'XTick', [12 20 28]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^C$', '\\scriptsize $\\bm{p}_b^C$', '\\scriptsize $\\bm{p}_c^C$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:3
  for p = 1:3
    h = bar([8*i+2*p], fmt_corridor_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 30+2])
set(gca, 'XTick', [12 20 28]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^C$', '\\scriptsize $\\bm{p}_b^C$', '\\scriptsize $\\bm{p}_c^C$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = [1 2 3];
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_corridor_pose_errors(1,:), 'marker', '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_pose_errors(2,:), 'marker', '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_pose_errors(3,:), 'marker', '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.05]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.01 0.02 0.03 0.04 0.05]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.03$', '\\scriptsize $0.04$', '\\scriptsize $0.05$'});
title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_corridor_pose_errors(1,:), 'marker', '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_pose_errors(2,:), 'marker', '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_pose_errors(3,:), 'marker', '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.05]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.01 0.02 0.03 0.04 0.05]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.03$', '\\scriptsize $0.04$', '\\scriptsize $0.05$'});
box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_corridor_exec_time(1,:), 'marker', '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);,
plot(xaxis, csm_corridor_exec_time(2,:), 'marker', '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);,
plot(xaxis, csm_corridor_exec_time(3,:), 'marker', '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);,

xlim([0.5 3.5]);
ylim([0.16 0.32])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.16 0.20 0.24 0.28 0.32]);
set(gca, 'yticklabel', {'\\scriptsize $160$', '\\scriptsize $200$', '\\scriptsize $240$', '\\scriptsize $280$', '\\scriptsize $320$'});
title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_corridor_exec_time(1,:), 'marker', '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);,
plot(xaxis, fmt_corridor_exec_time(2,:), 'marker', '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);,
plot(xaxis, fmt_corridor_exec_time(3,:), 'marker', '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);,

xlim([0.5 3.5]);
ylim([0.16 0.32])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.16 0.20 0.24 0.28 0.32]);
set(gca, 'yticklabel', {'\\scriptsize $160$', '\\scriptsize $200$', '\\scriptsize $240$', '\\scriptsize $208$', '\\scriptsize $320$'});
box on;







img_file = strcat(here, '/results_corridor.eps');
drawnow ("epslatex", img_file, '')
