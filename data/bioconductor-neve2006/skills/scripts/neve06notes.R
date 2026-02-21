# Code example from 'neve06notes' vignette. See references/ for full tutorial.

### R code from vignette source 'neve06notes.Rnw'

###################################################
### code chunk number 1: lkm
###################################################
library(Neve2006)
data(neveRMAmatch)
neveRMAmatch
experimentData(neveRMAmatch)
data(neveCGHmatch)
neveCGHmatch
all.equal(sampleNames(neveRMAmatch), sampleNames(neveCGHmatch))


###################################################
### code chunk number 2: lkc
###################################################
featureData(neveCGHmatch)[1:5,]


###################################################
### code chunk number 3: lkrp
###################################################
pData(featureData(neveCGHmatch))[grep("RP11-265K5", 
  featureNames(neveCGHmatch)),]


###################################################
### code chunk number 4: doid
###################################################
library(hgu133a.db)
library(annotate)
cb = as.list(hgu133aMAP)
G8p12ind = grep("8p12", unlist(cb))
ps8p12 = names(unlist(cb)[G8p12ind])
nevex = exprs(neveRMAmatch)[ps8p12,]
syms = as.character(unlist(lookUp(rownames(nevex), "hgu133a", "SYMBOL")))


###################################################
### code chunk number 5: getlr
###################################################
nevlr = as.numeric(logRatios(neveCGHmatch)["RP11-265K5",])


###################################################
### code chunk number 6: dopl
###################################################
par(mfrow=c(2,2))
for (i in c(2,8,11,20))
 plot( nevlr, nevex[i,], xlab="logratio", ylab="RMA expression",
   main=syms[i])
par(mfrow=c(1,1))


