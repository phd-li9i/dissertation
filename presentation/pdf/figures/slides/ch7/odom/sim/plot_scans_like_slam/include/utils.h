#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>
#include <random>
#include <boost/random/normal_distribution.hpp>
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/variate_generator.hpp>
#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Filtered_kernel.h>
#include <CGAL/Cartesian.h>
#include <CGAL/Polygon_2.h>
#include <CGAL/convex_hull_2.h>
#include <CGAL/minimum_enclosing_quadrilateral_2.h>
#include <CGAL/squared_distance_2.h>
#include <CGAL/Min_ellipse_2.h>
#include <CGAL/Min_ellipse_2_traits_2.h>
#include <intersections.h>
#include <defines.h>


typedef CGAL::Exact_predicates_inexact_constructions_kernel Kernel;
typedef Kernel::Point_2                       Point_2;
typedef Kernel::Vector_2                      Vector_2;
typedef CGAL::Polygon_2<Kernel>               Polygon_2;
typedef Polygon_2::Vertex_iterator            VertexIterator;
typedef CGAL::Min_ellipse_2_traits_2<Kernel>  Traits;
typedef CGAL::Min_ellipse_2<Traits>           Min_ellipse;

class Utils
{
  public:

    static std::pair<double,double> computeDeltaXY(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::pair<double,double> >& virtual_scan_points);

    static std::pair<double,double> computeDeltaXY(
      const std::vector<double>& real_scan,
      const std::tuple<double,double,double>& real_pose,
      const std::vector<double>& virtual_scan,
      const std::tuple<double,double,double>& virtual_pose);

    static std::vector< std::pair<double, double> > conjugate(
      const std::vector< std::pair<double, double> >& vec);

    static void diffScansPerRay(
      const std::vector<double>& scan1, const std::vector<double>& scan2,
      const double& inclusion_bound, std::vector<double>* diff,
      std::vector<double>* diff_true);

    static void generatePose(
      const std::tuple<double,double,double>& real_pose,
      const double& dxy, const double& dt,
      std::tuple<double,double,double>* virtual_pose);

    static bool generatePose(
      const std::tuple<double,double,double>& base_pose,
      const std::vector< std::pair<double,double> >& map,
      const double& dxy, const double& dt, const double& dist_threshold,
      std::tuple<double,double,double>* real_pose);

    static bool generatePoseWithinMap(
      const std::vector< std::pair<double,double> >& map,
      const double& dist_threshold,
      std::tuple<double,double,double>* pose);

    static bool isPositionInMap(
      const std::tuple<double, double, double>& pose,
      const std::vector< std::pair<double,double> >& map);

    static bool isPositionFartherThan(
      const std::tuple<double, double, double>& pose,
      const std::vector< std::pair<double,double> >& map,
      const double& dist);

    static std::vector<double> innerProduct(const std::vector<double>& vec1,
      const std::vector<double>& vec2);

    static std::vector< std::pair<double, double> > innerProductComplex(
      const std::vector< std::pair<double, double> >& vec1,
      const std::vector< std::pair<double, double> >& vec2);

    static std::pair<double,double> multiplyWithRotationMatrix(
      const std::pair<double,double>& point, const double& angle);

    static std::vector< std::pair<double,double> > multiplyWithRotationMatrix(
      const std::vector< std::pair<double,double> >& points,
      const double& angle);

    static double norm(const std::pair<double,double>& vec);
    static std::vector<double> norm(
      const std::vector< std::pair<double,double> >& vec);
    static double norm2(const std::vector< std::pair<double,double> >& vec);

    static std::pair<double,double> pairDiff(
      const std::pair<double,double>& pair1,
      const std::pair<double,double>& pair2);

    static void points2scan(
      const std::vector< std::pair<double,double> >& points,
      const std::tuple<double,double,double>& pose,
      std::vector<double>* scan);

    static void scan2points(
      const std::vector<double>& scan,
      const std::tuple<double,double,double> pose,
      std::vector< std::pair<double,double> >* points,
      const double& angle_span = 2*M_PI);

    static void scanFromPose(
      const std::tuple<double,double,double>& pose,
      const std::vector< std::pair<double,double> >& points,
      const unsigned int& num_rays,
      std::vector<double>* scan);

    static int sgn(const double& a);

    static std::vector< std::pair<double,double> > vectorDiff(
      const std::vector< std::pair<double,double> >& vec);

    static std::pair<double,double> vectorStatistics(
      const std::vector< double >& v);

    static void wrapAngle(double* angle);

};

#endif
