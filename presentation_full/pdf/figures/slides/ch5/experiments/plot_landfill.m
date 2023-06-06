%clear all
%close all
%pkg load io
%pkg load geometry

%colours = colours2();
%here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



%% map
%map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/dirtrack');
%ms = csv2cell(map_str);
%map_x = ms(2:end, 1);
%map_y = ms(2:end, 2);
%map_x = cell2mat(map_x);
%map_y = cell2mat(map_y);


%%experiment data
%fmt_landfill_base_str = 'vault/fmt/Centroid-based/noise_s=125/dirtrack/';
%csm_landfill_base_str = 'vault/csm/dirtrack/';

%fmt_landfill_pose_1_dir_2 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-01_02:23:58');
%fmt_landfill_pose_1_dir_3 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-01_13:13:11');
%fmt_landfill_pose_1_dir_4 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-01_18:32:10');

%fmt_landfill_pose_2_dir_2 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-02_10:35:55');
%fmt_landfill_pose_2_dir_3 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-02_16:08:14');
%fmt_landfill_pose_2_dir_4 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-02_19:59:29');

%fmt_landfill_pose_3_dir_2 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-03_10:45:46');
%fmt_landfill_pose_3_dir_3 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-03_15:13:38');
%fmt_landfill_pose_3_dir_4 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-03_19:11:24');

%fmt_landfill_pose_4_dir_2 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-04_10:53:59');
%fmt_landfill_pose_4_dir_3 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-04_14:46:46');
%fmt_landfill_pose_4_dir_4 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-04_18:48:03');

%fmt_landfill_pose_5_dir_2 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-05_02:54:21');
%fmt_landfill_pose_5_dir_3 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-05_10:43:56');
%fmt_landfill_pose_5_dir_4 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-05_15:17:09');

%fmt_landfill_pose_6_dir_2 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-06_01:43:11');
%fmt_landfill_pose_6_dir_3 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-06_10:12:29');
%fmt_landfill_pose_6_dir_4 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-06_14:04:24');

%fmt_landfill_pose_7_dir_2 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-06_22:12:47');
%fmt_landfill_pose_7_dir_3 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-07_02:56:06');
%fmt_landfill_pose_7_dir_4 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-07_13:27:11');



%fmt_landfill_pose_1_dirs = {fmt_landfill_pose_1_dir_2, fmt_landfill_pose_1_dir_3, fmt_landfill_pose_1_dir_4};
%fmt_landfill_pose_2_dirs = {fmt_landfill_pose_2_dir_2, fmt_landfill_pose_2_dir_3, fmt_landfill_pose_2_dir_4};
%fmt_landfill_pose_3_dirs = {fmt_landfill_pose_3_dir_2, fmt_landfill_pose_3_dir_3, fmt_landfill_pose_3_dir_4};
%fmt_landfill_pose_4_dirs = {fmt_landfill_pose_4_dir_2, fmt_landfill_pose_4_dir_3, fmt_landfill_pose_4_dir_4};
%fmt_landfill_pose_5_dirs = {fmt_landfill_pose_5_dir_2, fmt_landfill_pose_5_dir_3, fmt_landfill_pose_5_dir_4};
%fmt_landfill_pose_6_dirs = {fmt_landfill_pose_6_dir_2, fmt_landfill_pose_6_dir_3, fmt_landfill_pose_6_dir_4};
%fmt_landfill_pose_7_dirs = {fmt_landfill_pose_7_dir_2, fmt_landfill_pose_7_dir_3, fmt_landfill_pose_7_dir_4};
%fmt_landfill_poses = {fmt_landfill_pose_1_dirs;
                  %fmt_landfill_pose_2_dirs;
                  %fmt_landfill_pose_3_dirs;
                  %fmt_landfill_pose_4_dirs;
                  %fmt_landfill_pose_5_dirs;
                  %fmt_landfill_pose_6_dirs;
                  %fmt_landfill_pose_7_dirs;};


%csm_landfill_pose_1_dir_2 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-07_23:52:27');
%csm_landfill_pose_1_dir_3 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-07_21:48:38');
%csm_landfill_pose_1_dir_4 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-07_17:31:00');

%csm_landfill_pose_2_dir_2 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-08_14:44:27');
%csm_landfill_pose_2_dir_3 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-08_17:27:11');
%csm_landfill_pose_2_dir_4 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-08_20:12:34');

%csm_landfill_pose_3_dir_2 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-09_10:07:28');
%csm_landfill_pose_3_dir_3 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-09_12:12:11');
%csm_landfill_pose_3_dir_4 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-09_14:18:56');

