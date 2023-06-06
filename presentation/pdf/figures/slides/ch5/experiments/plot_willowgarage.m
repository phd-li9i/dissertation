%clear all
%close all
%pkg load io
%pkg load geometry

%colours = colours2();
%here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



%% map
%map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/willowgarage');
%ms = csv2cell(map_str);
%map_x = ms(2:end, 1);
%map_y = ms(2:end, 2);
%map_x = cell2mat(map_x);
%map_y = cell2mat(map_y);


%%experiment data
%fmt_willowgarage_base_str = 'vault/fmt/Centroid-based/noise_s=125/willowgarage/';
%csm_willowgarage_base_str = 'vault/csm/willowgarage/';

%fmt_willowgarage_pose_1_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-06_09:53:14');
%fmt_willowgarage_pose_1_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-06_21:25:00');
%fmt_willowgarage_pose_1_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-07_11:10:20');

%fmt_willowgarage_pose_2_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-28_15:28:06');
%fmt_willowgarage_pose_2_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-28_02:20:42');
%fmt_willowgarage_pose_2_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-04-27_11:23:22');

%fmt_willowgarage_pose_3_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-04_03:16:21');
%fmt_willowgarage_pose_3_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-03_14:55:59');
%fmt_willowgarage_pose_3_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-02_19:26:17');

%fmt_willowgarage_pose_4_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-13_17:00:41');
%fmt_willowgarage_pose_4_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-13_01:41:43');
%fmt_willowgarage_pose_4_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-12_10:09:45');

%fmt_willowgarage_pose_5_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-18_10:54:29');
%fmt_willowgarage_pose_5_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-18_23:57:28');
%fmt_willowgarage_pose_5_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-19_13:49:46');

%fmt_willowgarage_pose_6_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-21_15:13:01');
%fmt_willowgarage_pose_6_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-21_01:41:00');
%fmt_willowgarage_pose_6_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-20_11:58:34');

%fmt_willowgarage_pose_7_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-26_23:57:36');
%fmt_willowgarage_pose_7_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-26_10:53:10');
%fmt_willowgarage_pose_7_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-25_15:13:10');

%fmt_willowgarage_pose_8_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-02_15:09:49');
%fmt_willowgarage_pose_8_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-02_02:02:40');
%fmt_willowgarage_pose_8_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-01_11:47:00');

%fmt_willowgarage_pose_9_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-17_10:32:36');
%fmt_willowgarage_pose_9_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-18_01:05:53');
%fmt_willowgarage_pose_9_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-18_14:35:53');

%fmt_willowgarage_pose_10_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-23_11:05:58');
%fmt_willowgarage_pose_10_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-22_14:12:20');
%fmt_willowgarage_pose_10_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-22_01:01:07');


%fmt_willowgarage_pose_1_dirs = {fmt_willowgarage_pose_1_dir_2, fmt_willowgarage_pose_1_dir_3, fmt_willowgarage_pose_1_dir_4};
%fmt_willowgarage_pose_2_dirs = {fmt_willowgarage_pose_2_dir_2, fmt_willowgarage_pose_2_dir_3, fmt_willowgarage_pose_2_dir_4};
%fmt_willowgarage_pose_3_dirs = {fmt_willowgarage_pose_3_dir_2, fmt_willowgarage_pose_3_dir_3, fmt_willowgarage_pose_3_dir_4};
%fmt_willowgarage_pose_4_dirs = {fmt_willowgarage_pose_4_dir_2, fmt_willowgarage_pose_4_dir_3, fmt_willowgarage_pose_4_dir_4};
%fmt_willowgarage_pose_5_dirs = {fmt_willowgarage_pose_5_dir_2, fmt_willowgarage_pose_5_dir_3, fmt_willowgarage_pose_5_dir_4};
%fmt_willowgarage_pose_6_dirs = {fmt_willowgarage_pose_6_dir_2, fmt_willowgarage_pose_6_dir_3, fmt_willowgarage_pose_6_dir_4};
%fmt_willowgarage_pose_7_dirs = {fmt_willowgarage_pose_7_dir_2, fmt_willowgarage_pose_7_dir_3, fmt_willowgarage_pose_7_dir_4};
%fmt_willowgarage_pose_8_dirs = {fmt_willowgarage_pose_8_dir_2, fmt_willowgarage_pose_8_dir_3, fmt_willowgarage_pose_8_dir_4};
%fmt_willowgarage_pose_9_dirs = {fmt_willowgarage_pose_9_dir_2, fmt_willowgarage_pose_9_dir_3, fmt_willowgarage_pose_9_dir_4};
%fmt_willowgarage_pose_10_dirs = {fmt_willowgarage_pose_10_dir_2, fmt_willowgarage_pose_10_dir_3, fmt_willowgarage_pose_10_dir_4};
%fmt_willowgarage_poses = {fmt_willowgarage_pose_1_dirs;
                  %fmt_willowgarage_pose_2_dirs;
                  %fmt_willowgarage_pose_3_dirs;
                  %fmt_willowgarage_pose_4_dirs;
                  %fmt_willowgarage_pose_5_dirs;
                  %fmt_willowgarage_pose_6_dirs;
                  %fmt_willowgarage_pose_7_dirs;
                  %fmt_willowgarage_pose_8_dirs;
                  %fmt_willowgarage_pose_9_dirs;
                  %fmt_willowgarage_pose_10_dirs; };


