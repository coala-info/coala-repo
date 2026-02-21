# Code example from 'geNetClassifier-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'geNetClassifier-vignette.Rnw'

###################################################
### code chunk number 1: geNetClassifier-vignette.Rnw:81-84 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("geNetClassifier")


###################################################
### code chunk number 2: geNetClassifier-vignette.Rnw:90-91 (eval = FALSE)
###################################################
## BiocManager::install("leukemiasEset")


###################################################
### code chunk number 3: geNetClassifier-vignette.Rnw:97-100
###################################################
library(leukemiasEset)
data(leukemiasEset)
leukemiasEset


###################################################
### code chunk number 4: geNetClassifier-vignette.Rnw:102-103
###################################################
summary(leukemiasEset$LeukemiaType) 


###################################################
### code chunk number 5: geNetClassifier-vignette.Rnw:105-106 (eval = FALSE)
###################################################
## pData(leukemiasEset)


###################################################
### code chunk number 6: geNetClassifier-vignette.Rnw:109-110 (eval = FALSE)
###################################################
## ?leukemiasEset


###################################################
### code chunk number 7: geNetClassifier-vignette.Rnw:116-118 (eval = FALSE)
###################################################
## data(geneSymbols)
## head(geneSymbols)


###################################################
### code chunk number 8: geNetClassifier-vignette.Rnw:122-128 (eval = FALSE)
###################################################
## load("genes-human-annotation.R")
## leukEset_protCoding <- leukemiasEset[featureNames(leukemiasEset) 
## %in% rownames(genes.human.Annotation[genes.human.Annotation$biotype 
## %in% "protein_coding",]),]
## dim(leukemiasEset)
## dim(leukEset_protCoding)


###################################################
### code chunk number 9: geNetClassifier-vignette.Rnw:156-157
###################################################
library(geNetClassifier)


###################################################
### code chunk number 10: geNetClassifier-vignette.Rnw:160-164 (eval = FALSE)
###################################################
## # List available vignettes for package geNetClassifier: 
## vignette(package="geNetClassifier")
## # Open vignette named "geNetClassifier-vignette":
## vignette("geNetClassifier-vignette")


###################################################
### code chunk number 11: geNetClassifier-vignette.Rnw:167-168
###################################################
options(width=80)


###################################################
### code chunk number 12: geNetClassifier-vignette.Rnw:170-171
###################################################
objects("package:geNetClassifier")


###################################################
### code chunk number 13: geNetClassifier-vignette.Rnw:173-174 (eval = FALSE)
###################################################
## ?geNetClassifier


###################################################
### code chunk number 14: geNetClassifier-vignette.Rnw:178-180 (eval = FALSE)
###################################################
## library(leukemiasEset)
## data(leukemiasEset)


###################################################
### code chunk number 15: geNetClassifier-vignette.Rnw:184-186
###################################################
trainSamples <- c(1:10, 13:22, 25:34, 37:46, 49:58)
summary(leukemiasEset$LeukemiaType[trainSamples])


###################################################
### code chunk number 16: geNetClassifier-vignette.Rnw:219-220
###################################################
data(leukemiasClassifier) 


###################################################
### code chunk number 17: geNetClassifier-vignette.Rnw:224-227 (eval = FALSE)
###################################################
## leukemiasClassifier <- geNetClassifier(leukEset_protCoding[,trainSamples],
## sampleLabels="LeukemiaType", plotsName="leukemiasClassifier",
## estimateGError=TRUE, geneLabels=geneSymbols)


###################################################
### code chunk number 18: geNetClassifier-vignette.Rnw:233-236 (eval = FALSE)
###################################################
## leukemiasClassifier <- geNetClassifier(eset=leukemiasEset[,trainSamples], 
## sampleLabels="LeukemiaType", plotsName="leukemiasClassifier", 
## skipInteractions=TRUE, maxGenesTrain=20, geneLabels=geneSymbols)


