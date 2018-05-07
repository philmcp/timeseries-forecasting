library(lubridate)
library(doParallel)
library(caret)

economics$month <- as.factor(month(economics$date))
set.seed(123)
seeds <- vector(mode = "list", length = 432)
for(i in 1:431) seeds[[i]] <- sample.int(1000, 5)

seeds[[432]] <- sample.int(1000, 1)

registerDoParallel(cores=2)

myTimeControl <- trainControl(method = "timeslice",
                              initialWindow = 36,
                              horizon = 12,
                              fixedWindow = FALSE,
                              allowParallel = TRUE,
                              seeds = seeds)