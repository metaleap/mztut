include "globals.mzn";

int: minEnergy = 3300;
int: minProtein = 500;
int: maxSalt = 180;
int: maxFat = 320;

enum Food = { icecream, banana, chocolatecake, lasagna, steak, rice, chips, brocolli, beans};
set of Food: mains = { lasagna, steak, rice };
set of Food: sides = { chips, brocolli, beans };
set of Food: desserts = { icecream, banana, chocolatecake };

enum Feature =                          { name,          energy, protein, salt, fat, cost }; 
array[Food,Feature] of int: dbFoods =  [| icecream,      1200,   50,      10,   120, 400
                                        | banana,         800,   120,     5,    20,  120
                                        | chocolatecake, 2500,   400,     20,   100, 600
                                        | lasagna,       3000,   200,     100,  250, 450
                                        | steak,         1800,   800,     50,   100, 1200
                                        | rice,          1200,   50,      5,    20,  100
                                        | chips,         2000,   50,      200,  200, 250
                                        | brocolli,       700,   100,     10,   10,  125
                                        | beans,         1900,   250,     60,   90,  150 |];

array[Feature] of var int: main;
array[Feature] of var int: side;
array[Feature] of var int: dessert;
var int: totalCost;

constraint (totalCost == (main[cost] + side[cost] + dessert[cost]));
constraint main[name] in mains;
constraint side[name] in sides;
constraint dessert[name] in desserts;
constraint table(main, dbFoods);    % kinda-sorta "main in dbFoods" but 2d-array-specific, since we dont have array-of-array directly. same for the 2 below
constraint table(side, dbFoods);
constraint table(dessert, dbFoods);
constraint ((main[energy] + side[energy] + dessert[energy]) >= minEnergy);
constraint ((main[protein] + side[protein] + dessert[protein]) >= minProtein);
constraint ((main[salt] + side[salt] + dessert[salt]) <= maxSalt);
constraint ((main[fat] + side[fat] + dessert[fat]) <= maxFat);

solve minimize totalCost; 
