# Code example from 'rama' vignette. See references/ for full tutorial.

### R code from vignette source 'rama.Rnw'

###################################################
### code chunk number 1: rama.Rnw:81-82 (eval = FALSE)
###################################################
## library(rama,lib.loc='/home/user/Rlib')


###################################################
### code chunk number 2: rama.Rnw:123-125
###################################################
library(rama)
data(hiv)


###################################################
### code chunk number 3: rama.Rnw:155-156
###################################################
mcmc.hiv<-fit.model(hiv[1:640,c(1:4)],hiv[1:640,c(5:8)],B=5000,min.iter=4000,batch=1,shift=30,mcmc.obj=NULL,dye.swap=TRUE,nb.col1=2)


###################################################
### code chunk number 4: rama.Rnw:162-164
###################################################
gamma1<-mat.mean(mcmc.hiv$gamma1)[,1]
gamma2<-mat.mean(mcmc.hiv$gamma2)[,1]


###################################################
### code chunk number 5: logratio
###################################################
ratio.plot(mcmc.hiv,col=1,pch=1)


###################################################
### code chunk number 6: histdf
###################################################
hist(mcmc.hiv$df[3,],main="Posterior degree of freedoms, array 3",xlab="df",50)


###################################################
### code chunk number 7: imagew
###################################################
weight.plot(mcmc.hiv,hiv[1:640,9:10],array=3)


###################################################
### code chunk number 8: rama.Rnw:208-209
###################################################
mcmc.shift<-est.shift(hiv[1:640,c(1:4)],hiv[1:640,c(5:8)],B=2000,min.iter=1000,batch=10,mcmc.obj=NULL,dye.swap=TRUE,nb.col1=2)


###################################################
### code chunk number 9: rama.Rnw:225-229 (eval = FALSE)
###################################################
## library(rama)
## data(hiv)
## mcmc.hiv<-fit.model(hiv[,c(1:4)],hiv[,c(5:8)],B=50000,min.iter=5000,batch=90,shift=30,mcmc.obj=NULL,dye.swap=TRUE,nb.col1=2)
## save(mcmc.hiv,file='mcmc.hiv.R')


