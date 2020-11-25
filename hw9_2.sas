/*Q2*/
data q2;
input x1 x2 group;
cards;
-2 5 1
0 3 1
-1 1 1
0 6 2
2 4 2
1 2 2
;
proc print; run; quit;

/*fisher�� �Ǻ��Լ�*/
proc discrim data=q2 method=normal wcov pcov listerr crosslisterr pool=test manova;
priors proportional;
class group;
var x1 x2;
run; quit;

data test;
input x1 x2 group testvalue $1-4;
cards;
-1 2 .
;

/*���ο� ��ü�� ���� �����Ǻ�*/
proc discrim data=q2 testdata=test testlist;
class group;
testid testvalue;
var x1 x2;
run; quit;
