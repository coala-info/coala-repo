# Code example from 'a4vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'a4vignette.Rnw'

###################################################
### code chunk number 1: config
###################################################
options(width = 50)
options(continue=" ")
options(prompt="R> ")
set.seed(123)


###################################################
### code chunk number 2: loadPackage
###################################################
library(a4)
require(ALL)
data(ALL, package = "ALL")


###################################################
### code chunk number 3: prepareSimulatedData
###################################################
require(nlcv)
esSim <- simulateData(nEffectRows=50, betweenClassDifference = 5, 
	nNoEffectCols = 5, withinClassSd = 0.2)


###################################################
### code chunk number 4: prepareALL
###################################################
library("hgu95av2.db")
ALL <- addGeneInfo(ALL)


###################################################
### code chunk number 5: showALL (eval = FALSE)
###################################################
## # The phenotypic data
## head(pData(ALL)[, c(1:5, 13, 18, 21)])
## # The gene expression data
## head(exprs(ALL)[, 1:5])
## # The feature data
## fDat <- head(pData(featureData(ALL)))
## fDat[,"Description"] <- substr(fDat[,"Description"], 1, 30)
## fDat


###################################################
### code chunk number 6: CreatebcrAblOrNeg
###################################################
Bcell <- grep("^B", as.character(ALL$BT))  # create B-Cell subset for ALL

subsetType <- "BCR/ABL"  # other subsetType can be "ALL/AF4"
bcrAblOrNegIdx <- which(as.character(ALL$mol) %in% c("NEG", subsetType))
bcrAblOrNeg <- ALL[, intersect(Bcell, bcrAblOrNegIdx)]
bcrAblOrNeg$mol.biol <- factor(bcrAblOrNeg$mol.biol)


###################################################
### code chunk number 7: spectralMapALL
###################################################
spectralMap(object = ALL, groups = "BT")
  
  # optional argument settings
  #    plot.mpm.args=list(label.tol = 12, zoom = c(1,2), do.smoothScatter = TRUE),
  #    probe2gene = TRUE)


###################################################
### code chunk number 8: spectralMapALLSubset
###################################################
spectralMap(object = bcrAblOrNeg, groups = "mol.biol", probe2gene = TRUE)


###################################################
### code chunk number 9: filtering
###################################################
selBcrAblOrNeg <- filterVarInt(object = bcrAblOrNeg)
propSelGenes <- round((dim(selBcrAblOrNeg)[1]/dim(bcrAblOrNeg)[1])*100,1)


###################################################
### code chunk number 10: tTest
###################################################
tTestResult <- tTest(selBcrAblOrNeg, "mol.biol")


###################################################
### code chunk number 11: tTestHist
###################################################
histPvalue(tTestResult[,"p"], addLegend = TRUE)
propDEgenesRes <- propDEgenes(tTestResult[,"p"])


###################################################
### code chunk number 12: tabTTest
###################################################
tabTTest <- topTable(tTestResult, n = 10)
print(xtable(tabTTest,
    caption="The top 5 features selected by an ordinary t-test.",
  label ="tablassoClass"))


###################################################
### code chunk number 13: tTestVolcanoPlot
###################################################
volcanoPlot(tTestResult, topPValues = 5, topLogRatios = 5)


###################################################
### code chunk number 14: limmaTwoLevels
###################################################
limmaResult <- limmaTwoLevels(selBcrAblOrNeg, "mol.biol")
volcanoPlot(limmaResult)
# histPvalue(limmaResult)
# propDEgenes(limmaResult)


###################################################
### code chunk number 15: limma
###################################################
tabLimma <- topTable(limmaResult, n = 10, coef = 2) # 1st is (Intercept)


