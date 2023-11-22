include "ide/vis.mzn";

type Size = record(0..infinity: width, 0..infinity: height);
type Pos = record(var 0..infinity: x, var 0..infinity: y);
type Rect = Size ++ Pos;

Size: area = ( width: 10, height: 11 );
array[_] of Size: rectSize = [
    (width: 3, height: 3),
    (width: 2, height: 1),
    (width: 1, height: 2),
    (width: 2, height: 2),
    (width: 2, height: 3),
  ];

array[index_set(rectSize)] of Pos: rectPos;
array[_] of Rect: rects ::output = [ rectSize[i] ++ rectPos[i] | i in index_set(rectSize)];

% Constraint: rects must be placed within the area
constraint forall(rect in rects) (
  ((rect.x + rect.width) <= area.width)  /\  ((rect.y + rect.height) <= area.height));

% Constraint: no rects can overlap
constraint forall(r1, r2 in index_set(rects) where r1 < r2) (
  noOverlapX(rects[r1], rects[r2])  /\  noOverlapY(rects[r1], rects[r2]));

predicate noOverlapX(Rect: rectA, Rect: rectB) = 
  ((rectA.x + rectA.width) <= rectB.x)  \/  ((rectB.x + rectB.width) <= rectA.x);

predicate noOverlapY(Rect: rectA, Rect: rectB) = 
  ((rectA.y + rectA.height) <= rectB.y)  \/  ((rectB.y + rectB.height) <= rectA.y);

solve satisfy;
