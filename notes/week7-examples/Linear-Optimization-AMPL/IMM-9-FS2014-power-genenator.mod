#Data file: IMM-9-FS2014-power-genenator.mod
set GENERATOR;
param T; # No. of years
param P;   # Initial capacity (MW)
param Q {t in 1..T} >= 0;   # minimum yearly required capacity
param c{i in GENERATOR,t in 1..T}; # Yearly generating cost (CHF)
param G{i in GENERATOR}; # Capacity of generator i (MW)
var x {i in GENERATOR}: integer;  # No. of generator to buy
var H {t in 1..T} = P + sum{i in GENERATOR} x[i]*G[i];
minimize purchasingcost:
   sum {i in GENERATOR,t in 1..T} c[i,t] * x[i];
subject to minimumcapacity {t in 1..T}: H[t] >= Q[t];
