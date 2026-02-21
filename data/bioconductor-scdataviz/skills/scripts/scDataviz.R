# Code example from 'scDataviz' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------

  suppressWarnings(library(knitr))

  suppressWarnings(library(kableExtra))

  opts_chunk$set(tidy = FALSE, message = FALSE, warning = FALSE)


## ----getPackage, eval = FALSE-------------------------------------------------
# 
#   if (!requireNamespace('BiocManager', quietly = TRUE))
#     install.packages('BiocManager')
# 
#   BiocManager::install('scDataviz')
# 

## ----getPackageDevel, eval = FALSE--------------------------------------------
# 
#   devtools::install_github('kevinblighe/scDataviz')
# 

## ----Load, message = FALSE----------------------------------------------------

  library(scDataviz)


## ----readFCS, eval = FALSE----------------------------------------------------
# 
#   filelist <- list.files(
#     path = "scDataviz_data/FCS/",
#     pattern = "*.fcs|*.FCS",
#     full.names = TRUE)
#   filelist
# 
#   metadata <- data.frame(
#     sample = gsub('\\ [A-Za-z0-9]*\\.fcs$', '',
#       gsub('scDataviz_data\\/FCS\\/\\/', '', filelist)),
#     group = c(rep('Healthy', 7), rep('Disease', 11)),
#     treatment = gsub('\\.fcs$', '',
#       gsub('scDataviz_data\\/FCS\\/\\/[A-Z0-9]*\\ ', '', filelist)),
#     row.names = filelist,
#     stringsAsFactors = FALSE)
#   metadata
# 
#   inclusions <- c('Yb171Di','Nd144Di','Nd145Di',
#     'Er168Di','Tm169Di','Sm154Di','Yb173Di','Yb174Di',
#     'Lu175Di','Nd143Di')
# 
#   markernames <- c('Foxp3','C3aR','CD4',
#     'CD46','CD25','CD3','Granzyme B','CD55',
#     'CD279','CD45RA')
# 
#   names(markernames) <- inclusions
#   markernames
# 
#   exclusions <- c('Time','Event_length','BCKG190Di',
#     'Center','Offset','Width','Residual')
# 
#   sce <- processFCS(
#     files = filelist,
#     metadata = metadata,
#     transformation = TRUE,
#     transFun = function (x) asinh(x),
#     asinhFactor = 5,
#     downsample = 10000,
#     downsampleVar = 0.7,
#     colsRetain = inclusions,
#     colsDiscard = exclusions,
#     newColnames = markernames)
# 

## ----readFCSparameters, eval = FALSE------------------------------------------
# 
#   library(flowCore)
#   pData(parameters(
#     read.FCS(filelist[[4]], transformation = FALSE, emptyValue = FALSE)))
# 

## ----load---------------------------------------------------------------------

  load(system.file('extdata/', 'complosome.rdata', package = 'scDataviz'))
  

## ----ex1, fig.height = 7, fig.width = 8, fig.cap = 'Perform PCA'--------------

  library(PCAtools)
  p <- pca(assay(sce, 'scaled'), metadata = metadata(sce))

  biplot(p,
    x = 'PC1', y = 'PC2',
    lab = NULL,
    xlim = c(min(p$rotated[,'PC1'])-1, max(p$rotated[,'PC1'])+1),
    ylim = c(min(p$rotated[,'PC2'])-1, max(p$rotated[,'PC2'])+1),
    pointSize = 1.0,
    colby = 'treatment',
    legendPosition = 'right',
    title = 'PCA applied to CyTOF data',
    caption = paste0('10000 cells randomly selected after ',
      'having filtered for low variance'))


## ----addPCAdim----------------------------------------------------------------

  reducedDim(sce, 'PCA') <- p$rotated


## ----performUMAP--------------------------------------------------------------

  sce <- performUMAP(sce)


## ----eval = FALSE, echo = TRUE------------------------------------------------
# 
#   config <- umap::umap.defaults
#   config$min_dist <- 0.5
#   performUMAP(sce, config = config)
# 

## ----elbowHorn----------------------------------------------------------------

  elbow <- findElbowPoint(p$variance)
  horn <- parallelPCA(assay(sce, 'scaled'))

  elbow
  horn$n


