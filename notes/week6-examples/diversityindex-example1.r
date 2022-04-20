# Readming materials
# https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/diversity

#https://cran.r-project.org/web/packages/vegan/vignettes/diversity-vegan.pdf

#https://www.statology.org/shannon-diversity-index/

#http://www.countrysideinfo.co.uk/simpsons.htm  --> explain on Simpson index

##Loading the data
# Example 1
# Let us use the measure from the left.


# We will create two plots with three species each. However, the abundances are different for each species:

plot1<-c(300,335,365)
plot2<-c(20,49,931)
plots<-cbind(plot1,plot2)
plots

#simpson index
source("simpson-f.r")

simpson1


simpson1(plots, type ="complement")
simpson2(plots, type ="complement")

sample <- c(2,8,1,1,3)
sample

simpson1(cbind(sample), type ="complement")
simpson2(cbind(sample), type ="complement")



#shanon index
source("shannon-f.r")
plots<-rbind(plot1,plot2)
plots

shannon.h(plots)
shannon.h(rbind(sample))



## using vegan package
library(vegan)

H = diversity(sample,'shannon')

H


D1 <- diversity(sample,'simpson')
D1
1/(1-D1)
D2 <- diversity(sample,'invsimpson')
D2
##