###################################################
### code chunk number 16: annotationTableLimma
###################################################
  tabLimmaSel <- tabLimma[,c("SYMBOL", "logFC", "AveExpr","P.Value","adj.P.Val", "GENENAME" )]
  tabLimmaSel[, "GENENAME"] <- substr(tabLimmaSel[,"GENENAME"], 1, 38)
  dData <- data.frame(Gene = tabLimmaSel[, 1], tabLimmaSel[,-1],
      stringsAsFactors = FALSE,  row.names = NULL)
  hData <- data.frame(Gene = generateEntrezIdLinks(tabLimma[,"ENTREZID"]))
  tabAnnot <- annotationTable(displayData = dData, hrefData = hData)
  xTabAnnot <- a4Reporting::xtable(tabAnnot, digits = 2,
         caption = "Top differentially expressed genes between disabled anf functional p53 cell lines.")
  print(xTabAnnot, include.rownames = FALSE, floating = FALSE)


###################################################
### code chunk number 17: limmaReg
###################################################



###################################################
### code chunk number 18: PAM
###################################################
resultPam <- pamClass(selBcrAblOrNeg, "mol.biol")
plot(resultPam)
featResultPam <- topTable(resultPam, n = 15)
xtable(head(featResultPam$listGenes),
    caption = "Top 5 features selected by PAM.")


###################################################
### code chunk number 19: randomForest
###################################################
resultRF <- rfClass(selBcrAblOrNeg, "mol.biol")
plot(resultRF, which = 2)
featResultRF <- topTable(resultRF, n = 15)
xtable(head(featResultRF$topList),
    caption = "Features selected by Random Forest variable importance.")
  


###################################################
### code chunk number 20: plotTop2_3genesRf
###################################################
plotCombination2genes(probesetId1=rownames(featResultRF$topList)[1],
    probesetId2=rownames(featResultRF$topList)[2],
    object = selBcrAblOrNeg, groups = "mol.biol")


###################################################
### code chunk number 21: loadNlcvTT
###################################################
#  nlcvTT <- nlcv(selBcrAblOrNeg, classVar = 'mol.biol', 
#                  classdist = "unbalanced",
#                  nRuns = 10, fsMethod = "t.test", verbose = TRUE)
data(nlcvTT)


###################################################
### code chunk number 22: MCRPlot
###################################################
mcrPlot_TT <- mcrPlot(nlcvTT, plot = TRUE, optimalDots = TRUE,
    layout = TRUE, main = "t-test selection")


###################################################
### code chunk number 23: tabmcrPlot
###################################################
xtable(summary(mcrPlot_TT),rownames=TRUE,
    caption = "Optimal number of genes per classification method together with the 
    respective misclassification error rate (mean and standard deviation across all CV loops).",
    label = "tabmcrPlot_TT")


###################################################
### code chunk number 24: ScoresPlot
###################################################
scoresPlot(nlcvTT, tech = "svm", nfeat = 2)


###################################################
### code chunk number 25: lasso
###################################################
resultLasso <- lassoClass(object = bcrAblOrNeg, groups = "mol.biol")
plot(resultLasso, label = TRUE,
    main = "Lasso coefficients in relation to degree of penalization.")
featResultLasso <- topTable(resultLasso, n = 15)


###################################################
### code chunk number 26: tabLasso
###################################################
lassoTable <- xtable(featResultLasso, label = "tablassoClass",
    caption = "Features selected by Lasso, ranked from largest to smallest penalized coefficient.")
print(lassoTable, include.rownames = FALSE)


###################################################
### code chunk number 27: plotTop2_3genesLasso
###################################################
op <- par(mfrow=c(1,2))
  plotCombination2genes(geneSymbol1 = featResultLasso$topList[1, 1], 
    geneSymbol2 = featResultLasso$topList[2, 1],
    object = bcrAblOrNeg, groups = "mol.biol",
    main = "Combination of\nfirst and second gene", addLegend = TRUE, 
    legendPos = "topright")

  plotCombination2genes(geneSymbol1 = featResultLasso$topList[1, 1], 
      geneSymbol2 = featResultLasso$topList[3, 1],
    object = bcrAblOrNeg, groups = "mol.biol",
    main = "Combination of\nfirst and third gene", addLegend = FALSE)
par(op)


###################################################
### code chunk number 28: LogisticRegression
###################################################
logRegRes <- logReg(geneSymbol = "ABL1", object = bcrAblOrNeg, groups = "mol.biol")


