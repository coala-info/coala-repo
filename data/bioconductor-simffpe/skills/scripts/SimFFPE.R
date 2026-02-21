# Code example from 'SimFFPE' vignette. See references/ for full tutorial.

### R code from vignette source 'SimFFPE.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: options
###################################################
options(width=60)


###################################################
### code chunk number 3: calcPhredScoreProfile
###################################################
library(SimFFPE)
bamFilePath <- system.file("extdata", "example.bam", package = "SimFFPE")
regionPath <- system.file("extdata", "regionsBam.txt", package = "SimFFPE")
regions <- read.table(regionPath)
PhredScoreProfile <- calcPhredScoreProfile(bamFilePath, targetRegions = regions)

## Example Phred score profile with 100 read length
PhredScoreProfilePath <- system.file("extdata", "PhredScoreProfile1.txt",
                                      package = "SimFFPE")
PhredScoreProfile <- as.matrix(read.table(PhredScoreProfilePath, skip = 1))
colnames(PhredScoreProfile)  <- 
    strsplit(readLines(PhredScoreProfilePath)[1], "\t")[[1]]
#
## Example Phred score profile with 150 read length

PhredScoreProfilePath2 <- system.file("extdata", "PhredScoreProfile2.txt",
                                      package = "SimFFPE")
PhredScoreProfile2 <- as.matrix(read.table(PhredScoreProfilePath2, skip = 1))
colnames(PhredScoreProfile2)  <- 
    strsplit(readLines(PhredScoreProfilePath2)[1], "\t")[[1]]



###################################################
### code chunk number 4: readDNAStringSet
###################################################
referencePath <- system.file("extdata", "example.fasta", package = "SimFFPE")
reference <- readDNAStringSet(referencePath)
reference



###################################################
### code chunk number 5: target region table
###################################################
regionPath <- system.file("extdata", "regionsSim.txt", package = "SimFFPE")
targetRegions <- read.table(regionPath)


###################################################
### code chunk number 6: readSimFFPE
###################################################
## Simulate reads of the first three sequences of the reference genome

sourceSeq <- reference[1:3]
outFile1 <- paste0(tempdir(), "/sim1")
readSimFFPE(sourceSeq, referencePath, PhredScoreProfile2, outFile1,
            overWrite = TRUE, coverage = 80, readLen = 150,
            enzymeCut = TRUE, threads = 2)
#
## Simulate reads of defined regions on the first two sequences of
## the reference genome

sourceSeq2 <- DNAStringSet(lapply(reference[1:2], function(x) x[1:10000]))
outFile2 <- paste0(tempdir(), "/sim2")
readSimFFPE(sourceSeq2, referencePath, PhredScoreProfile2, outFile2,
            overWrite = TRUE, coverage = 80, readLen = 150, enzymeCut = TRUE)



###################################################
### code chunk number 7: targetReadSimFFPE
###################################################

outFile3 <- paste0(tempdir(), "/sim3")
targetReadSimFFPE(referencePath, PhredScoreProfile, targetRegions, outFile3,
                  coverage = 120, readLen = 100, meanInsertLen = 180, 
                  sdInsertLen = 50, enzymeCut = FALSE)



###################################################
### code chunk number 8: sessionInfo
###################################################
packageDescription("SimFFPE")
sessionInfo()


