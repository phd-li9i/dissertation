1. Grab the map from scrips/candidate_1/map.m
2. Plot it with fltk enabled
3.
    octave:1> map;
    octave:2> plot(mx,my)
    octave:3> axis equal
    octave:4> [x, y, buttons] = ginput ()

4. Left-click in the map the trajectory you want. You won't feel a thing.
5. When you are done press enter. The points you clicked will pop up in the
  command line
6. Copy these and paste them into `generate_poses_for_odom_test.m`, and punctuate
   the fucker
7. Execute generate_poses_for_odom_test.m. Copy the c++ output into
  void S2MSM::getRealTrajectory. Execute for CSM, NDT, FMT
8. Go to the logs directory; create the directories for the three algos
9. run
make && ./s2msm_node 50 1 193 194 0.2 0.786 0.00 0.00 0 0 360 180 FMT
make && ./s2msm_node 1 1 193 194 0.2 0.786 0.00 0.00 0 0 360 180 NDT
make && ./s2msm_node 1 1 193 194 0.2 0.786 0.00 0.00 0 0 360 180 CSM

10. run scripts/plot_odom_tests.m
