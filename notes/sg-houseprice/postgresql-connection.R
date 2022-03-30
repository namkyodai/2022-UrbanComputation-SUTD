require(DBI)
require(RPostgres)
require(RPostgreSQL)

con<-dbConnect(dbDriver("PostgreSQL"), dbname="sghousingprice", host="localhost", port=5432, user="postgres",password="St029477")




