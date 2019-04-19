## loading libarries 
library(LPWC)
library(ggplot2)
library(fpc)
library(reshape2)

## setting a seed
set.seed(12229)

## reading the dataset
## you can replace the example URL below with a URL for any other publicly
## available dataset that has genes in the rows and time points in the columns
## this example was used in the STEM paper (Ernst et al. 2005) and is from
## Guillemin et al. 2002 originally
## see http://www.cs.cmu.edu/~jernst/st/biodata.html for details
data <- read.delim("http://www.cs.cmu.edu/~jernst/st/g27_1.txt", header = T)

## selecting columns with time series data
# *** TODO: use the gene names ***
num.data <- data[, c(3:7)]

## removing genes with missing expression values
num.data <- num.data[complete.cases(num.data), ]

## subset the data by randomly selecting 100 genes
## ignore this line when analyzing your data, we subset the data to 
## speed up the computation in this example
num.data <- num.data[sample(1:dim(num.data)[1], 100), ]

## analyzing time series data of 100 genes using LPWC with high penalty
## the timepoints in hours are taken from the header row of
## http://www.cs.cmu.edu/~jernst/st/g27_1.txt
## *** TODO: isn't the first time point 0 h ***
output.high <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12))

## analyzing time series data of 100 genes using LPWC with low penalty,
## the low penalty allows more lags
# *** TODO: can we demonstrate how it allows more lags by showing the number of nonzero lags? ***
output.low <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12), 
                           penalty = "low")

## if you want to customize the penalty instead of using the high or low
## default values, you can control the C parameter in the penalty funtion
## we picked C = 1/100 in the example below
output.C <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12), 
                         C = 1/100)

## we use the silhouette method to determine the number of clusters with a minimum of 3
## clusters and maximum of 20 clusters
sil.width <- rep(NA, length(3:20))
for(i in 3:20){
## *** TODO: why do you reset the seed each time ***
  set.seed(123456)
  clust <- cutree(hclust(1 - output.C$corr), i)
  sil.width[i - 2] <- cluster.stats(1 - output.C$corr,  clust)$avg.silwidth
}

## picking the best number of clusters based on average silhouette width
plot(3:20, sil.width, type = "l")

## based on the plot, 7 was picked as the ideal cluster size 
cluster.size <- 7

## plotting and saving the clusters
for(i in 1:cluster.size){
  clust <- cutree(hclust(1 - output.C$corr), cluster.size)
  sub.data <- melt(num.data[clust == i, ])
  sub.data$time <- rep(c(0, 0.5, 3, 6, 12), each = sum(clust == i))
  sub.data$gene <- rep(1:sum(clust == i), 5)
  
  ## plotting the expression patterns for each cluster
  temp_plot <- ggplot(sub.data, aes(x = time, y = value, group = gene)) + 
    geom_line(size = 0.5) +
    xlab("Time (h)") + ylab("Expression")
  
  ## saving each cluster plot
  ggsave(temp_plot, file=paste0("plot_", i,".png"), width = 14, height = 10, units = "cm")
}

## ** TODO: output the session state such as the package versions uses **
