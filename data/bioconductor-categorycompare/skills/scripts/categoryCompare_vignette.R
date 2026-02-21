# Code example from 'categoryCompare_vignette' vignette. See references/ for full tutorial.

## ----loadLibs, message=FALSE--------------------------------------------------
library("affy")
library("hgu95av2.db")
library("genefilter")
library("estrogen")
library("limma")

## ----loadMeta-----------------------------------------------------------------
datadir <- system.file("extdata", package = "estrogen")
pd <- read.AnnotatedDataFrame(file.path(datadir,"estrogen.txt"), 
  	header = TRUE, sep = "", row.names = 1)
pData(pd)

## ----loadAffy-----------------------------------------------------------------
filePaths <- file.path(datadir, rownames(pData(pd)))
a <- ReadAffy(filenames=filePaths, phenoData = pd, verbose = TRUE)

## ----normalizeAffy, message=FALSE---------------------------------------------
eData <- mas5(a)

## ----edata10------------------------------------------------------------------
e10 <- eData[, eData$time.h == 10]
e10 <- nsFilter(e10, remove.dupEntrez=TRUE, var.filter=FALSE, 
        feature.exclude="^AFFX")$eset

e10$estrogen <- factor(e10$estrogen)
d10 <- model.matrix(~0 + e10$estrogen)
colnames(d10) <- unique(e10$estrogen)
fit10 <- lmFit(e10, d10)
c10 <- makeContrasts(present - absent, levels=d10)
fit10_2 <- contrasts.fit(fit10, c10)
eB10 <- eBayes(fit10_2)
table10 <- topTable(eB10, number=nrow(e10), p.value=1, adjust.method="BH")
table10$Entrez <- unlist(mget(rownames(table10), hgu95av2ENTREZID, ifnotfound=NA))

## ----edata48------------------------------------------------------------------
e48 <- eData[, eData$time.h == 48]
e48 <- nsFilter(e48, remove.dupEntrez=TRUE, var.filter=FALSE, 
        feature.exclude="^AFFX" )$eset

e48$estrogen <- factor(e48$estrogen)
d48 <- model.matrix(~0 + e48$estrogen)
colnames(d48) <- unique(e48$estrogen)
fit48 <- lmFit(e48, d48)
c48 <- makeContrasts(present - absent, levels=d48)
fit48_2 <- contrasts.fit(fit48, c48)
eB48 <- eBayes(fit48_2)
table48 <- topTable(eB48, number=nrow(e48), p.value=1, adjust.method="BH")
table48$Entrez <- unlist(mget(rownames(table48), hgu95av2ENTREZID, ifnotfound=NA))

## ----gUniverse----------------------------------------------------------------
gUniverse <- unique(union(table10$Entrez, table48$Entrez))

## ----createGeneList, message=FALSE--------------------------------------------
library("categoryCompare")
library("GO.db")
library("KEGGREST")

g10 <- unique(table10$Entrez[table10$adj.P.Val < 0.05])
g48 <- unique(table48$Entrez[table48$adj.P.Val < 0.05])

## ----viewLists----------------------------------------------------------------
list10 <- list(genes=g10, universe=gUniverse, annotation='org.Hs.eg.db')
list48 <- list(genes=g48, universe=gUniverse, annotation='org.Hs.eg.db')

geneLists <- list(T10=list10, T48=list48)
geneLists <- new("ccGeneList", geneLists, ccType=c("BP","KEGG"))
fdr(geneLists) <- 0 # this speeds up the calculations for demonstration
geneLists

## ----runEnrichment------------------------------------------------------------
enrichLists <- ccEnrich(geneLists)
enrichLists

## ----modPVal------------------------------------------------------------------
pvalueCutoff(enrichLists$BP) <- 0.001
enrichLists

## ----ccOptions----------------------------------------------------------------
ccOpts <- new("ccOptions", listNames=names(geneLists), outType='none')
ccOpts

## ----ccResults----------------------------------------------------------------
ccResults <- ccCompare(enrichLists,ccOpts)
ccResults

## ----setupRunningCytoscape, echo=FALSE, error=FALSE, results='asis'-----------
push_graph <- try(
  {
    # borrowed from createNetworkFromDataFrames
    nodes <- data.frame(id=c("node 0","node 1","node 2","node 3"),
           stringsAsFactors=FALSE)
    edges <- data.frame(source=c("node 0","node 0","node 0","node 2"),
           target=c("node 1","node 2","node 3","node 3"),
           stringsAsFactors=FALSE)

    RCy3::createNetworkFromDataFrames(nodes,edges)
  }
)

if (inherits(push_graph, "try-error")) {
  runCy <- FALSE
  print("No connection to Cytoscape available, subsequent visualizations were not run")
} else {
  runCy <- TRUE
}

## ----cwBP, eval=runCy---------------------------------------------------------
# ccBP <- breakEdges(ccResults$BP, 0.2)
# 
# cw.BP <- ccOutCyt(ccBP, ccOpts)

## ----breakHighBP, eval=runCy--------------------------------------------------
# breakEdges(cw.BP,0.4)
# breakEdges(cw.BP,0.6)
# breakEdges(cw.BP,0.8)

## ----deleteBP, include=FALSE, eval=runCy--------------------------------------
# RCy3::deleteNetwork(cw.BP)

## ----GOHierarchical-----------------------------------------------------------
graphType(enrichLists$BP) <- "hierarchical"
ccResultsBPHier <- ccCompare(enrichLists$BP, ccOpts)
ccResultsBPHier

## ----hier2Cytoscape, eval=runCy-----------------------------------------------
# cw.BP2 <- ccOutCyt(ccResultsBPHier, ccOpts, "BPHier")

## ----deleteHier, include=FALSE, eval=runCy------------------------------------
# RCy3::deleteNetwork(cw.BP2)

## ----cytoscapeKEGG, eval=runCy------------------------------------------------
# cw.KEGG <- ccOutCyt(ccResults$KEGG,ccOpts)

## ----deleteKEGG, include=FALSE, eval=runCy------------------------------------
# RCy3::deleteNetwork(cw.KEGG)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

