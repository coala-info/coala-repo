# Code example from 'MeasurementError.cor' vignette. See references/ for full tutorial.

### R code from vignette source 'MeasurementError.cor.Rnw'

###################################################
### code chunk number 1: MeasurementError.cor.Rnw:41-47
###################################################
library(MeasurementError.cor)
exp <- matrix(abs(rnorm(100,1000,20)),ncol=10)
se <- matrix(abs(rnorm(100,50,5)),ncol=10)
cor.me.vector(exp[1,],se[1,],exp[2,],se[2,])
cor.me.matrix(exp,se)