###################################################
### code chunk number 19: geNetClassifier-vignette.Rnw:239-241 (eval = FALSE)
###################################################
## leukemiasClassifier <- geNetClassifier(eset=leukemiasEset[,trainSamples], 
## sampleLabels="LeukemiaType", plotsName="leukemiasClassifier") 


###################################################
### code chunk number 20: geNetClassifier-vignette.Rnw:244-247 (eval = FALSE)
###################################################
## leukemiasClassifier <- geNetClassifier(eset=leukemiasEset[,trainSamples], 
## sampleLabels="LeukemiaType", plotsName="leukemiasClassifier", 
## estimateGError=TRUE)


###################################################
### code chunk number 21: geNetClassifier-vignette.Rnw:260-262 (eval = FALSE)
###################################################
## getwd()
## save(leukemiasClassifier, file="leukemiasClassifier.RData") 


###################################################
### code chunk number 22: geNetClassifier-vignette.Rnw:270-271
###################################################
options(width=50)


###################################################
### code chunk number 23: geNetClassifier-vignette.Rnw:273-274
###################################################
names(leukemiasClassifier)


###################################################
### code chunk number 24: geNetClassifier-vignette.Rnw:276-277
###################################################
options(width=80)


###################################################
### code chunk number 25: geNetClassifier-vignette.Rnw:282-283
###################################################
leukemiasClassifier@call


###################################################
### code chunk number 26: geNetClassifier-vignette.Rnw:301-302
###################################################
leukemiasClassifier


###################################################
### code chunk number 27: geNetClassifier-vignette.Rnw:326-327
###################################################
leukemiasClassifier@genesRanking


###################################################
### code chunk number 28: geNetClassifier-vignette.Rnw:331-332
###################################################
numGenes(leukemiasClassifier@genesRanking)


###################################################
### code chunk number 29: geNetClassifier-vignette.Rnw:336-337
###################################################
subRanking <- getTopRanking(leukemiasClassifier@genesRanking, 10)


###################################################
### code chunk number 30: geNetClassifier-vignette.Rnw:341-342
###################################################
getRanking(subRanking)


###################################################
### code chunk number 31: geNetClassifier-vignette.Rnw:345-346
###################################################
getRanking(subRanking, showGeneID=TRUE)$geneID[,1:4]


###################################################
### code chunk number 32: geNetClassifier-vignette.Rnw:352-353
###################################################
genesDetails(subRanking)$AML


###################################################
### code chunk number 33: geNetClassifier-vignette.Rnw:357-358 (eval = FALSE)
###################################################
## options(width=200)


###################################################
### code chunk number 34: geNetClassifier-vignette.Rnw:386-387
###################################################
numSignificantGenes(leukemiasClassifier@genesRanking)


###################################################
### code chunk number 35: geNetClassifier-vignette.Rnw:391-392 (eval = FALSE)
###################################################
## plot(leukemiasClassifier@genesRanking)


###################################################
### code chunk number 36: geNetClassifier-vignette.Rnw:396-398 (eval = FALSE)
###################################################
## plot(leukemiasClassifier@genesRanking, 
## numGenesPlot=3000, lpThreshold=0.80)


###################################################
### code chunk number 37: geNetClassifier-vignette.Rnw:409-410
###################################################
leukemiasClassifier@classifier


###################################################
### code chunk number 38: geNetClassifier-vignette.Rnw:415-416
###################################################
leukemiasClassifier@classificationGenes


###################################################
### code chunk number 39: geNetClassifier-vignette.Rnw:418-420
###################################################
numGenes(leukemiasClassifier@classificationGenes)
genesDetails(leukemiasClassifier@classificationGenes)$ALL


###################################################
### code chunk number 40: geNetClassifier-vignette.Rnw:479-480
###################################################
leukemiasClassifier@generalizationError


###################################################
### code chunk number 41: geNetClassifier-vignette.Rnw:483-484 (eval = FALSE)
###################################################
## overview(leukemiasClassifier@generalizationError)


