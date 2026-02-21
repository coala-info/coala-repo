# Code example from 'PROMISE' vignette. See references/ for full tutorial.

### R code from vignette source 'PROMISE.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: Load PROMISE package and data
###################################################
library(PROMISE)
data(sampExprSet)
data(sampGeneSet)
data(phPatt)


###################################################
### code chunk number 3: Extract ArrayData and Endpoint Data from sampExprSet
###################################################
arrayData<-exprs(sampExprSet)
ptData<- pData(phenoData(sampExprSet))
head(arrayData[, 1:4])
head(ptData)
all(colnames(arrayData)==rownames(ptData))


###################################################
### code chunk number 4: Extract sampGeneSet to a data frame
###################################################
GS.data<-NULL
for (i in 1:length(sampGeneSet)){
    tt<-sampGeneSet[i][[1]]
    this.name<-unlist(geneIds(tt))
    this.set<-setName(tt)
    this.data<- cbind.data.frame(featureID=as.character(this.name),
             setID=rep(as.character(this.set), length(this.name)))
    GS.data<-rbind.data.frame(GS.data, this.data)
}
sum(!is.element(GS.data[,1], rownames(arrayData)))==0


###################################################
### code chunk number 5: Display phPatt
###################################################
phPatt


###################################################
### code chunk number 6: PROMISE without GSEA
###################################################
test1 <- PROMISE(exprSet=sampExprSet,
                 geneSet=NULL, 
                 promise.pattern=phPatt, 
                 strat.var=NULL,
                 proj0=FALSE,
                 nbperm=FALSE, 
                 max.ntail=10,
                 seed=13, 
                 nperms=100)


###################################################
### code chunk number 7: Gene Level Result
###################################################
gene.res<-test1$generes
head(gene.res)


###################################################
### code chunk number 8: Gene Set Result
###################################################
set.res<-test1$setres
head(set.res)


###################################################
### code chunk number 9: PROMISE with GSEA
###################################################
test2 <- PROMISE(exprSet=sampExprSet,
                 geneSet=sampGeneSet, 
                 promise.pattern=phPatt, 
                 strat.var=NULL,
                 proj0=FALSE,
                 nbperm=TRUE,
                 max.ntail=10,
                 seed=13, 
                 nperms=100)


###################################################
### code chunk number 10: Gene Level Result
###################################################
gene.res2<-test2$generes
head(gene.res2)


###################################################
### code chunk number 11: Gene Set Result
###################################################
set.res2<-test2$setres
head(set.res2)


###################################################
### code chunk number 12: PROMISE with GSEA
###################################################
test3 <- PROMISE(exprSet=sampExprSet,
                 geneSet=sampGeneSet, 
                 promise.pattern=phPatt, 
                 strat.var=NULL,
                 proj0=TRUE,
                 nbperm=TRUE,
                 max.ntail=10,
                 seed=13, 
                 nperms=100)


###################################################
### code chunk number 13: Gene Level Result
###################################################
gene.res3<-test3$generes
head(gene.res3)


###################################################
### code chunk number 14: Gene Set Result
###################################################
set.res3<-test3$setres
head(set.res3)


