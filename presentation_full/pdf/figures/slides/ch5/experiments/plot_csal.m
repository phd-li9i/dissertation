clear all
close all
pkg load io
pkg load geometry

colours = colours2();
here = '/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/';



% map
map_str = strcat('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch5/experiments/maps/csal');
ms = csv2cell(map_str);
map_x = ms(2:end, 1);
map_y = ms(2:end, 2);
map_x = cell2mat(map_x);
map_y = cell2mat(map_y);


%experiment data
fmt_csal_base_str = 'vault/fmt/Centroid-based/noise_s=125/csal/';
csm_csal_base_str = 'vault/csm/csal/';

fmt_csal_pose_1_dir_2 = strcat(fmt_csal_base_str, 'pose_1');

fmt_csal_pose_2_dir_2 = strcat(fmt_csal_base_str, 'pose_2');

fmt_csal_pose_3_dir_2 = strcat(fmt_csal_base_str, 'pose_3');

fmt_csal_pose_4_dir_2 = strcat(fmt_csal_base_str, 'pose_4');

fmt_csal_pose_5_dir_2 = strcat(fmt_csal_base_str, 'pose_5');

fmt_csal_pose_6_dir_2 = strcat(fmt_csal_base_str, 'pose_6');

fmt_csal_pose_7_dir_2 = strcat(fmt_csal_base_str, 'pose_7');

fmt_csal_pose_8_dir_2 = strcat(fmt_csal_base_str, 'pose_8');

fmt_csal_pose_9_dir_2 = strcat(fmt_csal_base_str, 'pose_9');

fmt_csal_pose_10_dir_2 = strcat(fmt_csal_base_str, 'pose_10');

fmt_csal_pose_11_dir_2 = strcat(fmt_csal_base_str, 'pose_11');

fmt_csal_pose_1_dirs = {fmt_csal_pose_1_dir_2};
fmt_csal_pose_2_dirs = {fmt_csal_pose_2_dir_2};
fmt_csal_pose_3_dirs = {fmt_csal_pose_3_dir_2};
fmt_csal_pose_4_dirs = {fmt_csal_pose_4_dir_2};
fmt_csal_pose_5_dirs = {fmt_csal_pose_5_dir_2};
fmt_csal_pose_6_dirs = {fmt_csal_pose_6_dir_2};
fmt_csal_pose_7_dirs = {fmt_csal_pose_7_dir_2};
fmt_csal_pose_8_dirs = {fmt_csal_pose_8_dir_2};
fmt_csal_pose_9_dirs = {fmt_csal_pose_9_dir_2};
fmt_csal_pose_10_dirs = {fmt_csal_pose_10_dir_2};
fmt_csal_pose_11_dirs = {fmt_csal_pose_11_dir_2};
fmt_csal_poses = {fmt_csal_pose_1_dirs;
                  fmt_csal_pose_2_dirs;
                  fmt_csal_pose_3_dirs;
                  fmt_csal_pose_4_dirs;
                  fmt_csal_pose_5_dirs;
                  fmt_csal_pose_6_dirs;
                  fmt_csal_pose_7_dirs;
                  fmt_csal_pose_8_dirs;
                  fmt_csal_pose_9_dirs;
                  fmt_csal_pose_10_dirs;
                  fmt_csal_pose_11_dirs};


csm_csal_pose_1_dir_2 = strcat(csm_csal_base_str, 'pose_1');

csm_csal_pose_2_dir_2 = strcat(csm_csal_base_str, 'pose_2');

csm_csal_pose_3_dir_2 = strcat(csm_csal_base_str, 'pose_3');

csm_csal_pose_4_dir_2 = strcat(csm_csal_base_str, 'pose_4');

csm_csal_pose_5_dir_2 = strcat(csm_csal_base_str, 'pose_5');

csm_csal_pose_6_dir_2 = strcat(csm_csal_base_str, 'pose_6');

csm_csal_pose_7_dir_2 = strcat(csm_csal_base_str, 'pose_7');

