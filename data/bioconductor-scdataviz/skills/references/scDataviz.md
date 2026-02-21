# scDataviz: single cell dataviz and downstream analyses

#### Kevin Blighe

#### 2025-10-30

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 1. Download the package from Bioconductor](#download-the-package-from-bioconductor)
  + [2.2 2. Load the package into R session](#load-the-package-into-r-session)
* [3 Tutorial 1: CyTOF FCS data](#tutorial-1-cytof-fcs-data)
  + [3.1 Perform principal component analysis (PCA)](#perform-principal-component-analysis-pca)
  + [3.2 Perform UMAP](#perform-umap)
  + [3.3 Create a contour plot of the UMAP layout](#create-a-contour-plot-of-the-umap-layout)
  + [3.4 Show marker expression across the layout](#show-marker-expression-across-the-layout)
  + [3.5 Shade cells by metadata](#shade-cells-by-metadata)
  + [3.6 Find ideal clusters in the UMAP layout via k-nearest neighbours](#find-ideal-clusters-in-the-umap-layout-via-k-nearest-neighbours)
  + [3.7 Plot marker expression per identified cluster](#plot-marker-expression-per-identified-cluster)
  + [3.8 Determine enriched markers in each cluster and plot the expression signature](#determine-enriched-markers-in-each-cluster-and-plot-the-expression-signature)
* [4 Tutorial 2: Import from Seurat](#tutorial-2-import-from-seurat)
* [5 Tutorial 3: Import any numerical data](#tutorial-3-import-any-numerical-data)
* [6 Acknowledgments](#acknowledgments)
* [7 Session info](#session-info)
* [8 References](#references)

# 1 Introduction

In the single cell World, which includes flow cytometry, mass cytometry, single-cell RNA-seq (scRNA-seq), and others, there is a need to improve data visualisation and to bring analysis capabilities to researchers even from non-technical backgrounds. *scDataviz* (Blighe 2020) attempts to fit into this space, while also catering for advanced users. Additonally, due to the way that *scDataviz* is designed, which is based on *SingleCellExperiment* (Lun and Risso 2020), it has a ‘plug and play’ feel, and immediately lends itself as flexibile and compatibile with studies that go beyond *scDataviz*. Finally, the graphics in *scDataviz* are generated via the *ggplot* (Wickham 2016) engine, which means that users can ‘add on’ features to these with ease.

This package just provides some additional functions for dataviz and clustering, and provides another way of identifying cell-types in clusters. It is not strictly intended as a standalone analysis package. For a comprehensive high-dimensional cytometry workflow, it is recommended to check out the work by Nowicka *et al.* [CyTOF workflow: differential discovery in high-throughput high-dimensional cytometry datasets](https://f1000research.com/articles/6-748). For a more comprehensive scRNA-seq workflow, please check out [OSCA](https://osca.bioconductor.org) and [Analysis of single cell RNA-seq data](https://scrnaseq-course.cog.sanger.ac.uk/website/index.html).

# 2 Installation

## 2.1 1. Download the package from Bioconductor

```
  if (!requireNamespace('BiocManager', quietly = TRUE))
    install.packages('BiocManager')

  BiocManager::install('scDataviz')
```

Note: to install development version:

```
  devtools::install_github('kevinblighe/scDataviz')
```

## 2.2 2. Load the package into R session

```
  library(scDataviz)
```

# 3 Tutorial 1: CyTOF FCS data

Here, we will utilise some of the flow cytometry data from [Deep phenotyping detects a pathological CD4+ T-cell complosome signature in systemic sclerosis](https://www.nature.com/articles/s41423-019-0360-8).

This can normally be downloadedd via `git clone` from your command prompt:

```
  git clone https://github.com/kevinblighe/scDataviz_data/ ;
```

In a practical situation, we would normally read in this data from the raw FCS files and then QC filter, normalise, and transform them. This can be achieved via the `processFCS` function, which, by default, also removes variables based on low variance and downsamples [randomly] your data to 100000 variables. The user can change these via the `downsample` and `downsampleVar` parameters. An example (*not run*) is given below:

```
  filelist <- list.files(
    path = "scDataviz_data/FCS/",
    pattern = "*.fcs|*.FCS",
    full.names = TRUE)
  filelist

  metadata <- data.frame(
    sample = gsub('\\ [A-Za-z0-9]*\\.fcs$', '',
      gsub('scDataviz_data\\/FCS\\/\\/', '', filelist)),
    group = c(rep('Healthy', 7), rep('Disease', 11)),
    treatment = gsub('\\.fcs$', '',
      gsub('scDataviz_data\\/FCS\\/\\/[A-Z0-9]*\\ ', '', filelist)),
    row.names = filelist,
    stringsAsFactors = FALSE)
  metadata

  inclusions <- c('Yb171Di','Nd144Di','Nd145Di',
    'Er168Di','Tm169Di','Sm154Di','Yb173Di','Yb174Di',
    'Lu175Di','Nd143Di')

  markernames <- c('Foxp3','C3aR','CD4',
    'CD46','CD25','CD3','Granzyme B','CD55',
    'CD279','CD45RA')

  names(markernames) <- inclusions
  markernames

  exclusions <- c('Time','Event_length','BCKG190Di',
    'Center','Offset','Width','Residual')

  sce <- processFCS(
    files = filelist,
    metadata = metadata,
    transformation = TRUE,
    transFun = function (x) asinh(x),
    asinhFactor = 5,
    downsample = 10000,
    downsampleVar = 0.7,
    colsRetain = inclusions,
    colsDiscard = exclusions,
    newColnames = markernames)
```

In flow and mass cytometry, getting the correct marker names in the FCS files can be surprisingly difficult. In many cases, from experience, a facility may label the markers by their metals, such as Iridium (Ir), Ruthenium (Ru), Terbium (Tb), *et cetera* - this is the case for the data used in this tutorial. The true marker names may be held as pData encoded within each FCS, accessible via:

```
  library(flowCore)
  pData(parameters(
    read.FCS(filelist[[4]], transformation = FALSE, emptyValue = FALSE)))
```

Whatever the case, it is important to sort out marker naming issues prior to the experiment being conducted in order to avoid any confusion.

For this vignette, due to the fact that the raw FCS data is > 500 megabytes, we will work with a smaller pre-prepared dataset that has been downsampled to 10000 cells using the above code. This data comes included with the package.

Load the pre-prepared complosome data.

```
  load(system.file('extdata/', 'complosome.rdata', package = 'scDataviz'))
```

One can also create a new *SingleCellExperiment* object manually using any type of data, including any data from scRNA-seq produced elsewhere. Import functions for data deriving from other sources is covered in Tutorials 2 and 3 in this vignette. All functions in *scDataviz* additionally accept data-frames or matrices on their own, de-necessitating the reliance on the *SingleCellExperiment* class.

## 3.1 Perform principal component analysis (PCA)

We can use the *PCAtools* (Blighe and Lun 2020) package for the purpose of performing PCA.

```
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
```

![Perform PCA](data:image/png;base64...)

Perform PCA

We can add the rotated component loadings as a new reduced dimensional component to our dataset.

```
  reducedDim(sce, 'PCA') <- p$rotated
```

For more functionality via *PCAtools*, check the vignette: [PCAtools: everything Principal Component Analysis](https://bioconductor.org/packages/release/bioc/vignettes/PCAtools/inst/doc/PCAtools.html)

## 3.2 Perform UMAP

UMAP can be performed on the entire dataset, if your computer’s memory will permit. Currently it’s default is to use the data contained in the ‘scaled’ assay component of your *SingleCellExperiment* object.

```
  sce <- performUMAP(sce)
```

UMAP can also be stratified based on a column in your metadata, e.g., (treated versus untreated samples); however, to do this, I recommend creating separate *SingleCellExperiment* objects from the very start, i.e., from the the data input stage, and processing the data separately for each group.

**Nota bene** - advanced users may want to change the default configuration for UMAP. *scDataviz* currently performs UMAP via the *umap* package. In order to modify the default configuration, one can pull in the default config separately from the *umap* package and then modify these config values held in the *umap.defaults* variable, as per the [umap vignette](https://cran.r-project.org/web/packages/umap/vignettes/umap.html) (see ‘Tuning UMAP’ section). For example:

```
  config <- umap::umap.defaults
  config$min_dist <- 0.5
  performUMAP(sce, config = config)
```

We can also perform UMAP on a select number of PC eigenvectors. *PCAtools* (Blighe and Lun 2020) can be used to infer ideal number of dimensions to use via the elbow method and Horn’s parallel analysis.

```
  elbow <- findElbowPoint(p$variance)
  horn <- parallelPCA(assay(sce, 'scaled'))

  elbow
```

```
## PC3
##   3
```

```
  horn$n
```

```
## [1] 1
```

For now, let’s just use 5 PCs.

```
  sce <- performUMAP(sce, reducedDim = 'PCA', dims = c(1:5))
```

## 3.3 Create a contour plot of the UMAP layout

This and the remaining sections in this tutorial are about producing great visualisations of the data and attempting to make sense of it, while not fully overlapping with functionalioty provided by other programs that operate in tis space.

With the contour plot, we are essentially looking at celluar density. It can provide for a beautiful viusualisation in a manuscript while also serving as a useful QC tool: if the density is ‘scrunched up’ into a single area in the plot space, then there are likely issues with your input data distribution. We want to see well-separated, high density ‘islands’, or, at least, gradual gradients that blend into one another across high density ‘peaks’.

```
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
```

![Create a contour plot of the UMAP layout](data:image/png;base64...)

Create a contour plot of the UMAP layout

## 3.4 Show marker expression across the layout

Here, we randomly select some markers and then plot their expression profiles across the UMAP layouts.

```
  markers <- sample(rownames(sce), 6)
  markers
```

```
## [1] "CD55"   "CD25"   "Foxp3"  "C3aR"   "CD46"   "CD45RA"
```

```
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
```

![Show marker expression across the layout](data:image/png;base64...)

Show marker expression across the layout

## 3.5 Shade cells by metadata

Shading cells by metadata can be useful for identifying any batch effects, but also useful for visualising, e.g., differences across treatments.

First, let’s take a look inside the metadata that we have.

```
  head(metadata(sce))
```

```
##       sample   group treatment
## cell1    P00 Disease    Unstim
## cell2    P00 Disease    Unstim
## cell3    P04 Disease      CD46
## cell4    P03 Disease      CD46
## cell5    P08 Disease    Unstim
## cell6    P00 Disease      CD46
```

```
  levels(metadata(sce)$group)
```

```
## [1] "Healthy" "Disease"
```

```
  levels(metadata(sce)$treatment)
```

```
## [1] "CD46"   "Unstim" "CD3"
```

```
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
```

![Shade cells by metadata](data:image/png;base64...)

Shade cells by metadata

## 3.6 Find ideal clusters in the UMAP layout via k-nearest neighbours

This function utilises the k nearest neighbours (k-NN) approach from Seurat, which works quite well on flow cytometry and CyTOF UMAP layouts, from my experience.

```
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
```

![Find ideal clusters in the UMAP layout via k-nearest neighbours](data:image/png;base64...)

Find ideal clusters in the UMAP layout via k-nearest neighbours

## 3.7 Plot marker expression per identified cluster

```
  markerExpressionPerCluster(sce,
    caption = 'Cluster assignments based on UMAP performed on expression values',
    stripLabSize = 22,
    axisLabSize = 22,
    titleLabSize = 22,
    subtitleLabSize = 18,
    captionLabSize = 18)
```

```
  clusters <- unique(metadata(sce)[['Cluster_PCA']])
  clusters
```

```
## [1] 2 0 1 6 4 3 5 8 7
```

```
  markers <- sample(rownames(sce), 5)
  markers
```

```
## [1] "CD25"       "Granzyme B" "CD46"       "CD45RA"     "CD279"
```

```
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
```

![Plot marker expression per identified cluster2](data:image/png;base64...)

Plot marker expression per identified cluster2

Try all markers across a single cluster:

```
  cluster <- sample(unique(metadata(sce)[['Cluster']]), 1)
  cluster
```

```
## [1] 7
```

```
  markerExpressionPerCluster(sce,
    clusters = cluster,
    markers = rownames(sce),
    stripLabSize = 20,
    axisLabSize = 20,
    titleLabSize = 20,
    subtitleLabSize = 14,
    captionLabSize = 12)
```

![Plot marker expression per identified cluster3](data:image/png;base64...)

Plot marker expression per identified cluster3

## 3.8 Determine enriched markers in each cluster and plot the expression signature

This method also calculates metacluster abundances across a chosen phenotype. The function returns a data-frame, which can then be exported to do other analyses.

### 3.8.1 Disease vs Healthy metacluster abundances

```
  markerEnrichment(sce,
    method = 'quantile',
    studyvarID = 'group')
```

| Cluster | nCells | TotalCells | PercentCells | NegMarkers | PosMarkers | PerCent\_HD00 | PerCent\_HD01 | PerCent\_HD262 | PerCent\_P00 | PerCent\_P02 | PerCent\_P03 | PerCent\_P04 | PerCent\_P08 | nCell\_Healthy | nCell\_Disease |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | 3308 | 10000 | 33.08 | NA | CD25+ | 0.0604595 | 9.9758162 | 26.299879 | 23.5489722 | 6.4087062 | 8.2527207 | 18.1680774 | 7.2853688 | 1202 | 2106 |
| 1 | 1927 | 10000 | 19.27 | CD25-CD279- | CD3+CD45RA+ | 0.0000000 | 0.1037883 | 61.961598 | 0.6746238 | 0.2075765 | 0.0518941 | 0.0518941 | 36.9486248 | 1196 | 731 |
| 2 | 1513 | 10000 | 15.13 | NA | CD25+ | 5.2875083 | 0.9914078 | 14.144085 | 2.7759418 | 19.7620621 | 5.7501652 | 46.4639788 | 4.8248513 | 309 | 1204 |
| 3 | 1303 | 10000 | 13.03 | Granzyme B-CD279- | CD3+ | 15.5794321 | 7.9815810 | 2.455871 | 63.7759018 | 3.8372985 | 3.6838066 | 1.9186493 | 0.7674597 | 339 | 964 |
| 4 | 960 | 10000 | 9.60 | NA | CD3+ | 16.5625000 | 26.0416667 | 7.604167 | 28.0208333 | 3.2291667 | 10.0000000 | 6.0416667 | 2.5000000 | 482 | 478 |
| 5 | 560 | 10000 | 5.60 | CD25- | NA | 0.3571429 | 15.0000000 | 36.785714 | 9.8214286 | 0.1785714 | 8.9285714 | 0.1785714 | 28.7500000 | 292 | 268 |
| 6 | 320 | 10000 | 3.20 | CD46-CD279- | CD3+ | 0.0000000 | 39.6875000 | 1.875000 | 51.2500000 | 0.3125000 | 5.3125000 | 0.6250000 | 0.9375000 | 133 | 187 |
| 7 | 109 | 10000 | 1.09 | CD46- | CD25+ | 0.9174312 | 0.0000000 | 0.000000 | 0.0000000 | 67.8899083 | 27.5229358 | 3.6697248 | 0.0000000 | 1 | 108 |

.

### 3.8.2 Treatment type metacluster abundances

```
  markerEnrichment(sce,
    sampleAbundances = FALSE,
    method = 'quantile',
    studyvarID = 'treatment')
```

| Cluster | nCells | TotalCells | PercentCells | NegMarkers | PosMarkers | nCell\_CD46 | nCell\_Unstim | nCell\_CD3 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | 3308 | 10000 | 33.08 | NA | CD25+ | 3283 | 2 | 23 |
| 1 | 1927 | 10000 | 19.27 | CD25-CD279- | CD3+CD45RA+ | 4 | 1919 | 4 |
| 2 | 1513 | 10000 | 15.13 | NA | CD25+ | 20 | 409 | 1084 |
| 3 | 1303 | 10000 | 13.03 | Granzyme B-CD279- | CD3+ | 5 | 1175 | 123 |
| 4 | 960 | 10000 | 9.60 | NA | CD3+ | 4 | 770 | 186 |
| 5 | 560 | 10000 | 5.60 | CD25- | NA | 166 | 28 | 366 |
| 6 | 320 | 10000 | 3.20 | CD46-CD279- | CD3+ | 308 | 10 | 2 |
| 7 | 109 | 10000 | 1.09 | CD46- | CD25+ | 107 | 0 | 2 |

.

### 3.8.3 Expression signature

The expression signature is a quick way to visualise which markers are more or less expressed in each identified cluster of cells.

```
  plotSignatures(sce,
    labCex = 1.2,
    legendCex = 1.2,
    labDegree = 40)
```

![Determine enriched markers in each cluster and plot the expression signature](data:image/png;base64...)

Determine enriched markers in each cluster and plot the expression signature

# 4 Tutorial 2: Import from Seurat

Due to the fact that *scDataviz* is based on *SingleCellExperiment*, it has increased interoperability with other packages, including the popular *Seurat* (Stuart et al. 2018). Taking the data produced from the [Seurat Tutorial](https://satijalab.org/seurat/v3.1/pbmc3k_tutorial.html) on Peripheral Blood Mononuclear Cells (PBMCs), we can convert this to a *SingleCellExperiment* object recognisable by *scDataviz* via `as.SingleCellExperiment()`.

When deriving from the Seurat route, be sure to manually assign the metadata slot, which is required for some functions. Also be sure to modify the default values for `assay`, `reducedDim`, and `dimColnames`, as these are assigned differently in Seurat.

```
  sce <- as.SingleCellExperiment(pbmc)

  metadata(sce) <- data.frame(colData(sce))

  markerExpression(sce,
    assay = 'logcounts',
    reducedDim = 'UMAP',
    dimColnames = c('UMAP_1','UMAP_2'),
    markers = c('CD79A', 'Cd79B', 'MS4A1'))
```

For `markerEnrichment()`, a typical command using an ex-Seurat object could be:

```
  markerEnrichment(sce,
    assay = 'logcounts',
    method = 'quantile',
    sampleAbundances = TRUE,
    sampleID = 'orig.ident',
    studyvarID = 'ident',
    clusterAssign = as.character(colData(sce)[['seurat_clusters']]))
```

# 5 Tutorial 3: Import any numerical data

*scDataviz* will work with any numerical data, too. Here, we show a quick example of how one can import a data-matrix of randomly-generated numbers that follow a negative binomial distribution, comprising 2500 cells and 20 markers:

```
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
```

```
##       group
## cell1     A
## cell2     A
## cell3     A
## cell4     A
## cell5     A
## cell6     A
```

```
  sce <- importData(mat,
    assayname = 'normcounts',
    metadata = metadata)
  sce
```

```
## class: SingleCellExperiment
## dim: 20 2500
## metadata(1): group
## assays(1): normcounts
## rownames(20): CD1 CD2 ... CD19 CD20
## rowData names(0):
## colnames(2500): cell1 cell2 ... cell2499 cell2500
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

This will also work without any assigned metadata; however, having no metadata limits the functionality of the package.

```
  sce <- importData(mat,
    assayname = 'normcounts',
    metadata = NULL)
  sce
```

```
## class: SingleCellExperiment
## dim: 20 2500
## metadata(0):
## assays(1): normcounts
## rownames(20): CD1 CD2 ... CD19 CD20
## rowData names(0):
## colnames(2500): cell1 cell2 ... cell2499 cell2500
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# 6 Acknowledgments

* Jessica Timms
* James Opzoomer
* Shahram Kordasti
* Marcel Ramos (Bioconductor)
* Lori Shepherd (Bioconductor)
* Bioinformatics CRO
* Henrik Bengtsson

# 7 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] PCAtools_2.22.0             ggrepel_0.9.6
##  [3] ggplot2_4.0.0               scDataviz_1.20.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              kableExtra_1.4.0
## [17] knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        rstudioapi_0.17.1
##   [3] jsonlite_2.0.0            umap_0.2.10.0
##   [5] magrittr_2.0.4            spatstat.utils_3.2-0
##   [7] corrplot_0.95             farver_2.1.2
##   [9] rmarkdown_2.30            vctrs_0.6.5
##  [11] ROCR_1.0-11               DelayedMatrixStats_1.32.0
##  [13] spatstat.explore_3.5-3    askpass_1.2.1
##  [15] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [17] SparseArray_1.10.0        sass_0.4.10
##  [19] sctransform_0.4.2         parallelly_1.45.1
##  [21] KernSmooth_2.23-26        bslib_0.9.0
##  [23] htmlwidgets_1.6.4         ica_1.0-3
##  [25] plyr_1.8.9                plotly_4.11.0
##  [27] zoo_1.8-14                cachem_1.1.0
##  [29] igraph_2.2.1              mime_0.13
##  [31] lifecycle_1.0.4           pkgconfig_2.0.3
##  [33] rsvd_1.0.5                Matrix_1.7-4
##  [35] R6_2.6.1                  fastmap_1.2.0
##  [37] fitdistrplus_1.2-4        future_1.67.0
##  [39] shiny_1.11.1              digest_0.6.37
##  [41] patchwork_1.3.2           Seurat_5.3.1
##  [43] tensor_1.5.1              dqrng_0.4.1
##  [45] RSpectra_0.16-2           irlba_2.3.5.1
##  [47] textshaping_1.0.4         beachmat_2.26.0
##  [49] labeling_0.4.3            cytolib_2.22.0
##  [51] progressr_0.17.0          spatstat.sparse_3.1-0
##  [53] httr_1.4.7                polyclip_1.10-7
##  [55] abind_1.4-8               compiler_4.5.1
##  [57] withr_3.0.2               S7_0.2.0
##  [59] BiocParallel_1.44.0       fastDummies_1.7.5
##  [61] MASS_7.3-65               openssl_2.3.4
##  [63] DelayedArray_0.36.0       tools_4.5.1
##  [65] lmtest_0.9-40             otel_0.2.0
##  [67] httpuv_1.6.16             future.apply_1.20.0
##  [69] goftest_1.2-3             glue_1.8.0
##  [71] nlme_3.1-168              promises_1.4.0
##  [73] grid_4.5.1                Rtsne_0.17
##  [75] cluster_2.1.8.1           reshape2_1.4.4
##  [77] isoband_0.2.7             gtable_0.3.6
##  [79] spatstat.data_3.1-9       tidyr_1.3.1
##  [81] data.table_1.17.8         ScaledMatrix_1.18.0
##  [83] BiocSingular_1.26.0       sp_2.2-0
##  [85] xml2_1.4.1                XVector_0.50.0
##  [87] spatstat.geom_3.6-0       RcppAnnoy_0.0.22
##  [89] RANN_2.6.2                pillar_1.11.1
##  [91] stringr_1.5.2             spam_2.11-1
##  [93] RcppHNSW_0.6.0            later_1.4.4
##  [95] flowCore_2.22.0           splines_4.5.1
##  [97] dplyr_1.1.4               lattice_0.22-7
##  [99] survival_3.8-3            deldir_2.0-4
## [101] RProtoBufLib_2.22.0       tidyselect_1.2.1
## [103] miniUI_0.1.2              pbapply_1.7-4
## [105] gridExtra_2.3             svglite_2.2.2
## [107] scattermore_1.2           xfun_0.53
## [109] stringi_1.8.7             lazyeval_0.2.2
## [111] yaml_2.3.10               evaluate_1.0.5
## [113] codetools_0.2-20          tibble_3.3.0
## [115] cli_3.6.5                 uwot_0.2.3
## [117] xtable_1.8-4              reticulate_1.44.0
## [119] systemfonts_1.3.1         jquerylib_0.1.4
## [121] dichromat_2.0-0.1         Rcpp_1.1.0
## [123] globals_0.18.0            spatstat.random_3.4-2
## [125] png_0.1-8                 spatstat.univar_3.1-4
## [127] parallel_4.5.1            dotCall64_1.2
## [129] sparseMatrixStats_1.22.0  listenv_0.9.1
## [131] viridisLite_0.4.2         scales_1.4.0
## [133] ggridges_0.5.7            SeuratObject_5.2.0
## [135] purrr_1.1.0               rlang_1.1.6
## [137] cowplot_1.2.0
```

# 8 References

﻿Blighe (2020)

Blighe and Lun (2020)

Lun and Risso (2020)

Stuart et al. (2018)

Wickham (2016)

Blighe, K. 2020. “scDataviz: single cell dataviz and downstream analyses.” <https://github.com/kevinblighe/scDataviz>.

Blighe, K, and A Lun. 2020. “PCAtools: everything Principal Component Analysis.” <https://github.com/kevinblighe/PCAtools>.

Lun, A, and D Risso. 2020. “SingleCellExperiment: S4 Classes for Single Cell Data.” <https://bioconductor.org/packages/SingleCellExperiment>.

Stuart, Tim, Andrew Butler, Paul Hoffman, Christoph Hafemeister, Efthymia Papalexi, William M Mauck III, Marlon Stoeckius, Peter Smibert, and Rahul Satija. 2018. “Comprehensive Integration of Single Cell Data.” *bioRxiv*. <https://doi.org/10.1101/460147>.

Wickham, H. 2016. “ggplot2: Elegant Graphics for Data Analysis.” Springer-Verlag New York, ISBN: 978-3-319-24277-4.