#ifndef DATSET_UTILS_H
#define DATSET_UTILS_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <assert.h>
#include <utils.h>
#include <defines.h>


class DatasetUtils
{
  public:

    static std::vector< std::vector< std::pair<double,double> > >
      dataset2points(const char* dataset_filepath);

    static void dataset2rangesAndPose(
      const char* dataset_filepath,
      std::vector<double>* ranges,
      std::tuple<double,double,double>* pose);

    static void readDataset(
      const char* filepath,
      std::vector< std::vector<double> >* ranges,
      std::vector< std::tuple<double,double,double> >* poses);

    static void readDataset(
      const char* filepath,
      std::vector<double>* range,
      std::tuple<double,double,double>* pose);

    static void printDataset(const char* dataset_filepath);

    static void splitDataset();

};

#endif
