# Code example from 'lol' vignette. See references/ for full tutorial.

### R code from vignette source 'lol.Rnw'

###################################################
### code chunk number 1: lol.Rnw:29-31
###################################################
options(width=80)
options(verbose=FALSE)


###################################################
### code chunk number 2: lol.Rnw:57-61
###################################################
library(lol)
data(chin07)
dim(chin07$cn)
dim(chin07$ge)


###################################################
### code chunk number 3: lol.Rnw:65-69
###################################################
gain <- rowSums(chin07$cn >= .2)
loss <- -rowSums(chin07$cn <= -.2)
plotGW(data=cbind(gain, loss), pos=attr(chin07$cn, 'chrome'), file='plotGWCN', 
fileType='pdf', legend=c('gain', 'loss'), col=c('darkred', 'darkblue'))


###################################################
### code chunk number 4: lol.Rnw:76-81
###################################################
Data <- list(y=chin07$ge[1,], x=t(chin07$cn))
class(Data) <- 'cv'
set.seed(10)
res.cv <- lasso(Data)
res.cv


###################################################
### code chunk number 5: lol.Rnw:88-91
###################################################
class(Data) <- 'stability'
res.stability <- lasso(Data)
res.stability


###################################################
### code chunk number 6: lol.Rnw:96-99
###################################################
class(Data) <- 'multiSplit'
res.multiSplit <- lasso(Data)
res.multiSplit


###################################################
### code chunk number 7: lol.Rnw:103-106
###################################################
class(Data) <- 'simultaneous'
res.simultaneous <- lasso(Data)
res.simultaneous


###################################################
### code chunk number 8: lol.Rnw:110-113
###################################################
plotGW(data=cbind(res.cv$beta, res.stability$beta, res.multiSplit$beta, res.simultaneous$beta), 
pos=attr(chin07$cn, 'chrome'), file='plotGWLassoOptimizers', fileType='pdf', width=8, 
height=5, legend=c('cv', 'stability', 'multiSplit', 'simultaneous'), legend.pos='topleft')


###################################################
### code chunk number 9: lol.Rnw:118-123
###################################################
Data <- list(y=t(chin07$ge), x=t(chin07$cn))
res1 <- matrixLasso(Data, method='cv')
res1
res2 <- matrixLasso(Data, method='stability')
res2


###################################################
### code chunk number 10: lol.Rnw:127-129
###################################################
res.lm <- lmMatrixFit(y=Data, mat=abs(res2$coefMat), th=0.01)
res.lm


###################################################
### code chunk number 11: sessionInfo
###################################################
sessionInfo()


