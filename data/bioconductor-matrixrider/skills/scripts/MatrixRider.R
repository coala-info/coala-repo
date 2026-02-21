# Code example from 'MatrixRider' vignette. See references/ for full tutorial.

### R code from vignette source 'MatrixRider.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: ObtainSinglePFMGetSeqOccupancy
###################################################
library(MatrixRider)
library(JASPAR2014)
library(TFBSTools)
library(Biostrings)
pfm <- getMatrixByID(JASPAR2014,"MA0004.1")
## The following sequence has a single perfect match 
## thus it gives the same results with all cutoff values.
sequence <- DNAString("CACGTG")
getSeqOccupancy(sequence, pfm, 0.1)
getSeqOccupancy(sequence, pfm, 1)


###################################################
### code chunk number 3: ObtainMultiplePFMGetSeqOccupancy
###################################################
pfm2 <- getMatrixByID(JASPAR2014,"MA0005.1")
pfms <- PFMatrixList(pfm, pfm2)
names(pfms) <- c(name(pfm), name(pfm2))
## This calculates total affinity for both the PFMatrixes.
getSeqOccupancy(sequence, pfms, 0)


