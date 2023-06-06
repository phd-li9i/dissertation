#ifndef TRANSLATION_H
#define TRANSLATION_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>
#include <utils.h>
#include <find.h>
#include <intersections.h>
#include <dft_utils.h>
#include <defines.h>
#include <fftw3.h>



class Translation
{
  public:

    static double tff(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const int& max_iterations,
      const double& dist_bound,
      const bool& pick_min,
      const fftw_plan& r2rp,
      int* iterations,
      std::chrono::duration<double>* intersections_time,
      std::tuple<double,double,double>* result_pose);

    static std::pair<double,double> tffCore(
      const std::vector< double >& real_scan,
      const std::vector< double >& virtual_scan,
      const double& current_t,
      const double& bound,
      const fftw_plan& r2rp,
      std::vector<double>* d_v,
      double* norm_x1);

    static std::vector<double> turnDFTCoeffsIntoErrors(
      const std::vector<double>& dft_coeff,
      const int& num_valid_rays,
      const double& starting_angle);

};

#endif
