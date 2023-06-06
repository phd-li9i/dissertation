print_dir = '/media/li9i/elements/PhD/dissertation/figures_production/0.road_map/';

N = 100;
p = stdnormal_rnd(2,N);

p_dists = norm(p, 1, 'columns');

p_dists_idx = p_dists < 0.5;

p_best = p(:,p_dists_idx);

%close all
%scatter(p(1,:), p(2,:));
%hold on
%scatter(p_best(1,:), p_best(2,:),'filled');
%axis equal

a = [p(1,:)', p(2,:)', [p_best(1,:)'; zeros(N-size(p_best,2),1)], [p_best(2,:)'; zeros(N-size(p_best,2),1)]];


csvwrite (strcat(print_dir,'all_p.csv'), a);
