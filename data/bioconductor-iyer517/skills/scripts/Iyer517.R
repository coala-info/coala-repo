# Code example from 'Iyer517' vignette. See references/ for full tutorial.

### R code from vignette source 'Iyer517.Rnw'

###################################################
### code chunk number 1: Iyer517.Rnw:56-58
###################################################
library(Iyer517)
data(Iyer517)


###################################################
### code chunk number 2: Iyer517.Rnw:61-62
###################################################
show(Iyer517)


###################################################
### code chunk number 3: Iyer517.Rnw:65-66
###################################################
exprs(Iyer517)[1:4,1:6]


###################################################
### code chunk number 4: Iyer517.Rnw:82-86
###################################################
chg <- seq(.1,8,.01)
mycol <- rgb( chg/8, 1-chg/8, 0 )
CEX <- exprs(Iyer517)
CEX[CEX>8] <- 8


###################################################
### code chunk number 5: Iyer517.Rnw:89-92
###################################################
image(t(log10(CEX[517:1,1:13])),col=mycol,xlim=c(0,3),axes=FALSE,
 xlab="Hours post exposure to serum")
axis(1,at=(1:13)/13,lab=c("0",".25",".5","1","2","4","6","8","12","16","20","24","u"),cex=.3)


###################################################
### code chunk number 6: Iyer517.Rnw:107-116
###################################################
par(mfrow=c(2,2))
plot(apply((CEX[1:100,1:13]),2,mean),main="Cluster A", log="y",
ylab="fold change", xlab="index in timing sequence")
plot(apply((CEX[101:242,1:13]),2,mean),main="Cluster B", log="y",
ylab="fold change", xlab="index in timing sequence")
plot(apply((CEX[483:499,1:13]),2,mean),main="Cluster I", log="y",
ylab="fold change", xlab="index in timing sequence")
plot(apply((CEX[500:517,1:13]),2,mean),main="Cluster J", log="y",
ylab="fold change", xlab="index in timing sequence")


###################################################
### code chunk number 7: Iyer517.Rnw:122-124
###################################################
data(IyerAnnotated)
print(IyerAnnotated[1:5,])


