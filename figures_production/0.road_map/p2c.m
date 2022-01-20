% Polar to cartesian
function [x,y] = p2c(t,r,p)
  x = [];
  y = [];
  for i = 1:size(r,2)
    xx = p(1) + r(i)*cos(p(3) + t(i));
    yy = p(2) + r(i)*sin(p(3) + t(i));

    x = [x xx];
    y = [y yy];
  end
end
