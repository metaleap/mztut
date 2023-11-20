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
array[Job,Machine] of var 0..sumOfTaskDurations: dtTaskStart;
var 0..sumOfTaskDurations: dtEnd;


constraint % ensure the machines occur in sequence
    forall(job in Job) (
        forall(machine in Machine where machine < maxMachine) 
            (dtTaskStart[job,machine] + taskDurations[job,machine] <= dtTaskStart[job,enum_next(Machine,machine)])  /\  (dtTaskStart[job,maxMachine] + taskDurations[job,maxMachine] <= dtEnd));

constraint % ensure no overlap of machines
    forall(machine in Machine) (
        forall(jobA,jobB in Job where jobA < jobB) (
            (dtTaskStart[jobA,machine] + taskDurations[jobA,machine] <= dtTaskStart[jobB,machine])  \/  (dtTaskStart[jobB,machine] + taskDurations[jobB,machine] <= dtTaskStart[jobA,machine])
        )
    );

solve minimize dtEnd;
