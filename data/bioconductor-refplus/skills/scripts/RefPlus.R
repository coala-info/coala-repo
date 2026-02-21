# Code example from 'RefPlus' vignette. See references/ for full tutorial.

### R code from vignette source 'RefPlus.Rnw'

###################################################
### code chunk number 1: RefPlus.Rnw:100-105
###################################################
##Use Dilution in affydata package
library(RefPlus)
library(affydata)
data(Dilution)
sampleNames(Dilution)


###################################################
### code chunk number 2: RefPlus.Rnw:109-111
###################################################
##Calculate RMA intensities using the rma function.
Ex0<-exprs(rma(Dilution))


###################################################
### code chunk number 3: RefPlus.Rnw:116-120
###################################################
##Background correct, estimate the probe effects, and calculate the 
##RMA intensities using rma.para function.
Para<-rma.para(Dilution[,1:3],bg=TRUE,exp=TRUE)
Ex1 <- Para[[3]]


###################################################
### code chunk number 4: RefPlus.Rnw:127-129
###################################################
##Calculate the RMA+ intensity using rmaplus function. 
Ex2 <- rmaplus(Dilution, rmapara=Para, bg = TRUE)


###################################################
### code chunk number 5: RefPlus.Rnw:134-139
###################################################
par(mfrow=c(2,2))
plot(Ex0[,1],Ex2[,1],pch=".",main=sampleNames(Dilution)[1])
plot(Ex0[,2],Ex2[,2],pch=".",main=sampleNames(Dilution)[2])
plot(Ex0[,3],Ex2[,3],pch=".",main=sampleNames(Dilution)[3])
plot(Ex0[,4],Ex2[,4],pch=".",main=sampleNames(Dilution)[4])


###################################################
### code chunk number 6: RefPlus.Rnw:148-150
###################################################
Para2 <- rma.para(Dilution[,2:4],bg=TRUE,exp=TRUE)
Ex3 <- rmaplus(Dilution, rmapara=Para2, bg = TRUE)


###################################################
### code chunk number 7: RefPlus.Rnw:156-157
###################################################
Ex4 <- (Ex2+Ex3)/2


###################################################
### code chunk number 8: RefPlus.Rnw:162-167
###################################################
par(mfrow=c(2,2))
plot(Ex0[,1],Ex4[,1],pch=".",main=sampleNames(Dilution)[1])
plot(Ex0[,2],Ex4[,2],pch=".",main=sampleNames(Dilution)[2])
plot(Ex0[,3],Ex4[,3],pch=".",main=sampleNames(Dilution)[3])
plot(Ex0[,4],Ex4[,4],pch=".",main=sampleNames(Dilution)[4])


###################################################
### code chunk number 9: RefPlus.Rnw:176-178
###################################################
sqrt(mean((Ex0-Ex2)^2))
sqrt(mean((Ex0-Ex3)^2))


###################################################
### code chunk number 10: RefPlus.Rnw:181-182
###################################################
sqrt(mean((Ex0-Ex4)^2))


