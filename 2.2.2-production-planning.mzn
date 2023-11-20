% more generalized form of 2.1.2-school-cakes.mzn: now all cakes-specific stuff only in the data (would in reality come from data files), not the code anymore

% data that would come from data files

enum Products = { BananaCake, ChocolateCake };
enum Resources = { Flour, Banana, Sugar, Butter, Cocoa };

array[Products] of int: centsEarnedPerUnit = [ 400, 450 ];
array[Resources] of int: amountsAvailable = [ 4000, 6, 2000, 500, 500 ];

array[Products, Resources] of int: consumedByProd = [| 
  250, 2, 75, 100, 0 | 
  200, 0, 150, 150, 75
|];

% the rest

int: maxProducable = max([ min([ amountsAvailable[res] div consumedByProd[prod,res] | res in Resources where consumedByProd[prod,res] > 0 ])
                           | prod in Products ]);
array[Products] of var 0..maxProducable: produceHowMany;
array[Resources] of var 0..max(amountsAvailable): consumedThereby;

constraint forall([ (consumedThereby[res] <= amountsAvailable[res]) /\ (consumedThereby[res] == sum([ consumedByProd[prod, res] * produceHowMany[prod] | prod in Products ]))
                    | res in Resources]); % Production cannot use more than the available Resources

solve maximize sum([ centsEarnedPerUnit[prod]*produceHowMany[prod] | prod in Products ]);
