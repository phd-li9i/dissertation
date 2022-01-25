close all
clear all

p = [19, 26, 55];
pr = {'Απαχθέν ρομπότ', 'Βάσει καθολικής αβεβαιότητας', 'Βάσει περιορισμένης αβεβαιότητας'};

figure(1, 'position', [1 1 300 300]);
pie(p)
axis equal
h = legend(pr, 'location', 'northoutside')
legend boxoff
set (h, "fontsize", 16);


graphics_toolkit("gnuplot")
print_dir = pwd;
img_file = strcat(print_dir, '/localisation_problems_pie.eps');
drawnow ("epslatex", img_file, strcat(img_file,'.gp'));
