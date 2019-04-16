## loading libarries 
library(LPWC)
library(ggplot2)
library(fpc)
library(reshape2)

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

## analyzing time series data with 100 genes using LPWC with low penalty,
## low penalty picks up more lags
output.low <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12), 
                           penalty = "low")


## how if you want to customize your own penalty, you can control the C parameter
## in the penalty funtion, we picked C = 1/100 in the example below
output.C <- corr.bestlag(data = num.data, timepoints = c(0.1, 0.5, 3, 6, 12), 
                         C = 1/100)


## we use silhouttte to determine the right number of cluster size with a minimum of 3 
## clusters and maximum of 20 clusters
sil.width <- rep(NA, length(3:20))
for(i in 3:20){
  set.seed(123456)
  clust <- cutree(hclust(1 - output.C$corr), i)
  sil.width[i - 2] <- cluster.stats(1 - output.C$corr,  clust)$avg.silwidth
}

## picking the best cluster based on average silhouette width
plot(3:20, sil.width, type = "l")

## based on the plot, 7 was picked as the ideal cluster size 
## the cluster are plotted and saved
for(i in 1:7){
  clust <- cutree(hclust(1 - output.C$corr), 7)
  sub.data <- melt(num.data[clust == i, ])
  sub.data$time <- rep(c(0, 0.5, 3, 6, 12), each = sum(clust == i))
  sub.data$gene <- rep(1:sum(clust == i), 5)
  
  # ggplot for each cluster
  temp_plot <- ggplot(sub.data, aes(x = time, y = value, group = gene)) + 
    geom_line(size = 0.5) +
    xlab("Time(min)") + ylab("Intensity")
  
  #saving each cluster plot
  ggsave(temp_plot, file=paste0("plot_", i,".png"), width = 14, height = 10, units = "cm")
}



