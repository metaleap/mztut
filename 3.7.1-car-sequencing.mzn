% https://www.csplib.org/Problems/prob001/

include "globals.mzn";

int: n_cars = 10;
int: n_options = 5;
int: n_classes = 6;
array [options] of int: max_per_block = [1, 2, 1, 2, 1];
array [options] of int: block_size = [2, 3, 3, 5, 5];
array [classes] of int: cars_in_class = [1, 1, 2, 2, 2, 2];
array [classes, options] of 0..1: need = array2d(1..6, 1..5, [ 1, 0, 1, 1, 0,
                                                            0, 0, 0, 1, 0,
                                                            0, 1, 0, 0, 1,
                                                            0, 1, 0, 1, 0,
                                                            1, 0, 1, 0, 0,
                                                            1, 1, 0, 0, 0
                                                          ]);

set of int: steps = 1..n_cars;
set of int: options = 1..n_options;
set of int: classes = 1..n_classes;

% The class of car being started at each step.
array [steps] of var classes: class;

% Which options are required by the car started at each step.
array [steps, options] of var 0..1: used;

% Block p must be used at step s if the class of the car to be
% produced at step s needs it.
constraint forall (s in steps, p in options) (used[s, p]=need[class[s], p]);

% For each option p with block size b and maximum limit m, no consecutive
% sequence of b cars contains more than m that require option p.
constraint
    forall (p in options, i in 1..(n_cars - (block_size[p] - 1))) (
        sum (j in 0..(block_size[p] - 1)) (used[i + j, p])
            <= max_per_block[p]);

% Require that the right number of cars in each class are produced.
constraint forall (c in classes) (count(class, c, cars_in_class[c]));

solve satisfy; % Find any solution.
