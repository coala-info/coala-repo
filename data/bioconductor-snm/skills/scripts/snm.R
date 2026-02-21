# Code example from 'snm' vignette. See references/ for full tutorial.

### R code from vignette source 'snm.Rnw'

###################################################
### code chunk number 1: load.library
###################################################
library(snm)


###################################################
### code chunk number 2: load.simulated.example.1
###################################################
singleChannel <- sim.singleChannel(12345)
str(singleChannel)


###################################################
### code chunk number 3: normalize.simulated.example.1
###################################################
snm.obj1 <- snm(singleChannel$raw.data,
				singleChannel$bio.var,
				singleChannel$adj.var,
			        singleChannel$int.var)


###################################################
### code chunk number 4: check.pvalues.1
###################################################
ks.test(snm.obj1$pval[singleChannel$true.nulls],"punif")


