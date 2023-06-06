#include "intersections.h"


/*******************************************************************************
*/
std::vector< std::pair<double,double> > X::find(
  const std::tuple<double,double,double>& pose,
  const std::vector< std::pair<double, double> >& lines,
  const unsigned int& num_rays)
{
  return findExact2(pose, lines, num_rays);
}


/*******************************************************************************
*/
std::vector< std::pair<double,double> > X::findApprox(
  const std::tuple<double,double,double>& pose,
  const std::vector< std::pair<double, double> >& lines,
  const unsigned int& num_rays)
{
#ifdef TIMES
  std::chrono::high_resolution_clock::time_point a =
    std::chrono::high_resolution_clock::now();
#endif

  double px = std::get<0>(pose);
  double py = std::get<1>(pose);
  double pt = std::get<2>(pose);

  std::vector< std::pair<double,double> > intersections;
  double mul = 100000000.0;

  int segid = 0;

  bool check_lower_segment = true;
  for (int i = 0; i < num_rays; i++)
  {
    double t_ray = i * 2*M_PI / num_rays + pt - M_PI;
    Utils::wrapAngle(&t_ray);
    double x_far = px + mul*cos(t_ray);
    double y_far = py + mul*sin(t_ray);


    double tan_t_ray = tan(t_ray);
    bool tan_peligro = false;
    if (fabs(fabs(t_ray) - M_PI/2) < 0.0001)
      //if (fabs(fabs(t_ray) - M_PI/2) == 0.0)
      tan_peligro = true;


    std::vector< std::pair<double,double> > candidate_points;
    std::pair<double,double> intersection_point;

    bool intersection_found = false;
    int counter = 0;

    while(!intersection_found)
    {
      intersection_found = false;

      if (check_lower_segment)
        segid = i;

      int upper_segment_id = fmod(segid+counter,lines.size());
      int lower_segment_id;

      if (segid != 0)
        check_lower_segment = false;
      else
        lower_segment_id = lines.size()-1 + fmod(segid-counter, lines.size());

      ////////////////////////////////////
      // Check the upper segment always //
      ////////////////////////////////////

      // The index of the first sensed point
      int idx_1 = upper_segment_id;

      // The index of the second sensed point (in counter-clockwise order)
      int idx_2;

      if (idx_1 >= lines.size()-1)
        idx_2 = 0;
      else
        idx_2 = idx_1 + 1;

      double det_1 =
        (lines[idx_1].first-px)*(lines[idx_2].second-py)-
        (lines[idx_2].first-px)*(lines[idx_1].second-py);

      double det_2 =
        (lines[idx_1].first-x_far)*(lines[idx_2].second-y_far)-
        (lines[idx_2].first-x_far)*(lines[idx_1].second-y_far);

      if (det_1 * det_2 <= 0.0)
      {
        double det_3 =
          (px-lines[idx_1].first)*(y_far-lines[idx_1].second)-
          (x_far-lines[idx_1].first)*(py-lines[idx_1].second);

        double det_4 =
          (px-lines[idx_2].first)*(y_far-lines[idx_2].second)-
          (x_far-lines[idx_2].first)*(py-lines[idx_2].second);

        if (det_3 * det_4 <= 0.0)
        {
          // They intersect!
          intersection_found = true;

          segid = idx_1;

          double tan_two_points =
            (lines[idx_2].second - lines[idx_1].second) /
            (lines[idx_2].first - lines[idx_1].first);

          double x = 0.0;
          double y = 0.0;

          if (!tan_peligro)
          {
            x = (py - lines[idx_1].second + tan_two_points * lines[idx_1].first
              -tan_t_ray * px) / (tan_two_points - tan_t_ray);

            y = py + tan_t_ray * (x - px);
          }
          else
          {
            x = px;
            y = lines[idx_1].second + tan_two_points * (x - lines[idx_1].first);
            //y = (lines[idx_2].second + lines[idx_1].second)/2;
          }


          intersection_point = std::make_pair(x,y);
          candidate_points.push_back(intersection_point);

          // Snatch the first intersection point and don't look for no others
          break;
        }
      }


      /////////////////////////////////
      // Check the lower segment now //
      /////////////////////////////////

      if (check_lower_segment)
      {
        // The index of the first sensed point
        int idx_1 = lower_segment_id;
        int idx_2;

        if (idx_1 > lines.size() - 1)
          idx_2 = 0;
        else if (idx_1 > 0)
          idx_2 = idx_1 - 1;
        else
          idx_2 = lines.size() - 1;


        double det_1 =
          (lines[idx_1].first-px)*(lines[idx_2].second-py)-
          (lines[idx_2].first-px)*(lines[idx_1].second-py);

        double det_2 =
          (lines[idx_1].first-x_far)*(lines[idx_2].second-y_far)-
          (lines[idx_2].first-x_far)*(lines[idx_1].second-y_far);

        if (det_1 * det_2 <= 0.0)
        {
          double det_3 =
            (px-lines[idx_1].first)*(y_far-lines[idx_1].second)-
            (x_far-lines[idx_1].first)*(py-lines[idx_1].second);

          double det_4 =
            (px-lines[idx_2].first)*(y_far-lines[idx_2].second)-
            (x_far-lines[idx_2].first)*(py-lines[idx_2].second);

          if (det_3 * det_4 <= 0.0)
          {
            // They intersect!
            intersection_found = true;

            segid = idx_1;

            double tan_two_points =
              (lines[idx_2].second - lines[idx_1].second) /
              (lines[idx_2].first - lines[idx_1].first);

            double x = 0.0;
            double y = 0.0;

            if (!tan_peligro)
            {
              x = (py - lines[idx_1].second + tan_two_points * lines[idx_1].first
                -tan_t_ray * px) / (tan_two_points - tan_t_ray);

              y = py + tan_t_ray * (x - px);
            }
            else
            {
              x = px;
              y = lines[idx_1].second + tan_two_points * (x - lines[idx_1].first);
              //y = (lines[idx_2].second + lines[idx_1].second)/2;
            }

            intersection_point = std::make_pair(x,y);
            candidate_points.push_back(intersection_point);

            // Snatch the first intersection point and don't look for no others
            break;
          }
        }
      }

      counter++;
    }

    /*
       double min_r = 1000000.0;
       int idx = -1;
       for (int c = 0; c < candidate_points.size(); c++)
       {
       double dx = candidate_points[c].first - px;
       double dy = candidate_points[c].second - py;
       double ra = sqrt(dx*dx+dy*dy);

       if (ra <= min_r)
       {
       min_r = ra;
       idx = c;
       }
       }
       assert(idx >= 0);
       */
    int idx = 0;

    intersections.push_back(
      std::make_pair(candidate_points[idx].first, candidate_points[idx].second));
  }

#ifdef TIMES
  std::chrono::high_resolution_clock::time_point b =
    std::chrono::high_resolution_clock::now();

  std::chrono::duration<double> elapsed =
    std::chrono::duration_cast< std::chrono::duration<double> >(b-a);

  printf("%f [X::findApprox]\n", elapsed.count());
#endif
  return intersections;
}


