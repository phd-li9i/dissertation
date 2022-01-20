function sim = function_organise_data2(dir, num)
  logs_dir = '/media/li9i/elements/PhD/dissertation/figures_production/0.road_map/data/intel_8730';

  here = pwd;

  cd(logs_dir);
  cd(dir);

  % Get initial configuration (ranges, poses)
  eval('scan_dump_init');
  eval('range_scan_dump_init');

  init = {rr, r00, vr, v00};

  angles = [rt];

  clear('range_scan_dump_init');
  clear('scan_dump_init')

  % Get rotation and translation ranges
  virtual_ranges_rot = [];
  virtual_ranges_trans = [];

  for i=1:num
    range_scans_rot_str = strcat('range_scan_dump_rot_', num2str(i));
    eval(range_scans_rot_str);
    virtual_ranges_rot = [virtual_ranges_rot; vr];
    clear(range_scans_rot_str)

    range_scans_trans_str = strcat('range_scan_dump_trans_', num2str(i));
    eval(range_scans_trans_str);
    virtual_ranges_trans = [virtual_ranges_trans; vr];
    real_ranges = rr;
    init{1} = real_ranges;
    clear(range_scans_trans_str)
  end


  % Get rotation and translation ranges pose estimates
  virtual_poses = [];
  pose_errors = [];

  pose_error = init{2} - init{4};
  d = sqrt(sum(pose_error .* pose_error,2));
  pose_errors = [pose_errors, d];

  for i=1:num
    scans_str = strcat('scan_dump_rot_', num2str(i));
    eval(scans_str);
    virtual_poses = [virtual_poses; v00];
    clear(scans_str)

    pose_error = virtual_poses(end,:)-init{2};
    d = sqrt(sum(pose_error .* pose_error,2));
    pose_errors = [pose_errors, d];

    scans_str = strcat('scan_dump_trans_', num2str(i));
    eval(scans_str);
    virtual_poses = [virtual_poses; v00];
    clear(scans_str)

    pose_error = virtual_poses(end,:)-init{2};
    d = sqrt(sum(pose_error .* pose_error,2));
    pose_errors = [pose_errors, d];
  end

  % Save map
  map_str = 'map_dump';
  eval(map_str);
  M = [mx;my];
  clear(map_str);




  cd(here);

  c = [];
  caer0 = caer(init{1}, init{3});
  c = [c, caer0];

  % Real scan in cartesian coordinates
  [xr,yr] = p2c(angles, init{1}, [0,0,0]);
  init{1} = [xr;yr];

  [xr,yr] = p2c(angles, init{3}, [0,0,0]);
  init{3} = [xr;yr];

  virtual_scan_coo = {};

  for i = 1:num
    [xv,yv] = p2c(angles, virtual_ranges_rot(i,:), [0,0,0]);
    virtual_scan_coo{end+1} = [xv;yv];
    c = [c, caer(real_ranges, virtual_ranges_rot(i,:))];

    [xv,yv] = p2c(angles, virtual_ranges_trans(i,:), [0,0,0]);
    virtual_scan_coo{end+1} = [xv;yv];
    c = [c, caer(real_ranges, virtual_ranges_trans(i,:))];
  end

  sim = {init, virtual_scan_coo, virtual_poses, pose_errors, c, M};

end
