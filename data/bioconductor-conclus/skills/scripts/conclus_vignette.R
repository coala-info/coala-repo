# Code example from 'conclus_vignette' vignette. See references/ for full tutorial.

## ----runConclus_first, eval=FALSE---------------------------------------------
#  library(conclus)
#  
#  outputDirectory <- tempdir()
#  experimentName <- "Test"
#  species <- "mouse"
#  
#  countmatrixPath <- system.file("extdata/countMatrix.tsv", package="conclus")
#  countMatrix <- loadDataOrMatrix(file=countmatrixPath, type="countMatrix",
#                                  ignoreCellNumber=TRUE)
#  
#  coldataPath <- system.file("extdata/colData.tsv", package="conclus")
#  columnsMetaData <- loadDataOrMatrix(file=coldataPath, type="coldata",
#                          columnID="cell_ID")
#  
#  sceObjectCONCLUS <- runCONCLUS(outputDirectory, experimentName, countMatrix,
#                              species, columnsMetaData=columnsMetaData,
#                              perplexities=c(2,3), tSNENb=1,
#                              PCs=c(4,5,6,7,8,9,10), epsilon=c(380, 390, 400),
#                              minPoints=c(2,3), clusterNumber=4)
#  

## ----format_data--------------------------------------------------------------

library(conclus)

outputDirectory <- tempdir()
dir.create(outputDirectory, showWarnings=FALSE)
species <- "mouse"

countMatrixPath <- file.path(outputDirectory, "countmatrix.txt")
metaDataPath <- file.path(outputDirectory, "metaData.txt")
matrixURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM492",
"3493&format=file&file=GSM4923493%5FE11%5F5%5Frawcounts%5Fmatrix%2Etsv%2Egz")
metaDataURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/download/?acc=",
"GSM4923493&format=file&file=GSM4923493%5FMetadata%5FE11%5F5%2Etxt%2Egz")

result <- retrieveFromGEO(matrixURL, countMatrixPath, species,
metaDataPath=metaDataPath, colMetaDataURL=metaDataURL)
countMatrix <- result[[1]]
columnsMetaData <- result[[2]]
## Correct the columns names to fit conclus input requirement
## The columns should be: cellName, state, and cellBarcode
columnsMetaData <- columnsMetaData[,c(1,3,2)]
colnames(columnsMetaData) <- c("cellName", "state", "cellBarcode")

## Removing embryonic hemoglobins with names starting with "Hba" or "Hbb"
idxHba <- grep("Hba", rownames(countMatrix))
idxHbb <- grep("Hbb", rownames(countMatrix))
countMatrix <- countMatrix[-c(idxHba, idxHbb),]

## Removing control human cells
idxHumanPos <- which(columnsMetaData$state == "Pos Ctrl")
idxHumanNeg <- which(columnsMetaData$state == "Neg Ctrl")
columnsMetaData <- columnsMetaData[-c(idxHumanPos, idxHumanNeg),]
countMatrix <- countMatrix[,-c(idxHumanPos, idxHumanNeg)]

## Removing genes not having an official symbol
idxENS <- grep("ENSMUSG", rownames(countMatrix))
countMatrix <- countMatrix[-idxENS,]

## ----local_data, eval=FALSE---------------------------------------------------
#  
#  ## countMatrixPath <- ""
#  ## metaDataPath <- ""
#  
#  countMatrix <- loadDataOrMatrix(countMatrixPath, type="countMatrix")
#  columnsMetaData <- loadDataOrMatrix(file=metaDataPath, type="coldata",
#                                      columnID="")
#  
#  ## Filtering steps to add here as performed above

## ----normalization_1----------------------------------------------------------

## Creation of the single-cell RNA-Seq object
scr <- singlecellRNAseq(experimentName = "E11_5",
        countMatrix     = countMatrix,
        species         = "mouse",
        outputDirectory = outputDirectory)

## Normalization of the count matrix
scr <- normaliseCountMatrix(scr, coldata=columnsMetaData)

## ----testClustering, results="hide", eval=FALSE-------------------------------
#  p <- testClustering(scr, writeOutput=TRUE, silent=TRUE)

## ----testClustering_result1, results="hide", fig.keep = 'none', eval=FALSE----
#  # saved as "outputDirectory/test_clustering/test_tSNE.pdf"
#  p[[1]]

## ----testClustering_result2, results="hide", fig.keep = 'none', eval=FALSE----
#  # saved as "outputDirectory/test_clustering/test_clustering.pdf"
#  p[[2]]

## ----normalization_2, eval=FALSE----------------------------------------------
#  scr <- normaliseCountMatrix(scr, coldata=columnsMetaData)

## ----normalization_results----------------------------------------------------
## Accessing slots
originalMat <- getCountMatrix(scr)
SCEobject <- getSceNorm(scr)
normMat <- SingleCellExperiment::logcounts(SCEobject)

# checking what changed after the normalisation
dim(originalMat)
dim(normMat)

# show first columns and rows of the count matrix
originalMat[1:5,1:5]

# show first columns and rows of the normalized count matrix
normMat[1:5,1:5]

# visualize first rows of metadata (coldata)
coldataSCE <- as.data.frame(SummarizedExperiment::colData(SCEobject))
head(coldataSCE)

# visualize beginning of the rowdata containing gene information
rowdataSCE <- as.data.frame(SummarizedExperiment:::rowData(SCEobject))
head(rowdataSCE)

