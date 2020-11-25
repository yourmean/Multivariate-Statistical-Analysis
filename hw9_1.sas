/*multivariate statistics*/

/*Q1*/
/*group1: -4000, group2:150 */
data skull;
input x1	x2	x3	x4	group;
cards;
131	138	89	49	1
125	131	92	48	1
131	132	99	50	1
119	132	96	44	1
136	143	100	54	1
138	137	89	56	1
139	130	108	48	1
125	136	93	48	1
131	134	102	51	1
134	134	99	51	1
129	138	95	50	1
134	121	95	53	1
126	129	109	51	1
132	136	100	50	1
141	140	100	51	1
131	134	97	54	1
135	137	103	50	1
132	133	93	53	1
139	136	96	50	1
132	131	101	49	1
126	133	102	51	1
135	135	103	47	1
134	124	93	53	1
128	134	103	50	1
130	130	104	49	1
138	135	100	55	1
128	132	93	53	1
127	129	106	48	1
131	136	114	54	1
124	138	101	46	1
137	123	91	50	2
136	131	95	49	2
128	126	91	57	2
130	134	92	52	2
138	127	86	47	2
126	138	101	52	2
136	138	97	58	2
126	126	92	45	2
132	132	99	55	2
139	135	92	54	2
143	120	95	51	2
141	136	101	54	2
135	135	95	56	2
137	134	93	53	2
142	135	96	52	2
139	134	95	47	2
138	125	99	51	2
137	135	96	54	2
133	125	92	50	2
145	129	89	47	2
138	136	92	46	2
131	129	97	44	2
143	126	88	54	2
134	124	91	55	2
132	127	97	52	2
137	125	85	57	2
129	128	81	52	2
140	135	103	48	2
147	129	87	48	2
136	133	97	51	2
;
proc print; run; quit;

proc discrim data=skull method=normal wcov pcov listerr crosslisterr pool=yes manova;
priors proportional;
class group;
var x1-x4;
run; quit;

data test;
input x1 x2 x3 x4 group testvalue $1-14;
cards;
137 125  85 60 .
137 135 107 54 .
;

/*새로운 개체에 대한 집단판별*/
proc discrim data=skull testdata=test testlist;
class group;
testid testvalue;
var x1-x4;
run; quit;

/*단계별 판별함수 변수선택*/
proc stepdisc data=skull;
class group;
var x1-x4;
run; quit;

/*단계별 선택방법으로 선택된 변수들의 판별분석*/
proc discrim data=skull method=normal wcov pcov listerr crosslisterr pool=yes manova;
priors proportional;
class group;
var x1-x3;
run; quit;

/*표준화 판별함수*/
proc standard data=skull mean=0 std=1 out=skull_z;
var x1-x4;
run; quit;

data skull_z;
set skull_z;
rename x1=z1 x2=z2 x3=z3 x4=z4;
run; quit;

proc discrim data=skull_z method=normal wcov pcov listerr crosslisterr pool=test manova;
priors proportional;
class group;
var z1-z4;
run; quit;
