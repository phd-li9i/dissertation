clear all;
close all;

store = true;


if store
  graphics_toolkit("gnuplot")
end

print_dir = pwd;

mats_exist = false;

if exist('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/c_cross_data/final_minus_initial_error') == 2 && ...
   exist('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/c_cross_data/initial_orientation_errors_comb') == 2
  mats_exist = true;
end

if (~mats_exist)
  disp('run c_.m and d_.m first and copy matrices to c_cross_data')
else
  load('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/c_cross_data/final_minus_initial_error');
  load('/media/li9i/var2/elements/PhD/fourier_scan_to_map_scan_matcher/struct/scripts_phd/experiments/improvement_percent/c_cross_data/initial_orientation_errors_comb');
end


edges = 0:0.01:0.79;
percents = {};
for a = 1:size(final_minus_initial_error,2)              % num algorithms
  for sm = 1:size(final_minus_initial_error{a},2)        % num map noises
    for sr = 1:size(final_minus_initial_error{a}{sm},2)  % num scan noises
      bins_init = interp1 (edges, 1:numel(edges), initial_orientation_errors_comb{a}{sm}{sr}, 'previous');

      percents{a}{sm}{sr} = [];
      for b = 1:numel(edges)
        bin_b_ids = find(bins_init == b);
        num_improved_in_bin_b =  nnz(final_minus_initial_error{a}{sm}{sr}(bin_b_ids) < 0);

        % protect against nans
        if ~isnan(num_improved_in_bin_b / numel(bin_b_ids))
          percents{a}{sm}{sr} = [percents{a}{sm}{sr}, num_improved_in_bin_b / numel(bin_b_ids)];
        end
      end
    end
  end
end


% smoothed percents
sp = 17;
percents_s = {};
for a = 1:size(percents,2)              % num algorithms
  for sm = 1:size(percents{a},2)        % num map noises
    for sr = 1:size(percents{a}{sm},2)  % num scan noises
      percents_s{a}{sm}{sr} = smooth(percents{a}{sm}{sr},sp);
    end
  end
end

percents = percents_s;

%\definecolor{c1}{rgb}{0.00000   0.44700   0.74100}
%\definecolor{c2}{rgb}{0.85000   0.32500   0.09800}
%\definecolor{c3}{rgb}{0.46600   0.67400   0.18800}
%\definecolor{c4}{rgb}{0.49400   0.18400   0.55600}
%\definecolor{c5}{rgb}{0.46600   0.67400   0.18800}
%\definecolor{c6}{rgb}{0.30100   0.74500   0.93300}
%\definecolor{c7}{RGB}{255, 197, 0}
%\definecolor{c8}{RGB}{178,204,227}
%\definecolor{c9}{RGB}{255, 0, 255}
      %\put(3999,6200){\makebox(0,0){\strut{}\footnotesize Ποσοστά επίτευξης στόχου Σ1}}%
      %\put(3999,5900){\makebox(0,0){\strut{}\footnotesize ως προς θέση ανά μονάδα αρχικού σφάλματος εκτίμησης προσανατολισμού $|\Delta\hat{\theta}|$}}%
      %\put(0,5400){\makebox(0,0){\strut{}{\color{c1}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize PLICP}}
      %\put(1500,5400){\makebox(0,0){\strut{}{\color{c2}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize NDT}}
      %\put(3000,5400){\makebox(0,0){\strut{}{\color{c3}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize GICP}}
      %\put(4500,5400){\makebox(0,0){\strut{}{\color{c4}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize VGICP}}
      %\put(6000,5400){\makebox(0,0){\strut{}{\color{c7}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize \texttt{x1}}}
      %\put(7500,5400){\makebox(0,0){\strut{}{\color{c8}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize \texttt{uf}}}
      %\put(8800,5400){\makebox(0,0){\strut{}{\color{c9}{\rule[0.6mm]{0.5cm}{0.5mm}}}\scriptsize \texttt{fm}}}
      %\put(3999,-750){\makebox(0,0){\strut{}\footnotesize Αρχικό σφάλμα εκτίμησης προσανατολισμού $|\Delta \hat{\theta}|$ [rad]}}%


% H1: plot in curves
linewidth = 4;
c = function_get_nine_colours();
c1 = c(1:6,:);
c1(3,:) = c(5,:);
c2 = [255, 197, 0;
      178,204,227;
      255, 0, 255]/255;

xlim_ = [1,79];
ylim_ = [40 102];

xtick_ = [1 100*pi/16 100*pi/8 100*pi/4];
ytick_ = [40 60 80 100];

h = figure(1);
set(h,'position',[1 1 400 240]);

s1 = subaxis(2,5,1, 'ML', 0.01, 'MR', 0.01, 'MT', 0.01, 'MB', 0.01, 'SH', 0.01, 'SV', 0.02); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{1}{1}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{1}{1}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{1}{1}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{1}{1}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{1}{1}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{1}{1}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{1}{1}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{1}{1}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{1}{1}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_)
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'','','','',''});
set(gca(), "ytick", ytick_, "yticklabel", {'\\small $40\\%$','\\small $60\\%$', '\\small $80\\%$', '\\small $100\\%$'});
ylabel('$\sigma_{\bm{M}} = 0.0$ m')
title('\scriptsize $\sigma_R = 0.01$ m')

s2 = subaxis(2,5,2); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{1}{2}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{1}{2}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{1}{2}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{1}{2}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{1}{2}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{1}{2}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{1}{2}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{1}{2}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{1}{2}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_)
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'','','','',''});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});
title('\scriptsize $\sigma_R = 0.03$ m')

