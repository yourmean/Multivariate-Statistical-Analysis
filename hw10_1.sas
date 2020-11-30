data crime;
input id city$ murder rape @@;
cards;
1 Atlanta 16.5 24.8
2 Boston 4.2 13.3
3 Chicago 11.6 24.7
4 Dallas 18.9 34.2
5 Denver 6.9 41.5
6 Detroit 13.0 35.7
7 Hartford 2.5 8.8
8 Honolulu 3.6 12.7
9 Houston 16.8 26.6
10 KansasCity 10.8 43.2
11 LosAngales 9.7 51.8
12 NewOrleans 10.3 39.7
13 NewYork 9.4 19.4
14 Portland 5.9 23.0
15 Tucson 5.1 22.9
16 Washington 12.5 27.6
;
proc print ; run; quit;

/*method=single*/
proc cluster data=crime method=single outtree=out1 standard;
var murder rape;
id city;
copy murder rape;
proc tree data=out1 ncl=2 out=cl1;
id city;
proc print data=cl1; run; quit;

/*method=complete*/
proc cluster data=crime method=complete outtree=out2 standard;
var murder rape;
id city;
copy murder rape;
proc tree data=out2 ncl=2 out=cl2;
id city;
proc print data=cl2; run; quit;

/*method=ward*/
proc cluster data=crime method=ward outtree=out3 standard pseudo rsq;
var murder rape;
id city;
proc tree data=out3 ncl=2 out=cl3;
id city;
proc print data=cl3; run; quit;

/*---------------------------------------------------------------------------*/
proc cluster data=crime method=ward outtree=out4 standard;
var murder rape;
id city;
proc tree data=out4 ncl=2 out=cl4;
id city;
proc print data=cl4; run; quit;
proc sort data=cl4;  by city; run; quit;
proc sort data=crime;  by city; run; quit;
data cl4d;
merge cl4 crime;
by city;
run; quit;

proc print data=cl4d; run; quit;
proc sort data=cl4d;  by cluster; run; quit;
proc means data=cl4d;  by cluster; run; quit; /*clusterwise mean*/

/*---------------------------------------------------------------------------*/
/*k-means method with 2 group*/
proc fastclus data=crime maxc=2 list summary distance out=out5;
var murder rape;
id city;
run; quit;

/*k-means method with 2 group*/
proc fastclus data=crime maxc=3 list summary distance out=out6;
var murder rape;
id city;
run; quit;

