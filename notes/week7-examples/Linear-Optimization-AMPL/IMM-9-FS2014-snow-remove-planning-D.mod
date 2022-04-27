### source:http://eckstein.rutgers.edu/beijing07/Tuesday/snow-solutions.pdf
### Parameters of model.  Actual values come from .dat file 
### IMM-9-FS2014-snow-remove-planning-extension.mod
set SECTOR ordered; 
set SITE   ordered; 
param s {SECTOR} >= 0; #snowAmount
param q {SITE} >= 0; #capacity
param l {SECTOR, SITE} >= 0; #distance
param e >= 0; #expansionSize
param n integer, >= 0; 
### -------------------------------------------------- 
### Decision variables 
### -------------------------------------------------- 
var x {SECTOR, SITE} binary; 
var y {SITE} binary; 
### -------------------------------------------------- 
### Objective function 
### -------------------------------------------------- 
minimize totalCost:   
    sum {i in SECTOR, j in SITE}  
          1000 * 0.1 * s[i] * l[i,j] * x[i,j]; 
### --------------------------------------------------------------- 
### Constraints (binary constraints already defined with variables) 
### --------------------------------------------------------------- 
subject to oneSite {i in SECTOR}:   
    sum {j in SITE} x[i,j] = 1; 
subject to siteCapacity {j in SITE}: 
    sum {i in SECTOR} s[i]*x[i,j]  
              <= q[j] + e*y[j]; 
subject to numExpansions: 
    sum {j in SITE} y[j] <= n;