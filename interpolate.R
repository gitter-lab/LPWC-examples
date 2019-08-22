# loading the LPWC library, which has the simulated data
library(LPWC)
# loading the ggplot2 library
library(ggplot2)

# loading the simulated data
data(simdata)

# viewing the head of the simulated data
head(simdata)

# looking at the structure of the simulated data
str(simdata)

# adding the timepoints used for the simulated data
timepoints <- c(0, 2, 4, 6, 8, 18, 24, 32, 48, 72)


# interpolate if the difference between consecutive timepoints is greater than 10
# when interpolating, we keep adding 10 to the time until the difference between
# consecutive timepoints is less than or equal to 10
# alternative interpolations, such as adding equally-spaced interpolated timepoints, would
# also be reasonable
new_timepoints <- c(timepoints[1])
k <- 10
for(i in 2:length(timepoints)){
  if((timepoints[i] - timepoints[i - 1]) > k){
    value <- timepoints[i - 1] + k
    repeat{
      if((timepoints[i] - max(value)) <= k){
        break
      }
      value <- c(value, max(value) + k)
    }
    print(value)
    new_timepoints <- c(new_timepoints, value, timepoints[i])
  }
  else{
    new_timepoints <- c(new_timepoints, timepoints[i])
  }
}

# creating new data frame and respective index for old and new data
new_simdata <- array(NA, c(dim(simdata)[1], length(new_timepoints)))
complete_index <- which(new_timepoints %in% timepoints)
incomplete_index <- which(!new_timepoints %in% timepoints)

# fill in the existing data
new_simdata[, complete_index] <- as.matrix(simdata)

# implement linear interpolation
for(i in incomplete_index){
  # low is the previous original timepoint, high is the next original timepoint
  low <- max(complete_index[i > complete_index])
  high <- min(complete_index[i < complete_index])
  high_weight <- (new_timepoints[i] - new_timepoints[low]) / 
                 (new_timepoints[high] - new_timepoints[low])
  new_simdata[, i] <- high_weight * new_simdata[, high] + 
                      (1- high_weight) * new_simdata[, low]
  
}

# interpolated data
new_simdata

# interpolated timepoints
new_timepoints

# after interpolating, the new data and new timepoints can be clustered with LPWC
# as demonstrated in LPWC.R