%csm_willowgarage_pose_1_dir_2 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-09_14:20:59');
%csm_willowgarage_pose_1_dir_3 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-09_16:47:45');
%csm_willowgarage_pose_1_dir_4 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-09_19:15:13');

%csm_willowgarage_pose_2_dir_2 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-30_15:19:27');
%csm_willowgarage_pose_2_dir_3 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-30_21:40:38');
%csm_willowgarage_pose_2_dir_4 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-05-02_00:05:56');

%csm_willowgarage_pose_3_dir_2 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-05_15:41:14');
%csm_willowgarage_pose_3_dir_3 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-05_20:57:25');
%csm_willowgarage_pose_3_dir_4 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-06_10:03:08');

%csm_willowgarage_pose_4_dir_2 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-15_14:41:34');
%csm_willowgarage_pose_4_dir_3 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-15_20:26:15');
%csm_willowgarage_pose_4_dir_4 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-16_00:44:39');

%csm_willowgarage_pose_5_dir_2 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-16_22:08:10');
%csm_willowgarage_pose_5_dir_3 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-16_17:49:27');
%csm_willowgarage_pose_5_dir_4 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-16_14:03:59');

%csm_willowgarage_pose_6_dir_2 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-23_13:38:56');
%csm_willowgarage_pose_6_dir_3 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-23_18:02:10');
%csm_willowgarage_pose_6_dir_4 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-23_21:56:11');

%csm_willowgarage_pose_7_dir_2 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-28_15:27:10');
%csm_willowgarage_pose_7_dir_3 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-28_20:21:35');
%csm_willowgarage_pose_7_dir_4 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-29_00:35:12');

%csm_willowgarage_pose_8_dir_2 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-04_16:06:56');
%csm_willowgarage_pose_8_dir_3 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-05_10:50:30');
%csm_willowgarage_pose_8_dir_4 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-06_20:22:08');

%csm_willowgarage_pose_9_dir_2 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-19_18:15:56');
%csm_willowgarage_pose_9_dir_3 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-19_14:21:47');
%csm_willowgarage_pose_9_dir_4 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-19_10:19:51');

%csm_willowgarage_pose_10_dir_2 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-21_11:47:37');
%csm_willowgarage_pose_10_dir_3 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-21_17:17:16');
%csm_willowgarage_pose_10_dir_4 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-21_21:09:28');

%csm_willowgarage_pose_1_dirs = {csm_willowgarage_pose_1_dir_2, csm_willowgarage_pose_1_dir_3, csm_willowgarage_pose_1_dir_4};
%csm_willowgarage_pose_2_dirs = {csm_willowgarage_pose_2_dir_2, csm_willowgarage_pose_2_dir_3, csm_willowgarage_pose_2_dir_4};
%csm_willowgarage_pose_3_dirs = {csm_willowgarage_pose_3_dir_2, csm_willowgarage_pose_3_dir_3, csm_willowgarage_pose_3_dir_4};
%csm_willowgarage_pose_4_dirs = {csm_willowgarage_pose_4_dir_2, csm_willowgarage_pose_4_dir_3, csm_willowgarage_pose_4_dir_4};
%csm_willowgarage_pose_5_dirs = {csm_willowgarage_pose_5_dir_2, csm_willowgarage_pose_5_dir_3, csm_willowgarage_pose_5_dir_4};
%csm_willowgarage_pose_6_dirs = {csm_willowgarage_pose_6_dir_2, csm_willowgarage_pose_6_dir_3, csm_willowgarage_pose_6_dir_4};
%csm_willowgarage_pose_7_dirs = {csm_willowgarage_pose_7_dir_2, csm_willowgarage_pose_7_dir_3, csm_willowgarage_pose_7_dir_4};
%csm_willowgarage_pose_8_dirs = {csm_willowgarage_pose_8_dir_2, csm_willowgarage_pose_8_dir_3, csm_willowgarage_pose_8_dir_4};
%csm_willowgarage_pose_9_dirs = {csm_willowgarage_pose_9_dir_2, csm_willowgarage_pose_9_dir_3, csm_willowgarage_pose_9_dir_4};
%csm_willowgarage_pose_10_dirs = {csm_willowgarage_pose_10_dir_2, csm_willowgarage_pose_10_dir_3, csm_willowgarage_pose_10_dir_4};
%csm_willowgarage_poses = {csm_willowgarage_pose_1_dirs;
                  %csm_willowgarage_pose_2_dirs;
                  %csm_willowgarage_pose_3_dirs;
                  %csm_willowgarage_pose_4_dirs;
                  %csm_willowgarage_pose_5_dirs;
                  %csm_willowgarage_pose_6_dirs;
                  %csm_willowgarage_pose_7_dirs;
                  %csm_willowgarage_pose_8_dirs;
                  %csm_willowgarage_pose_9_dirs;
                  %csm_willowgarage_pose_10_dirs;};


