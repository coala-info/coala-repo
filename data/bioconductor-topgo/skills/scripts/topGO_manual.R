# Code example from 'topGO_manual' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  error    = FALSE,
  warning  = FALSE,
  eval     = TRUE,
  message  = FALSE
)
options(width = 95)

## ----echo = FALSE----------------------------------------------------------------------------
x <- topGO:::.algoComp[, -8]
x <- x[, colSums(x) > 0]
yesPic <- "✅"
noPic <- "🔴"
x[x == 1] <-  yesPic
x[x == "0"] <-  noPic

## ----algos, echo = FALSE---------------------------------------------------------------------
knitr::kable(x, caption = "Algorithms currently supported by `topGO`", 
             align = c("c"))

## ----eval = FALSE----------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install()

## ----eval = FALSE----------------------------------------------------------------------------
# BiocManager::install("topGO")

## ----results='hide'--------------------------------------------------------------------------
library(topGO)
library(ALL)
data(ALL)
data(geneList)

## --------------------------------------------------------------------------------------------
affyLib <- paste(annotation(ALL), "db", sep = ".")
library(package = affyLib, character.only = TRUE)

## --------------------------------------------------------------------------------------------
sum(topDiffGenes(geneList))

## ----results='hide'--------------------------------------------------------------------------
sampleGOdata <- new("topGOdata", 
                    description = "Simple session", ontology = "BP",
                    allGenes = geneList, geneSel = topDiffGenes,
                    nodeSize = 10,
                    annot = annFUN.db, affyLib = affyLib)

## --------------------------------------------------------------------------------------------
sampleGOdata

## ----results = 'hide'------------------------------------------------------------------------
resultFisher <- runTest(sampleGOdata, 
                        algorithm = "classic", statistic = "fisher")

## --------------------------------------------------------------------------------------------
resultFisher

## ----results = 'hide'------------------------------------------------------------------------
resultKS <- runTest(sampleGOdata, algorithm = "classic", statistic = "ks")
resultKS.elim <- runTest(sampleGOdata, algorithm = "elim", statistic = "ks")

## --------------------------------------------------------------------------------------------
allRes <- GenTable(sampleGOdata, classicFisher = resultFisher, 
                   classicKS = resultKS, elimKS = resultKS.elim,
                   orderBy = "elimKS", ranksOf = "classicFisher", topNodes = 10)

## ----sampleGOresults, echo = FALSE-----------------------------------------------------------
knitr::kable(allRes, caption = "Significance of GO terms according to `classic` and `elim` methods.")

## ----echo = FALSE----------------------------------------------------------------------------
colMap <- function(x) {
  .col <- rep(rev(heat.colors(length(unique(x)))), time = table(x))
  return(.col[match(1:length(x), order(x))])
}

## ----eval = FALSE----------------------------------------------------------------------------
# pValue.classic <- score(resultKS)
# pValue.elim <- score(resultKS.elim)[names(pValue.classic)]
# 
# gstat <- termStat(sampleGOdata, names(pValue.classic))
# gSize <- gstat$Annotated / max(gstat$Annotated) * 4
# gCol <- colMap(gstat$Significant)
# 
# plot(pValue.classic, pValue.elim,
#      xlab = "p-value classic", ylab = "p-value elim",
#      pch = 19, cex = gSize, col = gCol)

## ----scatterClassicElim, echo = FALSE, width = 11, fig.cap="$p$-values scatter plot for the ` classic` ($x$ axis) and `elim` ($y$ axis) methods. On the right panel the $p$-values are plotted on a linear scale. The left panned plots the same $p$-values on a logarithmic scale. The size of the dot is proportional with the number of annotated genes for the respective GO term and its coloring represents the number of significantly differentially expressed genes, with the dark red points having more genes then the yellow ones."----
pValue.classic <- score(resultKS)
pValue.elim <- score(resultKS.elim)[names(pValue.classic)]

gstat <- termStat(sampleGOdata, names(pValue.classic))
gSize <- gstat$Annotated / max(gstat$Annotated) * 4
gCol <- colMap(gstat$Significant)

par(mfcol = c(1, 2), cex = 1)
plot(pValue.classic, pValue.elim, 
     xlab = "p-value classic", ylab = "p-value elim",
     pch = 19, cex = gSize, col = gCol)

