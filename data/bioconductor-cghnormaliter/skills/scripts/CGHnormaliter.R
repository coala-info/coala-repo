# Code example from 'CGHnormaliter' vignette. See references/ for full tutorial.

### R code from vignette source 'CGHnormaliter.Rnw'

###################################################
### code chunk number 1: CGHnormaliterPackage
###################################################
options(keep.source=TRUE)
CGHnormaliterPackage <- packageDescription("CGHnormaliter")


###################################################
### code chunk number 2: loadData
###################################################
library(CGHnormaliter)
data(Leukemia)


###################################################
### code chunk number 3: runCGHnormaliter
###################################################
result <- CGHnormaliter(Leukemia, nchrom=4, cellularity=0.9)


###################################################
### code chunk number 4: accessResults
###################################################
normalized.data <- copynumber(result)  # log2 ratios
segmented.data <- segmented(result)
called.data <- calls(result)


###################################################
### code chunk number 5: densityPlotCommand
###################################################
plot(density(normalized.data[, 2]), col=1, xlab="log2 ratio",
                                    main="Density plot")
abline(v=0, lty=2)



###################################################
### code chunk number 6: densityPlotFigure
###################################################
plot(density(normalized.data[, 2]), col=1, xlab="log2 ratio",
                                    main="Density plot")
abline(v=0, lty=2)



###################################################
### code chunk number 7: callPlotCommand
###################################################
plot(result[,2], ylimit=c(-2,2), dotres=1)


###################################################
### code chunk number 8: callPlotFigure
###################################################
plot(result[,2], ylimit=c(-2,2), dotres=1)


###################################################
### code chunk number 9: saveNormalizedData
###################################################
CGHnormaliter.write.table(result)


###################################################
### code chunk number 10: saveOtherData
###################################################
CGHnormaliter.write.table(result, data.type="segmented")
CGHnormaliter.write.table(result, data.type="called")


