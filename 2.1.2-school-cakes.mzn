% Baking cakes for the school fete

% objective: find how many banana and chocolate can be baked given current conditions
var 0..: num_banana_cakes;
var 0..: num_choc_cakes;
% current-conditions follow (would in-the-real-world come from data file or input prompts)

% recipe: banana cake
int: cakeBanaFlourGrams = 250;
int: cakeBanaSugarGrams = 75;
int: cakeBanaButterGrams = 100;
int: cakeBanaBananasNum = 2;

% recipe: choc cake
int: cakeChocFlourGrams = 200;
int: cakeChocSugarGrams = 150;
int: cakeChocButterGrams = 150;
int: cakeChocCocoaGrams = 75;

% current inventory:
int: gotFlourGrams = 4000;
int: gotBananasNum = 6;
int: gotSugarGrams = 2000;
int: gotButterGrams = 500;
int: gotCocoaGrams = 500;

% total sales value per 1 whole cake:
int: centsPerCakeBanaSold = 400;
int: centsPerCakeChocSold = 450;

% ensure all current-conditions are considered
constraint cakeBanaBananasNum*num_banana_cakes  <= gotBananasNum;
constraint cakeChocCocoaGrams*num_choc_cakes <= gotCocoaGrams;
constraint cakeBanaFlourGrams*num_banana_cakes + cakeChocFlourGrams*num_choc_cakes <= gotFlourGrams;
constraint cakeBanaSugarGrams*num_banana_cakes + cakeChocSugarGrams*num_choc_cakes <= gotSugarGrams;
constraint cakeBanaButterGrams*num_banana_cakes + cakeChocButterGrams*num_choc_cakes <= gotButterGrams;

% go!
solve maximize centsPerCakeBanaSold*num_banana_cakes + centsPerCakeChocSold*num_choc_cakes;