###################################################
### code chunk number 42: geNetClassifier-vignette.Rnw:490-491
###################################################
leukemiasClassifier@generalizationError@confMatrix


###################################################
### code chunk number 43: geNetClassifier-vignette.Rnw:495-496
###################################################
leukemiasClassifier@generalizationError@probMatrix


###################################################
### code chunk number 44: geNetClassifier-vignette.Rnw:505-506
###################################################
leukemiasClassifier@generalizationError@classificationGenes.stats$CLL


###################################################
### code chunk number 45: geNetClassifier-vignette.Rnw:511-512
###################################################
leukemiasClassifier@generalizationError@classificationGenes.num


###################################################
### code chunk number 46: geNetClassifier-vignette.Rnw:526-528
###################################################
leukemiasClassifier@genesNetwork
overview(leukemiasClassifier@genesNetwork$AML)


###################################################
### code chunk number 47: geNetClassifier-vignette.Rnw:533-535
###################################################
getNumEdges(leukemiasClassifier@genesNetwork$AML)
getNumNodes(leukemiasClassifier@genesNetwork$AML)


###################################################
### code chunk number 48: geNetClassifier-vignette.Rnw:537-539
###################################################
getEdges(leukemiasClassifier@genesNetwork$AML)[1:5,]
getNodes(leukemiasClassifier@genesNetwork$AML)[1:12]


###################################################
### code chunk number 49: geNetClassifier-vignette.Rnw:543-544 (eval = FALSE)
###################################################
## network2txt(leukemiasClassifier@genesNetwork, filePrefix="leukemiasNetwork")


###################################################
### code chunk number 50: geNetClassifier-vignette.Rnw:547-550 (eval = FALSE)
###################################################
## geneNtwsInfo <- lapply(leukemiasClassifier@genesNetwork, 
##     function(x) write.table(getEdges(x), 
##     file=paste("leukemiaNtw_",getEdges(x)[1,"class1"],".txt",sep="")))


###################################################
### code chunk number 51: geNetClassifier-vignette.Rnw:568-570
###################################################
testSamples <- c(1:60)[-trainSamples]
testSamples


###################################################
### code chunk number 52: geNetClassifier-vignette.Rnw:574-576
###################################################
queryResult <- queryGeNetClassifier(leukemiasClassifier, 
leukemiasEset[,testSamples])


###################################################
### code chunk number 53: geNetClassifier-vignette.Rnw:580-582
###################################################
queryResult$class
queryResult$probabilities


###################################################
### code chunk number 54: geNetClassifier-vignette.Rnw:586-588
###################################################
confusionMatrix <- table(leukemiasEset[,testSamples]$LeukemiaType, 
queryResult$class)


###################################################
### code chunk number 55: geNetClassifier-vignette.Rnw:592-593
###################################################
externalValidation.stats(confusionMatrix)


###################################################
### code chunk number 56: geNetClassifier-vignette.Rnw:597-599
###################################################
externalValidation.probMatrix(queryResult, 
leukemiasEset[,testSamples]$LeukemiaType, numDecimals=3)


###################################################
### code chunk number 57: geNetClassifier-vignette.Rnw:612-615
###################################################
queryResult_AssignAll <- queryGeNetClassifier(leukemiasClassifier, 
    leukemiasEset[,testSamples], minProbAssignCoeff=0, minDiffAssignCoeff=0)
which(queryResult_AssignAll$class=="NotAssigned")


###################################################
### code chunk number 58: geNetClassifier-vignette.Rnw:620-623
###################################################
queryResult_AssignLess <- queryGeNetClassifier(leukemiasClassifier, 
    leukemiasEset[,testSamples], minProbAssignCoeff=1.5, minDiffAssignCoeff=1)
queryResult_AssignLess$class


###################################################
### code chunk number 59: geNetClassifier-vignette.Rnw:627-629
###################################################
t(queryResult_AssignLess$probabilities[,
    queryResult_AssignLess$class=="NotAssigned", drop=FALSE])


