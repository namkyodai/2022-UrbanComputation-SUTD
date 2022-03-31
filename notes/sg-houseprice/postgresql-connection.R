require(DBI)
require(RPostgres)
require(RPostgreSQL)

#con<-dbConnect(dbDriver("PostgreSQL"), dbname="hcmc_population2019", host="localhost", port=5432, user="postgres",password="St029477")


con<- dbConnect(RPostgres::Postgres(),user="postgres",password="St029477",host="localhost",port=5432,dbname="sghouseprice")

dbListTables(con)
# Select

df1 <- dbGetQuery(con, "SELECT * FROM communes")
library(dplyr)

print(df1)

glimpse(df1)



### below code is for another example (for testing only)


df2 <- dbGetQuery(con, "select id as id, geom, ST_Area(geom,false)/1000000 as area, tongdans01/(ST_Area(geom,false)/1000000) as density
from communes")



df3 <- dbGetQuery(con, "select id as id, geom, ST_Area(geom,false)/1000000 as area, tongdans01/(ST_Area(geom,false)/1000000) as density
from communes")
