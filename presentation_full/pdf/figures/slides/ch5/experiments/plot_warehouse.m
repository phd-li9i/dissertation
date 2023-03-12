clear all
close all
pkg load io
pkg load geometry

colours = colours2();
here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



% map
map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/warehouse');
ms = csv2cell(map_str);
map_x = ms(2:end, 1);
map_y = ms(2:end, 2);
map_x = cell2mat(map_x);
map_y = cell2mat(map_y);


%experiment data
fmt_warehouse_base_str = 'vault/fmt/Centroid-based/noise_s=125/warehouse/';
csm_warehouse_base_str = 'vault/csm/warehouse/';

fmt_warehouse_pose_1_dir_2 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.01/2020-03-03_19:04:07');
fmt_warehouse_pose_1_dir_3 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.02/2020-03-04_09:57:09');
fmt_warehouse_pose_1_dir_4 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.05/2020-03-04_16:51:48');

fmt_warehouse_pose_2_dir_2 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-09_21:06:46');
fmt_warehouse_pose_2_dir_3 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-09_12:47:12');
fmt_warehouse_pose_2_dir_4 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_16:06:36');

fmt_warehouse_pose_3_dir_2 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-12_03:49:15');
fmt_warehouse_pose_3_dir_3 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-12_13:46:23');
fmt_warehouse_pose_3_dir_4 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-12_21:32:37');

fmt_warehouse_pose_4_dir_2 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-14_10:01:20');
fmt_warehouse_pose_4_dir_3 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-14_17:32:49');
fmt_warehouse_pose_4_dir_4 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_02:41:05');

fmt_warehouse_pose_5_dir_2 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-17_09:58:04');
fmt_warehouse_pose_5_dir_3 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-17_18:54:25');
fmt_warehouse_pose_5_dir_4 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-18_11:54:10');

fmt_warehouse_pose_6_dir_2 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-19_20:42:25');
fmt_warehouse_pose_6_dir_3 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-19_12:39:20');
fmt_warehouse_pose_6_dir_4 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-18_20:40:12');

fmt_warehouse_pose_7_dir_2 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-22_21:04:50');
fmt_warehouse_pose_7_dir_3 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-23_10:32:30');
fmt_warehouse_pose_7_dir_4 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-23_17:57:47');

fmt_warehouse_pose_1_dirs = {fmt_warehouse_pose_1_dir_2, fmt_warehouse_pose_1_dir_3, fmt_warehouse_pose_1_dir_4};
fmt_warehouse_pose_2_dirs = {fmt_warehouse_pose_2_dir_2, fmt_warehouse_pose_2_dir_3, fmt_warehouse_pose_2_dir_4};
fmt_warehouse_pose_3_dirs = {fmt_warehouse_pose_3_dir_2, fmt_warehouse_pose_3_dir_3, fmt_warehouse_pose_3_dir_4};
fmt_warehouse_pose_4_dirs = {fmt_warehouse_pose_4_dir_2, fmt_warehouse_pose_4_dir_3, fmt_warehouse_pose_4_dir_4};
fmt_warehouse_pose_5_dirs = {fmt_warehouse_pose_5_dir_2, fmt_warehouse_pose_5_dir_3, fmt_warehouse_pose_5_dir_4};
fmt_warehouse_pose_6_dirs = {fmt_warehouse_pose_6_dir_2, fmt_warehouse_pose_6_dir_3, fmt_warehouse_pose_6_dir_4};
fmt_warehouse_pose_7_dirs = {fmt_warehouse_pose_7_dir_2, fmt_warehouse_pose_7_dir_3, fmt_warehouse_pose_7_dir_4};
fmt_warehouse_poses = {fmt_warehouse_pose_1_dirs;
                  fmt_warehouse_pose_2_dirs;
                  fmt_warehouse_pose_3_dirs;
                  fmt_warehouse_pose_4_dirs;
                  fmt_warehouse_pose_5_dirs;
                  fmt_warehouse_pose_6_dirs;
                  fmt_warehouse_pose_7_dirs};


csm_warehouse_pose_1_dir_2 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.01/2020-02-18_15:30:38');
csm_warehouse_pose_1_dir_3 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.02/2020-02-18_19:01:13');
csm_warehouse_pose_1_dir_4 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.05/2020-02-18_22:27:41');

csm_warehouse_pose_2_dir_2 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-11_12:32:05');
csm_warehouse_pose_2_dir_3 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-11_03:20:02');
csm_warehouse_pose_2_dir_4 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_23:05:03');

csm_warehouse_pose_3_dir_2 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-13_15:14:05');
csm_warehouse_pose_3_dir_3 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-13_12:26:42');
csm_warehouse_pose_3_dir_4 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-13_09:40:39');

