function C = function_get_nine_colours()

  c1 = [0 0.4470 0.7410;        % PLICP
        0.8500 0.3250 0.0980;   % NDT
        0.9290 0.6940 0.1250;   % FastGICP
        0.4940 0.1840 0.5560;   % FastVGICP
        0.4660 0.6740 0.1880;   % NDT-PSO
        0.3010 0.7450 0.9330];  % TEASER

  c2 = [251,180,185;            % SKG
        247,104,161;            % DBH
        255,0,255]/255;         % FMT

  C = [c1; c2];
end
