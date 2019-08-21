# loading the LPWC and ggplot2 libraries
library(LPWC)
library(ggplot2)

# loading the simulated data
data(simdata)

# viewing the head of the simulated data
head(simdata)

# looking at the structure of the simulated data
str(simdata)

# adding the timepoints used for the simulated data
timepoints <- c(0, 2, 4, 6, 8, 18, 24, 32, 48, 72)


# interpolate if timepoints larger than 10 mins
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

## creating new data frame and respective index for old and new data
new_simdata <- array(NA, c(dim(simdata)[1], length(new_timepoints)))
complete_index <- which(new_timepoints %in% timepoints)
incomplete_index <- which(!new_timepoints %in% timepoints)

# fill in the existing data
new_simdata[, complete_index] <- as.matrix(simdata)

## implement linear interpolation
for(i in incomplete_index){
  low <- max(complete_index[i > complete_index])
  high <- min(complete_index[i < complete_index])
  high_weight <- (new_timepoints[i] - new_timepoints[low]) / 
                 (new_timepoints[high] - new_timepoints[low])
  new_simdata[, i] <- high_weight * new_simdata[, high] + 
                      (1- high_weight) * new_simdata[, low]
  
}

## interpolated data
new_simdata

## interpolated timepoints
new_timepoints

