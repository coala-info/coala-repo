# Code example from 'RLMM' vignette. See references/ for full tutorial.

### R code from vignette source 'RLMM.Rnw'

###################################################
### code chunk number 1: RLMM.Rnw:101-102
###################################################
library(RLMM)


###################################################
### code chunk number 2: RLMM.Rnw:240-242
###################################################
x<-read.table("Xba.rlmm")
x[1:2,1:5]


###################################################
### code chunk number 3: RLMM.Rnw:267-268
###################################################
plot_theta(genotypefile="Xba.rlmm",thetafile="Xba.theta",plotfile="",snpsfile="snps.lst")


