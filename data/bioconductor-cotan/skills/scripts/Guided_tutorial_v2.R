# Code example from 'Guided_tutorial_v2' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk[["set"]](
  collapse = TRUE,
  comment = "#>",
  dev = "png",
  fig.width = 6L,
  fig.height = 4L,
  dpi = 72L
)


## ----message=FALSE, warning=FALSE---------------------------------------------
library(COTAN)
library(zeallot)

# necessary to solve precedence of overloads
conflicted::conflict_prefer("%<-%", "zeallot")

options(parallelly.fork.enable = TRUE)

## ----eval=TRUE, include=TRUE--------------------------------------------------
dataDir <- tempdir()
print(dataDir)

GEO <- "GSM2861514"
fName <- "GSM2861514_E175_Only_Cortical_Cells_DGE.txt.gz"

dataSetFile <- file.path(dataDir, GEO, fName)

dir.create(file.path(dataDir, GEO), showWarnings = FALSE)

if (!file.exists(dataSetFile)) {
  GEOquery::getGEOSuppFiles(
    GEO,
    makeDirectory = TRUE,
    baseDir = dataDir,
    fetch_files = TRUE,
    filter_regex = fName
  )
}

sample.dataset <- read.csv(dataSetFile, sep = "\t", row.names = 1L)

## -----------------------------------------------------------------------------
outDir <- dataDir

# Log-level 2 was chosen to showcase better how the package works
# In normal usage a level of 0 or 1 is more appropriate
setLoggingLevel(2L)

# This file will contain all the logs produced by the package
# as if at the highest logging level
setLoggingFile(file.path(outDir, "vignette_v2.log"))

message("COTAN uses the `torch` library when asked to `optimizeForSpeed`")
message("Run the command 'options(COTAN.UseTorch = FALSE)'",
        " in your session to disable `torch` completely!")

# this command does check whether the torch library is properly installed
c(useTorch, deviceStr) %<-% COTAN:::canUseTorch(TRUE, "cuda")
if (useTorch) {
  message("The `torch` library is available and ready to use")
  if (deviceStr == "cuda") {
    message("The `torch` library can use the `CUDA` GPU")
  } else {
    message("The `torch` library can only use the CPU")
    message("Please ensure you have the `OpenBLAS` libraries",
            " installed on the system")
  }
}

rm(useTorch, deviceStr)

## -----------------------------------------------------------------------------
cond <- "mouse_cortex_E17.5"

obj <- COTAN(raw = sample.dataset)
obj <-
  initializeMetaDataset(
    obj,
    GEO = GEO,
    sequencingMethod = "Drop_seq",
    sampleCondition = cond
  )

logThis(paste0("Condition ", getMetadataElement(obj, datasetTags()[["cond"]])),
        logLevel = 1L)

## -----------------------------------------------------------------------------
plot(ECDPlot(obj))

## -----------------------------------------------------------------------------
plot(cellSizePlot(obj))

## -----------------------------------------------------------------------------
plot(genesSizePlot(obj))

## -----------------------------------------------------------------------------
plot(scatterPlot(obj))

## -----------------------------------------------------------------------------
cellsSizeThr <- 6000L
obj <- addElementToMetaDataset(obj, "Cells size threshold", cellsSizeThr)