csm_csal_pose_8_dir_2 = strcat(csm_csal_base_str, 'pose_8');

csm_csal_pose_9_dir_2 = strcat(csm_csal_base_str, 'pose_9');

csm_csal_pose_10_dir_2 = strcat(csm_csal_base_str, 'pose_10');

csm_csal_pose_11_dir_2 = strcat(csm_csal_base_str, 'pose_11');

csm_csal_pose_1_dirs = {csm_csal_pose_1_dir_2};
csm_csal_pose_2_dirs = {csm_csal_pose_2_dir_2};
csm_csal_pose_3_dirs = {csm_csal_pose_3_dir_2};
csm_csal_pose_4_dirs = {csm_csal_pose_4_dir_2};
csm_csal_pose_5_dirs = {csm_csal_pose_5_dir_2};
csm_csal_pose_6_dirs = {csm_csal_pose_6_dir_2};
csm_csal_pose_7_dirs = {csm_csal_pose_7_dir_2};
csm_csal_pose_8_dirs = {csm_csal_pose_8_dir_2};
csm_csal_pose_9_dirs = {csm_csal_pose_9_dir_2};
csm_csal_pose_10_dirs = {csm_csal_pose_10_dir_2};
csm_csal_pose_11_dirs = {csm_csal_pose_11_dir_2};
csm_csal_poses = {csm_csal_pose_1_dirs;
                  csm_csal_pose_2_dirs;
                  csm_csal_pose_3_dirs;
                  csm_csal_pose_4_dirs;
                  csm_csal_pose_5_dirs;
                  csm_csal_pose_6_dirs;
                  csm_csal_pose_7_dirs;
                  csm_csal_pose_8_dirs;
                  csm_csal_pose_9_dirs;
                  csm_csal_pose_10_dirs;
                  csm_csal_pose_11_dirs};


fmt_csal_xy_errors = [];
fmt_csal_t_errors = [];
fmt_csal_outliers = [];
fmt_csal_exec_time = [];

csm_csal_xy_errors = [];
csm_csal_t_errors = [];
csm_csal_outliers = [];
csm_csal_exec_time = [];


for r=1:size(fmt_csal_poses,1)
  fmt_csal_xy_errors_row = [];
  fmt_csal_t_errors_row = [];
  fmt_csal_outliers_row = [];
  fmt_csal_exec_time_row = [];
  csm_csal_xy_errors_row = [];
  csm_csal_t_errors_row = [];
  csm_csal_outliers_row = [];
  csm_csal_exec_time_row = [];

  for c=1:size(fmt_csal_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_csal_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_csal_poses{r}{c});

    fmt_csal_xy_errors_row = [fmt_csal_xy_errors_row, fmt_xy];
    fmt_csal_t_errors_row = [fmt_csal_t_errors_row, fmt_t];
    fmt_csal_outliers_row = [fmt_csal_outliers_row, fmt_o];
    fmt_csal_exec_time_row = [fmt_csal_exec_time_row, fmt_et];

    csm_csal_xy_errors_row = [csm_csal_xy_errors_row, csm_xy];
    csm_csal_t_errors_row = [csm_csal_t_errors_row, csm_t];
    csm_csal_outliers_row = [csm_csal_outliers_row, csm_o];
    csm_csal_exec_time_row = [csm_csal_exec_time_row, csm_et];

  end
  fmt_csal_xy_errors = [fmt_csal_xy_errors; fmt_csal_xy_errors_row];
  fmt_csal_t_errors = [fmt_csal_t_errors; fmt_csal_t_errors_row];
  fmt_csal_outliers = [fmt_csal_outliers; fmt_csal_outliers_row];
  fmt_csal_exec_time = [fmt_csal_exec_time; fmt_csal_exec_time_row];

  csm_csal_xy_errors = [csm_csal_xy_errors; csm_csal_xy_errors_row];
  csm_csal_t_errors = [csm_csal_t_errors; csm_csal_t_errors_row];
  csm_csal_outliers = [csm_csal_outliers; csm_csal_outliers_row];
  csm_csal_exec_time = [csm_csal_exec_time; csm_csal_exec_time_row];

