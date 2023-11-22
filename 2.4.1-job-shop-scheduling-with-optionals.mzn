include "globals.mzn";

int: horizon = 123;
set of int: Time = 0..horizon;
enum Task = _(1..5);
enum Machine = _(1..5);

array[Task,Machine] of int: taskDurationByMachine = [|
                                                      1, 4, 5, 3, 6 |
                                                      3, 2, 7, 1, 2 |
                                                      4, 4, 4, 4, 4 |
                                                      1, 1, 1, 6, 8 |
                                                      7, 3, 2, 2, 1 |];
int: maxDuration = max([ taskDurationByMachine[task,machine] | task in Task, machine in Machine ]);
int: minDuration = min([ taskDurationByMachine[task,machine] | task in Task, machine in Machine ]);

array[Task] of var Time: taskStart;
array[Task] of var minDuration..maxDuration: taskDuration;
array[Task,Machine] of var opt Time: taskStartMaybe; % optional task start

constraint forall(task in Task) (
  alternative(taskStart[task], taskDuration[task], [taskStartMaybe[task,mach] | mach in Machine], [taskDurationByMachine[task,mach] | mach in Machine]));

constraint forall(mach in Machine)
  (disjunctive([taskStartMaybe[task,mach] | task in Task], [taskDurationByMachine[task,mach] | task in Task]));

constraint cumulative(taskStart, taskDuration, [1 | _ in Task], card(Machine));

solve minimize max(task in Task) (taskStart[task] + taskDuration[task]);
