#ifndef DFT_UTILS_H
#define DFT_UTILS_H

#include <iostream>
#include <assert.h>
#include <chrono>
#include <stdlib.h>
#include <time.h>
#include <cmath>
#include <vector>
#include <algorithm>    // std::rotate
#include <fftw3.h>
#include <defines.h>


class DFTUtils
{
  public:


    /***************************************************************************
    */
    static void fftshift(std::vector<double>* vec);

    /***************************************************************************
     * @brief Calculates the X1 coefficient of the rays_diff input vector.
     * @param[in] rays_diff [const std::vector<double>&] The difference in range
     * between a world and a map scan.
     * @return [std::vector<double>] A vector of size two, of which the first
     * position holds the real part of the first DFT coefficient, and the
     * second the imaginary part of it.
     */
    static std::vector<double> getFirstDFTCoefficient(
      const std::vector<double>& rays_diff);

    static std::vector<double> getFirstDFTCoefficient(
      const std::vector<double>& rays_diff,
      const fftw_plan& r2rp);

    /***************************************************************************
    */
    static std::vector< std::pair<double, double> >
      getDFTCoefficientsPairs(const std::vector<double>& coeffs);

    /***************************************************************************
     * @brief Performs DFT in a vector of doubles via fftw. Returns the DFT
     * coefficients vector in the order described in
     * http://www.fftw.org/fftw3_doc/Real_002dto_002dReal-Transform-Kinds.html#Real_002dto_002dReal-Transform-Kinds.
     * @param[in] rays_diff [const std::vector<double>&] The vector of differences
     * in range between a world scan and a map scan.
     * @return [std::vector<double>] The vector's DFT coefficients.
     */
    static std::vector<double> dft(const std::vector<double>& rays_diff);

    static std::vector<double> dft(const std::vector<double>& rays_diff,
      const fftw_plan& r2rp);

    static std::vector< std::vector<double> > dftBatch(
      const std::vector< std::vector<double> >& scans);

    static std::vector< std::vector<double> > dftBatch(
      const std::vector< std::vector<double> >& scans,
      const fftw_plan& r2rp);

    /***************************************************************************
    */
    static std::vector<double> idft(
      const std::vector<std::pair<double, double> >& rays_diff);

    static std::vector< std::vector<double> > idftBatch(
      const std::vector< std::vector<std::pair<double, double> > >& scans);

    static std::vector< std::vector<double> > idftBatch(
      const std::vector< std::vector<std::pair<double, double> > >& scans,
      const fftw_plan& c2rp);
};

#endif // DFT_UTILS_H
