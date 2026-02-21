# Code example from 'sigaR' vignette. See references/ for full tutorial.

### R code from vignette source 'sigaR.Rnw'

###################################################
### code chunk number 1: sigaR.Rnw:71-74
###################################################
library(sigaR)
data(pollackCN16)
data(pollackGE16)


###################################################
### code chunk number 2: sigaR.Rnw:104-106
###################################################
pollackCN16 <- cghCall2order(pollackCN16, chr=1, bpstart=2, verbose=FALSE)
pollackGE16 <- ExpressionSet2order(pollackGE16, chr=1, bpstart=2, verbose=FALSE)


###################################################
### code chunk number 3: sigaR.Rnw:109-111
###################################################
matchIDs <- matchCGHcall2ExpressionSet(pollackCN16, pollackGE16, CNchr=1, CNbpstart=2, 
    CNbpend=3, GEchr=1, GEbpstart=2, GEbpend=3, method = "distance", verbose=FALSE)


###################################################
### code chunk number 4: sigaR.Rnw:114-116
###################################################
pollackCN16 <- cghCall2subset(pollackCN16, matchIDs[,1], verbose=FALSE)
pollackGE16 <- ExpressionSet2subset(pollackGE16, matchIDs[,2], verbose=FALSE)


###################################################
### code chunk number 5: sigaR.Rnw:122-127
###################################################
data(pollackCN16)
data(pollackGE16)
matchedIDs <- matchAnn2Ann(fData(pollackCN16)[,1], fData(pollackCN16)[,2], 
    fData(pollackCN16)[,3], fData(pollackGE16)[,1], fData(pollackGE16)[,2], 
    fData(pollackGE16)[,3], method="distance", verbose=FALSE)


###################################################
### code chunk number 6: sigaR.Rnw:130-131
###################################################
nrow(exprs(pollackGE16)) - length(matchedIDs)


###################################################
### code chunk number 7: sigaR.Rnw:134-135
###################################################
table(sapply(matchedIDs, nrow, simplify=TRUE))


###################################################
### code chunk number 8: sigaR.Rnw:141-143
###################################################
matchedIDs <- lapply(matchedIDs, function(Z, offset){ Z[,3] <- Z[,3] + offset; return(Z)}, 
    offset=1)


###################################################
### code chunk number 9: sigaR.Rnw:146-148
###################################################
matchedIDsGE <- lapply(matchedIDs, function(Z){ return(Z[, -2, drop=FALSE]) })
matchedIDsCN <- lapply(matchedIDs, function(Z){ return(Z[, -1, drop=FALSE]) })


###################################################
### code chunk number 10: sigaR.Rnw:151-153
###################################################
GEdata <- ExpressionSet2weightedSubset(pollackGE16, matchedIDsGE, 1, 2, 3, verbose=FALSE)
CNdata <- cghCall2weightedSubset(pollackCN16, matchedIDsCN, 1, 2, 3, verbose=FALSE)


###################################################
### code chunk number 11: sigaR.Rnw:168-169
###################################################
CNGEheatmaps(pollackCN16, pollackGE16, location = "mode", colorbreaks = "equiquantiles")


###################################################
### code chunk number 12: sigaR.Rnw:189-193
###################################################
library(sigaR)
data(pollackCN16)
data(pollackGE16)
profilesPlot(pollackCN16, pollackGE16, 23, 16, verbose=FALSE)


###################################################
### code chunk number 13: sigaR.Rnw:352-357
###################################################
library(sigaR)
data(pollackCN16)
data(pollackGE16)
cisTestResults <- cisEffectTest(pollackCN16, pollackGE16, 1:nrow(pollackGE16), 1, "univariate", "wmw",  nPerm = 10, lowCiThres = 0.10, verbose=FALSE)
hist(cisTestResults@effectSize, n=50, col="blue", border="lightblue", xlab="effect size", main="histogram of effect size")


###################################################
### code chunk number 14: sigaR.Rnw:388-392
###################################################
op <- par(mfrow = c(1, 1), pty = "m")
data(pollackCN16)
data(pollackGE16)
cisEffectPlot(237, pollackCN16, pollackGE16)


###################################################
### code chunk number 15: sigaR.Rnw:447-448
###################################################
featureNo <- 240


