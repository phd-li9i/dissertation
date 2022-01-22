close all
clear all

years = 2009:1:2021;
pubs = [37, 149 ,394 ,862 ,1180 ,1580 ,1870 ,2490 ,3140 ,3770 ,4560 ,4840 ,4640];

c = cumsum(pubs);

k = 30;

figure(1, 'position', [1 1 11*k 6*k])
h = area(years, c, 'facecolor', 'k');
xlim([2009, 2021])
title ('Αριθμός δημοσιεύσεων που αναφέρουν το ROS (2009-2021)')


graphics_toolkit("gnuplot")
print_dir = pwd;
img_file = strcat(print_dir, '/ros_mentions.eps');
drawnow ("epslatex", img_file, strcat(img_file,'.gp'));
