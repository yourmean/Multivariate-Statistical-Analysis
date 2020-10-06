/*multivariate statistics assignment #3*/

/* Q2*/
data cg;
input item x1 x2 x3 x4;
cards;
1 72 50 8 0.5
2 66.5 48 15 1.0
3 54 57 14 1.0
4 67 60 15 0.9
5 44 57 14 0.3
6 41 52 18 1.9
7 34.5 50 4 0.5
8 34.5 46 8.5 1.0
9 24 54 3 1.2
;
run;
data pg;
input item x1 x2 x3 x4;
cards;
1 57 57 12.5 0.9
2 100 54 17 0.5
3 100 32 16.5 0.7
4 96.5 65 20.5 0.9
5 79 51 18 0.9
6 78.5 53 18 1.2
7 48 50 21 1.6
8 155 44 20.5 1.4
9 84 64 13 0.8
10 105 35 17 1.8
;
run;

/*평균벡터 추정값 - 표본평균벡터, 소수점 아래 둘째자리까지 출력*/
proc means data=cg mean maxdec=2 ;
proc means data=pg mean maxdec=2;
run; quit;

/*공분산 행렬 추정값 - 표본공분산행렬*/
proc corr data=cg noprob cov outp=cov_cg;
var x1-x4;
proc corr data=pg noprob cov outp=cov_pg;
var x1-x4;
run; quit;

/*합동공분산행렬 추정*/
data cov_together;
set cov_cg cov_pg;
run; quit;
proc print data=cov_together; run;

/*1) 두 집단의 공분산행렬이 같다고 가정할 때, 모평균 벡터가 같은지 검정*/
proc iml;
use cov_together;
cg_cov=1:4; cg_mean=5; pg_cov=12:15; pg_mean=16;
read point cg_cov into cg_s;
read point cg_mean into cg_mu;
read point pg_cov into pg_s;
read point pg_mean into pg_mu;
s = (8*cg_s + 9*pg_s)/17;
T = (cg_mu - pg_mu) * inv((1/9 + 1/10)*s) * t(cg_mu - pg_mu); 
q = 17*4/14 * finv(.95, 4, 14);
print s,  T, q; 
run; quit;


/*2) 두 집단의 공분산행렬이 다르다고 가정할 때, 모평균 벡터가 같은지 검정*/
proc iml;
use cov_together;
cg_cov=1:4; cg_mean=5; pg_cov=12:15; pg_mean=16;
read point cg_cov into cg_s;
read point cg_mean into cg_mu;
read point pg_cov into pg_s;
read point pg_mean into pg_mu;
T = (cg_mu - pg_mu) * inv(cg_s/9 + pg_s/10) * t(cg_mu - pg_mu);
q = cinv(.95, 4);
print T, q;
run; quit;
