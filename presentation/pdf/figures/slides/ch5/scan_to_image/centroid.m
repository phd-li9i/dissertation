function [xc,yc] = centroid(x,y)

  area = 0.5 * sum( (shift(x,-1)+x).*(shift(y,-1)-y) );

  xc = 1.0/(6*area) * sum( (shift(x,-1) + x).*(x.*shift(y,-1) - shift(x,-1).*y) );
  yc = 1.0/(6*area) * sum( (shift(y,-1) + y).*(x.*shift(y,-1) - shift(x,-1).*y) );

end