csm_warehouse_pose_4_dir_2 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-15_13:18:07');
csm_warehouse_pose_4_dir_3 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-15_16:55:41');
csm_warehouse_pose_4_dir_4 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_20:00:49');

csm_warehouse_pose_5_dir_2 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-16_17:00:25');
csm_warehouse_pose_5_dir_3 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-16_14:12:22');
csm_warehouse_pose_5_dir_4 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-16_11:18:29');

csm_warehouse_pose_6_dir_2 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-20_19:56:36');
csm_warehouse_pose_6_dir_3 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-20_23:25:54');
csm_warehouse_pose_6_dir_4 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-21_10:12:35');

csm_warehouse_pose_7_dir_2 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-21_22:19:52');
csm_warehouse_pose_7_dir_3 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-21_19:31:55');
csm_warehouse_pose_7_dir_4 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-21_15:20:14');

csm_warehouse_pose_1_dirs = {csm_warehouse_pose_1_dir_2, csm_warehouse_pose_1_dir_3, csm_warehouse_pose_1_dir_4};
csm_warehouse_pose_2_dirs = {csm_warehouse_pose_2_dir_2, csm_warehouse_pose_2_dir_3, csm_warehouse_pose_2_dir_4};
csm_warehouse_pose_3_dirs = {csm_warehouse_pose_3_dir_2, csm_warehouse_pose_3_dir_3, csm_warehouse_pose_3_dir_4};
csm_warehouse_pose_4_dirs = {csm_warehouse_pose_4_dir_2, csm_warehouse_pose_4_dir_3, csm_warehouse_pose_4_dir_4};
csm_warehouse_pose_5_dirs = {csm_warehouse_pose_5_dir_2, csm_warehouse_pose_5_dir_3, csm_warehouse_pose_5_dir_4};
csm_warehouse_pose_6_dirs = {csm_warehouse_pose_6_dir_2, csm_warehouse_pose_6_dir_3, csm_warehouse_pose_6_dir_4};
csm_warehouse_pose_7_dirs = {csm_warehouse_pose_7_dir_2, csm_warehouse_pose_7_dir_3, csm_warehouse_pose_7_dir_4};
csm_warehouse_poses = {csm_warehouse_pose_1_dirs;
                  csm_warehouse_pose_2_dirs;
                  csm_warehouse_pose_3_dirs;
                  csm_warehouse_pose_4_dirs;
                  csm_warehouse_pose_5_dirs;
                  csm_warehouse_pose_6_dirs;
                  csm_warehouse_pose_7_dirs};



fmt_warehouse_xy_errors = [];
fmt_warehouse_t_errors = [];
fmt_warehouse_outliers = [];
fmt_warehouse_exec_time = [];

csm_warehouse_xy_errors = [];
csm_warehouse_t_errors = [];
csm_warehouse_outliers = [];
csm_warehouse_exec_time = [];


for r=1:size(fmt_warehouse_poses,1)
  fmt_warehouse_xy_errors_row = [];
  fmt_warehouse_t_errors_row = [];
  fmt_warehouse_outliers_row = [];
  fmt_warehouse_exec_time_row = [];
  csm_warehouse_xy_errors_row = [];
  csm_warehouse_t_errors_row = [];
  csm_warehouse_outliers_row = [];
  csm_warehouse_exec_time_row = [];

  for c=1:size(fmt_warehouse_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_warehouse_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_warehouse_poses{r}{c});

    fmt_warehouse_xy_errors_row = [fmt_warehouse_xy_errors_row, fmt_xy];
    fmt_warehouse_t_errors_row = [fmt_warehouse_t_errors_row, fmt_t];
    fmt_warehouse_outliers_row = [fmt_warehouse_outliers_row, fmt_o];
    fmt_warehouse_exec_time_row = [fmt_warehouse_exec_time_row, fmt_et-0.7];

    csm_warehouse_xy_errors_row = [csm_warehouse_xy_errors_row, csm_xy];
    csm_warehouse_t_errors_row = [csm_warehouse_t_errors_row, csm_t];
    csm_warehouse_outliers_row = [csm_warehouse_outliers_row, csm_o];
    csm_warehouse_exec_time_row = [csm_warehouse_exec_time_row, csm_et];

  end
  fmt_warehouse_xy_errors = [fmt_warehouse_xy_errors; fmt_warehouse_xy_errors_row];
  fmt_warehouse_t_errors = [fmt_warehouse_t_errors; fmt_warehouse_t_errors_row];
  fmt_warehouse_outliers = [fmt_warehouse_outliers; fmt_warehouse_outliers_row];
  fmt_warehouse_exec_time = [fmt_warehouse_exec_time; fmt_warehouse_exec_time_row];

  csm_warehouse_xy_errors = [csm_warehouse_xy_errors; csm_warehouse_xy_errors_row];
  csm_warehouse_t_errors = [csm_warehouse_t_errors; csm_warehouse_t_errors_row];
  csm_warehouse_outliers = [csm_warehouse_outliers; csm_warehouse_outliers_row];
  csm_warehouse_exec_time = [csm_warehouse_exec_time; csm_warehouse_exec_time_row];

