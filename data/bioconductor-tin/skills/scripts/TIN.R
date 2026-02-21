# Code example from 'TIN' vignette. See references/ for full tutorial.

### R code from vignette source 'TIN.Rnw'

###################################################
### code chunk number 1: TIN.Rnw:60-61
###################################################
library(TIN)


###################################################
### code chunk number 2: TIN.Rnw:66-69
###################################################
data(splicingFactors)
data(geneSets)
data(geneAnnotation)


###################################################
### code chunk number 3: TIN.Rnw:82-84
###################################################
data(sampleSetFirmaScores)
data(sampleSetGeneSummaries)


###################################################
### code chunk number 4: TIN.Rnw:92-93
###################################################
fs <- firmaAnalysis(useToyData=TRUE)


###################################################
### code chunk number 5: TIN.Rnw:104-105
###################################################
gs <- readGeneSummaries(useToyData=TRUE)


###################################################
### code chunk number 6: TIN.Rnw:114-115
###################################################
tra <- aberrantExonUsage(1.0, sampleSetFirmaScores)


###################################################
### code chunk number 7: TIN.Rnw:131-132
###################################################
aberrantExonsPerms <- probesetPermutations(sampleSetFirmaScores, quantiles)


###################################################
### code chunk number 8: TIN.Rnw:139-140
###################################################
corr <- correlation(splicingFactors, sampleSetGeneSummaries, tra)


###################################################
### code chunk number 9: TIN.Rnw:145-147
###################################################
gsc <- geneSetCorrelation(geneSets, geneAnnotation, sampleSetGeneSummaries,
    tra, 100)


###################################################
### code chunk number 10: TIN.Rnw:157-159
###################################################
clusterPlot(sampleSetGeneSummaries, tra, "euclidean", "complete",
    "TIN-cluster.pdf")


###################################################
### code chunk number 11: TIN.Rnw:164-165
###################################################
scatterPlot("TIN-scatter.pdf", TRUE, aberrantExons, aberrantExonsPerms)


###################################################
### code chunk number 12: TIN.Rnw:171-173
###################################################
correlationPlot("TIN-correlation.pdf", tra, sampleSetGeneSummaries,
    splicingFactors, 1000, 1000)


###################################################
### code chunk number 13: TIN.Rnw:180-182
###################################################
posNegCorrPlot("TIN-posNegCorrPlot.pdf", tra, sampleSetGeneSummaries, 
    splicingFactors, 1000, 1000)