###################################################
### code chunk number 29: LogisticRegressionPlot
###################################################
probabilitiesPlot(proportions = logRegRes$fit, classVar = logRegRes$y,
    sampleNames = rownames(logRegRes), main = "Probability of being NEG")


###################################################
### code chunk number 30: LogisticRegressionPlotBars
###################################################
probabilitiesPlot(proportions = logRegRes$fit, classVar = logRegRes$y, barPlot= TRUE,
    sampleNames = rownames(logRegRes), main = "Probability of being NEG")


###################################################
### code chunk number 31: ROC
###################################################
ROCres <- ROCcurve(geneSymbol = "ABL1", object = bcrAblOrNeg, groups = "mol.biol")


###################################################
### code chunk number 32: plotProfile
###################################################
plot1gene(probesetId = rownames(tTestResult)[1],
    object = selBcrAblOrNeg, groups = "mol.biol", legendPos = "topright")


###################################################
### code chunk number 33: otherSampleIDsInPlot1gene
###################################################
plot1gene(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg,
    groups = "mol.biol", sampleIDs = "mol.biol", legendPos = "topright")


###################################################
### code chunk number 34: plot1gene2vars
###################################################
plot1gene(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg,
    groups = "mol.biol", colgroups = 'BT', legendPos = "topright")


###################################################
### code chunk number 35: boxPlot
###################################################
boxPlot(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg, boxwex = 0.3,
    groups = "mol.biol", colgroups = "BT", legendPos = "topright")


###################################################
### code chunk number 36: plotTop2_3genesLasso
###################################################
plotCombination2genes(geneSymbol1 = featResultLasso$topList[1, 1],
    geneSymbol2 = featResultLasso$topList[2, 1],
    object = bcrAblOrNeg, groups = "mol.biol",
    main = "Combination of\nfirst and second gene", addLegend = TRUE, 
    legendPos = "topright")


###################################################
### code chunk number 37: profilesPlot
###################################################
myGeneSymbol <- "LCK"
probesetPos <- which(myGeneSymbol == featureData(ALL)$SYMBOL)
myProbesetIds <- featureNames(ALL)[probesetPos]

profilesPlot(object = ALL, probesetIds = myProbesetIds,
    orderGroups = "BT", sampleIDs = "BT")


###################################################
### code chunk number 38: plotComb2Samples (eval = FALSE)
###################################################
## plotComb2Samples(ALL, "11002", "01003",
##     xlab = "a T-cell", ylab = "another T-cell")


###################################################
### code chunk number 39: plotComb2Samples
###################################################
png(filename="plotComb2Samples.png",width=500,height=500)
plotComb2Samples(ALL, "11002", "01003",
    xlab = "a T-cell", ylab = "another T-cell")
dev.off()


###################################################
### code chunk number 40: plotComb2SamplesWithAnnotation (eval = FALSE)
###################################################
## plotComb2Samples(ALL, "84004", "01003",
##     trsholdX = c(10,12), trsholdY = c(4,6),
##     xlab = "a B-cell", ylab = "a T-cell")


###################################################
### code chunk number 41: plotComb2SamplesWithAnnotation2
###################################################
png(filename="plotComb2SamplesWithAnnotation.png",width=500,height=500)
plotComb2Samples(ALL,"84004", "01003",
    trsholdX = c(10,12), trsholdY = c(4,6),
    xlab = "a B-cell", ylab = "a T-cell")
dev.off()


###################################################
### code chunk number 42: plotCombMultipleSamples
###################################################
plotCombMultSamples(exprs(ALL)[,c("84004", "11002", "01003")])
# text.panel= function(x){x, labels = c("a B-cell", "a T-cell", "another T-cell")})


###################################################
### code chunk number 43: plotCombMultipleSamples2
###################################################
png(filename="plotCombMultipleSamples.png", width=500, height=500)
plotCombMultSamples(exprs(ALL)[, c("84004", "11002", "01003")])
dev.off()


