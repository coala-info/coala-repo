# Code example from 'spitzer' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results = "asis"-----------------------------------
BiocStyle::markdown()

## ---- eval=FALSE-----------------------------------------------------------
#  if (!requireNamespace("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install("cytofast")

## --------------------------------------------------------------------------
library(cytofast)

## ----echo=FALSE------------------------------------------------------------
cfList(samples = data.frame(sampleID = as.factor(1:10)),
       expr = data.frame(sampleID = as.factor(1:10), clusterID=letters[1:10]), 
       counts = data.frame())

## ---- eval=TRUE------------------------------------------------------------
dirFCS <- system.file("extdata", package="cytofast")
cfData <- readCytosploreFCS(dir = dirFCS, colNames = "description")

## ---- eval=T---------------------------------------------------------------
cfData@expr[1:5, 1:5]

## ---- eval=T---------------------------------------------------------------
cfData@expr <- cfData@expr[,-c(3:10, 13:16, 55:59, 61:63)]

## ---- eval=T---------------------------------------------------------------
data(spitzer) 
meta <- spitzer[match(row.names(cfData@samples), spitzer[,"CSPLR_ST"]),] # match sampleID
cfData@samples <- cbind(cfData@samples, meta[,2:3])

## ---- eval=T---------------------------------------------------------------
levels(cfData@expr[,"clusterID"]) <- gsub("[^0-9]", "", levels(cfData@expr[,"clusterID"]))  

## ---- eval=F---------------------------------------------------------------
#  cfData <- cellCounts(cfData)
#  head(cfData@counts)

## ---- eval=T---------------------------------------------------------------
cfData <- cellCounts(cfData, frequency = TRUE, scale = TRUE)
head(cfData@counts)

## ----fig.width=10, fig.height=12, fig.cap="\\label{fig:fig2}Cytofast heatmap"----
cytoHeatmaps(cfData, group="group", legend=TRUE)

## ---- eval=T---------------------------------------------------------------
cytoBoxplots(cfData, group = "group")

## ---- eval=T---------------------------------------------------------------
msiPlot(cfData, markers = c("MHC.II", "CD45", "CD4"), byGroup='group')

## ---- eval=F---------------------------------------------------------------
#  cfData@samples$effect <- gsub("_D\\d", "", spitzer$group) # difference between effective and ineffective
#  cfData <- cytottest(cfData, group="effect", adjustMethod = "bonferroni")

## ---- eval=F---------------------------------------------------------------
#  library(FlowSOM)
#  fSOM <- FlowSOM(input = dirFCS,
#                  transform = FALSE,
#                  scale = FALSE,
#                  colsToUse = c(9:11, 15:52),
#                  nClus = 10, # We simply choose 10 clusters here
#                  seed = 123)

## ---- eval=F---------------------------------------------------------------
#  clusterID_FS <- as.factor(fSOM$FlowSOM$map$mapping[,1])
#  levels(clusterID_FS) <- fSOM$metaclustering

## ----fig.width=10, fig.height=12, fig.cap="\\label{fig:fig3}heatmap based on flowSOM", eval=F----
#  cfData@expr$clusterID <- clusterID_FS
#  cfData <- cellCounts(cfData) # Update cellCounts with new clusters
#  cytoHeatmaps(cfData, group='group', legend=TRUE)