plot(pValue.classic, pValue.elim, log = "xy", 
     xlab = "log(p-value) classic", ylab = "log(p-value) elim",
     pch = 19, cex = gSize, col = gCol)

## --------------------------------------------------------------------------------------------
sel.go <- names(pValue.classic)[pValue.elim < pValue.classic]
cbind(termStat(sampleGOdata, sel.go),
      elim = pValue.elim[sel.go],
      classic = pValue.classic[sel.go])

## ----sampleGOelim, fig.height=8, fig.cap="The subgraph induced by the top $5$ GO terms identified by the `elim` algorithm for scoring GO terms for enrichment. Rectangles indicate the $5$ most significant terms. Rectangle color represents the relative significance, ranging from dark red (most significant) to bright yellow (least significant). For each node, some basic information is displayed. The first two lines show the  GO identifier and a trimmed GO name. In the third line the raw p-value is shown. The forth line is showing the number of significant genes and the total number of genes annotated to the respective GO term.", results='hide'----
showSigOfNodes(sampleGOdata, score(resultKS.elim), 
               firstSigNodes = 5, useInfo = 'all')

## ----results = 'hide'------------------------------------------------------------------------
library(topGO)
library(ALL)
data(ALL)

## --------------------------------------------------------------------------------------------
BPterms <- ls(GOBPTerm)
head(BPterms)

## --------------------------------------------------------------------------------------------
library(genefilter)
selProbes <- genefilter(ALL, filterfun(pOverA(0.20, log2(100)), 
                                       function(x) (IQR(x) > 0.25)))
eset <- ALL[selProbes, ]
eset

## --------------------------------------------------------------------------------------------
geneID2GO <- readMappings(file = system.file("examples/geneid2go.map", package = "topGO"))
str(head(geneID2GO))

## --------------------------------------------------------------------------------------------
GO2geneID <- inverseList(geneID2GO)
str(head(GO2geneID))

## --------------------------------------------------------------------------------------------
geneNames <- names(geneID2GO)
head(geneNames)

## --------------------------------------------------------------------------------------------
myInterestingGenes <- sample(geneNames, length(geneNames) / 10)
geneList <- factor(as.integer(geneNames %in% myInterestingGenes))
names(geneList) <- geneNames
str(geneList)

## ----results = 'hide'------------------------------------------------------------------------
GOdata <- new("topGOdata", ontology = "MF", allGenes = geneList,
              annot = annFUN.gene2GO, gene2GO = geneID2GO)

## --------------------------------------------------------------------------------------------
GOdata

## ----results = 'hide'------------------------------------------------------------------------
y <- as.integer(sapply(eset$BT, function(x) return(substr(x, 1, 1) == 'T')))
table(y)

## --------------------------------------------------------------------------------------------
geneList <- getPvalues(exprs(eset), classlabel = y, alternative = "greater")

## ----results = 'hide'------------------------------------------------------------------------
topDiffGenes <- function(allScore) {
  return(allScore < 0.01)
}
x <- topDiffGenes(geneList)
sum(x) ## the number of selected genes

## ----results = 'hide'------------------------------------------------------------------------
GOdata <- new("topGOdata", 
              description = "GO analysis of ALL data; B-cell vs T-cell",
              ontology = "BP",
              allGenes = geneList,
              geneSel = topDiffGenes,
              annot = annFUN.db,
              nodeSize = 5,
              affyLib = affyLib)

## --------------------------------------------------------------------------------------------
allProb <- featureNames(ALL)
groupProb <- integer(length(allProb)) + 1
groupProb[allProb %in% genes(GOdata)] <- 0
groupProb[!selProbes] <- 2
groupProb <- factor(groupProb, 
                    labels = c("Used", "Not annotated", "Filtered"))

tt <- table(groupProb)
tt

## ----whichProbes, fig.cap="Scatter plot of FDR adjusted $p$-values against variance of probes. Points below the horizontal line are significant probes.", fig.width=9, fig.height=7----
library(lattice)
pValue <- getPvalues(exprs(ALL), classlabel = y, alternative = "greater")
geneVar <- apply(exprs(ALL), 1, var)
dd <- data.frame(x = geneVar[allProb], 
                 y = log10(pValue[allProb]), 
                 groups = groupProb)
legendLab <- paste(names(table(groupProb)), 
                   " (#", table(groupProb), ")", sep = "")
