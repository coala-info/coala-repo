# Code example from 'SVM2CRMdata' vignette. See references/ for full tutorial.

### R code from vignette source 'SVM2CRMdata.Rnw'

###################################################
### code chunk number 1: SVM2CRMdata.Rnw:31-36
###################################################
library(SVM2CRMdata)
setwd(system.file("data",package="SVM2CRMdata"))
load("CD4_matrixInputSVMbin100window1000.rda")
#The column contains the signal. The rows contains the genomic coordinate, while the columns the signals of the histone modifications. The number of columns depends on the window size used to smooth the signals of the histone modification.
dim("CD4_matrixInputSVMbin100window1000")


###################################################
### code chunk number 2: SVM2CRMdata.Rnw:42-45
###################################################
setwd(system.file("data",package="SVM2CRMdata"))
load("train_positive.rda")
load("train_negative.rda")


###################################################
### code chunk number 3: SVM2CRMdata.Rnw:66-67
###################################################
sessionInfo()


