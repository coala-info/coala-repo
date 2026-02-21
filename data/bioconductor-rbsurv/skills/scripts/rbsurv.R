# Code example from 'rbsurv' vignette. See references/ for full tutorial.

### R code from vignette source 'rbsurv.Rnw'

###################################################
### code chunk number 1: rbsurv.Rnw:179-188
###################################################
library(rbsurv)
data(gliomaSet)
gliomaSet
x <- exprs(gliomaSet)
x <- log2(x)
time <- gliomaSet$Time
status <- gliomaSet$Status
z <- cbind(gliomaSet$Age, gliomaSet$Gender)



###################################################
### code chunk number 2: rbsurv.Rnw:195-196
###################################################
fit <-  rbsurv(time=time, status=status, x=x, method="efron", max.n.genes=20)


###################################################
### code chunk number 3: rbsurv.Rnw:208-209
###################################################
fit$model


