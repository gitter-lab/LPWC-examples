# setting the seed
set.seed(18990)

## reading the dataset, please replace this link with your dataset
data <- read.delim("http://www.cs.cmu.edu/~jernst/st/g27_1.txt", header = T)

## selecting columns with time series data
num.data <- data[, c(3:7)]

## removing genes with missing intensity
num.data <- num.data[complete.cases(num.data), ]

## subset the data by randomly collecting 200 genes
## ignore this line when analyzing your data, we subset the data to speed up the computation
num.data <- num.data[sample(1:dim(num.data)[1], 200), ]





