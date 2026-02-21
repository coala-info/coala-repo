# Code example from 'baySeq' vignette. See references/ for full tutorial.

### R code from vignette source 'baySeq.Rnw'

###################################################
### code chunk number 1: <style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: baySeq.Rnw:34-36
###################################################
set.seed(102)
options(width = 90)


###################################################
### code chunk number 3: baySeq.Rnw:40-41
###################################################
library(baySeq)


###################################################
### code chunk number 4: baySeq.Rnw:45-51
###################################################
if(TRUE) { # set to FALSE if you don't want parallelisation
  library(parallel)  # explicit use, assume installed because in "Imports"
  cl <- makeCluster(4)
} else {
  cl <- NULL
}


###################################################
### code chunk number 5: baySeq.Rnw:56-58
###################################################
data(simData)
simData[1:10,]


###################################################
### code chunk number 6: baySeq.Rnw:62-64
###################################################
  replicates <- c("simA", "simA", "simA", "simA", "simA",
                  "simB", "simB", "simB", "simB", "simB")


###################################################
### code chunk number 7: baySeq.Rnw:73-75
###################################################
groups <- list(NDE = c(1,1,1,1,1,1,1,1,1,1),
               DE = c(1,1,1,1,1,2,2,2,2,2))


###################################################
### code chunk number 8: baySeq.Rnw:86-87
###################################################
CD <- new("countData", data = simData, replicates = replicates, groups = groups)


###################################################
### code chunk number 9: baySeq.Rnw:92-94
###################################################
libsizes(CD) <- getLibsizes(CD)
libsizes(CD)


###################################################
### code chunk number 10: plotMA
###################################################
plotMA.CD(CD, samplesA = "simA", samplesB = "simB",
          col = c(rep("red", 100), rep("black", 900)))


###################################################
### code chunk number 11: figPlotMA
###################################################
plotMA.CD(CD, samplesA = "simA", samplesB = "simB",
          col = c(rep("red", 100), rep("black", 900)))


###################################################
### code chunk number 12: baySeq.Rnw:117-118
###################################################
CD@annotation <- data.frame(name = paste("count", 1:1000, sep = "_"))


###################################################
### code chunk number 13: baySeq.Rnw:125-126
###################################################
CD <- getPriors.NB(CD, samplesize = 1000, estimation = "QL", cl = cl)


###################################################
### code chunk number 14: baySeq.Rnw:131-133
###################################################
CD@groups
sapply(names(CD@groups), function(group) lapply(CD@priors$priors[[group]], head, 5))


###################################################
### code chunk number 15: baySeq.Rnw:138-142
###################################################
CD <- getLikelihoods(CD, cl = cl, bootStraps = 3, verbose = FALSE)
CD@estProps
CD@posteriors[1:10,]
CD@posteriors[101:110,]


###################################################
### code chunk number 16: baySeq.Rnw:146-147
###################################################
CD@estProps[2]


###################################################
### code chunk number 17: baySeq.Rnw:154-155
###################################################
topCounts(CD, group = "DE")  


###################################################
### code chunk number 18: plotPosteriors
###################################################
plotPosteriors(CD, group = "DE", col = c(rep("red", 100), rep("black", 900)))


###################################################
### code chunk number 19: figPlotPosteriors
###################################################
plotPosteriors(CD, group = "DE", col = c(rep("red", 100), rep("black", 900)))


###################################################
### code chunk number 20: baySeq.Rnw:186-188
###################################################
data(mobData)
data(mobAnnotation)


###################################################
### code chunk number 21: baySeq.Rnw:201-203
###################################################
seglens <- mobAnnotation$end - mobAnnotation$start + 1
cD <- new("countData", data = mobData, seglens = seglens, annotation = mobAnnotation)


###################################################
### code chunk number 22: baySeq.Rnw:207-208
###################################################
libsizes(cD) <- getLibsizes(cD, estimationType = "quantile")


###################################################
### code chunk number 23: baySeq.Rnw:216-217
###################################################
cDPair <- cD[,1:4]


###################################################
### code chunk number 24: baySeq.Rnw:221-222
###################################################
replicates(cDPair) <- as.factor(c("D3/D3", "D3/D3", "WT/D3", "WT/D3"))


