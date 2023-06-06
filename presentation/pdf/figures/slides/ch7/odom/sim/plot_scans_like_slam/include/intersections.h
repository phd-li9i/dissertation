#ifndef INTERSECTIONS_H
#define INTERSECTIONS_H

#include <math.h>
#include <assert.h>
#include <vector>
#include <tuple>
#include <chrono>
#include <utils.h>
#include <defines.h>


class X
{
  public:

    static std::vector< std::pair<double,double> > find(
      const std::tuple<double,double,double>& pose,
      const std::vector< std::pair<double, double> >& lines,
      const unsigned int& num_rays);

    static std::vector< std::pair<double,double> > findApprox(
      const std::tuple<double,double,double>& pose,
      const std::vector< std::pair<double, double> >& lines,
      const unsigned int& num_rays);

    static std::vector< std::pair<double,double> > findExact(
      const std::tuple<double,double,double>& pose,
      const std::vector< std::pair<double, double> >& lines,
      const unsigned int& num_rays);

    static std::vector< std::pair<double,double> > findExact2(
      const std::tuple<double,double,double>& pose,
      const std::vector< std::pair<double, double> >& lines,
      const unsigned int& num_rays);

    static bool findExactOneRay(
      const double& px, const double& py, const double& tan_t_ray,
      const double& x_far, const double& y_far,
      const std::vector< std::pair<double, double> >& lines,
      const int& start_search_id, const int& end_search_id,
      const bool& tan_peligro,
      std::pair<double,double>* intersection_point,
      int* start_segment_id);

};

#endif
