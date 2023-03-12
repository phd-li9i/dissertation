clear all;
close all;

store = true;


if store
  graphics_toolkit("gnuplot")
end

logs_dir = '/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/all_logs';
print_dir = pwd;

mats_exist = false;

if exist('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/a_data/percents') == 2
  mats_exist = true;
end

if (~mats_exist)

  datasets = {'aces', 'fr079', 'intel', 'mit_csail', 'mit_killian'};

  % Grab pose, position, and orientation errors per dataset
  initial_poses = {};
  real_poses = {};
  pose_errors = {};

  for i = 1:size(datasets,2)
    pose_errors{end+1}   = function_get_pose_errors(logs_dir, datasets{i});
    real_poses{end+1}    = function_get_real_poses(logs_dir, datasets{i});
    initial_poses{end+1} = function_get_initial_pose_estimates(logs_dir, datasets{i});
  end


  % Rearrange to suitable structure for plotting
  pose_errors_comb = {};
  initial_poses_comb = {};
  real_poses_comb = {};

  % Do the first dataset just for later concatenation purposes
  for a = 1:size(pose_errors{1},2)              % num algorithms
    for sm = 1:size(pose_errors{1}{a},2)        % num map noises
      for sr = 1:size(pose_errors{1}{a}{sm},2)  % num scan noises
        pose_errors_comb{a}{sm}{sr} = pose_errors{1}{a}{sm}{sr};
        real_poses_comb{a}{sm}{sr} = real_poses{1}{a}{sm}{sr};
        initial_poses_comb{a}{sm}{sr} = initial_poses{1}{a}{sm}{sr};
      end
    end
  end

  for d = 2:size(pose_errors,2)                   % num datasets
    for a = 1:size(pose_errors{d},2)              % num algorithms
      for sm = 1:size(pose_errors{d}{a},2)        % num map noises
        for sr = 1:size(pose_errors{d}{a}{sm},2)  % num scan noises
          pose_errors_comb{a}{sm}{sr} = [pose_errors_comb{a}{sm}{sr}, pose_errors{d}{a}{sm}{sr}];
          real_poses_comb{a}{sm}{sr} = [real_poses_comb{a}{sm}{sr}, real_poses{d}{a}{sm}{sr}];
          initial_poses_comb{a}{sm}{sr} = [initial_poses_comb{a}{sm}{sr}, initial_poses{d}{a}{sm}{sr}];
        end
      end
    end
  end


  datasets_sizes = [7373, 4933, 13630, 1987, 17479];


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Pose errors
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % But also look at the ones they processed only; p for pure

  pose_errors_comb_p = pose_errors_comb;
  initial_poses_comb_p = initial_poses_comb;
  real_poses_comb_p = real_poses_comb;


  % Include failed by default
  for a = 1:size(pose_errors{1},2)              % num algorithms
    for sm = 1:size(pose_errors{1}{a},2)        % num map noises
      for sr = 1:size(pose_errors{1}{a}{sm},2)  % num scan noises
        if a < 5 || a > 6
          if size(pose_errors_comb{a}{sm}{sr},2) < 10 * sum(datasets_sizes)
            pose_errors_comb{a}{sm}{sr} = ...
              [pose_errors_comb{a}{sm}{sr}, ones(1, (10 * sum(datasets_sizes)-size(pose_errors_comb{a}{sm}{sr},2)))];

            real_poses_comb{a}{sm}{sr} = ...
              [real_poses_comb{a}{sm}{sr}, zeros(3, (10 * sum(datasets_sizes)-size(real_poses_comb{a}{sm}{sr},2)))];

            initial_poses_comb{a}{sm}{sr} = ...
              [initial_poses_comb{a}{sm}{sr}, zeros(3, (10 * sum(datasets_sizes)-size(initial_poses_comb{a}{sm}{sr},2)))];
          end
        else
          if size(pose_errors_comb{a}{sm}{sr},2) < 1 * sum(datasets_sizes)
            pose_errors_comb{a}{sm}{sr} = ...
              [pose_errors_comb{a}{sm}{sr}, ones(1, (1 * sum(datasets_sizes)-size(pose_errors_comb{a}{sm}{sr},2)))];

            real_poses_comb{a}{sm}{sr} = ...
              [real_poses_comb{a}{sm}{sr}, zeros(3, (1 * sum(datasets_sizes)-size(real_poses_comb{a}{sm}{sr},2)))];

            initial_poses_comb{a}{sm}{sr} = ...
              [initial_poses_comb{a}{sm}{sr}, zeros(3, (1 * sum(datasets_sizes)-size(initial_poses_comb{a}{sm}{sr},2)))];
          end
        end
      end
    end
  end





  % Get initial pose errors and then percent of success
  initial_pose_errors_comb = {};
  percents = {};
  for a = 1:size(pose_errors{1},2)              % num algorithms
    for sm = 1:size(pose_errors{1}{a},2)        % num map noises
      for sr = 1:size(pose_errors{1}{a}{sm},2)  % num scan noises
        d = real_poses_comb{a}{sm}{sr} - initial_poses_comb{a}{sm}{sr};
        d(3,:) = rem(d(3,:) + 5*pi, 2*pi)-pi;
        initial_pose_errors_comb{a}{sm}{sr} = sqrt(sum(d .* d, 1));
        indicator = pose_errors_comb{a}{sm}{sr} - initial_pose_errors_comb{a}{sm}{sr} < 0;
        percents{a}{sm}{sr} = nnz(indicator) / numel(indicator);
      end
    end
  end

  save percents percents
