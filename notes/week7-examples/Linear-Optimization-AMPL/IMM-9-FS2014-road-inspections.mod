#file name: IMM-9-FS2014-road-inspections.mod
#Coded by Nam Lethanh. It is used for the course "IMM-FS2014".  
# AMPL language
# April, 2014
#-----------------------------------------------------------------------
#in order to ensure that all 
set	TEST; # index of testing types
set	PERSON; # index of person
param c{TEST}; #cost of test i (CHF/km)
param d{i in TEST, j in PERSON}; #capacity of personnel (Hour/km)
param M{PERSON}; #Availability time of personnel type j (hours per week)
param L {i in TEST}; # Maximum length of road can be inspected with respect to type i
var x{TEST}:>=0; # Length of test for type i

#objective function: Maximize the total benefit
maximize total_benefit: sum{i in TEST} x[i]*c[i];
#constraint: 
subject to 
#Personnel capacity
personnel{j in PERSON}: sum{i in TEST} x[i]*d[i,j] <=M[j];

# Maximum of road length can be tested
Max_road {i in TEST}: x[i] <=L[i];
#end