/*******************************************************************************
 * This is the alter ego of findApprox, the thorough approach
 */
std::vector< std::pair<double,double> > X::findExact(
  const std::tuple<double,double,double>& pose,
  const std::vector< std::pair<double, double> >& lines,
  const unsigned int& num_rays)
{
#ifdef TIMES
  std::chrono::high_resolution_clock::time_point a =
    std::chrono::high_resolution_clock::now();
#endif

  double px = std::get<0>(pose);
  double py = std::get<1>(pose);
  double pt = std::get<2>(pose);

  std::vector< std::pair<double,double> > intersections;
  double mul = 100000000.0;

  for (int i = 0; i < num_rays; i++)
  {
    double t_ray = i * 2*M_PI / num_rays + pt - M_PI;
    Utils::wrapAngle(&t_ray);

    double x_far = px + mul*cos(t_ray);
    double y_far = py + mul*sin(t_ray);


    double tan_t_ray = tan(t_ray);
    bool tan_peligro = false;
    //if (fabs(fabs(t_ray) - M_PI/2) == 0.0)
    if (fabs(fabs(t_ray) - M_PI/2) < 0.0001)
      tan_peligro = true;


    std::vector< std::pair<double,double> > candidate_points;

    for (int l = 0; l < lines.size(); l++)
    {
      // The index of the first sensed point
      int idx_1 = l;

      // The index of the second sensed point (in counter-clockwise order)
      int idx_2 = idx_1 + 1;

      if (idx_2 >= lines.size())
        idx_2 = fmod(idx_2, lines.size());

      if (idx_1 >= lines.size())
        idx_1 = fmod(idx_1, lines.size());

      double det_1 =
        (lines[idx_1].first-px)*(lines[idx_2].second-py)-
        (lines[idx_2].first-px)*(lines[idx_1].second-py);

      double det_2 =
        (lines[idx_1].first-x_far)*(lines[idx_2].second-y_far)-
        (lines[idx_2].first-x_far)*(lines[idx_1].second-y_far);

      if (det_1 * det_2 <= 0.0)
      {
        double det_3 =
          (px-lines[idx_1].first)*(y_far-lines[idx_1].second)-
          (x_far-lines[idx_1].first)*(py-lines[idx_1].second);

        double det_4 =
          (px-lines[idx_2].first)*(y_far-lines[idx_2].second)-
          (x_far-lines[idx_2].first)*(py-lines[idx_2].second);

        if (det_3 * det_4 <= 0.0)
        {
          // They intersect!

          double tan_two_points =
            (lines[idx_2].second - lines[idx_1].second) /
            (lines[idx_2].first - lines[idx_1].first);

          double x = 0.0;
          double y = 0.0;

          if (!tan_peligro)
          {
            x = (py - lines[idx_1].second + tan_two_points * lines[idx_1].first
              -tan_t_ray * px) / (tan_two_points - tan_t_ray);

            y = py + tan_t_ray * (x - px);
          }
          else
          {
            x = px;
            y = lines[idx_1].second + tan_two_points * (x - lines[idx_1].first);
            //y = (lines[idx_2].second + lines[idx_1].second)/2;
          }


          candidate_points.push_back(std::make_pair(x,y));
        }
      }
    }

    double min_r = 100000000.0;
    int idx = -1;
    for (int c = 0; c < candidate_points.size(); c++)
    {
      double dx = candidate_points[c].first - px;
      double dy = candidate_points[c].second - py;
      double r = dx*dx+dy*dy;

      if (r < min_r)
      {
        min_r = r;
        idx = c;
      }
    }

    assert(idx >= 0);

    intersections.push_back(
      std::make_pair(candidate_points[idx].first, candidate_points[idx].second));
  }

#ifdef TIMES
  std::chrono::high_resolution_clock::time_point b =
    std::chrono::high_resolution_clock::now();

  std::chrono::duration<double> elapsed =
    std::chrono::duration_cast< std::chrono::duration<double> >(b-a);

  printf("%f [X::findExact]\n", elapsed.count());
#endif

  return intersections;
}


