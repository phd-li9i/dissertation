#ifndef CS2MSM_H
#define CS2MSM_H

#include <memory>
#include <vector>
#include <chrono>
#include <signal.h>
#include <cmath>
#include <numeric>
#include <iostream>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <time.h>
#include <tuple>
#include <functional>
#include <utils.h>
#include <intersections.h>

#include <csm/csm_all.h>  // csm defines min and max, but Eigen complains

class CS2MSM
{

  public:

    static void convertRealScanToLDP(const std::vector<double>& scan,
      const std::tuple<double,double,double>&pose,
      LDP& ldp);

    static void convertVirtualScanToLDP(const std::vector<double>& scan,
      const std::tuple<double,double,double>& virtual_pose,
      LDP& ldp);

    static void convertScanToLDP(const std::vector<double>& scan, LDP& ldp);

};

#endif // CS2MSM_H
