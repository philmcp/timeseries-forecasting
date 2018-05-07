# Overview
I tried to build a regression model which could model / forecast the number of installs for a particular app on a given day.

# Approach
I used the following approach:

- *Postgresql:* load and store the data from CSV. Also, computed the features using Postgresql. Unfortunately however, this means you won't be able to run the code - I can put the database online though if this would help.
- *R*: Building and evaluation of regression models

I used the following data partitions:

- *Validation set*: The first month (Jan). As we are using a moving average, the first month is used to "warm up" the moving averages e.g. avg20 = the average installs in the last 20 days
- *Training set:* Months Feb - Nov. Used to train the LM models
- *Test set*: December

**UPDATE** I now plan to evaluate using a more complex time series cross validation (see https://rpubs.com/crossxwill/time-series-cv)

# Hypothesis
I was interested to see if there were any temporal trends within the data. Therefore, I begun by analysing the data, creating various scatter plots etc. By doing this, I quickly realised that the number of installs on the weekend was slightly more than during the week (on average). (See graphs/dow-vs-num-installs.png). Therefore I looked to exploit this feature in my model.

# Future work
Obviously this is a very early, preliminary work just for the interview, but with more time I'd like to:
- Explore additional features (e.g. platform, week of the year etc)
- Execute more indepth cross validation experimentation to ensure the model isn't overfitting. I am using the dynlm package, which should ensure that no future information is used at any point, but I'd need more time to make sure of this and do some testing

# Notes
I picked R as this is the stack that you use at Adjust - I haven't used R in a few years (!) so excuse me here...