###################################################
### code chunk number 60: geNetClassifier-vignette.Rnw:650-651
###################################################
testSamples <- c(1:60)[-trainSamples]


###################################################
### code chunk number 61: geNetClassifier-vignette.Rnw:655-657
###################################################
queryResult_AsUnkown <- queryGeNetClassifier(leukemiasClassifier, 
leukemiasEset[,testSamples])


###################################################
### code chunk number 62: geNetClassifier-vignette.Rnw:661-662
###################################################
names(queryResult_AsUnkown)


###################################################
### code chunk number 63: geNetClassifier-vignette.Rnw:664-665
###################################################
queryResult_AsUnkown$class


###################################################
### code chunk number 64: geNetClassifier-vignette.Rnw:669-671
###################################################
t(queryResult_AsUnkown$probabilities[ ,
queryResult$class=="NotAssigned"])


###################################################
### code chunk number 65: geNetClassifier-vignette.Rnw:675-676
###################################################
querySummary(queryResult_AsUnkown, numDecimals=3)


###################################################
### code chunk number 66: geNetClassifier-vignette.Rnw:687-688 (eval = FALSE)
###################################################
## plot(leukemiasClassifier@genesRanking)


###################################################
### code chunk number 67: geNetClassifier-vignette.Rnw:697-699 (eval = FALSE)
###################################################
## plot(leukemiasClassifier@genesRanking, numGenesPlot=3000, 
## plotTitle="5 classes: ALL, AML, CLL, CML, NoL", lpThreshold=0.80)


###################################################
### code chunk number 68: geNetClassifier-vignette.Rnw:710-712 (eval = FALSE)
###################################################
## ranking <- calculateGenesRanking(leukemiasEset[,trainSamples], 
## "LeukemiaType")


###################################################
### code chunk number 69: geNetClassifier-vignette.Rnw:722-723
###################################################
data(geneSymbols)


###################################################
### code chunk number 70: geNetClassifier-vignette.Rnw:725-731 (eval = FALSE)
###################################################
## data(geneSymbols)
## topGenes <- getRanking(
## getTopRanking(leukemiasClassifier@classificationGenes,numGenesClass=1), 
## showGeneID=TRUE)$geneID
## plotExpressionProfiles(leukemiasEset, topGenes[,c("ALL","AML"), drop=FALSE], 
##     sampleLabels="LeukemiaType", geneLabels=geneSymbols)


###################################################
### code chunk number 71: geNetClassifier-vignette.Rnw:742-744 (eval = FALSE)
###################################################
## plotExpressionProfiles(leukemiasEset[,trainSamples], leukemiasClassifier,
##     sampleLabels="LeukemiaType", fileName="leukExprs_trainSamples.pdf")


###################################################
### code chunk number 72: geNetClassifier-vignette.Rnw:748-752 (eval = FALSE)
###################################################
## classGenes <- getRanking(leukemiasClassifier@classificationGenes, 
##     showGeneID=TRUE)$geneID[,"AML"]
## plotExpressionProfiles(leukemiasEset, genes=classGenes, 
##     sampleLabels="LeukemiaType", geneLabels=geneSymbols, fileName="AML_genes.pdf")


###################################################
### code chunk number 73: geNetClassifier-vignette.Rnw:760-765 (eval = FALSE)
###################################################
## plotExpressionProfiles(leukemiasEset, genes=topGenes[,3, drop=FALSE], 
##                        sampleLabels="LeukemiaType", 
##                        showMean=TRUE, identify=FALSE,
##                        sampleColors=c("grey","red")
##                        [(sampleNames(leukemiasEset)%in% c("GSM331386.CEL","GSM331392.CEL"))+1])


###################################################
### code chunk number 74: geNetClassifier-vignette.Rnw:767-771 (eval = FALSE)
###################################################
## plotExpressionProfiles(leukemiasEset, genes=topGenes[,3, drop=FALSE], 
##                        sampleLabels="LeukemiaType", 
##                        showMean=TRUE, identify=FALSE,
##                        classColors=c("red","red", "blue","red","red"))


