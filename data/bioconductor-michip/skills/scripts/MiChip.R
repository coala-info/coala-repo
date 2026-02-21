# Code example from 'MiChip' vignette. See references/ for full tutorial.

### R code from vignette source 'MiChip.Rnw'

###################################################
### code chunk number 1: loadLibary
###################################################
library(MiChip)


###################################################
### code chunk number 2: defaultRawData
###################################################
datadir <-system.file("extdata", package="MiChip")
defaultRawData <- parseRawData(datadir)


###################################################
### code chunk number 3: noe
###################################################
 noEmptiesDataSet <- removeUnwantedRows(defaultRawData, c("Empty"))


###################################################
### code chunk number 4: humanDataSet
###################################################
humanDataSet <- standardRemoveRows(defaultRawData)


###################################################
### code chunk number 5: flagCorrectDataSet
###################################################
 flagCorrectedDataSet <- correctForFlags(humanDataSet)


###################################################
### code chunk number 6: flagCorrectedDataSet
###################################################
flagCorrectedDataSet <- correctForFlags(humanDataSet, intensityCutoff = 50)


###################################################
### code chunk number 7: summedData
###################################################
summedData <- summarizeIntensitiesAsMedian(flagCorrectedDataSet,minSumlength = 0, madAdjust=FALSE)


###################################################
### code chunk number 8: plotIntensities
###################################################
plotIntensitiesScatter(exprs(summedData), NULL, "MiChipDemX", "SummarizedScatter")


###################################################
### code chunk number 9: boxplotSummed
###################################################
 boxplotData(exprs(summedData), "MiChipDemX", "Summarized")


###################################################
### code chunk number 10: mednormedData
###################################################
mednormedData <- normalizePerChipMedian(summedData)


###################################################
### code chunk number 11: outputAnnot
###################################################
outputAnnotatedDataMatrix(mednormedData, "MiChipDemo", "medNormedIntensity",  "exprs")


###################################################
### code chunk number 12: myNormedEset
###################################################
datadir <-system.file("extdata", package="MiChip")
 myNormedEset <- workedExampleMedianNormalize("NormedDemo", intensityCutoff = 50,datadir)


