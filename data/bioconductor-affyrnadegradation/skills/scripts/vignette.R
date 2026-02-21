# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:45-49
###################################################
library(AffyRNADegradation)
library(AmpAffyExample)
data(AmpData)
AmpData


###################################################
### code chunk number 2: plotTongs
###################################################
tongs <- GetTongs(AmpData, chip.idx = 4) 
PlotTongs(tongs)


###################################################
### code chunk number 3: plotTongs
###################################################
tongs <- GetTongs(AmpData, chip.idx = 4) 
PlotTongs(tongs)


###################################################
### code chunk number 4: correctAffy
###################################################
rna.deg <- RNADegradation(AmpData, location.type = "index")


###################################################
### code chunk number 5: plotDx
###################################################
plotDx(rna.deg)


###################################################
### code chunk number 6: fig1
###################################################
plotDx(rna.deg)


###################################################
### code chunk number 7: RnaIntegrityD
###################################################
d(rna.deg)


###################################################
### code chunk number 8: saveProbeLocations (eval = FALSE)
###################################################
## filename = paste(cdfName(AmpData), ".Rd", sep="")
## save(probeDists, file = filename)


###################################################
### code chunk number 9: correctAffy
###################################################
afbatch(rna.deg)


###################################################
### code chunk number 10: vsnCorrect (eval = FALSE)
###################################################
## library(vsn)
## affydata.vsn <- do.call(affy:::normalize, c(alist(AmpData, "vsn"), NULL))
## affydata.vsn <- afbatch(RNADegradation(affydata.vsn))
## expr <- computeExprSet(affydata.vsn, summary.method="medianpolish", pmcorrect.method="pmonly")


###################################################
### code chunk number 11: details
###################################################
sessionInfo()


