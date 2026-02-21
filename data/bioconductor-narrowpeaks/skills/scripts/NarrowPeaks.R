# Code example from 'NarrowPeaks' vignette. See references/ for full tutorial.

### R code from vignette source 'NarrowPeaks.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: setup
###################################################
options(width=100)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 3: write score binaries from a WIG file
###################################################
library(NarrowPeaks)
data("NarrowPeaks-dataset")
head(wigfile_test)
writeLines(wigfile_test, con="wigfile.wig")
wigScores <- wig2CSARScore(wigfilename="wigfile.wig", nbchr = 1, chrle=c(30427671))
print(wigScores$infoscores$filenames)


###################################################
### code chunk number 4: extract candidate regions of enrichment in GRanges object
###################################################
library(CSAR)
candidates <- sigWin(experiment=wigScores$infoscores, t=1.0, g=30)
head(candidates)


###################################################
### code chunk number 5: narrow down enriched regions by funtional PCA
###################################################
shortpeaksP0 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,
 rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=0.0, ms=0)
head(shortpeaksP0$broadPeaks)
head(shortpeaksP0$narrowPeaks)
shortpeaksP3 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,
 rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=3.0, ms=0)
head(shortpeaksP3$broadPeaks)
head(shortpeaksP3$narrowPeaks)
shortpeaksP100 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,
 rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=100, ms=0)
head(shortpeaksP100$broadPeaks)
head(shortpeaksP100$narrowPeaks)


###################################################
### code chunk number 6: final number of components and variance
###################################################
print(shortpeaksP0$reqcomp)
print(shortpeaksP0$pvar)


###################################################
### code chunk number 7: merge neighbouring narrow peaks
###################################################
shortpeaksP90 <- narrowpeaks(inputReg=candidates,scoresInfo=wigScores$infoscores, lmin=0, nbf=25,
 rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=90, ms=0)
shortpeaksP90ms20 <- narrowpeaks(inputReg=candidates,scoresInfo=wigScores$infoscores, lmin=0, nbf=25,
 rpenalty=0,nderiv=0, npcomp=2, pv=80, pmaxscor=90, ms=20)


###################################################
### code chunk number 8: create GRangesLists
###################################################
library(GenomicRanges)
exampleMerge <- GRangesList("narrowpeaksP90"=shortpeaksP90$narrowPeaks,
"narrowpeaksP90ms20"=shortpeaksP90ms20$narrowPeaks);
exampleMerge


###################################################
### code chunk number 9: export GRanges to annotation tracks in various formats
###################################################
library(GenomicRanges)
names(elementMetadata(shortpeaksP3$broadPeaks))[3] <- "score"
names(elementMetadata(shortpeaksP3$narrowPeaks))[2] <- "score"
library(rtracklayer)
export.bedGraph(object=candidates, con="CSAR.bed")
export.bedGraph(object=shortpeaksP3$broadPeaks, con="broadPeaks.bed")
export.bedGraph(object=shortpeaksP3$narrowPeaks, con="narrowpeaks.bed")


###################################################
### code chunk number 10: sessionInfo
###################################################
sessionInfo()


