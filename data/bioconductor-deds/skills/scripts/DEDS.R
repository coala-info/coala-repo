# Code example from 'DEDS' vignette. See references/ for full tutorial.

### R code from vignette source 'DEDS.rnw'

###################################################
### code chunk number 1: loadaffy
###################################################
library(DEDS)
data(affySpikeIn) 


###################################################
### code chunk number 2: showaffy
###################################################
dim(affySpikeIn) 
affySpikeIn.L
spikedgene


###################################################
### code chunk number 3: dedsaffy
###################################################
deds.affy <- deds.stat.linkC(affySpikeIn, affySpikeIn.L, B=400, nsig=100) 


###################################################
### code chunk number 4: showdedsaffy
###################################################
topgenes(deds.affy, number=20, genelist=affySpikeIn.gnames)


###################################################
### code chunk number 5: pairsaffy (eval = FALSE)
###################################################
## pairs(deds.affy, subset=c(2:12626), thresh=0.01, legend=F)


###################################################
### code chunk number 6: qqaffy (eval = FALSE)
###################################################
## qqnorm(deds.affy, subset=c(2:12626), thresh=0.01)


###################################################
### code chunk number 7: loadApoA1
###################################################
data(ApoA1) 


###################################################
### code chunk number 8: showApoA1
###################################################
dim(ApoA1) 
ApoA1.L


###################################################
### code chunk number 9: dedsApoA1
###################################################
deds.ApoA1 <- deds.stat.linkC(ApoA1, ApoA1.L, B=400, adj="adjp" ) 


###################################################
### code chunk number 10: DEDS.rnw:263-265
###################################################
sum(deds.ApoA1$p<=0.01)
sum(deds.ApoA1$p<=0.05)


###################################################
### code chunk number 11: showdedsApoA1
###################################################
topgenes(deds.ApoA1, number=9)


###################################################
### code chunk number 12: pairsApoA1
###################################################
pairs(deds.ApoA1, legend=F)


###################################################
### code chunk number 13: tstat (eval = FALSE)
###################################################
## t <- comp.t(L=affySpikeIn.L)
## t.affy <- t(affySpikeIn)


###################################################
### code chunk number 14: tstat2 (eval = FALSE)
###################################################
## t.affy <- comp.stat(affySpikeIn, affySpikeIn.L, test='t')


