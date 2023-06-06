#include <s2msm.h>

/*******************************************************************************
*/
S2MSM::S2MSM()
{
  printf("[S2MSM] Starting with default params \n");

  // init params
  initParams(1, 1, 0, 778, 0.20, M_PI/4, 0.0, 0.0, 0.0, 0.0, 360, 180, "FMT");

  cacheFFTW3Plans(SIZE_REAL_SCAN);

  // init logs
#if defined (LOGS)
  initLogs();
#endif

  // Start tests
  performTests();
}


/*******************************************************************************
*/
S2MSM::S2MSM(
  const unsigned int& max_iterations,
  const unsigned int& num_iterations,
  const unsigned int& start_sample,
  const unsigned int& end_sample,
  const double& xy_uniform_displacement,
  const double& t_uniform_displacement,
  const double& sigma_noise_real,
  const double& sigma_noise_map,
  const double& invalid_rays_randomly_percent,
  const double& invalid_rays_sequentially_percent,
  const unsigned int& size_real_scan,
  const unsigned int& size_map,
  const std::string& method)
{
  printf("[S2MSM] Starting with custom params \n");

  // init params
  initParams(
    max_iterations,
    num_iterations,
    start_sample,
    end_sample,
    xy_uniform_displacement,
    t_uniform_displacement,
    sigma_noise_real,
    sigma_noise_map,
    invalid_rays_randomly_percent,
    invalid_rays_sequentially_percent,
    size_real_scan,
    size_map,
    method);

    cacheFFTW3Plans(SIZE_REAL_SCAN);


  // init logs
#if defined (LOGS)
  initLogs();
#endif

  // Start tests
  performTests();
}


/*******************************************************************************
*/
S2MSM::~S2MSM()
{
  printf("[S2MSM] Destroying S2MSM\n");
}


/*******************************************************************************
*/
void S2MSM::cacheFFTW3Plans(const unsigned int& sz)
{
  // Create forward  plan
  double* r2r_in;
  double* r2r_out;

  r2r_in = (double*) fftw_malloc(sz * sizeof(double));
  r2r_out = (double*) fftw_malloc(sz * sizeof(double));

  r2rp_ = fftw_plan_r2r_1d(sz, r2r_in, r2r_out, FFTW_R2HC, FFTW_MEASURE);

  // Create backward plan
  fftw_complex* c2r_in;
  double* c2r_out;

  c2r_in = (fftw_complex*) fftw_malloc(sz * sizeof(fftw_complex));
  c2r_out = (double*) fftw_malloc(sz * sizeof(double));

  c2rp_ = fftw_plan_dft_c2r_1d(sz, c2r_in, c2r_out, FFTW_MEASURE);
}


/*******************************************************************************
*/
  std::vector<double>
S2MSM::collectErrorBins(const std::vector<double>& errors)
{
  double b0 = 0.001;
  double b1 = 0.005;
  double b2 = 0.01;
  double b3 = 0.05;

  double num_below_b0 = 0;
  double num_below_b1 = 0;
  double num_below_b2 = 0;
  double num_below_b3 = 0;
  double num_above_b3 = 0;

  for (int i = 0; i < errors.size(); i++)
  {
    if (errors[i] <= b0)
      num_below_b0++;
    else if (errors[i] <= b1)
      num_below_b1++;
    else if (errors[i] <= b2)
      num_below_b2++;
    else if (errors[i] <= b3)
      num_below_b3++;
    else
      num_above_b3++;
  }

  std::vector<double> error_bins;
  error_bins.push_back(num_below_b0);
  error_bins.push_back(num_below_b1);
  error_bins.push_back(num_below_b2);
  error_bins.push_back(num_below_b3);
  error_bins.push_back(num_above_b3);

  return error_bins;
}


/*******************************************************************************
*/
double S2MSM::computePositionError(
  const std::tuple<double,double,double>& pose1,
  const std::tuple<double,double,double>& pose2)
{
  double dx = std::get<0>(pose1) - std::get<0>(pose2);
  double dy = std::get<1>(pose1) - std::get<1>(pose2);

  return sqrt(dx*dx + dy*dy);
}


/*******************************************************************************
*/
double S2MSM::computeOrientationError(
  const std::tuple<double,double,double>& pose1,
  const std::tuple<double,double,double>& pose2)
{
  double dt = std::get<2>(pose1) - std::get<2>(pose2);
  Utils::wrapAngle(&dt);

  return fabs(dt);
}

/*******************************************************************************
*/
double S2MSM::computePoseError(
  const std::tuple<double,double,double>& pose1,
  const std::tuple<double,double,double>& pose2)
{
  double dx = std::get<0>(pose1) - std::get<0>(pose2);
  double dy = std::get<1>(pose1) - std::get<1>(pose2);
  double dt = std::get<2>(pose1) - std::get<2>(pose2);
  Utils::wrapAngle(&dt);

  return sqrt(dx*dx + dy*dy + dt*dt);
}


/*******************************************************************************
*/
  void
S2MSM::corruptRanges(std::vector<double>* scan, const double& sigma)
{
  if (sigma > 0.0)
  {
    std::random_device rand_dev;
    std::mt19937 generator_n(rand_dev());

    std::normal_distribution<double> distribution_n(0.0, sigma);

    for (int i = 0; i < scan->size(); i++)
    {
      double n = 0.0;
      do
      {
        n = distribution_n(generator_n);
      } while (scan->at(i) + n < 0); // ranges should be non-negative

      scan->at(i) += n;
    }
  }
}


/*******************************************************************************
*/
  void
S2MSM::corruptMap(std::vector< std::pair<double,double> >* map,
  const double& sigma)
{
  if (sigma > 0.0)
  {
    std::random_device rand_dev_x;
    std::random_device rand_dev_y;
    std::mt19937 generator_x(rand_dev_x());
    std::mt19937 generator_y(rand_dev_y());

    std::normal_distribution<double> distribution_x(0.0, sigma);
    std::normal_distribution<double> distribution_y(0.0, sigma);

    for (int i = 0; i < map->size(); i++)
    {
      double dx = distribution_x(generator_x);
      map->at(i).first += dx;
      double dy = distribution_y(generator_y);
      map->at(i).second += dy;
    }
  }
}


/*******************************************************************************
*/
  void
S2MSM::doFinalReport(
  const std::vector< std::vector<double> >& errors_n,
  const std::vector< std::vector<int> >& iterations_n,
  const std::vector< std::vector<double> >& times_n,
  const std::vector< std::vector<double> >& intersections_times_n)
{
  printf("________________________________________________________________________\n");
  printf("Displacement uniform in (+/-%.2f,+/-%.2f,+/-%.3f)\n",
    XY_UNIFORM_DISPLACEMENT, XY_UNIFORM_DISPLACEMENT, T_UNIFORM_DISPLACEMENT);
  printf("________________________________________________________________________\n");
  printf("Noise acting on laser's range measurements: Normal with sigma = %f\n",
    SIGMA_NOISE_REAL);
  printf("Noise acting on map's range measurements: Normal with sigma = %f\n",
    SIGMA_NOISE_MAP);
  printf("Invalidated rays in random percentage = %f\n", INVALID_RAYS_RANDOMLY_PERCENT);
  printf("Invalidated rays in sequence percentage = %f\n", INVALID_RAYS_SEQUENTIALLY_PERCENT);
  printf("________________________________________________________________________\n");

  double b0 = 0.001;
  double b1 = 0.005;
  double b2 = 0.01;
  double b3 = 0.05;

  double num_below_b0 = 0;
  double num_below_b1 = 0;
  double num_below_b2 = 0;
  double num_below_b3 = 0;
  double num_above_b3 = 0;

  double mean_error = 0.0;
  double mean_iterations = 0.0;
  double mean_time = 0.0;
  double mean_intersections_time = 0.0;

  for (int i = 0; i < errors_n.size(); i++)
  {
    std::vector<double> error_bins = collectErrorBins(errors_n[i]);
    num_below_b0 += error_bins[0];
    num_below_b1 += error_bins[1];
    num_below_b2 += error_bins[2];
    num_below_b3 += error_bins[3];
    num_above_b3 += error_bins[4];

    for(int k = 0; k < errors_n[i].size(); k++)
    {
      mean_error += errors_n[i][k];
      mean_iterations += iterations_n[i][k];
      mean_time += times_n[i][k];
      mean_intersections_time += intersections_times_n[i][k];
    }
  }

  size_t denom = (errors_n.size() * errors_n[0].size());

  printf("Below %.3f: %f (%.0f/%zu)\n",
    b0, 100*num_below_b0 / denom, num_below_b0, denom);
  printf("Below %.3f: %f (%.0f/%zu)\n",
    b1, 100*num_below_b1 / denom, num_below_b1, denom);
  printf("Below %.3f: %f (%.0f/%zu)\n",
    b2, 100*num_below_b2 / denom, num_below_b2, denom);
  printf("Below %.3f: %f (%.0f/%zu)\n",
    b3, 100*num_below_b3 / denom, num_below_b3, denom);
  printf("Above %.3f: %f (%.0f/%zu)\n",
    b3, 100*num_above_b3 / denom, num_above_b3, denom);

  printf("_________________________________\n");
  printf("Final mean error: %f\n", mean_error / denom);
  printf("Final mean number of iterations: %f\n", mean_iterations / denom);
  printf("Final mean execution time: %f\n", mean_time / denom);
  printf("Final mean intersection-finding time: %f\n", mean_intersections_time / denom);
  printf("_________________________________\n");

#if defined (LOGS)
  std::ofstream statistics_file(statistics_filename_.c_str(), std::ios::app);
  if (statistics_file.is_open())
  {
    statistics_file << "Displacement uniform in ["
      << "+/-" << XY_UNIFORM_DISPLACEMENT << ","
      << "+/-" << XY_UNIFORM_DISPLACEMENT << ","
      << "[" << -T_UNIFORM_DISPLACEMENT << ","
      << T_UNIFORM_DISPLACEMENT <<
      "]]"<< std::endl;
    statistics_file << "Noise acting on laser's range measurements: Normal with sigma = "
      << SIGMA_NOISE_REAL << std::endl;
    statistics_file << "Noise acting on map's range measurements: Normal with sigma = "
      << SIGMA_NOISE_MAP << std::endl;
    statistics_file << "Invalidated rays randomly percentage = "
      << INVALID_RAYS_RANDOMLY_PERCENT << std::endl;
    statistics_file << "Invalidated rays sequentially percentage = "
      << INVALID_RAYS_SEQUENTIALLY_PERCENT << std::endl;
    statistics_file << "Below " << b0 << ": " << 100*num_below_b0 / denom
      << "(" << num_below_b0 << "/" << denom << ")" << std::endl;
    statistics_file << "Below " << b1 << ": " << 100*num_below_b1 / denom
      << "(" << num_below_b1 << "/" << denom << ")" << std::endl;
    statistics_file << "Below " << b2 << ": " << 100*num_below_b2 / denom
      << "(" << num_below_b2 << "/" << denom << ")" << std::endl;
    statistics_file << "Below " << b3 << ": " << 100*num_below_b3 / denom
      << "(" << num_below_b3 << "/" << denom << ")" << std::endl;
    statistics_file << "Above " << b3 << ": " << 100*num_above_b3 / denom
      << "(" << num_above_b3 << "/" << denom << ")" << std::endl;
    statistics_file << "Mean error: "
      << mean_error / denom << " m" << std::endl;
    statistics_file << "Mean number of iterations: "
      << mean_iterations / denom << std::endl;
    statistics_file << "Mean execution time: "
      << mean_time / denom << " sec" << std::endl;
    statistics_file.close();
  }
#endif
}


/*******************************************************************************
*/
  void
