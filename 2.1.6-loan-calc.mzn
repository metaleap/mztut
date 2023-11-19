% example with 3 statically consted vars, but let's remember, *any* n of the 7 vars could be set from data-file (or not. depending what one is looking for)

var float: quarterly_repayment = 260.0;
var float: principal_borrowed = 1000.0;
var 0.0 .. 10.0: quarterly_interest_rate_percent = 0.04;

var float: owing_after_q1;
var float: owing_after_q2;
var float: owing_after_q3;
var float: owing_after_q4;

constraint owing_after_q1 = principal_borrowed * (1.0 + quarterly_interest_rate_percent) - quarterly_repayment;
constraint owing_after_q2 = owing_after_q1 * (1.0 + quarterly_interest_rate_percent) - quarterly_repayment;
constraint owing_after_q3 = owing_after_q2 * (1.0 + quarterly_interest_rate_percent) - quarterly_repayment; 
constraint owing_after_q4 = owing_after_q3 * (1.0 + quarterly_interest_rate_percent) - quarterly_repayment;

solve satisfy;
