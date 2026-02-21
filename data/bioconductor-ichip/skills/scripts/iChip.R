# Code example from 'iChip' vignette. See references/ for full tutorial.

### R code from vignette source 'iChip.Rnw'

###################################################
### code chunk number 1: iChip.Rnw:87-90
###################################################
library(iChip)
data(oct4)
head(oct4,n=3L)


###################################################
### code chunk number 2: iChip.Rnw:97-98
###################################################
oct4 = oct4[order(oct4[,1],oct4[,2]),]


###################################################
### code chunk number 3: iChip.Rnw:102-103
###################################################
oct4lmt = lmtstat(oct4[,5:6],oct4[,3:4])


###################################################
### code chunk number 4: iChip.Rnw:117-118
###################################################
oct4Y = cbind(oct4[,1],oct4lmt)


###################################################
### code chunk number 5: iChip.Rnw:128-131
###################################################
set.seed(777)
oct4res2 = iChip2(Y=oct4Y,burnin=2000,sampling=10000,winsize=2,
  sdcut=2,beta=1.25,verbose=FALSE)


###################################################
### code chunk number 6: iChip.Rnw:140-145
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
plot(oct4res2$mu0, pch=".", xlab="Iterations", ylab="mu0")
plot(oct4res2$lambda0, pch=".", xlab="Iterations", ylab="lambda0")
plot(oct4res2$mu1, pch=".", xlab="Iterations", ylab="mu1")
plot(oct4res2$lambda1, pch=".", xlab="Iterations", ylab="lambda1")


###################################################
### code chunk number 7: iChip.Rnw:153-154
###################################################
hist(oct4res2$pp)


###################################################
### code chunk number 8: iChip.Rnw:162-165
###################################################
reg1 = enrichreg(pos=oct4[,1:2],enrich=oct4lmt,pp=oct4res2$pp,
  cutoff=0.9,method="ppcut",maxgap=500)
print(reg1)


###################################################
### code chunk number 9: iChip.Rnw:171-174
###################################################
reg2 = enrichreg(pos=oct4[,1:2],enrich=oct4lmt,pp=oct4res2$pp,
  cutoff=0.01,method="fdrcut",maxgap=500)
print(reg2)


###################################################
### code chunk number 10: iChip.Rnw:181-183
###################################################
bed1 = data.frame(chr=paste("chr",reg2[,1],sep=""),reg2[,2:3])
print(bed1[1:2,])


###################################################
### code chunk number 11: iChip.Rnw:189-192
###################################################
bed2 = data.frame(chr=paste("chr",reg2[,1],sep=""),gstart=reg2[,6]-100,
  gend=reg2[,6]+100)
print(bed2[1:2,])


###################################################
### code chunk number 12: iChip.Rnw:197-199
###################################################
oct4res1 =iChip1(enrich=oct4lmt,burnin=2000,sampling=10000,sdcut=2,beta0=3,
  minbeta=0,maxbeta=10,normsd=0.1,verbose=FALSE)


###################################################
### code chunk number 13: iChip.Rnw:205-210
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
plot(oct4res1$beta, pch=".", xlab="Iterations", ylab="beta")
plot(oct4res1$mu0, pch=".", xlab="Iterations", ylab="mu0")
plot(oct4res1$mu1, pch=".", xlab="Iterations", ylab="mu1")
plot(oct4res1$lambda, pch=".", xlab="Iterations", ylab="lambda")


###################################################
### code chunk number 14: iChip.Rnw:216-220
###################################################
enrichreg(pos=oct4[,1:2],enrich=oct4lmt,pp=oct4res1$pp,cutoff=0.9,
          method="ppcut",maxgap=500)
enrichreg(pos=oct4[,1:2],enrich=oct4lmt,pp=oct4res1$pp,cutoff=0.01,
          method="fdrcut",maxgap=500)


###################################################
### code chunk number 15: iChip.Rnw:227-233
###################################################
data(p53)
head(p53,n=3L)
# sort the p53 data by chromosome and genomic position
p53 = p53[order(p53[,1],p53[,2]),]
p53lmt = lmtstat(p53[,9:14],p53[,3:8])
p53Y = cbind(p53[,1],p53lmt)


###################################################
### code chunk number 16: iChip.Rnw:240-241
###################################################
p53res2 = iChip2(Y=p53Y,burnin=2000,sampling=10000,winsize=2,sdcut=2,beta=2.5)


###################################################
### code chunk number 17: iChip.Rnw:245-250
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
plot(p53res2$mu0, pch=".", xlab="Iterations", ylab="mu0")
plot(p53res2$lambda0, pch=".", xlab="Iterations", ylab="lambda0")
plot(p53res2$mu1, pch=".", xlab="Iterations", ylab="mu1")
plot(p53res2$lambda1, pch=".", xlab="Iterations", ylab="lambda1")


###################################################
### code chunk number 18: iChip.Rnw:258-259
###################################################
hist(p53res2$pp)


###################################################
### code chunk number 19: iChip.Rnw:263-267
###################################################
enrichreg(pos=p53[,1:2],enrich=p53lmt,pp=p53res2$pp,cutoff=0.9,
          method="ppcut",maxgap=500)
enrichreg(pos=p53[,1:2],enrich=p53lmt,pp=p53res2$pp,cutoff=0.01,
          method="fdrcut",maxgap=500)


###################################################
### code chunk number 20: iChip.Rnw:272-274
###################################################
p53res1 =iChip1(enrich=p53lmt,burnin=2000,sampling=10000,sdcut=2,beta0=3,
  minbeta=0,maxbeta=10,normsd=0.1,verbose=FALSE)


###################################################
### code chunk number 21: iChip.Rnw:278-283
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
plot(p53res1$beta, pch=".", xlab="Iterations", ylab="beta")
plot(p53res1$mu0, pch=".", xlab="Iterations", ylab="mu0")
plot(p53res1$mu1, pch=".", xlab="Iterations", ylab="mu1")
plot(p53res1$lambda, pch=".", xlab="Iterations", ylab="lambda")


###################################################
### code chunk number 22: iChip.Rnw:287-291
###################################################
enrichreg(pos=p53[,1:2],enrich=p53lmt,pp=p53res1$pp,cutoff=0.9,
          method="ppcut",maxgap=500)
enrichreg(pos=p53[,1:2],enrich=p53lmt,pp=p53res1$pp,cutoff=0.01,
          method="fdrcut",maxgap=500)


###################################################
### code chunk number 23: iChip.Rnw:297-301
###################################################
randomY = cbind(p53[,1],rnorm(10000,0,1))
randomres2 = iChip2(Y=randomY,burnin=1000,sampling=5000,winsize=2,
  sdcut=2,beta=2.5,verbose=FALSE)
table(randomres2$pp)


###################################################
### code chunk number 24: iChip.Rnw:322-325
###################################################
randomres1 =iChip1(enrich=randomY[,2],burnin=1000,sampling=5000,sdcut=2,
  beta0=3,minbeta=0,maxbeta=10,normsd=0.1,verbose=FALSE)
table(randomres1$pp)


###################################################
### code chunk number 25: iChip.Rnw:373-374
###################################################
sessionInfo()


