include "globals.mzn";

enum Job = _(1..5);
enum Machine = _(1..5);

Machine: maxMachine = max(Machine);
array[Job,Machine] of int: taskDurations = [|
                                          1, 4, 5, 3, 6 |
                                          3, 2, 7, 1, 2 |
                                          4, 4, 4, 4, 4 |
                                          1, 1, 1, 6, 8 |
                                          7, 3, 2, 2, 1 |];
int: sumOfTaskDurations = sum(job in Job, machine in Machine) ( taskDurations[job,machine] );
array[Job,Machine] of var 0..sumOfTaskDurations: timeTaskStart;
var 0..sumOfTaskDurations: timeDone;


constraint % ensure the machines occur in sequence
  forall(job in Job, machine in Machine where machine < maxMachine) (
    (timeTaskStart[job,machine] + taskDurations[job,machine] <= timeTaskStart[job,enum_next(Machine,machine)])  /\  (timeTaskStart[job,maxMachine] + taskDurations[job,maxMachine] <= timeDone));

constraint % ensure no overlap of machines
  forall(machine in Machine) (
    disjunctive([timeTaskStart[job,machine] | job in Job], [taskDurations[job,machine] | job in Job]));
%  forall(machine in Machine, jobA,jobB in Job where jobA < jobB) (
%    noOverlap(timeTaskStart[jobA,machine], taskDurations[jobA,machine], timeTaskStart[jobB,machine], taskDurations[jobB,machine]));

predicate noOverlap(var int: timeStart1, int: duration1, var int: timeStart2, int: duration2) =
  ((timeStart1 + duration1) <= timeStart2)  \/  ((timeStart2 + duration2) <= timeStart1);

predicate disjunctive(array[int] of var int: startTimes, array[int] of int: durations) =
          cumulative(startTimes, durations, [ 1 | _ in index_set(startTimes) ], 1);

solve minimize timeDone;
