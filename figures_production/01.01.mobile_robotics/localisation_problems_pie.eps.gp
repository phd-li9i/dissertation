unset multiplot;
set terminal epslatex size 4.16666666667,4.16666666667  dashlength 2
set output '/media/li9i/elements/PhD/dissertation/figures_production/01.01.mobile_robotics/localisation_problems_pie.eps';
set multiplot;

reset;
set autoscale keepfix;
set origin 0, 0
set size 1, 1
if (GPVAL_TERM eq "qt") set obj 1 rectangle from screen 0,0 to screen 1,1 behind fc rgb "#ffffff" fs solid noborder;
set border linecolor rgb "#000000"
unset tmargin;
unset bmargin;
unset lmargin;
unset rmargin;
set origin 0, 0.166667;
set size ratio -1 1, 0.666667;
unset label;
unset xtics;
unset ytics;
unset ztics;
unset x2tics;
unset y2tics;
unset title;
unset xlabel;
unset x2label;
unset ylabel;
unset y2label;
unset zlabel;
set grid noxtics;
set grid noytics;
set grid noztics;
set grid nomxtics;
set grid nomytics;
set grid nomztics;
set grid layerdefault;
unset logscale;
set clip two;
set label "19%" at  -6.745000534225567e-01,9.924966891294742e-01 right rotate by 0.000000 offset character -0.000000,0.000000 font ",10"  front textcolor rgb "#000000";
set label "26%" at  -1.085792462959223e+00,-5.109351498780872e-01 right rotate by 0.000000 offset character -0.000000,0.000000 font ",10"  front textcolor rgb "#000000";
set label "55%" at  1.185226008714165e+00,-1.877213580482772e-01 left rotate by 0.000000 offset character -0.000000,0.000000 font ",10"  front textcolor rgb "#000000";
set pm3d implicit;
set hidden3d front nooffset;
set xrange [-1.500000000000000e+00:1.500000000000000e+00];
set yrange [-1.000000000000000e+00:1.000000000000000e+00];
set cbrange [1:6.400000000000000e+01];
unset border; unset tics
unset grid;
set key outside center top;
set key nobox reverse Left vertical spacing 2 font ",16" textcolor rgb "#000000" ;
set style data lines;
set palette positive color model RGB maxcolors 64;
set palette file "-" binary record=64 using 1:2:3:4;
  �?���>ظ�;��>   @��>R��<��>  @@���>�P=��>  �@׊�>���=���>  �@n��>S��=�$�>  �@2 �>�e�=���>  �@c̐>��>���>   A{��>lB!>���>  A���>��5>�$�>   A#��>I�I>���>  0A;�>��]>�?  @AR[�>�q>�?  PA�>}!�>��?  `A��>���>`S?  pA�y>̔>��	?  �A3�q>S؝>:�
?  �Aӽi>D��>��?  �A�a>k^�>�?  �AF�Y>?ܷ>�7?  �AB R>�/�>��?  �A�wJ>�]�>n?  �A�4C>]j�>�[?  �A*;<>GZ�>k�?  �A�5>�2�>O�?  �A}/>���>c�?  �A��(>���>q�?  �A\�">[�>��?  �A@�>� �>m�?  �A��>PQ?Ε?  �A��>v!?"M?  �A�>��
?��?   BQ�>P�?c[?  B�� >~�?t�?  B�0�=�d?0�?  B��=�5?j�
?  B���="?pk	?  B:��=��!?��?  BR�>�%?�?  Bv>0\)?f?   B<>/-?��?  $BS�)>��0?CV�>  (B��=>�h4?���>  ,B�U>��7?s�>  0B��n>�~;?��>  4Bbd�>��>?�`�>  8B�z�>�CB?��>  <B]��>�E?��>  @Bn�>|�H?q�>  DB�!�>ТK?�*�>  HB֐�>.�N?%@�>  LB���>	=Q?�>  PBd1 ?�S?���>  TB�S
?V<V?-Ύ>  XBQ�?f}X?T��>  \B�F?��Z?.�g>  `B�*?�\?�K>  dB��4?�B^?^�/>  hB�??��_?��>  lB��J?^^a?qg�=  pBISU?|�b?���=  tB}�_?�d?FG�=  xB�Pj?�^e?2��=  |B]pt?Q�f?-i�=  �B~E~?��g?d>
unset colorbox;
plot "-" binary format='%float64' record=20 using ($1):($2) title "Απαχθέν ρομπότ" with filledcurve lc rgb "#440154" fillstyle transparent solid 1.000000 \
, "-" binary format='%float64' record=21 using ($1):($2) title "" with linespoints linewidth 0.500000 pointtype -1 dashtype solid pointsize 0.666667 lc rgb "#000000" \
, "-" binary format='%float64' record=26 using ($1):($2) title "Βάσει καθολικής αβεβαιότητας" with filledcurve lc rgb "#20928c" fillstyle transparent solid 1.000000 \
, "-" binary format='%float64' record=27 using ($1):($2) title "" with linespoints linewidth 0.500000 pointtype -1 dashtype solid pointsize 0.666667 lc rgb "#000000" \
, "-" binary format='%float64' record=52 using ($1):($2) title "Βάσει περιορισμένης αβεβαιότητας" with filledcurve lc rgb "#fde725" fillstyle transparent solid 1.000000 \
, "-" binary format='%float64' record=53 using ($1):($2) title "" with linespoints linewidth 0.500000 pointtype -1 dashtype solid pointsize 0.666667 lc rgb "#000000" \
;
                              �?(Qjm�۱���pq��?���l���z�0�F��?�XB�ٜʿ� z2�L�?)�2�
�ѿ�{^���?��t��տ-RB��?�!�ڿ����;�?yP$t�޿'mOA�?*ݬ>��E���5#�?^Zu#�⿨���w��?<R���9PϢo��?s�0�:�9M����?��3�����▄i�?�c�Sb7�9ɽ���?���y�������?�LX�z��     �?�8V�������E�?W˗y}���������?�Z�����HZ��?                              �?(Qjm�۱���pq��?���l���z�0�F��?�XB�ٜʿ� z2�L�?)�2�
�ѿ�{^���?��t��տ-RB��?�!�ڿ����;�?yP$t�޿'mOA�?*ݬ>��E���5#�?^Zu#�⿨���w��?<R���9PϢo��?s�0�:�9M����?��3�����▄i�?�c�Sb7�9ɽ���?���y�������?�LX�z��     �?�8V�������E�?W˗y}���������?�Z�����HZ��?                                �Z�����HZ��?M� ����?^>Z�?��M���#�?p���G������X�?�)�!����Hc1��?�+Z���x�t}��?��p����ƹp���za����XZ:����jy�r��X@ǿ�����Ͽ��91]��3Կg]@������� ucؿ-ޛ�����P�tܿ�#3D���DOr�m1�a�RlTg�p�`�5⿈�)M�"�HOq��Fn1m�翉-ə��^�`]��ձwj,翽���e��k[c��n�Y����!��� �6~�����XA뿔3�i��ݿư̆�[�gKt�Q�ٿ��W��R��}^�	xտ��իU%�Q�/7��ӿ�TDo�                �Z�����HZ��?M� ����?^>Z�?��M���#�?p���G������X�?�)�!����Hc1��?�+Z���x�t}��?��p����ƹp���za����XZ:����jy�r��X@ǿ�����Ͽ��91]��3Կg]@������� ucؿ-ޛ�����P�tܿ�#3D���DOr�m1�a�RlTg�p�`�5⿈�)M�"�HOq��Fn1m�翉-ə��^�`]��ձwj,翽���e��k[c��n�Y����!��� �6~�����XA뿔3�i��ݿư̆�[�gKt�Q�ٿ��W��R��}^�	xտ��իU%�Q�/7��ӿ�TDo�                                Q�/7��ӿ�TDo����K�ο%�y��ￖs~:ƿ�����W<�`º��g����@���Xޡ�g�x�����Xޡ?g�x��nW<�`º?�g���ￎs~:�?��������K��?%�y���U�/7���?�TDo�����?X˗y}������E�?�8V����     �?�LX�z�������?���y��5ɽ���?�c�Sb7��▄i�?¾3����6M����?s�0�:�8PϢo��?<R��俧���w��?_Zu#��E���5#�?+ݬ>��'mOA�?xP$t�޿����;�?�!�ڿ-RB��?�t��տ�{^���?$�2�
�ѿ z2�L�?YB�ٜʿy�0�F��?'���l�����pq��?<Qjm�۱�      �?        ��pq��?"Qjm�۱?z�0�F��?���l��? z2�L�?�XB�ٜ�?�{^���?�2�
��?-RB��?��t���?����;�?�!��?	'mOA�?rP$t��?G���5#�?(ݬ>��?����w��?\Zu#��?:PϢo��?<R���?9M����?s�0�:�?�▄i�?��3����?8ɽ���?�c�Sb7�?�����?���y��?     �?�LX�z��?���E�?�8V����?������?W˗y}��?S�/7���?�TDo�?"���K��?%�y���?�s~:�?�����?�W<�`º?�g����?���Xޡ?g�x��?              �?                Q�/7��ӿ�TDo����K�ο%�y��ￖs~:ƿ�����W<�`º��g����@���Xޡ�g�x�����Xޡ?g�x��nW<�`º?�g���ￎs~:�?��������K��?%�y���U�/7���?�TDo�����?X˗y}������E�?�8V����     �?�LX�z�������?���y��5ɽ���?�c�Sb7��▄i�?¾3����6M����?s�0�:�8PϢo��?<R��俧���w��?_Zu#��E���5#�?+ݬ>��'mOA�?xP$t�޿����;�?�!�ڿ-RB��?�t��տ�{^���?$�2�
�ѿ z2�L�?YB�ٜʿy�0�F��?'���l�����pq��?<Qjm�۱�      �?        ��pq��?"Qjm�۱?z�0�F��?���l��? z2�L�?�XB�ٜ�?�{^���?�2�
��?-RB��?��t���?����;�?�!��?	'mOA�?rP$t��?G���5#�?(ݬ>��?����w��?\Zu#��?:PϢo��?<R���?9M����?s�0�:�?�▄i�?��3����?8ɽ���?�c�Sb7�?�����?���y��?     �?�LX�z��?���E�?�8V����?������?W˗y}��?S�/7���?�TDo�?"���K��?%�y���?�s~:�?�����?�W<�`º?�g����?���Xޡ?g�x��?              �?                
if (GPVAL_TERM eq "qt") unset obj 1;

unset multiplot;
