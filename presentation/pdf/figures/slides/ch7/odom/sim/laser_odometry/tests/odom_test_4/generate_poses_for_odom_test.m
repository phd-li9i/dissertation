x = [...
  -1.617694,...
  -1.577549,...
  -1.537404,...
  -1.437042,...
  -1.336679,...
  -1.316607,...
  -1.216244,...
  -1.135954,...
  -1.135954,...
  -1.055664,...
  -0.955302,...
  -0.875012,...
  -0.754577,...
  -0.734504,...
  -0.614069,...
  -0.533779,...
  -0.493634,...
  -0.473562,...
  -0.393272,...
  -0.312982,...
  -0.252764,...
  -0.212619,...
  -0.172474,...
  -0.052039,...
   0.088469,...
   0.168759,...
   0.249049,...
   0.369484,...
   0.509991,...
   0.670571,...
   0.811079,...
   0.871296,...
   0.971659,...
   1.031876,...
   1.112166,...
   1.192456,...
   1.272746,...
   1.373109,...
   1.453399,...
   1.553761,...
   1.593906,...
   1.694269,...
   1.734414,...
   1.814704,...
   1.935139,...
   2.015429,...
   2.135864,...
   2.196082,...
   2.296444,...
   2.457024,...
   2.617604,...
   2.858474,...
   2.978909,...
   3.219779,...
   3.279997,...
   3.420504,...
   3.681447,...
   3.842027,...
   3.982534,...
   4.09626,...
   4.52963,...
   4.73187,...
   4.73187,...
   4.84743,...
   4.90522,...
   4.90522,...
   4.90522,...
   4.90522,...
   4.96300,...
   5.28080,...
   5.48304,...
   5.51193,...
   5.51193,...
   5.51193,...
   5.51193,...
   5.51193,...
   5.51193,...
   5.30969,...
   5.22302,...
   5.267175,...
   5.186885,...
   5.146740,...
   5.146740,...
   4.885797,...
   4.825580,...
   4.644927,...
   4.644927,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.604782,...
   4.524492,...
   4.383985,...
   4.303695,...
   4.143115,...
   4.143115,...
   3.842027,...
   3.801882,...
   3.661374,...
   3.540939,...
   3.360287,...
   3.340214,...
   3.159562,...
   3.079272,...
   2.998982,...
   2.998982,...
   2.838402,...
   2.838402,...
   2.838402,...
   2.798257,...
   2.758112,...
   2.758112,...
   2.697894,...
   2.677822,...
   2.677822,...
   2.657749,...
   2.657749,...
   2.657749,...
   2.717967,...
   2.717967,...
   2.717967,...
   2.858474,...
   2.858474,...
   2.978909,...
   3.019054,...
   3.059199,...
   3.139489,...
   3.179634,...
   3.340214,...
   3.420504,...
   3.460649,...
   3.561012,...
   3.601157,...
   3.701519,...
   3.761737,...
   3.821954,...
   3.862099];

   y = [...
   6.6865,...
   6.6865,...
   6.7267,...
   6.7869,...
   6.8471,...
   6.8672,...
   6.9274,...
   6.9274,...
   6.9274,...
   6.9475,...
   6.9475,...
   6.9876,...
   7.0478,...
   7.0478,...
   7.1081,...
   7.1683,...
   7.2285,...
   7.2686,...
   7.3489,...
   7.4091,...
   7.4493,...
   7.5095,...
   7.5496,...
   7.6299,...
   7.7303,...
   7.7905,...
   7.9110,...
   8.0916,...
   8.2522,...
   8.3726,...
   8.4328,...
   8.4328,...
   8.4328,...
   8.4328,...
   8.4328,...
   8.4328,...
   8.4128,...
   8.3525,...
   8.3325,...
   8.2321,...
   8.1920,...
   8.0916,...
   8.0314,...
   7.8720,...
   7.8909,...
   7.8307,...
   7.7504,...
   7.7303,...
   7.7303,...
   7.7303,...
   7.7504,...
   7.7905,...
   7.8708,...
   7.8708,...
   7.9110,...
   7.9110,...
   7.9712,...
   8.0314,...
   8.0314,...
   8.0314,...
   7.9587,...
   8.0743,...
   8.1032,...
   8.2187,...
   8.3921,...
   8.4499,...
   8.7677,...
   8.7677,...
   8.9988,...
   9.2299,...
   9.5766,...
   9.8655,...
   10.2122,...
   10.5300,...
   10.8767,...
   11.1079,...
   11.1079,...
   11.5412,...
   11.8590,...
   12.0459,...
   12.2065,...
   12.2265,...
   12.2466,...
   12.4072,...
   12.4674,...
   12.6882,...
   12.6882,...
   12.8086,...
   12.9893,...
   13.2302,...
   13.4309,...
   13.5915,...
   13.8123,...
   14.0331,...
   14.2739,...
   14.4947,...
   14.6955,...
   14.7557,...
   14.8560,...
   14.8560,...
   15.0166,...
   15.0367,...
   15.0367,...
   15.0367,...
   15.0367,...
   15.0367,...
   15.0367,...
   15.0367,...
   15.0166,...
   15.0166,...
   14.8962,...
   14.8962,...
   14.8560,...
   14.6955,...
   14.5750,...
   14.4947,...
   14.2539,...
   14.2137,...
   14.2137,...
   13.9327,...
   13.9327,...
   13.9327,...
   13.6918,...
   13.6918,...
   13.5915,...
   13.3506,...
   13.3305,...
   13.1499,...
   13.0696,...
   12.9692,...
   12.8086,...
   12.6882,...
   12.5076,...
   12.4273,...
   12.3470,...
   12.1864,...
   12.0660,...
   11.9857,...
   11.7247,...
   11.5641,...
   11.4638
   ];

   % The trajectory
   path = [x;y];

   % Get the orientations
   diff_x = gradient(path(1,:));
   diff_y = gradient(path(2,:));

   t = atan2(diff_y,diff_x);

   for i=1:size(t,2)
     if abs(t(i)) == pi/2
       t(i) = t(i)- pi/20;
  end
end

t(end+1) = t(end);
t = t(2:end);

trj = [path; t];

% Paste the following into
% /media/li9i/elements/PhD/fourier_scan_matcher/struct/odom_test/src/s2msm.cpp:getRealTrajectory

%printf('std::vector< std::tuple<double,double,double> > virtual_poses;\n');
%printf('std::vector< std::tuple<double,double,double> > real_poses;\n');
%printf('std::tuple<double,double,double> virtual_pose;\n');
%printf('std::tuple<double,double,double> real_pose;\n');

%for i=1:size(trj,2)-1
%printf('//-------------------------------------------------\n')
%printf('// Pose no. %d/%d\n', i, size(trj,2)-1);
%printf('std::get<0>(virtual_pose) = %f;\n', trj(1,i));
%printf('std::get<1>(virtual_pose) = %f;\n', trj(2,i));
%printf('std::get<2>(virtual_pose) = %f;\n', trj(3,i));
%printf('std::get<0>(real_pose) = %f;\n', trj(1,i+1));
%printf('std::get<1>(real_pose) = %f;\n', trj(2,i+1));
%printf('std::get<2>(real_pose) = %f;\n', trj(3,i+1));
%printf('virtual_poses->push_back(virtual_pose);\n');
%printf('real_poses->push_back(real_pose);\n');
%end