cells_to_rem <- getCells(obj)[getCellsSize(obj) > cellsSizeThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(cellSizePlot(obj))

## -----------------------------------------------------------------------------
genesSizeHighThr <- 3000L
obj <-
  addElementToMetaDataset(obj, "Num genes high threshold", genesSizeHighThr)

cells_to_rem <- getCells(obj)[getNumExpressedGenes(obj) > genesSizeHighThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(genesSizePlot(obj))

## -----------------------------------------------------------------------------
genesSizeLowThr <- 500L
obj <- addElementToMetaDataset(obj, "Num genes low threshold", genesSizeLowThr)

cells_to_rem <- getCells(obj)[getNumExpressedGenes(obj) < genesSizeLowThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

plot(genesSizePlot(obj))

## -----------------------------------------------------------------------------
c(mitPlot, mitSizes) %<-%
  mitochondrialPercentagePlot(obj, genePrefix = "^Mt")

plot(mitPlot)

## -----------------------------------------------------------------------------
mitPercThr <- 1.0
obj <- addElementToMetaDataset(obj, "Mitoc. perc. threshold", mitPercThr)

cells_to_rem <- rownames(mitSizes)[mitSizes[["mit.percentage"]] > mitPercThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

c(mitPlot, mitSizes) %<-%
  mitochondrialPercentagePlot(obj, genePrefix = "^Mt")

plot(mitPlot)

## -----------------------------------------------------------------------------
genes_to_rem <- getGenes(obj)[grep("^Mt", getGenes(obj))]
cells_to_rem <- getCells(obj)[which(getCellsSize(obj) == 0L)]

obj <- dropGenesCells(obj, genes_to_rem, cells_to_rem)

## -----------------------------------------------------------------------------
logThis(paste("n cells", getNumCells(obj)), logLevel = 1L)

## -----------------------------------------------------------------------------
obj <- addElementToMetaDataset(obj, "Num drop B group", 0L)

obj <- clean(obj)

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)

plot(pcaCellsPlot)

## -----------------------------------------------------------------------------
plot(genesPlot)

## ----eval=TRUE, include=TRUE--------------------------------------------------
cells_to_rem <- rownames(pcaCellsData)[pcaCellsData[["groups"]] == "B"]
obj <- dropGenesCells(obj, cells = cells_to_rem)

obj <- addElementToMetaDataset(obj, "Num drop B group", 1L)

obj <- clean(obj)

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)

plot(pcaCellsPlot)

## -----------------------------------------------------------------------------
plot(UDEPlot)

## -----------------------------------------------------------------------------
plot(nuPlot)

## -----------------------------------------------------------------------------
plot(zoomedNuPlot)

## -----------------------------------------------------------------------------
UDELowThr <- 0.30
obj <- addElementToMetaDataset(obj, "Low UDE cells' threshold", UDELowThr)

obj <- addElementToMetaDataset(obj, "Num drop B group", 2L)

obj <- estimateNuLinear(obj)

cells_to_rem <- getCells(obj)[getNu(obj) < UDELowThr]
obj <- dropGenesCells(obj, cells = cells_to_rem)

## -----------------------------------------------------------------------------
obj <- clean(obj)

c(pcaCellsPlot, pcaCellsData, genesPlot,
  UDEPlot, nuPlot, zoomedNuPlot) %<-% cleanPlots(obj)

plot(pcaCellsPlot)

## -----------------------------------------------------------------------------
plot(scatterPlot(obj))

## -----------------------------------------------------------------------------
logThis(paste("n cells", getNumCells(obj)), logLevel = 1L)

## -----------------------------------------------------------------------------
obj <-
  proceedToCoex(
    obj,
    calcCoex = TRUE,
    optimizeForSpeed = TRUE,
    cores = 6L,
    deviceStr = "cuda",
    saveObj = FALSE,
    outDir = outDir
  )

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # saving the structure
# saveRDS(obj, file = file.path(outDir, paste0(cond, ".cotan.RDS")))

## ----eval=FALSE, include=TRUE-------------------------------------------------
# obj2 <-
#   automaticCOTANObjectCreation(
#     raw = sample.dataset,
#     GEO = GEO,
#     sequencingMethod = "Drop_seq",
#     sampleCondition = cond,
#     calcCoex = TRUE,
#     cores = 6L,
#     optimizeForSpeed = TRUE,
#     saveObj = TRUE,
#     outDir = outDir
#   )

## -----------------------------------------------------------------------------
gdiDF <- calculateGDI(obj)

head(gdiDF)

# This will store only the $GDI column
obj <- storeGDI(obj, genesGDI = gdiDF)

## -----------------------------------------------------------------------------
genesList <- list(
  "NPGs" = c("Nes", "Vim", "Sox2", "Sox1", "Notch1", "Hes1", "Hes5", "Pax6"),
  "PNGs" = c("Map2", "Tubb3", "Neurod1", "Nefm", "Nefl", "Dcx", "Tbr1"),
  "hk"   = c("Calm1", "Cox6b1", "Ppia", "Rpl18", "Cox7c", "Erh", "H3f3a",
             "Taf1", "Taf2", "Gapdh", "Actb", "Golph3", "Zfr", "Sub1",
             "Tars", "Amacr")
)

GDIPlot(obj, cond = cond, genes = genesList, GDIThreshold = 1.40)

## -----------------------------------------------------------------------------
plot(heatmapPlot(obj, genesLists = genesList))

## ----eval=TRUE, include=TRUE--------------------------------------------------
invisible(
  genesHeatmapPlot(
    obj,
    primaryMarkers = c("Satb2", "Bcl11b", "Vim", "Hes1"),
    pValueThreshold = 0.001,
    symmetric = TRUE
  )
)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# invisible(
#   genesHeatmapPlot(
#     obj,
#     primaryMarkers = c("Satb2", "Bcl11b", "Fezf2"),
#     secondaryMarkers = c("Gabra3", "Meg3", "Cux1", "Neurod6"),
#     pValueThreshold = 0.001,
#     symmetric = FALSE
#   )
# )

## -----------------------------------------------------------------------------
print("Contingency Tables:")
contingencyTables(obj, g1 = "Satb2", g2 = "Bcl11b")

print("Corresponding Coex")
getGenesCoex(obj)["Satb2", "Bcl11b"]

## -----------------------------------------------------------------------------
# For the whole matrix
coex <- getGenesCoex(obj, zeroDiagonal = FALSE)
coex[1000L:1005L, 1000L:1005L]

## -----------------------------------------------------------------------------
# For a partial matrix
coex <- getGenesCoex(obj, genes = c("Satb2", "Bcl11b", "Fezf2"))
coex[1000L:1005L, ]

## ----eval=TRUE, include=TRUE--------------------------------------------------
layersGenes <- list(
  "L1"   = c("Reln",   "Lhx5"),
  "L2/3" = c("Satb2",  "Cux1"),
  "L4"   = c("Rorb",   "Sox5"),
  "L5/6" = c("Bcl11b", "Fezf2"),
  "Prog" = c("Vim",    "Hes1", "Dummy")
)
c(gSpace, eigPlot, pcaGenesClDF, treePlot) %<-%
  establishGenesClusters(
    obj,
    groupMarkers = layersGenes,
    numGenesPerMarker = 25L,
    kCuts = 5
  )

plot(eigPlot)

## ----eval=TRUE, include=TRUE--------------------------------------------------
plot(treePlot)

## ----eval=TRUE, include=TRUE--------------------------------------------------
colSelection <- vapply(pcaGenesClDF, is.numeric, logical(1L))
genesUmapPl <-
  UMAPPlot(
    pcaGenesClDF[, colSelection, drop = FALSE],
    clusters = getColumnFromDF(pcaGenesClDF, "hclust"),
    elements = layersGenes,
    title = "Genes' clusters UMAP Plot",
    numNeighbors = 32L,
    minPointsDist = 0.25
  )

plot(genesUmapPl)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # This code is a little too computationally heavy to be used in an example
# # So we stored the result and we can load it in the next section
# 
# # default constructed checker is OK
# advChecker <- new("AdvancedGDIUniformityCheck")
# 
# c(splitClusters, splitCoexDF) %<-%
#   cellsUniformClustering(
#     obj,
#     initialResolution = 0.8,
#     checker = advChecker,
#     optimizeForSpeed = TRUE,
#     deviceStr = "cuda",
#     cores = 6L,
#     genesSel = "HGDI",
#     saveObj = TRUE,
#     outDir = outDir
#   )
# 
# obj <-
#   addClusterization(
#     obj,
#     clName = "split",
#     clusters = splitClusters,
#     coexDF = splitCoexDF
#   )
# 
# table(splitClusters)

## ----eval=TRUE, include=TRUE--------------------------------------------------
data("vignette.split.clusters", package = "COTAN")
splitClusters <- vignette.split.clusters[getCells(obj)]

splitCoexDF <- DEAOnClusters(obj, clusters = splitClusters)

obj <-
  addClusterization(
    obj,
    clName = "split",
    clusters = splitClusters,
    coexDF = splitCoexDF,
    override = FALSE
  )

## ----eval=TRUE, include=TRUE--------------------------------------------------
c(summaryData, summaryPlot) %<-%
  clustersSummaryPlot(
    obj,
    clName = "split",
    plotTitle = "split summary"
  )

summaryData

## ----eval=TRUE, include=TRUE--------------------------------------------------
plot(summaryPlot)

## ----eval=TRUE, include=TRUE--------------------------------------------------
c(splitHeatmap, scoreDF, pValueDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    groupMarkers = layersGenes,
    clName = "split",
    kCuts = 5L,
    adjustmentMethod = "holm"
  )

ComplexHeatmap::draw(splitHeatmap)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# c(mergedClusters, mergedCoexDF) %<-%
#   mergeUniformCellsClusters(
#     obj,
#     clusters = splitClusters,
#     checkers = advChecker,
#     optimizeForSpeed = TRUE,
#     deviceStr = "cuda",
#     cores = 6L,
#     saveObj = TRUE,
#     outDir = outDir
#   )
# 
# # merges are:
# #  1 <- 06 + 07
# #  2 <- '-1' + 08 + 11
# #  3 <- 09
# #  4 <- 01
# #  5 <- 02
# #  6 <- 12
# #  7 <- 03 + 04 + 10 + 13
# #  8 <- 05
# 
# obj <-
#   addClusterization(
#     obj,
#     clName = "merge",
#     override = TRUE,
#     clusters = mergedClusters,
#     coexDF = mergedCoexDF
#   )
# 
# table(mergedClusters)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# 
# checkersList <-
#   list(
#     advChecker,
#     shiftCheckerThresholds(advChecker, 0.01),
#     shiftCheckerThresholds(advChecker, 0.03)
#   )
# 
# prevCheckRes <- data.frame()
# 
# # In this case we want to re-use the already calculated merge checks
# # Se we reload them from the output files. This, along a similar facility for
# # the split method, is also useful in the cases the execution is interrupted
# # prematurely...
# #
# if (TRUE) {
#   # read from the last file among those named all_check_results_XX.csv
#   mergeDir <- file.path(outDir, cond, "leafs_merge")
#   resFiles <-
#     list.files(
#       path = mergeDir,
#       pattern = "all_check_results_.*csv",
#       full.names = TRUE
#     )
# 
#   prevCheckRes <-
#     read.csv(resFiles[length(resFiles)], header = TRUE, row.names = 1L)
# }
# 
# c(mergedClusters2, mergedCoexDF2) %<-%
#   mergeUniformCellsClusters(
#     obj,
#     clusters = splitClusters,
#     checkers = checkersList,
#     allCheckResults = prevCheckRes,
#     optimizeForSpeed = TRUE,
#     deviceStr = "cuda",
#     cores = 6L,
#     saveObj = TRUE,
#     outDir = outDir
#   )
# 
# # merges are:
# #  1 <- '-1' + 06 + 09
# #  2 <- 07
# #  3 <- 03  + 04 + 10 + 13
# #  4 <- 12
# #  5 <- 01 + 08 + 11
# #  6 <- 02 + 05
# 
# obj <-
#   addClusterization(
#     obj,
#     clName = "merge2",
#     override = TRUE,
#     clusters = mergedClusters2,
#     coexDF = mergedCoexDF2
#   )
# 
# table(mergedClusters2)

## ----eval=TRUE, include=TRUE--------------------------------------------------
data("vignette.merge.clusters", package = "COTAN")
mergedClusters <- vignette.merge.clusters[getCells(obj)]

mergedCoexDF <- DEAOnClusters(obj, clusters = mergedClusters)

obj <-
  addClusterization(
    obj,
    clName = "merge",
    clusters = mergedClusters,
    coexDF = mergedCoexDF,
    override = FALSE
  )

data("vignette.merge2.clusters", package = "COTAN")
mergedClusters2 <- vignette.merge2.clusters[getCells(obj)]

mergedCoexDF2 <- DEAOnClusters(obj, clusters = mergedClusters2)

obj <-
  addClusterization(
    obj,
    clName = "merge2",
    clusters = mergedClusters2,
    coexDF = mergedCoexDF2,
    override = FALSE
  )

table(mergedClusters2, mergedClusters)

## ----eval=TRUE, include=TRUE--------------------------------------------------
c(mergeHeatmap, mergeScoresDF, mergePValuesDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    clName = "merge",
    condNameList = "split",
    conditionsList = list(splitClusters)
  )

ComplexHeatmap::draw(mergeHeatmap)


c(merge2Heatmap, merge2ScoresDF, merge2PValuesDF) %<-%
  clustersMarkersHeatmapPlot(
    obj,
    clName = "merge2",
    condNameList = "split",
    conditionsList = list(splitClusters)
  )

ComplexHeatmap::draw(merge2Heatmap)

## -----------------------------------------------------------------------------
c(umapPlot, cellsRDM) %<-%
  cellsUMAPPlot(
    obj,
    clName = "merge2",
    clusters = NULL,
    useCoexEigen = TRUE,
    dataMethod = "LogLikelihood",
    numComp = 50L,
    genesSel = "HGDI",
    numGenes = 200L,
    colors = NULL,
    numNeighbors = 30L,
    minPointsDist = 0.3
  )

plot(umapPlot)

## -----------------------------------------------------------------------------
if (file.exists(file.path(outDir, paste0(cond, ".cotan.RDS")))) {
  #Delete file if it exists
  file.remove(file.path(outDir, paste0(cond, ".cotan.RDS")))
}
if (file.exists(file.path(outDir, paste0(cond, "_times.csv")))) {
  #Delete file if it exists
  file.remove(file.path(outDir, paste0(cond, "_times.csv")))
}
if (dir.exists(file.path(outDir, cond))) {
  unlink(file.path(outDir, cond), recursive = TRUE)
}
if (dir.exists(file.path(outDir, GEO))) {
  unlink(file.path(outDir, GEO), recursive = TRUE)
}

# stop logging to file
setLoggingFile("")
file.remove(file.path(outDir, "vignette_v2.log"))

options(parallelly.fork.enable = FALSE)

## -----------------------------------------------------------------------------
Sys.time()

## -----------------------------------------------------------------------------
sessionInfo()

