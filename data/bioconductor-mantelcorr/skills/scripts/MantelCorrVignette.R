# Code example from 'MantelCorrVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'MantelCorrVignette.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
library(MantelCorr)
data(GolubTrain)
dim(GolubTrain)
data <- GolubTrain


###################################################
### code chunk number 2: GetClusters
###################################################
kmeans.result <- GetClusters(data, 500, 100)


###################################################
### code chunk number 3: DistMatrices
###################################################
DistMatrices.result <- DistMatrices(data, kmeans.result$clusters)


###################################################
### code chunk number 4: MantelCorrs
###################################################
MantelCorrs.result <- MantelCorrs(DistMatrices.result$Dfull, DistMatrices.result$Dsubsets)


###################################################
### code chunk number 5: PermutationTest
###################################################
permuted.pval <- PermutationTest(DistMatrices.result$Dfull, DistMatrices.result$Dsubsets, 100, 38, 0.05)


###################################################
### code chunk number 6: ClusterList
###################################################
ClusterLists <- ClusterList(permuted.pval, kmeans.result$cluster.sizes, MantelCorrs.result)


###################################################
### code chunk number 7: ClusterGeneList
###################################################
ClusterGenes <- ClusterGeneList(kmeans.result$clusters, ClusterLists$SignificantClusters, data)


