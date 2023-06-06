#ifndef ROTATION_H
#define ROTATION_H

#include <vector>
#include <tuple>
#include <utility>
#include <math.h>
#include <chrono>
#include <assert.h>
#include <eigen3/Eigen/Geometry>

#include <defines.h>
#include <utils.h>
#include <find.h>
#include <intersections.h>
#include <dft_utils.h>
#include <fftw3.h>



class Rotation
{
  public:

    static double angleById(const unsigned int& rotation_id,
      const unsigned int scan_size);

    static void coarse(
      const std::vector< double >& real_scan,
      const std::vector<double>& real_scan_points_vectors_norm,
      const double& real_ip,
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& num_rays,
      std::tuple<double,double,double>* result_pose);

    static std::vector<double> dbh(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      const std::string& batch_or_sequential,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    /***************************************************************************
     * DBH sequential execution functions (slower)
     */
    static std::vector<double> dbh2Sequential(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    static void dbh1Sequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::pair<double,double> >& virtual_scan_points,
      double* angle, double* snr, double* fahm, double* pd);

    static void dbh0Sequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::pair<double,double> >& virtual_scan_points,
      std::vector<double>* traces, unsigned int* traces_max_id);

    static void dbh0AutoSequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      std::vector<double>* traces, unsigned int* traces_max_id);

    /***************************************************************************
     * DBH batch execution functions (faster)
     */
    static std::vector<double> dbh2Batch(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    static void dbh1Batch(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::vector< std::pair<double,double> > >& virtual_scan_points,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* angle,
      std::vector<double>* snr,
      std::vector<double>* fahm,
      std::vector<double>* pd);

    static void dbh0Batch(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::vector< std::pair<double,double> > >& virtual_scan_points_in,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector< std::vector<double> >* traces_v,
      std::vector< unsigned int>* traces_max_id_v);

    static void dbh0AutoBatch(
      const std::vector< std::vector< std::pair<double,double> > >&
      virtual_scan_points_in_v,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector< std::vector<double> >* traces_v,
      std::vector< unsigned int>* traces_max_id_v);


    static std::vector<double> fmt(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      const std::string& batch_or_sequential,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    /***************************************************************************
     * FMT sequential execution functions (slower)
     */
    static std::vector<double> fmt2Sequential(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    static void fmt1Sequential(
      const std::vector< double >& real_scan,
      const std::vector< double >& virtual_scan,
      double* angle, double* snr, double* fahm, double* pd);

    static void fmt0Sequential(
      const std::vector< double >& real_scan,
      const std::vector< double >& virtual_scan,
      std::vector<double>* q_0,
      unsigned int* q_0_max_id);

    static void fmt0AutoSequential(
      const std::vector< double >& real_scan,
      std::vector<double>* q_0,
      unsigned int* q_0_max_id);

    /***************************************************************************
     * FMT batch execution functions (faster)
     */
    static std::vector<double> fmt2Batch(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    static void fmt1Batch(
      const std::vector< double >& real_scan,
      const std::vector< std::vector< double > >& virtual_scans,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector<double>* angle,
      std::vector<double>* snr,
      std::vector<double>* fahm,
      std::vector<double>* pd);

    static void fmt0Batch(
      const std::vector<double>& real_scan,
      const std::vector< std::vector<double> > & virtual_scans,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector< std::vector<double> >* q_0_v,
      std::vector<unsigned int>* q_0_max_id_v);

    static void fmt0AutoBatch(
      const std::vector< std::vector<double> > & virtual_scans,
      const fftw_plan& r2rp, const fftw_plan& c2rp,
      std::vector< std::vector<double> >* q_0_v,
      std::vector<unsigned int>* q_0_max_id_v);

    static unsigned int findRotationId(
      const std::vector<double>& real_scan,
      const std::vector<double>& virtual_scan_it,
      const std::vector<double>& real_scan_points_vectors_norm,
      const double& real_ip,
      const unsigned int& rotation_fashion);

    static bool fromEllipse2(
      const std::vector< double >& real_scan,
      std::vector<double> real_ellipse_coefficients,
      const std::tuple<double,double,double>& current_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& num_rays,
      std::tuple<double,double,double>* result_pose);

    /***************************************************************************
     * KU sequential execution functions (slower)
     */
    static std::vector<double> ku2Sequential(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      const unsigned int& magnification_size,
      std::vector<double>* rc0, std::vector<double>* rc1,
      std::chrono::duration<double>* intersections_time);

    static void ku1Sequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::pair<double,double> >& virtual_scan_points,
      double* angle, double* snr, double* fahm, double* pd);

    static void ku0Sequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::vector< std::pair<double,double> >& virtual_scan_points,
      std::vector<double>* traces, unsigned int* traces_max_id);

    static void ku0AutoSequential(
      const std::vector< std::pair<double,double> >& real_scan_points,
      std::vector<double>* traces, unsigned int* traces_max_id);

    static std::vector<unsigned int> rankDBHOutput(
      const std::vector<double>& snr,
      const std::vector<double>& fahm,
      const std::vector<double>& pd,
      const unsigned int& method,
      const unsigned int& magnification_size,
      const double& pd_threshold);

    static std::vector<unsigned int> rankFMTOutput(
      const std::vector<double>& snr,
      const std::vector<double>& fahm,
      const std::vector<double>& pd,
      const unsigned int& method,
      const unsigned int& magnification_size,
      const double& pd_threshold);

    static std::vector<unsigned int> rankKUOutput(
      const std::vector<double>& snr,
      const std::vector<double>& fahm,
      const std::vector<double>& pd,
      const unsigned int& method,
      const unsigned int& magnification_size,
      const double& pd_threshold);

    static std::pair<double,double> skg1(
      const std::vector< double >& real_scan,
      const std::tuple<double,double,double>& virtual_pose,
      const std::vector< std::pair<double,double> >& map,
      double* dt);

    static std::pair<double,double> skg2(
      const std::vector< double >& real_scan_in,
      const std::vector< std::pair<double,double> >& real_scan_points,
      const std::tuple<double,double,double>& virtual_pose_in,
      const std::vector< std::pair<double,double> >& map,
      std::tuple<double,double,double>* result_pose,
      const bool& use_centroids,
      const int& magnification_size);

};

#endif