end

fmt_csal_pose_errors = [];
csm_csal_pose_errors = [];
for r=1:size(fmt_csal_poses,1)
  fmt_csal_pose_errors = sqrt(fmt_csal_xy_errors .* fmt_csal_xy_errors + fmt_csal_t_errors .* fmt_csal_t_errors);
  csm_csal_pose_errors = sqrt(csm_csal_xy_errors .* csm_csal_xy_errors + csm_csal_t_errors .* csm_csal_t_errors);
end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 475 200])

% PLOT MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,[1,4], 'sh', 0.1, 'sv', 0.15)

M = [map_x map_y];
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

pose_1 = [15.4721268025, 15.1977831686, -0.095];
pose_2 = [16.7216527641, 14.8115392043, -1.67];
pose_3 = [12.6718948032, 13.9136193677, 2.982];
pose_4 = [11.3033797346, 13.1062780437, 1.083];
pose_5 = [11.7128740531, 11.8384089383, -1.700];
pose_6 = [12.1218809427, 9.80543750581, -2.088];
pose_7 = [12.4712945723, 8.89038521273, -1.149];
pose_8 = [13.2214581898, 8.08269807369, 0.105];
pose_9 = [14.3233989244, 8.31691540978, 0.652];
pose_10 = [16.2206537931, 9.01636418709, 0.470];
pose_11 = [13.5679147405, 10.9915395271, -2.637];


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
axis([5.5 20 6.5 21])







% PLOT INLIERS PERCENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,2, 'sh', 0.1, 'sv', 0.15);
hold on
for i=1:11
  hb = bar([2*i], csm_csal_outliers(i));
  set (hb, "facecolor", [colours{i}(2,:)]);
end
ylim([0 5])
xlim([2-1 22+1])
set(gca, 'XTick', 2*[1:11]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^A$', '\\scriptsize $\\bm{p}_b^A$', '\\scriptsize $\\bm{p}_c^A$', '\\scriptsize $\\bm{p}_d^A$', '\\scriptsize $\\bm{p}_e^A$', '\\scriptsize $\\bm{p}_f^A$', '\\scriptsize $\\bm{p}_g^A$', '\\scriptsize $\\bm{p}_h^A$', '\\scriptsize $\\bm{p}_i^A$', '\\scriptsize $\\bm{p}_j^A$', '\\scriptsize $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 1 2 3 4 5])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $20\\%$','\\scriptsize $40\\%$','\\scriptsize $60\\%$', '\\scriptsize $80\\%$', '\\scriptsize $100\\%$'});
box on
title('\footnotesize Ποσοστά αποτυχιών')
%grid

subaxis(3,3,3, 'sh', 0.1, 'sv', 0.15);
hold on;
for i=1:11
  hb = bar([2*i], fmt_csal_outliers(i));
  set (hb, "facecolor", [colours{i}(2,:)]);
end
ylim([0 5])
xlim([2-1 22+1])
set(gca, 'XTick', 2*[1:11]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^A$', '\\scriptsize $\\bm{p}_b^A$', '\\scriptsize $\\bm{p}_c^A$', '\\scriptsize $\\bm{p}_d^A$', '\\scriptsize $\\bm{p}_e^A$', '\\scriptsize $\\bm{p}_f^A$', '\\scriptsize $\\bm{p}_g^A$', '\\scriptsize $\\bm{p}_h^A$', '\\scriptsize $\\bm{p}_i^A$', '\\scriptsize $\\bm{p}_j^A$', '\\scriptsize $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 1 2 3 4 5])
set(gca, 'yticklabel', {'\\scriptsize $0\\%$', '\\scriptsize $20\\%$','\\scriptsize $40\\%$','\\scriptsize $60\\%$', '\\scriptsize $80\\%$', '\\scriptsize $100\\%$'});
box on
%grid