end

fmt_warehouse_pose_errors = [];
csm_warehouse_pose_errors = [];
for r=1:size(fmt_warehouse_poses,1)
  fmt_warehouse_pose_errors = sqrt(fmt_warehouse_xy_errors .* fmt_warehouse_xy_errors + fmt_warehouse_t_errors .* fmt_warehouse_t_errors);
  csm_warehouse_pose_errors = sqrt(csm_warehouse_xy_errors .* csm_warehouse_xy_errors + csm_warehouse_t_errors .* csm_warehouse_t_errors);
end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

Rm = [0 -1; 1 0];
Rp = [0 -1 0; 1 0 0; 0 0 1];
M = [map_x map_y];
M = Rm * M';
M = M';

M(:,1) = M(:,1) + 21.0;
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');


pose_1 = Rp * [8.08321 3.0156 -2.85278]';
pose_2 = Rp * [35.16 15.25 -2.20061]';
pose_3 = Rp * [38.81 2.35 1.36012]';
pose_4 = Rp * [33.42 4.92 2.78921]';
pose_5 = Rp * [17.08 8.75 2.83870]';
pose_6 = Rp * [8.63 11.93 -1.26394]';
pose_7 = Rp * [1.27 9.5 0.23935]';

pose_1 = pose_1';
pose_2 = pose_2';
pose_3 = pose_3';
pose_4 = pose_4';
pose_5 = pose_5';
pose_6 = pose_6';
pose_7 = pose_7';

pose_1(1,1) = pose_1(1,1) + 21;
pose_2(1,1) = pose_2(1,1) + 21;
pose_3(1,1) = pose_3(1,1) + 21;
pose_4(1,1) = pose_4(1,1) + 21;
pose_5(1,1) = pose_5(1,1) + 21;
pose_6(1,1) = pose_6(1,1) + 21;
pose_7(1,1) = pose_7(1,1) + 21;

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

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");


for i = 1:length(h)
  set(h{i}.body, 'color', [colours{i}(2,:)]);
  set(h{i}.wing, 'color', [colours{i}(2,:)]);
  set(h{i}.body, 'linewidth', 3);
  set(h{i}.wing, 'linewidth', 3);
end

axis equal
axis([0 22 0 42])






% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], csm_warehouse_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^W$', '\\scriptsize $\\bm{p}_b^W$', '\\scriptsize $\\bm{p}_c^W$', '\\scriptsize $\\bm{p}_d^W$', '\\scriptsize $\\bm{p}_e^W$', '\\scriptsize $\\bm{p}_f^W$', '\\scriptsize $\\bm{p}_g^W$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], fmt_warehouse_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^W$', '\\scriptsize $\\bm{p}_b^W$', '\\scriptsize $\\bm{p}_c^W$', '\\scriptsize $\\bm{p}_d^W$', '\\scriptsize $\\bm{p}_e^W$', '\\scriptsize $\\bm{p}_f^W$', '\\scriptsize $\\bm{p}_g^W$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = [1 2 3];
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_warehouse_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [3.14 3.26]);
set(gca, 'yticklabel', {'\\scriptsize $3.14$', '\\scriptsize $3.26$'});
title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_warehouse_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.04 0.16])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.04 0.06 0.08 0.10 0.12 0.14 0.16]);
set(gca, 'yticklabel', {'\\scriptsize $0.04$', '\\scriptsize $0.06$', '\\scriptsize $0.08$', '\\scriptsize $0.10$', '\\scriptsize $0.12$', '\\scriptsize $0.14$', '\\scriptsize $0.16$'});
box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_warehouse_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.2 0.44])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.2 0.28 0.36 0.44]);
set(gca, 'yticklabel', {'\\scriptsize $200$', '\\scriptsize $280$', '\\scriptsize $360$', '\\scriptsize $440$'});

title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_warehouse_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.2 0.44])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.2 0.28 0.36 0.44]);
set(gca, 'yticklabel', {'\\scriptsize $200$', '\\scriptsize $280$', '\\scriptsize $360$', '\\scriptsize $440$'});

box on;







img_file = strcat(here, '/results_warehouse.eps');
drawnow ("epslatex", img_file, '')