else
  load('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/a_data/percents');
end





% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script will crash at line 166 for no reason.
% Just copy from here till the end in the octave console and it will run
%
%
c2 = [255, 197, 0;
      178,204,227;
      255, 0, 255]/255;

xtick = [1 2 3 4 5];

% H1: ERRORS WHEN MAP NOISE = 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(1);
set(h,'position',[1 1 420 120]);

s1 = subaxis(2,9,1, 'ML', 0.0, 'MR', 0.008, 'SH', 0.008, 'MT', 0.01, 'MB', 0, 'SV', 0.1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h11 = bar(100*[percents{1}{1}{1}, percents{1}{1}{2}, percents{1}{1}{3}, percents{1}{1}{4}, percents{1}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100], "yticklabel", {'\\footnotesize $75\\%$','\\footnotesize $80\\%$','\\footnotesize $85\\%$','\\footnotesize $90\\%$', '\\footnotesize $95\\%$', '\\footnotesize $100\\%$'});
xlim([0.3,5.7])
ylim([73 100])
set(gca, "ylabel", "\\small $\\sigma_{\\bm{M}} = 0.0$ m");
set(gca, "xticklabel", []);
box on

title('\footnotesize PLICP')

s2 = subaxis(2,9,2); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h31 = bar(100*[percents{2}{1}{1}, percents{2}{1}{2}, percents{2}{1}{3}, percents{2}{1}{4}, percents{2}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize NDT')

s3 = subaxis(2,9,3); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{3}{1}{1}, percents{3}{1}{2}, percents{3}{1}{3}, percents{3}{1}{4}, percents{3}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize FastGICP')


s4 = subaxis(2,9,4); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{4}{1}{1}, percents{4}{1}{2}, percents{4}{1}{3}, percents{4}{1}{4}, percents{4}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize FastVGICP')

s5 = subaxis(2,9,5); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{5}{1}{1}, percents{5}{1}{2}, percents{5}{1}{3}, percents{5}{1}{4}, percents{5}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize NDT-PSO')

s6 = subaxis(2,9,6); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{6}{1}{1}, percents{6}{1}{2}, percents{6}{1}{3}, percents{6}{1}{4}, percents{6}{1}{5}], 'k');
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize TEASER')

s7 = subaxis(2,9,7); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{7}{1}{1}, percents{7}{1}{2}, percents{7}{1}{3}, percents{7}{1}{4}, percents{7}{1}{5}], 'facecolor', [c2(1,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize \texttt{x1}')

s8 = subaxis(2,9,8); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{8}{1}{1}, percents{8}{1}{2}, percents{8}{1}{3}, percents{8}{1}{4}, percents{8}{1}{5}], 'facecolor', [c2(2,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize \texttt{uf}')

s9 = subaxis(2,9,9); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{9}{1}{1}, percents{9}{1}{2}, percents{9}{1}{3}, percents{9}{1}{4}, percents{9}{1}{5}], 'facecolor', [c2(3,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "xticklabel", []);
set(gca, "yticklabel", []);
box on

title('\footnotesize \texttt{fm}')



s10 = subaxis(2,9,10, 'ML', 0.0, 'MR', 0.008, 'SH', 0.008, 'MB', 0.01, 'MT', 0); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{1}{2}{1}, percents{1}{2}{2}, percents{1}{2}{3}, percents{1}{2}{4}, percents{1}{2}{5}], 'k');
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100], "yticklabel", {'\\footnotesize $75\\%$','\\footnotesize $80\\%$','\\footnotesize $85\\%$','\\footnotesize $90\\%$', '\\footnotesize $95\\%$', '\\footnotesize $100\\%$'});
xlim([0.3,5.7])
ylim([73 100])
set(gca, "ylabel", "\\small $\\sigma_{\\bm{M}} = 0.05$ m");
box on

