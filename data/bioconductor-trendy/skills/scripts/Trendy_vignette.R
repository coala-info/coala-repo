# Code example from 'Trendy_vignette' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis", tidy=TRUE---------
BiocStyle::latex()

## ----eval=FALSE, echo=TRUE, cache=FALSE, message=FALSE, warning=FALSE------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Trendy")

## ----eval=FALSE, echo=TRUE, cache=FALSE, message=FALSE, warning=FALSE------
# install.packages("devtools")
# library(devtools)
# install_github("rhondabacher/Trendy")

## ----eval=FALSE, echo=TRUE, cache=FALSE, message=FALSE, warning=FALSE------
# install.packages("devtools")
# library(devtools)
# install_github("rhondabacher/Trendy", ref="devel")

## ----eval=TRUE, echo=TRUE, message=FALSE-----------------------------------
library(Trendy)

## ----eval=TRUE-------------------------------------------------------------
data("trendyExampleData")
str(trendyExampleData)

## ----eval=FALSE------------------------------------------------------------
# library(EBSeq)
# Sizes <- MedianNorm(trendyExampleData)
# normalizedData <- GetNormalizedMat(trendyExampleData, Sizes)

## ----eval=TRUE-------------------------------------------------------------
time.vector <- 1:40
time.vector

## ----eval=TRUE-------------------------------------------------------------
time.vector <- rep(1:20, each = 2)
time.vector

## ----eval=TRUE-------------------------------------------------------------
time.vector <- c(rep(1, 3), rep(2:9, each = 2), rep(10:11, 3), 
                  rep(12:17, each=2), rep(18, 3))
time.vector
table(time.vector)

## ----eval=TRUE, fig.height=3, fig.width=7, fig.align='left', out.width='.8\\textwidth', message=FALSE----
mygene <- trendyExampleData[2,1:10]
equalSpacing <- rep(c(1:5), each=2)
trueSpacing <- c(1,1,2,2,10,10,20,20,60,60)
par(mfrow=c(1,2), mar=c(5,5,2,1))
plot(equalSpacing, mygene, ylab="Expression")
plot(trueSpacing, mygene, ylab="Expression")

## ----eval=TRUE-------------------------------------------------------------
time.vector <- 1:40
res <- trendy(Data = trendyExampleData, tVectIn = time.vector, maxK = 2)
res <- results(res)
res.top <- topTrendy(res)
# default adjusted R square cutoff is 0.5
res.top$AdjustedR2

## ----eval=TRUE, warning=FALSE, fig.width=7, fig.align='center', out.width='.8\\textwidth'----
res.trend <- trendHeatmap(res.top)
str(res.trend)

## ----eval=TRUE, warning=FALSE, fig.width=7, fig.align='left', out.width='.8\\textwidth', message=FALSE----
library(gplots)
heatmap.2(trendyExampleData[names(res.trend$firstup),],
  trace="none", Rowv=FALSE,Colv=FALSE,dendrogram='none',
	scale="row", main="top genes (first go up)")

## ----eval=TRUE, warning=FALSE, fig.width=7, fig.align='left', out.width='.8\\textwidth'----
heatmap.2(trendyExampleData[names(res.trend$firstdown),],
  trace="none", Rowv=FALSE,Colv=FALSE,dendrogram='none',
	scale="row", main="top genes (first go down)")

## ----eval=TRUE, warning=FALSE, fig.width=7, fig.align='left', out.width='.8\\textwidth'----
heatmap.2(trendyExampleData[names(res.trend$firstnochange),],
  trace="none", Rowv=FALSE,Colv=FALSE,dendrogram='none',
	scale="row", main="top genes (first no change)",
	cexRow=.8)

## ----eval=TRUE, warning=FALSE, fig.height=10, fig.width=10, fig.align='left', out.width='\\textwidth'----
par(mfrow=c(3,2))
plotFeature(Data = trendyExampleData, tVectIn = time.vector, simple = TRUE,
                    featureNames = names(res.trend$firstup)[1:6],
                    trendyOutData = res)

## ----eval=TRUE, warning=FALSE, fig.height=10, fig.width=10, fig.align='left', out.width='\\textwidth'----
par(mfrow=c(3,2)) #specify the layout of multiple plots in a single panel
plotFeature(Data = trendyExampleData, tVectIn = time.vector, simple = FALSE,
                    showLegend = TRUE, legendLocation='side',cexLegend=1,
                    featureNames = names(res.trend$firstup)[1:6],
                    trendyOutData = res)

