# Code example from 'sampleClassifierData' vignette. See references/ for full tutorial.

### R code from vignette source 'sampleClassifierData.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: sampleClassifierData.Rnw:37-38
###################################################
library(sampleClassifierData)


###################################################
### code chunk number 3: sampleClassifierData.Rnw:46-49
###################################################
data("se_rnaseq_refmat")
rnaseq_refmat <- assay(se_rnaseq_refmat)
dim(rnaseq_refmat)


###################################################
### code chunk number 4: sampleClassifierData.Rnw:54-57
###################################################
data("se_micro_refmat")
micro_refmat <- assay(se_micro_refmat)
dim(micro_refmat)


###################################################
### code chunk number 5: sampleClassifierData.Rnw:62-65
###################################################
data("se_rnaseq_testmat")
rnaseq_testmat <- assay(se_rnaseq_testmat)
dim(rnaseq_testmat)


###################################################
### code chunk number 6: sampleClassifierData.Rnw:71-74
###################################################
data("se_micro_testmat")
micro_testmat <- assay(se_micro_testmat)
dim(micro_refmat)