xyplot(y ~ x | groups, data = dd, groups = groups,
       xlab = "Variance", ylab = "Log of p-values",
       layout = c(2, 2),
       key = list(text = list(lab = legendLab),
                  points = list(pch = 20, cex = 2, 
                                col = Rows(trellis.par.get("superpose.symbol"), 1:3)$col),
                  size = 7, padding.text = 3,
                  x = .65, y = .7, corner = c(0, 0), border = TRUE, cex = 1),
       panel = function(x, y, ...) {
         selY <- y <= -2
         panel.xyplot(x[selY], y[selY], pch = 2, ...)
         panel.xyplot(x[!selY], y[!selY], pch = 20, ...)
         panel.abline(h = -2, lty = 2, col = "black")
       })

## ----results = 'hide'------------------------------------------------------------------------
description(GOdata)
description(GOdata) <- paste(description(GOdata), 
                             "Object modified on:", 
                             format(Sys.time(), "%d %b %Y"), sep = " ")
description(GOdata)

## --------------------------------------------------------------------------------------------
a <- genes(GOdata) ## obtain the list of genes
head(a)
numGenes(GOdata)

## --------------------------------------------------------------------------------------------
selGenes <- sample(a, 10)
gs <- geneScore(GOdata, whichGenes = selGenes) 
print(gs)

## --------------------------------------------------------------------------------------------
gs <- geneScore(GOdata, whichGenes = selGenes, use.names = FALSE)
print(gs)

gs <- geneScore(GOdata, use.names = FALSE)
str(gs)

## --------------------------------------------------------------------------------------------
sg <- sigGenes(GOdata)
str(sg)
numSigGenes(GOdata)

## ----results = 'hide'------------------------------------------------------------------------
.geneList <- geneScore(GOdata, use.names = TRUE)
GOdata ## more available genes
GOdata <- updateGenes(GOdata, geneList = .geneList, geneSelFun = topDiffGenes)
GOdata ## the available genes are now the feasible genes

## --------------------------------------------------------------------------------------------
graph(GOdata) ## returns the GO graph

ug <- usedGO(GOdata)
head(ug) 

## ----results = 'hide'------------------------------------------------------------------------
sel.terms <- sample(usedGO(GOdata), 10)

num.ann.genes <- countGenesInTerm(GOdata, sel.terms) ## the number of annotated genes
num.ann.genes

ann.genes <- genesInTerm(GOdata, sel.terms) ## get the annotations
head(ann.genes)

## ----results = 'hide'------------------------------------------------------------------------
ann.score <- scoresInTerm(GOdata, sel.terms)
head(ann.score)
ann.score <- scoresInTerm(GOdata, sel.terms, use.names = TRUE)
head(ann.score)

## --------------------------------------------------------------------------------------------
termStat(GOdata, sel.terms)

## ----topGOclasses, echo=FALSE, fig.cap="The test statistics class structure."----------------
knitr::include_graphics("topGO_classes_v3.png")

## --------------------------------------------------------------------------------------------
goID <- "GO:0006629"
gene.universe <- genes(GOdata)
go.genes <- genesInTerm(GOdata, goID)[[1]]
sig.genes <- sigGenes(GOdata)

## --------------------------------------------------------------------------------------------
my.group <- new("classicCount", testStatistic = GOFisherTest, name = "fisher",
                allMembers = gene.universe, groupMembers = go.genes,
                sigMembers = sig.genes)

contTable(my.group)
runTest(my.group)

## --------------------------------------------------------------------------------------------
set.seed(123)
elim.genes <- sample(go.genes, length(go.genes) / 4)
elim.group <- new("elimCount", testStatistic = GOFisherTest, name = "fisher",
                  allMembers = gene.universe, groupMembers = go.genes,
                  sigMembers = sig.genes, elim = elim.genes)

contTable(elim.group)
runTest(elim.group)

## ----results = 'hide'------------------------------------------------------------------------
test.stat <- new("classicCount", 
                 testStatistic = GOFisherTest, 
                 name = "Fisher test")
resultFisher <- getSigGroups(GOdata, test.stat)

## --------------------------------------------------------------------------------------------
resultFisher

## ----results = 'hide'------------------------------------------------------------------------
test.stat <- new("classicScore", 
                 testStatistic = GOKSTest, 
                 name = "KS tests")
resultKS <- getSigGroups(GOdata, test.stat)

