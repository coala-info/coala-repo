# Code example from 'FilterFFPE' vignette. See references/ for full tutorial.

### R code from vignette source 'FilterFFPE.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: options
###################################################
options(width=60)


###################################################
### code chunk number 3: findArtifactChimericReads
###################################################
library(FilterFFPE)

# Find artifact chimeric reads
file <- system.file("extdata", "example.bam", package = "FilterFFPE")
outFolder <- tempdir()
FFPEReadsFile <- paste0(outFolder, "/example.FFPEReads.txt")
dupChimFile <- paste0(outFolder, "/example.dupChim.txt")
artifactReads <- findArtifactChimericReads(file = file, threads = 2,
                                           FFPEReadsFile = FFPEReadsFile,
                                           dupChimFile = dupChimFile)
head(artifactReads)



###################################################
### code chunk number 4: filterBamByReadNames
###################################################
# Filter artifact chimeric reads and PCR or optical duplicates of chimeric reads
dupChim <- readLines(dupChimFile)
readsToFilter <- c(artifactReads, dupChim)
destination <- paste0(outFolder, "/example.FilterFFPE.bam")
filterBamByReadNames(file = file, readsToFilter = readsToFilter,
                     destination = destination, overwrite=TRUE)



###################################################
### code chunk number 5: FFPEReadFilter
###################################################
# Perform finding and filtering with one function
file <- system.file("extdata", "example.bam", package = "FilterFFPE")
outFolder <- tempdir()
FFPEReadsFile <- paste0(outFolder, "/example.FFPEReads.txt")
dupChimFile <- paste0(outFolder, "/example.dupChim.txt")
destination <- paste0(outFolder, "/example.FilterFFPE.bam")
FFPEReadFilter(file = file, threads=2, destination = destination,
               overwrite=TRUE, FFPEReadsFile = FFPEReadsFile,
               dupChimFile = dupChimFile)



###################################################
### code chunk number 6: scanBAM
###################################################
# load Bam file with scanBAM
newBam <- Rsamtools::scanBam(destination)
head(newBam[[1]]$seq)


###################################################
### code chunk number 7: sessionInfo
###################################################
packageDescription("FilterFFPE")
sessionInfo()


