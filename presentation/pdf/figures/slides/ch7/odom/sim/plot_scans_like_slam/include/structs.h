#ifndef STRUCT_DEFINES_H
#define STRUCT_DEFINES_H

struct input_params
{
  unsigned int num_iterations;
  double xy_bound;
  double t_bound;
  double sigma_noise_real;
  double sigma_noise_map;
};

struct output_params
{
  double exec_time;
  double rotation_times;
  double translation_times;
  double rotation_iterations;
  double translation_iterations;
  double intersections_times;
  unsigned int num_recoveries;
  std::vector< std::tuple<double,double,double> > trajectory;

  // Rotation criterion
  double rc;

  // Translation criterion
  double tc;

  output_params()
  {
    exec_time = 0;
    rotation_times = 0;
    translation_times = 0;
    rotation_iterations = 0;
    translation_iterations = 0;
    intersections_times = 0;
    num_recoveries = 0;
    rc = 0;
    tc = 0;
  };
};
#endif // STRUCT_DEFINES_H
