library(forecast)
library(xts)
library(e1071)
library(doParallel)
library(dynlm)
library(caret)

# Compute timeseries regressinon, creates graphs, prints summary and return model
models <- list(
  dynlm(data=training, log_installs ~ avg1), 
  dynlm(data=training, log_installs ~ avg1 + avg3),
  dynlm(data=training, log_installs ~ avg1 + avg3 + avg7),
  dynlm(data=training, log_installs ~ avg1 + avg3 + avg7 + avg20),
  dynlm(data=training, log_installs ~ avg1 + avg3 + avg7 + avg20 + min20),
  dynlm(data=training, log_installs ~ avg1 + avg3 + avg7 + avg20 + min20 + max20)
  )

# Evaluation
n <- character(length(models))
sq <- numeric(length(models))
error <- numeric(length(models))

# Extract r squared and error from model summaries
for(i in 1:length(models)){
  m <- models[[i]]
  temp <- strsplit(toString(m$call$formula),",")
  n[i] <- gsub(" ", "", temp[[1]][3])
  sq[i] <- summary(m)$r.squared
  error[i] <- summary(m)$sigma
}

# Plot results
par(mar=c(15,4,4,2)) 
barplot(sq, names.arg=n,  ylim=range(pretty(c(min(sq), max(sq)))), xpd = FALSE, main='Adjusted R-squared',las=2)
barplot(error, names.arg=n,  ylim=range(pretty(c(min(error), max(error)))), xpd = FALSE, main='Residual standard error',las=2)

 