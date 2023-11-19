% Baking cakes for the school fete

var 0..: num_cakeban;  % no. of banana cakes
var 0..: num_cakechoc;    % no. of chocolate cakes

% flour
int: got_flour_g = 4000;
int: flour_per_cakeban_g = 250;
int: flour_per_cakechoc_g = 200;
constraint flour_per_cakeban_g*num_cakeban + flour_per_cakechoc_g*num_cakechoc <= got_flour_g;
% bananas
int: got_cakebans_n = 6;
int: cakebans_per_cakeban_n = 2;
constraint cakebans_per_cakeban_n*num_cakeban  <= got_cakebans_n;
% sugar
int: got_sugar_g = 2000;
int: sugar_per_cakeban_g = 75;
int: sugar_per_cakechoc_g = 150;
constraint sugar_per_cakeban_g*num_cakeban + sugar_per_cakechoc_g*num_cakechoc <= got_sugar_g;
% butter
int: got_butter_g = 500;
int: butter_per_cakeban_g = 100;
int: butter_per_cakechoc_g = 150;
constraint butter_per_cakeban_g*num_cakeban + butter_per_cakechoc_g*num_cakechoc <= got_butter_g;
% cocoa
int: got_cocoa_g = 500;
int: cocoa_per_cakechoc_g = 75;
constraint cocoa_per_cakechoc_g*num_cakechoc <= got_cocoa_g;

int: cents_per_cakeban = 400;
int: cents_per_cakechoc = 450;
solve maximize cents_per_cakeban*num_cakeban + cents_per_cakechoc*num_cakechoc;
