# loading the LPWC library
library(LPWC)

# loading the simulated data
data(simdata)

# viewing the head of the simulated data
head(simdata)

# looking at the structure of the simulated data
str(simdata)

# adding the timepoints used for the simulated data
timepoints <- c(0, 2, 4, 6, 8, 18, 24, 32, 48, 72)
timepoints

# loading the ggplot2 library
library(ggplot2)

# setting a seed
set.seed(29876)


# store results for the high penalty simulation
high_results <- LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "high", iter = 10)

# compute distance with the high penalty
dist_high <- 1 - LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "low", iter = 10)$corr

# plot a hierarchical clustering
plot(hclust(dist_high))

# compute distance with the low penalty
dist_low <- 1 - LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "low", iter = 10)$corr

# divide the hierarchical clustering into 3 groups
cutree(hclust(dist_low), k = 3)
