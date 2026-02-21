# Code example from 'SimBindProfiles' vignette. See references/ for full tutorial.

### R code from vignette source 'SimBindProfiles.Rnw'

###################################################
### code chunk number 1: loadpackage
###################################################
library("SimBindProfiles")


###################################################
### code chunk number 2: exampleData
###################################################
dataPath <- system.file("extdata",package="SimBindProfiles")
list.files(dataPath, pattern=".txt")
head(read.delim(paste(dataPath, "SoxNDam_trunc.txt", sep="/"), 
	header=FALSE, nrows=5))


###################################################
### code chunk number 3: readTestData
###################################################
readTestSGR <- readSgrFiles(X=c("SoxNDam_trunc", "SoxN-DDam_trunc", 
	"DDam_trunc"), dataPath)


###################################################
### code chunk number 4: loadData
###################################################
dataPath <- system.file("data",package="SimBindProfiles")
load(paste(dataPath, "SGR.RData", sep="/"))
print(SGR)


###################################################
### code chunk number 5: scatter0 (eval = FALSE)
###################################################
## eSetScatterPlot(SGR)


###################################################
### code chunk number 6: scatter
###################################################
png("SimBindProfiles-scatter.png")
eSetScatterPlot(SGR)
dev.off()


###################################################
### code chunk number 7: boundCutoff (eval = FALSE)
###################################################
## bound.cutoff <- findBoundCutoff(SGR, method="twoGaussiansNull", fdr=0.25)


###################################################
### code chunk number 8: boundCutoffprecomputed
###################################################
dataPath <- system.file("data",package="SimBindProfiles")
load(paste(dataPath, "precomputed.RData", sep="/"))
cat("Using bound.cutoff =", bound.cutoff, "\n")


###################################################
### code chunk number 9: boundHistogram0 (eval = FALSE)
###################################################
## hist(exprs(SGR)[,1], breaks=1000, freq=FALSE, border="grey", 
## 	main=sampleNames(SGR)[1], xlab="signal", 
## 	sub=paste("bound.cutoff =", bound.cutoff, sep=" "))
## abline(v=bound.cutoff, col="red", lty=3, lwd=2)


###################################################
### code chunk number 10: boundHistogram
###################################################
png("SimBindProfiles-boundHist.png")
hist(exprs(SGR)[,1], breaks=1000, freq=FALSE, border="grey", 
	main=sampleNames(SGR)[1], xlab="signal", 
	sub=paste("bound.cutoff =", bound.cutoff, sep=" "))
abline(v=bound.cutoff, col="red", lty=3, lwd=2)
dev.off()


###################################################
### code chunk number 11: diffCutoff
###################################################
diff.cutoff <- round(bound.cutoff * 0.75,2)


###################################################
### code chunk number 12: createProbeAnno
###################################################
probeAnno <- probeAnnoFromESet(SGR, probeLength=50)


###################################################
### code chunk number 13: visualiseBound (eval = FALSE)
###################################################
## plot(SGR, probeAnno, chrom="X", xlim=c(2323000,2337000), ylim=c(-3,4), 
## 	samples=c(1,2))


###################################################
### code chunk number 14: visualiseBound
###################################################
plot(SGR, probeAnno, chrom="X", xlim=c(2323000,2337000), ylim=c(-3,4), samples=c(1,2), 
	icex=1, sampleLegend=FALSE)


###################################################
### code chunk number 15: setArraySpecPara
###################################################
probes <- 10
probe.max.spacing <- 200


###################################################
### code chunk number 16: probeLengthPlot (eval = FALSE)
###################################################
## probeLengthPlot(SGR, sgrset=1, chr=NULL, bound.cutoff, probe.max.spacing=200, 
## 	xlim.max=25)


###################################################
### code chunk number 17: probeLengthPlot
###################################################
probeLengthPlot(SGR, sgrset=1, chr=NULL, bound.cutoff, probe.max.spacing=200, xlim.max=25)


