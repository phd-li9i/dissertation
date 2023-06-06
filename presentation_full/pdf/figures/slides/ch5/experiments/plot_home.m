%clear all
%close all
%pkg load io
%pkg load geometry

%colours = colours2();
%here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



%% map
%map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/home');
%ms = csv2cell(map_str);
%map_x = ms(2:end, 1);
%map_y = ms(2:end, 2);
%map_x = cell2mat(map_x);
%map_y = cell2mat(map_y);


%%experiment data
%fmt_home_base_str = 'vault/fmt/Centroid-based/noise_s=125/home/';
%csm_home_base_str = 'vault/csm/home/';

%fmt_home_pose_1_dir_2 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.01/2020-02-29_00:41:39');
%fmt_home_pose_1_dir_3 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.02/2020-02-29_14:51:19');
%fmt_home_pose_1_dir_4 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.05/2020-03-01_14:51:25');

%fmt_home_pose_2_dir_2 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.01/2020-03-19_22:09:40');
%fmt_home_pose_2_dir_3 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.02/2020-03-20_09:25:23');
%fmt_home_pose_2_dir_4 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_16:25:12');

%fmt_home_pose_3_dir_2 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.01/2020-03-22_02:29:06');
%fmt_home_pose_3_dir_3 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.02/2020-03-22_11:50:58');
%fmt_home_pose_3_dir_4 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.05/2020-03-22_19:33:51');

%fmt_home_pose_4_dir_2 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.01/2020-03-24_16:50:29');
%fmt_home_pose_4_dir_3 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.02/2020-03-24_09:45:09');
%fmt_home_pose_4_dir_4 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.05/2020-03-23_21:31:05');

%fmt_home_pose_5_dir_2 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.01/2020-06-13_22:52:26');
%fmt_home_pose_5_dir_3 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.02/2020-06-12_12:42:45');
%fmt_home_pose_5_dir_4 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.05/2020-06-12_21:18:45');

%fmt_home_pose_6_dir_2 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.01/2020-03-27_23:22:45');
%fmt_home_pose_6_dir_3 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.02/2020-03-27_16:22:33');
%fmt_home_pose_6_dir_4 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.05/2020-03-27_09:26:12');

%fmt_home_pose_7_dir_2 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.01/2020-03-29_20:45:41');
%fmt_home_pose_7_dir_3 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.02/2020-03-29_13:41:55');
%fmt_home_pose_7_dir_4 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.05/2020-03-28_23:09:03');

%fmt_home_pose_8_dir_2 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.01/2020-06-10_13:00:10');
%fmt_home_pose_8_dir_3 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.02/2020-06-11_10:09:56');
%fmt_home_pose_8_dir_4 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.05/2020-06-11_18:49:26');

%fmt_home_pose_9_dir_2 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_00:41:37');
%fmt_home_pose_9_dir_3 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.02/2020-04-02_17:23:49');
%fmt_home_pose_9_dir_4 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.05/2020-04-02_10:20:54');

%fmt_home_pose_10_dir_2 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.01/2020-04-04_19:33:55');
%fmt_home_pose_10_dir_3 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.02/2020-04-05_03:36:15');
%fmt_home_pose_10_dir_4 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_14:31:27');

%fmt_home_pose_11_dir_2 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.01/2020-04-08_10:11:44');
%fmt_home_pose_11_dir_3 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_23:04:27');
%fmt_home_pose_11_dir_4 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_15:27:07');