###################################################
### code chunk number 16: sigaR.Rnw:451-452
###################################################
ids <- getSegFeatures(featureNo, pollackCN16)


###################################################
### code chunk number 17: sigaR.Rnw:455-456
###################################################
Y <- exprs(pollackGE16)[ids,]


###################################################
### code chunk number 18: sigaR.Rnw:459-460
###################################################
Y <- t(Y)


###################################################
### code chunk number 19: sigaR.Rnw:463-464
###################################################
X <- segmented(pollackCN16)[featureNo,]


###################################################
### code chunk number 20: sigaR.Rnw:467-468
###################################################
X <- matrix(as.numeric(X), ncol=1)


###################################################
### code chunk number 21: sigaR.Rnw:473-475
###################################################
Y <- sweep(Y, 2, apply(Y, 2, mean))
R <- matrix(1, ncol=1)


###################################################
### code chunk number 22: sigaR.Rnw:482-483
###################################################
RCMresult <- RCMestimation(Y, X, R)


###################################################
### code chunk number 23: sigaR.Rnw:486-487
###################################################
summary(RCMresult)


###################################################
### code chunk number 24: sigaR.Rnw:491-492
###################################################
RCMresult@betas


###################################################
### code chunk number 25: sigaR.Rnw:496-497
###################################################
RCMresult@tau2s


###################################################
### code chunk number 26: sigaR.Rnw:500-501
###################################################
RCMresult@rho


###################################################
### code chunk number 27: sigaR.Rnw:509-510
###################################################
RCMtestResult <- RCMtest(Y, X, R, testType="II")


###################################################
### code chunk number 28: sigaR.Rnw:513-514
###################################################
summary(RCMtestResult)


###################################################
### code chunk number 29: sigaR.Rnw:522-523
###################################################
op <- par(mfrow = c(1, 1), pty = "m")


###################################################
### code chunk number 30: sigaR.Rnw:525-532
###################################################
GEpred <- numeric()
for (u in 1:1000){
	slope <- rnorm(1, mean=RCMresult@betas[1], sd=sqrt(RCMresult@tau2s[1]))
	slope[slope < 0] <- 0
	GEpred <- rbind(GEpred, as.numeric(slope * X[,1]))
}
verts <- rbind(apply(GEpred, 2, min), apply(GEpred, 2, max))


###################################################
### code chunk number 31: sigaR.Rnw:538-547
###################################################
plot(lm(Y[,1] ~ X[,1])$fitted.values ~ X[,1], type="l", ylim=c(-1.0, 2.2), 
    ylab="gene expression", xlab="DNA copy number")
polygon(x=c(X[order(X[,1]), 1], X[order(X[,1], decreasing = TRUE), 1]), 
    y=c(verts[1, order(X[,1])], verts[2, order(X[,1], decreasing = TRUE)]), 
    col="pink", border="pink")
for (j in 1:ncol(Y)){
	lines(X[,1], lm(Y[,j] ~ X[,1])$fitted.values)
}
lines(X[,1], RCMresult@betas[1] * X[,1], type="l", col="red", lwd=4)


###################################################
### code chunk number 32: sigaR.Rnw:584-586
###################################################
X <- copynumber(pollackCN16)
Y <- exprs(pollackGE16)


###################################################
### code chunk number 33: sigaR.Rnw:589-591
###################################################
Y <- t(Y)
X <- t(X)


###################################################
### code chunk number 34: sigaR.Rnw:594-595
###################################################
hdMI(Y, X, method="knn")


###################################################
### code chunk number 35: sigaR.Rnw:598-600
###################################################
MItestResults <- mutInfTest(Y, X, nPerm=100, method="knn", verbose=FALSE)
summary(MItestResults)


###################################################
### code chunk number 36: sigaR.Rnw:614-617
###################################################
plot(isoreg(hdEntropy(Y, method="knn") ~ hdEntropy(X, method="knn")), 
    lwd=2, pch=20, main="", ylab="marginal transcriptomic entropy", 
    xlab="marginal genomic entropy")


###################################################
### code chunk number 37: sigaR.Rnw:622-623
###################################################
cor(hdEntropy(Y, method="knn"), hdEntropy(X, method="knn"), m="s")