s3 = subaxis(2,5,3); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{1}{3}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{1}{3}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{1}{3}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{1}{3}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{1}{3}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{1}{3}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{1}{3}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{1}{3}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{1}{3}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_)
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'','','','',''});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});
title('\scriptsize $\sigma_R = 0.05$ m')

s4 = subaxis(2,5,4); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{1}{4}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{1}{4}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{1}{4}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{1}{4}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{1}{4}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{1}{4}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{1}{4}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{1}{4}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{1}{4}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_)
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'','','','',''});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});
title('\scriptsize $\sigma_R = 0.10$ m')

s5 = subaxis(2,5,5); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{1}{5}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{1}{5}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{1}{5}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{1}{5}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{1}{5}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{1}{5}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{1}{5}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{1}{5}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{1}{5}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'','','','',''});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});
title('\scriptsize $\sigma_R = 0.20$ m')





s6 = subaxis(2,5,6, 'ML', 0.01, 'MR', 0.01, 'MT', 0.01, 'MB', 0.01, 'SH', 0.01, 'SV', 0.02); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{2}{1}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{2}{1}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{2}{1}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{2}{1}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{2}{1}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{2}{1}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{2}{1}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{2}{1}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{2}{1}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'\\small $0.0$', '\\small $\\frac{pi}{16}$','\\small $\\frac{pi}{8}$','\\small $\\frac{pi}{4}$'});
set(gca(), "ytick", ytick_, "yticklabel", {'\\small $40\\%$','\\small $60\\%$', '\\small $80\\%$', '\\small $100\\%$'});
ylabel('$\sigma_{\bm{M}} = 0.05$ m')

s7 = subaxis(2,5,7); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{2}{2}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{2}{2}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{2}{2}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{2}{2}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{2}{2}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{2}{2}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{2}{2}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{2}{2}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{2}{2}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'\\small $0.0$', '\\small $\\frac{pi}{16}$','\\small $\\frac{pi}{8}$','\\small $\\frac{pi}{4}$'});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});


s8 = subaxis(2,5,8); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{2}{3}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{2}{3}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{2}{3}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{2}{3}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{2}{3}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{2}{3}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{2}{3}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{2}{3}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{2}{3}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on


xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'\\small $0.0$', '\\small $\\frac{pi}{16}$','\\small $\\frac{pi}{8}$','\\small $\\frac{pi}{4}$'});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});

s9 = subaxis(2,5,9); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{2}{4}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{2}{4}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{2}{4}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{2}{4}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{2}{4}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{2}{4}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{2}{4}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{2}{4}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{2}{4}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'\\small $0.0$', '\\small $\\frac{pi}{16}$','\\small $\\frac{pi}{8}$','\\small $\\frac{pi}{4}$'});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});

s10 = subaxis(2,5,10); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(100*percents{1}{2}{5}, 'color', [c1(1,:)], 'linewidth', linewidth);
plot(100*percents{2}{2}{5}, 'color', [c1(2,:)], 'linewidth', linewidth);
plot(100*percents{3}{2}{5}, 'color', [c1(3,:)], 'linewidth', linewidth);
plot(100*percents{4}{2}{5}, 'color', [c1(4,:)], 'linewidth', linewidth);
%plot(100*percents{5}{2}{5}, 'color', [c1(5,:)], 'linewidth', linewidth);
%plot(100*percents{6}{2}{5}, 'color', [c1(6,:)], 'linewidth', linewidth);
plot(100*percents{7}{2}{5}, 'color', [c2(1,:)], 'linewidth', linewidth);
plot(100*percents{8}{2}{5}, 'color', [c2(2,:)], 'linewidth', linewidth);
plot(100*percents{9}{2}{5}, 'color', [c2(3,:)], 'linewidth', linewidth);
box on

xlim(xlim_);
ylim(ylim_);
set(gca(), "xtick", xtick_, "xticklabel", {'\\small $0.0$', '\\small $\\frac{pi}{16}$','\\small $\\frac{pi}{8}$','\\small $\\frac{pi}{4}$'});
set(gca(), "ytick", ytick_, "yticklabel", {'','','',''});



if store
  img_file = strcat(print_dir, '/cross_position_improvement_percent_orientation_binned_curves.eps');
  drawnow ("epslatex", img_file, '');
end