###################################################
### code chunk number 75: geNetClassifier-vignette.Rnw:778-781 (eval = FALSE)
###################################################
## plotExpressionProfiles(leukemiasEset, genes=topGenes[,3, drop=FALSE],
##                        sampleLabels="LeukemiaType", 
##                        type="boxplot", geneLabels=geneSymbols, sameScale=FALSE)


###################################################
### code chunk number 76: geNetClassifier-vignette.Rnw:801-803
###################################################
plotDiscriminantPower(leukemiasClassifier, 
classificationGenes="ENSG00000169575")


###################################################
### code chunk number 77: geNetClassifier-vignette.Rnw:807-809
###################################################
plotDiscriminantPower(leukemiasClassifier, 
classificationGenes="ENSG00000169575")


###################################################
### code chunk number 78: geNetClassifier-vignette.Rnw:817-820 (eval = FALSE)
###################################################
## discPowerTable <- plotDiscriminantPower(leukemiasClassifier, 
## classificationGenes=getRanking(leukemiasClassifier@classificationGenes,
## showGeneID=TRUE)$geneID[1:4,"AML",drop=FALSE], returnTable=TRUE)


###################################################
### code chunk number 79: geNetClassifier-vignette.Rnw:824-827
###################################################
discPowerTable <- plotDiscriminantPower(leukemiasClassifier, 
classificationGenes=getRanking(leukemiasClassifier@classificationGenes,
showGeneID=TRUE)$geneID[1:4,"AML",drop=FALSE], returnTable=TRUE)


###################################################
### code chunk number 80: geNetClassifier-vignette.Rnw:844-846
###################################################
clGenesSubNet <- getSubNetwork(leukemiasClassifier@genesNetwork, 
leukemiasClassifier@classificationGenes)


###################################################
### code chunk number 81: geNetClassifier-vignette.Rnw:857-858 (eval = FALSE)
###################################################
## clGenesInfo <- genesDetails(leukemiasClassifier@classificationGenes)


###################################################
### code chunk number 82: geNetClassifier-vignette.Rnw:868-869 (eval = FALSE)
###################################################
## plotNetwork(genesNetwork=clGenesSubNet$ALL, genesInfo=clGenesInfo)


###################################################
### code chunk number 83: geNetClassifier-vignette.Rnw:881-883 (eval = FALSE)
###################################################
## plotNetwork(genesNetwork=clGenesSubNet$ALL, genesInfo=clGenesInfo, 
## plotAllNodesNetwork=FALSE, plotOnlyConnectedNodesNetwork=TRUE)


###################################################
### code chunk number 84: geNetClassifier-vignette.Rnw:887-893 (eval = FALSE)
###################################################
## top30g <- getRanking(leukemiasClassifier@genesRanking, 
## showGeneID=TRUE)$geneID[1:30,]
## top30gSubNet <- getSubNetwork(leukemiasClassifier@genesNetwork, top30g)
## top30gInfo <- lapply(genesDetails(leukemiasClassifier@genesRanking), 
## function(x) x[1:30,])
## plotNetwork(genesNetwork=top30gSubNet$AML, genesInfo=top30gInfo$AML)


###################################################
### code chunk number 85: geNetClassifier-vignette.Rnw:906-915 (eval = FALSE)
###################################################
## top100gRanking <- getTopRanking(leukemiasClassifier@genesRanking, 
## numGenes=100)
## top100gSubNet <- getSubNetwork(leukemiasClassifier@genesNetwork, 
## getRanking(top100gRanking, showGeneID=TRUE)$geneID)
## plotNetwork(genesNetwork=top100gSubNet, 
## classificationGenes=leukemiasClassifier@classificationGenes, 
## genesRanking=top100gRanking, plotAllNodesNetwork=TRUE, 
## plotOnlyConnectedNodesNetwork=TRUE, labelSize=0.4, 
## plotType="pdf", fileName="leukemiasNetwork")


