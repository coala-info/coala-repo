# Code example from 'SNAGEE' vignette. See references/ for full tutorial.

### R code from vignette source 'SNAGEE.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=60)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 2: SNAGEE.Rnw:92-95
###################################################
library(SNAGEE)
library(ALL)
data(ALL)


###################################################
### code chunk number 3: SNAGEE.Rnw:99-101
###################################################
q = qualStudy(ALL)
print(q)


###################################################
### code chunk number 4: SNAGEE.Rnw:120-122
###################################################
qs = qualSample(ALL, multicore=FALSE)
sum(qs < -5)


###################################################
### code chunk number 5: SNAGEE.Rnw:132-133
###################################################
sessionInfo()


