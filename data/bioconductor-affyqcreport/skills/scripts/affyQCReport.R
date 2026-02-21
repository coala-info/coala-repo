# Code example from 'affyQCReport' vignette. See references/ for full tutorial.

### R code from vignette source 'affyQCReport.Rnw'

###################################################
### code chunk number 1: affyQCReport.Rnw:44-45
###################################################
library(affyQCReport)


###################################################
### code chunk number 2: affyQCReport.Rnw:51-53
###################################################
library(affydata)
data(Dilution)


###################################################
### code chunk number 3: affyQCReport.Rnw:96-98
###################################################
plot.new()
titlePage(Dilution)


###################################################
### code chunk number 4: affyQCReport.Rnw:115-117
###################################################
#plot.new()
signalDist(Dilution)


###################################################
### code chunk number 5: affyQCReport.Rnw:173-175
###################################################
#plot.new()
borderQC1(Dilution)


###################################################
### code chunk number 6: affyQCReport.Rnw:199-201
###################################################
#plot.new()
borderQC2(Dilution)


###################################################
### code chunk number 7: affyQCReport.Rnw:219-221
###################################################
#plot.new()
correlationPlot(Dilution)


