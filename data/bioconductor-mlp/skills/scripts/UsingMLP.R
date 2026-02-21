# Code example from 'UsingMLP' vignette. See references/ for full tutorial.

### R code from vignette source 'UsingMLP.Rnw'

###################################################
### code chunk number 1: loadRequiredPackages
###################################################
require(MLP)
require(limma)
library(AnnotationDbi)


###################################################
### code chunk number 2: loadData
###################################################
  
  pathExampleData <- system.file("exampleFiles", "expressionSetGcrma.rda", package = "MLP")
  load(pathExampleData)
  annotation(expressionSetGcrma) <- "mouse4302"


###################################################
### code chunk number 3: preparePValues
###################################################
  ### calculation of the statistics values via limma
  group <- as.numeric(factor(pData(expressionSetGcrma)$subGroup1, levels = c("WT", "KO")))-1
  design <- model.matrix(~group)
  fit <- lmFit(exprs(expressionSetGcrma), design)
  fit2 <- eBayes(fit)
  results <- limma:::topTable(fit2, coef = "group", adjust.method = "fdr", number = Inf)
  pvalues <- results[,"P.Value"]
  names(pvalues) <- rownames(results)
  # since we moved towards using "_at", next step should be needed as well
  names(pvalues) <- sub("_at", "", names(pvalues))	


###################################################
### code chunk number 4: createGeneSets
###################################################
geneSet <- getGeneSets(species = "Mouse", 
		geneSetSource = "GOCC", 
		entrezIdentifiers = names(pvalues)
)
tail(geneSet, 3)


###################################################
### code chunk number 5: showAttributes
###################################################
str(attributes(geneSet))


###################################################
### code chunk number 6: runMLP
###################################################
set.seed(111)
mlpOut <- MLP(
		geneSet = geneSet, 
		geneStatistic = pvalues, 
		minGenes = 5, 
		maxGenes = 100, 
		rowPermutations = TRUE, 
		nPermutations = 50, 
		smoothPValues = TRUE, 
    probabilityVector = c(0.5, 0.9, 0.95, 0.99, 0.999, 0.9999, 0.99999), 
		df = 9) 	
head(mlpOut)


###################################################
### code chunk number 7: showAttributes
###################################################
str(attributes(mlpOut))


###################################################
### code chunk number 8: quantileCurves
###################################################
  pdf("mlpQuantileCurves.pdf", width = 10, height = 10)
  plot(mlpOut, type = "quantileCurves")
  tmp <- dev.off()


###################################################
### code chunk number 9: barplot
###################################################
  pdf("mlpBarplot.pdf", width = 10, height = 10)
  op <- par(mar = c(30, 10, 6, 2))
  plot(mlpOut, type = "barplot", ylab = "-log10(gene set p-value)")
  par(op)
  tmp <- dev.off()


###################################################
### code chunk number 10: GOgraph
###################################################
  pdf("mlpGOgraph.pdf", width = 8, height = 6)
  op <- par(mar = c(0, 0, 0, 0))
  plot(mlpOut, type = "GOgraph", nRow = 10, nCutDescPath = 15)
  par(op)
  tmp <- dev.off()


###################################################
### code chunk number 11: geneSignificance
###################################################
geneSetID <- rownames(mlpOut)[1]
pdf("geneSignificance.pdf", width = 10, height = 10)
op <- par(mar = c(25, 10, 6, 2))
plotGeneSetSignificance(
		geneSet = geneSet, 
		geneSetIdentifier = geneSetID, 
		geneStatistic = pvalues, 
		annotationPackage = annotation(expressionSetGcrma)
)
par(op)
tmp <- dev.off()	