S2MSM::doOneReport(
  const std::vector<double>& errors,
  const std::vector<int>& iterations,
  const std::vector<double>& times)
{
  printf("__________________________________________________\n");
  printf("Displacement uniform in (+/-%.2f,+/-%.2f,+/-%.3f)\n",
    XY_UNIFORM_DISPLACEMENT, XY_UNIFORM_DISPLACEMENT, T_UNIFORM_DISPLACEMENT);
  printf("_________________________________\n");

  std::vector<double> error_bins = collectErrorBins(errors);

  size_t denom = (errors.size());

  double b0 = 0.001;
  double b1 = 0.005;
  double b2 = 0.01;
  double b3 = 0.05;

  printf("Below %.3f: %f (%.0f/%zu)\n",
    b0, 100*error_bins[0] / denom, error_bins[0], denom);

  if (error_bins[1] > 0)
  {
    printf("\033[0;31m");
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b1, 100*error_bins[1] / denom, error_bins[1], denom);
    printf("\033[0m");
  }
  else
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b1, 100*error_bins[1] / denom, error_bins[1], denom);

  if (error_bins[2] > 0)
  {
    printf("\033[0;31m");
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b2, 100*error_bins[2] / denom, error_bins[2], denom);
    printf("\033[0m");
  }
  else
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b2, 100*error_bins[2] / denom, error_bins[2], denom);

  if (error_bins[3] > 0)
  {
    printf("\033[0;31m");
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b3, 100*error_bins[3] / denom, error_bins[3], denom);
    printf("\033[0m");
  }
  else
    printf("Below %.3f: %f (%.0f/%zu)\n",
      b3, 100*error_bins[3] / denom, error_bins[3], denom);

  if (error_bins[4] > 0)
  {
    printf("\033[0;31m");
    printf("Above %.3f: %f (%.0f/%zu)\n",
      b3, 100*error_bins[4] / denom, error_bins[4], denom);
    printf("\033[0m");
  }
  else
    printf("Above %.3f: %f (%.0f/%zu)\n",
      b3, 100*error_bins[4] / denom, error_bins[4], denom);

  printf("_________________________________\n");
  printf("Mean error: %f\n",
    accumulate(errors.begin(), errors.end(), 0.0) / errors.size());
  printf("Mean number of iterations: %f\n",
    static_cast<double>(accumulate(iterations.begin(), iterations.end(), 0.0))
    / iterations.size());
  printf("Mean execution time: %f\n",
    accumulate(times.begin(), times.end(), 0.0) / times.size());
}


/*******************************************************************************
*/
  void
