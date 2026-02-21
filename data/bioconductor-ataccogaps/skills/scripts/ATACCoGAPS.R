# Code example from 'ATACCoGAPS' vignette. See references/ for full tutorial.

## ---- eval = FALSE------------------------------------------------------------
#  if (!require("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("ATACCoGAPS")

## ---- message = FALSE---------------------------------------------------------
library(ATACCoGAPS)

## -----------------------------------------------------------------------------
data("subsetSchepData")
data("schepPeaks")
data("schepCellTypes")

## -----------------------------------------------------------------------------
params <- CogapsParams(nPatterns=7, nIterations=10000, seed=42, sparseOptimization=TRUE, distributed="genome-wide", geneNames=schepPeaks, sampleNames=as.character(schepCellTypes))

params

## ---- eval = FALSE------------------------------------------------------------
#  schepCogapsResult <- CoGAPS(data = subsetSchepData, params = params, nThreads = 1)

## -----------------------------------------------------------------------------
data("schepCogapsResult")

## -----------------------------------------------------------------------------
#colors to plot by
col <- viridis::plasma(n=12)


cgapsPlot(cgaps_result = schepCogapsResult, sample.classifier = schepCellTypes, cols = col, ylab = "Pattern Weight")

## ---- fig.width=8, fig.height=8-----------------------------------------------
heatmapPatternMatrix(cgaps_result = schepCogapsResult, sample.classifier = schepCellTypes, cellCols = col, col = viridis::magma(n=9))

## -----------------------------------------------------------------------------
#get the pattern Matrix
patMatrix <- getSampleFactors(schepCogapsResult)
#perform a pairwise Wilcoxon test
pairwise.wilcox.test(patMatrix[,5], schepCellTypes, p.adjust.method = "BH")

## ---- fig.width=8, fig.height=8-----------------------------------------------
cellClass <- patternMarkerCellClassifier(schepCogapsResult)
cellClasses <- cellClass$cellClassifier

heatmapPatternMatrix(schepCogapsResult, as.factor(cellClasses), col = viridis::magma(n=9))

## ---- fig.width=8, fig.height=8-----------------------------------------------
heatmapPatternMarkers(cgaps_result = schepCogapsResult, atac_data = subsetSchepData, celltypes = schepCellTypes, numregions = 5, colColors = col, col = viridis::plasma(n = 2))

## ---- message = FALSE---------------------------------------------------------
data("schepGranges")

#loading TxDb of human genes
library(Homo.sapiens)

#find genes known to fall within thresholded patternMarker peaks for each pattern
genes <- genePatternMatch(cogapsResult = schepCogapsResult, generanges = schepGranges, genome = Homo.sapiens)

#download hallmark pathways using msigdbr
library(dplyr)

## -----------------------------------------------------------------------------
pathways <- msigdbr::msigdbr(species = "Homo sapiens", category =
                             "H") %>% dplyr::select(gs_name, gene_symbol) %>% as.data.frame()

#match these pattern Gene sets to hallmark pathways, using an adjusted p-value threshold of 0.001.
matchedPathways <- pathwayMatch(gene_list = genes, pathways = pathways, p_threshold = 0.001)

lapply(matchedPathways, function(x) {x[4]})

## -----------------------------------------------------------------------------
motifResults <- simpleMotifTFMatch(cogapsResult = schepCogapsResult, generanges = schepGranges, organism = "Homo sapiens", genome = "hg19", motifsPerRegion = 1)


## -----------------------------------------------------------------------------
motifResults$tfMatchSummary[[1]]

## -----------------------------------------------------------------------------
#get peaks overlapping with the gene
EGR1peaks <- geneAccessibility("EGR1", schepGranges, subsetSchepData, Homo.sapiens)

#make binary accessibility matrix
binaryMatrix <- (subsetSchepData > 0) + 0

#find accessibility of those peaks relative to others among monocyte cells
foldAccessibility(peaksAccessibility = EGR1peaks$EGR1, cellTypeList = schepCellTypes, cellType = "Monocyte", binaryMatrix = binaryMatrix)

## ---- echo = FALSE------------------------------------------------------------
sessionInfo()

