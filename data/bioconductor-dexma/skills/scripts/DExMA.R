# Code example from 'DExMA' vignette. See references/ for full tutorial.

### R code from vignette source 'DExMA.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: DExMA.Rnw:50-52
###################################################
library(DExMA)
data("DExMAExampleData")


###################################################
### code chunk number 3: DExMA.Rnw:82-90
###################################################
#List of expression matrices
data("DExMAExampleData")
ls(listMatrixEX)
head(listMatrixEX$Study1)

#List of ExpressionSets
ls(listExpressionSets)
listExpressionSets$Study1


###################################################
### code chunk number 4: DExMA.Rnw:95-99
###################################################
data("DExMAExampleData")
#Example of a phenodata object
ls(listPhenodatas)
listPhenodatas$Study1


###################################################
### code chunk number 5: DExMA.Rnw:114-115
###################################################
listPhenodatas$Study1


###################################################
### code chunk number 6: DExMA.Rnw:121-122
###################################################
listPhenodatas$Study2


###################################################
### code chunk number 7: DExMA.Rnw:127-128
###################################################
listPhenodatas$Study3


###################################################
### code chunk number 8: DExMA.Rnw:135-136
###################################################
listPhenodatas$Study4


###################################################
### code chunk number 9: DExMA.Rnw:143-148
###################################################
phenoGroups = c("condition", "condition", "state", "state")
phenoCases = list(Study1 = "Diseased", Study2 = c("Diseased", "ill"),
                    Study3 = "Diseased", Study4 = "ill")
phenoControls = list(Study1 = "Healthy", Study2 = c("Healthy", "control"),
                    Study3 = "Healthy", Study4 = "control")


###################################################
### code chunk number 10: DExMA.Rnw:153-164
###################################################
newObjectMA <- createObjectMA(listEX=listMatrixEX,
                                listPheno = listPhenodatas,
                                namePheno=phenoGroups,
                                expGroups=phenoCases, 
                                refGroups = phenoControls)
#Study 1
head(newObjectMA[[1]][[1]])
newObjectMA[[1]][[2]]
#Study 2
head(newObjectMA[[2]][[1]])
newObjectMA[[2]][[2]]


###################################################
### code chunk number 11: DExMA.Rnw:186-190
###################################################
data("DExMAExampleData")
ExpressionSetStudy5
library(Biobase)
pData(ExpressionSetStudy5)


###################################################
### code chunk number 12: DExMA.Rnw:195-201
###################################################
newElem <-elementObjectMA(expressionMatrix = ExpressionSetStudy5,
                            groupPheno = "condition",
                            expGroup = c("Diseased", "ill"),
                            refGroup = c("Healthy", "control"))
head(newElem[[1]])
head(newElem[[2]])


###################################################
### code chunk number 13: DExMA.Rnw:208-212
###################################################
newObjectMA2 <- newObjectMA
newObjectMA2[[5]] <- newElem
head(newObjectMA2[[5]][[1]])
newObjectMA2[[5]][[2]]


###################################################
### code chunk number 14: DExMA.Rnw:252-256
###################################################
rownames(newObjectMA$Study1$mExpres)[1:20]
rownames(newObjectMA$Study2$mExpres)[1:20]
rownames(newObjectMA$Study3$mExpres)[1:20]
rownames(newObjectMA$Study4$mExpres)[1:20]


###################################################
### code chunk number 15: DExMA.Rnw:262-264
###################################################
head(avaliableIDs)
avaliableOrganism


###################################################
### code chunk number 16: DExMA.Rnw:271-276
###################################################
newObjectMA <- allSameID(newObjectMA, finalID="GeneSymbol", organism = "Homo sapiens")
rownames(newObjectMA$Study1$mExpres)[1:20]
rownames(newObjectMA$Study2$mExpres)[1:20]
rownames(newObjectMA$Study3$mExpres)[1:20]
rownames(newObjectMA$Study4$mExpres)[1:20]