S2MSM::generateMapConfiguration(
  const std::tuple<double,double,double>& dataset_pose,
  const std::vector<double>& dataset_scan,
  const bool& do_artificial_360,
  const bool& generate_real_pose,
  std::vector< std::pair<double,double> >* map,
  std::vector<double>* real_scan,
  std::tuple<double,double,double>* real_pose,
  std::vector<double>* virtual_scan,
  std::tuple<double,double,double>* virtual_pose)
{
  map->clear();
  real_scan->clear();

  // CONSTRUCT MAP -------------------------------------------------------------
  // How to complete the scan if it doesn't range over 2π?
  if (do_artificial_360)
  {
    std::tuple<double,double,double> origin_of_generated_pose;
    std::tuple<double,double,double> map_origin;

    int completion_fashion = 4;
    if (completion_fashion != 5)
    {
      *real_scan = dataset_scan;
      ScanCompletion::completeScan(real_scan, completion_fashion);
      Utils::scan2points(*real_scan, dataset_pose, map);
      *real_pose = dataset_pose;
      origin_of_generated_pose = dataset_pose;
    }
    else
    {
      // The real scan in points in 2D, aka the map
      ScanCompletion::completeScan5(dataset_pose, dataset_scan,
        pow(2,0)*dataset_scan.size(), real_scan, map, &map_origin);
      *real_pose = map_origin;
      origin_of_generated_pose = map_origin;
    }

    *map = X::findExact(origin_of_generated_pose, *map, SIZE_MAP);
  }
  else // just impress the rays onto the plane over 2π
  {
    // 361-1 = 360
    std::vector<double> map_scan = dataset_scan;
    map_scan.erase(map_scan.begin() + map_scan.size()-1);

    Utils::scan2points(map_scan, dataset_pose, map);

    // This is the map
    *map = X::findExact(dataset_pose, *map, SIZE_MAP);
  }


  // GENERATE REAL POSE (perhaps, sir?) ----------------------------------------
  // Generate a new pose in the map or take that from the dataset
  if (generate_real_pose)
  {
    //while(!Utils::generatePose(dataset_pose, *map,
    //10*XY_UNIFORM_DISPLACEMENT, 0.0, 0.25,
    //real_pose));

    while(!Utils::generatePoseWithinMap(*map, 0.5, real_pose));

    // Limit precision
    // http://www.cplusplus.com/forum/general/222965/#msg1022316
    double f = pow(10, 6);
    std::get<0>(*real_pose) = ((int)(std::get<0>(*real_pose)*f))/f;
    std::get<1>(*real_pose) = ((int)(std::get<1>(*real_pose)*f))/f;
    std::get<2>(*real_pose) = ((int)(std::get<2>(*real_pose)*f))/f;

    // sample 193
    std::get<0>(*real_pose) = -1.66847;
    std::get<1>(*real_pose) = 9.42382;
    std::get<2>(*real_pose) = 0.696756;
  }
  else
    *real_pose = dataset_pose;

  // Set orientation to 0.0 for quick visual inspection of angular errors.
  // It doesn't matter anyway, this is an independent variable
  // TODO comment-out
  //std::get<2>(*real_pose) = 0.0;std::get<2>(dataset_pose);

  // GENERATE VIRTUAL POSE -----------------------------------------------------
  while(!Utils::generatePose(*real_pose, *map,
      XY_UNIFORM_DISPLACEMENT, T_UNIFORM_DISPLACEMENT, 0.25, virtual_pose));

  std::get<0>(*virtual_pose) = -0.939415;
  std::get<1>(*virtual_pose) =  8.52613;
  std::get<2>(*virtual_pose) = 0.89;

  std::vector< std::pair<double,double> > v_intersections =
    X::findExact(*virtual_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(v_intersections, *virtual_pose, virtual_scan);


  // New real pose means new real scan
  // COMPUTE REAL SCAN ---------------------------------------------------------
  std::vector< std::pair<double,double> > intersections =
    X::findExact(*real_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(intersections, *real_pose, real_scan);


  // move everything relative to the virtual pose, so that the virtual pose
  // is at (0,0,0)
  // start with the map
  for (unsigned int i = 0; i < map->size(); i++)
  {
    map->at(i).first -= std::get<0>(*virtual_pose);
    map->at(i).second -= std::get<1>(*virtual_pose);
  }

  for (unsigned int i = 0; i < map->size(); i++)
  {
    double dx = map->at(i).first * cos(-std::get<2>(*virtual_pose))
      - map->at(i).second * sin(-std::get<2>(*virtual_pose));
    double dy = map->at(i).first * sin(-std::get<2>(*virtual_pose))
      + map->at(i).second * cos(-std::get<2>(*virtual_pose));

    map->at(i).first = dx;
    map->at(i).second = dy;
  }


  std::get<0>(*real_pose) -= std::get<0>(*virtual_pose);
  std::get<1>(*real_pose) -= std::get<1>(*virtual_pose);

  double dx = std::get<0>(*real_pose) * cos(-std::get<2>(*virtual_pose))
    - std::get<1>(*real_pose) * sin(-std::get<2>(*virtual_pose));
  double dy = std::get<0>(*real_pose) * sin(-std::get<2>(*virtual_pose))
    + std::get<1>(*real_pose) * cos(-std::get<2>(*virtual_pose));

  std::get<0>(*real_pose) = dx;
  std::get<1>(*real_pose) = dy;

  std::get<2>(*real_pose) -= std::get<2>(*virtual_pose);
  Utils::wrapAngle(&std::get<2>(*real_pose));

  std::get<0>(*virtual_pose) = 0.0;
  std::get<1>(*virtual_pose) = 0.0;
  std::get<2>(*virtual_pose) = 0.0;


  intersections =
    X::findExact(*real_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(intersections, *real_pose, real_scan);

  v_intersections =
    X::findExact(*virtual_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(v_intersections, *virtual_pose, virtual_scan);




  Dump::map(*map, base_path_ + "/../scripts/map.m");
#if defined (STORE)
  std::vector< std::pair<double,double> > v_intersections =
    X::findExact(*virtual_pose, *map, real_scan->size());
  std::vector<double> virtual_scan;
  Utils::points2scan(v_intersections, *virtual_pose, &virtual_scan);

  Dump::map(*map, base_path_ + "/../matlab/map_dump.m");
  Dump::scan(*real_scan, *real_pose, virtual_scan, *virtual_pose,
    base_path_ + "/../matlab/scan_dump.m");
#endif
}

void S2MSM::generateScans(
  const std::tuple<double,double,double>& dataset_pose,
  const std::vector<double>& dataset_scan,
  const bool& do_artificial_360,
  const bool& generate_real_pose,
  std::vector< std::pair<double,double> >* map,
  const std::tuple<double,double,double>& real_pose,
  const std::tuple<double,double,double>& virtual_pose,
  std::vector<double>* real_scan,
  std::vector<double>* virtual_scan)
{
  map->clear();
  real_scan->clear();

  // CONSTRUCT MAP -------------------------------------------------------------
  // How to complete the scan if it doesn't range over 2π?
  if (do_artificial_360)
  {
    std::tuple<double,double,double> origin_of_generated_pose;
    std::tuple<double,double,double> map_origin;

    int completion_fashion = 4;
    if (completion_fashion != 5)
    {
      *real_scan = dataset_scan;
      ScanCompletion::completeScan(real_scan, completion_fashion);
      Utils::scan2points(*real_scan, dataset_pose, map);
      origin_of_generated_pose = dataset_pose;
    }
    else
    {
      // The real scan in points in 2D, aka the map
      ScanCompletion::completeScan5(dataset_pose, dataset_scan,
        pow(2,0)*dataset_scan.size(), real_scan, map, &map_origin);
      origin_of_generated_pose = map_origin;
    }

    *map = X::findExact(origin_of_generated_pose, *map, SIZE_MAP);
  }
  else // just impress the rays onto the plane over 2π
  {
    // 361-1 = 360
    std::vector<double> map_scan = dataset_scan;
    map_scan.erase(map_scan.begin() + map_scan.size()-1);

    Utils::scan2points(map_scan, dataset_pose, map);

    // This is the map
    *map = X::findExact(dataset_pose, *map, SIZE_MAP);
  }


  // COMPUTE VIRTUAL SCAN (S0) -------------------------------------------------
  std::vector< std::pair<double,double> > v_intersections =
    X::findExact(virtual_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(v_intersections, virtual_pose, virtual_scan);


  // COMPUTE REAL SCAN (S1) ----------------------------------------------------
  std::vector< std::pair<double,double> > intersections =
    X::findExact(real_pose, *map, SIZE_REAL_SCAN);
  Utils::points2scan(intersections, real_pose, real_scan);



#if defined (STORE)
  Dump::map(*map, base_path_ + "/../scripts/map.m");
#endif
}


/*******************************************************************************
*/
void S2MSM::getRealTrajectory(
  std::vector< std::tuple<double,double,double> >* real_poses,
  std::vector< std::tuple<double,double,double> >* virtual_poses)
{
  // conf 6
  std::tuple<double,double,double> virtual_pose;
  std::tuple<double,double,double> real_pose;
  //-------------------------------------------------
  // Pose no. 1/59
  std::get<0>(virtual_pose) = -1.778274;
  std::get<1>(virtual_pose) = 6.566100;
  std::get<2>(virtual_pose) = 0.436607;
  std::get<0>(real_pose) = -1.517332;
  std::get<1>(real_pose) = 6.666500;
  std::get<2>(real_pose) = 0.587996;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 2/59
  std::get<0>(virtual_pose) = -1.517332;
  std::get<1>(virtual_pose) = 6.666500;
  std::get<2>(virtual_pose) = 0.587996;
  std::get<0>(real_pose) = -1.176099;
  std::get<1>(real_pose) = 6.847100;
  std::get<2>(real_pose) = 1.094363;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 3/59
  std::get<0>(virtual_pose) = -1.176099;
  std::get<1>(virtual_pose) = 6.847100;
  std::get<2>(virtual_pose) = 1.094363;
  std::get<0>(real_pose) = -0.975374;
  std::get<1>(real_pose) = 7.027800;
  std::get<2>(real_pose) = 1.425474;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 4/59
  std::get<0>(virtual_pose) = -0.975374;
  std::get<1>(virtual_pose) = 7.027800;
  std::get<2>(virtual_pose) = 1.425474;
  std::get<0>(real_pose) = -0.854939;
  std::get<1>(real_pose) = 7.469400;
  std::get<2>(real_pose) = 1.911800;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 5/59
  std::get<0>(virtual_pose) = -0.854939;
  std::get<1>(virtual_pose) = 7.469400;
  std::get<2>(virtual_pose) = 1.911800;
  std::get<0>(real_pose) = -0.854939;
  std::get<1>(real_pose) = 7.850700;
  std::get<2>(real_pose) = 2.234808;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 6/59
  std::get<0>(virtual_pose) = -0.854939;
  std::get<1>(virtual_pose) = 7.850700;
  std::get<2>(virtual_pose) = 2.234808;
  std::get<0>(real_pose) = -1.075737;
  std::get<1>(real_pose) = 8.091600;
  std::get<2>(real_pose) = 1.925476;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 7/59
  std::get<0>(virtual_pose) = -1.075737;
  std::get<1>(virtual_pose) = 8.091600;
  std::get<2>(virtual_pose) = 1.925476;
  std::get<0>(real_pose) = -1.216244;
  std::get<1>(real_pose) = 8.312400;
  std::get<2>(real_pose) = 1.460149;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 8/59
  std::get<0>(virtual_pose) = -1.216244;
  std::get<1>(virtual_pose) = 8.312400;
  std::get<2>(virtual_pose) = 1.460149;
  std::get<0>(real_pose) = -1.276462;
  std::get<1>(real_pose) = 8.633600;
  std::get<2>(real_pose) = 0.628756;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 9/59
  std::get<0>(virtual_pose) = -1.276462;
  std::get<1>(virtual_pose) = 8.633600;
  std::get<2>(virtual_pose) = 0.628756;
  std::get<0>(real_pose) = -1.156027;
  std::get<1>(real_pose) = 8.854400;
  std::get<2>(real_pose) = 0.280760;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 10/59
  std::get<0>(virtual_pose) = -1.156027;
  std::get<1>(virtual_pose) = 8.854400;
  std::get<2>(virtual_pose) = 0.280760;
  std::get<0>(real_pose) = -0.614069;
  std::get<1>(real_pose) = 9.115300;
  std::get<2>(real_pose) = -0.281189;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 11/59
  std::get<0>(virtual_pose) = -0.614069;
  std::get<1>(virtual_pose) = 9.115300;
  std::get<2>(virtual_pose) = -0.281189;
  std::get<0>(real_pose) = -0.112257;
  std::get<1>(real_pose) = 9.155400;
  std::get<2>(real_pose) = -0.654503;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 12/59
  std::get<0>(virtual_pose) = -0.112257;
  std::get<1>(virtual_pose) = 9.155400;
  std::get<2>(virtual_pose) = -0.654503;
  std::get<0>(real_pose) = 0.289194;
  std::get<1>(real_pose) = 8.854400;
  std::get<2>(real_pose) = -0.651867;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 13/59
  std::get<0>(virtual_pose) = 0.289194;
  std::get<1>(virtual_pose) = 8.854400;
  std::get<2>(virtual_pose) = -0.651867;
  std::get<0>(real_pose) = 0.750861;
  std::get<1>(real_pose) = 8.493100;
  std::get<2>(real_pose) = -0.504939;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 14/59
  std::get<0>(virtual_pose) = 0.750861;
  std::get<1>(virtual_pose) = 8.493100;
  std::get<2>(virtual_pose) = -0.504939;
  std::get<0>(real_pose) = 1.051949;
  std::get<1>(real_pose) = 8.272300;
  std::get<2>(real_pose) = -0.204644;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 15/59
  std::get<0>(virtual_pose) = 1.051949;
  std::get<1>(virtual_pose) = 8.272300;
  std::get<2>(virtual_pose) = -0.204644;
  std::get<0>(real_pose) = 1.513616;
  std::get<1>(real_pose) = 8.071500;
  std::get<2>(real_pose) = -0.022641;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 16/59
  std::get<0>(virtual_pose) = 1.513616;
  std::get<1>(virtual_pose) = 8.071500;
  std::get<2>(virtual_pose) = -0.022641;
  std::get<0>(real_pose) = 2.115792;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 17/59
  std::get<0>(virtual_pose) = 2.115792;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.396807;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 18/59
  std::get<0>(virtual_pose) = 2.396807;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.958837;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 19/59
  std::get<0>(virtual_pose) = 2.958837;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 3.460649;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.022138;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 20/59
  std::get<0>(virtual_pose) = 3.460649;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.022138;
  std::get<0>(real_pose) = 4.002607;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.141810;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 21/59
  std::get<0>(virtual_pose) = 4.002607;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.141810;
  std::get<0>(real_pose) = 4.363912;
  std::get<1>(real_pose) = 8.071500;
  std::get<2>(real_pose) = 0.311075;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 22/59
  std::get<0>(virtual_pose) = 4.363912;
  std::get<1>(virtual_pose) = 8.071500;
  std::get<2>(virtual_pose) = 0.311075;
  std::get<0>(real_pose) = 4.705145;
  std::get<1>(real_pose) = 8.151800;
  std::get<2>(real_pose) = 0.446110;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 23/59
  std::get<0>(virtual_pose) = 4.705145;
  std::get<1>(virtual_pose) = 8.151800;
  std::get<2>(virtual_pose) = 0.446110;
  std::get<0>(real_pose) = 4.925942;
  std::get<1>(real_pose) = 8.252200;
  std::get<2>(real_pose) = 0.502848;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 24/59
  std::get<0>(virtual_pose) = 4.925942;
  std::get<1>(virtual_pose) = 8.252200;
  std::get<2>(virtual_pose) = 0.502848;
  std::get<0>(real_pose) = 5.166812;
  std::get<1>(real_pose) = 8.372600;
  std::get<2>(real_pose) = 1.071454;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 25/59
  std::get<0>(virtual_pose) = 5.166812;
  std::get<1>(virtual_pose) = 8.372600;
  std::get<2>(virtual_pose) = 1.071454;
  std::get<0>(real_pose) = 5.327392;
  std::get<1>(real_pose) = 8.473000;
  std::get<2>(real_pose) = 1.633217;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 26/59
  std::get<0>(virtual_pose) = 5.327392;
  std::get<1>(virtual_pose) = 8.473000;
  std::get<2>(virtual_pose) = 1.633217;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 8.814200;
  std::get<2>(real_pose) = 2.332937;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 27/59
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 8.814200;
  std::get<2>(virtual_pose) = 2.332937;
  std::get<0>(real_pose) = 5.287247;
  std::get<1>(real_pose) = 9.115300;
  std::get<2>(real_pose) = 2.461117;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 28/59
  std::get<0>(virtual_pose) = 5.287247;
  std::get<1>(virtual_pose) = 9.115300;
  std::get<2>(virtual_pose) = 2.461117;
  std::get<0>(real_pose) = 4.986160;
  std::get<1>(real_pose) = 9.255800;
  std::get<2>(real_pose) = 1.606498;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 29/59
  std::get<0>(virtual_pose) = 4.986160;
  std::get<1>(virtual_pose) = 9.255800;
  std::get<2>(virtual_pose) = 1.606498;
  std::get<0>(real_pose) = 4.865725;
  std::get<1>(real_pose) = 9.456500;
  std::get<2>(real_pose) = 1.119348;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 30/59
  std::get<0>(virtual_pose) = 4.865725;
  std::get<1>(virtual_pose) = 9.456500;
  std::get<2>(virtual_pose) = 1.119348;
  std::get<0>(real_pose) = 4.966087;
  std::get<1>(real_pose) = 9.817800;
  std::get<2>(real_pose) = 0.974654;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 31/59
  std::get<0>(virtual_pose) = 4.966087;
  std::get<1>(virtual_pose) = 9.817800;
  std::get<2>(virtual_pose) = 0.974654;
  std::get<0>(real_pose) = 5.186885;
  std::get<1>(real_pose) = 10.118900;
  std::get<2>(real_pose) = 1.312039;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 32/59
  std::get<0>(virtual_pose) = 5.186885;
  std::get<1>(virtual_pose) = 10.118900;
  std::get<2>(virtual_pose) = 1.312039;
  std::get<0>(real_pose) = 5.347465;
  std::get<1>(real_pose) = 10.379900;
  std::get<2>(real_pose) = 1.499486;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 33/59
  std::get<0>(virtual_pose) = 5.347465;
  std::get<1>(virtual_pose) = 10.379900;
  std::get<2>(virtual_pose) = 1.499486;
  std::get<0>(real_pose) = 5.367537;
  std::get<1>(real_pose) = 10.801400;
  std::get<2>(real_pose) = 1.527344;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 34/59
  std::get<0>(virtual_pose) = 5.367537;
  std::get<1>(virtual_pose) = 10.801400;
  std::get<2>(virtual_pose) = 1.527344;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.222900;
  std::get<2>(real_pose) = 1.594048;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 35/59
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.222900;
  std::get<2>(virtual_pose) = 1.594048;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.724700;
  std::get<2>(real_pose) = 1.772556;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 36/59
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.724700;
  std::get<2>(virtual_pose) = 1.772556;
  std::get<0>(real_pose) = 5.387610;
  std::get<1>(real_pose) = 12.086000;
  std::get<2>(real_pose) = 1.961403;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 37/59
  std::get<0>(virtual_pose) = 5.387610;
  std::get<1>(virtual_pose) = 12.086000;
  std::get<2>(virtual_pose) = 1.961403;
  std::get<0>(real_pose) = 5.227030;
  std::get<1>(real_pose) = 12.607900;
  std::get<2>(real_pose) = 1.958303;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 38/59
  std::get<0>(virtual_pose) = 5.227030;
  std::get<1>(virtual_pose) = 12.607900;
  std::get<2>(virtual_pose) = 1.958303;
  std::get<0>(real_pose) = 4.966087;
  std::get<1>(real_pose) = 13.109700;
  std::get<2>(real_pose) = 1.947698;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 39/59
  std::get<0>(virtual_pose) = 4.966087;
  std::get<1>(virtual_pose) = 13.109700;
  std::get<2>(virtual_pose) = 1.947698;
  std::get<0>(real_pose) = 4.825580;
  std::get<1>(real_pose) = 13.591500;
  std::get<2>(real_pose) = 2.071833;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 40/59
  std::get<0>(virtual_pose) = 4.825580;
  std::get<1>(virtual_pose) = 13.591500;
  std::get<2>(virtual_pose) = 2.071833;
  std::get<0>(real_pose) = 4.584710;
  std::get<1>(real_pose) = 14.073200;
  std::get<2>(real_pose) = 1.995604;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 41/59
  std::get<0>(virtual_pose) = 4.584710;
  std::get<1>(virtual_pose) = 14.073200;
  std::get<2>(virtual_pose) = 1.995604;
  std::get<0>(real_pose) = 4.363912;
  std::get<1>(real_pose) = 14.434500;
  std::get<2>(real_pose) = 2.118344;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 42/59
  std::get<0>(virtual_pose) = 4.363912;
  std::get<1>(virtual_pose) = 14.434500;
  std::get<2>(virtual_pose) = 2.118344;
  std::get<0>(real_pose) = 4.203332;
  std::get<1>(real_pose) = 14.916300;
  std::get<2>(real_pose) = 2.356189;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 43/59
  std::get<0>(virtual_pose) = 4.203332;
  std::get<1>(virtual_pose) = 14.916300;
  std::get<2>(virtual_pose) = 2.356189;
  std::get<0>(real_pose) = 3.862099;
  std::get<1>(real_pose) = 15.257500;
  std::get<2>(real_pose) = 2.918035;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 44/59
  std::get<0>(virtual_pose) = 3.862099;
  std::get<1>(virtual_pose) = 15.257500;
  std::get<2>(virtual_pose) = 2.918035;
  std::get<0>(real_pose) = 3.761737;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = -3.033890;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 45/59
  std::get<0>(virtual_pose) = 3.761737;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = -3.033890;
  std::get<0>(real_pose) = 3.420504;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = -2.792782;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 46/59
  std::get<0>(virtual_pose) = 3.420504;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = -2.792782;
  std::get<0>(real_pose) = 3.019054;
  std::get<1>(real_pose) = 15.277600;
  std::get<2>(real_pose) = -2.573036;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 47/59
  std::get<0>(virtual_pose) = 3.019054;
  std::get<1>(virtual_pose) = 15.277600;
  std::get<2>(virtual_pose) = -2.573036;
  std::get<0>(real_pose) = 2.537314;
  std::get<1>(real_pose) = 15.036700;
  std::get<2>(real_pose) = -2.129410;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 48/59
  std::get<0>(virtual_pose) = 2.537314;
  std::get<1>(virtual_pose) = 15.036700;
  std::get<2>(virtual_pose) = -2.129410;
  std::get<0>(real_pose) = 2.296444;
  std::get<1>(real_pose) = 14.815900;
  std::get<2>(real_pose) = -1.778281;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 49/59
  std::get<0>(virtual_pose) = 2.296444;
  std::get<1>(virtual_pose) = 14.815900;
  std::get<2>(virtual_pose) = -1.778281;
  std::get<0>(real_pose) = 2.135864;
  std::get<1>(real_pose) = 14.394400;
  std::get<2>(real_pose) = -1.279350;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 50/59
  std::get<0>(virtual_pose) = 2.135864;
  std::get<1>(virtual_pose) = 14.394400;
  std::get<2>(virtual_pose) = -1.279350;
  std::get<0>(real_pose) = 2.135864;
  std::get<1>(real_pose) = 14.053100;
  std::get<2>(real_pose) = -0.628756;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 51/59
  std::get<0>(virtual_pose) = 2.135864;
  std::get<1>(virtual_pose) = 14.053100;
  std::get<2>(virtual_pose) = -0.628756;
  std::get<0>(real_pose) = 2.316517;
  std::get<1>(real_pose) = 13.792200;
  std::get<2>(real_pose) = -0.732854;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 52/59
  std::get<0>(virtual_pose) = 2.316517;
  std::get<1>(virtual_pose) = 13.792200;
  std::get<2>(virtual_pose) = -0.732854;
  std::get<0>(real_pose) = 2.798257;
  std::get<1>(real_pose) = 13.571400;
  std::get<2>(real_pose) = -1.543026;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 53/59
  std::get<0>(virtual_pose) = 2.798257;
  std::get<1>(virtual_pose) = 13.571400;
  std::get<2>(virtual_pose) = -1.543026;
  std::get<0>(real_pose) = 2.918692;
  std::get<1>(real_pose) = 13.250200;
  std::get<2>(real_pose) = -1.518209;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 54/59
  std::get<0>(virtual_pose) = 2.918692;
  std::get<1>(virtual_pose) = 13.250200;
  std::get<2>(virtual_pose) = -1.518209;
  std::get<0>(real_pose) = 2.818329;
  std::get<1>(real_pose) = 12.848800;
  std::get<2>(real_pose) = -1.091266;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 55/59
  std::get<0>(virtual_pose) = 2.818329;
  std::get<1>(virtual_pose) = 12.848800;
  std::get<2>(virtual_pose) = -1.091266;
  std::get<0>(real_pose) = 2.958837;
  std::get<1>(real_pose) = 12.487500;
  std::get<2>(real_pose) = -0.767258;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 56/59
  std::get<0>(virtual_pose) = 2.958837;
  std::get<1>(virtual_pose) = 12.487500;
  std::get<2>(virtual_pose) = -0.767258;
  std::get<0>(real_pose) = 3.079272;
  std::get<1>(real_pose) = 12.347000;
  std::get<2>(real_pose) = -0.799934;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 57/59
  std::get<0>(virtual_pose) = 3.079272;
  std::get<1>(virtual_pose) = 12.347000;
  std::get<2>(virtual_pose) = -0.799934;
  std::get<0>(real_pose) = 3.520867;
  std::get<1>(real_pose) = 11.945500;
  std::get<2>(real_pose) = -1.097405;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 58/59
  std::get<0>(virtual_pose) = 3.520867;
  std::get<1>(virtual_pose) = 11.945500;
  std::get<2>(virtual_pose) = -1.097405;
  std::get<0>(real_pose) = 3.761737;
  std::get<1>(real_pose) = 11.644400;
  std::get<2>(real_pose) = -1.237503;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 59/59
  std::get<0>(virtual_pose) = 3.761737;
  std::get<1>(virtual_pose) = 11.644400;
  std::get<2>(virtual_pose) = -1.237503;
  std::get<0>(real_pose) = 3.942389;
  std::get<1>(real_pose) = 11.122600;
  std::get<2>(real_pose) = -1.237503;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  /*

  // conf 5
  std::tuple<double,double,double> virtual_pose;
  std::tuple<double,double,double> real_pose;
  //-------------------------------------------------
  // Pose no. 1/120
  std::get<0>(virtual_pose) = -1.938854;
  std::get<1>(virtual_pose) = 6.505900;
  std::get<2>(virtual_pose) = 0.432298;
  std::get<0>(real_pose) = -1.778274;
  std::get<1>(real_pose) = 6.566100;
  std::get<2>(real_pose) = 0.367300;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 2/120
  std::get<0>(virtual_pose) = -1.778274;
  std::get<1>(virtual_pose) = 6.566100;
  std::get<2>(virtual_pose) = 0.367300;
  std::get<0>(real_pose) = -1.677912;
  std::get<1>(real_pose) = 6.626300;
  std::get<2>(real_pose) = 0.404787;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 3/120
  std::get<0>(virtual_pose) = -1.677912;
  std::get<1>(virtual_pose) = 6.626300;
  std::get<2>(virtual_pose) = 0.404787;
  std::get<0>(real_pose) = -1.517332;
  std::get<1>(real_pose) = 6.666500;
  std::get<2>(real_pose) = 0.486778;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 4/120
  std::get<0>(virtual_pose) = -1.517332;
  std::get<1>(virtual_pose) = 6.666500;
  std::get<2>(virtual_pose) = 0.486778;
  std::get<0>(real_pose) = -1.396897;
  std::get<1>(real_pose) = 6.746700;
  std::get<2>(real_pose) = 0.487007;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 5/120
  std::get<0>(virtual_pose) = -1.396897;
  std::get<1>(virtual_pose) = 6.746700;
  std::get<2>(virtual_pose) = 0.487007;
  std::get<0>(real_pose) = -1.176099;
  std::get<1>(real_pose) = 6.847100;
  std::get<2>(real_pose) = 0.732946;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 6/120
  std::get<0>(virtual_pose) = -1.176099;
  std::get<1>(virtual_pose) = 6.847100;
  std::get<2>(virtual_pose) = 0.732946;
  std::get<0>(real_pose) = -1.055664;
  std::get<1>(real_pose) = 6.927400;
  std::get<2>(real_pose) = 1.128446;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 7/120
  std::get<0>(virtual_pose) = -1.055664;
  std::get<1>(virtual_pose) = 6.927400;
  std::get<2>(virtual_pose) = 1.128446;
  std::get<0>(real_pose) = -0.975374;
  std::get<1>(real_pose) = 7.027800;
  std::get<2>(real_pose) = 1.304547;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 8/120
  std::get<0>(virtual_pose) = -0.975374;
  std::get<1>(virtual_pose) = 7.027800;
  std::get<2>(virtual_pose) = 1.304547;
  std::get<0>(real_pose) = -0.875012;
  std::get<1>(real_pose) = 7.308800;
  std::get<2>(real_pose) = 1.465926;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 9/120
  std::get<0>(virtual_pose) = -0.875012;
  std::get<1>(virtual_pose) = 7.308800;
  std::get<2>(virtual_pose) = 1.465926;
  std::get<0>(real_pose) = -0.854939;
  std::get<1>(real_pose) = 7.469400;
  std::get<2>(real_pose) = 1.413717;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 10/120
  std::get<0>(virtual_pose) = -0.854939;
  std::get<1>(virtual_pose) = 7.469400;
  std::get<2>(virtual_pose) = 1.413717;
  std::get<0>(real_pose) = -0.834867;
  std::get<1>(real_pose) = 7.690200;
  std::get<2>(real_pose) = 1.913836;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 11/120
  std::get<0>(virtual_pose) = -0.834867;
  std::get<1>(virtual_pose) = 7.690200;
  std::get<2>(virtual_pose) = 1.913836;
  std::get<0>(real_pose) = -0.854939;
  std::get<1>(real_pose) = 7.850700;
  std::get<2>(real_pose) = 2.312683;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 12/120
  std::get<0>(virtual_pose) = -0.854939;
  std::get<1>(virtual_pose) = 7.850700;
  std::get<2>(virtual_pose) = 2.312683;
  std::get<0>(real_pose) = -0.935229;
  std::get<1>(real_pose) = 7.971200;
  std::get<2>(real_pose) = 2.446916;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 13/120
  std::get<0>(virtual_pose) = -0.935229;
  std::get<1>(virtual_pose) = 7.971200;
  std::get<2>(virtual_pose) = 2.446916;
  std::get<0>(real_pose) = -1.075737;
  std::get<1>(real_pose) = 8.091600;
  std::get<2>(real_pose) = 2.137519;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 14/120
  std::get<0>(virtual_pose) = -1.075737;
  std::get<1>(virtual_pose) = 8.091600;
  std::get<2>(virtual_pose) = 2.137519;
  std::get<0>(real_pose) = -1.176099;
  std::get<1>(real_pose) = 8.171900;
  std::get<2>(real_pose) = 1.849110;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 15/120
  std::get<0>(virtual_pose) = -1.176099;
  std::get<1>(virtual_pose) = 8.171900;
  std::get<2>(virtual_pose) = 1.849110;
  std::get<0>(real_pose) = -1.216244;
  std::get<1>(real_pose) = 8.312400;
  std::get<2>(real_pose) = 1.756123;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 16/120
  std::get<0>(virtual_pose) = -1.216244;
  std::get<1>(virtual_pose) = 8.312400;
  std::get<2>(virtual_pose) = 1.756123;
  std::get<0>(real_pose) = -1.216244;
  std::get<1>(real_pose) = 8.312400;
  std::get<2>(real_pose) = 1.727390;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 17/120
  std::get<0>(virtual_pose) = -1.216244;
  std::get<1>(virtual_pose) = 8.312400;
  std::get<2>(virtual_pose) = 1.727390;
  std::get<0>(real_pose) = -1.276462;
  std::get<1>(real_pose) = 8.633600;
  std::get<2>(real_pose) = 1.071454;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 18/120
  std::get<0>(virtual_pose) = -1.276462;
  std::get<1>(virtual_pose) = 8.633600;
  std::get<2>(virtual_pose) = 1.071454;
  std::get<0>(real_pose) = -1.276462;
  std::get<1>(real_pose) = 8.693800;
  std::get<2>(real_pose) = 0.756787;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 19/120
  std::get<0>(virtual_pose) = -1.276462;
  std::get<1>(virtual_pose) = 8.693800;
  std::get<2>(virtual_pose) = 0.756787;
  std::get<0>(real_pose) = -1.156027;
  std::get<1>(real_pose) = 8.854400;
  std::get<2>(real_pose) = 0.448659;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 20/120
  std::get<0>(virtual_pose) = -1.156027;
  std::get<1>(virtual_pose) = 8.854400;
  std::get<2>(virtual_pose) = 0.448659;
  std::get<0>(real_pose) = -0.915157;
  std::get<1>(real_pose) = 9.035000;
  std::get<2>(real_pose) = 0.197340;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 21/120
  std::get<0>(virtual_pose) = -0.915157;
  std::get<1>(virtual_pose) = 9.035000;
  std::get<2>(virtual_pose) = 0.197340;
  std::get<0>(real_pose) = -0.614069;
  std::get<1>(real_pose) = 9.115300;
  std::get<2>(real_pose) = 0.079741;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 22/120
  std::get<0>(virtual_pose) = -0.614069;
  std::get<1>(virtual_pose) = 9.115300;
  std::get<2>(virtual_pose) = 0.079741;
  std::get<0>(real_pose) = -0.312982;
  std::get<1>(real_pose) = 9.155400;
  std::get<2>(real_pose) = -0.257170;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 23/120
  std::get<0>(virtual_pose) = -0.312982;
  std::get<1>(virtual_pose) = 9.155400;
  std::get<2>(virtual_pose) = -0.257170;
  std::get<0>(real_pose) = -0.112257;
  std::get<1>(real_pose) = 9.155400;
  std::get<2>(real_pose) = -0.643360;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 24/120
  std::get<0>(virtual_pose) = -0.112257;
  std::get<1>(virtual_pose) = 9.155400;
  std::get<2>(virtual_pose) = -0.643360;
  std::get<0>(real_pose) = 0.068396;
  std::get<1>(real_pose) = 9.055100;
  std::get<2>(real_pose) = -0.587996;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 25/120
  std::get<0>(virtual_pose) = 0.068396;
  std::get<1>(virtual_pose) = 9.055100;
  std::get<2>(virtual_pose) = -0.587996;
  std::get<0>(real_pose) = 0.289194;
  std::get<1>(real_pose) = 8.854400;
  std::get<2>(real_pose) = -0.664040;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 26/120
  std::get<0>(virtual_pose) = 0.289194;
  std::get<1>(virtual_pose) = 8.854400;
  std::get<2>(virtual_pose) = -0.664040;
  std::get<0>(real_pose) = 0.610354;
  std::get<1>(real_pose) = 8.693800;
  std::get<2>(real_pose) = -0.950522;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 27/120
  std::get<0>(virtual_pose) = 0.610354;
  std::get<1>(virtual_pose) = 8.693800;
  std::get<2>(virtual_pose) = -0.950522;
  std::get<0>(real_pose) = 0.750861;
  std::get<1>(real_pose) = 8.493100;
  std::get<2>(real_pose) = -0.632753;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 28/120
  std::get<0>(virtual_pose) = 0.750861;
  std::get<1>(virtual_pose) = 8.493100;
  std::get<2>(virtual_pose) = -0.632753;
  std::get<0>(real_pose) = 0.811079;
  std::get<1>(real_pose) = 8.412800;
  std::get<2>(real_pose) = -0.540474;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 29/120
  std::get<0>(virtual_pose) = 0.811079;
  std::get<1>(virtual_pose) = 8.412800;
  std::get<2>(virtual_pose) = -0.540474;
  std::get<0>(real_pose) = 1.051949;
  std::get<1>(real_pose) = 8.272300;
  std::get<2>(real_pose) = -0.410264;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 30/120
  std::get<0>(virtual_pose) = 1.051949;
  std::get<1>(virtual_pose) = 8.272300;
  std::get<2>(virtual_pose) = -0.410264;
  std::get<0>(real_pose) = 1.212529;
  std::get<1>(real_pose) = 8.171900;
  std::get<2>(real_pose) = -0.185295;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 31/120
  std::get<0>(virtual_pose) = 1.212529;
  std::get<1>(virtual_pose) = 8.171900;
  std::get<2>(virtual_pose) = -0.185295;
  std::get<0>(real_pose) = 1.513616;
  std::get<1>(real_pose) = 8.071500;
  std::get<2>(real_pose) = -0.033201;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 32/120
  std::get<0>(virtual_pose) = 1.513616;
  std::get<1>(virtual_pose) = 8.071500;
  std::get<2>(virtual_pose) = -0.033201;
  std::get<0>(real_pose) = 1.854849;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 33/120
  std::get<0>(virtual_pose) = 1.854849;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.115792;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 34/120
  std::get<0>(virtual_pose) = 2.115792;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.236227;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 35/120
  std::get<0>(virtual_pose) = 2.236227;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.396807;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 36/120
  std::get<0>(virtual_pose) = 2.396807;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.778184;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 37/120
  std::get<0>(virtual_pose) = 2.778184;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 2.958837;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 38/120
  std::get<0>(virtual_pose) = 2.958837;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 3.159562;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 39/120
  std::get<0>(virtual_pose) = 3.159562;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 3.460649;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.000000;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 40/120
  std::get<0>(virtual_pose) = 3.460649;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.000000;
  std::get<0>(real_pose) = 3.681447;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.039834;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 41/120
  std::get<0>(virtual_pose) = 3.681447;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.039834;
  std::get<0>(real_pose) = 4.002607;
  std::get<1>(real_pose) = 8.051500;
  std::get<2>(real_pose) = 0.055298;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 42/120
  std::get<0>(virtual_pose) = 4.002607;
  std::get<1>(virtual_pose) = 8.051500;
  std::get<2>(virtual_pose) = 0.055298;
  std::get<0>(real_pose) = 4.183260;
  std::get<1>(real_pose) = 8.071500;
  std::get<2>(real_pose) = 0.055574;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 43/120
  std::get<0>(virtual_pose) = 4.183260;
  std::get<1>(virtual_pose) = 8.071500;
  std::get<2>(virtual_pose) = 0.055574;
  std::get<0>(real_pose) = 4.363912;
  std::get<1>(real_pose) = 8.071500;
  std::get<2>(real_pose) = 0.231118;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 44/120
  std::get<0>(virtual_pose) = 4.363912;
  std::get<1>(virtual_pose) = 8.071500;
  std::get<2>(virtual_pose) = 0.231118;
  std::get<0>(real_pose) = 4.544565;
  std::get<1>(real_pose) = 8.091600;
  std::get<2>(real_pose) = 0.432298;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 45/120
  std::get<0>(virtual_pose) = 4.544565;
  std::get<1>(virtual_pose) = 8.091600;
  std::get<2>(virtual_pose) = 0.432298;
  std::get<0>(real_pose) = 4.705145;
  std::get<1>(real_pose) = 8.151800;
  std::get<2>(real_pose) = 0.426769;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 46/120
  std::get<0>(virtual_pose) = 4.705145;
  std::get<1>(virtual_pose) = 8.151800;
  std::get<2>(virtual_pose) = 0.426769;
  std::get<0>(real_pose) = 4.805507;
  std::get<1>(real_pose) = 8.212000;
  std::get<2>(real_pose) = 0.463797;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 47/120
  std::get<0>(virtual_pose) = 4.805507;
  std::get<1>(virtual_pose) = 8.212000;
  std::get<2>(virtual_pose) = 0.463797;
  std::get<0>(real_pose) = 4.925942;
  std::get<1>(real_pose) = 8.252200;
  std::get<2>(real_pose) = 0.463531;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 48/120
  std::get<0>(virtual_pose) = 4.925942;
  std::get<1>(virtual_pose) = 8.252200;
  std::get<2>(virtual_pose) = 0.463531;
  std::get<0>(real_pose) = 5.006232;
  std::get<1>(real_pose) = 8.312400;
  std::get<2>(real_pose) = 0.394924;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 49/120
  std::get<0>(virtual_pose) = 5.006232;
  std::get<1>(virtual_pose) = 8.312400;
  std::get<2>(virtual_pose) = 0.394924;
  std::get<0>(real_pose) = 5.166812;
  std::get<1>(real_pose) = 8.372600;
  std::get<2>(real_pose) = 0.558767;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 50/120
  std::get<0>(virtual_pose) = 5.166812;
  std::get<1>(virtual_pose) = 8.372600;
  std::get<2>(virtual_pose) = 0.558767;
  std::get<0>(real_pose) = 5.247102;
  std::get<1>(real_pose) = 8.412800;
  std::get<2>(real_pose) = 0.942005;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 51/120
  std::get<0>(virtual_pose) = 5.247102;
  std::get<1>(virtual_pose) = 8.412800;
  std::get<2>(virtual_pose) = 0.942005;
  std::get<0>(real_pose) = 5.327392;
  std::get<1>(real_pose) = 8.473000;
  std::get<2>(real_pose) = 1.339684;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 52/120
  std::get<0>(virtual_pose) = 5.327392;
  std::get<1>(virtual_pose) = 8.473000;
  std::get<2>(virtual_pose) = 1.339684;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 8.633600;
  std::get<2>(real_pose) = 1.413717;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 53/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 8.633600;
  std::get<2>(virtual_pose) = 1.413717;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 8.814200;
  std::get<2>(real_pose) = 1.951288;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 54/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 8.814200;
  std::get<2>(virtual_pose) = 1.951288;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 8.854400;
  std::get<2>(real_pose) = 2.297446;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 55/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 8.854400;
  std::get<2>(virtual_pose) = 2.297446;
  std::get<0>(real_pose) = 5.287247;
  std::get<1>(real_pose) = 9.115300;
  std::get<2>(real_pose) = 2.704985;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 56/120
  std::get<0>(virtual_pose) = 5.287247;
  std::get<1>(virtual_pose) = 9.115300;
  std::get<2>(virtual_pose) = 2.704985;
  std::get<0>(real_pose) = 5.086522;
  std::get<1>(real_pose) = 9.215700;
  std::get<2>(real_pose) = 2.513032;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 57/120
  std::get<0>(virtual_pose) = 5.086522;
  std::get<1>(virtual_pose) = 9.215700;
  std::get<2>(virtual_pose) = 2.513032;
  std::get<0>(real_pose) = 4.986160;
  std::get<1>(real_pose) = 9.255800;
  std::get<2>(real_pose) = 2.111271;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 58/120
  std::get<0>(virtual_pose) = 4.986160;
  std::get<1>(virtual_pose) = 9.255800;
  std::get<2>(virtual_pose) = 2.111271;
  std::get<0>(real_pose) = 4.865725;
  std::get<1>(real_pose) = 9.376200;
  std::get<2>(real_pose) = 1.499512;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 59/120
  std::get<0>(virtual_pose) = 4.865725;
  std::get<1>(virtual_pose) = 9.376200;
  std::get<2>(virtual_pose) = 1.499512;
  std::get<0>(real_pose) = 4.865725;
  std::get<1>(real_pose) = 9.456500;
  std::get<2>(real_pose) = 1.299847;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 60/120
  std::get<0>(virtual_pose) = 4.865725;
  std::get<1>(virtual_pose) = 9.456500;
  std::get<2>(virtual_pose) = 1.299847;
  std::get<0>(real_pose) = 4.885797;
  std::get<1>(real_pose) = 9.657300;
  std::get<2>(real_pose) = 1.071454;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 61/120
  std::get<0>(virtual_pose) = 4.885797;
  std::get<1>(virtual_pose) = 9.657300;
  std::get<2>(virtual_pose) = 1.071454;
  std::get<0>(real_pose) = 4.966087;
  std::get<1>(real_pose) = 9.817800;
  std::get<2>(real_pose) = 0.938066;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 62/120
  std::get<0>(virtual_pose) = 4.966087;
  std::get<1>(virtual_pose) = 9.817800;
  std::get<2>(virtual_pose) = 0.938066;
  std::get<0>(real_pose) = 5.006232;
  std::get<1>(real_pose) = 9.878100;
  std::get<2>(real_pose) = 0.935673;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 63/120
  std::get<0>(virtual_pose) = 5.006232;
  std::get<1>(virtual_pose) = 9.878100;
  std::get<2>(virtual_pose) = 0.935673;
  std::get<0>(real_pose) = 5.186885;
  std::get<1>(real_pose) = 10.118900;
  std::get<2>(real_pose) = 1.019240;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 64/120
  std::get<0>(virtual_pose) = 5.186885;
  std::get<1>(virtual_pose) = 10.118900;
  std::get<2>(virtual_pose) = 1.019240;
  std::get<0>(real_pose) = 5.287247;
  std::get<1>(real_pose) = 10.259400;
  std::get<2>(real_pose) = 1.352124;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 65/120
  std::get<0>(virtual_pose) = 5.287247;
  std::get<1>(virtual_pose) = 10.259400;
  std::get<2>(virtual_pose) = 1.352124;
  std::get<0>(real_pose) = 5.347465;
  std::get<1>(real_pose) = 10.379900;
  std::get<2>(real_pose) = 1.523212;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 66/120
  std::get<0>(virtual_pose) = 5.347465;
  std::get<1>(virtual_pose) = 10.379900;
  std::get<2>(virtual_pose) = 1.523212;
  std::get<0>(real_pose) = 5.367537;
  std::get<1>(real_pose) = 10.620700;
  std::get<2>(real_pose) = 1.471140;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 67/120
  std::get<0>(virtual_pose) = 5.367537;
  std::get<1>(virtual_pose) = 10.620700;
  std::get<2>(virtual_pose) = 1.471140;
  std::get<0>(real_pose) = 5.367537;
  std::get<1>(real_pose) = 10.801400;
  std::get<2>(real_pose) = 1.475840;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 68/120
  std::get<0>(virtual_pose) = 5.367537;
  std::get<1>(virtual_pose) = 10.801400;
  std::get<2>(virtual_pose) = 1.475840;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.022200;
  std::get<2>(real_pose) = 1.413717;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 69/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.022200;
  std::get<2>(virtual_pose) = 1.413717;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.222900;
  std::get<2>(real_pose) = 1.413717;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 70/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.222900;
  std::get<2>(virtual_pose) = 1.413717;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.383500;
  std::get<2>(real_pose) = 1.599361;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 71/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.383500;
  std::get<2>(virtual_pose) = 1.599361;
  std::get<0>(real_pose) = 5.407682;
  std::get<1>(real_pose) = 11.724700;
  std::get<2>(real_pose) = 1.626294;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 72/120
  std::get<0>(virtual_pose) = 5.407682;
  std::get<1>(virtual_pose) = 11.724700;
  std::get<2>(virtual_pose) = 1.626294;
  std::get<0>(real_pose) = 5.387610;
  std::get<1>(real_pose) = 12.086000;
  std::get<2>(real_pose) = 1.681427;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 73/120
  std::get<0>(virtual_pose) = 5.387610;
  std::get<1>(virtual_pose) = 12.086000;
  std::get<2>(virtual_pose) = 1.681427;
  std::get<0>(real_pose) = 5.387610;
  std::get<1>(real_pose) = 12.086000;
  std::get<2>(real_pose) = 1.869287;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 74/120
  std::get<0>(virtual_pose) = 5.387610;
  std::get<1>(virtual_pose) = 12.086000;
  std::get<2>(virtual_pose) = 1.869287;
  std::get<0>(real_pose) = 5.367537;
  std::get<1>(real_pose) = 12.266700;
  std::get<2>(real_pose) = 1.911799;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 75/120
  std::get<0>(virtual_pose) = 5.367537;
  std::get<1>(virtual_pose) = 12.266700;
  std::get<2>(virtual_pose) = 1.911799;
  std::get<0>(real_pose) = 5.227030;
  std::get<1>(real_pose) = 12.607900;
  std::get<2>(real_pose) = 2.050327;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 76/120
  std::get<0>(virtual_pose) = 5.227030;
  std::get<1>(virtual_pose) = 12.607900;
  std::get<2>(virtual_pose) = 2.050327;
  std::get<0>(real_pose) = 5.146740;
  std::get<1>(real_pose) = 12.888900;
  std::get<2>(real_pose) = 2.158805;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 77/120
  std::get<0>(virtual_pose) = 5.146740;
  std::get<1>(virtual_pose) = 12.888900;
  std::get<2>(virtual_pose) = 2.158805;
  std::get<0>(real_pose) = 4.966087;
  std::get<1>(real_pose) = 13.109700;
  std::get<2>(real_pose) = 1.854556;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 78/120
  std::get<0>(virtual_pose) = 4.966087;
  std::get<1>(virtual_pose) = 13.109700;
  std::get<2>(virtual_pose) = 1.854556;
  std::get<0>(real_pose) = 4.905870;
  std::get<1>(real_pose) = 13.250200;
  std::get<2>(real_pose) = 1.933343;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 79/120
  std::get<0>(virtual_pose) = 4.905870;
  std::get<1>(virtual_pose) = 13.250200;
  std::get<2>(virtual_pose) = 1.933343;
  std::get<0>(real_pose) = 4.825580;
  std::get<1>(real_pose) = 13.591500;
  std::get<2>(real_pose) = 2.034477;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 80/120
  std::get<0>(virtual_pose) = 4.825580;
  std::get<1>(virtual_pose) = 13.591500;
  std::get<2>(virtual_pose) = 2.034477;
  std::get<0>(real_pose) = 4.685072;
  std::get<1>(real_pose) = 13.832300;
  std::get<2>(real_pose) = 2.060736;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 81/120
  std::get<0>(virtual_pose) = 4.685072;
  std::get<1>(virtual_pose) = 13.832300;
  std::get<2>(virtual_pose) = 2.060736;
  std::get<0>(real_pose) = 4.584710;
  std::get<1>(real_pose) = 14.073200;
  std::get<2>(real_pose) = 2.119353;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 82/120
  std::get<0>(virtual_pose) = 4.584710;
  std::get<1>(virtual_pose) = 14.073200;
  std::get<2>(virtual_pose) = 2.119353;
  std::get<0>(real_pose) = 4.363912;
  std::get<1>(real_pose) = 14.434500;
  std::get<2>(real_pose) = 1.815744;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 83/120
  std::get<0>(virtual_pose) = 4.363912;
  std::get<1>(virtual_pose) = 14.434500;
  std::get<2>(virtual_pose) = 1.815744;
  std::get<0>(real_pose) = 4.363912;
  std::get<1>(real_pose) = 14.434500;
  std::get<2>(real_pose) = 1.892510;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 84/120
  std::get<0>(virtual_pose) = 4.363912;
  std::get<1>(virtual_pose) = 14.434500;
  std::get<2>(virtual_pose) = 1.892510;
  std::get<0>(real_pose) = 4.303695;
  std::get<1>(real_pose) = 14.675400;
  std::get<2>(real_pose) = 2.013149;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 85/120
  std::get<0>(virtual_pose) = 4.303695;
  std::get<1>(virtual_pose) = 14.675400;
  std::get<2>(virtual_pose) = 2.013149;
  std::get<0>(real_pose) = 4.203332;
  std::get<1>(real_pose) = 14.916300;
  std::get<2>(real_pose) = 2.356243;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 86/120
  std::get<0>(virtual_pose) = 4.203332;
  std::get<1>(virtual_pose) = 14.916300;
  std::get<2>(virtual_pose) = 2.356243;
  std::get<0>(real_pose) = 4.123042;
  std::get<1>(real_pose) = 15.056800;
  std::get<2>(real_pose) = 2.446834;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 87/120
  std::get<0>(virtual_pose) = 4.123042;
  std::get<1>(virtual_pose) = 15.056800;
  std::get<2>(virtual_pose) = 2.446834;
  std::get<0>(real_pose) = 3.862099;
  std::get<1>(real_pose) = 15.257500;
  std::get<2>(real_pose) = 2.356005;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 88/120
  std::get<0>(virtual_pose) = 3.862099;
  std::get<1>(virtual_pose) = 15.257500;
  std::get<2>(virtual_pose) = 2.356005;
  std::get<0>(real_pose) = 3.761737;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = 3.141593;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 89/120
  std::get<0>(virtual_pose) = 3.761737;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = 3.141593;
  std::get<0>(real_pose) = 3.761737;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = 3.141593;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 90/120
  std::get<0>(virtual_pose) = 3.761737;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = 3.141593;
  std::get<0>(real_pose) = 3.500794;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = 3.141593;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 91/120
  std::get<0>(virtual_pose) = 3.500794;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = 3.141593;
  std::get<0>(real_pose) = 3.420504;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = -2.944173;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 92/120
  std::get<0>(virtual_pose) = 3.420504;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = -2.944173;
  std::get<0>(real_pose) = 3.420504;
  std::get<1>(real_pose) = 15.357900;
  std::get<2>(real_pose) = -2.937467;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 93/120
  std::get<0>(virtual_pose) = 3.420504;
  std::get<1>(virtual_pose) = 15.357900;
  std::get<2>(virtual_pose) = -2.937467;
  std::get<0>(real_pose) = 3.019054;
  std::get<1>(real_pose) = 15.277600;
  std::get<2>(real_pose) = -2.677895;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 94/120
  std::get<0>(virtual_pose) = 3.019054;
  std::get<1>(virtual_pose) = 15.277600;
  std::get<2>(virtual_pose) = -2.677895;
  std::get<0>(real_pose) = 2.838402;
  std::get<1>(real_pose) = 15.237400;
  std::get<2>(real_pose) = -2.517577;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 95/120
  std::get<0>(virtual_pose) = 2.838402;
  std::get<1>(virtual_pose) = 15.237400;
  std::get<2>(virtual_pose) = -2.517577;
  std::get<0>(real_pose) = 2.537314;
  std::get<1>(real_pose) = 15.036700;
  std::get<2>(real_pose) = -2.399640;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 96/120
  std::get<0>(virtual_pose) = 2.537314;
  std::get<1>(virtual_pose) = 15.036700;
  std::get<2>(virtual_pose) = -2.399640;
  std::get<0>(real_pose) = 2.336589;
  std::get<1>(real_pose) = 14.876100;
  std::get<2>(real_pose) = -1.913836;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 97/120
  std::get<0>(virtual_pose) = 2.336589;
  std::get<1>(virtual_pose) = 14.876100;
  std::get<2>(virtual_pose) = -1.913836;
  std::get<0>(real_pose) = 2.296444;
  std::get<1>(real_pose) = 14.815900;
  std::get<2>(real_pose) = -1.934793;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 98/120
  std::get<0>(virtual_pose) = 2.296444;
  std::get<1>(virtual_pose) = 14.815900;
  std::get<2>(virtual_pose) = -1.934793;
  std::get<0>(real_pose) = 2.236227;
  std::get<1>(real_pose) = 14.595100;
  std::get<2>(real_pose) = -1.828107;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 99/120
  std::get<0>(virtual_pose) = 2.236227;
  std::get<1>(virtual_pose) = 14.595100;
  std::get<2>(virtual_pose) = -1.828107;
  std::get<0>(real_pose) = 2.135864;
  std::get<1>(real_pose) = 14.394400;
  std::get<2>(real_pose) = -1.727876;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 100/120
  std::get<0>(virtual_pose) = 2.135864;
  std::get<1>(virtual_pose) = 14.394400;
  std::get<2>(virtual_pose) = -1.727876;
  std::get<0>(real_pose) = 2.135864;
  std::get<1>(real_pose) = 14.213700;
  std::get<2>(real_pose) = -1.299845;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 101/120
  std::get<0>(virtual_pose) = 2.135864;
  std::get<1>(virtual_pose) = 14.213700;
  std::get<2>(virtual_pose) = -1.299845;
  std::get<0>(real_pose) = 2.135864;
  std::get<1>(real_pose) = 14.053100;
  std::get<2>(real_pose) = -0.965174;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 102/120
  std::get<0>(virtual_pose) = 2.135864;
  std::get<1>(virtual_pose) = 14.053100;
  std::get<2>(virtual_pose) = -0.965174;
  std::get<0>(real_pose) = 2.236227;
  std::get<1>(real_pose) = 13.852400;
  std::get<2>(real_pose) = -0.426394;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 103/120
  std::get<0>(virtual_pose) = 2.236227;
  std::get<1>(virtual_pose) = 13.852400;
  std::get<2>(virtual_pose) = -0.426394;
  std::get<0>(real_pose) = 2.316517;
  std::get<1>(real_pose) = 13.792200;
  std::get<2>(real_pose) = -0.429767;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 104/120
  std::get<0>(virtual_pose) = 2.316517;
  std::get<1>(virtual_pose) = 13.792200;
  std::get<2>(virtual_pose) = -0.429767;
  std::get<0>(real_pose) = 2.457024;
  std::get<1>(real_pose) = 13.752100;
  std::get<2>(real_pose) = -0.444564;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 105/120
  std::get<0>(virtual_pose) = 2.457024;
  std::get<1>(virtual_pose) = 13.752100;
  std::get<2>(virtual_pose) = -0.444564;
  std::get<0>(real_pose) = 2.798257;
  std::get<1>(real_pose) = 13.571400;
  std::get<2>(real_pose) = -1.212067;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 106/120
  std::get<0>(virtual_pose) = 2.798257;
  std::get<1>(virtual_pose) = 13.571400;
  std::get<2>(virtual_pose) = -1.212067;
  std::get<0>(real_pose) = 2.878547;
  std::get<1>(real_pose) = 13.551300;
  std::get<2>(real_pose) = -1.727876;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 107/120
  std::get<0>(virtual_pose) = 2.878547;
  std::get<1>(virtual_pose) = 13.551300;
  std::get<2>(virtual_pose) = -1.727876;
  std::get<0>(real_pose) = 2.918692;
  std::get<1>(real_pose) = 13.250200;
  std::get<2>(real_pose) = -1.815805;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 108/120
  std::get<0>(virtual_pose) = 2.918692;
  std::get<1>(virtual_pose) = 13.250200;
  std::get<2>(virtual_pose) = -1.815805;
  std::get<0>(real_pose) = 2.878547;
  std::get<1>(real_pose) = 13.029400;
  std::get<2>(real_pose) = -1.781902;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 109/120
  std::get<0>(virtual_pose) = 2.878547;
  std::get<1>(virtual_pose) = 13.029400;
  std::get<2>(virtual_pose) = -1.781902;
  std::get<0>(real_pose) = 2.818329;
  std::get<1>(real_pose) = 12.848800;
  std::get<2>(real_pose) = -1.199899;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 110/120
  std::get<0>(virtual_pose) = 2.818329;
  std::get<1>(virtual_pose) = 12.848800;
  std::get<2>(virtual_pose) = -1.199899;
  std::get<0>(real_pose) = 2.818329;
  std::get<1>(real_pose) = 12.748400;
  std::get<2>(real_pose) = -0.996447;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 111/120
  std::get<0>(virtual_pose) = 2.818329;
  std::get<1>(virtual_pose) = 12.748400;
  std::get<2>(virtual_pose) = -0.996447;
  std::get<0>(real_pose) = 2.958837;
  std::get<1>(real_pose) = 12.487500;
  std::get<2>(real_pose) = -0.862144;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 112/120
  std::get<0>(virtual_pose) = 2.958837;
  std::get<1>(virtual_pose) = 12.487500;
  std::get<2>(virtual_pose) = -0.862144;
  std::get<0>(real_pose) = 3.039127;
  std::get<1>(real_pose) = 12.407200;
  std::get<2>(real_pose) = -0.815644;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 113/120
  std::get<0>(virtual_pose) = 3.039127;
  std::get<1>(virtual_pose) = 12.407200;
  std::get<2>(virtual_pose) = -0.815644;
  std::get<0>(real_pose) = 3.079272;
  std::get<1>(real_pose) = 12.347000;
  std::get<2>(real_pose) = -0.737877;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 114/120
  std::get<0>(virtual_pose) = 3.079272;
  std::get<1>(virtual_pose) = 12.347000;
  std::get<2>(virtual_pose) = -0.737877;
  std::get<0>(real_pose) = 3.360287;
  std::get<1>(real_pose) = 12.066000;
  std::get<2>(real_pose) = -0.741953;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 115/120
  std::get<0>(virtual_pose) = 3.360287;
  std::get<1>(virtual_pose) = 12.066000;
  std::get<2>(virtual_pose) = -0.741953;
  std::get<0>(real_pose) = 3.520867;
  std::get<1>(real_pose) = 11.945500;
  std::get<2>(real_pose) = -0.896076;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 116/120
  std::get<0>(virtual_pose) = 3.520867;
  std::get<1>(virtual_pose) = 11.945500;
  std::get<2>(virtual_pose) = -0.896076;
  std::get<0>(real_pose) = 3.601157;
  std::get<1>(real_pose) = 11.845200;
  std::get<2>(real_pose) = -1.124719;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 117/120
  std::get<0>(virtual_pose) = 3.601157;
  std::get<1>(virtual_pose) = 11.845200;
  std::get<2>(virtual_pose) = -1.124719;
  std::get<0>(real_pose) = 3.761737;
  std::get<1>(real_pose) = 11.644400;
  std::get<2>(real_pose) = -1.237503;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 118/120
  std::get<0>(virtual_pose) = 3.761737;
  std::get<1>(virtual_pose) = 11.644400;
  std::get<2>(virtual_pose) = -1.237503;
  std::get<0>(real_pose) = 3.821954;
  std::get<1>(real_pose) = 11.383500;
  std::get<2>(real_pose) = -1.030394;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 119/120
  std::get<0>(virtual_pose) = 3.821954;
  std::get<1>(virtual_pose) = 11.383500;
  std::get<2>(virtual_pose) = -1.030394;
  std::get<0>(real_pose) = 3.942389;
  std::get<1>(real_pose) = 11.122600;
  std::get<2>(real_pose) = -0.588631;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  //-------------------------------------------------
  // Pose no. 120/120
  std::get<0>(virtual_pose) = 3.942389;
  std::get<1>(virtual_pose) = 11.122600;
  std::get<2>(virtual_pose) = -0.588631;
  std::get<0>(real_pose) = 4.002607;
  std::get<1>(real_pose) = 11.082400;
  std::get<2>(real_pose) = -0.588631;
  virtual_poses->push_back(virtual_pose);
  real_poses->push_back(real_pose);
  */
}


/*******************************************************************************
*/
  void
S2MSM::initLogs()
{
  std::string configuration_str =
    std::to_string(NUM_ITERATIONS) + "_"
    + std::to_string(MAX_ITERATIONS) + "_"
    + std::to_string(XY_UNIFORM_DISPLACEMENT) + "_"
    + std::to_string(T_UNIFORM_DISPLACEMENT) + "_"
    + std::to_string(SIGMA_NOISE_REAL) + "_"
    + std::to_string(SIGMA_NOISE_MAP) + "_"
    + std::to_string(INVALID_RAYS_RANDOMLY_PERCENT) + "_"
    + std::to_string(INVALID_RAYS_SEQUENTIALLY_PERCENT);

  std::string base_log_path_str =
    base_path_ + "/../logs/" + METHOD + "/" + configuration_str;

  // Log real poses to file ----------------------------------------------------
  real_poses_filename_ =
    base_log_path_str + "/poses/real_poses.txt";

  // Log virtual starting poses to file ----------------------------------------
  initial_pose_estimates_ =
    base_log_path_str + "/poses/initial_pose_estimates.txt";

  // Log pose errors to file ---------------------------------------------------
  pose_errors_filename_ =
    base_log_path_str + "/errors/pose_errors.txt";

  // Log position errors to file -----------------------------------------------
  position_errors_filename_ =
    base_log_path_str + "/errors/position_errors.txt";

  // Log orientation errors to file --------------------------------------------
  orientation_errors_filename_ =
    base_log_path_str + "/errors/orientation_errors.txt";

  // Log trajectories to file --------------------------------------------------
  trajectories_filename_ =
    base_log_path_str + "/trajectories/trajectories.txt";

  // Log rotation execution times to file --------------------------------------
  rotation_times_filename_ =
    base_log_path_str + "/times/rotation_times.txt";

  // Log translation execution times to file -----------------------------------
  translation_times_filename_ =
    base_log_path_str + "/times/translation_times.txt";

  // Log intersections times to file -------------------------------------------
  intersections_times_filename_ =
    base_log_path_str + "/times/intersections_times.txt";

  // Log total execution times to file -----------------------------------------
  times_filename_ =
    base_log_path_str + "/times/total_times.txt";

  // Log rotation iterations to file -------------------------------------------
  rotation_iterations_filename_ =
    base_log_path_str + "/iterations/rotation_iterations.txt";

  // Log translation iterations to file ----------------------------------------
  translation_iterations_filename_ =
    base_log_path_str + "/iterations/translation_iterations.txt";

  // Log number of recoveries to file ------------------------------------------
  num_recoveries_filename_ =
    base_log_path_str + "/recoveries/num_recoveries.txt";

  // Log statistics to file ----------------------------------------------------
  statistics_filename_ =
    base_log_path_str + "/statistics/statistics.txt";

  // Log scans from real poses to file -----------------------------------------
  scans_filename_ =
    base_log_path_str + "/scans/statistics.txt";

  std::ofstream real_poses_file(real_poses_filename_.c_str());
  std::ofstream virtual_starting_poses_file(initial_pose_estimates_.c_str());
  std::ofstream pose_errors_file(pose_errors_filename_.c_str());
  std::ofstream position_errors_file(position_errors_filename_.c_str());
  std::ofstream orientation_errors_file(orientation_errors_filename_.c_str());
  std::ofstream trajectories_file(trajectories_filename_.c_str());
  std::ofstream rotation_times_file(rotation_times_filename_.c_str());
  std::ofstream translation_times_file(translation_times_filename_.c_str());
  std::ofstream intersections_times_file(intersections_times_filename_.c_str());
  std::ofstream times_file(times_filename_.c_str());
  std::ofstream rotation_iterations_file(rotation_iterations_filename_.c_str());
  std::ofstream translation_iterations_file(translation_iterations_filename_.c_str());
  std::ofstream num_recoveries_file(num_recoveries_filename_.c_str());
  std::ofstream statistics_file(statistics_filename_.c_str());
  std::ofstream scans_file(scans_filename_.c_str());
}


/*******************************************************************************
*/
  void
S2MSM::initParams(const unsigned int& max_iterations,
  const unsigned int& num_iterations,
  const unsigned int& start_sample,
  const unsigned int& end_sample,
  const double& xy_uniform_displacement,
  const double& t_uniform_displacement,
  const double& sigma_noise_real,
  const double& sigma_noise_map,
  const double& invalid_rays_randomly_percent,
  const double& invalid_rays_sequentially_percent,
  const unsigned int& size_real_scan,
  const unsigned int& size_map,
  const std::string& method)
{
  MAX_ITERATIONS = max_iterations;
  NUM_ITERATIONS = num_iterations;
  START_SAMPLE = start_sample;
  END_SAMPLE = end_sample;
  XY_UNIFORM_DISPLACEMENT  = xy_uniform_displacement;
  T_UNIFORM_DISPLACEMENT = t_uniform_displacement;
  SIGMA_NOISE_REAL = sigma_noise_real;
  SIGMA_NOISE_MAP = sigma_noise_map;
  INVALID_RAYS_RANDOMLY_PERCENT = invalid_rays_randomly_percent;
  INVALID_RAYS_SEQUENTIALLY_PERCENT = invalid_rays_sequentially_percent;
  SIZE_REAL_SCAN = size_real_scan;
  SIZE_MAP = size_map;
  METHOD = method;

  input_params_.num_iterations = max_iterations;
  input_params_.xy_bound = xy_uniform_displacement;
  input_params_.t_bound = t_uniform_displacement;
  input_params_.sigma_noise_real = SIGMA_NOISE_REAL;
  input_params_.sigma_noise_map = SIGMA_NOISE_MAP;

  // **** CSM parameters - comments copied from algos.h (by Andrea Censi)

  // Maximum angular displacement between scans
  input_.max_angular_correction_deg = 90.0;

  // Maximum translation between scans (m)
  input_.max_linear_correction = 2.0;

  // Maximum ICP cycle iterations
  input_.max_iterations = 1000;

  // A threshold for stopping (m)
  input_.epsilon_xy = 0.0001;

  // A threshold for stopping (rad)
  input_.epsilon_theta = 0.0001;

  // Maximum distance for a correspondence to be valid
  input_.max_correspondence_dist = 200.0;

  // Noise in the scan (m)
  input_.sigma = 0.01;

  // Use smart tricks for finding correspondences.
  input_.use_corr_tricks = 0;

  // Restart: Restart if error is over threshold
  input_.restart = 0;

  // Restart: Threshold for restarting
  input_.restart_threshold_mean_error = 0.01;

  // Restart: displacement for restarting. (m)
  input_.restart_dt = 0.01;

  // Restart: displacement for restarting. (rad)
  input_.restart_dtheta = 0.026;

  // Max distance for staying in the same clustering
  input_.clustering_threshold = 0.05;

  // Number of neighbour rays used to estimate the orientation
  input_.orientation_neighbourhood = 3;

  // If 0, it's vanilla ICP
  input_.use_point_to_line_distance = 1;

  // Discard correspondences based on the angles
  input_.do_alpha_test = 0;

  // Discard correspondences based on the angles - threshold angle, in degrees
  input_.do_alpha_test_thresholdDeg = 20.0;

  // Percentage of correspondences to consider: if 0.9,
  // always discard the top 10% of correspondences with more error
  input_.outliers_maxPerc = 0.95;

  // Parameters describing a simple adaptive algorithm for discarding.
  //  1) Order the errors.
  //  2) Choose the percentile according to outliers_adaptive_order.
  //     (if it is 0.7, get the 70% percentile)
  //  3) Define an adaptive threshold multiplying outliers_adaptive_mult
  //     with the value of the error at the chosen percentile.
  //  4) Discard correspondences over the threshold.
  //  This is useful to be conservative; yet remove the biggest errors.
  input_.outliers_adaptive_order = 1.0;

  input_.outliers_adaptive_mult = 2.0;

  // If you already have a guess of the solution, you can compute the polar angle
  // of the points of one scan in the new position. If the polar angle is not a monotone
  // function of the readings index, it means that the surface is not visible in the
  // next position. If it is not visible, then we don't use it for matching.
  input_.do_visibility_test = 0;

  // no two points in laser_sens can have the same corr.
  input_.outliers_remove_doubles = 1;

  // If 1, computes the covariance of ICP using the method http://purl.org/censi/2006/icpcov
  input_.do_compute_covariance = 0;

  // Checks that find_correspondences_tricks gives the right answer
  input_.debug_verify_tricks = 0;

  // If 1, the field 'true_alpha' (or 'alpha') in the first scan is used to compute the
  // incidence beta, and the factor (1/cos^2(beta)) used to weight the correspondence.");
  input_.use_ml_weights = 0;

  // If 1, the field 'readings_sigma' in the second scan is used to weight the
  // correspondence by 1/sigma^2
  input_.use_sigma_weights = 0;

  input_.laser[0] = 0.0;
  input_.laser[1] = 0.0;
  input_.laser[2] = 0.0;

  input_.min_reading = 0.01;
  input_.max_reading = 100;

  // http://docs.ros.org/kinetic/api/csm/html/gpm_8c_source.html
  input_.gpm_theta_bin_size_deg = 1; // 5
  input_.gpm_extend_range_deg = 1;   // 15
  input_.gpm_interval = 1;

  std::string cwd("\0",FILENAME_MAX+1);
  base_path_ = getcwd(&cwd[0],cwd.capacity());
}


/*******************************************************************************
*/
  void
S2MSM::invalidateRaysRandomly(std::vector<double>* scan,
  const double& percent_invalid)
{
  if (percent_invalid > 0.0)
  {
    std::random_device rand_dev;
    std::mt19937 generator_i(rand_dev());
    std::uniform_real_distribution<double> distribution_i(0,1);

    for (int i = 0; i < scan->size(); i++)
    {
      double ii = distribution_i(generator_i);
      if (ii <= percent_invalid)
        scan->at(i) = 0.0;
    }
  }
}


/*******************************************************************************
*/
  void
S2MSM::invalidateRaysSequentially(std::vector<double>* scan,
  const double& percent_invalid)
{
  if (percent_invalid > 0.0)
  {
    // The number of invalid rays
    int num_invalid = floor(percent_invalid * scan->size());

    // Throw a dice to see from which ray forward rays are going to be invalidated
    std::random_device rand_dev;
    std::mt19937 generator_i(rand_dev());
    std::uniform_real_distribution<double> distribution_i(0, scan->size()-1);

    int start = floor(distribution_i(generator_i));
    int end = 0;

    if (start + num_invalid < scan->size())
      end = start + num_invalid;
    else
      end = scan->size();

    for (int i = start; i < end; i++)
      scan->at(i) = 0.0;
  }
}


/*******************************************************************************
*/
void S2MSM::performTests()
{
  // The base string of one dataset
  std::string base_str = base_path_ + "/../dataset/dataset_";

  // The errors, iterations, and execution times per dataset,
  // for all iterations
  std::vector< std::vector<double> > errors_n;
  std::vector< std::vector<int> > iterations_n;
  std::vector< std::vector<double> > times_n;
  std::vector< std::vector<double> > intersections_times_n;


  // The trajectory of the robot for sample 193
  std::vector< std::tuple<double,double,double> > virtual_poses;
  std::vector< std::tuple<double,double,double> > real_poses;
  getRealTrajectory(&real_poses, &virtual_poses);

  for (int n = 0; n < NUM_ITERATIONS; n++)
  {
    printf("*                               *\n");
    printf("*********************************\n");
    printf("*                               *\n");
    printf("*                               *\n");
    printf("*                               *\n");
    printf("          ITERATION #%d          \n", n);
    printf("*                               *\n");
    printf("*                               *\n");
    printf("*                               *\n");
    printf("*********************************\n");
    printf("*                               *\n");

    // The errors, iterations, and execution times per dataset, per iteration
    std::vector<double> pose_errors;
    std::vector<int> iterations;
    std::vector<double> times;
    std::vector<double> intersections_times;

    for (int i = START_SAMPLE; i < END_SAMPLE; i++)
    {
      printf("_________________________________\n");
      printf("Processing sample no. #%d\n", i);

      // The resulting pose, number of execution iterations, and execution time
      // for the i-th sample of the dataset
      std::tuple<double,double,double> result_pose;

      output_params output_params_;

      // Read dataset i
      std::string dataset_filepath_str = base_str + std::to_string(i) + ".txt";
      int l = dataset_filepath_str.length();
      char dataset_filepath_char[l+1];
      strcpy(dataset_filepath_char, dataset_filepath_str.c_str());

      // Read scan and the pose from which it was taken from the dataset
      std::vector<double> dataset_real_scan;
      std::tuple<double,double,double> dataset_real_pose;
      DatasetUtils::dataset2rangesAndPose(dataset_filepath_char,
        &dataset_real_scan, &dataset_real_pose);

      // Get the map, the real scan, the real pose, and the virtual pose
      std::vector< std::pair<double,double> > true_map;
      std::vector<double> real_scan;
      std::vector<double> virtual_scan;
      bool do_artificial_360 = true;
      bool generate_real_pose = true;

      //generateMapConfiguration(dataset_real_pose, dataset_real_scan,
      //do_artificial_360, generate_real_pose,
      //&true_map, &real_scan, &real_pose, &virtual_scan, &virtual_pose);


      for (unsigned int p = 0; p < virtual_poses.size(); p++)
      {
        std::tuple<double,double,double> real_pose = real_poses[p];
        std::tuple<double,double,double> virtual_pose = virtual_poses[p];

        generateScans(dataset_real_pose, dataset_real_scan,
          do_artificial_360, generate_real_pose,
          &true_map, real_pose, virtual_pose, &real_scan, &virtual_scan);

        Dump::rangeScan(virtual_scan, virtual_scan, scans_filename_.c_str());
        continue;

        // For design/debugging purposes
#if defined(TEST_ROTATION_ONLY_CONT) || defined(TEST_ROTATION_ONLY_DISC)
        std::get<0>(virtual_pose) = std::get<0>(real_pose);
        std::get<1>(virtual_pose) = std::get<1>(real_pose);

#if defined (TEST_ROTATION_ONLY_DISC)
        double ang_inc = 2*M_PI/real_scan.size();
        std::get<2>(virtual_pose) = std::get<2>(real_pose) + 49*ang_inc;
#endif
#endif

#if defined (TEST_TRANSLATION_ONLY)
        std::get<2>(virtual_pose) = std::get<2>(real_pose);
#endif

        // Dump initial conf
#if defined (STORE)
        std::vector< std::pair<double,double> > r;
        r = X::findExact(real_pose, true_map, real_scan.size());
        std::vector< std::pair<double,double> > v;
        v = X::findExact(virtual_pose, true_map, real_scan.size());
        Dump::points(r,v,0, base_path_ + "/../matlab/points_dump.m");
        Dump::map(true_map, base_path_ + "/../matlab/map_dump.m");
#endif

        // -----------------------------------------------------------------------
        // This is the meat ------------------------------------------------------
        testOne(real_scan, real_pose, virtual_scan, virtual_pose, true_map,
          input_params_, &output_params_, &result_pose);
        // -----------------------------------------------------------------------
        // -----------------------------------------------------------------------

        // Calculate pose error
        double pose_error = computePoseError(real_pose, result_pose);
        double position_error = computePositionError(real_pose, result_pose);
        double orientation_error = computeOrientationError(real_pose, result_pose);



        // Log results for i-th dataset
        pose_errors.push_back(pose_error);
        iterations.push_back(output_params_.translation_iterations);
        times.push_back(output_params_.exec_time);
        intersections_times.push_back(output_params_.intersections_times);

        // Log real pose
        std::ofstream real_poses_file(
          real_poses_filename_.c_str(), std::ios::app);
        if (real_poses_file.is_open())
        {
          real_poses_file <<
            std::get<0>(real_pose) << ", " <<
            std::get<1>(real_pose) << ", " <<
            std::get<2>(real_pose) << std::endl;
          real_poses_file.close();
        }

        // Log initial pose estimate
        std::ofstream initial_pose_estimates_file(
          initial_pose_estimates_.c_str(), std::ios::app);
        if (initial_pose_estimates_file.is_open())
        {
          initial_pose_estimates_file <<
            std::get<0>(virtual_pose) << ", " <<
            std::get<1>(virtual_pose) << ", " <<
            std::get<2>(virtual_pose) << std::endl;
          initial_pose_estimates_file.close();
        }

        // Log pose error
        std::ofstream pose_errors_file(
          pose_errors_filename_.c_str(), std::ios::app);
        if (pose_errors_file.is_open())
        {
          pose_errors_file << pose_error << std::endl;
          pose_errors_file.close();
        }

        // Log position error
        std::ofstream position_errors_file(
          position_errors_filename_.c_str(), std::ios::app);
        if (position_errors_file.is_open())
        {
          position_errors_file <<
            std::get<0>(real_pose) - std::get<0>(result_pose) << ", " <<
            std::get<1>(real_pose) - std::get<1>(result_pose) << ", " <<
            std::endl;
          position_errors_file.close();
        }

        // Log orientation error
        std::ofstream orientation_errors_file(
          orientation_errors_filename_.c_str(), std::ios::app);
        if (orientation_errors_file.is_open())
        {
          orientation_errors_file << orientation_error << std::endl;
          orientation_errors_file.close();
        }
      }
    }

    errors_n.push_back(pose_errors);
    iterations_n.push_back(iterations);
    times_n.push_back(times);
    intersections_times_n.push_back(intersections_times);

    printf("************************************************************************\n");
    printf("                   Final report over %d/%d iterations                   \n",
      n+1, NUM_ITERATIONS);
    printf("************************************************************************\n");
    doFinalReport(errors_n, iterations_n, times_n, intersections_times_n);
    printf("************************************************************************\n");
  }
}


/*******************************************************************************
 * Corrupt the real scan first, the map second. Test third
 */
  void
S2MSM::testOne(
  const std::vector< double >& real_scan,
  const std::tuple<double,double,double>& real_pose,
  const std::vector< double >& virtual_scan,
  const std::tuple<double,double,double>& virtual_pose,
  const std::vector< std::pair<double,double> >& map,
  const input_params& ip, output_params* op,
  std::tuple<double,double,double>* result_pose)
{
  // ---------------------------------------------------------------------------
  // real scan stuff
  // Are the real scan's ranges are corrupted by noise?
  // ---------------------------------------------------------------------------
  std::vector<double> real_scan_corrupted = real_scan;
  corruptRanges(&real_scan_corrupted, SIGMA_NOISE_REAL);

  // Invalidate some rays
  invalidateRaysRandomly(&real_scan_corrupted, INVALID_RAYS_RANDOMLY_PERCENT);

  // Invalidate a whole sequential region
  invalidateRaysSequentially(&real_scan_corrupted,
    INVALID_RAYS_SEQUENTIALLY_PERCENT);

  // ---------------------------------------------------------------------------
  // virtual scan stuff
  // Are the virtual scan's ranges are corrupted by noise?
  // ---------------------------------------------------------------------------
  std::vector<double> virtual_scan_corrupted = virtual_scan;
  corruptRanges(&virtual_scan_corrupted, SIGMA_NOISE_REAL);

  std::vector< std::pair<double,double> > virtual_scan_points;
  Utils::scan2points(virtual_scan_corrupted, virtual_pose, &virtual_scan_points);

  // SCAN-MATCHING: instead of the map you get the virtual scan points

#if defined (PRINTS)
  printf("real pose   (%f,%f,%f)\n",
    std::get<0>(real_pose),
    std::get<1>(real_pose),
    std::get<2>(real_pose));
#endif

  // Test per method
  if (METHOD.compare("FMT") == 0 || METHOD.compare("DBH") == 0
    || METHOD.compare("KU") == 0)
    Match::fmtdbh(real_scan_corrupted, virtual_pose, virtual_scan_points,
      METHOD, r2rp_, c2rp_, ip, op, result_pose);


  if (METHOD.compare("CSM") == 0)
    Match::csm(real_scan_corrupted, virtual_scan_corrupted, virtual_pose,
      &input_, &output_, ip, op, result_pose);

  if (METHOD.compare("NDT") == 0)
    Match::ndt(real_scan_corrupted, virtual_scan_corrupted, virtual_pose,
      ip, op, result_pose);


  /*
     Dump::scan(real_scan, real_pose, virtual_scan, virtual_pose,
     base_path_ + "/../scripts/scan_points_init.m");

     Dump::scan(real_scan, real_pose, virtual_scan, *result_pose,
     base_path_ + "/../scripts/scan_points_finl.m");

     Dump::rangeScan(real_scan, virtual_scan,
     base_path_ + "/../scripts/scan_dump.m");
     */

#if defined (PRINTS)
  printf("______________________________________________________________\n");
  printf("input pose  (%f,%f,%f)\n",
    std::get<0>(virtual_pose),
    std::get<1>(virtual_pose),
    std::get<2>(virtual_pose));
  printf("real pose   (%f,%f,%f)\n",
    std::get<0>(real_pose),
    std::get<1>(real_pose),
    std::get<2>(real_pose));
  printf("output pose (%f,%f,%f)\n",
    std::get<0>(*result_pose),
    std::get<1>(*result_pose),
    std::get<2>(*result_pose));
  printf("______________________________________________________________\n");
#endif
}