s11 = subaxis(2,9,11); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{2}{2}{1}, percents{2}{2}{2}, percents{2}{2}{3}, percents{2}{2}{4}, percents{2}{2}{5}], 'k');
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s12 = subaxis(2,9,12); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{3}{2}{1}, percents{3}{2}{2}, percents{3}{2}{3}, percents{3}{2}{4}, percents{3}{2}{5}], 'k');
hold on
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s13 = subaxis(2,9,13); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{4}{2}{1}, percents{4}{2}{2}, percents{4}{2}{3}, percents{4}{2}{4}, percents{4}{2}{5}], 'k');
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s14 = subaxis(2,9,14); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{5}{2}{1}, percents{5}{2}{2}, percents{5}{2}{3}, percents{5}{2}{4}, percents{5}{2}{5}], 'k');
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s15 = subaxis(2,9,15); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{6}{2}{1}, percents{6}{2}{2}, percents{6}{2}{3}, percents{6}{2}{4}, percents{6}{2}{5}], 'k');
% Manually increase by 30 in the .tex file
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s16 = subaxis(2,9,16); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{7}{2}{1}, percents{7}{2}{2}, percents{7}{2}{3}, percents{7}{2}{4}, percents{7}{2}{5}], 'facecolor', [c2(1,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s17 = subaxis(2,9,17); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{8}{2}{1}, percents{8}{2}{2}, percents{8}{2}{3}, percents{8}{2}{4}, percents{8}{2}{5}], 'facecolor', [c2(2,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on

s18 = subaxis(2,9,18); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(100*[percents{9}{2}{1}, percents{9}{2}{2}, percents{9}{2}{3}, percents{9}{2}{4}, percents{9}{2}{5}], 'facecolor', [c2(3,:)]);
set(gca(), "xtick", xtick, "xticklabel", {'\\scriptsize $1$', '\\scriptsize $3$', '\\scriptsize $5$', '\\scriptsize $10$', '\\scriptsize $20$'});
set(gca(), "ytick", [75 80 85 90 95 100]);
xlim([0.3,5.7])
ylim([73 100])
set(gca, "yticklabel", []);
box on


% Manually increase by 30 in the .tex file
xlabel('Τυπική απόκλιση διαταραχών $\sigma_R$ [cm]')



if store
  img_file = strcat(pwd, '/pose_improvement_percent.eps');
  drawnow ("epslatex", img_file, '');
end
