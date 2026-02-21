# Code example from 'rqubic' vignette. See references/ for full tutorial.

### R code from vignette source 'rqubic.Rnw'

###################################################
### code chunk number 1: helpParser (eval = FALSE)
###################################################
## library(rqubic)
## library(Biobase)
## library(biclust)
## help("parseQubicRules")
## example(parseQubicRules)


###################################################
### code chunk number 2: buildExpres
###################################################
library(rqubic)
library(Biobase)
library(biclust)
data(BicatYeast)
demo.exprs <- new("ExpressionSet", exprs=BicatYeast)

## processing the condition information
demo.cond.split <- strsplit(sub("\\.CEL", "", colnames(BicatYeast)), "_")
demo.group <- sapply(demo.cond.split, function(x) paste(x[-length(x)], collapse="_"))
demo.time <- sapply(demo.cond.split, function(x) x[length(x)])

pData(demo.exprs) <- data.frame(group=demo.group,
                                time=demo.time)
sampleNames(demo.exprs) <- paste(demo.group, demo.time)


###################################################
### code chunk number 3: quantile
###################################################
demo.disc <- quantileDiscretize(demo.exprs)


###################################################
### code chunk number 4: seed
###################################################
demo.seed <- generateSeeds(demo.disc)


###################################################
### code chunk number 5: biclust
###################################################
demo.bic <- quBicluster(demo.seed, demo.disc)
demo.bic


###################################################
### code chunk number 6: help (eval = FALSE)
###################################################
## help("features", package="rqubic")


###################################################
### code chunk number 7: biclustVis
###################################################
parallelCoordinates(BicatYeast, demo.bic, number=3, plotBoth=FALSE, 
                    compare=TRUE, col="#004495", pch=1)                       


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


