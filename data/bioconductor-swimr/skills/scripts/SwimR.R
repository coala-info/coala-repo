# Code example from 'SwimR' vignette. See references/ for full tutorial.

### R code from vignette source 'SwimR.Rnw'

###################################################
### code chunk number 1: Example
###################################################
library("SwimR")
inputPath <- system.file("extdata", "trackerFiles", package="SwimR")
outputPath <- getwd()
freMat <- createFrequencyMatrix(inputPath, outputPath, method = "Extrema", Threshold = 0.6, 
DeltaPeakDt = 1.6, MinFrameBtwnMax = 4, MinDelta = 2.5, longPeriod = 5, AvWindowSize = 10, 
fps = 15, ZP_Length = 100, WindowSize = 30, MaxCompWin = 2, minTime = 0, maxTime = 600)


###################################################
### code chunk number 2: Example
###################################################
expfile <- system.file("extdata", "SwimExample", "SwimR_Matrix.txt", package="SwimR")
annfile <- system.file("extdata", "SwimExample", "SwimR_anno.txt", package="SwimR")
projectname <- "SwimR"
outputPath <- getwd()
result <- SwimR(expfile, annfile, projectname, outputPath, color = "red/green", 
data.collection.interval = 0.067, window.size = 150, mads = 4.4478, 
quantile = 0.95, interval = 20, degree = 0.2, paralysis.interval = 20, 
paralysis.degree = 0.2, rev.degree = 0.5)


