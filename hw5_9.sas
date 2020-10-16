/* multivariate analysis assignment #5*/

/* Q9 */

data ex76 (ype=covariance);
_type_ = 'covariane';
input _name_ $ x1-x3;
cards;
x1 4 . .
x2 2 9 .
x3 0 6 16
;
proc princomp data=ex76 (type=corr); run; 
