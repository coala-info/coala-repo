# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:38-40
###################################################
options(width=90)
options(continue=" ")


###################################################
### code chunk number 2: preliminaries
###################################################
library(Scale4C)


###################################################
### code chunk number 3: importBasic4CseqData
###################################################
csvFile <- system.file("extdata", "liverData.csv", package="Scale4C")
liverReads <- importBasic4CseqData(csvFile, viewpoint = 21160072, 
    viewpointChromosome = "chr10", distance = 1000000)
head(liverReads)


###################################################
### code chunk number 4: initialiseObject
###################################################
liverData = Scale4C(rawData = liverReads, viewpoint = 21160072, viewpointChromosome = "chr10")
liverData


###################################################
### code chunk number 5: addPointsOfInterest
###################################################
poiFile <- system.file("extdata", "vp.txt", package="Scale4C")
pointsOfInterest(liverData) <- addPointsOfInterest(liverData, 
    read.csv(poiFile, sep = "\t", stringsAsFactor = FALSE))
head(pointsOfInterest(liverData))


###################################################
### code chunk number 6: plotInflectionPoints01
###################################################
plotInflectionPoints(liverData, 2, fileName = "", plotIP = FALSE)


###################################################
### code chunk number 7: plotInflectionPoints02
###################################################
plotInflectionPoints(liverData, 50, fileName = "", plotIP = FALSE)


###################################################
### code chunk number 8: calculateScaleSpace
###################################################
scaleSpace(liverData) = calculateScaleSpace(liverData, maxSQSigma = 10)
head(t(assay(scaleSpace(liverData), 1))[,1:5])


###################################################
### code chunk number 9: calculateFingerprintMap
###################################################
liverData = calculateFingerprintMap(liverData, maxSQSigma = 10)
singularities(liverData) = findSingularities(liverData, 1, guessViewpoint = FALSE)


###################################################
### code chunk number 10: adaptSingularities
###################################################
data(liverData)
tail(singularities(liverData))
# add viewpoint singularity
singularities(liverData) = c(singularities(liverData), GRanges("chr10", IRanges(39, 42),
    "*", "sqsigma" = 2000, "left" = 40, "right" = 41, "type" = "peak"))
# correct singularity's coordinates
tempSingularities = singularities(liverData)
tempSingularities$left[30] = 235
tempSingularities$right[30] = 250
tempSingularities$type[30] = "peak"
singularities(liverData) = tempSingularities
tail(singularities(liverData))


###################################################
### code chunk number 11: plotTesselation
###################################################
# use pre-calculated example data with VP and correction
data(liverDataVP)
plotTesselation(liverDataVP, fileName = "")


###################################################
### code chunk number 12: outputScaleSpaceTree
###################################################
head(outputScaleSpaceTree(liverDataVP, useLog = FALSE))


###################################################
### code chunk number 13: sessionInfo
###################################################
sessionInfo()