## ----performUMAP_PCA----------------------------------------------------------

  sce <- performUMAP(sce, reducedDim = 'PCA', dims = c(1:5))


## ----ex2, fig.height = 7.5, fig.width = 16, fig.cap = 'Create a contour plot of the UMAP layout'----

  ggout1 <- contourPlot(sce,
    reducedDim = 'UMAP',
    bins = 150,
    subtitle = 'UMAP performed on expression values',
    legendLabSize = 18,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)

  ggout2 <- contourPlot(sce,
    reducedDim = 'UMAP_PCA',
    bins = 150,
    subtitle = 'UMAP performed on PC eigenvectors',
    legendLabSize = 18,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)

  cowplot::plot_grid(ggout1, ggout2,
    labels = c('A','B'),
    ncol = 2, align = "l", label_size = 24)


## ----ex3, fig.height = 12, fig.width = 20, fig.cap = 'Show marker expression across the layout'----

  markers <- sample(rownames(sce), 6)
  markers

  ggout1 <- markerExpression(sce,
    markers = markers,
    subtitle = 'UMAP performed on expression values',
    nrow = 1, ncol = 6,
    legendKeyHeight = 1.0,
    legendLabSize = 18,
    stripLabSize = 22,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)

  ggout2 <- markerExpression(sce,
    markers = markers,
    reducedDim = 'UMAP_PCA',
    subtitle = 'UMAP performed on PC eigenvectors',
    nrow = 1, ncol = 6,
    col = c('white', 'darkblue'),
    legendKeyHeight = 1.0,
    legendLabSize = 18,
    stripLabSize = 22,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)

  cowplot::plot_grid(ggout1, ggout2,
    labels = c('A','B'),
    nrow = 2, align = "l", label_size = 24)


## ----metadataPlot-------------------------------------------------------------

  head(metadata(sce))

  levels(metadata(sce)$group)

  levels(metadata(sce)$treatment)