###################################################
### code chunk number 18: pairwiseRegions
###################################################
pairwiseR <- pairwiseRegions(SGR, sgrset=c(1,3), bound.cutoff, 
	diff.cutoff, probes, probe.max.spacing)
head(pairwiseR)


###################################################
### code chunk number 19: pairwiseBoundProbesPlot (eval = FALSE)
###################################################
## plotBoundProbes(SGR, sgrset=c(1,2), method="pairwise", bound.cutoff, 
## 	diff.cutoff)


###################################################
### code chunk number 20: pairwiseBoundProbesPlot
###################################################
png("SimBindProfiles-pairwiseBound.png")
plotBoundProbes(SGR, sgrset=c(1,2), method="pairwise", bound.cutoff, diff.cutoff)
dev.off()


###################################################
### code chunk number 21: threewayRegions (eval = FALSE)
###################################################
## threewayR <- threewayRegions(SGR, sgrset=c(1,2,3), bound.cutoff, 
## 	diff.cutoff, probes, probe.max.spacing)


###################################################
### code chunk number 22: increasedBindingRegions (eval = FALSE)
###################################################
## increasedR <- increasedBindingRegions(SGR, sgrset=c(2,3), bound.cutoff, diff.cutoff, 
## 	probes, probe.max.spacing)
## head(increasedR)


###################################################
### code chunk number 23: increasedBindingRegionsprecomputed
###################################################
head(increasedR)


###################################################
### code chunk number 24: visualiseIncreasedBinding (eval = FALSE)
###################################################
## plot(SGR, probeAnno, chrom="X", xlim=c(4589000,4593200), ylim=c(-0.5,5), 
## 	samples=c(2,3))


###################################################
### code chunk number 25: visualiseIncreasedBinding
###################################################
plot(SGR, probeAnno, chrom="X", xlim=c(4589000,4593200), ylim=c(-0.5,5), samples=c(2,3), 
	icex=1, sampleLegend=FALSE)


###################################################
### code chunk number 26: increasedBindingBoundProbesPlot (eval = FALSE)
###################################################
## plotBoundProbes(SGR, sgrset=c(2,3), method="increasedBinding", bound.cutoff, 
## 	diff.cutoff, pcex=4)


###################################################
### code chunk number 27: increasedBindingBoundProbesPlot
###################################################
png("SimBindProfiles-increasedBindingBound.png")
plotBoundProbes(SGR, sgrset=c(2,3), method="increasedBinding", bound.cutoff, diff.cutoff,
	pcex=4)
dev.off()


###################################################
### code chunk number 28: compensationRegions (eval = FALSE)
###################################################
## compR <- compensationRegions(SGR, sgrset=c(1,2,3), bound.cutoff, 
## 	diff.cutoff, probes, probe.max.spacing)
## head(compR)


###################################################
### code chunk number 29: compensationRegionsprecomputed
###################################################
head(compR)


###################################################
### code chunk number 30: visualiseCompensation (eval = FALSE)
###################################################
## plot(SGR, probeAnno, chrom="X", xlim=c(2943000,2947000), ylim=c(-1,4))


###################################################
### code chunk number 31: visualiseCompensation
###################################################
plot(SGR, probeAnno, chrom="X", xlim=c(2943000,2947000), ylim=c(-1,4),
	icex=1)


###################################################
### code chunk number 32: compensationBoundProbesPlot (eval = FALSE)
###################################################
## plotBoundProbes(SGR, sgrset=c(1,2,3), method="compensation", bound.cutoff, 
## 	diff.cutoff, pcex=4)


###################################################
### code chunk number 33: compensationBoundProbesPlot
###################################################
png("SimBindProfiles-compensationBound.png")
plotBoundProbes(SGR, sgrset=c(1,2,3), method="compensation", bound.cutoff, diff.cutoff,
	pcex=4)
dev.off()


###################################################
### code chunk number 34: sessionInfo
###################################################
toLatex(sessionInfo())


