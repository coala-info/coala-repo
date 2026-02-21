# Code example from 'BicARE' vignette. See references/ for full tutorial.

### R code from vignette source 'BicARE.Rnw'

###################################################
### code chunk number 1: BicARE.Rnw:41-42
###################################################
require(BicARE)


###################################################
### code chunk number 2: BicARE.Rnw:47-49
###################################################
data(sample.bicData)
sample.bicData


###################################################
### code chunk number 3: BicARE.Rnw:55-56
###################################################
residue(sample.bicData)  


###################################################
### code chunk number 4: BicARE.Rnw:64-66
###################################################
set.seed(1)
res.biclustering <- FLOC(sample.bicData, k=15, pGene=0.3, pSample=0.6, r=0.01, 10, 8, 200)


###################################################
### code chunk number 5: BicARE.Rnw:68-69
###################################################
res.biclustering


###################################################
### code chunk number 6: BicARE.Rnw:79-87
###################################################
init.genes <- matrix(data=0, nrow=352, ncol=5)
init.samples <- matrix(data=0, nrow=26, ncol=5)
init.genes[1:10,1] <- 1
init.genes[20:30,2] <- 1
init.genes[50:60,3] <- 1
init.samples[1:5,3] <- 1
init.samples[1:5,4] <- 1
init.samples[10:15,5] <- 1


###################################################
### code chunk number 7: BicARE.Rnw:100-102
###################################################
bic <- bicluster(res.biclustering, 6, graph=FALSE)
plot(bic)


###################################################
### code chunk number 8: BicARE.Rnw:111-113
###################################################
gsc <- GeneSetCollection(res.biclustering$ExpressionSet[1:50], setType=GOCollection())
res.bic2 <- testSet(res.biclustering, gsc)


###################################################
### code chunk number 9: BicARE.Rnw:122-123
###################################################
pData(sample.bicData)


###################################################
### code chunk number 10: BicARE.Rnw:126-127
###################################################
res.bic2 <- testAnnot(res.biclustering, annot=pData(sample.bicData), covariates=c("sex", "type"))


