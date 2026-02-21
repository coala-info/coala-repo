# Code example from 'bridge' vignette. See references/ for full tutorial.

### R code from vignette source 'bridge.Rnw'

###################################################
### code chunk number 1: bridge.Rnw:84-85
###################################################
library(bridge)


###################################################
### code chunk number 2: bridge.Rnw:131-132
###################################################
data(hiv)


###################################################
### code chunk number 3: bridge.Rnw:153-154
###################################################
bridge.hiv<-bridge.2samples(hiv[1:640,c(1:4)],hiv[1:640,c(5:8)],B=2000,min.iter=0,batch=1,mcmc.obj=NULL,affy=FALSE,verbose=FALSE)


###################################################
### code chunk number 4: bridge.Rnw:158-160
###################################################
gamma1<-mat.mean(bridge.hiv$gamma1)[,1]
gamma2<-mat.mean(bridge.hiv$gamma2)[,1]


###################################################
### code chunk number 5: logratio
###################################################
plot(gamma1-gamma2,bridge.hiv$post.p,col=1,pch=1,main="Posterior probability",xlab="log ratio",ylab="posterior probability")


###################################################
### code chunk number 6: histdf
###################################################
hist(bridge.hiv$nu1[3,],main="Posterior degree of freedoms, array 3",xlab="nu",50)


###################################################
### code chunk number 7: bridge.Rnw:199-204
###################################################
sample1<-matrix(exp(rnorm(150)),50,3)
sample2<-matrix(exp(rnorm(200)),50,4)
sample3<-matrix(exp(rnorm(150)),50,3)

mcmc.bridge3<-bridge.3samples(sample1,sample2,sample3,B=10,min.iter=0,batch=1,mcmc.obj=NULL,all.out=TRUE,verbose=FALSE)


