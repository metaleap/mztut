include "globals.mzn"; % to import alldifferent()

int: subSquareSize = 3;
int: puzzleSize = subSquareSize * subSquareSize;

array[1..puzzleSize,1..puzzleSize] of 0..puzzleSize: 
  puzzleInitial = [| % ...or from data file (as usual)
                    0, 0, 0, 0, 0, 0, 0, 0, 0|
                    0, 6, 8, 4, 0, 1, 0, 7, 0|
                    0, 0, 0, 0, 8, 5, 0, 3, 0|
                    0, 2, 6, 8, 0, 9, 0, 4, 0|
                    0, 0, 7, 0, 0, 0, 9, 0, 0|
                    0, 5, 0, 1, 0, 6, 3, 2, 0|
                    0, 4, 0, 6, 1, 0, 0, 0, 0|
                    0, 3, 0, 2, 0, 7, 6, 9, 0|
                    0, 0, 0, 0, 0, 0, 0, 0, 0|];
array[1..puzzleSize,1..puzzleSize] of var 1..puzzleSize: 
  puzzleSolved;

% ensure puzzleInitial non-0 cells remain in puzzleSolved
constraint forall(row,col in 1..puzzleSize) (if (puzzleInitial[row,col] > 0) then (puzzleSolved[row,col] == puzzleInitial[row,col]) else true endif);

% no duplicates in any row
constraint forall(row in 1..puzzleSize) (alldifferent([ puzzleSolved[row,col] | col in 1..puzzleSize ]));
% likewise, none in any column
constraint forall(col in 1..puzzleSize) (alldifferent([ puzzleSolved[row,col] | row in 1..puzzleSize ]));
% also, none in any sub-square
constraint forall(sqr, sqc in 1..subSquareSize)(alldifferent([ puzzleSolved[ (sqr-1)*subSquareSize + sqrcell, (sqc-1)*subSquareSize + sqccell ]
                                                               | sqrcell, sqccell in 1..subSquareSize ]));

solve satisfy;
