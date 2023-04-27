#ifndef DUMP_H
#define DUMP_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>
#include <iostream>
#include <fstream>
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

class Dump
{
  public:

    static void scan(
      const std::vector<double>& real_scan,
      const std::tuple<double,double,double>& real_pose,
      const std::vector<double>& virtual_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::string& dump_filepath);

    static void rangeScan(
      const std::vector<double>& real_scan,
      const std::vector<double>& virtual_scan,
      const std::string& dump_filepath);

    static void map(const std::vector< std::pair<double,double> >& map,
      const std::string& dump_filepath);

    static void points(const std::vector< std::pair<double,double> >& real_points,
      const std::vector< std::pair<double,double> >& virtual_points,
      const unsigned int& id,
      const std::string& dump_filepath);

    static void polygon(const Polygon_2& poly, const std::string& dump_filepath);

    static void polygons(const Polygon_2& real_poly,
      const Polygon_2& virtual_poly,
      const std::string& dump_filepath);

    static void pose(const std::tuple<double,double,double>& pose,
      const std::string& dump_filepath);

    static void convexHulls(const std::vector<Point_2>& real_hull,
      const std::vector<Point_2>& virtual_hull,
      const std::string& dump_filepath);

};

#endif