###################################################
### code chunk number 44: GeneLRlist
###################################################
ALL$BTtype <- as.factor(substr(ALL$BT,0,1))
ALL2 <- ALL[,ALL$BT != 'T1']  # omit subtype T1 as it only contains one sample
ALL2$BTtype <- as.factor(substr(ALL2$BT,0,1)) # create a vector with only T and B

# Test for differential expression between B and T cells
tTestResult <- tTest(ALL, "BTtype", probe2gene = FALSE)
topGenes <- rownames(tTestResult)[1:20]

# plot the log ratios versus subtype B of the top genes 
LogRatioALL <- computeLogRatio(ALL2, reference = list(var="BT", level="B"))
a <- plotLogRatio(e = LogRatioALL[topGenes,], openFile = FALSE, tooltipvalues = FALSE,
    device = "pdf", filename = "GeneLRlist",
    colorsColumnsBy = "BTtype", 
    main = 'Top 20 genes most differentially between T- and B-cells',
    orderBy = list(rows = "hclust"), probe2gene = TRUE)


###################################################
### code chunk number 45: plotLogRatioComplex
###################################################
  load(system.file("extdata", "esetExampleTimeCourse.rda", package = "a4"))
  logRatioEset <- computeLogRatio(esetExampleTimeCourse, within = "hours",
    reference = list(var = "compound", level = "DMSO"))

  # re-order
  idx <- order(pData(logRatioEset)$compound, pData(logRatioEset)$hours)
  logRatioEset <- logRatioEset[,idx]
  
  # plot LogRatioEset across all
  cl <- "TEST"
  compound <- "COMPOUND"
  shortvarnames <- unique(interaction(pData(logRatioEset)$compound, pData(logRatioEset)$hours))
  shortvarnames <- shortvarnames[-grep("DMSO", shortvarnames), drop=TRUE]
  
  plotLogRatio(e = logRatioEset, mx = 1, filename = "logRatioOverallTimeCourse.pdf",
      gene.fontsize = 8,
      orderBy = list(rows = "hclust", cols = NULL), colorsColumnsBy = c('compound'),
      within = "hours", shortvarnames = shortvarnames, exp.width = 1,
      main = paste("Differential Expression (trend at early time points) in", 
          cl, "upon treatment with", compound),
      reference = list(var = "compound", level = "DMSO"), device = 'pdf')


###################################################
### code chunk number 46: MLP
###################################################
require(MLP)
# create groups
labels <- as.factor(ifelse(regexpr("^B", as.character(pData(ALL)$BT))==1, "B", "T"))
pData(ALL)$BT2 <- labels

# generate p-values
limmaResult <- limmaTwoLevels(object =  ALL, group = "BT2")
pValues <- limmaResult@MArrayLM$p.value

pValueNames <- fData(ALL)[rownames(pValues), 'ENTREZID']
pValues <- pValues[,2]
names(pValues) <- pValueNames
pValues <- pValues[!is.na(pValueNames)]


###################################################
### code chunk number 47: geneSet
###################################################
geneSet <- getGeneSets(species = "Human", 
    geneSetSource = "GOBP", 
    entrezIdentifiers = names(pValues)
)
tail(geneSet, 3)


###################################################
### code chunk number 48: MLP
###################################################
mlpOut <- MLP(
    geneSet = geneSet, 
    geneStatistic = pValues, 
    minGenes = 5, 
    maxGenes = 100, 
    rowPermutations = TRUE, 
    nPermutations = 50, 
    smoothPValues = TRUE, 
    probabilityVector = c(0.5, 0.9, 0.95, 0.99, 0.999, 0.9999, 0.99999), 
    df = 9)   


###################################################
### code chunk number 49: GOgraph (eval = FALSE)
###################################################
## library(Rgraphviz)
## library(GOstats)
##   pdf(file = "GOgraph.pdf")
##     plot(mlpOut, type = "GOgraph", nRow = 25)
##   dev.off()


###################################################
### code chunk number 50: sessionInfo
###################################################
toLatex(sessionInfo())


