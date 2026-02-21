# Code example from 'nnNorm' vignette. See references/ for full tutorial.

### R code from vignette source 'nnNorm.Rnw'

###################################################
### code chunk number 1: nnNorm.Rnw:48-50
###################################################
library(marray)
data(swirl)


###################################################
### code chunk number 2: nnNorm.Rnw:56-58
###################################################
library(nnNorm)
swirl_n<-maNormNN(swirl[,1:2])


