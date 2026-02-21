# Code example from 'DFP' vignette. See references/ for full tutorial.

### R code from vignette source 'DFP.Rnw'

###################################################
### code chunk number 1: DFP.Rnw:69-70
###################################################
library(DFP)


###################################################
### code chunk number 2: DFP.Rnw:73-76
###################################################
data(rmadataset)
# Number of genes in the test set
length(featureNames(rmadataset))


###################################################
### code chunk number 3: DFP.Rnw:79-80
###################################################
res <- discriminantFuzzyPattern(rmadataset)


###################################################
### code chunk number 4: DFP.Rnw:83-84
###################################################
plotDiscriminantFuzzyPattern(res$discriminant.fuzzy.pattern)


###################################################
### code chunk number 5: DFP.Rnw:100-101
###################################################
library(DFP)


###################################################
### code chunk number 6: DFP.Rnw:106-107
###################################################
dataDir <- system.file("extdata", package="DFP"); dataDir


###################################################
### code chunk number 7: DFP.Rnw:110-112
###################################################
fileExprs <- file.path(dataDir, "exprsData.csv"); fileExprs
filePhenodata <- file.path(dataDir, "pData.csv"); filePhenodata


###################################################
### code chunk number 8: DFP.Rnw:115-116
###################################################
rmadataset <- readCSV(fileExprs, filePhenodata); rmadataset


###################################################
### code chunk number 9: DFP.Rnw:119-123
###################################################
skipFactor <- 3 # Factor to skip odd values
zeta <- 0.5 # Threshold used in the membership functions to label the float values with a discrete value
piVal <- 0.9 # Percentage of values of a class to determine the fuzzy patterns
overlapping <- 2 # Determines the number of discrete labels


###################################################
### code chunk number 10: DFP.Rnw:130-132
###################################################
mfs <- calculateMembershipFunctions(rmadataset, skipFactor); mfs[[1]]
plotMembershipFunctions(rmadataset, mfs, featureNames(rmadataset)[1:2])


###################################################
### code chunk number 11: DFP.Rnw:138-140
###################################################
dvs <- discretizeExpressionValues(rmadataset, mfs, zeta, overlapping); dvs[1:4,1:10]
showDiscreteValues(dvs, featureNames(rmadataset)[1:10],c("healthy", "AML-inv"))


###################################################
### code chunk number 12: DFP.Rnw:146-148
###################################################
fps <- calculateFuzzyPatterns(rmadataset, dvs, piVal, overlapping); fps[1:30,]
showFuzzyPatterns(fps, "healthy")[21:50]


###################################################
### code chunk number 13: DFP.Rnw:154-156
###################################################
dfps <- calculateDiscriminantFuzzyPattern(rmadataset, fps); dfps[1:5,]
plotDiscriminantFuzzyPattern(dfps, overlapping)


###################################################
### code chunk number 14: DFP.Rnw:186-187
###################################################
toLatex(sessionInfo())


