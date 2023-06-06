function [x,y] = function_project(s,p)

  x = [];
  y = [];

  for i=0:numel(s)-1
    x = [x; p(1) + s(i+1)*cos(2*pi*i/numel(s) + p(3) - pi)];
    y = [y; p(2) + s(i+1)*sin(2*pi*i/numel(s) + p(3) - pi)];
  end

end
