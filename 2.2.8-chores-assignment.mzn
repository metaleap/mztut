include "globals.mzn"; % to import alldifferent_except()

enum Flatmates = { Anne, Bert, Ceci, Dave };
enum Chores = { Cooking, Vacuuming, Bathroom, Kitchen, Rubbish };

enum ChoreOrNone = Chores(Chores) ++ { None };

array[Flatmates] of var ChoreOrNone: assignments;

constraint alldifferent_except(assignments, {None});