###################################################
### code chunk number 25: baySeq.Rnw:228-229
###################################################
NDE <- c(1,1,1,1)


###################################################
### code chunk number 26: baySeq.Rnw:234-235
###################################################
mobile <- c("non-mobile","non-mobile","mobile","mobile")


###################################################
### code chunk number 27: baySeq.Rnw:240-241
###################################################
groups(cDPair) <- list(NDE = NDE, mobile = mobile)


###################################################
### code chunk number 28: baySeq.Rnw:246-247
###################################################
cDPair <- getPriors.NB(cDPair, samplesize = 1e4, cl = cl)


###################################################
### code chunk number 29: plotPriors
###################################################
plotNullPrior(cDPair)


###################################################
### code chunk number 30: figPlotPriors
###################################################
plotNullPrior(cDPair)


###################################################
### code chunk number 31: baySeq.Rnw:276-277
###################################################
cDPair <- getLikelihoods(cDPair, nullData = TRUE, cl = cl)


###################################################
### code chunk number 32: baySeq.Rnw:283-284
###################################################
cDPair


###################################################
### code chunk number 33: baySeq.Rnw:289-290
###################################################
summarisePosteriors(cD)


###################################################
### code chunk number 34: baySeq.Rnw:297-298
###################################################
topCounts(cDPair, group = 2, normaliseData = TRUE)


###################################################
### code chunk number 35: baySeq.Rnw:303-304
###################################################
topCounts(cDPair, group = NULL, number = 500)


###################################################
### code chunk number 36: plotPairPosteriors
###################################################
plotPosteriors(cDPair, group = 2, samplesA = 1:2, samplesB = 3:4)


###################################################
### code chunk number 37: figPlotPairPosteriors
###################################################
plotPosteriors(cDPair, group = 2, samplesA = 1:2, samplesB = 3:4)


###################################################
### code chunk number 38: plotMAPost
###################################################
plotMA.CD(cDPair, samplesA = c(1,2), samplesB = c(3,4),
          col = rgb(red = exp(cDPair@posteriors[,2]), green = 0, blue = 0))


###################################################
### code chunk number 39: figPlotMAPost
###################################################
plotMA.CD(cDPair, samplesA = c(1,2), samplesB = c(3,4),
          col = rgb(red = exp(cDPair@posteriors[,2]), green = 0, blue = 0))


###################################################
### code chunk number 40: baySeq.Rnw:345-346
###################################################
cD@replicates <- as.factor(c("D3/D3", "D3/D3", "WT/D3", "WT/D3", "WT/WT", "WT/WT"))


###################################################
### code chunk number 41: baySeq.Rnw:352-353
###################################################
NDE <- factor(c(1,1,1,1,1,1))


###################################################
### code chunk number 42: baySeq.Rnw:358-359
###################################################
d3dep <- c("wtRoot","wtRoot","wtRoot","wtRoot","dicerRoot","dicerRoot")


###################################################
### code chunk number 43: baySeq.Rnw:364-365
###################################################
mobile <- c("dicerShoot","dicerShoot","wtShoot","wtShoot","wtShoot","wtShoot")


###################################################
### code chunk number 44: baySeq.Rnw:370-371
###################################################
groups(cD) <- list(NDE = NDE, d3dep = d3dep, mobile = mobile)  


###################################################
### code chunk number 45: baySeq.Rnw:378-380
###################################################
cD <- getPriors.NB(cD, cl = cl)
cD <- getLikelihoods(cD, nullData = TRUE, cl = cl)


###################################################
### code chunk number 46: baySeq.Rnw:384-385
###################################################
topCounts(cD, group = "mobile", normaliseData = TRUE)  


###################################################
### code chunk number 47: baySeq.Rnw:389-390
###################################################
topCounts(cD, group = "d3dep", normaliseData = TRUE)  


###################################################
### code chunk number 48: baySeq.Rnw:397-398
###################################################
if(!is.null(cl)) stopCluster(cl)


###################################################
### code chunk number 49: baySeq.Rnw:404-405
###################################################
sessionInfo()


