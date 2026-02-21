# Code example from 'howtoprocess' vignette. See references/ for full tutorial.

### R code from vignette source 'howtoprocess.Rnw'

###################################################
### code chunk number 1: bslnoffSingle
###################################################
library(PROcess)
fdat <- system.file("Test", package="PROcess")
fs <- list.files(fdat, pattern="\\.*csv\\.*", full.names=TRUE)
f1 <- read.files(fs[1])
fcut <- f1[f1[,1]>0,]
bseoff <-bslnoff(fcut,method="loess",plot=TRUE, bw=0.1)
title(basename(fs[1]))


###################################################
### code chunk number 2: isPeakSingle
###################################################
pkgobj <- isPeak(bseoff,span=81,sm.span=11,plot=TRUE)


###################################################
### code chunk number 3: specZoom
###################################################
specZoom(pkgobj, xlim=c(5000,10000))


###################################################
### code chunk number 4: rmBaselineBatch
###################################################
testdir <- system.file("Test", package = "PROcess")
testM <- rmBaseline(testdir)


###################################################
### code chunk number 5: renorm
###################################################
rtM <- renorm(testM, cutoff=1500)


###################################################
### code chunk number 6: getPeaksBatch
###################################################
peakfile <- paste(tempdir(), "testpeakinfo.csv", sep = "/")
getPeaks(rtM, peakfile)


###################################################
### code chunk number 7: QC
###################################################
qualRes <- quality(testM, peakfile, cutoff=1500)
print(qualRes)


###################################################
### code chunk number 8: pk2bmkr
###################################################
bmkfile <- paste(tempdir(), "testbiomarker.csv", sep = "/")
testBio <- pk2bmkr(peakfile, rtM, bmkfile)
mzs <- as.numeric(rownames(rtM))
matplot(mzs, rtM, type = "l", xlim = c(1000, 10000),
ylab="intensities", main="proto-biomarkers")
bks <- getMzs(testBio)
print(round(bks))
abline(v = bks, col = "green")


###################################################
### code chunk number 9: overallMean
###################################################
grandAve <- aveSpec(fs)
mzs <- grandAve[,1]


###################################################
### code chunk number 10: bslnoffRawMean
###################################################
grandOff <- bslnoff(grandAve[mzs>0,], method="loess",
        plot=T, bw=0.1)


###################################################
### code chunk number 11: RawMeanPeak
###################################################
grandPkg <- isPeak(grandOff[grandOff[,1]>1500,], zerothrsh=1,
plot=T, ratio=0.1)
grandpvec <- round(grandPkg[grandPkg$peak, "mz"])
print(as.vector(grandpvec))


###################################################
### code chunk number 12: getPeaks2
###################################################
grandBmk <- getPeaks2(rtM, grandpvec)


