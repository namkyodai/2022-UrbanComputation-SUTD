#Dataframe 1
#https://www.rdocumentation.org/packages/geosphere/versions/1.5-14/topics/distm

library(geosphere)

# Example 1
xy <- rbind(c(0,0),c(90,90),c(10,10),c(-120,-45))

distm(xy)



xy2 <- rbind(c(0,0),c(10,-10))
xy2

distm(xy, xy2)

distm(xy2, xy)

# Example 2

a<-structure(list(lat = c(50L),
                    lon = c(14L)),
               .Names = c("lat", "lon"),
               row.names = c(NA,  1L),
               class = "data.frame")
a


b<-structure(list(lat = c(40, 50),
                    lon = c(14, 12)),
               .Names = c("lat", "lon"),
               row.names = c(NA,  2L),
               class = "data.frame")
b

plot.new()
plot(a,col="red", type="p")
points(b,col = "blue")

distance.a.b <- distm(a[,c('lon','lat')], b[,c('lon','lat')], fun=distCosine)
distance.a.b


### example 3


df1<-structure(list(lat = c(54L, 55L, 51L),
                    lon = c(14L, 8L, 15L)),
               .Names = c("lat", "lon"),
               row.names = c(NA,  3L),
               class = "data.frame")

df2<-structure(list(lat = c(51, 52, 54.5, 51.2),
                    lon = c(9, 13, 14, 11)),
               .Names = c("lat", "lon"),
               row.names = c(NA,  4L),
               class = "data.frame")

df1
df2

plot.new()
plot(df1,col="red", type="p")
points(df2,col = "blue")


distance.df1.df2 <- distm(df1[,c('lon','lat')], df2[,c('lon','lat')], fun=distVincentyEllipsoid)

distance.df1.df2

row <- length(distance.df1.df2[,1])
row

column <- length(distance.df1.df2[1,])
column

x1<-matrix(double(1),nrow=row,ncol=1)
x2<-matrix(double(1),nrow=row,ncol=1)

vidu <- c(2,1,3,6)
which.min(vidu)
which.max(vidu)

for (i in 1:row){
#  for (j in 1: column){
    x1[i] <- which.min(distance.df1.df2[i,])
    x2[i] <- distance.df1.df2[i,x1[i]]
#  }
}
x1
x2

x1.x2 <- cbind(x1,x2)

x1.x2

### adding more value


df3<-structure(list(lat = c(54L, 55L, 51L),
                    lon = c(14L, 8L, 15L),
                    house = c("house01", "house02", "house03")
                    ),
               .Names = c("lat", "lon","house"),
               row.names = c(NA,  3L),
               class = "data.frame")

df4<-structure(list(lat = c(51, 52, 54.5, 51.2),
                    lon = c(9, 13, 14, 11),
                            poi = c("poi01","poi02","poi03","poi04")),
               .Names = c("lat", "lon",'poi'),
               row.names = c(NA,  4L),
               class = "data.frame")

df3


distance.df3.df4 <- distm(df3[,c('lon','lat')], df4[,c('lon','lat')], fun=distVincentyEllipsoid)

distance.df3.df4

row <- length(distance.df3.df4[,1])
column <- length(distance.df3.df4[1,])

x3<-matrix(double(1),nrow=row,ncol=1)
x4<-matrix(double(1),nrow=row,ncol=1)
for (i in 1:row){
  #  for (j in 1: column){
  x3[i] <- which.min(distance.df1.df2[i,])
  x4[i] <- distance.df1.df2[i,x1[i]]
  #  }
}

x3.x4 <- cbind(x3,x4)
x3.x4
x5 <- df3
x5$distance <- x3.x4[,2]
x5
x5$poi <-df4$poi[apply(distance.df3.df4, 1, which.min)]
x5