## ----ex4, fig.height = 12, fig.width = 14, fig.cap = 'Shade cells by metadata', message = FALSE----

  ggout1 <- metadataPlot(sce,
    colby = 'group',
    colkey = c(Healthy = 'royalblue', Disease = 'red2'),
    title = 'Disease status',
    subtitle = 'UMAP performed on expression values',
    legendLabSize = 16,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  ggout2 <- metadataPlot(sce,
    reducedDim = 'UMAP_PCA',
    colby = 'group',
    colkey = c(Healthy = 'royalblue', Disease = 'red2'),
    title = 'Disease status',
    subtitle = 'UMAP performed on PC eigenvectors',
    legendLabSize = 16,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  ggout3 <- metadataPlot(sce,
    colby = 'treatment',
    title = 'Treatment type',
    subtitle = 'UMAP performed on expression values',
    legendLabSize = 16,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  ggout4 <- metadataPlot(sce,
    reducedDim = 'UMAP_PCA',
    colby = 'treatment',
    title = 'Treatment type',
    subtitle = 'UMAP performed on PC eigenvectors',
    legendLabSize = 16,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  cowplot::plot_grid(ggout1, ggout3, ggout2, ggout4,
    labels = c('A','B','C','D'),
    nrow = 2, ncol = 2, align = "l", label_size = 24)


## ----ex5, message = FALSE, fig.height = 8, fig.width = 14, fig.cap = 'Find ideal clusters in the UMAP layout via k-nearest neighbours'----

  sce <- clusKNN(sce,
    k.param = 20,
    prune.SNN = 1/15,
    resolution = 0.01,
    algorithm = 2,
    verbose = FALSE)

  sce <- clusKNN(sce,
    reducedDim = 'UMAP_PCA',
    clusterAssignName = 'Cluster_PCA',
    k.param = 20,
    prune.SNN = 1/15,
    resolution = 0.01,
    algorithm = 2,
    verbose = FALSE)

  ggout1 <- plotClusters(sce,
    clusterColname = 'Cluster',
    labSize = 7.0,
    subtitle = 'UMAP performed on expression values',
    caption = paste0('Note: clusters / communities identified via',
      '\nLouvain algorithm with multilevel refinement'),
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  ggout2 <- plotClusters(sce,
    clusterColname = 'Cluster_PCA',
    reducedDim = 'UMAP_PCA',
    labSize = 7.0,
    subtitle = 'UMAP performed on PC eigenvectors',
    caption = paste0('Note: clusters / communities identified via',
      '\nLouvain algorithm with multilevel refinement'),
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 16,
    captionLabSize = 16)

  cowplot::plot_grid(ggout1, ggout2,
    labels = c('A','B'),
    ncol = 2, align = "l", label_size = 24)


## ----ex6a, eval = FALSE-------------------------------------------------------
# 
#   markerExpressionPerCluster(sce,
#     caption = 'Cluster assignments based on UMAP performed on expression values',
#     stripLabSize = 22,
#     axisLabSize = 22,
#     titleLabSize = 22,
#     subtitleLabSize = 18,
#     captionLabSize = 18)
# 

## ----ex6b, fig.height = 7, fig.width = 12, fig.cap = 'Plot marker expression per identified cluster2'----

  clusters <- unique(metadata(sce)[['Cluster_PCA']])
  clusters

  markers <- sample(rownames(sce), 5)
  markers

  markerExpressionPerCluster(sce,
    clusters = clusters,
    clusterAssign = metadata(sce)[['Cluster_PCA']],
    markers = markers,
    nrow = 2, ncol = 5,
    caption = 'Cluster assignments based on UMAP performed on PC eigenvectors',
    stripLabSize = 22,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)


## ----ex6c, fig.height = 6, fig.width = 8, fig.cap = 'Plot marker expression per identified cluster3'----

  cluster <- sample(unique(metadata(sce)[['Cluster']]), 1)
  cluster

  markerExpressionPerCluster(sce,
    clusters = cluster,
    markers = rownames(sce),
    stripLabSize = 20,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 14,
    captionLabSize = 12)


## ----echo = TRUE, eval = FALSE------------------------------------------------
# 
#   markerEnrichment(sce,
#     method = 'quantile',
#     studyvarID = 'group')
# 

## ----echo = TRUE, eval = FALSE------------------------------------------------
# 
#   markerEnrichment(sce,
#     sampleAbundances = FALSE,
#     method = 'quantile',
#     studyvarID = 'treatment')
# 

## ----ex7, fig.height = 8, fig.width = 6, fig.cap = 'Determine enriched markers in each cluster and plot the expression signature'----

  plotSignatures(sce,
    labCex = 1.2,
    legendCex = 1.2,
    labDegree = 40)


## ----import_Seurat1, eval = FALSE---------------------------------------------
# 
#   sce <- as.SingleCellExperiment(pbmc)
# 
#   metadata(sce) <- data.frame(colData(sce))
# 
#   markerExpression(sce,
#     assay = 'logcounts',
#     reducedDim = 'UMAP',
#     dimColnames = c('UMAP_1','UMAP_2'),
#     markers = c('CD79A', 'Cd79B', 'MS4A1'))
# 

## ----import_Seurat2, eval = FALSE---------------------------------------------
# 
#   markerEnrichment(sce,
#     assay = 'logcounts',
#     method = 'quantile',
#     sampleAbundances = TRUE,
#     sampleID = 'orig.ident',
#     studyvarID = 'ident',
#     clusterAssign = as.character(colData(sce)[['seurat_clusters']]))
# 

## ----importRandomData1--------------------------------------------------------

  mat <- jitter(matrix(
    MASS::rnegbin(rexp(50000, rate=.1), theta = 4.5),
    ncol = 20))
  colnames(mat) <- paste0('CD', 1:ncol(mat))
  rownames(mat) <- paste0('cell', 1:nrow(mat))

  metadata <- data.frame(
    group = rep('A', nrow(mat)),
    row.names = rownames(mat),
    stringsAsFactors = FALSE)
  head(metadata)

  sce <- importData(mat,
    assayname = 'normcounts',
    metadata = metadata)
  sce


## ----importRandomData2--------------------------------------------------------

  sce <- importData(mat,
    assayname = 'normcounts',
    metadata = NULL)
  sce


## -----------------------------------------------------------------------------

sessionInfo()