/*******************************************************************************
 */
std::vector< std::pair<double,double> > X::findExact2(
  const std::tuple<double,double,double>& pose,
  const std::vector< std::pair<double, double> >& lines,
  const unsigned int& num_rays)
{
#ifdef TIMES
  std::chrono::high_resolution_clock::time_point a =
    std::chrono::high_resolution_clock::now();
#endif

  double px = std::get<0>(pose);
  double py = std::get<1>(pose);
  double pt = std::get<2>(pose);

  std::vector< std::pair<double,double> > intersections;
  double mul = 100000000.0;


  int start0 = 0;
  int end0 = lines.size();

  for (int i = 0; i < num_rays; i++)
  {
    double t_ray = i * 2*M_PI / num_rays + pt - M_PI;
    Utils::wrapAngle(&t_ray);

    double x_far = px + mul*cos(t_ray);
    double y_far = py + mul*sin(t_ray);


    double tan_t_ray = tan(t_ray);
    bool tan_peligro = false;
    //if (fabs(fabs(t_ray) - M_PI/2) == 0.0)
    if (fabs(fabs(t_ray) - M_PI/2) < 0.0001)
      tan_peligro = true;


    std::pair<double,double> intersection_point;
    int segment_id;
    bool success = false;
    int inc = lines.size()/16;

    // Start off with the first ray. Scan the whole `lines` vector and find
    // the index of the segment the first ray hits. This index becomes the
    // starting index from which the second ray shall start searching. The last
    // segment the second ray shall end at is defined by `inc`. And do this
    // for all rays.
    // IF there is no intersection between [start, start+inc] then start from
    // start+inc and go up to start+2inc... and do this until you find a hit.
    while(!success)
    {
      success = findExactOneRay(px,py,tan_t_ray, x_far,y_far,lines,
        start0, end0, tan_peligro,
        &intersection_point, &segment_id);

      if (success)
        start0 = segment_id;
      else
        start0 += inc;

      end0 = start0 + inc;
    }

    intersections.push_back(intersection_point);
  }

#ifdef TIMES
  std::chrono::high_resolution_clock::time_point b =
    std::chrono::high_resolution_clock::now();

  std::chrono::duration<double> elapsed =
    std::chrono::duration_cast< std::chrono::duration<double> >(b-a);

  printf("%f [X::findExact]\n", elapsed.count());
#endif

  return intersections;
}


