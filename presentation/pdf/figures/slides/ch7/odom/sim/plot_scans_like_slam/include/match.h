#ifndef MATCH_H
#define MATCH_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>

#include <utils.h>
#include <rotation.h>
#include <translation.h>
#include <find.h>
#include <defines.h>
#include <structs.h>
#include <dump.h>
#include <fftw3.h>

#include <pcl/point_types.h>
#include <pcl/registration/ndt.h>
#include <pcl/filters/approximate_voxel_grid.h>
#include <boost/thread/thread.hpp>
#include <pcl/console/time.h>

#include <cs2msm.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_histogram.h>
#include <gsl/gsl_matrix.h>
#include <egsl/egsl_macros.h>


class Match
{
  public:

    static bool canGiveNoMore(
      const std::vector<double>& xs,
      const std::vector<double>& ys,
      const std::vector<double>& ts,
      const double& xy_eps,
      const double& t_eps);

    static void csm(
      const std::vector< double >& real_scan,
      const std::vector< double >& virtual_scan,
      const std::tuple<double,double,double>& virtual_pose,
      sm_params* input_,
      sm_result* output_,
      const input_params& ip, output_params* op,
      std::tuple<double,double,double>* result_pose);

    static void fmtdbh(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const std::string& match_method,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      const input_params& ip, output_params* op,
      std::tuple<double,double,double>* result_pose);

    static void ndt(
      const std::vector< double >& real_scan,
      const std::vector< double >& virtual_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const input_params& ip, output_params* op,
      std::tuple<double,double,double>* result_pose);

    static void l2recovery(
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const double& xy_bound, const double& t_bound,
      std::tuple<double,double,double>* result_pose);

    static void skg(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& real_pose,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const fftw_plan& r2rp,
      const input_params& ip, output_params* op,
      std::tuple<double,double,double>* result_pose);

    static void skgIt(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& real_pose,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& max_translation_iterations,
      const double& xy_bound, const double& t_bound,
      int* result_iterations,
      double* result_time,
      double* intersections_time,
      std::tuple<double,double,double>* result_pose);

};

#endif