%fmt_home_pose_1_dirs = {fmt_home_pose_1_dir_2, fmt_home_pose_1_dir_3, fmt_home_pose_1_dir_4};
%fmt_home_pose_2_dirs = {fmt_home_pose_2_dir_2, fmt_home_pose_2_dir_3, fmt_home_pose_2_dir_4};
%fmt_home_pose_3_dirs = {fmt_home_pose_3_dir_2, fmt_home_pose_3_dir_3, fmt_home_pose_3_dir_4};
%fmt_home_pose_4_dirs = {fmt_home_pose_4_dir_2, fmt_home_pose_4_dir_3, fmt_home_pose_4_dir_4};
%fmt_home_pose_5_dirs = {fmt_home_pose_5_dir_2, fmt_home_pose_5_dir_3, fmt_home_pose_5_dir_4};
%fmt_home_pose_6_dirs = {fmt_home_pose_6_dir_2, fmt_home_pose_6_dir_3, fmt_home_pose_6_dir_4};
%fmt_home_pose_7_dirs = {fmt_home_pose_7_dir_2, fmt_home_pose_7_dir_3, fmt_home_pose_7_dir_4};
%fmt_home_pose_8_dirs = {fmt_home_pose_8_dir_2, fmt_home_pose_8_dir_3, fmt_home_pose_8_dir_4};
%fmt_home_pose_9_dirs = {fmt_home_pose_9_dir_2, fmt_home_pose_9_dir_3, fmt_home_pose_9_dir_4};
%fmt_home_pose_10_dirs = {fmt_home_pose_10_dir_2, fmt_home_pose_10_dir_3, fmt_home_pose_10_dir_4};
%fmt_home_pose_11_dirs = {fmt_home_pose_11_dir_2, fmt_home_pose_11_dir_3, fmt_home_pose_11_dir_4};
%fmt_home_poses = {fmt_home_pose_1_dirs;
                  %fmt_home_pose_2_dirs;
                  %fmt_home_pose_3_dirs;
                  %fmt_home_pose_4_dirs;
                  %fmt_home_pose_5_dirs;
                  %fmt_home_pose_6_dirs;
                  %fmt_home_pose_7_dirs;
                  %fmt_home_pose_8_dirs;
                  %fmt_home_pose_9_dirs;
                  %fmt_home_pose_10_dirs;
                  %fmt_home_pose_11_dirs};


%csm_home_pose_1_dir_2 = strcat(csm_home_base_str, 'pose_1/noise_s=0.01/2020-02-17_12:36:24');
%csm_home_pose_1_dir_3 = strcat(csm_home_base_str, 'pose_1/noise_s=0.02/2020-02-14_16:17:33');
%csm_home_pose_1_dir_4 = strcat(csm_home_base_str, 'pose_1/noise_s=0.05/2020-02-17_09:40:53');