## ----tsne_generation----------------------------------------------------------
scr <- generateTSNECoordinates(scr, cores=2)

## ----tsne_showResults---------------------------------------------------------
tsneList <- getTSNEList(scr)
head(getCoordinates(tsneList[[1]]))

## ----runDBSScan---------------------------------------------------------------
scr <- runDBSCAN(scr, cores=2)

## ----dbscan_showResults-------------------------------------------------------
dbscanList <- getDbscanList(scr)
clusteringList <- lapply(dbscanList, getClustering)
clusteringList[[1]][, 1:10]

## ----clusterCellsInternal-----------------------------------------------------
scr <- clusterCellsInternal(scr, clusterNumber=10)

## ----clusterCellsInternal_showResults-----------------------------------------
cci <- getCellsSimilarityMatrix(scr)
cci[1:10, 1:10]

## ----clustersSimilarityMatrix-------------------------------------------------
scr <- calculateClustersSimilarity(scr)
csm <- getClustersSimilarityMatrix(scr)
csm[1:10, 1:10]

## ----plotClustered, eval=FALSE------------------------------------------------
#  tSNEclusters <- plotClusteredTSNE(scr, columnName="clusters",
#                  returnPlot=TRUE, silentPlot=TRUE)
#  
#  tSNEnoColor <- plotClusteredTSNE(scr, columnName="noColor",
#                  returnPlot=TRUE, silentPlot=TRUE)
#  
#  tSNEstate <- plotClusteredTSNE(scr, columnName="state",
#                  returnPlot=TRUE, silentPlot=TRUE)

## ----plotClustered_visualization1, results="hide", fig.keep = 'none', eval=FALSE----
#  tSNEclusters[[5]]

## ----plotClustered_visualization2, results="hide", fig.keep = 'none', eval=FALSE----
#  tSNEnoColor[[5]]

## ----plotClustered_visualization3, results="hide", fig.keep = 'none', eval=FALSE----
#  tSNEstate[[5]]

## ----plotCellSimilarity, results="hide", fig.keep = 'none', eval=FALSE--------
#  plotCellSimilarity(scr)

## ----plotClustersSimilarity, results="hide", fig.keep = 'none', eval=FALSE----
#  plotClustersSimilarity(scr)

## ----rankGenes----------------------------------------------------------------
scr <- rankGenes(scr)

## ----rankGenes_result---------------------------------------------------------
markers <- getMarkerGenesList(scr)
head(markers[[1]])

## ----topMarkers_result--------------------------------------------------------
scr <- retrieveTopClustersMarkers(scr, removeDuplicates=TRUE)
topMarkers <- getClustersMarkers(scr)
topMarkers

## ----plotCellHeatmap_marker1, results="hide", fig.keep = 'none', eval=FALSE----
#  plotCellHeatmap(scr, orderClusters=TRUE, orderGenes=TRUE)

## ----plotCellHeatmap_marker2, results="hide", fig.keep = 'none', eval=FALSE----
#  plotCellHeatmap(scr, orderClusters=TRUE, orderGenes=TRUE, meanCentered=FALSE)

## ----plotGeneExpression1, eval=FALSE------------------------------------------
#  plotGeneExpression(scr, "Maob", tSNEpicture=5)

## ----plotGeneExpression2, eval=FALSE------------------------------------------
#  plotGeneExpression(scr, "Pcbd1", tSNEpicture=5)

## ----plotGeneExpression3, eval=FALSE------------------------------------------
#  plotGeneExpression(scr, "Serpinf2", tSNEpicture=5)

## ----plotGeneExpression4, eval=FALSE------------------------------------------
#  plotGeneExpression(scr, "Cldn1", tSNEpicture=5)

## ----getGenesInfo-------------------------------------------------------------
scr <- retrieveGenesInfo(scr)
result <- getGenesInfos(scr)
head(result)

## ----merging_clusters, eval=FALSE---------------------------------------------
#  ## Retrieving the table indicating to which cluster each cell belongs
#  clustCellsDf <- retrieveTableClustersCells(scr)
#  
#  ## Replace "2/10" by "1/9" to merge 1/2 and 9/10
#  clustCellsDf$clusters[which(clustCellsDf$clusters == 2)] <- 1
#  clustCellsDf$clusters[which(clustCellsDf$clusters == 10)] <- 9
#  
#  ## Modifying the object to take into account the new classification
#  scrUpdated <- addClustering(scr, clusToAdd=clustCellsDf)

## ----addClusteringManually_visualization2, results="hide", fig.keep = 'none', eval=FALSE----
#  plotCellSimilarity(scrUpdated)

## ----addClusteringManually_visualization3, results="hide", fig.keep = 'none', eval=FALSE----
#  plotCellHeatmap(scrUpdated, orderClusters=TRUE, orderGenes=TRUE)

## ----addClusteringManually_visualization4, results="hide", fig.keep = 'none', eval=FALSE----
#  tSNEclusters <- plotClusteredTSNE(scrUpdated, columnName="clusters",
#                                      returnPlot=TRUE, silentPlot=TRUE)
#  tSNEclusters[[5]]

## ----replot1, eval=FALSE------------------------------------------------------
#  plotGeneExpression(scrUpdated, "Col1a1", tSNEpicture=5)

## ----replot2, eval=FALSE------------------------------------------------------
#  plotGeneExpression(scrUpdated, "Cdk8", tSNEpicture=5)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

