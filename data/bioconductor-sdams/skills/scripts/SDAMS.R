# Code example from 'SDAMS' vignette. See references/ for full tutorial.

### R code from vignette source 'SDAMS.Rnw'

###################################################
### code chunk number 1: quick start (eval = FALSE)
###################################################
## library("SDAMS")
## data("exampleSumExp")
## results <- SDA(exampleSumExp)


###################################################
### code chunk number 2: quick start (eval = FALSE)
###################################################
## data("exampleSingleCell")
## results_SC <- SDA(exampleSingleCell)


###################################################
### code chunk number 3: directory (eval = FALSE)
###################################################
## path1 <- "/path/to/your/feature.csv/"
## path2 <- "/path/to/your/group.csv/"


###################################################
### code chunk number 4: GetDirectory
###################################################
directory1 <- system.file("extdata", package = "SDAMS", mustWork = TRUE)
path1 <- file.path(directory1, "ProstateFeature.csv")
directory2 <- system.file("extdata", package = "SDAMS", mustWork = TRUE)
path2 <- file.path(directory2, "ProstateGroup.csv")


###################################################
### code chunk number 5: CsvInput
###################################################
library("SDAMS")
exampleSE1 <- createSEFromCSV(path1, path2)
exampleSE1


###################################################
### code chunk number 6: Accessors
###################################################
head(assay(exampleSE1)[,1:10])
head(colData(exampleSE1)$grouping)


###################################################
### code chunk number 7: MatrixInput
###################################################
set.seed(100)
featureInfo <- matrix(runif(8000, -2, 5), ncol = 40)
featureInfo[featureInfo<0] <- 0
rownames(featureInfo) <- paste("gene", 1:200, sep = '')
colnames(featureInfo) <- paste('cell', 1:40, sep = '')
groupInfo <- data.frame(grouping=matrix(sample(0:1, 40, replace = TRUE),
                        ncol = 1))
rownames(groupInfo) <- colnames(featureInfo)

exampleSE2 <- createSEFromMatrix(feature = featureInfo, colData = groupInfo)
exampleSE2
head(assay(exampleSE2)[,1:10])
head(colData(exampleSE2)$grouping)



###################################################
### code chunk number 8: resultsForGamma
###################################################
results <- SDA(exampleSE1)
head(results$gamma[,1])
head(results$pv_gamma[,1])
head(results$qv_gamma[,1])


###################################################
### code chunk number 9: resultsForBeta
###################################################
head(results$beta[,1])
head(results$pv_beta[,1])
head(results$qv_beta[,1])


###################################################
### code chunk number 10: resultsFor2part
###################################################
head(results$pv_2part[,1])
head(results$qv_2part[,1])


###################################################
### code chunk number 11: outputForFeatureName
###################################################
head(results$feat.names)


###################################################
### code chunk number 12: AnalysisAndResults
###################################################
results_SC <- SDA(exampleSE2)
head(results_SC$pv_gamma[,1])
head(results_SC$qv_gamma[,1])
head(results_SC$pv_beta[,1])
head(results_SC$qv_beta[,1])
head(results_SC$pv_2part[,1])
head(results_SC$qv_2part[,1])
head(results_SC$feat.names)


###################################################
### code chunk number 13: sessionInfo
###################################################
toLatex(sessionInfo())


