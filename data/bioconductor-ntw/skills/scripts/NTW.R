# Code example from 'NTW' vignette. See references/ for full tutorial.

### R code from vignette source 'NTW.Rnw'

###################################################
### code chunk number 1: libPackage
###################################################
library(NTW)
library(mvtnorm)


###################################################
### code chunk number 2: loadData
###################################################
data(sos.data)
X<-sos.data
X<-as.matrix(X)
X


###################################################
### code chunk number 3: setPara
###################################################
restK=rep(ncol(X)-1, nrow(X))
topD = round(0.6*nrow(X))
topK = round(0.5*nrow(X))
numP = round(0.25*nrow(X))


###################################################
### code chunk number 4: genPrior
###################################################
pred.net<-matrix(round(runif(nrow(X)*nrow(X), min=0, max=1)), nrow(X), nrow(X))
pred.net


###################################################
### code chunk number 5: calResult1
###################################################
result<-NTW(X, restK, topD, topK, P.known=NULL, cFlag="sse", pred.net = NULL, sup.drop = -1,numP, noiseLevel=0.1)
result


###################################################
### code chunk number 6: calResult2
###################################################
result<-NTW(X, restK, topD, topK, P.known=NULL, cFlag="sse", pred.net =pred.net, sup.drop = 1,numP, noiseLevel=0.1)
result


###################################################
### code chunk number 7: calResultS
###################################################
IX<-P.preestimation(X, topK= round(2*nrow(X)))
result.Srow<-AP.estimation.Srow(r=1,cMM.corrected = 1, pred.net,X, IX,topD, restK, cFlag="sse",sup.drop = -1, numP, noiseLevel=0.1)
result.Srow


###################################################
### code chunk number 8: calResultSPKnown
###################################################
P.known<-matrix(round(runif(nrow(X)*ncol(X), min=0, max=1)), nrow(X), ncol(X))
result.Srow<-A.estimation.Srow(r=1,cMM.corrected = 1, pred.net, X, P.known, topD, restK, cFlag="ml",sup.drop = -1, noiseLevel=0.1)
result.Srow


