# Code example from 'acde' vignette. See references/ for full tutorial.

### R code from vignette source 'acde.Rnw'

###################################################
### code chunk number 1: acde.Rnw:828-830 (eval = FALSE)
###################################################
## # Analysis of the phytophthora data set with acde
## library(acde)


###################################################
### code chunk number 2: acde.Rnw:832-837 (eval = FALSE)
###################################################
## ## Single time point analysis (36 hai)
## dat <- phytophthora[[3]]
## des <- c(rep(1,8), rep(2,8))
## ### For a quick run, set BCa=FALSE
## stpPI <- stp(dat, des, BCa=TRUE)


###################################################
### code chunk number 3: acde.Rnw:839-841 (eval = FALSE)
###################################################
## stpPI
## plot(stpPI)


###################################################
### code chunk number 4: acde.Rnw:843-847 (eval = FALSE)
###################################################
## ## Time course analysis
## desPI <- vector("list",4)
## for(tp in 1:4) desPI[[tp]] <- c(rep(1,8), rep(2,8))
## tcPI <- tc(phytophthora, desPI)


###################################################
### code chunk number 5: acde.Rnw:849-852 (eval = FALSE)
###################################################
## summary(tcPI)
## tcPI
## plot(tcPI)


###################################################
### code chunk number 6: acde.Rnw:889-893
###################################################
library(acde)
load("resVignette.rda")
dat <- phytophthora[[3]]
des <- c(rep(1,8), rep(2,8))


###################################################
### code chunk number 7: stpPI (eval = FALSE)
###################################################
## library(acde)
## dat <- phytophthora[[3]]
## des <- c(rep(1,8), rep(2,8))
## stpPI <- stp(dat, des, BCa=TRUE)


###################################################
### code chunk number 8: printStp
###################################################
stpPI


###################################################
### code chunk number 9: plotStp
###################################################
golden <- 1.1*(1+sqrt(5))/2
hi <- 4

pdf("acde-plotStpFDR.pdf", width=golden*hi, height=hi, fonts="Times")
par(mfrow=c(1,1), mar=c(4, 4, 0.1, 1), las=1, family="Times")
plot(stpPI, AC=FALSE)
invisible(dev.off())

pdf("acde-plotStpAC.pdf", width=golden*hi, height=hi, fonts="Times")
par(mfrow=c(1,1), mar=c(4, 4, 0.1, 1), las=1, family="Times")
plot(stpPI, FDR=FALSE)
invisible(dev.off())


###################################################
### code chunk number 10: tcPI (eval = FALSE)
###################################################
## desPI <- vector("list",4)
## for(tp in 1:4) desPI[[tp]] <- c(rep(1,8), rep(2,8))
## tcPI <- tc(phytophthora, desPI)


###################################################
### code chunk number 11: acde.Rnw:1034-1036
###################################################
desPI <- vector("list",4)
for(tp in 1:4) desPI[[tp]] <- c(rep(1,8), rep(2,8))


###################################################
### code chunk number 12: acde.Rnw:1057-1058
###################################################
summary(tcPI)


###################################################
### code chunk number 13: plotTcPI1
###################################################
tcAux1 <- tcPI; tcAux1$gct <- "Not computed."
hi <- 6
pdf("acde-plotTcPI1.pdf", width=golden*hi, height=hi, fonts="Times")
par(mfrow=c(1,1), mar=c(4, 4, 0.1, 1), las=1, family="Times")
plot(tcAux1, iRatios=FALSE, FDR=FALSE)
invisible(dev.off())


###################################################
### code chunk number 14: plotTcPI2
###################################################
tcAux2 <- tcPI; tcAux2$act <- "Not computed."
pdf("acde-plotTcPI2.pdf", width=golden*hi, height=hi, fonts="Times")
par(mfrow=c(1,1), mar=c(4, 4, 0.1, 1), las=1, family="Times")
plot(tcAux2, iRatios=FALSE, AC=FALSE)
invisible(dev.off())


###################################################
### code chunk number 15: plotTcPI3
###################################################
pdf("acde-plotTcPI3.pdf", width=golden*hi, height=hi, fonts="Times")
par(mfrow=c(1,1), mar=c(4, 4, 0.1, 1), las=1, family="Times")
plot(tcAux2, iRatios=FALSE, FDR=FALSE)
invisible(dev.off())


###################################################
### code chunk number 16: acde.Rnw:1396-1400 (eval = FALSE)
###################################################
## ## Object stpPI
## set.seed(73, kind="Mersenne-Twister")
## des <- c(rep(1,8), rep(2,8))
## stpPI <- stp(phytophthora[[3]], desPI[[3]], BCa=TRUE)


###################################################
### code chunk number 17: acde.Rnw:1402-1407 (eval = FALSE)
###################################################
## ## Object tcPI
## set.seed(27, kind="Mersenne-Twister")
## desPI <- vector("list",4)
## for(tp in 1:4) desPI[[tp]] <- c(rep(1,8), rep(2,8))
## tcPI <- tc(phytophthora, desPI)


