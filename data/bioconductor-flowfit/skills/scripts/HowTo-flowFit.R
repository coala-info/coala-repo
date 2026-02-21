# Code example from 'HowTo-flowFit' vignette. See references/ for full tutorial.

### R code from vignette source 'HowTo-flowFit.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: CompanionPkg (eval = FALSE)
###################################################
## 
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## 
## BiocManager::install("flowFitExampleData")


###################################################
### code chunk number 2: HowTo-flowFit.Rnw:260-262
###################################################
library(flowFitExampleData)
library(flowFit)


###################################################
### code chunk number 3: HowTo-flowFit.Rnw:267-268
###################################################
library(flowCore)


###################################################
### code chunk number 4: HowTo-flowFit.Rnw:274-275
###################################################
data(QuahAndParish)


###################################################
### code chunk number 5: HowTo-flowFit.Rnw:292-293
###################################################
QuahAndParish[[1]]


###################################################
### code chunk number 6: HowTo-flowFit.Rnw:310-313
###################################################
parent.fitting.cfse <- parentFitting(QuahAndParish[[1]], "<FITC-A>")
parent.fitting.cpd <- parentFitting(QuahAndParish[[1]], "<APC-A>")
parent.fitting.ctv <- parentFitting(QuahAndParish[[1]], "<Alexa Fluor 405-A>")


###################################################
### code chunk number 7: HowTo-flowFit.Rnw:319-321 (eval = FALSE)
###################################################
## parent.fitting.cfse <- parentFitting(QuahAndParish[[1]], "<FITC-A>")
## plot(parent.fitting.cfse)


###################################################
### code chunk number 8: fig1
###################################################
plot(parent.fitting.cfse)


###################################################
### code chunk number 9: HowTo-flowFit.Rnw:339-341 (eval = FALSE)
###################################################
## parent.fitting.cpd <- parentFitting(QuahAndParish[[1]], "<APC-A>")
## plot(parent.fitting.cpd)


###################################################
### code chunk number 10: fig2
###################################################
plot(parent.fitting.cpd)


###################################################
### code chunk number 11: HowTo-flowFit.Rnw:358-360 (eval = FALSE)
###################################################
## parent.fitting.ctv <- parentFitting(QuahAndParish[[1]], "<Alexa Fluor 405-A>")
## plot(parent.fitting.ctv)


###################################################
### code chunk number 12: fig3
###################################################
plot(parent.fitting.ctv)


###################################################
### code chunk number 13: HowTo-flowFit.Rnw:380-381
###################################################
summary(parent.fitting.cfse)


###################################################
### code chunk number 14: HowTo-flowFit.Rnw:386-387
###################################################
confint(parent.fitting.cfse)


###################################################
### code chunk number 15: HowTo-flowFit.Rnw:397-398
###################################################
QuahAndParish[[1]]@parameters@data[7,]


###################################################
### code chunk number 16: HowTo-flowFit.Rnw:403-405 (eval = FALSE)
###################################################
## logTrans <- logTransform(transformationId="log10-transformation",
##  logbase=10, r=1, d=1)


###################################################
### code chunk number 17: HowTo-flowFit.Rnw:415-417
###################################################
data(PKH26data)
keyword(PKH26data[[1]])$`$P4M`


###################################################
### code chunk number 18: HowTo-flowFit.Rnw:422-424
###################################################
acquisiton.resolution <- QuahAndParish[[1]]@parameters@data$range[7]
log10(acquisiton.resolution)


###################################################
### code chunk number 19: HowTo-flowFit.Rnw:441-443
###################################################
parent.fitting.cfse@parentPeakPosition
parent.fitting.cfse@parentPeakSize


###################################################
### code chunk number 20: HowTo-flowFit.Rnw:448-452
###################################################
fitting.cfse <- proliferationFitting(QuahAndParish[[2]],
  "<FITC-A>", parent.fitting.cfse@parentPeakPosition,
  parent.fitting.cfse@parentPeakSize)
fitting.cfse


###################################################
### code chunk number 21: HowTo-flowFit.Rnw:456-457
###################################################
coef(fitting.cfse)


###################################################
### code chunk number 22: HowTo-flowFit.Rnw:460-461
###################################################
summary(fitting.cfse)


###################################################
### code chunk number 23: HowTo-flowFit.Rnw:489-491 (eval = FALSE)
###################################################
## library(flowFit)
## ?plot


###################################################
### code chunk number 24: HowTo-flowFit.Rnw:502-503 (eval = FALSE)
###################################################
## plot(fitting.cfse, which=1)


###################################################
### code chunk number 25: fig4
###################################################
plot(fitting.cfse, which=1)


###################################################
### code chunk number 26: HowTo-flowFit.Rnw:526-527 (eval = FALSE)
###################################################
## plot(fitting.cfse, which=2)


###################################################
### code chunk number 27: fig5
###################################################
plot(fitting.cfse, which=2)


###################################################
### code chunk number 28: HowTo-flowFit.Rnw:550-551 (eval = FALSE)
###################################################
## plot(fitting.cfse, which=3)


###################################################
### code chunk number 29: fig6
###################################################
plot(fitting.cfse, which=3)


