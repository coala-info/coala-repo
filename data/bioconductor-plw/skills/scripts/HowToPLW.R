# Code example from 'HowToPLW' vignette. See references/ for full tutorial.

### R code from vignette source 'HowToPLW.Rnw'

###################################################
### code chunk number 1: HowToPLW.Rnw:44-45
###################################################
require(plw)


###################################################
### code chunk number 2: HowToPLW.Rnw:67-68
###################################################
data(AffySpikeU95Subset)


###################################################
### code chunk number 3: HowToPLW.Rnw:70-71
###################################################
AffySpikeU95Subset


###################################################
### code chunk number 4: HowToPLW.Rnw:79-80
###################################################
pData(AffySpikeU95Subset)


###################################################
### code chunk number 5: HowToPLW.Rnw:84-87
###################################################
group<-factor(rep(letters[1:2],each=3))
design<-model.matrix(~group-1)
contrast<-matrix(c(1,-1),1,2)


###################################################
### code chunk number 6: HowToPLW.Rnw:89-91
###################################################
design
contrast


###################################################
### code chunk number 7: HowToPLW.Rnw:94-95
###################################################
plwFit<-plw(AffySpikeU95Subset,design=design,contrast=contrast,epsilon=1e-05)


###################################################
### code chunk number 8: HowToPLW.Rnw:97-98
###################################################
plwFit


###################################################
### code chunk number 9: HowToPLW.Rnw:115-116
###################################################
topRankSummary(plwFit,genes=spikedProbesU95)


###################################################
### code chunk number 10: HowToPLW.Rnw:119-120
###################################################
topRankSummary(plwFit,genesOfRank=11:20)


###################################################
### code chunk number 11: HowToPLW.Rnw:124-125
###################################################
topRankSummary(plwFit,nGenes=20)


###################################################
### code chunk number 12: HowToPLW.Rnw:134-135
###################################################
plotSummaryT(plwFit,genes=spikedProbesU95)


###################################################
### code chunk number 13: HowToPLW.Rnw:142-143
###################################################
plotSummaryLog2FC(plwFit,nGenes=15)


###################################################
### code chunk number 14: HowToPLW.Rnw:161-162
###################################################
varHistPlot(plwFit)


###################################################
### code chunk number 15: HowToPLW.Rnw:170-171
###################################################
scaleParameterPlot(plwFit)


###################################################
### code chunk number 16: HowToPLW.Rnw:187-195 (eval = FALSE)
###################################################
## source("http://www.math.chalmers.se/~astrandm/plw/GetApoAIdata.R")
## RG <- GetApoAIdata()
## require(limma)
## MA <- normalizeWithinArrays(RG)
## rownames(MA$M) <- MA$genes$Name
## ii <- apply(is.na(MA$M),1,any)
## MA$A <- MA$A[!ii,]
## MA$M <- MA$M[!ii,]


###################################################
### code chunk number 17: HowToPLW.Rnw:201-203 (eval = FALSE)
###################################################
## design <- cbind("Control-Ref"=1,"KO-Control"=MA$targets$Cy5=="ApoAI KO")
## contrast <- matrix(0:1,ncol=2)


###################################################
### code chunk number 18: HowToPLW.Rnw:205-207 (eval = FALSE)
###################################################
## design
## contrast


###################################################
### code chunk number 19: HowToPLW.Rnw:215-218 (eval = FALSE)
###################################################
## meanX <- apply(MA$A,1,mean)
## knots <- quantile(meanX,seq(0.1,0.9,by=0.2))
## lmwFit <- lmw(MA$M,design=design,contrast=contrast,meanX=meanX,knots=knots)


###################################################
### code chunk number 20: HowToPLW.Rnw:220-221 (eval = FALSE)
###################################################
## lmwFit


###################################################
### code chunk number 21: HowToPLW.Rnw:224-225 (eval = FALSE)
###################################################
## topRankSummary(lmwFit,nGenes=10)


