#Data file: IMM-9-FS2014-group-of-bridges-work-programme.mod

set BRIGES; #type of bridges (metal, concrete, masonry)
set PERSONS; #involved personnels

#parameters
param c {BRIGES}; #fixed cost
param b {BRIGES}; #benefit
param h {BRIGES, PERSONS}; #hours required for each bridge type for each kind of person
param Maxh{PERSONS}; #Maximum of hours for each type of person
param M{BRIGES}; #M values
# Decision variables 
var x{BRIGES} integer >=0;  #number of bridges of each types to repair in each year
var y{BRIGES} binary;  #binary variables

# Objective function 
maximize benefit: sum {i in BRIGES}  	(b[i]*x[i] - c[i]*y[i]); 

subject to Maxhours {j in PERSONS}: 	sum {i in BRIGES} x[i]*h[i,j] <= Maxh[j]; 
subject to Linking 	{i in BRIGES}:   	x[i]<= M[i]*y[i];
#subject to Consistency {i in BRIGES}: 	(x[i]>0 ==> y[i]=1 else y[i]=0);
#subject to Consistency {i in BRIGES}: 	if (x[i]>0) then (y[i] =1) else (y[i] =0);


