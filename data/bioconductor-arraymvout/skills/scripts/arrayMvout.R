# Code example from 'arrayMvout' vignette. See references/ for full tutorial.

### R code from vignette source 'arrayMvout.Rnw'

###################################################
### code chunk number 1: dddd
###################################################
library(arrayMvout)
data(maqcQA)
mm = ArrayOutliers(maqcQA[, 3:11], alpha=.01)
mm


###################################################
### code chunk number 2: dde
###################################################
data(itnQA)
ii = ArrayOutliers(itnQA, alpha=.01)
ii


###################################################
### code chunk number 3: lklk
###################################################
plot(ii, choices=c(1,3))


###################################################
### code chunk number 4: doapan (eval = FALSE)
###################################################
## library(arrayMvout)
## library(MAQCsubset)
## if (!exists("afxsub")) data(afxsub)
## sn = sampleNames(afxsub)
## if (nchar(sn)[1] > 6) {
##   sn = substr(sn, 3, 8)
##   sampleNames(afxsub) = sn
## }


###################################################
### code chunk number 5: lkda (eval = FALSE)
###################################################
## opar = par(no.readonly=TRUE)
## par(mar=c(10,5,5,5), las=2)
## boxplot(afxsub, main="MAQC subset", 
##   col=rep(c("green", "blue", "orange"), c(8,8,8)))
## par(opar)


###################################################
### code chunk number 6: lkadas (eval = FALSE)
###################################################
## #afxsubDEG = AffyRNAdeg(afxsub)
## #save(afxsubDEG, file="afxsubDEG.rda")
## library(arrayMvout)
## data(afxsubDEG)
## plotAffyRNAdeg(afxsubDEG, 
##   col=rep(c("green", "blue", "orange"),c(8,8,8)))


###################################################
### code chunk number 7: asdad (eval = FALSE)
###################################################
## #afxsubQC = qc(afxsub)
## #save(afxsubQC, file="afxsubQC.rda")
## data(afxsubQC)
## plot(afxsubQC)


###################################################
### code chunk number 8: splm (eval = FALSE)
###################################################
## library(affyPLM)
## #if (file.exists("splm.rda")) load("splm.rda")
## #if (!exists("splm")) splm = fitPLM(afxsub)
## splm = fitPLM(afxsub)
## #save(splm, file="splm.rda")


###################################################
### code chunk number 9: don (eval = FALSE)
###################################################
## png(file="doim.png")
## par(mar=c(7,5,5,5),mfrow=c(2,2),las=2)
## NUSE(splm, ylim=c(.85,1.3))
## RLE(splm)
## image(splm, which=2, type="sign.resid")
## image(splm, which=5, type="sign.resid")


###################################################
### code chunk number 10: adadadadadad (eval = FALSE)
###################################################
## dev.off()


###################################################
### code chunk number 11: doao (eval = FALSE)
###################################################
## AO = ArrayOutliers(afxsub, alpha=0.05, qcOut=afxsubQC, 
##   plmOut=splm, degOut=afxsubDEG)
## nrow(AO[["outl"]])


###################################################
### code chunk number 12: doaaa (eval = FALSE)
###################################################
## AO[[3]][1:2, ]


###################################################
### code chunk number 13: doz (eval = FALSE)
###################################################
## library(mdqc)
## mdq = mdqc( AO[[3]], robust="MVE" )
## mdq


###################################################
### code chunk number 14: doada (eval = FALSE)
###################################################
## require(mvoutData)
## data(s12c)


###################################################
### code chunk number 15: aaadas (eval = FALSE)
###################################################
## image(s12c[,1])


###################################################
### code chunk number 16: doaaaasdas (eval = FALSE)
###################################################
## aos12c = ArrayOutliers(s12c, alpha=0.05)


###################################################
### code chunk number 17: lkres (eval = FALSE)
###################################################
## aos12c[[1]]


###################################################
### code chunk number 18: lkaaa (eval = FALSE)
###################################################
## aos12c[[4]]


###################################################
### code chunk number 19: doma (eval = FALSE)
###################################################
## mdqc(aos12c[[3]], robust="MVE")


###################################################
### code chunk number 20: DoSessionInfo
###################################################
sessionInfo()


