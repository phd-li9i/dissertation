#ifndef NOISE_H
#define NOISE_H

#include <vector>
#include <math.h>
#include <assert.h>
#include <defines.h>


class Noise
{
  public:

    static std::vector<double> smooth(const std::vector<double>& scan,
      const double& window_angle);

    static std::vector<double> smooth(const std::vector<double>& scan,
      const int& window_length);

    static double window(const std::vector<double>& vec,
      const int& sz, const int& mid_id);
};

#endif
