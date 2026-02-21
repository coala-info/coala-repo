# Code example from 'savR' vignette. See references/ for full tutorial.

### R code from vignette source 'savR.Rnw'

###################################################
### code chunk number 1: prepare
###################################################
library(savR)


###################################################
### code chunk number 2: intro
###################################################
fc <- savR(system.file("extdata", "MiSeq", package="savR"))


###################################################
### code chunk number 3: show
###################################################
fc


###################################################
### code chunk number 4: doPfPlot (eval = FALSE)
###################################################
## pfBoxplot(fc)


###################################################
### code chunk number 5: pfPlot
###################################################
png(filename="pf.png", width=400, height=300, res=72)
pfBoxplot(fc)
invisible(dev.off())


###################################################
### code chunk number 6: intro2 (eval = FALSE)
###################################################
## fc <- savR(system.file("extdata", "MiSeq", package="savR"))


###################################################
### code chunk number 7: ri
###################################################
directions(fc)
reads(fc)
cycles(fc)
flowcellLayout(fc)


###################################################
### code chunk number 8: ciex
###################################################
head(correctedIntensities(fc), n=1)


###################################################
### code chunk number 9: doCiPlot (eval = FALSE)
###################################################
## plotIntensity(fc)


###################################################
### code chunk number 10: ciPlot
###################################################
png(filename="ci.png", width=250, height=400, res=72)
plotIntensity(fc)
invisible(dev.off())


###################################################
### code chunk number 11: qmex
###################################################
head(qualityMetrics(fc), n=1)


###################################################
### code chunk number 12: doQhPlot (eval = FALSE)
###################################################
## qualityHeatmap(fc,1,1)


###################################################
### code chunk number 13: qhPlot
###################################################
png(filename="qh.png", width=400, height=300, res=72)
qualityHeatmap(fc,1,1)
invisible(dev.off())


###################################################
### code chunk number 14: tmex
###################################################
head(tileMetrics(fc), n=4)


###################################################
### code chunk number 15: example2
###################################################
head(extractionMetrics(fc), n=1)


