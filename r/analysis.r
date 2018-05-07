# Box plot for average number of installs per day, globally
installs_per_day_type.melt <- melt(installs_per_day_type)
boxplot(
  formula = value ~ variable,
  data    = installs_per_day_type.melt )

# Install frequency per day
hist(log(training$installs), main="Install frequency per day")
