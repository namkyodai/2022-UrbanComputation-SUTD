source("postgresql-connection.R")


df <- dbGetQuery(con, "select * from hcmcforanalysis_nogeom")
#print(df)


df<-data.frame(df)

#plotting some variable as part of descriptive statistics
#loading ggplot2 package
library(ggplot2)


#population density
p <- ggplot(df, aes(x=matdo)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, color="darkblue", fill="lightblue")+
  labs(title="Density curve",x="Population Density", y = "Density")

p 

# Density differenciation between male/female, combinating histogram and density plot
#first to melt data for 
library(reshape)

library(tidyverse) #using tydyverse package for data transformation and manupulation
#library(dplyr)

#selection columns of interest for melting

# sex differencec

df1<-select(df, id, c_nameen, p_nameen, d_nameen, danso_nam, danso_nu)

df1<-melt(df1, id =c("id", "c_nameen", "p_nameen", "d_nameen"))


p1<-ggplot(df1, aes(x=value)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") 
p1
# Color by groups
p1<-ggplot(df1, aes(x=value, color=variable, fill=variable)) + 
  geom_histogram(aes(y=..density..), alpha=0.5, position="identity")+
  geom_density(alpha=.2) +
  labs(title="Density",x="Population", y = "Density")#+ 
 # scale_fill_discrete(name = "Sex", labels = c("Male", "Female"))

p1

df1 %>%                               # Summary by group using dplyr
  group_by(variable) %>% 
  summarize(min = min(value),
            q1 = quantile(value, 0.25),
            median = median(value),
            mean = mean(value),
            q3 = quantile(value, 0.75),
            max = max(value))


# some histograph by district and communune.

#library(ggsci)

#graph at district level
ggplot(df1, aes(fill=variable, y=value, x=reorder(d_nameen,value,sum))) + 
  geom_bar(position="stack", stat="identity")+
  coord_flip()+
  labs(title="Sex distribution histogram",x="District", y = "District Population (thousands)")+ 
  scale_fill_discrete(name = "Sex", labels = c("Male", "Female"))


#graph at ward level
ggplot(filter(df1, d_nameen =="District 4"), aes(fill=variable, y=value, x=reorder(c_nameen,value,sum))) + 
  geom_bar(position="stack", stat="identity")+
  coord_flip()+
  labs(title="Sex distribution histogram",x="District 4", y = "Population")+ 
  scale_fill_discrete(name = "Sex", labels = c("Male", "Female"))


arrange(df1, desc(value))


# education differencece

df2<-select(df, id, c_nameen, p_nameen, d_nameen, daihoc, thacsy, tiensi)

df2<-melt(df2, id =c("id", "c_nameen", "p_nameen", "d_nameen"))

#density


p2<-ggplot(df2, aes(x=value, color=variable, fill=variable)) + 
  geom_histogram(aes(y=..density..), alpha=0.5, 
                 position="identity")+
  geom_density(alpha=.2) 

p2

#distribution
ggplot(df2, aes(fill=variable, y=value, x=reorder(d_nameen,value,sum))) + 
  geom_bar(position="stack", stat="identity")+
  coord_flip()+
  labs(title="Education",x="District", y = "Population")


#library(raster)

#x <- shapefile('HCMC_Communes.shp')
#crs(x)
#a <- area(x) / 1000000

#library(terra)
#x <- vect('HCMC_Communes.shp')
#b <- expanse(x) / 1000000

