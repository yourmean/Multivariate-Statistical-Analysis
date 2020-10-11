/* multivariate statistics assignment #4 */

/*Q1*/
data data1;
input x1 x2 x3;
cards;
0.3 0.01 0.01
0.01 0.2 0.03
0.01 0.03 0.1
;
run; quit;

data data2;
input x1 x2 x3;
cards;
0.5 0.11 0.04
0.11 0.3 0.007
0.04 0.007 0.2
;
run; quit;

data data3;
input x1 x2 x3;
cards;
0.32 0.30 0.01
0.30 0.7 -0.03
0.01 -0.03 0.4
;
run; quit;

data data4;
set data1 data2 data3 ;
run; quit;
proc print data=data4; run;

/* (c) 오차제곱합행렬 */
proc iml;
use data4;
d1 = 1:3;
d2 = 4:6;
d3 = 7:9;
read point d1 into A;
read point d2 into B;
read point d3 into C;
sum_val = 9*A + 19*B + 49*C ;
dt = det(sum_val);
print sum_val;
print dt;  /*det of H matrix*/
create e from sum_val;
append from sum_val;
close e;
run; quit;

proc print data =e ;
run; quit;


/* (d) 처리제곱합 행렬 */
data data1;
input x @@;
cards;
3 2 1
;

data data2;
input x @@;
cards;
4 1 1
;

data data3;
input x @@;
cards;
4 2 2
;

data data4;
set data1 data2 data3 ;
run; quit;
proc print data=data4; run;

proc iml;
use data4;
d1 = 1:3;
d2 = 4:6;
d3 = 7:9;
read point d1 into A;
read point d2 into B;
read point d3 into C;

xbar = {3.875 1.75 1.625}`;
sum_val = 10*(A-xbar)*t(A-xbar) + 20*(B-xbar)*t(B-xbar) + 50*(C-xbar)*t(C-xbar);
print sum_val;
create h from sum_val;
append from sum_val;
close h;
run; quit;

proc print data = h;
run;quit;

proc print data = e;
run; quit;

data he;
set h e;
run; quit;

proc iml;
use he;
q=1:3;
w=4:6;
read point q into H;
read point w into E;
add = H+E;
dt = det(add);
print add;
print dt; /*det of H+E matrix*/
run; quit;
