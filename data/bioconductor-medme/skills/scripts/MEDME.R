# Code example from 'MEDME' vignette. See references/ for full tutorial.

### R code from vignette source 'MEDME.rnw'

###################################################
### code chunk number 1: MEDMEload
###################################################
library(MEDME)
data(testMEDMEset)


###################################################
### code chunk number 2: MEDMEdata
###################################################
logR(testMEDMEset[1:5,])


###################################################
### code chunk number 3: MEDMEsmooth
###################################################
testMEDMEset = smooth(data = testMEDMEset, wsize = 1000, wFunction = 'linear')


###################################################
### code chunk number 4: MEDMEcpg
###################################################
library(BSgenome.Hsapiens.UCSC.hg18)
testMEDMEset = CGcount(data = testMEDMEset)


###################################################
### code chunk number 5: MEDMEmodel
###################################################
MEDMEmodel = MEDME(data = testMEDMEset, sample = 1)


###################################################
### code chunk number 6: MEDMErun
###################################################
testMEDMEset = MEDME.predict(data = testMEDMEset, MEDMEfit = MEDMEmodel, MEDMEextremes = c(1,32), wsize = 1000, wFunction='linear')


###################################################
### code chunk number 7: MEDMEsee
###################################################
smoothed(testMEDMEset)[1:3,]
AMS(testMEDMEset)[1:3,]
RMS(testMEDMEset)[1:3,]


