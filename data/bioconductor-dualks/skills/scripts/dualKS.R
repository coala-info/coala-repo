# Code example from 'dualKS' vignette. See references/ for full tutorial.

### R code from vignette source 'dualKS.rnw'

###################################################
### code chunk number 1: dualKS.rnw:98-99
###################################################
options(width=70, scipen=999)


###################################################
### code chunk number 2: dualKS.rnw:102-105
###################################################
library("dualKS")
data("dks")
pData(eset)


###################################################
### code chunk number 3: dualKS.rnw:119-120
###################################################
	tr <- dksTrain(eset, class=1, type="up")


###################################################
### code chunk number 4: dualKS.rnw:132-133
###################################################
	cl <- dksSelectGenes(tr, n=100)


###################################################
### code chunk number 5: dualKS.rnw:141-144
###################################################
	pr <- dksClassify(eset, cl)
	summary(pr, actual=pData(eset)[,1])
	show(pr)


###################################################
### code chunk number 6: dualKS.rnw:167-168 (eval = FALSE)
###################################################
## plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 7: dualKS.rnw:173-174
###################################################
plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 8: dualKS.rnw:212-214
###################################################
	pr <- dksClassify(eset, cl, rescale=TRUE)
	summary(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 9: dualKS.rnw:219-220 (eval = FALSE)
###################################################
## 	plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 10: dualKS.rnw:225-226
###################################################
	plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 11: dualKS.rnw:243-251 (eval = FALSE)
###################################################
## 
## sc <- KS(exprs(eset)[,1], cl@genes.up)
## plot(sc$runningSums[,1], type='l', ylab="KS sum", ylim=c(-1200,1200), col="red")
## par(new=TRUE)
## plot(sc$runningSums[,2], type='l', ylab="KS sum", ylim=c(-1200,1200), col="green")
## par(new=TRUE)
## plot(sc$runningSums[,3], type='l', ylab="KS sum", ylim=c(-1200,1200), col="blue")
## legend("topright", col=c("red", "green", "blue"), lwd=2, legend=colnames(sc$runningSums))


###################################################
### code chunk number 12: dualKS.rnw:260-267
###################################################
sc <- KS(exprs(eset)[,1], cl@genes.up)
plot(sc$runningSums[,1], type='l', ylab="KS sum", ylim=c(-1200,1200), col="red")
par(new=TRUE)
plot(sc$runningSums[,2], type='l', ylab="KS sum", ylim=c(-1200,1200), col="green")
par(new=TRUE)
plot(sc$runningSums[,3], type='l', ylab="KS sum", ylim=c(-1200,1200), col="blue")
legend("topright", col=c("red", "green", "blue"), lwd=2, legend=colnames(sc$runningSums))


###################################################
### code chunk number 13: dualKS.rnw:310-314 (eval = FALSE)
###################################################
## tr <- dksTrain(exprs(eset), class=pData(eset)[,1], type="up", weights=TRUE)
## cl <- dksSelectGenes(tr, n=100)
## pr <- dksClassify(exprs(eset), cl)
## plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 14: dualKS.rnw:323-327
###################################################
tr <- dksTrain(exprs(eset), class=pData(eset)[,1], type="up", weights=TRUE)
cl <- dksSelectGenes(tr, n=100)
pr <- dksClassify(exprs(eset), cl)
plot(pr, actual=pData(eset)[,1])


###################################################
### code chunk number 15: dualKS.rnw:348-349 (eval = FALSE)
###################################################
## wt <- dksWeights(eset, class=1)


###################################################
### code chunk number 16: dualKS.rnw:355-356 (eval = FALSE)
###################################################
## tr <- dksTrain(exprs(eset), class=1, weights=wt)


###################################################
### code chunk number 17: dualKS.rnw:392-397 (eval = FALSE)
###################################################
## 
## ix.n <- which(pData(eset)[,1] == "normal")
## data <- exprs(eset)
## data.m <- apply(data[,ix.n], 1, mean, na.rm=TRUE)
## 


###################################################
### code chunk number 18: dualKS.rnw:403-405 (eval = FALSE)
###################################################
## data <- data[,-ix.n]
## data.r <- sweep(data, 1, data.m, "/")


###################################################
### code chunk number 19: dualKS.rnw:411-416 (eval = FALSE)
###################################################
## data.r <- log(data.r, 2)
## tr <- dksTrain(data.r, class=pData(eset)[-ix.n,1], type="both")
## cl <- dksSelectGenes(tr, n=100)
## pr <- dksClassify(data.r, cl)
## plot(pr, actual=pData(eset)[-ix.n,1])


###################################################
### code chunk number 20: dualKS.rnw:421-432
###################################################
ix.n <- which(pData(eset)[,1] == "normal")
data <- exprs(eset)
data.m <- apply(data[,ix.n], 1, mean, na.rm=TRUE)
data <- data[,-ix.n]
data.r <- sweep(data, 1, data.m, "/")
data.r <- log(data.r, 2)

tr <- dksTrain(data.r, class=pData(eset)[-ix.n,1], type="both")
cl <- dksSelectGenes(tr, n=100)
pr <- dksClassify(data.r, cl)
plot(pr, actual=pData(eset)[-ix.n,1])


###################################################
### code chunk number 21: dualKS.rnw:440-442
###################################################
summary(pr, actual=pData(eset)[-ix.n,1])
show(pr)


###################################################
### code chunk number 22: dualKS.rnw:468-469
###################################################
pvalue.f <- pv.f


###################################################
### code chunk number 23: dualKS.rnw:472-473
###################################################
pvalue.f <- dksPerm(eset, 1, type="both", samples=500)


###################################################
### code chunk number 24: dualKS.rnw:482-483
###################################################
pvalue.f(pr@predictedScore)


###################################################
### code chunk number 25: dualKS.rnw:516-520 (eval = FALSE)
###################################################
## cls <- factor(sample(pData(eset)[,1], 300, replace=TRUE))
## sig.up <- sample(rownames(exprs(eset), 300))
## classifier <- dksCustomClass(upgenes=sig.up, upclass=cls)
## pr.cust <- dksClassify(eset, classifier)


###################################################
### code chunk number 26: dualKS.rnw:535-537
###################################################
results <- data.frame(pr@predictedClass, pr@scoreMatrix)
results


