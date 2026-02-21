# Code example from 'bioDist' vignette. See references/ for full tutorial.

### R code from vignette source 'bioDist.Rnw'

###################################################
### code chunk number 1: loadLib
###################################################
library("bioDist")
data(sample.ExpressionSet)
exData = t(exprs(sample.ExpressionSet))


###################################################
### code chunk number 2: R
###################################################
s1 = MIdist(exData)
s2 = as.matrix(s1)
dim(s2)
r1 = mutualInfo(exData)


###################################################
### code chunk number 3: KLD
###################################################
kl1 = KLdist.matrix(exData)
kl2 = KLD.matrix(exData, method="density", supp=range(exData))


###################################################
### code chunk number 4: Tau
###################################################
eS = sample.ExpressionSet[401:500,]
tauD = tau.dist(eS, sample=FALSE)
sp = spearman.dist(eS, sample=FALSE)


###################################################
### code chunk number 5: closest
###################################################
f1 = featureNames(eS)[1]
closest.top(f1, sp, 3)


###################################################
### code chunk number 6: bioDist.Rnw:130-131
###################################################
sessionInfo()


