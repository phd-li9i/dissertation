print_dir = '/media/li9i/elements/PhD/dissertation/figures_production/0.road_map/';

m = importdata('willowgarage_map.csv');


N = 400;
p = 60*rand(2,N) + [40;30];

t = [55,65]
scatter(m(:,1), m(:,2))
hold on
scatter(p(1,:), p(2,:))
scatter(t(1), t(2))

% add padding to the rest
pp = repmat(p',[],20);
pp = pp (1:size(m,1),:);
tt = repmat(t,[],size(m,1));

a = [m, pp, tt];


csvwrite (strcat(print_dir,'all_h.csv'), a);
