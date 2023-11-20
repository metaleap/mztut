include "globals.mzn";

int: numWeeks = 4;
int: numGroups = 4;
int: groupSize = 3;
int: numGolfers = groupSize * numGroups;

set of int: Week = 1..numWeeks;
set of int: Group = 1..numGroups;
set of int: GroupSize = 1..groupSize;
set of int: Golfer = 1..numGolfers;

array[Week,Group] of var set of Golfer: sched;


constraint forall (week in Week, group in Group) (
  (card(sched[week,group]) == groupSize)  /\
    forall (group_other in group+1..numGroups) (
      (sched[week,group] intersect sched[week,group_other]) == {}));
constraint forall (week in Week) (
  partition_set([sched[week,group] | group in Group], Golfer));
constraint forall (weekA in 1..numWeeks-1, weekB in weekA+1..numWeeks) (
  forall (groupA,groupB in Group) (
    card(sched[weekA,groupA] intersect sched[weekB,groupB]) <= 1));


constraint % Fix the first week %
  forall (group in Group, group_size in GroupSize) (
      ((group-1)*groupSize + group_size) in sched[1,group]);
constraint % Fix first group of second week %
  forall (group_size in GroupSize) (
      ((group_size-1)*groupSize + 1) in sched[2,1]);
constraint % Fix first 'groupSize' players
  forall (week in 2..numWeeks, group_size in GroupSize) (
      group_size in sched[week,group_size]);

solve satisfy;
