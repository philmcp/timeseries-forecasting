library(magrittr)
library(dplyr)
library(reshape2)
require("sqldf")
require("RPostgreSQL")

# Connect to db etc

####################################################################################
# Dont worry, I wouldn't include the password to the database in a production project ;)
####################################################################################

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "adjust",
                 host = "localhost", port = 5432,
                 user = "phil", password = "adjust")

options(sqldf.RPostgreSQL.user ="phil", 
        sqldf.RPostgreSQL.password ="adjust",
        sqldf.RPostgreSQL.dbname ="adjust",
        sqldf.RPostgreSQL.host ="localhost", 
        sqldf.RPostgreSQL.port =5432)


# Compute extra time features such as day of week
addFeatures <- function(df){
  df = within(df, {
    dow =  as.POSIXlt(date)$wday
    week =  as.POSIXlt(date)$yday %% 52
    month =  as.POSIXlt(date)$mon
    day =  as.POSIXlt(date)$yday
    #day_type = as.POSIXlt(date)$wday == 0 | as.POSIXlt(date)$wday == 6
    log_installs = log2(installs)
  })
  as.factor(df$platform)
  df$date <- NULL
  df$app_token <- NULL
  df$platform <- NULL
  return(df)
}


# Most popular apps
popular <- sqldf("SELECT app_token, installs FROM popular LIMIT 10") 


# Training & testing
training <- sqldf("SELECT * FROM installs_window WHERE extract(month from date)::bigint != 1 AND extract(month from date)::bigint != 12  ORDER BY date ASC")
testing <- sqldf("SELECT * FROM installs_window WHERE extract(month from date)::bigint = 12 ORDER BY date ASC")

training <- addFeatures(training)
testing <- addFeatures(testing)