%csm_landfill_pose_4_dir_2 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-09_18:24:57');
%csm_landfill_pose_4_dir_3 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-09_20:54:44');
%csm_landfill_pose_4_dir_4 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-09_23:07:32');

%csm_landfill_pose_5_dir_2 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-10_10:35:26');
%csm_landfill_pose_5_dir_3 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-10_12:37:31');
%csm_landfill_pose_5_dir_4 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-10_14:57:32');

%csm_landfill_pose_6_dir_2 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-10_19:11:36');
%csm_landfill_pose_6_dir_3 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-10_21:29:43');
%csm_landfill_pose_6_dir_4 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-10_23:57:44');

%csm_landfill_pose_7_dir_2 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-11_11:06:06');
%csm_landfill_pose_7_dir_3 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-11_13:12:29');
%csm_landfill_pose_7_dir_4 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-11_15:12:33');



%csm_landfill_pose_1_dirs = {csm_landfill_pose_1_dir_2, csm_landfill_pose_1_dir_3, csm_landfill_pose_1_dir_4};
%csm_landfill_pose_2_dirs = {csm_landfill_pose_2_dir_2, csm_landfill_pose_2_dir_3, csm_landfill_pose_2_dir_4};
%csm_landfill_pose_3_dirs = {csm_landfill_pose_3_dir_2, csm_landfill_pose_3_dir_3, csm_landfill_pose_3_dir_4};
%csm_landfill_pose_4_dirs = {csm_landfill_pose_4_dir_2, csm_landfill_pose_4_dir_3, csm_landfill_pose_4_dir_4};
%csm_landfill_pose_5_dirs = {csm_landfill_pose_5_dir_2, csm_landfill_pose_5_dir_3, csm_landfill_pose_5_dir_4};
%csm_landfill_pose_6_dirs = {csm_landfill_pose_6_dir_2, csm_landfill_pose_6_dir_3, csm_landfill_pose_6_dir_4};
%csm_landfill_pose_7_dirs = {csm_landfill_pose_7_dir_2, csm_landfill_pose_7_dir_3, csm_landfill_pose_7_dir_4};

%csm_landfill_poses = {csm_landfill_pose_1_dirs;
                  %csm_landfill_pose_2_dirs;
                  %csm_landfill_pose_3_dirs;
                  %csm_landfill_pose_4_dirs;
                  %csm_landfill_pose_5_dirs;
                  %csm_landfill_pose_6_dirs;
                  %csm_landfill_pose_7_dirs;};


%fmt_landfill_xy_errors = [];
%fmt_landfill_t_errors = [];
%fmt_landfill_outliers = [];
%fmt_landfill_exec_time = [];

%csm_landfill_xy_errors = [];
%csm_landfill_t_errors = [];
%csm_landfill_outliers = [];
%csm_landfill_exec_time = [];


%for r=1:size(fmt_landfill_poses,1)
  %fmt_landfill_xy_errors_row = [];
  %fmt_landfill_t_errors_row = [];
  %fmt_landfill_outliers_row = [];
  %fmt_landfill_exec_time_row = [];
  %csm_landfill_xy_errors_row = [];
  %csm_landfill_t_errors_row = [];
  %csm_landfill_outliers_row = [];
  %csm_landfill_exec_time_row = [];

  %for c=1:size(fmt_landfill_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_landfill_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_landfill_poses{r}{c});

    %fmt_landfill_xy_errors_row = [fmt_landfill_xy_errors_row, fmt_xy];
    %fmt_landfill_t_errors_row = [fmt_landfill_t_errors_row, fmt_t];
    %fmt_landfill_outliers_row = [fmt_landfill_outliers_row, fmt_o];
    %fmt_landfill_exec_time_row = [fmt_landfill_exec_time_row, fmt_et-0.7];

    %csm_landfill_xy_errors_row = [csm_landfill_xy_errors_row, csm_xy];
    %csm_landfill_t_errors_row = [csm_landfill_t_errors_row, csm_t];
    %csm_landfill_outliers_row = [csm_landfill_outliers_row, csm_o];
    %csm_landfill_exec_time_row = [csm_landfill_exec_time_row, csm_et];

  %end
  %fmt_landfill_xy_errors = [fmt_landfill_xy_errors; fmt_landfill_xy_errors_row];
  %fmt_landfill_t_errors = [fmt_landfill_t_errors; fmt_landfill_t_errors_row];
  %fmt_landfill_outliers = [fmt_landfill_outliers; fmt_landfill_outliers_row];
  %fmt_landfill_exec_time = [fmt_landfill_exec_time; fmt_landfill_exec_time_row];

  %csm_landfill_xy_errors = [csm_landfill_xy_errors; csm_landfill_xy_errors_row];
  %csm_landfill_t_errors = [csm_landfill_t_errors; csm_landfill_t_errors_row];
  %csm_landfill_outliers = [csm_landfill_outliers; csm_landfill_outliers_row];
  %csm_landfill_exec_time = [csm_landfill_exec_time; csm_landfill_exec_time_row];

