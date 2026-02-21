# Code example from 'ABSSeq' vignette. See references/ for full tutorial.

### R code from vignette source 'ABSSeq.Rnw'

###################################################
### code chunk number 1: ABSSeq.Rnw:27-28
###################################################
library(ABSSeq)


###################################################
### code chunk number 2: ABSSeq.Rnw:33-35
###################################################
data(simuN5)
names(simuN5)


###################################################
### code chunk number 3: ABSSeq.Rnw:40-41
###################################################
simuN5$groups


###################################################
### code chunk number 4: ABSSeq.Rnw:46-48
###################################################
obj <- ABSDataSet(simuN5$counts, factor(simuN5$groups))
pairedobj <- ABSDataSet(simuN5$counts, factor(simuN5$groups),paired=TRUE)


###################################################
### code chunk number 5: ABSSeq.Rnw:53-58
###################################################
obj1 <- ABSDataSet(simuN5$counts, factor(simuN5$groups),
                   normMethod="user",sizeFactor=runif(10,1,2))
normMethod(obj1)
normMethod(obj1) <- "geometric"
normMethod(obj1)


###################################################
### code chunk number 6: ABSSeq.Rnw:63-65
###################################################
  obj <- normalFactors(obj)
  sFactors(obj)


###################################################
### code chunk number 7: ABSSeq.Rnw:70-71
###################################################
  head(counts(obj,norm=TRUE))


###################################################
### code chunk number 8: ABSSeq.Rnw:76-77
###################################################
  obj=callParameter(obj)


###################################################
### code chunk number 9: plotDifftoBase
###################################################
obj <- callDEs(obj)
plotDifftoBase(obj)


###################################################
### code chunk number 10: plotDifftoBase
###################################################
obj <- callDEs(obj)
plotDifftoBase(obj)


###################################################
### code chunk number 11: ABSSeq.Rnw:99-101
###################################################
obj <- callDEs(obj)
head(results(obj,c("rawFC","lowFC","foldChange","pvalue","adj.pvalue")))


###################################################
### code chunk number 12: ABSSeq.Rnw:106-107
###################################################
head(results(obj))


###################################################
### code chunk number 13: ABSSeq.Rnw:112-117
###################################################
data(simuN5)
obj <- ABSDataSet(simuN5$counts, factor(simuN5$groups))
obj <- ABSSeq(obj)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
head(res)


###################################################
### code chunk number 14: ABSSeq.Rnw:122-130
###################################################
data(simuN5)
obj <- ABSDataSet(simuN5$counts, factor(simuN5$groups),minRates=0.2, maxRates=0.2)
#or by slot functions
#minRates(obj) <- 0.2
#maxRates(obj) <- 0.2
obj <- ABSSeq(obj)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
head(res)


###################################################
### code chunk number 15: ABSSeq.Rnw:134-141
###################################################
data(simuN5)
obj <- ABSDataSet(simuN5$counts, factor(simuN5$groups),minDispersion=0.1)
#or by slot functions
#minimalDispersion(obj) <- 0.2
obj <- ABSSeq(obj)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
head(res)


###################################################
### code chunk number 16: ABSSeq.Rnw:146-151
###################################################
data(simuN5)
obj <- ABSDataSet(simuN5$counts[,c(1,2)], factor(c(1,2)))
obj <- ABSSeq(obj)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
head(res)


###################################################
### code chunk number 17: ABSSeq.Rnw:158-163
###################################################
data(simuN5)
obj <- ABSDataSet(counts=simuN5$counts, groups=factor(simuN5$groups))
obj <- ABSSeq(obj, useaFold=TRUE)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
head(res)


###################################################
### code chunk number 18: ABSSeq.Rnw:170-192
###################################################
data(simuN5)
obj <- ABSDataSet(counts=simuN5$counts)
##as one group
cond <- as.factor(rep("hex",ncol(simuN5$counts)))
##normalization
cda <- counts(obj,T)
##variance stabilization
sds <- genAFold(cda,cond)
##sds is list vector, which contains variance stabilized read counts in 3rd element
##or expression level adjusted counts in 4th element. 3rd element is more sensitive
##to difference between samples than the 4th one. Here we use the 4th element for a
##PCA analysis.
## log transformation
ldat <- log2(sds[[4]])
## PCA analysis
PCA <- prcomp(t(ldat), scale = F)
## Percentage of components
percentVar <- round(100*PCA$sdev^2/sum(PCA$sdev^2),1)
## ploting
pc1=PCA$x[,1]
pc2=PCA$x[,2]
#plot(pc1,pc2,main="",pch=16,col="black",xlab="PC1",ylab="PC2",cex=1.2)


###################################################
### code chunk number 19: ABSSeq.Rnw:199-205
###################################################
data(simuN5)
groups<-factor(simuN5$groups)
obj <- ABSDataSet(counts=simuN5$counts)
design <- model.matrix(~0+groups)
res <- ABSSeqlm(obj,design,condA=c("groups0"),condB=c("groups1"))
head(res)


###################################################
### code chunk number 20: ABSSeq.Rnw:210-212
###################################################
res <- ABSSeqlm(obj,design,condA=c("groups0","groups1"))
head(res)


###################################################
### code chunk number 21: ABSSeq.Rnw:217-219
###################################################
res <- ABSSeqlm(obj,design,condA=c("groups0"),condB=c("groups1"),lmodel=FALSE)
head(res)


