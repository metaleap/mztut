include "globals.mzn";

enum Flatmates = { Anne, Bert, Ceci, Dave };
enum Robots = { R2D2, C3PO, Marvin };
enum Chores = { Cooking, Vacuuming, Bathroom, Kitchen, Rubbish };


array[Flatmates,Chores] of int: humanPreference = % Higher number = higher preference
  [| 1, 2, 3, 4, 5 
   | 2, 1, 3, 4, 5 
   | 3, 5, 4, 1, 2 
   | 1, 5, 4, 2, 3 |];

array[Robots,Chores] of int: robotSkill =
  [| 20, 100, 20, 100, 30 
   | 10, 120, 40, 40,  60  
   | 50, 500, 30, 10,  70 |];



enum ChoreOrNone = ctorChores(Chores) ++ { None };
enum Workers = ctorFlatmates(Flatmates) ++ ctorRobots(Robots);

array[Flatmates,ChoreOrNone] of int: humanPrefOrNone =
  array2d(Flatmates,ChoreOrNone,
          [ if chore==None then 0 else humanPreference[mate,ctorChores^-1(chore)] endif
          | mate in Flatmates, chore in ChoreOrNone]);

array[Robots,ChoreOrNone] of int: robotSkillOrNone =
  array2d(Robots,ChoreOrNone,
          [ if chore==None then 0 else robotSkill[robo,ctorChores^-1(chore)] endif
          | robo in Robots, chore in ChoreOrNone]);

array[Workers] of var ChoreOrNone: assignment;
constraint alldifferent_except(assignment, {None});

var int: sumOfHumanPreferences =
  sum(mate in Flatmates)(humanPrefOrNone[mate, assignment[ctorFlatmates(mate)]]);
var int: sumOfRobotSkills =
  sum(robo in Robots)(robotSkillOrNone[robo, assignment[ctorRobots(robo)]]);
solve maximize sumOfHumanPreferences + sumOfRobotSkills;
