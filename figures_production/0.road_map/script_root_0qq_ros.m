clear all;
close all;

pkg load geometry

store = true;

if store
  graphics_toolkit("gnuplot")
end

print_dir = '/media/li9i/elements/PhD/dissertation/figures_production/0.road_map/';


sim = function_organise_data2('sr5_sm0', 20);

csvwrite (strcat(print_dir,'ranges.csv'), ...
  [sim{1}{1}(1,:)', sim{1}{1}(2,:)', ...
   sim{2}{1}(1,:)', sim{2}{1}(2,:)', ...
   sim{2}{40}(1,:)', sim{2}{40}(2,:)'])
