## loading libarries 
library(LPWC)
library(ggplot2)

# setting the seed
set.seed(12229)

## reading the dataset
## please replace this link with your dataset
data <- read.delim("http://www.cs.cmu.edu/~jernst/st/g27_1.txt", header = T)

## selecting columns with time series data
num.data <- data[, c(3:7)]

## removing genes with missing intensity
num.data <- num.data[complete.cases(num.data), ]

## subset the data by randomly collecting 200 genes
## ignore this line when analyzing your data, we subset the data to 
##speed up the computation
num.data <- num.data[sample(1:dim(num.data)[1], 100), ]

## analyzing time series data with 100 genes using LPWC with high penalty
output.high <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12))

## analyzing time series data with 100 genes using LPWC with low penalty
output.low <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12), 
                           penalty = "low")