/*******************************************************************************
*/
bool X::findExactOneRay(
  const double& px, const double& py, const double& tan_t_ray,
  const double& x_far, const double& y_far,
  const std::vector< std::pair<double, double> >& lines,
  const int& start_search_id, const int& end_search_id,
  const bool& tan_peligro,
  std::pair<double,double>* intersection_point,
  int* start_segment_id)
{
  std::vector< std::pair<double,double> > candidate_points;
  std::vector<int> candidate_start_segment_ids;

  for (int l = start_search_id; l < end_search_id; l++)
  {
    // The index of the first sensed point
    int idx_1 = l;

    // The index of the second sensed point (in counter-clockwise order)
    int idx_2 = idx_1 + 1;

    if (idx_2 >= lines.size())
      idx_2 = fmod(idx_2, lines.size());

    if (idx_1 >= lines.size())
      idx_1 = fmod(idx_1, lines.size());

    double det_1 =
      (lines[idx_1].first-px)*(lines[idx_2].second-py)-
      (lines[idx_2].first-px)*(lines[idx_1].second-py);

    double det_2 =
      (lines[idx_1].first-x_far)*(lines[idx_2].second-y_far)-
      (lines[idx_2].first-x_far)*(lines[idx_1].second-y_far);

    if (det_1 * det_2 <= 0.0)
    {
      double det_3 =
        (px-lines[idx_1].first)*(y_far-lines[idx_1].second)-
        (x_far-lines[idx_1].first)*(py-lines[idx_1].second);

      double det_4 =
        (px-lines[idx_2].first)*(y_far-lines[idx_2].second)-
        (x_far-lines[idx_2].first)*(py-lines[idx_2].second);

      if (det_3 * det_4 <= 0.0)
      {
        // They intersect!

        double tan_two_points =
          (lines[idx_2].second - lines[idx_1].second) /
          (lines[idx_2].first - lines[idx_1].first);

        double x = 0.0;
        double y = 0.0;

        if (!tan_peligro)
        {
          x = (py - lines[idx_1].second + tan_two_points * lines[idx_1].first
            -tan_t_ray * px) / (tan_two_points - tan_t_ray);

          y = py + tan_t_ray * (x - px);
        }
        else
        {
          x = px;
          y = lines[idx_1].second + tan_two_points * (x - lines[idx_1].first);
          //y = (lines[idx_2].second + lines[idx_1].second)/2;
        }


        candidate_points.push_back(std::make_pair(x,y));
        candidate_start_segment_ids.push_back(idx_1);
      }
    }
  }

  double min_r = 100000000.0;
  int idx = -1;
  for (int c = 0; c < candidate_points.size(); c++)
  {
    double dx = candidate_points[c].first - px;
    double dy = candidate_points[c].second - py;
    double r = dx*dx+dy*dy;

    if (r < min_r)
    {
      min_r = r;
      idx = c;
    }
  }

  if (idx >= 0)
  {
    *intersection_point =
      std::make_pair(candidate_points[idx].first, candidate_points[idx].second);
    *start_segment_id = candidate_start_segment_ids[idx];

    return true;
  }
  else
    return false;
}