% PLOT POSE ERRORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth = 3;

subaxis(3,3,5, 'sh', 0.1, 'sv', 0.15)
hold on
for i = 1:6
  s = stem(i, csm_csal_pose_errors(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end
for i = 7:2:11
  s = stem(i, csm_csal_pose_errors(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.40])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 0.10 0.20 0.30 0.40])
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.10$','\\scriptsize $0.20$','\\scriptsize $0.30$', '\\scriptsize $0.40$'});
title('\footnotesize Μέσο σφάλμα στάσης [$(\text{m}^2 + \text{rad}^2)^{1/2}$]')
box on;


subaxis(3,3,6, 'sh', 0.1, 'sv', 0.15)
hold on;
hold on
for i = 1:11
  s = stem(i, fmt_csal_pose_errors(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.40])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^A$', '\\scriptsize $\\bm{p}_b^A$', '\\scriptsize $\\bm{p}_c^A$', '\\scriptsize $\\bm{p}_d^A$', '\\scriptsize $\\bm{p}_e^A$', '\\scriptsize $\\bm{p}_f^A$', '\\scriptsize $\\bm{p}_g^A$', '\\scriptsize $\\bm{p}_h^A$', '\\scriptsize $\\bm{p}_i^A$', '\\scriptsize $\\bm{p}_j^A$', '\\scriptsize $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 0.10 0.20 0.30 0.40])
set(gca, 'yticklabel', {'\\scriptsize $0.0$', '\\scriptsize $0.10$','\\scriptsize $0.20$','\\scriptsize $0.30$', '\\scriptsize $0.40$'});
box on;




% PLOT EXECUTION TIMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(3,3,8, 'sh', 0.1, 'sv', 0.15)
hold on
for i = 1:6
  s = stem(i, csm_csal_exec_time(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end
for i = 7:2:11
  s = stem(i, csm_csal_exec_time(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end

ylim([0 1.2])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11], 'xticklabel', []);
set(gca, 'ytick', [0 0.2 0.4 0.6 0.8 1.0 1.2]);
set(gca, 'yticklabel', {'\\scriptsize $0$','\\scriptsize $200$','\\scriptsize $400$','\\scriptsize $600$','\\scriptsize $800$','\\scriptsize $1000$','\\scriptsize $1200$'});

title('\footnotesize Μέσος χρόνος εκτέλεσης ανά υπόθεση [ms]')
box on;

subaxis(3,3,9, 'sh', 0.1, 'sv', 0.15)
hold on
for i = 1:11
  s = stem(i, fmt_csal_exec_time(i));
  set(s, 'color', [colours{i}(2,:)], 'markerfacecolor', [colours{i}(2,:)], 'markeredgecolor', [colours{i}(2,:)], 'linewidth', linewidth);
end

ylim([0 1.2])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', {'\\scriptsize $\\bm{p}_a^A$', '\\scriptsize $\\bm{p}_b^A$', '\\scriptsize $\\bm{p}_c^A$', '\\scriptsize $\\bm{p}_d^A$', '\\scriptsize $\\bm{p}_e^A$', '\\scriptsize $\\bm{p}_f^A$', '\\scriptsize $\\bm{p}_g^A$', '\\scriptsize $\\bm{p}_h^A$', '\\scriptsize $\\bm{p}_i^A$', '\\scriptsize $\\bm{p}_j^A$', '\\scriptsize $\\bm{p}_k^A$' });
set(gca, 'ytick', [0 0.2 0.4 0.6 0.8 1.0 1.2]);
set(gca, 'yticklabel', {'\\scriptsize $0$','\\scriptsize $200$','\\scriptsize $400$','\\scriptsize $600$','\\scriptsize $800$','\\scriptsize $1000$','\\scriptsize $1200$'});
%grid
box on;







img_file = strcat(here, '/results_csal.eps');
drawnow ("epslatex", img_file, '')