###################################################
### code chunk number 17: DExMA.Rnw:286-288
###################################################
newObjectMA <- dataLog(newObjectMA)
head(newObjectMA[[1]][[1]])


###################################################
### code chunk number 18: DExMA.Rnw:302-303
###################################################
heterogeneityTest(newObjectMA)


###################################################
### code chunk number 19: DExMA.Rnw:312-316
###################################################
nrow(newObjectMA$Study1[[1]])
nrow(newObjectMA$Study2[[1]])
imputation <- missGenesImput(maObject, k =7)
maObject_imput <- imputation$objectMA


###################################################
### code chunk number 20: DExMA.Rnw:321-323
###################################################
nrow(maObject_imput$Study1[[1]])
nrow(maObject_imput$Study2[[1]])


###################################################
### code chunk number 21: DExMA.Rnw:335-339
###################################################
head(imputation$imputIndicators$imputValuesSample)
head(imputation$imputIndicators$imputPercentageSample)
head(imputation$imputIndicators$imputValuesGene)
head(imputation$imputIndicators$imputPercentageGene)


###################################################
### code chunk number 22: DExMA.Rnw:370-372
###################################################
resultsMA <- metaAnalysisDE(newObjectMA, typeMethod="REM",
                            missAllow=0.3, proportionData=0.50)


###################################################
### code chunk number 23: DExMA.Rnw:377-378
###################################################
head(resultsMA)


###################################################
### code chunk number 24: DExMA.Rnw:383-385
###################################################
resultsMA_imput <- metaAnalysisDE(maObject_imput, typeMethod="REM",)
head(resultsMA_imput)


###################################################
### code chunk number 25: DExMA.Rnw:406-408
###################################################
resultsES <- metaAnalysisDE(newObjectMA, typeMethod="REM", proportionData=0.5)
head(resultsES)


###################################################
### code chunk number 26: DExMA.Rnw:424-426
###################################################
resultsPV <- metaAnalysisDE(newObjectMA, typeMethod="maxP", proportionData=0.5)
head(resultsPV)


###################################################
### code chunk number 27: DExMA.Rnw:451-454
###################################################
makeHeatmap(objectMA=newObjectMA, resMA=resultsMA, scaling = "zscor", 
            regulation = "all", numSig=40,
            fdrSig = 0.05, logFCSig = 1.5, show_rownames = TRUE)


###################################################
### code chunk number 28: DExMA.Rnw:468-470 (eval = FALSE)
###################################################
## GEOobjects<- c("GSE4588", "GSE10325")
## dataGEO<-downloadGEOData(GEOobjects)


###################################################
### code chunk number 29: DExMA.Rnw:487-494
###################################################
library(swamp)
pheno <- listPhenodatas$Study2
pheno <- pheno[,apply(pheno,2,function(x) length(table(x)))>1]
# Character variables must be converted in numeric
pheno <- data.frame(apply(pheno, 2, factor), stringsAsFactors = TRUE) 
res_prince <- prince(listMatrixEX$Study2, pheno,top=ncol(listMatrixEX$Study2))
prince.plot(res_prince,note=TRUE , notecex=0.5)


###################################################
### code chunk number 30: DExMA.Rnw:499-503
###################################################
listMatrixEX$Study2 <- batchRemove(listMatrixEX$Study2, listPhenodatas$Study2, 
                                    formula=~gender+race, 
                                    mainCov = "race", nameGroup="condition")
head(listMatrixEX$Study2)


###################################################
### code chunk number 31: DExMA.Rnw:511-515
###################################################
effects <- calculateES(newObjectMA)
head(effects$ES)
head(effects$Var)
head(effects$logFC)


###################################################
### code chunk number 32: DExMA.Rnw:522-525
###################################################
pvalues <- pvalueIndAnalysis(newObjectMA)
head(pvalues$p)
head(pvalues$logFC)


###################################################
### code chunk number 33: DExMA.Rnw:530-531
###################################################
sessionInfo()


