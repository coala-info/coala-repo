# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:37-40
###################################################
options(width=60)
options(continue=" ")
set.seed(1234)


###################################################
### code chunk number 2: preliminaries
###################################################
library(RDRToolbox)


###################################################
### code chunk number 3: vignette.Rnw:68-69 (eval = FALSE)
###################################################
## swissData=SwissRoll(N = 1000, Plot=TRUE)


###################################################
### code chunk number 4: vignette.Rnw:88-91
###################################################
sim = generateData(samples=20, genes=1000, diffgenes=100, diffsamples=10)
simData = sim[[1]]
simLabels = sim[[2]]


###################################################
### code chunk number 5: vignette.Rnw:94-97
###################################################
sim = generateData(samples=20, genes=1000, diffgenes=100, cov1=0.2, cov2=0, blocksize=10)
simData = sim[[1]]
simLabels = sim[[2]]


###################################################
### code chunk number 6: vignette.Rnw:110-114
###################################################
simData_dim3_lle = LLE(data=simData, dim=3, k=10)
head(simData_dim3_lle)
simData_dim2_lle = LLE(data=simData, dim=2, k=5)
head(simData_dim2_lle)


###################################################
### code chunk number 7: vignette.Rnw:122-124
###################################################
simData_dim2_IM = Isomap(data=simData, dims=2, k=10)
head(simData_dim2_IM$dim2)


###################################################
### code chunk number 8: vignette.Rnw:128-129
###################################################
simData_dim1to10_IM = Isomap(data=simData, dims=1:10, k=10, plotResiduals=TRUE) 


###################################################
### code chunk number 9: vignette.Rnw:133-134 (eval = FALSE)
###################################################
## Isomap(data=simData, dims=2, mod=TRUE, k=10)


###################################################
### code chunk number 10: vignette.Rnw:145-146
###################################################
plotDR(data=simData_dim2_lle, labels=simLabels)


###################################################
### code chunk number 11: vignette.Rnw:151-154
###################################################
samples = c(rep("class 1", 10), rep("class 2", 10)) #letters[1:20]
labels = c("first component", "second component")
plotDR(data=simData_dim2_lle, labels=simLabels, axesLabels=labels, text=samples)


###################################################
### code chunk number 12: vignette.Rnw:158-159 (eval = FALSE)
###################################################
## plotDR(data=simData_dim3_lle, labels=simLabels)


###################################################
### code chunk number 13: vignette.Rnw:174-176
###################################################
d = generateData(samples=20, genes=50, diffgenes=10, blocksize=5)
DBIndex(data=d[[1]], labels=d[[2]])


###################################################
### code chunk number 14: vignette.Rnw:179-180
###################################################
DBIndex(data=simData_dim2_lle, labels=simLabels)


###################################################
### code chunk number 15: vignette.Rnw:189-191
###################################################
library(golubEsets)
data(Golub_Merge)


###################################################
### code chunk number 16: vignette.Rnw:195-199
###################################################
golubExprs = t(exprs(Golub_Merge))
labels = pData(Golub_Merge)$ALL.AML
dim(golubExprs)
show(labels)


###################################################
### code chunk number 17: vignette.Rnw:203-204
###################################################
Isomap(data=golubExprs, dims=1:10, plotResiduals=TRUE, k=5)


###################################################
### code chunk number 18: vignette.Rnw:209-211
###################################################
golubIsomap = Isomap(data=golubExprs, dims=2, k=5)
golubLLE = LLE(data=golubExprs, dim=2, k=5)


###################################################
### code chunk number 19: vignette.Rnw:214-216
###################################################
DBIndex(data=golubIsomap$dim2, labels=labels)
DBIndex(data=golubLLE, labels=labels)


###################################################
### code chunk number 20: plotGolubIsomap
###################################################
plotDR(data=golubIsomap$dim2, labels=labels, axesLabels=c("", ""), legend=TRUE)
title(main="Isomap")


###################################################
### code chunk number 21: plotGolubLLE
###################################################
plotDR(data=golubLLE, labels=labels, axesLabels=c("", ""), legend=TRUE)
title(main="LLE")


