# Code example from 'ArrayTools' vignette. See references/ for full tutorial.

### R code from vignette source 'ArrayTools.Rnw'

###################################################
### code chunk number 1: ArrayTools.Rnw:60-66
###################################################
library(ArrayTools)
data(exprsExample)
head(exprsExample)
dim(exprsExample)
data(pDataExample)
pDataExample


###################################################
### code chunk number 2: ArrayTools.Rnw:75-78
###################################################
rownames(exprsExample) <- exprsExample$probeset_id
eSet <- createExpressionSet (pData=pDataExample,  exprs = exprsExample, annotation = "hugene10sttranscriptcluster")
dim(eSet)


###################################################
### code chunk number 3: ArrayTools.Rnw:95-98
###################################################
normal <- preProcessGeneST (eSet, output=TRUE)
normal
dim(normal)


###################################################
### code chunk number 4: ArrayTools.Rnw:115-117
###################################################
data(QC)
qaGeneST(normal, c("Treatment", "Group"), QC)


###################################################
### code chunk number 5: ArrayTools.Rnw:134-135
###################################################
filtered <- geneFilter(normal, numChip = 2, bg = 4, iqrPct=0.1,  output=TRUE)


###################################################
### code chunk number 6: ArrayTools.Rnw:149-151
###################################################
design1<- new("designMatrix", target=pData(filtered), covariates = "Treatment")
design1


###################################################
### code chunk number 7: ArrayTools.Rnw:156-158
###################################################
design2<- new("designMatrix", target=pData(filtered), covariates = c("Treatment", "Group"))
design2


###################################################
### code chunk number 8: ArrayTools.Rnw:166-168
###################################################
contrast1 <- new("contrastMatrix", design.matrix = design1,  compare1 = "Treated", compare2 = "Control")
contrast1


###################################################
### code chunk number 9: ArrayTools.Rnw:174-176
###################################################
contrast2 <- new("contrastMatrix", design.matrix = design2, compare1 = "Treated", compare2 = "Control")
contrast2


###################################################
### code chunk number 10: ArrayTools.Rnw:184-186
###################################################
result1 <- regress(filtered, contrast1)
result2 <- regress(filtered, contrast2)


###################################################
### code chunk number 11: ArrayTools.Rnw:195-197
###################################################
sigResult1 <- selectSigGene(result1, p.value=0.05, fc.value=log2(1.5))
sigResult2 <- selectSigGene(result2, p.value=0.05, fc.value=log2(1.5))


###################################################
### code chunk number 12: ArrayTools.Rnw:205-207
###################################################
Sort(sigResult1, sorted.by = 'pValue')
Sort(sigResult2, sorted.by = 'F')


###################################################
### code chunk number 13: ArrayTools.Rnw:215-217
###################################################
Output2HTML(sigResult1)
Output2HTML(sigResult2)


###################################################
### code chunk number 14: ArrayTools.Rnw:229-233
###################################################
designInt <- new("designMatrix", target=pData(filtered), covariates = c("Treatment", "Group"), intIndex=c(1,2))
designInt
contrastInt <- new("contrastMatrix", design.matrix = designInt, interaction = TRUE)
contrastInt


###################################################
### code chunk number 15: ArrayTools.Rnw:239-241
###################################################
resultInt <- regress(filtered, contrastInt)
sigResultInt <-selectSigGene(resultInt, p.value=0.05, fc.value=log2(1.5))


###################################################
### code chunk number 16: ArrayTools.Rnw:257-259
###################################################
intResult <- postInteraction(filtered, sigResultInt, mainVar ="Treatment",  compare1 = "Treated",  compare2 = "Control")
sigResultInt <- selectSigGeneInt(intResult, pGroup = 0.05, pMain = 0.05)


###################################################
### code chunk number 17: ArrayTools.Rnw:266-267
###################################################
Output2HTML(sigResultInt)


###################################################
### code chunk number 18: ArrayTools.Rnw:275-276
###################################################
createIndex (sigResult1, sigResult2, intResult)