## ----eval=TRUE, warning=FALSE, fig.height=10, fig.width=10, fig.align='left', out.width='\\textwidth'----
par(mfrow=c(3,2)) #specify the layout of multiple plots in a single panel
plotFeature(Data = trendyExampleData, tVectIn = time.vector, simple = FALSE, 
                    showLegend = TRUE, legendLocation='bottom',cexLegend=1,
                    featureNames = names(res.trend$firstup)[1:6],
                    trendyOutData = res)


## ----eval=TRUE, warning=FALSE, fig.height=10, fig.width=10, fig.align='left'----
par(mfrow=c(3,2))
plotFeature(Data = trendyExampleData,tVectIn = time.vector, simple=TRUE,
                    featureNames = names(res.trend$firstdown)[1:6],
                    trendyOutData = res)

## ----eval=TRUE, warning=FALSE, fig.height=5, fig.width=10, fig.align='left'----
par(mfrow=c(1,2))

plotFeature(trendyExampleData,tVectIn = time.vector, simple=TRUE,
                    featureNames = names(res.trend$firstnochange)[1:2],
                    trendyOutData = res)

## ----eval=TRUE, fig.align='center', fig.height=4, fig.width=6--------------
par(mfrow=c(1,1))
plot2 <- plotFeature(trendyExampleData,tVectIn = time.vector,
                    featureNames = "g2",
                    trendyOutData = res)
res.top$Breakpoints["g2",] # break points
res.top$AdjustedR2["g2"] # adjusted r squared
res.top$Segments["g2",] # fitted slopes of the segments
res.top$Segment.Pvalues["g2",] # p value of each the segment

## ----eval=TRUE-------------------------------------------------------------
trendy.summary <- formatResults(res.top)
trendy.summary[1:4,1:8]
# To save:
# write.table(trendy.summary, file="trendy_summary.txt")

## ----eval=TRUE, warning=FALSE, fig.height=3.5, fig.width=7, fig.align='left', out.width='.8\\textwidth'----
res.bp <- breakpointDist(res.top)
barplot(res.bp, ylab="Number of breakpoints", col="lightblue")

## ----eval=TRUE-------------------------------------------------------------
time.vector <- c(1:30, seq(31, 80, 5))
names(time.vector) <- colnames(trendyExampleData)
time.vector

## ----eval=TRUE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center', out.width='.8\\textwidth'----
res2 <- trendy(Data = trendyExampleData, tVectIn = time.vector, maxK=2)
res2 <- results(res2)
res.top2 <- topTrendy(res2)
res.trend2 <- trendHeatmap(res.top2)
str(res.trend2)

## ----eval=TRUE, fig.height=8, fig.width=8----------------------------------
par(mfrow=c(2,2))
plotFeature(trendyExampleData, tVectIn=time.vector, simple = TRUE,
                        featureNames = names(res.trend2$firstup)[1:4],
                        trendyOutData = res2)

## ----eval=TRUE-------------------------------------------------------------
time.vector <- rep(1:10, each=4)
names(time.vector) <- colnames(trendyExampleData)
time.vector

## ----eval=TRUE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center', out.width='.8\\textwidth'----
res3 <- trendy(Data = trendyExampleData, tVectIn = time.vector, maxK=2)
res3 <- results(res3)
res.top3 <- topTrendy(res3)
res.trend3 <- trendHeatmap(res.top3)

## ----eval=TRUE, fig.height=6, fig.width=6----------------------------------
par(mfrow=c(2,2))
plotFeature(trendyExampleData, tVectIn=time.vector, simple = FALSE, 
                        legendLocation = 'bottom',
                        featureNames = names(res.trend2$firstup)[1:4],
                        trendyOutData = res3)

## ----eval=TRUE, warning=FALSE,fig.align='left',  fig.height=4, fig.width=10, out.width='1\\textwidth'----
# Genes that peak
pat1 <- extractPattern(res3, Pattern = c("up","down"))
head(pat1)

par(mfrow=c(1,2))
plotPat1 <- plotFeature(trendyExampleData, tVectIn=time.vector,
                      featureNames = pat1$Gene[1:2],
                      trendyOutData = res3)


