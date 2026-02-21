# Code example from 'package_vignettes' vignette. See references/ for full tutorial.

### R code from vignette source 'package_vignettes.Snw'

###################################################
### code chunk number 1: package_vignettes.Snw:29-35
###################################################
dirPath = system.file("extdata", package="HiCDataLymphoblast")
fileName1 = list.files(dirPath, full.names=TRUE)[1]
fileName2 = list.files(dirPath, full.names=TRUE)[2]
library(ShortRead)
alignedReads <- readAligned(fileName1, type="Bowtie")
alignedReads <- readAligned(fileName2, type="Bowtie")


