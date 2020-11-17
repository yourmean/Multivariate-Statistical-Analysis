/*Q1*/
data chem;
input y1	y2	x1	x2	x3;
cards;
41.5	45.9	162	23	3
33.8	53.3	162	23	8
27.7	57.5	162	30	5
21.7	58.8	162	30	8
19.9	60.6	172	25	5
15	58	172	25	8
12.2	58.6	172	30	5
4.3	52.4	172	30	8
19.3	56.9	167	27.5	6.5
6.4	55.4	177	27.5	6.5
37.6	46.9	157	27.5	6.5
18	57.3	167	32.5	6.5
;
proc print data=chem; run; quit;

proc cancorr data=chem out=c_out
vprefix=u vname='conditions'
wprefix=v wname='products';
var x1 x2 x3;
with y1 y2;
run; quit;

proc print data=c_out;
var u1 v1;
run; quit;

proc sgplot data=c_out;
scatter x=u1 y=v1;
run; quit;

proc sgplot data=c_out;
scatter x=u2 y=v2;
run; quit;
