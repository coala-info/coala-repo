# Code example from 'yaqcaffy' vignette. See references/ for full tutorial.

### R code from vignette source 'yaqcaffy.Rnw'

###################################################
### code chunk number 1: data
###################################################
library("yaqcaffy")
library("affydata")
data(Dilution)
## probe intensities modification
tmp <- exprs(Dilution)
tmp[,1] <- tmp[,1]*2
exprs(Dilution) <- tmp


###################################################
### code chunk number 2: yaqc
###################################################
yqc <- yaqc(Dilution, verbose=TRUE)
show(yqc)


###################################################
### code chunk number 3: objectversion
###################################################
objectVersion(yqc)


###################################################
### code chunk number 4: plotqual
###################################################
plot(yqc)


###################################################
### code chunk number 5: outlier
###################################################
getOutliers(yqc,"sfs")


###################################################
### code chunk number 6: merge
###################################################
yqc2 <- yaqc(Dilution[, 2:3])
arrays(yqc) 
arrays(yqc2)
yqc3 <- merge(yqc, yqc2)
arrays(yqc3)


###################################################
### code chunk number 7: myyaqccontolprobes (eval = FALSE)
###################################################
## yqc <- yaqc(myAffyData, myYaqcControlProbes = yaqcControlProbes)


###################################################
### code chunk number 8: maqcsubsetafx
###################################################
library(MAQCsubsetAFX)
data(refB)
d <- refB[,1]
sampleNames(d)


###################################################
### code chunk number 9: reprodplot (eval = FALSE)
###################################################
## reprodPlot(d, "refA", normalize="rma")


###################################################
### code chunk number 10: reprodplorFig
###################################################
reprodPlot(d, "test", normalize="none")


###################################################
### code chunk number 11: sessioninfo
###################################################
toLatex(sessionInfo())