## ----eval=TRUE, warning=FALSE, fig.height=10, fig.width=7, fig.align='center', out.width='\\textwidth'----
# Genes that peak after some time
pat3 <- extractPattern(res3, Pattern = c("up","down"), Delay = 7)
head(pat3)

## ----eval=TRUE, warning=FALSE, fig.height=3.5, fig.width=7, fig.align='center', out.width='.8\\textwidth'----
# Genes that are constant, none
extractPattern(res2, Pattern = c("no change", "up"))
extractPattern(res2, Pattern = c("same", "up"))

## ----eval=FALSE, warning=FALSE, fig.height=3.5, fig.width=7, fig.align='center', out.width='.8\\textwidth'----
# library(Trendy)
# res.r2 <- c()
# for(i in 1:100) { # permute 100 times at least
#   BiocParallel::register(BiocParallel::SerialParam())
#   seg.shuffle <- trendy(trendyExampleData[sample(1:nrow(data.norm.scale), 100),], #sample genes each time
#                         tVectIn = sample(time.vector), # shuffle the time vector
#                         saveObject=FALSE, numTry = 5)
#   res <- results(seg.shuffle)
#   res.r2 <- c(res.r2, sapply(res, function(x) x$AdjustedR2))
# }
# 
# # Histogram of all R^2
# hist(res.r2, ylim=c(0,1000), xlim=c(0,1), xlab=expression(paste("Adjusted R"^"2")))
# 
# # Say you want to use the value such that less than 1% of permutations reach:
# sort(res.r2, decreasing=T)[round(.01 * length(res.r2))]
# # Say you want to use the value such that less than 5% of permutations reach:
# sort(res.r2, decreasing=T)[round(.05 * length(res.r2))]

## ----eval=TRUE, warning=FALSE----------------------------------------------
time.vector = c(1,1,2,2,10,10,20,20,60,60)
# How to shuffle the replicates -together-
set.seed(12)
shuf.temp=sample(unique(time.vector))
print(shuf.temp)
setshuff=do.call(c,lapply(shuf.temp, function(x) which(!is.na(match(time.vector, x)))))
use.shuff <- time.vector[setshuff]
print(use.shuff)

## ----eval=FALSE, warning=FALSE---------------------------------------------
# ## Then in the permutation code you'll do:
# 
# for(i in 1:100) { # permute 100 times at least
#   BiocParallel::register(BiocParallel::SerialParam())
# 
#   shuf.temp=sample(unique(time.vector))
#   setshuff=do.call(c,lapply(shuf.temp, function(x) which(!is.na(match(time.vector, x)))))
#   use.shuff <- time.vector[setshuff]
#   seg.shuffle <- trendy(trendyExampleData[sample(1:nrow(data.norm.scale), 100),], #sample genes each time
#                         tVectIn = use.shuff, # shuffle the time vector
#                         saveObject=FALSE, numTry = 5)
#   res <- results(seg.shuffle)
#   res.r2 <- c(res.r2, sapply(res, function(x) x$AdjustedR2))
# }
# 

## ----eval=TRUE, warning=FALSE, fig.height=7, fig.width=10, fig.align='left', out.width='.8\\textwidth'----

# Get trend matrix:
trendMat <- res.top$Trends
# Cluster genes using hierarchical clustering:
hc.results <- hclust(dist(trendMat))
plot(hc.results) #Decide how many clusters to choose
#Let's say there are 4 main clusters
hc.groups <- cutree(hc.results, k = 4)

## ----eval=TRUE, warning=FALSE, fig.height=5, fig.width=8, fig.align='center', out.width='.8\\textwidth'----
cluster1.genes <- names(which(hc.groups == 1))
res.trend2 <- trendHeatmap(res.top, featureNames = cluster1.genes)

cluster4.genes <- names(which(hc.groups == 4))
res.trend2 <- trendHeatmap(res.top, featureNames = cluster4.genes)

## ----eval=TRUE, warning=FALSE----------------------------------------------
res <- trendy(trendyExampleData, tVectIn = 1:40, maxK=2, saveObject = TRUE, fileName="exampleObject")
res <- results(res)

## ----eval=FALSE, warning=FALSE---------------------------------------------
# trendyShiny()

## ----eval=TRUE, warning=FALSE, tidy=TRUE-----------------------------------
sessionInfo()

