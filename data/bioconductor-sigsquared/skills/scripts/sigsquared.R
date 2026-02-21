# Code example from 'sigsquared' vignette. See references/ for full tutorial.

### R code from vignette source 'sigsquared.Rnw'

###################################################
### code chunk number 1: sigsquared.Rnw:51-53
###################################################
library(Biobase)
library(survival)


###################################################
### code chunk number 2: sigsquared.Rnw:57-59
###################################################
library(sigsquared)
data(BrCa443)


###################################################
### code chunk number 3: sigsquared.Rnw:73-76
###################################################
gs <- new("geneSignature")
genes <- c("RKIP", "HMGA2", "SPP1", "CXCR4", "MMP1", "MetaLET7", "MetaBACH1")
gs <- setGeneSignature(gs, direct=c(-1, 1, 1, 1, 1, 1, 1), genes=genes)


###################################################
### code chunk number 4: sigsquared.Rnw:85-86
###################################################
gs <- analysisPipeline(dataSet=BrCa443, geneSig=gs, iterPerK=50, k=2, rand=FALSE)


###################################################
### code chunk number 5: sigsquared.Rnw:95-97
###################################################
s <- ensembleAdjustable(dataSet=BrCa443, geneSig=gs)
plot(survfit(Surv(MFS, met) ~ s, data=pData(BrCa443)))


