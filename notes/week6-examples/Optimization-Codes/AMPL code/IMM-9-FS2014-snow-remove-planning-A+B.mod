#Data file: IMM-9-FS2014-snow-remove-planning-A+B.mod
set SECTOR ordered; 
set SITE   ordered; 
param s {SECTOR} >= 0; #snow amount m3
param q {SITE} >= 0; #capacity m3
param l {SECTOR, SITE} >= 0; #distance in km
# Decision variables 
var x {SECTOR, SITE} binary; 
# Objective function 
minimize totalCost:   
    sum {i in SECTOR, j in SITE}  
          1000 * 0.1 * s[i] * l[i,j] * x[i,j]; 
subject to oneSite {i in SECTOR}:   
    sum {j in SITE} x[i,j] = 1; 
subject to siteq {j in SITE}: 
    sum {i in SECTOR} s[i]*x[i,j] <= q[j];