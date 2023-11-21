include "globals.mzn";

enum Nurse = ctorNurse(1..7);
enum Day = ctorDay(1..10);
int: numDayShiftsRequiredPerNurse = 3;
int: numNightShiftsRequiredPerNurse = 2;
int: numNightShiftsMinimumPerNurse = 2;

enum Shift = { dayshift, nightshift, off };
enum State = { S1, S2, S3, S4, S5, S6 };

array[State,Shift] of opt State: t = [|     dayshift:  nightshift:  off:
                                      | S1: S2,        S3,          S1
                                      | S2: S4,        S4,          S1
                                      | S3: S4,        S5,          S1
                                      | S4: S6,        S6,          S1
                                      | S5: S6,        <>,          S1
                                      | S6: <>,        <>,          S1 |];

array[Nurse,Day] of var Shift: roster;

constraint forall(day in Day) (
             (numDayShiftsRequiredPerNurse == (sum(nurse in Nurse) (roster[nurse,day] == dayshift))) /\
             (numNightShiftsRequiredPerNurse == (sum(nurse in Nurse) (roster[nurse,day] == nightshift))));
constraint forall(nurse in Nurse) (
             (regular([roster[nurse,day] | day in Day], t, S1, State)) /\
             ((sum(day in Day)(roster[nurse,day] == nightshift)) >= numNightShiftsMinimumPerNurse));

solve satisfy;