%csm_home_pose_2_dir_2 = strcat(csm_home_base_str, 'pose_2/noise_s=0.01/2020-03-21_12:32:16');
%csm_home_pose_2_dir_3 = strcat(csm_home_base_str, 'pose_2/noise_s=0.02/2020-03-21_01:50:20');
%csm_home_pose_2_dir_4 = strcat(csm_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_23:21:33');

%csm_home_pose_3_dir_2 = strcat(csm_home_base_str, 'pose_3/noise_s=0.01/2020-03-23_15:57:58');
%csm_home_pose_3_dir_3 = strcat(csm_home_base_str, 'pose_3/noise_s=0.02/2020-03-23_13:08:04');
%csm_home_pose_3_dir_4 = strcat(csm_home_base_str, 'pose_3/noise_s=0.05/2020-03-23_10:41:35');

%csm_home_pose_4_dir_2 = strcat(csm_home_base_str, 'pose_4/noise_s=0.01/2020-03-25_09:48:03');
%csm_home_pose_4_dir_3 = strcat(csm_home_base_str, 'pose_4/noise_s=0.02/2020-03-25_10:13:33');
%csm_home_pose_4_dir_4 = strcat(csm_home_base_str, 'pose_4/noise_s=0.05/2020-03-25_10:30:21');

%csm_home_pose_5_dir_2 = strcat(csm_home_base_str, 'pose_5/noise_s=0.01/2020-03-26_19:27:40');
%csm_home_pose_5_dir_3 = strcat(csm_home_base_str, 'pose_5/noise_s=0.02/2020-03-26_22:00:47');
%csm_home_pose_5_dir_4 = strcat(csm_home_base_str, 'pose_5/noise_s=0.05/2020-03-27_00:25:52');

%csm_home_pose_6_dir_2 = strcat(csm_home_base_str, 'pose_6/noise_s=0.01/2020-03-28_21:46:50');
%csm_home_pose_6_dir_3 = strcat(csm_home_base_str, 'pose_6/noise_s=0.02/2020-03-28_22:13:58');
%csm_home_pose_6_dir_4 = strcat(csm_home_base_str, 'pose_6/noise_s=0.05/2020-03-28_22:49:17');

%csm_home_pose_7_dir_2 = strcat(csm_home_base_str, 'pose_7/noise_s=0.01/2020-03-30_18:34:41');
%csm_home_pose_7_dir_3 = strcat(csm_home_base_str, 'pose_7/noise_s=0.02/2020-03-30_21:02:52');
%csm_home_pose_7_dir_4 = strcat(csm_home_base_str, 'pose_7/noise_s=0.05/2020-03-31_00:42:09');

%csm_home_pose_8_dir_2 = strcat(csm_home_base_str, 'pose_8/noise_s=0.01/2020-04-01_19:35:35');
%csm_home_pose_8_dir_3 = strcat(csm_home_base_str, 'pose_8/noise_s=0.02/2020-04-01_22:03:43');
%csm_home_pose_8_dir_4 = strcat(csm_home_base_str, 'pose_8/noise_s=0.05/2020-04-02_00:51:59');

%csm_home_pose_9_dir_2 = strcat(csm_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_21:46:59');
%csm_home_pose_9_dir_3 = strcat(csm_home_base_str, 'pose_9/noise_s=0.02/2020-04-03_19:15:27');
%csm_home_pose_9_dir_4 = strcat(csm_home_base_str, 'pose_9/noise_s=0.05/2020-04-03_16:34:29');

%csm_home_pose_10_dir_2 = strcat(csm_home_base_str, 'pose_10/noise_s=0.01/2020-04-06_09:49:56');
%csm_home_pose_10_dir_3 = strcat(csm_home_base_str, 'pose_10/noise_s=0.02/2020-04-06_00:41:07');
%csm_home_pose_10_dir_4 = strcat(csm_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_21:53:56');

%csm_home_pose_11_dir_2 = strcat(csm_home_base_str, 'pose_11/noise_s=0.01/2020-04-06_22:30:50');
%csm_home_pose_11_dir_3 = strcat(csm_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_09:27:07');
%csm_home_pose_11_dir_4 = strcat(csm_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_12:12:21');

%csm_home_pose_1_dirs = {csm_home_pose_1_dir_2, csm_home_pose_1_dir_3, csm_home_pose_1_dir_4};
%csm_home_pose_2_dirs = {csm_home_pose_2_dir_2, csm_home_pose_2_dir_3, csm_home_pose_2_dir_4};
%csm_home_pose_3_dirs = {csm_home_pose_3_dir_2, csm_home_pose_3_dir_3, csm_home_pose_3_dir_4};
%csm_home_pose_4_dirs = {csm_home_pose_4_dir_2, csm_home_pose_4_dir_3, csm_home_pose_4_dir_4};
%csm_home_pose_5_dirs = {csm_home_pose_5_dir_2, csm_home_pose_5_dir_3, csm_home_pose_5_dir_4};
%csm_home_pose_6_dirs = {csm_home_pose_6_dir_2, csm_home_pose_6_dir_3, csm_home_pose_6_dir_4};
%csm_home_pose_7_dirs = {csm_home_pose_7_dir_2, csm_home_pose_7_dir_3, csm_home_pose_7_dir_4};
%csm_home_pose_8_dirs = {csm_home_pose_8_dir_2, csm_home_pose_8_dir_3, csm_home_pose_8_dir_4};
%csm_home_pose_9_dirs = {csm_home_pose_9_dir_2, csm_home_pose_9_dir_3, csm_home_pose_9_dir_4};
%csm_home_pose_10_dirs = {csm_home_pose_10_dir_2, csm_home_pose_10_dir_3, csm_home_pose_10_dir_4};
%csm_home_pose_11_dirs = {csm_home_pose_11_dir_2, csm_home_pose_11_dir_3, csm_home_pose_11_dir_4};
%csm_home_poses = {csm_home_pose_1_dirs;
                  %csm_home_pose_2_dirs;
                  %csm_home_pose_3_dirs;
                  %csm_home_pose_4_dirs;
                  %csm_home_pose_5_dirs;
                  %csm_home_pose_6_dirs;
                  %csm_home_pose_7_dirs;
                  %csm_home_pose_8_dirs;
                  %csm_home_pose_9_dirs;
                  %csm_home_pose_10_dirs;
                  %csm_home_pose_11_dirs};


%fmt_home_xy_errors = [];
%fmt_home_t_errors = [];
%fmt_home_outliers = [];
%fmt_home_exec_time = [];

%csm_home_xy_errors = [];
%csm_home_t_errors = [];
%csm_home_outliers = [];
%csm_home_exec_time = [];


%for r=1:size(fmt_home_poses,1)
  %fmt_home_xy_errors_row = [];
  %fmt_home_t_errors_row = [];
  %fmt_home_outliers_row = [];
  %fmt_home_exec_time_row = [];
  %csm_home_xy_errors_row = [];
  %csm_home_t_errors_row = [];
  %csm_home_outliers_row = [];
  %csm_home_exec_time_row = [];

  %for c=1:size(fmt_home_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_home_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_home_poses{r}{c});

    %fmt_home_xy_errors_row = [fmt_home_xy_errors_row, fmt_xy];
    %fmt_home_t_errors_row = [fmt_home_t_errors_row, fmt_t];
    %fmt_home_outliers_row = [fmt_home_outliers_row, fmt_o];
    %fmt_home_exec_time_row = [fmt_home_exec_time_row, fmt_et-0.7];

    %csm_home_xy_errors_row = [csm_home_xy_errors_row, csm_xy];
    %csm_home_t_errors_row = [csm_home_t_errors_row, csm_t];
    %csm_home_outliers_row = [csm_home_outliers_row, csm_o];
    %csm_home_exec_time_row = [csm_home_exec_time_row, csm_et];

  %end
  %fmt_home_xy_errors = [fmt_home_xy_errors; fmt_home_xy_errors_row];
  %fmt_home_t_errors = [fmt_home_t_errors; fmt_home_t_errors_row];
  %fmt_home_outliers = [fmt_home_outliers; fmt_home_outliers_row];
  %fmt_home_exec_time = [fmt_home_exec_time; fmt_home_exec_time_row];

  %csm_home_xy_errors = [csm_home_xy_errors; csm_home_xy_errors_row];
  %csm_home_t_errors = [csm_home_t_errors; csm_home_t_errors_row];
  %csm_home_outliers = [csm_home_outliers; csm_home_outliers_row];
  %csm_home_exec_time = [csm_home_exec_time; csm_home_exec_time_row];

%end

%fmt_home_pose_errors = [];
%csm_home_pose_errors = [];
%for r=1:size(fmt_home_poses,1)
  %fmt_home_pose_errors = sqrt(fmt_home_xy_errors .* fmt_home_xy_errors + fmt_home_t_errors .* fmt_home_t_errors);
  %csm_home_pose_errors = sqrt(csm_home_xy_errors .* csm_home_xy_errors + csm_home_t_errors .* csm_home_t_errors);
%end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

M = [map_x map_y];
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');


pose_1 = [14.44 24.04 0.065046];
pose_2 = [17.84 24.84 1.329936];
pose_3 = [15.0 14.68 0.679224];
pose_4 = [22.0 14.22 -2.660285];
pose_5 = [26.0 16.10 0.698761];
pose_6 = [24.46 9.68 -0.492742];
pose_7 = [18.26 11.02 -3.102612];
pose_8 = [27.64 7.78 -0.142964];
pose_9 = [24.28 21.44 2.408114];
pose_10 = [29.0 28.64 0.305766];
pose_11 = [31.0 12.2 -2.197832];

tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];
tip_8 = pose_8(1,1:2) + [cos(pose_8(1,3)) sin(pose_8(1,3))];
tip_9 = pose_9(1,1:2) + [cos(pose_9(1,3)) sin(pose_9(1,3))];
tip_10 = pose_10(1,1:2) + [cos(pose_10(1,3)) sin(pose_10(1,3))];
tip_11 = pose_11(1,1:2) + [cos(pose_11(1,3)) sin(pose_11(1,3))];


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

arrow_8 = [pose_8(1,1:2) tip_8];
h{8} = drawArrow (arrow_8, 1, 0.5 , 0.1);

arrow_9 = [pose_9(1,1:2) tip_9];
h{9} = drawArrow (arrow_9, 1, 0.5 , 0.1);

arrow_10 = [pose_10(1,1:2) tip_10];
h{10} = drawArrow (arrow_10, 1, 0.5 , 0.1);

arrow_11 = [pose_11(1,1:2) tip_11];
h{11} = drawArrow (arrow_11, 1, 0.5 , 0.1);

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");


for i = 1:length(h)
  set(h{i}.body, 'color', [colours{i}(2,:)]);
  set(h{i}.wing, 'color', [colours{i}(2,:)]);
  set(h{i}.body, 'linewidth', 3);
  set(h{i}.wing, 'linewidth', 3);
end

axis equal
axis([9.5 40 3 30])






% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:11
  for p = 1:3
    h = bar([8*i+2*p], csm_home_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 94+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84 92]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^H$', '\\scriptsize $\\bm{p}_b^H$', '\\scriptsize $\\bm{p}_c^H$', '\\scriptsize $\\bm{p}_d^H$', '\\scriptsize $\\bm{p}_e^H$', '\\scriptsize $\\bm{p}_f^H$', '\\scriptsize $\\bm{p}_g^H$', '\\scriptsize $\\bm{p}_h^H$', '\\scriptsize $\\bm{p}_i^H$', '\\scriptsize $\\bm{p}_j^H$', '\\scriptsize $\\bm{p}_k^H$' });

set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:11
  for p = 1:3
    h = bar([8*i+2*p], fmt_home_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 94+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84 92]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^H$', '\\scriptsize $\\bm{p}_b^H$', '\\scriptsize $\\bm{p}_c^H$', '\\scriptsize $\\bm{p}_d^H$', '\\scriptsize $\\bm{p}_e^H$', '\\scriptsize $\\bm{p}_f^H$', '\\scriptsize $\\bm{p}_g^H$', '\\scriptsize $\\bm{p}_h^H$', '\\scriptsize $\\bm{p}_i^H$', '\\scriptsize $\\bm{p}_j^H$', '\\scriptsize $\\bm{p}_k^H$' });

set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = [1 2 3];
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_home_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_pose_errors(11,:), 'marker', '.', 'color', [colours{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.25]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.05$', '\\scriptsize $0.10$', '\\scriptsize $0.15$', '\\scriptsize $0.20$', '\\scriptsize $0.25$'});
title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_home_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_pose_errors(11,:), 'marker', '.', 'color', [colours{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.25]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.05$', '\\scriptsize $0.10$', '\\scriptsize $0.15$', '\\scriptsize $0.20$', '\\scriptsize $0.25$'});
box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_home_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_exec_time(11,:), 'marker', '.', 'color', [colours{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.16 0.48])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.16 0.24 0.32 0.4 0.48]);
set(gca, 'yticklabel', {'\\scriptsize $160$', '\\scriptsize $240$', '\\scriptsize $320$', '\\scriptsize $400$', '\\scriptsize $480$'});

title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_home_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_exec_time(11,:), 'marker', '.', 'color', [colours{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.16 0.48])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.16 0.24 0.32 0.4 0.48]);
set(gca, 'yticklabel', {'\\scriptsize $160$', '\\scriptsize $240$', '\\scriptsize $320$', '\\scriptsize $400$', '\\scriptsize $480$'});

box on;







img_file = strcat(here, '/results_home.eps');
drawnow ("epslatex", img_file, '')
