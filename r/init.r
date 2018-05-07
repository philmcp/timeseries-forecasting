require("sqldf")
require("RPostgreSQL")

# Init - connect to db etc
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "adjust",
                 host = "localhost", port = 5432,
                 user = "phil", password = "adjust")

options(sqldf.RPostgreSQL.user ="phil", 
        sqldf.RPostgreSQL.password ="adjust",
        sqldf.RPostgreSQL.dbname ="adjust",
        sqldf.RPostgreSQL.host ="localhost", 
        sqldf.RPostgreSQL.port =5432)
