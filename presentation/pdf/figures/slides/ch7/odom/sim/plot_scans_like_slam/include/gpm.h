#ifndef H_GPM_STRIPPED_DOWN
#define H_GPM_STRIPPED_DOWN

#include <gsl/gsl_vector.h>
#include <gsl/gsl_histogram.h>
#include <gsl/gsl_matrix.h>
#include "csm/csm_all.h"
#include <egsl/egsl_macros.h>

void ght_find_theta_range(LDP laser_ref, LDP laser_sens,
  const double*x0, double max_linear_correction,
  double max_angular_correction_deg, int interval, gsl_histogram*hist, int*num_correspondences);

void ght_one_shot(LDP laser_ref, LDP laser_sens,
  const double*x0, double max_linear_correction,
  double max_angular_correction_deg, int interval, double*x, int*num_correspondences) ;

void sm_gpm(struct sm_params*params, struct sm_result*res);


#endif
