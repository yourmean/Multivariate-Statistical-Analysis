  
/*multivariate statistics assignment #3*/

/*Q3*/
/*A: 실험군, B: 대조군  d1=x1-y1, d2=x2-y2*/

data datax;
input x1 x2;
cards;
81	74
461	423
20	16
450	450
246	87
166	115
63	50
64	50
155	113
151	38
166	156
37	27
223	218
138	138
72	39
245	231

;

data datay;
input y1 y2;
cards;
72	33
134	18
84	20
98	58
48	13
142	49
113	38
90	24
30	18
260	34
116	20
87	27
69	32
100	27
315	39
188	65
;

data dataxy;
merge datax datay;
d1 = x1 - y1;
d2 = x2 - y2;
run; quit;

/*평균벡터*/
proc means data=dataxy mean maxdec=2;
run; quit;

/*Sd*/
proc corr data=dataxy noprob cov outp=cov_xy;
var d1 d2;
run; quit;
proc print data=cov_xy; run;

/*가설 검정*/
proc iml;
use cov_xy;
cov=1:2; mean=3;
read point mean into d;
read point cov into sd;
T = d * inv(sd/16) * t(d);  
q = (16-1)*2/(16-2) *  finv(.95, 2, 16-2);
print q T; 
run; quit;