%fmt_willowgarage_xy_errors = [];
%fmt_willowgarage_t_errors = [];
%fmt_willowgarage_outliers = [];
%fmt_willowgarage_exec_time = [];

%csm_willowgarage_xy_errors = [];
%csm_willowgarage_t_errors = [];
%csm_willowgarage_outliers = [];
%csm_willowgarage_exec_time = [];


%for r=1:size(fmt_willowgarage_poses,1)
  %fmt_willowgarage_xy_errors_row = [];
  %fmt_willowgarage_t_errors_row = [];
  %fmt_willowgarage_outliers_row = [];
  %fmt_willowgarage_exec_time_row = [];
  %csm_willowgarage_xy_errors_row = [];
  %csm_willowgarage_t_errors_row = [];
  %csm_willowgarage_outliers_row = [];
  %csm_willowgarage_exec_time_row = [];

  %for c=1:size(fmt_willowgarage_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_willowgarage_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_willowgarage_poses{r}{c});

    %fmt_willowgarage_xy_errors_row = [fmt_willowgarage_xy_errors_row, fmt_xy];
    %fmt_willowgarage_t_errors_row = [fmt_willowgarage_t_errors_row, fmt_t];
    %fmt_willowgarage_outliers_row = [fmt_willowgarage_outliers_row, fmt_o];
    %fmt_willowgarage_exec_time_row = [fmt_willowgarage_exec_time_row, fmt_et-0.7];

    %csm_willowgarage_xy_errors_row = [csm_willowgarage_xy_errors_row, csm_xy];
    %csm_willowgarage_t_errors_row = [csm_willowgarage_t_errors_row, csm_t];
    %csm_willowgarage_outliers_row = [csm_willowgarage_outliers_row, csm_o];
    %csm_willowgarage_exec_time_row = [csm_willowgarage_exec_time_row, csm_et];

  %end
  %fmt_willowgarage_xy_errors = [fmt_willowgarage_xy_errors; fmt_willowgarage_xy_errors_row];
  %fmt_willowgarage_t_errors = [fmt_willowgarage_t_errors; fmt_willowgarage_t_errors_row];
  %fmt_willowgarage_outliers = [fmt_willowgarage_outliers; fmt_willowgarage_outliers_row];
  %fmt_willowgarage_exec_time = [fmt_willowgarage_exec_time; fmt_willowgarage_exec_time_row];

  %csm_willowgarage_xy_errors = [csm_willowgarage_xy_errors; csm_willowgarage_xy_errors_row];
  %csm_willowgarage_t_errors = [csm_willowgarage_t_errors; csm_willowgarage_t_errors_row];
  %csm_willowgarage_outliers = [csm_willowgarage_outliers; csm_willowgarage_outliers_row];
  %csm_willowgarage_exec_time = [csm_willowgarage_exec_time; csm_willowgarage_exec_time_row];

%end

%fmt_willowgarage_pose_errors = [];
%csm_willowgarage_pose_errors = [];
%for r=1:size(fmt_willowgarage_poses,1)
  %fmt_willowgarage_pose_errors = sqrt(fmt_willowgarage_xy_errors .* fmt_willowgarage_xy_errors + fmt_willowgarage_t_errors .* fmt_willowgarage_t_errors);
  %csm_willowgarage_pose_errors = sqrt(csm_willowgarage_xy_errors .* csm_willowgarage_xy_errors + csm_willowgarage_t_errors .* csm_willowgarage_t_errors);
