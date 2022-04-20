set MA; #materials (sand, salt, etc) in each source
set SO;		# supplier
param T>0; 	#planning years (for example 2 years)
param cost{i in MA,j in SO} >=0; # Cost of each materials
param require{i in MA, t in 1..T}; # tons of materials required for respective years
param limit_min{i in MA, j in SO, t in 1..T}>=0; #minimum requirement of quantity of material need to buy from each suppliers.
var buy{i in MA,j in SO,1..T}>=0; #actual quantity of material to buy from each supplier in each year.
var B{j in SO,t in 1..T} = sum{i in MA} buy[i,j,t]*cost[i,j]; # money of supplier j in year t.
#objective function
minimize total_cost:
	sum{i in MA,j in SO, t in 1..T} buy[i,j,t]*cost[i,j]; #minimum overal cost in T years
#constraints of the problem
subject to require1 {i in MA,j in SO, t in 1..T}: buy[i,j,t] >= limit_min[i,j,t]; 
#quantity of materials in each year must greater than a specific amount from each suppliers. (due to contractual agreement)
subject to	require2 {i in MA, t in 1..T}: sum{j in SO} buy[i,j,t] = require[i,t];
#Same amount of money to each of suppliers in each of the two years. (although they do not have to be the same in year 1 and year 2)
subject to	require3 {j in SO,k in SO,t in 1..T}: B[j,t] = B[k,t];