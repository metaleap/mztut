% Colouring Australia using num_colors colours

include "ide/vis.mzn";

3..: num_colors; % not-specified-here param raises input prompt (or reads from data file)

var 1..num_colors: col_wa;
var 1..num_colors: col_nt;
var 1..num_colors: col_sa;
var 1..num_colors: col_qld;
var 1..num_colors: col_nsw;
var 1..num_colors: col_vic;
var 1..num_colors: col_tas;

constraint col_wa != col_nt;
constraint col_wa != col_sa;
constraint col_nt != col_sa;
constraint col_nt != col_qld;
constraint col_sa != col_qld;
constraint col_sa != col_nsw;
constraint col_sa != col_vic;
constraint col_qld != col_nsw;
constraint col_nsw != col_vic;
solve satisfy;
