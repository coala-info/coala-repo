# Code example from 'BasicSTARRseq' vignette. See references/ for full tutorial.

### R code from vignette source 'BasicSTARRseq.rnw'

###################################################
### code chunk number 1: BasicSTARRseq.rnw:18-19
###################################################
library(BasicSTARRseq)


###################################################
### code chunk number 2: BasicSTARRseq.rnw:39-45
###################################################
starrseqFileName <- system.file("extdata", "smallSTARR.bam",
                                package="BasicSTARRseq")
inputFileName <- system.file("extdata", "smallInput.bam",
                             package="BasicSTARRseq")
STARRseqData(sample=starrseqFileName, control=inputFileName,
             pairedEnd=TRUE)


###################################################
### code chunk number 3: BasicSTARRseq.rnw:48-50
###################################################
STARRseqData(sample=starrseqFileName, control=inputFileName,
             pairedEnd=FALSE)


###################################################
### code chunk number 4: BasicSTARRseq.rnw:53-57
###################################################
starrseqGRanges <- granges(readGAlignmentPairs(starrseqFileName))
inputGRanges <- granges(readGAlignmentPairs(inputFileName))
data <- STARRseqData(sample=starrseqGRanges, control=inputGRanges)
data


###################################################
### code chunk number 5: BasicSTARRseq.rnw:62-64
###################################################
peaks <- getPeaks(data)
peaks


###################################################
### code chunk number 6: BasicSTARRseq.rnw:105-106
###################################################
sessionInfo()


