library(lpSolve)


#Linear Programing (LP)

f.Obj<-c(2,3)

##set constraint matrix coefficient
f.con<-matrix(c(1,3,
                2.5,1),nrow=2,byrow=TRUE)

## equality signs

f.dir <- c("<=",
           "<=")

## set right hand side coefficient

f.rhs <- c(8.25,
           8.75)

##Final value of obj

Z1 <- lp("max", f.Obj,f.con, f.dir, f.rhs)

Z1$solution
Z1

##### Mixed Linear Integer Programming (MIP)

Z2 <- lp("max", f.Obj,f.con, f.dir, f.rhs,int.vec = 1:2)
Z2$solution
Z2


