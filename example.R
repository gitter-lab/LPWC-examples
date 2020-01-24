## Loading libarries 
library(LPWC)
library(ggplot2)
library(fpc)
library(reshape2)

## Setting a seed
set.seed(12229)

## Reading the dataset
## You can replace the example URL below with a URL for any other publicly
## available dataset that has genes in the rows and time points in the columns.
## This example was used in the STEM paper (Ernst et al. 2005) and is from
## Guillemin et al. 2002 originally.
## See http://www.cs.cmu.edu/~jernst/st/biodata.html for details.
data <- read.delim("http://www.cs.cmu.edu/~jernst/st/g27_1.txt", header = T)

## Selecting columns with time series data
num.data <- data[, c(2, 3:7)]

## Removing genes with missing expression values
num.data <- num.data[complete.cases(num.data), ]
## Removing gene with no gene symbol
num.data <- num.data[num.data$Gene.Symbol != "",]

## Subset the data by randomly selecting 100 genes.
## Ignore this line when analyzing your data, we subset the data to 
## speed up the computation in this example.
num.data <- num.data[sample(1:dim(num.data)[1], 100), ]

# Assign names to the dataset and remove the gene symbol from the dataset column
rownames(num.data) <- num.data$Gene.Symbol
num.data <- num.data[, -1]

## Analyzing time series data of 100 genes using LPWC with high penalty.
## The timepoints in hours are taken from the header row of
## http://www.cs.cmu.edu/~jernst/st/g27_1.txt
## The first timepoint is set to 0.0001 instead of 0 due to a numeric
## problem with the underlying solver.
## See issue: https://github.com/gitter-lab/LPWC/issues/57
output.high <- corr.bestlag(data = num.data, timepoints = c(0.0001, 0.5, 3, 6, 12))

## Analyzing time series data of 100 genes using LPWC with low penalty,
## the low penalty allows more lags.
output.low <- corr.bestlag(data = num.data, timepoints = c(0.0001, 0.5, 3, 6, 12), 
                           penalty = "low")

## Demonstrating more lags with low penalty.
## Comparing the lags output for low and high 
## The first row shows the lag value and the second row shows the number
## of genes with that lag.
## There are slightly more non-zero lags with the low penalty.
table(output.high$lags)
table(output.low$lags)

## If you want to customize the penalty instead of using the high or low
## default values, you can control the C parameter in the penalty funtion.
## We picked C = 1/100 in the example below.
output.C <- corr.bestlag(data = num.data, timepoints = c(0, 0.5, 3, 6, 12), 
                         C = 1/100)

## We use the silhouette method to determine the number of clusters with a minimum of 3
## clusters and maximum of 10 clusters.
sil.width <- rep(NA, length(3:10))
for(i in 3:10){
  clust <- cutree(hclust(1 - output.C$corr), i)
  sil.width[i - 2] <- cluster.stats(1 - output.C$corr,  clust)$avg.silwidth
}

## Picking the best number of clusters based on average silhouette width
plot(3:10, sil.width, type = "l")

## Based on the plot, 8 was picked as the ideal number of clusters.
## Both 5 and 8 are a good number of clusters to pick because they have
## high average silhouette width.
## The average silhouette width describes the tightness between the items 
## in each cluster.
cluster.size <- 8

## Plotting and saving the clusters
for(i in 1:cluster.size){
  clust <- cutree(hclust(1 - output.C$corr), cluster.size)
  sub.data <- melt(num.data[clust == i, ])
  sub.data$time <- rep(c(0, 0.5, 3, 6, 12), each = sum(clust == i))
  sub.data$gene <- rep(1:sum(clust == i), 5)
  
  ## Plotting the expression patterns for each cluster
  temp_plot <- ggplot(sub.data, aes(x = time, y = value, group = gene)) + 
    geom_line(size = 0.5) +
    xlab("Time (h)") + ylab("Expression")
  
  ## Saving each cluster plot.
  ## Open the plot_*.png files that are created to view the clusters.
  ggsave(temp_plot, file=paste0("plot_", i,".png"), width = 14, height = 10, units = "cm")
}

## Inspect the R environment
sessionInfo()

