# Code example from 'focalCall' vignette. See references/ for full tutorial.

### R code from vignette source 'focalCall.Rnw'

###################################################
### code chunk number 1: focalCall.Rnw:64-66
###################################################
library(focalCall)
data(BierkensCNA)


###################################################
### code chunk number 2: focalCall.Rnw:79-80
###################################################
calls_focals<-focalCall(CGHset, CNVset, focalSize = 3, minFreq=2)


###################################################
### code chunk number 3: focalCall.Rnw:88-89
###################################################
FreqPlot(calls_focals, header="FrequencyPlot all aberrations")


###################################################
### code chunk number 4: focalCall.Rnw:95-96
###################################################
FreqPlotfocal(calls_focals, header="FrequencyPlot all aberrations")


###################################################
### code chunk number 5: focalCall.Rnw:106-107
###################################################
igvFiles(calls_focals)


###################################################
### code chunk number 6: focalCall.Rnw:122-123
###################################################
sessionInfo()


