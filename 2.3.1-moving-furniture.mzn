include "globals.mzn";

enum Furniture = { piano, fridge, doublebed, singlebed, wardrobe, chair1, chair2, table };

array[Furniture] of int: durationToMoveByPiece = [60, 45, 30, 30, 20, 15, 15, 15];
array[Furniture] of int: numHandlersRequiredByPiece = [3, 2, 2, 1, 2, 1, 1, 2];
array[Furniture] of int: numTrolleysRequiredByPiece = [2, 1, 2, 2, 2, 0, 0, 1]; % number of numTrolleysRequiredByPiece required
int: numHandlersAvailable = 4;
int: numTrolleysAvailable = 3;
int: timeAvailable = 180;

array[Furniture] of var 0..timeAvailable: timeStartByPiece;
var 0..timeAvailable: timeDone;

constraint cumulative(timeStartByPiece, durationToMoveByPiece, numHandlersRequiredByPiece, numHandlersAvailable);
constraint cumulative(timeStartByPiece, durationToMoveByPiece, numTrolleysRequiredByPiece, numTrolleysAvailable);
constraint forall(piece in Furniture) ((timeStartByPiece[piece] + durationToMoveByPiece[piece]) <= timeDone);

solve minimize timeDone;
