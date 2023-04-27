#ifndef SCAN_COMPLETION_H
#define SCAN_COMPLETION_H

#include <assert.h>
#include <vector>
#include <tuple>
#include <utility> // pair
#include <algorithm> // rotate, std::min_element, std::max_element
#include <math.h>
#include <intersections.h>
#include <utils.h>
#include <defines.h>



class ScanCompletion
{
  public:

    static void completeScan(std::vector<double>* scan, const int& method);

    static void completeScan1(std::vector<double>* scan);

    static void completeScan2(std::vector<double>* scan,
      const std::tuple<double,double,double>& pose);

    static void completeScan3(std::vector<double>* scan);

    static void completeScan4(std::vector<double>* scan);

    static void completeScan5(
      const std::tuple<double,double,double>& pose,
      const std::vector<double>& scan_in,
      const unsigned int& num_rays,
      std::vector<double>* scan_out,
      std::vector< std::pair<double,double> >* map,
      std::tuple<double,double,double>* map_origin);
};

#endif
