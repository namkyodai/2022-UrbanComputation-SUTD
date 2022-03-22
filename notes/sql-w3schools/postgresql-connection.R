require(DBI)
require(RPostgres)
require(RPostgreSQL)

con<-dbConnect(dbDriver("PostgreSQL"), dbname="w3school", host="localhost", port=5432, user="postgres",password="St029477")


# Select

df1 <- dbGetQuery(con, "SELECT * FROM customers")
print(df1)




