# Code example from 'PANR-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'PANR-Vignette.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 2: setup
###################################################
library(PANR)
data(Bakal2007)


###################################################
### code chunk number 3: dimBakal2007
###################################################
dim(Bakal2007)


###################################################
### code chunk number 4: newbm
###################################################
bm1<-new("BetaMixture", pheno=Bakal2007, metric="cosine", 
model="global", order=1)


###################################################
### code chunk number 5: bm1show
###################################################
bm1


###################################################
### code chunk number 6: fitNULL (eval = FALSE)
###################################################
## bm1<-fitNULL(bm1, nPerm=10, thetaNULL=c(alphaNULL=4, betaNULL=4),
## sumMethod="median", permMethod="all", verbose=TRUE)


###################################################
### code chunk number 7: fitBM (eval = FALSE)
###################################################
## bm1<-fitBM(bm1, para=list(zInit=NULL, thetaInit=c(alphaNeg=2, 
## betaNeg=4, alphaNULL=bm1@result$fitNULL$thetaNULL[["alphaNULL"]], 
## betaNULL=bm1@result$fitNULL$thetaNULL[["betaNULL"]], 
## alphaPos=4, betaPos=2), gamma=NULL), 
## ctrl=list(fitNULL=FALSE, tol=1e-1), verbose=TRUE, gradtol=1e-3)


###################################################
### code chunk number 8: loadBM1
###################################################
data(bm)


###################################################
### code chunk number 9: viewNULLfitting
###################################################
view(bm1, "fitNULL")


###################################################
### code chunk number 10: viewBMfitting
###################################################
view(bm1, "fitBM")


###################################################
### code chunk number 11: printBM
###################################################
summarize(bm1, what="ALL")


###################################################
### code chunk number 12: inferFullPAN
###################################################
pan<-new("PAN", bm1=bm1)
pan<-infer(pan, para=list(type="SNR", log=TRUE, sign=TRUE, 
cutoff=log(5)), filter=FALSE, verbose=TRUE)


###################################################
### code chunk number 13: buildPAN
###################################################
data(Bakal2007Cluster)
pan<-buildPAN(pan, engine="RedeR", 
para=list(nodeColor=nodeColor, hideNeg=TRUE))


###################################################
### code chunk number 14: visualFullPAN (eval = FALSE)
###################################################
## library(RedeR)
## viewPAN(pan, what="graph")


###################################################
### code chunk number 15: searchpvmodule (eval = FALSE)
###################################################
## library(pvclust)
## options(cluster=makeCluster(4, "SOCK"))
## pan<-pvclustModule(pan, nboot=1000, metric="cosine", hclustMethod=
## "average", filter=TRUE, verbose=TRUE, r=c(5:12/7))
## if(is(getOption("cluster"), "cluster")) {
## 	stopCluster(getOption("cluster"))
## 	options(cluster=NULL)
## }


###################################################
### code chunk number 16: sigmodules (eval = FALSE)
###################################################
## inds<-sigModules(pan,pValCutoff=0.01, minSize=3, 
## maxSize=100, sortby="pval", decreasing=FALSE)


###################################################
### code chunk number 17: visualpvmodule (eval = FALSE)
###################################################
## viewPAN(pan,what="pvclustModule", moduleID=inds)


###################################################
### code chunk number 18: visualnestedpvmodule (eval = FALSE)
###################################################
## viewNestedModules(pan,pValCutoff=0.05,minSize=3,maxSize=100)


###################################################
### code chunk number 19: printPAN
###################################################
summarize(pan, what="graph")


###################################################
### code chunk number 20: sessionInfo
###################################################
toLatex(sessionInfo())


