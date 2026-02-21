# Code example from 'scmap' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE, cache=TRUE------
library(googleVis)
op <- options(gvis.plot.tag='chart')

## ----warning=FALSE, message=FALSE---------------------------------------------
library(SingleCellExperiment)
library(scmap)

head(ann)
yan[1:3, 1:3]

## -----------------------------------------------------------------------------
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(yan)), colData = ann)
logcounts(sce) <- log2(normcounts(sce) + 1)
# use gene names as feature symbols
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
sce <- sce[!duplicated(rownames(sce)), ]
sce

## -----------------------------------------------------------------------------
sce <- selectFeatures(sce, suppress_plot = FALSE)

## -----------------------------------------------------------------------------
table(rowData(sce)$scmap_features)

## -----------------------------------------------------------------------------
sce <- indexCluster(sce)

## -----------------------------------------------------------------------------
head(metadata(sce)$scmap_cluster_index)

## ----fig.height=7-------------------------------------------------------------
heatmap(as.matrix(metadata(sce)$scmap_cluster_index))

## -----------------------------------------------------------------------------
scmapCluster_results <- scmapCluster(
  projection = sce, 
  index_list = list(
    yan = metadata(sce)$scmap_cluster_index
  )
)

## -----------------------------------------------------------------------------
head(scmapCluster_results$scmap_cluster_labs)

## -----------------------------------------------------------------------------
head(scmapCluster_results$scmap_cluster_siml)

## -----------------------------------------------------------------------------
head(scmapCluster_results$combined_labs)

## ----results='asis', tidy=FALSE, eval=FALSE-----------------------------------
# plot(
#   getSankey(
#     colData(sce)$cell_type1,
#     scmapCluster_results$scmap_cluster_labs[,'yan'],
#     plot_height = 400
#   )
# )

## -----------------------------------------------------------------------------
set.seed(1)

## ----message=FALSE, warning=FALSE---------------------------------------------
sce <- indexCell(sce)

## -----------------------------------------------------------------------------
names(metadata(sce)$scmap_cell_index)

## -----------------------------------------------------------------------------
length(metadata(sce)$scmap_cell_index$subcentroids)
dim(metadata(sce)$scmap_cell_index$subcentroids[[1]])
metadata(sce)$scmap_cell_index$subcentroids[[1]][,1:5]

## -----------------------------------------------------------------------------
dim(metadata(sce)$scmap_cell_index$subclusters)
metadata(sce)$scmap_cell_index$subclusters[1:5,1:5]

## -----------------------------------------------------------------------------
scmapCell_results <- scmapCell(
  sce, 
  list(
    yan = metadata(sce)$scmap_cell_index
  )
)

## -----------------------------------------------------------------------------
names(scmapCell_results)

## -----------------------------------------------------------------------------
scmapCell_results$yan$cells[,1:3]

## -----------------------------------------------------------------------------
scmapCell_results$yan$similarities[,1:3]

## -----------------------------------------------------------------------------
scmapCell_clusters <- scmapCell2Cluster(
  scmapCell_results, 
  list(
    as.character(colData(sce)$cell_type1)
  )
)

## -----------------------------------------------------------------------------
head(scmapCell_clusters$scmap_cluster_labs)

## -----------------------------------------------------------------------------
head(scmapCell_clusters$scmap_cluster_siml)

## -----------------------------------------------------------------------------
head(scmapCell_clusters$combined_labs)

## ----results='asis', tidy=FALSE, eval=FALSE-----------------------------------
# plot(
#   getSankey(
#     colData(sce)$cell_type1,
#     scmapCell_clusters$scmap_cluster_labs[,"yan"],
#     plot_height = 400
#   )
# )

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