%end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

M = [map_x map_y];
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

pose_1 = [77.56 37.48 1.87232];
pose_2 = [67.85 66.90 0.12961];
pose_3 = [81.0 57.6 -2.96939];
pose_4 = [78.55, 78.35, -1.31];
pose_5 = [84.0, 78.15, -1.31];
pose_6 = [84.75, 56.65, 1.02];
pose_7 = [51.15, 44.65, 1.29];
pose_8 = [61.95, 37.8, -0.58];
pose_9 = [62.2, 37.76, 1.23];
pose_10 = [55.2, 37.76, 1.98];

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");

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


for i = 1:length(h)
  set(h{i}.body, 'color', [colours{i}(2,:)]);
  set(h{i}.wing, 'color', [colours{i}(2,:)]);
  set(h{i}.body, 'linewidth', 3);
  set(h{i}.wing, 'linewidth', 3);
end

axis equal
axis([45 90 35 81]);










% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:10
  for p = 1:3
    h = bar([8*i+2*p], csm_willowgarage_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 86+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^G$', '\\scriptsize $\\bm{p}_b^G$', '\\scriptsize $\\bm{p}_c^G$', '\\scriptsize $\\bm{p}_d^G$', '\\scriptsize $\\bm{p}_e^G$', '\\scriptsize $\\bm{p}_f^G$', '\\scriptsize $\\bm{p}_g^G$', '\\scriptsize $\\bm{p}_h^G$', '\\scriptsize $\\bm{p}_i^G$', '\\scriptsize $\\bm{p}_j^G$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:10
  for p = 1:3
    h = bar([8*i+2*p], fmt_willowgarage_outliers(i,p));
    set (h, "facecolor", [colours{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 86+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^G$', '\\scriptsize $\\bm{p}_b^G$', '\\scriptsize $\\bm{p}_c^G$', '\\scriptsize $\\bm{p}_d^G$', '\\scriptsize $\\bm{p}_e^G$', '\\scriptsize $\\bm{p}_f^G$', '\\scriptsize $\\bm{p}_g^G$', '\\scriptsize $\\bm{p}_h^G$', '\\scriptsize $\\bm{p}_i^G$', '\\scriptsize $\\bm{p}_j^G$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $25\\%$','\\scriptsize $50\\%$','\\scriptsize $75\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = [1 2 3];
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_willowgarage_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_pose_errors(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 1.4]);

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.3 0.6 0.9 1.2]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.30$', '\\scriptsize $0.60$', '\\scriptsize $0.90$', '\\scriptsize $1.2$'});

title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_willowgarage_pose_errors(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_pose_errors(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.35]);

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.0 0.1 0.2 0.3]);
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.10$', '\\scriptsize $0.20$', '\\scriptsize $0.30$'});

box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, csm_willowgarage_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_exec_time(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.05 0.4])

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.05 0.10 0.15 0.2 0.25 0.3 0.35 0.4]);
set(gca, 'yticklabel', {'\\scriptsize $50$', '\\scriptsize $100$', '\\scriptsize $150$', '\\scriptsize $200$', '\\scriptsize $250$', '\\scriptsize $300$', '\\scriptsize $350$', '\\scriptsize $400$'});


title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on;
plot(xaxis, fmt_willowgarage_exec_time(1,:), 'marker',  '.', 'color', [colours{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(2,:), 'marker',  '.', 'color', [colours{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(3,:), 'marker',  '.', 'color', [colours{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(4,:), 'marker',  '.', 'color', [colours{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(5,:), 'marker',  '.', 'color', [colours{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(6,:), 'marker',  '.', 'color', [colours{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(7,:), 'marker',  '.', 'color', [colours{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(8,:), 'marker',  '.', 'color', [colours{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(9,:), 'marker',  '.', 'color', [colours{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_exec_time(10,:), 'marker', '.', 'color', [colours{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.05 0.4])

set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize $0.01$', '\\scriptsize $0.02$', '\\scriptsize $0.05$'});
set(gca, 'YTick', [0.05 0.10 0.15 0.2 0.25 0.3 0.35 0.4]);
set(gca, 'yticklabel', {'\\scriptsize $50$', '\\scriptsize $100$', '\\scriptsize $150$', '\\scriptsize $200$', '\\scriptsize $250$', '\\scriptsize $300$', '\\scriptsize $350$', '\\scriptsize $400$'});


box on;







img_file = strcat(here, '/results_willowgarage.eps');
drawnow ("epslatex", img_file, '')
