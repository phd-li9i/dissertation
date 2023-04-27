#ifndef FIND_H
#define FIND_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>
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

class Find
{
  public:

    static double area(
      const std::vector< std::pair<double,double> >& polygon);

    static std::pair<double,double> centroid(
      const std::vector< std::pair<double,double> >& polygon);

    static std::pair<double, double> closestPoint(
      const std::pair<double, double>& pose,
      const std::vector< std::pair<double,double> >& points);

    static void boundingEllipse(
      const std::vector< std::pair<double,double> >& points,
      std::vector<double>* coefficients);

    static std::pair<double, double> ellipseAxesPoints(
      const std::vector<double>& coefficients);

    static std::pair<double, double> ellipseCenter(
      const std::vector<double>& coefficients);

    static double ellipseAngle(const std::vector<double>& coefficients);

    static std::pair<double, double> furthestPoint(
      const std::pair<double, double>& pose,
      const std::vector< std::pair<double,double> >& points);

    static std::vector< std::pair<double,double> > points2convexHullPoints
      (const std::vector< std::pair<double,double> >& points);

    static void scansFromConvexHull(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      std::vector< double >* real_scan2,
      std::vector< double >* virtual_scan2);

};

#endif
