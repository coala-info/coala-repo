# Code example from 'roar' vignette. See references/ for full tutorial.

### R code from vignette source 'roar.Rnw'

###################################################
### code chunk number 1: loadLibAndCreateRoarObject
###################################################
library(roar)
library(rtracklayer)
library(RNAseqData.HNRNPC.bam.chr14)
gtf <- system.file("examples", "apa.gtf", package="roar")
# HNRNPC ko data
bamTreatment <- RNAseqData.HNRNPC.bam.chr14_BAMFILES[seq(5,8)]
# control (HeLa wt)
bamControl <- RNAseqData.HNRNPC.bam.chr14_BAMFILES[seq(1,3)]
rds <- RoarDatasetFromFiles(bamTreatment, bamControl, gtf)


###################################################
### code chunk number 2: countReads
###################################################
rds <- countPrePost(rds, FALSE)


###################################################
### code chunk number 3: computeRoars
###################################################
rds <- computeRoars(rds)


###################################################
### code chunk number 4: computePvals
###################################################
rds <- computePvals(rds)


###################################################
### code chunk number 5: getResults
###################################################
results <- totalResults(rds)


###################################################
### code chunk number 6: getFilteredResults
###################################################
results_filtered <- pvalueFilter(rds, fpkmCutoff=-Inf, 
                                 pvalCutoff=0.05)
nrow(results_filtered[results_filtered$nUnderCutoff==12,])