%end

%fmt_landfill_pose_errors = [];
%csm_landfill_pose_errors = [];
%for r=1:size(fmt_landfill_poses,1)
  %fmt_landfill_pose_errors = sqrt(fmt_landfill_xy_errors .* fmt_landfill_xy_errors + fmt_landfill_t_errors .* fmt_landfill_t_errors);
  %csm_landfill_pose_errors = sqrt(csm_landfill_xy_errors .* csm_landfill_xy_errors + csm_landfill_t_errors .* csm_landfill_t_errors);
%end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

M = [map_x map_y];
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');


pose_1 = [3.34 17.19 -0.082];
pose_2 = [3.34 26.19 -0.78];
pose_3 = [8.34 25.19 0.90];
pose_4 = [3.34 10.19 -2.97];
pose_5 = [7.34 8.19 -1.93];
pose_6 = [7.34 1.19 0.58];
pose_7 = [8.34 18.19 -2.02];


tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];

h = {};
arrow_1 = [pose_1(1,1:2) tip_1];
h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

arrow_2 = [pose_2(1,1:2) tip_2];
h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

arrow_3 = [pose_3(1,1:2) tip_3];
h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

arrow_4 = [pose_4(1,1:2) tip_4];
h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

arrow_5 = [pose_5(1,1:2) tip_5];
h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

arrow_6 = [pose_6(1,1:2) tip_6];
h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

arrow_7 = [pose_7(1,1:2) tip_7];
h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

axis equal
x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");


for i = 1:length(h)
  set(h{i}.body, 'color', [colours{i}(2,:)]);
  set(h{i}.wing, 'color', [colours{i}(2,:)]);
  set(h{i}.body, 'linewidth', 3);
  set(h{i}.wing, 'linewidth', 3);
end

axis equal
axis([-1 13 -1 29])






% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], csm_landfill_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^L$', '\\scriptsize $\\bm{p}_b^L$', '\\scriptsize $\\bm{p}_c^L$', '\\scriptsize $\\bm{p}_d^L$', '\\scriptsize $\\bm{p}_e^L$', '\\scriptsize $\\bm{p}_f^L$', '\\scriptsize $\\bm{p}_g^L$'});

set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], fmt_landfill_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^L$', '\\scriptsize $\\bm{p}_b^L$', '\\scriptsize $\\bm{p}_c^L$', '\\scriptsize $\\bm{p}_d^L$', '\\scriptsize $\\bm{p}_e^L$', '\\scriptsize $\\bm{p}_f^L$', '\\scriptsize $\\bm{p}_g^L$'});

set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = [1 2 3];
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_landfill_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.25 0.45]);

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.25 0.30 0.35 0.40 0.45]);
set(gca, 'yticklabel', {'\\scriptsize $0.25$', '\\scriptsize $0.30$', '\\scriptsize $0.35$', '\\scriptsize $0.40$', '\\scriptsize $0.45$'});
title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_landfill_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.25 0.45]);

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.25 0.30 0.35 0.40 0.45]);
set(gca, 'yticklabel', {'\\scriptsize $0.25$', '\\scriptsize $0.30$', '\\scriptsize $0.35$', '\\scriptsize $0.40$', '\\scriptsize $0.45$'});
box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_landfill_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.2 0.35])

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.2 0.25 0.30 0.35]);
set(gca, 'yticklabel', {'\\scriptsize $200$', '\\scriptsize $250$', '\\scriptsize $300$', '\\scriptsize $350$'});
title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_landfill_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.2 0.35])

set(gca, 'XTick', [1 2 3]);
set(gca, 'YTick', [0.2 0.25 0.30 0.35]);
set(gca, 'yticklabel', {'\\scriptsize $200$', '\\scriptsize $250$', '\\scriptsize $300$', '\\scriptsize $350$'});

box on;







img_file = strcat(here, '/results_landfill.eps');
drawnow ("epslatex", img_file, '')