## ----eval = FALSE, results = 'hide'----------------------------------------------------------
# test.stat <- new("elimScore", testStatistic = GOKSTest,
#                  name = "Fisher test", cutOff = 0.01)
# resultElim <- getSigGroups(GOdata, test.stat)

## ----results = 'hide'------------------------------------------------------------------------
test.stat <- new("weightCount", testStatistic = GOFisherTest, 
                 name = "Fisher test", sigRatio = "ratio")
resultWeight <- getSigGroups(GOdata, test.stat)

## ----results = 'hide'------------------------------------------------------------------------
resultFis <- runTest(GOdata, algorithm = "classic", statistic = "fisher")

## ----eval = FALSE, keep.source = TRUE--------------------------------------------------------
# weight01.fisher <- runTest(GOdata, statistic = "fisher")
# weight01.t <- runTest(GOdata, algorithm = "weight01", statistic = "t")
# elim.ks <- runTest(GOdata, algorithm = "elim", statistic = "ks")
# weight.ks <- runTest(GOdata, algorithm = "weight", statistic = "ks") # will not work!!!

## --------------------------------------------------------------------------------------------
whichTests()
whichAlgorithms()

## --------------------------------------------------------------------------------------------
head(score(resultWeight))

## --------------------------------------------------------------------------------------------
pvalFis <- score(resultFis)
head(pvalFis)
hist(pvalFis, 50, xlab = "p-values")

## --------------------------------------------------------------------------------------------
pvalWeight <- score(resultWeight, whichGO = names(pvalFis))
head(pvalWeight)
cor(pvalFis, pvalWeight)

## --------------------------------------------------------------------------------------------
geneData(resultWeight)

## --------------------------------------------------------------------------------------------
allRes <- GenTable(GOdata, classic = resultFis, KS = resultKS, 
                   weight = resultWeight, orderBy = "weight", 
                   ranksOf = "classic", topNodes = 20)

## ----GOresults, echo = FALSE-----------------------------------------------------------------
knitr::kable(allRes, 
             caption = "Significance of GO terms according to different tests.")

## ----geneDensityDiff, fig.cap="Distribution of the gene's rank from GO:0031580, compared with the null distribution."----
goID <- allRes[1, "GO.ID"]
print(showGroupDensity(GOdata, goID, ranks = TRUE))

## --------------------------------------------------------------------------------------------
goID <- allRes[10, "GO.ID"]
gt <- printGenes(GOdata, whichTerms = goID, chip = affyLib, numChar = 40)

## ----printGenes1, echo = FALSE---------------------------------------------------------------
knitr::kable(gt, caption = "Genes annotated to GO:0043378")

## ----GOclassic, fig.height=8, fig.cap="The subgraph induced by the top 5 GO terms identified by the `classic` algorithm for scoring GO terms for enrichment. Boxes indicate the 5 most significant terms. Box color represents the relative significance, ranging from dark red (most significant) to light yellow (least significant). Black arrows indicate *is-a* relationships and red arrows *part-of* relationships.", results='hide'----
showSigOfNodes(GOdata, score(resultFis), firstSigNodes = 5, useInfo = 'all')

## ----GOweight, fig.height=8, fig.cap="The subgraph induced by the top 5 GO terms identified by the `weight` algorithm for scoring GO terms for enrichment. Boxes indicate the 5 most significant terms. Box color represents the relative significance, ranging from dark red (most significant) to light yellow (least significant). Black arrows indicate *is-a* relationships and red arrows *part-of* relationships.", results='hide'----
showSigOfNodes(GOdata, score(resultWeight), firstSigNodes = 5, useInfo = 'def')

## ----eval=FALSE------------------------------------------------------------------------------
# printGraph(GOdata, resultFis, firstSigNodes = 5,
#            fn.prefix = "tGO", useInfo = "all", pdfSW = TRUE)
# printGraph(GOdata, resultWeight, firstSigNodes = 5,
#            fn.prefix = "tGO", useInfo = "def", pdfSW = TRUE)

## ----eval = FALSE----------------------------------------------------------------------------
# printGraph(GOdata, resultWeight, firstSigNodes = 10, resultFis,
#            fn.prefix = "tGO", useInfo = "def", pdfSW = TRUE)
# printGraph(GOdata, resultElim, firstSigNodes = 15, resultFis,
#            fn.prefix = "tGO", useInfo = "all", pdfSW = TRUE)

## ----echo=FALSE------------------------------------------------------------------------------
sessionInfo()

