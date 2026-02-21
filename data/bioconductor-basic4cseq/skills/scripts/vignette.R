# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:36-38
###################################################
options(width=90)
options(continue=" ")


###################################################
### code chunk number 2: preliminaries
###################################################
library(Basic4Cseq)


###################################################
### code chunk number 3: createVirtualFragmentLibrary
###################################################
testGenome = DNAString("ATCATGAAGTACTACATGGCACCATGT")
fragmentData = createVirtualFragmentLibrary(chosenGenome = testGenome, firstCutter = "catg", 
    secondCutter = "gtac", readLength = 2,  chromosomeName = "test", libraryName = "")
head(fragmentData)


###################################################
### code chunk number 4: l2 (eval = FALSE)
###################################################
## library(BSgenome.Mmusculus.UCSC.mm9)
## createVirtualFragmentLibrary(chosenGenome = Mmusculus, firstCutter = "aagctt", secondCutter = 
##     "catg", readLength = 54,  libraryName = "myFullFetalLiverVFL.csv")


###################################################
### code chunk number 5: loadFetalLiverRawData
###################################################
library(GenomicAlignments)
libraryFile <- system.file("extdata", "vfl_aagctt_catg_mm9_54_vp.csv", package="Basic4Cseq")
bamFile <- system.file("extdata", "fetalLiverShort.bam", package="Basic4Cseq")
liverReads <- readGAlignments(bamFile)
liverReads


###################################################
### code chunk number 6: addPointsOfInterest
###################################################
pointsOfInterestFile <- system.file("extdata", "fetalLiverVP.bed", package="Basic4Cseq")
liverPoints<-readPointsOfInterestFile(pointsOfInterestFile)
liverPoints


###################################################
### code chunk number 7: initializeObject
###################################################
liverData = Data4Cseq(viewpointChromosome = "10", viewpointInterval = c(20879870, 20882209), 
    readLength = 54, pointsOfInterest = liverPoints, rawReads = liverReads)
liverData


###################################################
### code chunk number 8: initializeObject
###################################################
rawFragments(liverData)<-readsToFragments(liverData, libraryFile)
liverData


###################################################
### code chunk number 9: initializeObject
###################################################
# pick near-cis fragments
nearCisFragments(liverData)<-chooseNearCisFragments(liverData, 
    regionCoordinates = c(20800000, 21100000))
head(nearCisFragments(liverData))


###################################################
### code chunk number 10: normalizeObject
###################################################
# normalization of near-cis data
library("caTools")
nearCisFragments(liverData)<-normalizeFragmentData(liverData)
head(nearCisFragments(liverData))


###################################################
### code chunk number 11: qualityControl
###################################################
getReadDistribution(liverData, useFragEnds = TRUE, outputName = "")


###################################################
### code chunk number 12: visualizeViewpoint (eval = FALSE)
###################################################
## # This command creates a near-cis plot of the fetal liver's viewpoint data
## visualizeViewpoint(liverData, plotFileName = "", mainColour = "blue", 
##     plotTitle = "Fetal Liver Near-Cis Plot", loessSpan = 0.1, maxY = 6000, 
##     xAxisIntervalLength = 50000, yAxisIntervalLength = 1000)


###################################################
### code chunk number 13: drawHeatmap (eval = FALSE)
###################################################
## # This command creates a near-cis heatmap plot of the fetal liver data
## drawHeatmap(liverData, plotFileName = "", xAxisIntervalLength = 50000, bands = 5)


###################################################
### code chunk number 14: exportWig (eval = FALSE)
###################################################
## printWigFile(liverData, wigFileName = "fetalLiver.wig")


###################################################
### code chunk number 15: transInteractions (eval = FALSE)
###################################################
## library("RCircos")
## transInteractions <- system.file("extdata", "transInteractionData.txt", package="Basic4Cseq")
## ideogramData <- system.file("extdata", "RCircos_GRCm38_ideogram.csv", package="Basic4Cseq")
## plotTransInteractions(transInteractions, "10", c(20000100, 20001000), ideogramData, 
##     PlotColor = "blue", expandBands = TRUE, expansionValue = 1000000, plotFileName = "")


###################################################
### code chunk number 16: checkRestrictionEnzyme (eval = FALSE)
###################################################
## # The demonstration reads are taken from Stadhouders et al's data,
## # but additional cutter sequences have been added manually for demonstration purposes
## fetalLiverCutterFile <- system.file("extdata", "fetalLiverCutter.sam", package="Basic4Cseq")
## checkRestrictionEnzymeSequence("aagctt", fetalLiverCutterFile, "fetalLiverCutter_filtered.sam")


###################################################
### code chunk number 17: extractBED (eval = FALSE)
###################################################
## printBEDFragmentLibrary(libraryFile, "BEDLibrary_FL_vp.bed")


###################################################
### code chunk number 18: giveEnzymeSequence
###################################################
enzymeData <- system.file("extdata", "enzymeData.csv", package="Basic4Cseq")
giveEnzymeSequence(enzymeData, "NlaIII")


###################################################
### code chunk number 19: simulateDigestion
###################################################
shortTestGenome = "ATCCATGTAGGCTAAGTACACATGTTAAGGTACAGTACAATTGCACGATCAT"
fragments = simulateDigestion("catg", "gtac", shortTestGenome)
head(fragments)


###################################################
### code chunk number 20: drawDigestionFragmentHistogram
###################################################
# This command creates a histogram plot of virtual library fragment length and frequencies
drawDigestionFragmentHistogram(fragments)


###################################################
### code chunk number 21: prepare4CseqData (eval = FALSE)
###################################################
## # BWA, samtools and bedtools must be installed
## # It is assumed that the example data files (from the package) are in the active directory
## prepare4CseqData("veryShortExample.fastq", "CATG", "veryShortLib.csv", 
##     referenceGenome = "veryShortReference.fasta")


###################################################
### code chunk number 22: sessionInfo
###################################################
sessionInfo()