###################################################
### code chunk number 30: HowTo-flowFit.Rnw:573-574 (eval = FALSE)
###################################################
## plot(fitting.cfse, which=4)


###################################################
### code chunk number 31: fig7
###################################################
plot(fitting.cfse, which=4)


###################################################
### code chunk number 32: HowTo-flowFit.Rnw:603-604 (eval = FALSE)
###################################################
## plot(fitting.cfse, which=5)


###################################################
### code chunk number 33: fig8
###################################################
plot(fitting.cfse, which=5)


###################################################
### code chunk number 34: HowTo-flowFit.Rnw:626-628 (eval = FALSE)
###################################################
## par(mfrow=c(2,2))
## plot(fitting.cfse, which=1:4, legend=FALSE)


###################################################
### code chunk number 35: fig9
###################################################
par(mfrow=c(2,2))
plot(fitting.cfse, which=1:4, legend=FALSE)


###################################################
### code chunk number 36: HowTo-flowFit.Rnw:642-644 (eval = FALSE)
###################################################
## par(mfrow=c(2,1))
## plot(fitting.cfse, which=c(3,5), legend=FALSE)


###################################################
### code chunk number 37: fig10
###################################################
par(mfrow=c(2,1))
plot(fitting.cfse, which=c(3,5), legend=FALSE)


###################################################
### code chunk number 38: GenFittingOut
###################################################
gen <- getGenerations(fitting.cfse)
class(gen)


###################################################
### code chunk number 39: GenFittingOutVector
###################################################
fitting.cfse@generations


###################################################
### code chunk number 40: ProliferationIndex
###################################################
proliferationIndex(fitting.cfse)


###################################################
### code chunk number 41: FittingCTVQuah
###################################################
fitting.ctv <- proliferationFitting(QuahAndParish[[4]],
  "<Alexa Fluor 405-A>", parent.fitting.ctv@parentPeakPosition,
  parent.fitting.ctv@parentPeakSize)


###################################################
### code chunk number 42: HowTo-flowFit.Rnw:740-741 (eval = FALSE)
###################################################
## plot(fitting.ctv, which=3)


###################################################
### code chunk number 43: fig11
###################################################
plot(fitting.ctv, which=3)


###################################################
### code chunk number 44: HowTo-flowFit.Rnw:761-762 (eval = FALSE)
###################################################
## plot(QuahAndParish[[3]],"<APC-A>", breaks=1024, main="CPD sample")


###################################################
### code chunk number 45: fig12
###################################################
plot(QuahAndParish[[3]],"<APC-A>", breaks=1024, main="CPD sample")


###################################################
### code chunk number 46: FittingCPDQuah
###################################################
fitting.cpd <- proliferationFitting(QuahAndParish[[3]],
  "<APC-A>",
  parent.fitting.cpd@parentPeakPosition,
  parent.fitting.cpd@parentPeakSize,
  fixedModel=TRUE,
  fixedPars=list(M=parent.fitting.cpd@parentPeakPosition))


###################################################
### code chunk number 47: HowTo-flowFit.Rnw:789-790 (eval = FALSE)
###################################################
## plot(fitting.cpd, which=3)


###################################################
### code chunk number 48: fig13
###################################################
plot(fitting.cpd, which=3)


###################################################
### code chunk number 49: CHISQUARETEST
###################################################
perc.cfse <- fitting.cfse@generations
perc.cpd <- fitting.cpd@generations
perc.ctv <- fitting.ctv@generations


###################################################
### code chunk number 50: CHISQUARETESTTRIM
###################################################
perc.cfse <- c(perc.cfse, rep(0,6))


###################################################
### code chunk number 51: CHISQUARE_TEST
###################################################
M <- rbind(perc.cfse, perc.cpd, perc.ctv)
colnames(M) <- 1:16
(Xsq <- chisq.test(M, B=100000, simulate.p.value=TRUE))


###################################################
### code chunk number 52: HowTo-flowFit.Rnw:828-835 (eval = FALSE)
###################################################
## plot(perc.cfse, type="b", axes=F, ylim=c(0,50), xlab="generations", ylab="Percentage of cells", main="")
## lines(perc.cpd, type="b", col="red")
## lines(perc.ctv, type="b", col="blue")
## legend("topleft", c("CFSE","CPD","CTV"), pch=1, col=c("black","red","blue"), bg = 'gray90',text.col = "green4")
## axis(2, at=seq(0,50,10), labels=paste(seq(0,50,10),"%"))
## axis(1, at=1:16,labels=1:16)
## text(8,40,paste("Chi-squared Test p=", round(Xsq$p.value, digits=4), sep=""))


###################################################
### code chunk number 53: fig14
###################################################
plot(perc.cfse, type="b", axes=F, ylim=c(0,50),
  xlab="generations", ylab="Percentage of cells", main="")
lines(perc.cpd, type="b", col="red")
lines(perc.ctv, type="b", col="blue")
legend("topleft", c("CFSE","CPD","CTV"), pch=1, col=c("black","red","blue"), bg = 'gray90',text.col = "green4")
axis(2, at=seq(0,50,10), labels=paste(seq(0,50,10),"%"))
axis(1, at=1:16,labels=1:16)
text(8,40,paste("Chi-squared Test p=", round(Xsq$p.value, digits=4), sep=""))


