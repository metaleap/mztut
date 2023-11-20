enum Item = _(1..8);

var set of Item: itemsPacked;

int: maxWeight = 44;
array[Item] of int: itemWeight = [14,12,11,9,7,4,2,1];
array[Item] of int: itemProfit = [77,11,44,22,55,99,88,66];

var int: sumWeightPacked = (sum (item in itemsPacked) (itemWeight[item]));
var int: sumProfitPacked = (sum (item in itemsPacked) (itemProfit[item]));

constraint maxWeight >= sumWeightPacked;

solve maximize sumProfitPacked;
