#Data file: IMM-9-FS2014-Hot-Warm-asphalt.mod
set asphalt;  # Hot or warm asphalt construction methods
#----pavement information
param thickness; # in cm
param length; # in km
param width; # in m
param density; # kg/m3
param CO2_limit; #allowance level of CO2 (tons)
param CO2{asphalt}; # kg/m3 of asphalt
param rate{asphalt}; # tons/day
param cost{asphalt}; # CHF/m2
param cost_limit;
param time_limit{asphalt}; # days (maximum number of days for intervention)
param profit{asphalt}; # earning per m2 of asphalt
#--derived parameters if needed
param demand := (length*width*thickness*1000)*(density/1000);
#variables
var time{k in asphalt} >=0; # Number of days
#objective function
maximize profits: sum{k in asphalt} time[k]*rate[k]*profit[k]/(thickness*density/1000);
subject to totaldemand:  sum {k in asphalt} time[k]*rate[k] = demand;
subject to emission:  sum {k in asphalt} (time[k]*rate[k])*(CO2[k]/1000)/(density/1000)/1000 <= CO2_limit;
subject to budget: sum{k in asphalt} ((time[k]*rate[k])/(thickness*density/1000))*cost[k] <= cost_limit;
subject to times {k in asphalt}: time[k] <= time_limit[k];
