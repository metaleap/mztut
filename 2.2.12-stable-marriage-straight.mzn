int: numPotentialCouples = 5;

enum Gal = _(1..numPotentialCouples);
enum Guy = _(1..numPotentialCouples);

% lower number == better ranking; higher number == worse ranking
array[Gal,Guy] of 1..numPotentialCouples: guyRanksByGal = [|  1, 2, 4, 3, 5 |
                                                              3, 5, 1, 2, 4 |
                                                              5, 4, 2, 1, 3 |
                                                              1, 3, 5, 4, 2 |
                                                              4, 2, 3, 5, 1 |];
array[Guy,Gal] of 1..numPotentialCouples: galRanksByGuy = [|  5, 1, 2, 4, 3 |
                                                              4, 1, 3, 2, 5 |
                                                              5, 3, 2, 4, 1 |
                                                              1, 5, 4, 3, 2 |
                                                              4, 3, 2, 1, 5 |];

array[Guy] of var Gal: candidateWife;
array[Gal] of var Guy: candidateHusband;

% assignment
constraint forall (guy in Guy, gal in Gal) 
  ((candidateHusband[candidateWife[guy]]==guy)  /\  (candidateWife[candidateHusband[gal]]==gal));

% ranking
constraint forall (guy in Guy, other_gal in Gal)
  ((galRanksByGuy[guy,other_gal] < galRanksByGuy[guy,candidateWife[guy]]) ->
    (guyRanksByGal[other_gal,candidateHusband[other_gal]] < guyRanksByGal[other_gal,guy]));
constraint forall (gal in Gal, other_guy in Guy)
  ((guyRanksByGal[gal,other_guy] < guyRanksByGal[gal,candidateHusband[gal]]) -> 
    (galRanksByGuy[other_guy,candidateWife[other_guy]] < galRanksByGuy[other_guy,gal]));

solve satisfy;
