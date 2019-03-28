# loading LPWC library
library(LPWC)

# loading the simulated data
data(simdata)

# viewing head of the simulated data
head(simdata)

# looking at the structure of the simulated data
str(simdata)

# adding timepoint respected to the simulated data
timepoints <- c(0, 2, 4, 6, 8, 18, 24, 32, 48, 72)
timepoints

# loading ggplot2 library
library(ggplot2)

#setting seed
set.seed(29876)


# store results for high penalty simulation
high_results <- LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "high", iter = 10)

# compute distance for high penalty
dist_high <- 1 - LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "low", iter = 10)$corr

# plot hierarchical clustering
plot(hclust(dist_high))

# compute distance for low penalty
dist_low <- 1 - LPWC::corr.bestlag(simdata, timepoints = timepoints, max.lag = 2, penalty = "low", iter = 10)$corr

# divide the cluster to 3 groups
cutree(hclust(dist_low), k = 3)



