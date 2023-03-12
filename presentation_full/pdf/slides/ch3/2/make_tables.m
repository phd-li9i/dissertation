% https://tex.stackexchange.com/questions/544528/how-to-generate-beamer-frames-in-a-foreach-loop
% Add to preamble:
% \usepackage{array}\newcolumntype{R}{@{\hspace{\dimexpr2\tabcolsep+0.05em}}c}
% https://tex.stackexchange.com/questions/89148/equivalent-addlinespace-command-for-table-columns#comment193536_89148 for 0.05em
% https://tex.stackexchange.com/questions/509393/table-cellcolor-any-way-to-paint-only-part-of-cell
% and then remove red!xxx to make neat red

rc = {'green', 'red'};
rcv = 10:10:100;

str1 = '\begin{frame}{Η ανάγκη για πειραματική αξιολόγηση του state-of-the-art}';
str_dur = '\transduration{1}';
str2  = '{\footnotesize';
str3  = '\begin{table}[h]';
str4  = '\begin{tabular}{lRRRR}';
str5  = '  & \multicolumn{3}{c}{Local planners} \\';
str6  = '  \cline{2-4}';
str7  = '  Global Planners                     & \texttt{dwa}                               & \texttt{eband}                             & \texttt{teb} \\ \addlinespace[.05em]\toprule';



% rc positions: 2, 6, 10
% rcv positions: 4, 8, 12
str8  = {'  \texttt{navfn}                     & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str9  = {'  \texttt{global\_planner}           & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str10 = {'  \texttt{asr\_navfn}                & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str11 = {'  \texttt{MoveIt!}                   & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str12 = {'  \texttt{sbpl\_lattice\_planner}    & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str13 = {'  \texttt{sbpl\_dynamic\_env}        & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str14 = {'  \texttt{lattice\_planner}          & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str15 = {'  \texttt{waypoint\_global\_planner} & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em]'};
str16 = {'  \texttt{voronoi\_planner}          & $\cellcolor{', '', '!', '', '}{?}$         & $\cellcolor{', '', '!', '', '}{?}$            & $\cellcolor{', '', '!', '', '}{?}$         \\\addlinespace[.05em] \bottomrule'};

str17 = '\end{tabular}';
str18 = '\end{table}';
str19 = '}';
str20 = '';
str21 = '\end{frame}';




for i=1:10

  str8_ = strcat(str8{1}, rc{randi([1,numel(rc)])}, str8{3}, num2str(rcv(randi([1,numel(rcv)]))), str8{5}, rc{randi([1,numel(rc)])}, str8{7}, num2str(rcv(randi([1,numel(rcv)]))), str8{9}, rc{randi([1,numel(rc)])}, str8{11}, num2str(rcv(randi([1,numel(rcv)]))), str8{13});

  str9_ = strcat(str9{1}, rc{randi([1,numel(rc)])}, str9{3}, num2str(rcv(randi([1,numel(rcv)]))), str9{5}, rc{randi([1,numel(rc)])}, str9{7}, num2str(rcv(randi([1,numel(rcv)]))), str9{9}, rc{randi([1,numel(rc)])}, str9{11}, num2str(rcv(randi([1,numel(rcv)]))), str9{13});

  str10_ = strcat(str10{1}, rc{randi([1,numel(rc)])}, str10{3}, num2str(rcv(randi([1,numel(rcv)]))), str10{5}, rc{randi([1,numel(rc)])}, str10{7}, num2str(rcv(randi([1,numel(rcv)]))), str10{9}, rc{randi([1,numel(rc)])}, str10{11}, num2str(rcv(randi([1,numel(rcv)]))), str10{13});

  str11_ = strcat(str11{1}, rc{randi([1,numel(rc)])}, str11{3}, num2str(rcv(randi([1,numel(rcv)]))), str11{5}, rc{randi([1,numel(rc)])}, str11{7}, num2str(rcv(randi([1,numel(rcv)]))), str11{9}, rc{randi([1,numel(rc)])}, str11{11}, num2str(rcv(randi([1,numel(rcv)]))), str11{13});

  str12_ = strcat(str12{1}, rc{randi([1,numel(rc)])}, str12{3}, num2str(rcv(randi([1,numel(rcv)]))), str12{5}, rc{randi([1,numel(rc)])}, str12{7}, num2str(rcv(randi([1,numel(rcv)]))), str12{9}, rc{randi([1,numel(rc)])}, str12{11}, num2str(rcv(randi([1,numel(rcv)]))), str12{13});

  str13_ = strcat(str13{1}, rc{randi([1,numel(rc)])}, str13{3}, num2str(rcv(randi([1,numel(rcv)]))), str13{5}, rc{randi([1,numel(rc)])}, str13{7}, num2str(rcv(randi([1,numel(rcv)]))), str13{9}, rc{randi([1,numel(rc)])}, str13{11}, num2str(rcv(randi([1,numel(rcv)]))), str13{13});

  str14_ = strcat(str14{1}, rc{randi([1,numel(rc)])}, str14{3}, num2str(rcv(randi([1,numel(rcv)]))), str14{5}, rc{randi([1,numel(rc)])}, str14{7}, num2str(rcv(randi([1,numel(rcv)]))), str14{9}, rc{randi([1,numel(rc)])}, str14{11}, num2str(rcv(randi([1,numel(rcv)]))), str14{13});

  str15_ = strcat(str15{1}, rc{randi([1,numel(rc)])}, str15{3}, num2str(rcv(randi([1,numel(rcv)]))), str15{5}, rc{randi([1,numel(rc)])}, str15{7}, num2str(rcv(randi([1,numel(rcv)]))), str15{9}, rc{randi([1,numel(rc)])}, str15{11}, num2str(rcv(randi([1,numel(rcv)]))), str15{13});

  str16_ = strcat(str16{1}, rc{randi([1,numel(rc)])}, str16{3}, num2str(rcv(randi([1,numel(rcv)]))), str16{5}, rc{randi([1,numel(rc)])}, str16{7}, num2str(rcv(randi([1,numel(rcv)]))), str16{9}, rc{randi([1,numel(rc)])}, str16{11}, num2str(rcv(randi([1,numel(rcv)]))), str16{13});


  filename = strcat('frame_', num2str(i), '.tex');
  file_id = fopen(filename, 'w');
  fprintf(file_id, '%s\n', str1);
  fprintf(file_id, '%s\n', str_dur);
  fprintf(file_id, '%s\n', str2);
  fprintf(file_id, '%s\n', str3);
  fprintf(file_id, '%s\n', str4);
  fprintf(file_id, '%s\n', str5);
  fprintf(file_id, '%s\n', str6);
  fprintf(file_id, '%s\n', str7);
  fprintf(file_id, '%s\n', str8_);
  fprintf(file_id, '%s\n', str9_);
  fprintf(file_id, '%s\n', str10_);
  fprintf(file_id, '%s\n', str11_);
  fprintf(file_id, '%s\n', str12_);
  fprintf(file_id, '%s\n', str13_);
  fprintf(file_id, '%s\n', str14_);
  fprintf(file_id, '%s\n', str15_);
  fprintf(file_id, '%s\n', str16_);
  fprintf(file_id, '%s\n', str17);
  fprintf(file_id, '%s\n', str18);
  fprintf(file_id, '%s\n', str19);
  fprintf(file_id, '%s\n', str20);
  fprintf(file_id, '%s\n', str21);
  fprintf(file_id, '\n');
  fclose(filename);

end
