# Code example from 'phenoTest' vignette. See references/ for full tutorial.

### R code from vignette source 'phenoTest.Rnw'

###################################################
### code chunk number 1: loadLibAndData
###################################################
options(width=100)
library(phenoTest)
data(eset)
eset


###################################################
### code chunk number 2: preprocess
###################################################
Tumor.size <- rnorm(ncol(eset),50,2)
pData(eset) <- cbind(pData(eset),Tumor.size)
pData(eset)[1:20,'lymph.node.status'] <- 'positive'


###################################################
### code chunk number 3: setVars2test
###################################################
head(pData(eset))
survival <- matrix(c("Relapse","Months2Relapse"),ncol=2,byrow=TRUE)
colnames(survival) <- c('event','time')
vars2test <- list(survival=survival,categorical='lymph.node.status',continuous='Tumor.size')
vars2test


###################################################
### code chunk number 4: runExpressionPhenoTest
###################################################
epheno <- ExpressionPhenoTest(eset,vars2test,p.adjust.method='none')
epheno


###################################################
### code chunk number 5: pValueAdjust
###################################################
p.adjust.method(epheno)
epheno <- pAdjust(epheno,method='BH')
p.adjust.method(epheno)


###################################################
### code chunk number 6: ephenoSubsetByName
###################################################
phenoNames(epheno)
epheno[,'Tumor.size']
epheno[,2]


###################################################
### code chunk number 7: ephenoSubsetByClass
###################################################
phenoClass(epheno)
epheno[,phenoClass(epheno)=='survival']


###################################################
### code chunk number 8: ephenoGetMeans
###################################################
head(getMeans(epheno))


###################################################
### code chunk number 9: ephenoGetSummaries
###################################################
head(getSummaryDif(epheno))
head(getFc(epheno))
head(getHr(epheno))


###################################################
### code chunk number 10: ephenoGetSignif
###################################################
head(getSignif(epheno))


###################################################
### code chunk number 11: ephenoGetVars2test
###################################################
getVars2test(epheno)


###################################################
### code chunk number 12: getSignatures
###################################################
set.seed(777)
sign1 <- sample(featureNames(eset))[1:20]
sign2 <- sample(featureNames(eset))[1:50]
mySignature <- list(sign1,sign2)
names(mySignature) <- c('My first signature','Another signature')
mySignature


###################################################
### code chunk number 13: makeGeneSets
###################################################
library(GSEABase)
myGeneSetA <- GeneSet(geneIds=sign1, setName='My first signature')
myGeneSetB <- GeneSet(geneIds=sign2, setName='Another signature')
mySignature <- GeneSetCollection(myGeneSetA,myGeneSetB)
mySignature


###################################################
### code chunk number 14: barplotSignifSignatures
###################################################
barplotSignifSignatures(epheno[,'lymph.node.status'],mySignature,alpha=0.99)


###################################################
### code chunk number 15: barplotSignifSignatures
###################################################
barplotSignifSignatures(epheno[,'lymph.node.status'],mySignature,alpha=0.99)


###################################################
### code chunk number 16: barplotSignatures
###################################################
barplotSignatures(epheno[,'Tumor.size'],mySignature, ylim=c(0,1))


###################################################
### code chunk number 17: barplotSignatures
###################################################
barplotSignatures(epheno[,'Tumor.size'],mySignature, ylim=c(0,1))


###################################################
### code chunk number 18: heatmapPhenoTestHeat
###################################################
pvals <- heatmapPhenoTest(eset,mySignature[[1]],vars2test=vars2test[1],heat.kaplan='heat')


###################################################
### code chunk number 19: heatmapPhenoTestHeatPvals
###################################################
pvals


###################################################
### code chunk number 20: heatmapPhenoTestHeat
###################################################
pvals <- heatmapPhenoTest(eset,mySignature[[1]],vars2test=vars2test[1],heat.kaplan='heat')


###################################################
### code chunk number 21: heatmapPhenoTestKaplan
###################################################
pvals <- heatmapPhenoTest(eset,mySignature[[1]],vars2test=vars2test[1],heat.kaplan='kaplan')


###################################################
### code chunk number 22: heatmapPhenoTestKaplanPvals
###################################################
pvals


###################################################
### code chunk number 23: heatmapPhenoTest2
###################################################
pvals <- heatmapPhenoTest(eset,mySignature[[1]],vars2test=vars2test[1],heat.kaplan='kaplan')


###################################################
### code chunk number 24: gsea
###################################################
my.gsea <- gsea(x=epheno,gsets=mySignature,B=1000,p.adjust='BH')
my.gsea
summary.gseaData(my.gsea)


###################################################
### code chunk number 25: gseaPlot
###################################################
plot.gseaData(my.gsea)


###################################################
### code chunk number 26: plotGseaPrepare
###################################################
my.gsea <- gsea(x=epheno[,'Relapse'],gsets=mySignature[1],B=100,p.adjust='BH')
summary.gseaData(my.gsea)


###################################################
### code chunk number 27: plotGseaEs
###################################################
plot.gseaData(my.gsea,es.nes='es',selGsets='My first signature')  


###################################################
### code chunk number 28: plotGsea
###################################################
plot.gseaData(my.gsea,es.nes='es',selGsets='My first signature')  


###################################################
### code chunk number 29: plotGseaWilcoxPrepare
###################################################
my.gsea <- gsea(x=epheno[,'Relapse'],gsets=mySignature,B=100,test='wilcox',p.adjust='BH')
summary.gseaData(my.gsea)


###################################################
### code chunk number 30: plotGseaWilcox
###################################################
plot.gseaData(my.gsea,selGsets='My first signature')


###################################################
### code chunk number 31: plotGseaWilcox
###################################################
plot.gseaData(my.gsea,selGsets='My first signature')


