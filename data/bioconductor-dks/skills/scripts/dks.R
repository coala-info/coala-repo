# Code example from 'dks' vignette. See references/ for full tutorial.

### R code from vignette source 'dks.Rnw'

###################################################
### code chunk number 1: dks.Rnw:73-77
###################################################
library(dks)
library(cubature)
data(dksdata)
dim(P)


###################################################
### code chunk number 2: dks1
###################################################
dks1 <- dks(P,plot=TRUE)


###################################################
### code chunk number 3: pprob
###################################################
 ## Calculate the posterior distribution
 delta <- 0.1
  dist1 <- pprob.dist(P[,1])

  ## Plot the posterior distribution
  alpha <- seq(0.1,10,by=delta)
  beta <- seq(0.1,10,by=delta)
  pprobImage = image(log10(alpha),log10(beta),dist1,xaxt="n",yaxt="n",xlab="Alpha",ylab="Beta")
  axis(1,at=c(-2,-1,0,1,2),labels=c("10^-2","10^-1","10^0","10^1","10^2"))
  axis(2,at=c(-2,-1,0,1,2),labels=c("10^-2","10^-1","10^0","10^1","10^2"))
  points(0,0,col="blue",cex=1,pch=19)	


###################################################
### code chunk number 4: credSet
###################################################
 ## Calculate a 80% credible set
  cred1 <- cred.set(dist1,delta=0.1, level=0.80)

  ## Plot the posterior and the credible set
  
  alpha <- seq(0.1,10,by=delta)
  beta <- seq(0.1,10,by=delta)

  credImage=image(log10(alpha),log10(beta),cred1$cred,xaxt="n",yaxt="n",xlab="Alpha",ylab="Beta")
  axis(1,at=c(-2,-1,0,1,2),labels=c("10^-2","10^-1","10^0","10^1","10^2"))
  axis(2,at=c(-2,-1,0,1,2),labels=c("10^-2","10^-1","10^0","10^1","10^2"))
  points(0,0,col="blue",cex=1,pch=19)	


