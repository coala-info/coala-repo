Code

* Show All Code
* Hide All Code

# *spatialHeatmap*: Co-visualizing Bulk and Single-cell Assay Data

Authors: Jianhai Zhang and Thomas Girke

#### Last update: 22 January, 2026

#### Package

spatialHeatmap 2.16.3

# 1 Introduction

This vignette showcases key functionalities of the `spatialHeatmap` package, with a detailed description of the project available [here](https://spatialheatmap.org/).

## 1.1 Overview

The primary utility of the *spatialHeatmap* package is the generation of
spatial heatmaps (SHMs) for visualizing cell-, tissue- and organ-specific
abundance patterns of biological molecules (*e.g.* RNAs) in spatial anatomical images (Zhang et al. [2024](#ref-shm)). This is useful for identifying biomolecules with spatially enriched/depleted
abundance patterns as well as clusters and/or network modules composed of
biomolecules sharing similar abundance patterns such as similar gene expression
patterns. These functionalities are introduced in the [main
vignette](https://bioconductor.org/packages/release/bioc/html/spatialHeatmap.html)
of this package. The following describes extended
functionalities for integrating tissue with single-cell data by
co-visualizing them in composite plots that combine SHMs with
embedding plots of high-dimensional data. The resulting spatial context
information is important for gaining insights into the tissue-level organization
of single cell data or vice versa.

## 1.2 Data Structures

The supported bulk and single-cell assay data come from most large-scale profiling technologies such as transcriptomics, proteomics, metabolomics, etc, while the corresponding anatomical images need to be supplied as annotated SVG ([aSVG](https://bioconductor.org/packages/devel/bioc/vignettes/spatialHeatmap/inst/doc/spatialHeatmap.html#13_Image_Format:_SVG)) images, where spatial features (e.g. tissues) are assigned unique identifiers.

To implement the co-visualization functionality, *spatialHeatmap* takes advantage of efficient and reusable S4 classes for both assay data and aSVGs respectively. The former includes the Bioconductor core data structures `SummarizedExperiment` (`SE`, Morgan et al. ([2018](#ref-se))) and `SingleCellExperiment` (`SCE`, Amezquita et al. ([2020](#ref-sce))) for bulk and single-cell data respectively (Figure [1](#fig:datastr)A, C). The slots
`assays`, `colData`, and `rowData` contain expression values,
tissue/cell metadata, and biomolecule metadata respectively. For the embedding plots of single-cell data, the reduced dimensionality embedding results (PCA, UMAP or tSNE) are stored in the `reducedDims` slot of `SCE`.

The S4 class `SVG` (Figure [1](#fig:datastr)B) is developed specifically in `spatialHeatmap` for storing aSVG instances. The two most important slots `coordinate` and `attribute` stores the aSVG feature coordinates and respective attributes (colors, line withs, etc) respectively, while other slots `dimension`, `svg`, and `raster` stores image dimension, original aSVG instances, and raster image paths respectively. Moreover, the meta class `SPHM` (Figure [1](#fig:datastr)D) is developed to harmonize these data objects.

When creating co-visualization plots (Figure [1](#fig:datastr)a-b), SHMs are created by mapping expression values from `SE` to corresponding spatial features in `SVG` through the same identifiers (here TissuesA and TissueB) between the two, and single cells in `SCE` are associated with spatial features through their group labels (here TissuesA and TissueB) stored in the `colData` slot.

![Schematic view of data structures and creation of co-visualization plots. File imports, classes, and plotting functionalities are illustrated in boxes with color-coded title bars in grey, blue and green, respectively. Quantitative and experimental design data (I) are imported into matching slots of an `SE` container (A). aSVG image files are stored in `SVG` containers (B). Expression profiles of a chosen gene (GeneX) in (A) are mapped to the corresponding spatial features in (B) via common identifiers (here TissuesA and TissueB). The quantitative data is represented in the matching features by colors according to a number to color key and the output is an SHM (a). For co-visualization plots, single-cell data are stored in the `SCE` object class (C). Reduced dimension data for embedding plots can be generated in R or imported from files. The single-cell embedding results are co-visualized with SHMs where the cell-to-tissue mappings are indicated by common colors in the co-visualization plot (b). The `SPHM` meta class organizes the individual objects (A)-(C) along with internally generated data.](data:image/jpeg;base64...)

Figure 1: Schematic view of data structures and creation of co-visualization plots
File imports, classes, and plotting functionalities are illustrated in boxes with color-coded title bars in grey, blue and green, respectively. Quantitative and experimental design data (I) are imported into matching slots of an `SE` container (A). aSVG image files are stored in `SVG` containers (B). Expression profiles of a chosen gene (GeneX) in (A) are mapped to the corresponding spatial features in (B) via common identifiers (here TissuesA and TissueB). The quantitative data is represented in the matching features by colors according to a number to color key and the output is an SHM (a). For co-visualization plots, single-cell data are stored in the `SCE` object class (C). Reduced dimension data for embedding plots can be generated in R or imported from files. The single-cell embedding results are co-visualized with SHMs where the cell-to-tissue mappings are indicated by common colors in the co-visualization plot (b). The `SPHM` meta class organizes the individual objects (A)-(C) along with internally generated data.

## 1.3 Cell-Tissue Mapping and Coloring

To co-visualize bulk and single-cell data (Figure
[1](#fig:datastr)b), the individual cells of the single-cell data are mapped
via their group labels to the corresponding tissue features in an aSVG image. For handling cell grouping
information, five major methods are supported including (1)
existing annotation labels, (2) manual assignments, (3) marker genes, (4) clustering labels, and (5) automated co-clustering (Figure [2](#fig:grpcolor)a). In the
annotation method, existing group labels are available and can be
uploaded and/or stored in the `SCE` object, such as the `SCE`
instances in the `scRNAseq` package (Risso and Cole [2022](#ref-scrnaseq)). The manual method allows users to create cell-tissue associations one-by-one or import
them from a tabular file. The marker-gene method utilizes known marker genes to group cells. In the clustering method, cells are clustered and grouped by clustering labels. In contrast, the automated co-clustering aims to
assign source tissues to corresponding single cells computationally by a
co-clustering method (Figure [8](#fig:coclusOver)). This method is
experimental and requires bulk expression data that are obtained from the
tissues represented in the single-cell data.

The matching between cell groups in the embedding plots and tissue features in SHMs are indicated with four coloring schemes (Figure [2](#fig:grpcolor)b). The first three ‘fixed-group’, ‘cell-by-group’, and ‘feature-by-group’ assign the same color for a cell group and matching tissue. The main difference is that ‘fixed-group’ uses constance colors while the latter two uses heat colors that is proportional to the numeric expression information obtained from the single cell or bulk expression data of a chosen gene. When expression values among groups are very similar, toggling between the constant and heat colors is important to track the tissue origin in
the single cell data. In ‘cell-by-group’ coloring, expression values of a given gene within each cell group are summarized by mean or median, then heat colors are created from the summary values and assigned to the corresponding cells and tissues (Figure [2](#fig:grpcolor).1-2). In this case, the mapping direction is cell-to-tissue. The ‘feature-by-group’ coloring is similar except that heat colors are based on summary values of each tissue, and the mapping direction is tissue-to-cell. The most meaningful coloring is ‘cell-by-value’ (Figure [2](#fig:grpcolor).2-3). In this option, each cell and tissue is colored independently according to respective expression values of a chosen gene, so the cellular heterogeneity is reflected.

Similar to other functionalities in *spatialHeatmap*, these functionalities are available within R as well as the corresponding [Shiny App](#autoSCE) (Chang et al. [2021](#ref-shiny)).

![Cell grouping and coloring. (a) For co-visualizing with SHMs, single cells need to have group labels. Five methods are supported to obtain group labels. (b) In the co-visualization plot, matching between cells and aSVG features is indicated by colors between the two. Four coloring options are summarized in a table. The cell grouping and coloring are schematically illustrated in 1-3.](data:image/jpeg;base64...)

Figure 2: Cell grouping and coloring
(a) For co-visualizing with SHMs, single cells need to have group labels. Five methods are supported to obtain group labels. (b) In the co-visualization plot, matching between cells and aSVG features is indicated by colors between the two. Four coloring options are summarized in a table. The cell grouping and coloring are schematically illustrated in 1-3.

# 2 Getting Started

## 2.1 Installation

The `spatialHeatmap` package can be installed with the `BiocManager::install` command.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("spatialHeatmap")
```

## 2.2 Packages and Documentation

Next, the packages required for running the sample code in this vignette need to be loaded.

```
library(spatialHeatmap); library(SummarizedExperiment); library(ggplot2); library(SingleCellExperiment);
library(kableExtra); library(Seurat)
```

The following lists the vignette(s) of this package in an HTML browser.
Clicking the name of the corresponding vignette will open it.

```
browseVignettes('spatialHeatmap')
```

To reduce runtime, intermediate results can be cached under `~/.cache/shm`.

```
cache.pa <- '~/.cache/shm' # Set path of the cache directory
```

# 3 Quick Start

To obtain for examples with randomized data or parameters always the same results, a fixed seed is set.

```
set.seed(10)
```

This quick start example is demonstrated on ‘cell-by-group’ coloring by using a single-cell data set from oligodendrocytes of mouse brain (Marques et al. [2016](#ref-Marques2016-ff)), which is obtained from the `scRNAseq` (Risso and Cole [2022](#ref-scrnaseq)).

The single-cell data is first pre-processed by the `process_cell_meta` function that applies common QC, normalization and dimension reduction routines.
The details of these pre-processing methods are described in the corresponding
help file. Additional background information on these topics can be found in the
[OSCA](http://bioconductor.org/books/3.14/OSCA.workflows/zeisel-mouse-brain-strt-seq.html) tutorial.

```
sce.pa <- system.file("extdata/shinyApp/data", "cell_mouse_brain.rds", package="spatialHeatmap")
sce <- readRDS(sce.pa)
sce.dimred.quick <- process_cell_meta(sce, qc.metric=list(subsets=list(Mt=rowData(sce)$featureType=='mito'), threshold=1))
colData(sce.dimred.quick)[1:3, 1:2]
```

```
## DataFrame with 3 rows and 2 columns
##                              label         age
##                        <character> <character>
## C1.1772096.085.B10          SN.VTA         p19
## C1.1772125.088.G02 corpus.callosum         p22
## C1.1772099.084.C06    zona.incerta         p19
```

The gene expression values in single-cell data
are averaged within their group labels in the `label` column of `colData` slot, which correspond to their source tissues.

```
sce.aggr.quick <- aggr_rep(sce.dimred.quick, assay.na='logcounts', sam.factor='label', aggr='mean')
```

The aSVG of mouse brain is imported with the function `read_svg` and stored in an `SVG` object `svg.mus.brain`.

```
svg.mus.brain.pa <- system.file("extdata/shinyApp/data", "mus_musculus.brain.svg", package="spatialHeatmap")
svg.mus.brain <- read_svg(svg.mus.brain.pa)
```

A subset of features and related attributes are returned from `svg.mus.brain`, where `fill` and `stroke` refer to color and line width respectively.

```
tail(attribute(svg.mus.brain)[[1]])[, 1:4]
```

```
## # A tibble: 6 × 4
##   feature                      id             fill  stroke
##   <chr>                        <chr>          <chr>  <dbl>
## 1 brainstem                    UBERON_0002298 none    0.05
## 2 midbrain                     UBERON_0001891 none    0.05
## 3 dorsal.plus.ventral.thalamus UBERON_0001897 none    0.05
## 4 hypothalamus                 UBERON_0001898 none    0.05
## 5 nose                         UBERON_0000004 none    0.05
## 6 corpora.quadrigemina         UBERON_0002259 none    0.05
```

Due to differences in naming conventions, cell group labels and tissue labels are often programatically different. To match the two, a `list` with named components is used, where cell labels are in name slots and tissue features are corresponding `list` elements (translation map). This is a general approach for ensuring cell group labels and tissue labels are programmatically matched. Note, in the cell-to-tisssue mapping, each cell label can be matched to multiple aSVG features but not vice versa.

```
lis.match.quick <- list(hypothalamus=c('hypothalamus'), cortex.S1=c('cerebral.cortex', 'nose'))
```

For efficient data management and reusability, the data objects for co-visualization are stored in an `SPHM` container.

```
dat.quick <- SPHM(svg=svg.mus.brain, bulk=sce.aggr.quick, cell=sce.dimred.quick, match=lis.match.quick)
```

The co-visualization plot is created with gene `Apod` using the function `covis`. In the embedding plot, the `hypothalamus` and `cortex.S1` cells are colored according to their respecitive aggregated expression values of `Apod`. In the SHM plot, aSVG features are assigned the same color as the matching cells defined in `lis.match.quick`. The `cell.group` argument refers to cell group labels in the `colData` slot of `sce.aggr.quick`, `tar.cell` specifies the target cell groups to show, and `dimred` specifies the embeddings.

```
shm.res.quick <- covis(data=dat.quick, ID=c('Apod'), dimred='UMAP', cell.group='label', tar.cell=names(lis.match.quick), assay.na='logcounts', bar.width=0.09, dim.lgd.nrow=2, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=4, h=0.6, verbose=FALSE)
```

![Co-visualization of 'cell-by-group' coloring. The co-visualization is created with gene `Apod`. Single cells in the embedding plot and their matching aSVG features in the SHM are assigned the same colors that are created according to mean expression values of `Apod` within cell groups.](data:image/png;base64...)

Figure 3: Co-visualization of ‘cell-by-group’ coloring
The co-visualization is created with gene `Apod`. Single cells in the embedding plot and their matching aSVG features in the SHM are assigned the same colors that are created according to mean expression values of `Apod` within cell groups.

# 4 Co-visualization Plots

This section showcases different cell grouping methods (Figure [2](#fig:grpcolor)a) and coloring options (Figure [2](#fig:grpcolor)b) for co-visualizing SHMs with single-cell embedding plots. As the cell grouping methods of annotation labels, clustering, manual assignments, and marker genes are very similar, this section only demonstrates the methods of annotation labels as well as automated co-clustering. The clustering/manual assignments are shown in the [Supplementary Section](#manClus). The ‘cell-by-group’ coloring is already showcased in the Quick Start, thus this section focuses on the other three coloring options. In addition, the co-visualization functioinality is demonstrated with patially resolved single-cell (SRSC) data.

## 4.1 Annotation Labels

To obtain reproducible results, a fixed seed is set for generating random numbers.

```
set.seed(10)
```

This section demonstrates the co-visualization plots created with annotation labels and ‘feature-by-group’ coloring. The single-cell data are stored in an `SCE` object downloaded from the `scRNAseq` package (Risso and Cole [2022](#ref-scrnaseq)), which is the same as the [Quick Start](#test) (`sce`). The annotation labels are stored in the `label` column of the `colData` slot and partially shown below.

```
colData(sce)[1:3, 1:2]
```

```
## DataFrame with 3 rows and 2 columns
##                              label         age
##                        <character> <character>
## C1.1772096.085.B10          SN.VTA         p19
## C1.1772125.088.G02 corpus.callosum         p22
## C1.1772099.084.C06    zona.incerta         p19
```

The bulk RNA-seq data are modified from a research on mouse cerebellar development (Vacher et al. [2021](#ref-Vacher2021-xg)) and are imported in an `SE` object, which are partially shown below. Note, replicates
are indicated by the same tissue names (*e.g.* `cerebral.cortex`).

```
blk.mus.pa <- system.file("extdata/shinyApp/data", "bulk_mouse_cocluster.rds", package="spatialHeatmap")
blk.mus <- readRDS(blk.mus.pa)
assay(blk.mus)[1:3, 1:5]
```

```
##          cerebral.cortex hippocampus hypothalamus cerebellum cerebral.cortex
## AI593442             177         256           50         24             285
## Actr3b               513        1465          228        244             666
## Adcy1                701        1243           57       1910             836
```

```
colData(blk.mus)[1:3, , drop=FALSE]
```

```
## DataFrame with 3 rows and 1 column
##                          tissue
##                     <character>
## cerebral.cortex cerebral.cortex
## hippocampus         hippocampus
## hypothalamus       hypothalamus
```

Bulk and single cell data are jointly normalized and subsequently separated.

```
mus.ann.nor <- read_cache(cache.pa, 'mus.ann.nor')
if (is.null(mus.ann.nor)) {
  # Joint normalization.
  mus.lis.nor <- norm_cell(sce=sce, bulk=blk.mus, quick.clus=list(min.size = 100, d=15), com=FALSE)
  save_cache(dir=cache.pa, overwrite=TRUE, mus.ann.nor)
}
```

```
## Cache directory: ~/.cache/shm
```

```
## [1] "~/.cache/shm"
```

```
# Separate bulk and cell data.
blk.mus.nor <- mus.lis.nor$bulk
cell.mus.nor <- mus.lis.nor$cell
colData(cell.mus.nor) <- colData(sce)
```

In normalized single-cell data, dimension reductions are performed with PAC, UMAP, and TSNE methods respectively, then single cells are plotted at the TSNE dimensions, where cells are represented by dots and are colored by the annotation labels (`color.by="label"`).

```
cell.dim <- reduce_dim(cell.mus.nor, min.dim=5)
```

```
## "prop" is set 1 in "getTopHVGs" due to too less genes.
```

```
plot_dim(cell.dim, color.by="label", dim='UMAP')
```

![Embedding plot of single-cell data. The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object](data:image/png;base64...)

Figure 4: Embedding plot of single-cell data
The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object

In normalized bulk data, expression values for each gene are summarized by mean across tissue replicates (here `aggr='mean'`).

```
# Aggregation.
blk.mus.aggr <- aggr_rep(blk.mus.nor, sam.factor='sample', aggr='mean')
assay(blk.mus.aggr)[1:2, ]
```

The aSVG instance of mouse brain from the Quick Start is used. Partial of the aSVG features are shown.

```
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4]
```

```
## # A tibble: 3 × 4
##   feature                      id             fill  stroke
##   <chr>                        <chr>          <chr>  <dbl>
## 1 brainstem                    UBERON_0002298 none    0.05
## 2 midbrain                     UBERON_0001891 none    0.05
## 3 dorsal.plus.ventral.thalamus UBERON_0001897 none    0.05
```

Following the same conventions in the main vignette, at least one tissue in bulk data should have the same identifier with an aSVG feature so as to create SHM.

```
colnames(blk.mus) %in% attribute(svg.mus.brain)[[1]]$feature
```

```
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

Same with the [Quick Start](#list), a translation `list` is used to match cell group and tissue labels. In ‘feature-by-group’ coloring, the feature and cell labels should be be the names and corresponding elements of the `list`, respectively.

```
lis.match.blk <- list(cerebral.cortex=c('cortex.S1'), hypothalamus=c('corpus.callosum', 'hypothalamus'))
```

The following plots the corresponding co-visualization for sample gene ‘Cacnb4’. The legend under the embedding plot shows the cell labels in the matching list (`lis.match.blk`). The source tissue information is indicated by using the same colors in the embedding and SHM plots on the left and right, respectively. In contrast to the Quick Start, the `tar.bulk` indicates target tissues to show.

```
# Store data objects in an SPHM container.
dat.ann.tocell <- SPHM(svg=svg.mus.brain, bulk=blk.mus.aggr, cell=cell.dim, match=lis.match.blk)
covis(data=dat.ann.tocell, ID=c('Cacnb4'), dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.09, dim.lgd.nrow=2, dim.lgd.text.size=12, h=0.6, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=3)
```

![Co-visualization plot with 'feature-by-group' coloring. This plot is created with gene 'Cacnb4'. Tissues in SHM are colored according to respective expression values of 'Cacnb4', and cells of each group in the embedding plot are assigned the same colors as the matching tissues in SHM.](data:image/png;base64...)

Figure 5: Co-visualization plot with ‘feature-by-group’ coloring
This plot is created with gene ‘Cacnb4’. Tissues in SHM are colored according to respective expression values of ‘Cacnb4’, and cells of each group in the embedding plot are assigned the same colors as the matching tissues in SHM.

In scenarios where expression values are similar across tissues, the mapping between cells and tissues can be indicated by constant colors by setting `profile=FALSE`.

```
covis(data=dat.ann.tocell, ID=c('Cacnb4'), profile=FALSE, dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.09, dim.lgd.nrow=2, dim.lgd.text.size=12, h=0.8, legend.r=1.5, legend.key.size=0.02, legend.text.size=10, legend.nrow=3)
```

![Co-visualization plot of constant colors. In this plot, mapping beween cell groups and tissues are indicated by fixed colors instead of expression values. ](data:image/png;base64...)

Figure 6: Co-visualization plot of constant colors
In this plot, mapping beween cell groups and tissues are indicated by fixed colors instead of expression values.

In the above examples, cells of the same group are assigned the same color in the embedding plots. It is useful to reveal matching between cell groups and tissues, but the cellular herterogeniety within groups is missing. The ‘cell-by-value’ coloring scheme is developed to overcome this limitation. In the following, this option is activated by `col.idp=TRUE`.

```
covis(data=dat.ann.tocell, ID=c('Cacnb4'), col.idp=TRUE, dimred='UMAP', cell.group='label', tar.bulk=names(lis.match.blk), bar.width=0.08, dim.lgd.nrow=2, dim.lgd.text.size=10, h=0.6, legend.r=0.1, legend.key.size=0.01, legend.text.size=10, legend.nrow=2)
```

![Co-visualization plot with 'cell-by-value' coloring. This plot is created with gene 'Cacnb4'. Tissues in SHM and cells in embedding plot are colored independently according to respective expression values of 'Cacnb4'.](data:image/png;base64...)

Figure 7: Co-visualization plot with ‘cell-by-value’ coloring
This plot is created with gene ‘Cacnb4’. Tissues in SHM and cells in embedding plot are colored independently according to respective expression values of ‘Cacnb4’.

## 4.2 Co-clustering Labels

If both single cell and bulk gene expression data are available for the same or
overlapping tissues then co-clustering can be used to assign cells to tissues
automatically (Figure [8](#fig:coclusOver)). Subsequently, the predicted
tissue-cell assignments can be used for creating co-visualization plots. This approach is useful for predicting the
source tissues of unlabeled cells without prior knowledge as is required for
the annotation approach. While attractive there
are various challenges to overcome to reliably co-cluster single cell data with
the corresponding tissue-level bulk data. This is due to the different
properties of single cell and bulk gene expression data, such as lower
sensitivity and higher sparsity in single cell compared to bulk data. This
section introduces a co-clustering method that is largely based on parameter
optimization including three major steps. First, both data are preprocessed to retain the most reliable expression values (Figure [8](#fig:coclusOver)A1-2). Second, the genes in the bulk data are
reduced to those robustly expressed in the single cell data (Figure [8](#fig:coclusOver)A3). Third, bulk and cell data are co-clustered (Figure [8](#fig:coclusOver)C) by using optimal default settings (Table [1](#tab:optPar)) that are obtained through optimization on real data with known tissue-cell assignments. The following introduces the three steps of this method in more detail using
the example of RNA-Seq data.

1. The raw count matrices of bulk and single cells are column-wise combined for joint normalization (Figure [8](#fig:coclusOver)A1). After separated from bulk data, the single-cell data are reduced to genes with robust expression across at least a proportion of cells and to cells with robust expression across at least a proportion of genes (Figure [8](#fig:coclusOver)A2). In the bulk data, genes are filtered according to expression values exceeding a cutoff over a proportion of bulk samples and a coefficient of variance (CV) between CV1 and CV2 (Figure [8](#fig:coclusOver)A2).
2. The bulk data are subsetted to the same genes as the single cell data (Figure [8](#fig:coclusOver)A3). This and the previous filtering steps reduce the sparsity in the single-cell data and the bulk data are made more compareable to the single cell data by subsetting it to the same genes.
3. Bulk and single-cell data are column-wise combined for joint embedding using PCA or UMAP (Figure [8](#fig:coclusOver)B). Co-clustering is then performed. Specifically, a graph is built on the the embedding data with methods (Table [1](#tab:optPar)) from *scran* (Lun, McCarthy, and Marioni [2016](#ref-scran)), where nodes are cells (or tissues) and edges are connections between nearest neighbors, and subsequently this graph is partitioned with methods (Table [1](#tab:optPar)) from *igraph* to obtain clusters (Csardi and Nepusz [2006](#ref-igraph)). Three types of clusters are produced. First, a single tissue is co-clustered with multiple cells (Figure [8](#fig:coclusOver)C1), and this tissue is assigned to all these cells. Second, multiple tissues are co-clustered with multiple cells (Figure [8](#fig:coclusOver)C2). The nearest-neighbor tissue is assigned to each cell based on the similarity measure Spearman’s correlation coefficient. Third, no tissue is co-clustered with cells (Figure [8](#fig:coclusOver)C3). All these cells are treated as unlabeled and represent candidates for discovering novel cell types. After co-clustering, cells are labeled by tissues or remain unlabeled (Figure [8](#fig:coclusOver)D) and these labels are used for associating cells and tissues in embedding plots and SHMs, respectively (Figure [8](#fig:coclusOver)E).

![Co-clustering illustration. (A) The single-cell and bulk tissue data are jointly pre-processed. (B) Single-cell and bulk data are embedded with dimension reduction methods. (C) The embedding results are used for co-clustering single-cells and bulk tissue data. Cells are assigned to tissues based on the clustering results as follows: (1) If a cluster contains a single tissue, then the cells of this cluster are assigned to the corresponding tissue. (2) If a cluster contains multiple tissues and cells, a nearest-neighbor approach resolves this ambiguous situation by assigning cells to the closest tissue sample. (3) Cells in clusters without tissue samples remain unassigned. (D) The cell-tissue assignments and the similarity scores of the predictions are stored in a table. (E) The predictions are used to color the cells by predicted source tissues in co-visualization plots.](data:image/jpeg;base64...)

Figure 8: Co-clustering illustration
(A) The single-cell and bulk tissue data are jointly pre-processed. (B) Single-cell and bulk data are embedded with dimension reduction methods. (C) The embedding results are used for co-clustering single-cells and bulk tissue data. Cells are assigned to tissues based on the clustering results as follows: (1) If a cluster contains a single tissue, then the cells of this cluster are assigned to the corresponding tissue. (2) If a cluster contains multiple tissues and cells, a nearest-neighbor approach resolves this ambiguous situation by assigning cells to the closest tissue sample. (3) Cells in clusters without tissue samples remain unassigned. (D) The cell-tissue assignments and the similarity scores of the predictions are stored in a table. (E) The predictions are used to color the cells by predicted source tissues in co-visualization plots.

To achieve reasonably robust default settings, the co-clustering optimization focuses on the two most important steps: joint dimension reduction and co-clustering (Figure [8](#fig:coclusOver)B-C). The relevant parameters associated with these steps are presented in Table [1](#tab:optPar), with the optimal settings highlighted in bold. These optimal settings are adopted as the default settings. The details of this optimization are given [here](https://jianhaizhang.github.io/spatialHeatmap_supplement/cocluster_optimize.html). The following example applies the default settings (bold in Table [1](#tab:optPar)) using single cell and bulk data from mouse brain
(Vacher et al. [2021](#ref-Vacher2021-xg); Ortiz et al. [2020](#ref-Ortiz2020-yt)). Both data sets have been simplified for demonstraton purposes.

Table 1: Table 2: Settings for optimization. Optimal settings are indicated by bold text.

| Parameter | Settings | Description |
| --- | --- | --- |
| dimensionReduction (dimred) | **PCA**, UMAP | Dimension reduction methods. Choosing “PCA” and “UMAP” involves utilizing the “denoisePCA” function from the scran package and the “runUMAP” function from the scater package, respectively |
| topDimensions (dims) | 5 to 80 (**14**) | Number of top dimensions selected for co-clustering. |
| graphBuilding (graph.meth) | **knn**, snn | Methods for building a graph where nodes are cells and edges are connections between nearest neighbors. Choosing “knn” and “snn” involves utilizing the “buildKNNGraph” and “buildSNNGraph” function from the scran package, respectively. |
| clusterDetection (cluster) | wt, **fg**, le | Methods for partitioning the graph to generate clusters. Choosing “wt”, “fg”, and “le” involves utilizing the “cluster\_walktrap”, “cluster\_fast\_greedy”, and “cluster\_leading\_eigen” function from the igraph package, respectively. |

### 4.2.1 Pre-processing

To obtain reproducible results, a fixed seed is set for generating random numbers.

```
set.seed(10)
```

The bulk data (`blk.mus`) are the same with the [Annotation Labels](#ann) section. The following imports the single-cell data from the `spatialHeatmap` package and shows its partial metadata in `colData` slot.

```
sc.mus.pa <- system.file("extdata/shinyApp/data", "cell_mouse_cocluster.rds", package="spatialHeatmap")
sc.mus <- readRDS(sc.mus.pa)
colData(sc.mus)[1:3, , drop=FALSE]
```

```
## DataFrame with 3 rows and 1 column
##                cell
##         <character>
## isocort     isocort
## isocort     isocort
## isocort     isocort
```

Bulk and single cell raw count data are jointly normalized by the function `norm_cell`, which is a wrapper of `computeSumFactors` from `scran` (Lun, McCarthy, and Marioni [2016](#ref-scran)). `com=FALSE` means bulk and single cells are separated after normalization for subsequent separate filtering.

```
#mus.lis.nor <- read_cache(cache.pa, 'mus.lis.nor')
#if (is.null(mus.lis.nor)) {
  mus.lis.nor <- norm_cell(sce=sc.mus, bulk=blk.mus, com=FALSE)
  save_cache(dir=cache.pa, overwrite=TRUE, mus.lis.nor)
#}
```

The normalized single cell and bulk data (log2-scale) are filtered to remove low expression values and reduce sparsity in the former. In the bulk data, replicates are first aggregated by taking means using the function `aggr_rep`. Then genes are filtered according to expression values \(\ge\) 1 at a proportion of \(\ge 10\%\) (`pOA`) across bulk samples and a coefficient of variance (`CV`) between \(0.1-50\) (Gentleman et al. [2018](#ref-Gentleman2018-xj)).

In the single cell data, genes with expression values \(\ge 1\) (`cutoff=1`) in \(\ge 1\%\) (`p.in.gen=0.01`) of cells are retained, and cells having expression values \(\ge 1\) (`cutoff=1`)
in \(\ge 10\%\) (`p.in.cell=0.1`) of all genes are retained.

```
# Aggregate bulk replicates
blk.mus.aggr <- aggr_rep(data=mus.lis.nor$bulk, assay.na='logcounts', sam.factor='sample', aggr='mean')
# Filter bulk
blk.mus.fil <- filter_data(data=blk.mus.aggr, pOA=c(0.1, 1), CV=c(0.1, 50), verbose=FALSE)
# Filter cell and subset bulk to genes in cell
blk.sc.mus.fil <- filter_cell(sce=mus.lis.nor$cell, bulk=blk.mus.fil, cutoff=1, p.in.cell=0.1, p.in.gen=0.01, verbose=FALSE)
```

Compared to bulk RNA-Seq data, single cell data has a much higher level of
sparsity. This difference is reduced by the above filtering and then subsetting
the bulk data to the genes remaining in the filtered single cell data. This
entire process is accomplished by the `filter_cell` function.

The same mouse brain aSVG as in the [Quick Start](#test) section is used here and the aSVG importing is omitted for brevity.

```
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4] # Partial features are shown.
```

```
## # A tibble: 3 × 4
##   feature                      id             fill  stroke
##   <chr>                        <chr>          <chr>  <dbl>
## 1 brainstem                    UBERON_0002298 none    0.05
## 2 midbrain                     UBERON_0001891 none    0.05
## 3 dorsal.plus.ventral.thalamus UBERON_0001897 none    0.05
```

### 4.2.2 Co-clustering

The co-clustering process is implemented in the function `cocluster`. In the following, default settings obtained from the optimization are used, where `min.dim`, `dimred`, `graph.meth`, and `cluster` refers to `topDimensions`, `dimensionReduction`, `graphBuilding`, and `clusterDetection` in Table [1](#tab:optPar) respectively. The results are saved in `coclus.mus`.

```
coclus.mus <- read_cache(cache.pa, 'coclus.mus')
if (is.null(coclus.mus)) {
  coclus.mus <- cocluster(bulk=blk.sc.mus.fil$bulk, cell=blk.sc.mus.fil$cell, min.dim=14, dimred='PCA', graph.meth='knn', cluster='fg')
  save_cache(dir=cache.pa, overwrite=TRUE, coclus.mus)
}
```

The tissue-cell assignments from the co-clustering process are stored in the `colData` slot of the `coclus.mus` object. The ‘cluster’ column represents cluster labels, ‘bulkCell’ indicates whether each entry represents bulk tissues or single cells, ‘sample’ represents the original labels of the bulk and cells, ‘assignedBulk’ refers to the bulk tissues assigned to cells with ‘none’ indicating unassigned cells, and ‘similarity’ represents Spearman’s correlation coefficients used for the tissue-cell assignments, serving as a measure of assignment stringency.

```
colData(coclus.mus)
```

```
## DataFrame with 4458 rows and 7 columns
##                     cluster    bulkCell          sample    assignedBulk
##                 <character> <character>     <character>     <character>
## cerebral.cortex       clus2        bulk cerebral.cortex            none
## hippocampus           clus6        bulk     hippocampus            none
## hypothalamus          clus6        bulk    hypothalamus            none
## cerebellum            clus6        bulk      cerebellum            none
## isocort               clus1        cell         isocort            none
## ...                     ...         ...             ...             ...
## retrohipp             clus2        cell       retrohipp cerebral.cortex
## retrohipp             clus6        cell       retrohipp    hypothalamus
## retrohipp             clus6        cell       retrohipp    hypothalamus
## retrohipp             clus6        cell       retrohipp      cerebellum
## retrohipp             clus6        cell       retrohipp     hippocampus
##                  similarity     index sizeFactor
##                 <character> <integer>  <numeric>
## cerebral.cortex        none         1  45.811788
## hippocampus            none         2 100.736625
## hypothalamus           none         3  28.249392
## cerebellum             none         4  44.415396
## isocort                none         5   0.711862
## ...                     ...       ...        ...
## retrohipp             0.574      4454   1.006589
## retrohipp             0.292      4455   0.674636
## retrohipp             0.398      4456   0.646310
## retrohipp             0.402      4457   0.564467
## retrohipp             0.486      4458   0.636357
```

The tissue-cell assignments can be controled by filtering the values in the `similarity` column. This utility is impletmented in function `filter_asg`, where only assignments with similarities above the cutoff `min.sim` will be retained. Utilities are also developed to tailor the assignments, such as assigning specific tissues to cells without assignments. Details of the tailoring are explained in the [Supplementary Section](#tailor).

```
coclus.mus <- filter_asg(coclus.mus, min.sim=0.1)
```

The co-clusters that consist of tissues and cells can be visualized in an embeding plot with the function `plot_dim`. The `dim` argument specifies an embedding method. To see all co-clusters, assign `TRUE` to `cocluster.only`, in this case, other clusters containing only cells will be in grey. To only show a specific cluster, assign the cluster label to `group.sel`, for example, `group.sel='clus3'`. In the embedding plot, tissues and cells are indicated by large and small circles respectively.

```
plot_dim(coclus.mus, dim='PCA', color.by='cluster', cocluster.only=TRUE, group.sel=NULL)
```

![Embedding plot of co-clusters. Large and small circles refer to tissues and single cells respectively. ](data:image/png;base64...)

Figure 9: Embedding plot of co-clusters
Large and small circles refer to tissues and single cells respectively.

### 4.2.3 Co-visualization

In co-clustering based co-visualization, assigned tissues are treated as group labels for cells. This section focuses on the ‘cell-by-value’ coloring, other coloring options (Figure [2](#fig:grpcolor)b) are provided in the [Supplementary Section](#coclusColor).

Single-cell and bulk data are separated from each other.

```
# Separate bulk data.
coclus.blk <- subset(coclus.mus, , bulkCell=='bulk')
# Separate single cell data.
coclus.sc <- subset(coclus.mus, , bulkCell=='cell')
```

The co-visualization of ‘cell-by-value’ coloring is built on gene ‘Atp2b1’. Each cell in the embedding plot and each tissue in SHM are colored independently according to respective expression value of ‘Atp2b1’. The matching between cells and tissues are indicated in the legend plot with constant colors.

```
# Store data objects in an SPHM container.
dat.auto.idp <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc)
covis(data=dat.auto.idp, ID=c('Atp2b1'), dimred='TSNE', tar.cell=c('hippocampus', 'hypothalamus', 'cerebellum', 'cerebral.cortex'), col.idp=TRUE, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.nrow=3, h=0.6, legend.key.size=0.01, legend.text.size=10, legend.r=0.27)
```

![Co-visualization of 'cell-by-value' coloring with the co-clustering method. This plot is created on gene 'Atp2b1'. Each cell and each tissue are colored independently according to expression values of 'Atp2b1'.](data:image/png;base64...)

Figure 10: Co-visualization of ‘cell-by-value’ coloring with the co-clustering method
This plot is created on gene ‘Atp2b1’. Each cell and each tissue are colored independently according to expression values of ‘Atp2b1’.

## 4.3 Spatial Single-Cell Data

Except for conventional single-cell data, the co-visualization module is able to co-visualize spatially resolved single-cell (SRSC) and bulk data as well. In the following example, the bulk data are the same as the [Annotation Labels](#ann) section, while the SRSC data are from the anterior region of sagittal mouse brain (10X Genomics Visium). For simplicity, the pre-processing steps of bulk and SRSC data are not described here and the pre-processed data are imported directly. These steps include (1) jointly normalizing bulk and SRSC data and subsequently separating them, which is performed with the the function `norm_srsc` in `spatialHeatmap`, (2) reducing dimensions (PCA, UMAP, TSNE) of the separated SRSC data, and (3) clustering the SRSC data. More details are described in the `Seurat` [vignette](https://satijalab.org/seurat/articles/spatial_vignette.html) (Satija et al. [2015](#ref-seurat1), @seurat2, @seurat3, @seurat4).

The pre-processed bulk and SRSC data are imported and partially shown.

```
# Importing bulk data.
blk.sp <- readRDS(system.file("extdata/shinyApp/data", "bulk_sp.rds", package="spatialHeatmap"))
# Bulk assay data are partially shown.
assay(blk.sp)[1:3, ]
## 3 x 4 sparse Matrix of class "dgCMatrix"
##        cerebral.cortex hippocampus hypothalamus cerebellum
## Resp18               .           .            7          .
## Epha4                5           9            2          .
## Scg2                 4           6           52          4
# Importing SRSC data.
srt.sc <- read_cache(cache.pa, 'srt.sc')
if (is.null(srt.sc)) {
  srt.sc <- readRDS(gzcon(url("https://zenodo.org/records/18098376/files/srt_sc.rds?download=1")))
  save_cache(dir=cache.pa, overwrite=TRUE, srt.sc)
}
# SRSC assay data are partially shown.
srt.sc@assays$SCT@data[1:3, 1:2]
## 3 x 2 sparse Matrix of class "dgCMatrix"
##        AAACAAGTATCTCCCA.1 AAACACCAATAACTGC.1
## Resp18          1.7917595           1.098612
## Epha4           0.6931472           .
## Scg2            2.6390573           3.091042
```

The SRSC data are stored in a `Seurat` object. The cluster labels of cells are stored in the `seurat_clusters` column of the `meta.data` slot and partially shown.

```
# SRSC metadata of cells are partially shown.
srt.sc@meta.data[1:2, c('seurat_clusters', 'nFeature_SCT')]
##                    seurat_clusters nFeature_SCT
## AAACAAGTATCTCCCA.1          clus11          257
## AAACACCAATAACTGC.1           clus2          237
```

The coordinates of spatial spots are stored in the `image` slot in the `Seurat` object and partially shown.

```
# Coordinates of spatial spots are partially shown.
srt.sc@images[['anterior1']]@boundaries$centroids@coords[1:3, ]
##         x    y
## [1,] 8501 7475
## [2,] 2788 8553
## [3,] 7950 3164
```

The aSVG of mouse brain is included in `spatialHeatmap` and imported into an `SVG` object.

```
svg.mus.sp <- read_svg(system.file("extdata/shinyApp/data", "mus_musculus.brain_sp.svg", package="spatialHeatmap"), srsc=TRUE)
```

In order to position spatial spots in the SRSC data correctly in the aSVG, a shape named `overlay` that defines the region of the spatial spots is required in the aSVG. By using this shape as a reference, the coordinates of spatial spots in the SRSC data are transformed so that all these spots are positioned within this shape. The `overlay` shape can be created in an SVG editor such as Inkscape. The process involves using the spatial plot generated by the `SpatialFeaturePlot` function in `Seurat` as a template.

```
attribute(svg.mus.sp)[[1]][7:8, c('feature', 'id', 'fill', 'stroke')]
```

```
## # A tibble: 2 × 4
##   feature           id             fill  stroke
##   <chr>             <chr>          <chr>  <dbl>
## 1 overlay           overlay        none   0.258
## 2 medulla.oblongata UBERON_0001896 none   0.1
```

In the `SVG` object, the `angle` slot is designed for optionally rotating the spatial spots. In the SRSC data generated by the Visium technology, a 90 degree rotation is required for correctly positioning the spatial spots, which is shown below.

```
angle(svg.mus.sp)[[1]] <- angle(svg.mus.sp)[[1]] + 90
```

The co-visualization plot is created with the gene ‘Epha4’ using ‘cell-by-value’ coloring. Assigning `FALSE` to `profile` will turn on the ‘fixed-group’ coloring. The cluster labels are treated as the cell group labels (`cell.group='seurat_clusters'`). The ‘cerebral.cortex’ tissue anatomically correspond to cell clusters of ‘clus1’, ‘clus2’, ‘clus3’, and ‘clus5’, and this association is defined by a `list` called `lis.match`. The co-visualization plot consists of an embedding plot on the left, a single-cell SHM (scSHM) in the middle, and a SHM on the right. In the scSHM, spatial spots are positioned in the `overlay` region and superimposed the anatomical structures in the aSVG.

```
# Association between "cerebral.cortex" and clusters.
lis.match <- list(cerebral.cortex=c('clus1', 'clus3', 'clus5', 'clus10', 'clus14'))
dat.srsc <- SPHM(svg=svg.mus.sp, bulk=blk.sp, cell=srt.sc, match=lis.match)
covis(data=dat.srsc, ID='Epha4', assay.na='logcounts', dimred='TSNE', cell.group='seurat_clusters', tar.bulk=c('cerebral.cortex'), col.idp=TRUE, image='anterior1', bar.width=0.07, dim.lgd.nrow=2, dim.lgd.text.size=8, legend.r=0.1, legend.key.size=0.013, legend.text.size=10, legend.nrow=3, h=0.6, profile=TRUE, ncol=3, vjust=5, dim.lgd.key.size=3, size.r=0.97, dim.axis.font.size=8, size.pt=1.5, lgd.plots.size=c(0.35, 0.25, 0.35), verbose=FALSE)
```

![Co-visualization of SRSC data with SHM. This plot is created on gene 'Epha4'. Each spatial spot and each tissue are colored independently according to expression values of 'Epha4'.](data:image/png;base64...)

Figure 11: Co-visualization of SRSC data with SHM
This plot is created on gene ‘Epha4’. Each spatial spot and each tissue are colored independently according to expression values of ‘Epha4’.

# 5 Shiny App

The co-visualization module is included in the [spatialHeatmap Shiny App](https://tgirke.shinyapps.io/spatialHeatmap/) that is an interactive implementation of `spatialHeatmap`. To start this App in R, simply call `shiny_shm()`. Below is a screenshot of the co-visulization output.

![Screenshot of the co-visualization output in Shiny App.](data:image/jpeg;base64...)

Figure 12: Screenshot of the co-visualization output in Shiny App

To upload single-cell and bulk data to this App for co-visualization, these two data types can be combined column-wise into an `SCE` object or saved as tabular files. When opting for the former, the metadata in the `colData` slot of the `SCE` object should be formatted according to the following rules:

1. Use the `bulkCell` column to indicate whether a sample is a bulk or a single cell. Use `bulk` for bulk samples and `cell` for single-cell samples. If no `bulk` designation is included in this column, all samples will default to single cells.
2. If multiple versions of cell group labels (such as annotation labels or marker genes) are provided, include them in columns labeled `label`, `label1`,`label2`, and so on. In each of these label columns, include the corresponding aSVG spatial features as bulk tissue labels.

Once the assay data is properly formatted as shown below, save the `SCE` object as an ‘.rds’ file using the `saveRDS` function in R. Then, upload both the ‘.rds’ file and the aSVG file to the App for co-visualization. An example of bulk and single-cell data for use in the Shiny App are included in `spatialHeatmap` and shown [below](#cdat). Alternatively, the combined bulk and single-cell assay data, along with sample metadata (targets file) can be saved as separate tabular files for uploading. The conventions for formatting the targets file are given [below](#cdat). It is important to make sure the order of bulk and single-cell samples remains consistent between the assay data and the targets file.

```
shiny.dat.pa <- system.file("extdata/shinyApp/data", "shiny_covis_bulk_cell_mouse_brain.rds", package="spatialHeatmap")
shiny.dat <- readRDS(shiny.dat.pa)
colData(shiny.dat)
```

```
## DataFrame with 1061 rows and 4 columns
##                           label          label1    bulkCell    variable
##                     <character>     <character> <character> <character>
## cerebral.cortex cerebral.cortex cerebral.cortex        bulk     control
## hippocampus         hippocampus     hippocampus        bulk     control
## hypothalamus       hypothalamus    hypothalamus        bulk     control
## cerebellum           cerebellum      cerebellum        bulk     control
## cerebral.cortex cerebral.cortex cerebral.cortex        bulk     control
## ...                         ...             ...         ...         ...
## retrohipp             retrohipp           clus4        cell     control
## retrohipp             retrohipp           clus4        cell     control
## cere                       cere           clus2        cell     control
## cere                       cere           clus2        cell     control
## midbrain               midbrain           clus2        cell     control
```

# 6 Supplementary Section

More examples of the co-visualization feature in *spatialHeatmap* are showcased [here](https://jianhaizhang.github.io/spatialHeatmap_supplement/manuscript_examples.html#5_Co-visualization).

## 6.1 Single-cell Clustering Labels

To provide additional flexibility for defining cell groupings, several other options are provided. Here users can assign cell groups manually or by using clustering methods that are often used in the
analysis of single-cell data. The resulting cell grouping or cluster
information needs to be stored in a tabular file, that will be imported into an
`SCE` object (here `cell_group` function). The following demonstration uses
the same single cell and aSVG instance as the example of annotation labels above. The only
difference is an additional clustering step. For demonstration purposes a small
example of a cluster file is included in the `spatialHeatmap` package. In this
case the group labels were created by the `cluster_cell` function. The details
of this function are available in its help file. The cluster file contains at
least two columns: a column (here `cell`) with single cell identifiers used under
`colData` and a column (here `cluster`) with the cell group labels. For practical
reasons of building this vignette a pure manual example could not be used here.
However, the chosen clustering example can be easily adapted to manual or
hybrid grouping approaches since the underlying tabular data structure is the
same for both that can be generated in most text or spreadsheet programs.

```
manual.clus.mus.sc.pa <- system.file("extdata/shinyApp/data", "manual_cluster_mouse_brain.txt", package="spatialHeatmap")
manual.clus.mus.sc <- read.table(manual.clus.mus.sc.pa, header=TRUE, sep='\t')
manual.clus.mus.sc[1:3, ]
```

```
##                 cell cluster
## 1 C1.1772078.029.F11   clus7
## 2 C1.1772089.202.E04   clus7
## 3 C1.1772099.091.D10   clus1
```

The `cell_group` function can be used to append the imported group labels to the `colData` slot of an `SCE` object.

```
sce.clus <- cell_group(sce=sce.dimred.quick, df.group=manual.clus.mus.sc, cell='cell', cell.group='cluster')
colData(sce.clus)[1:3, c('cluster', 'label', 'variable')]
```

```
## DataFrame with 3 rows and 3 columns
##                        cluster        label    variable
##                    <character>  <character> <character>
## C1.1772078.029.F11       clus7 hypothalamus     control
## C1.1772089.202.E04       clus7       SN.VTA     control
## C1.1772099.091.D10       clus1  dorsal.horn     control
```

An embedding plot of single cell data is created. The cells represented as dots are
colored by the grouping information stored in the `cluster` column of the `colData`
slot of `SCE`.

```
plot_dim(sce.clus, color.by="cluster", dim='TSNE')
```

![Embedding plot of single cells. The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object .](data:image/png;base64...)

Figure 13: Embedding plot of single cells
The cells (dots) are colored by the grouping information stored in the `colData` slot of the corresponding `SCE` object .

The same mouse brain aSVG as above is used here.

```
tail(attribute(svg.mus.brain)[[1]])[1:3, 1:4]
```

```
## # A tibble: 3 × 4
##   feature                      id             fill  stroke
##   <chr>                        <chr>          <chr>  <dbl>
## 1 brainstem                    UBERON_0002298 none    0.05
## 2 midbrain                     UBERON_0001891 none    0.05
## 3 dorsal.plus.ventral.thalamus UBERON_0001897 none    0.05
```

Similarly as above, a mapping list is used to match the cell clusters with aSVG
features.

```
lis.match.clus <- list(clus1=c('cerebral.cortex'), clus3=c('brainstem', 'medulla.oblongata'))
```

This example is demonstrated with ‘cell-by-group’ coloring, so gene expression values need to be summarized for the cells within each group label. Any grouping column in `colData` can be used as labels for summarizing. In this example, the `cluster` labels are used.

If additional experimental variables (e.g. treatments) are provided, the summarizing will consider them as well (here `variable`). The following example uses the `cluster` and `variable` columns as group labels and experimental variables, respectively.

```
sce.clus.aggr <- aggr_rep(sce.clus, assay.na='logcounts', sam.factor='cluster', con.factor='variable', aggr='mean')
colData(sce.clus.aggr)[1:3, c('cluster', 'label', 'variable')]
```

```
## DataFrame with 3 rows and 3 columns
##                    cluster           label    variable
##                <character>     <character> <character>
## clus7__control       clus7    hypothalamus     control
## clus1__control       clus1     dorsal.horn     control
## clus5__control       clus5 corpus.callosum     control
```

The co-visualization plot with ‘cell-by-group’ coloring is created with gene `Tcea1`.

```
# Store data objects in an SPHM container.
dat.man.tobulk <- SPHM(svg=svg.mus.brain, bulk=sce.clus.aggr, cell=sce.clus, match=lis.match.clus)
covis(data=dat.man.tobulk, ID=c('Tcea1'), dimred='TSNE', cell.group='cluster', assay.na='logcounts', tar.cell=names(lis.match.clus), bar.width=0.09, dim.lgd.nrow=1, h=0.6, legend.r=1.5, legend.key.size=0.02, legend.text.size=12, legend.nrow=4, verbose=FALSE)
```

![Co-visualization plot created with cluster groupings.](data:image/png;base64...)

Figure 14: Co-visualization plot created with cluster groupings

## 6.2 Co-clustering Labels: Other Coloring

### 6.2.1 Cell-by-Group

In ‘cell-by-group’ coloring, after separated from bulk, gene expression values in single-cell data are summarized by means within each cell group, *i.e.* tissue assignement.

```
# Separate single cell data.
coclus.sc <- subset(coclus.mus, , bulkCell=='cell')
# Summarize expression values in each cell group.
sc.aggr.coclus <- aggr_rep(data=coclus.sc, assay.na='logcounts', sam.factor='assignedBulk', aggr='mean')
colData(sc.aggr.coclus)
```

```
## DataFrame with 5 rows and 8 columns
##                     cluster    bulkCell      sample    assignedBulk  similarity
##                 <character> <character> <character>     <character> <character>
## none                  clus1        cell     isocort            none        none
## cerebral.cortex       clus2        cell     isocort cerebral.cortex       0.468
## hypothalamus          clus6        cell        olfa    hypothalamus       0.266
## hippocampus           clus6        cell        olfa     hippocampus       0.407
## cerebellum            clus6        cell    pallidum      cerebellum       0.653
##                     index sizeFactor       spFeature
##                 <integer>  <numeric>     <character>
## none                    5   0.711862            none
## cerebral.cortex        30   0.685422 cerebral.cortex
## hypothalamus          353   1.136880    hypothalamus
## hippocampus           500   1.055465     hippocampus
## cerebellum            897   0.867205      cerebellum
```

The co-visualization plot with ‘cell-by-group’ coloring is created on gene ‘Atp2b1’. Cells in the embedding plot and respective assigned tissues in SHM are colored by mean expression values of ‘Atp2b1’ in each cell group.

```
# Store data objects in an SPHM container.
dat.auto.tobulk <- SPHM(svg=svg.mus.brain, bulk=sc.aggr.coclus, cell=coclus.sc)
covis(data=dat.auto.tobulk, ID=c('Atp2b1'), dimred='TSNE', tar.cell=c('hippocampus', 'hypothalamus', 'cerebellum', 'cerebral.cortex'), dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.09, legend.nrow=5, h=0.6, legend.key.size=0.02, legend.text.size=12, legend.r=1.5)
```

![Co-clustering based co-visualization plot with 'cell-by-group' coloring.](data:image/png;base64...)

Figure 15: Co-clustering based co-visualization plot with ‘cell-by-group’ coloring

### 6.2.2 Feature-by-Group

Similar to the aforementioned ‘cell-by-group’ coloring, in the ‘feature-by-group’ coloring approach, expression values need to be aggregated across bulk replicates, a step that has already been performed during preprocessing.

```
coclus.blk <- subset(coclus.mus, , bulkCell=='bulk')
```

Same with the convention when plotting SHMs in the main vignette, at least one tissue in bulk assay data should share a common identifier with an aSVG feature.

```
colnames(coclus.blk) %in% attribute(svg.mus.brain)[[1]]$feature
```

```
## [1] TRUE TRUE TRUE TRUE
```

The co-visualization plot with ‘feature-by-group’ coloring is created on gene ‘Atp2b1’. Cells in the embedding plot and respective assigned tissues in SHM are colored according to mean expression values of ‘Atp2b1’ across tissue replicates.

```
# Store data objects in an SPHM container.
dat.auto.tocell <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc)
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='TSNE', tar.bulk=colnames(coclus.blk), assay.na='logcounts', legend.nrow=5, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, h=0.6, legend.key.size=0.02, legend.text.size=12, legend.r=1.5)
```

![Co-clustering based co-visualization plot wiht 'feature-by-group' coloring.](data:image/png;base64...)

Figure 16: Co-clustering based co-visualization plot wiht ‘feature-by-group’ coloring

### 6.2.3 Fixed-by-Group

By setting `profile=FALSE`, the co-visualization plot is created with ‘fixed-by-group’ coloring, where the same constant colors between the embedding plot and SHM indicate matching between cells and tissues respectively.

```
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='TSNE', profile=FALSE, assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.09)
```

![Co-clustering based co-visualization plot with 'fixed-by-group' coloring.](data:image/png;base64...)

Figure 17: Co-clustering based co-visualization plot with ‘fixed-by-group’ coloring

## 6.3 Tailoring Co-clustering Results

### 6.3.1 Command-line Method

The tissue-cell assignments in the automated co-clustering can be optionally tailored. Both command-line and [graphical](#asgBulkShiny) methods are supported for this purpose. In the command-line, the first step is to visualize single cells in an embedding plot as shown below.

```
plot_dim(coclus.mus, dim='PCA', color.by='sample', x.break=seq(-10, 10, 1), y.break=seq(-10, 10, 1), panel.grid=TRUE, lgd.ncol=2)
```

![Embedding plot of tissues and single cells of mouse brain. Tissues and single cells are indicated by large and small circles respectively. ](data:image/png;base64...)

Figure 18: Embedding plot of tissues and single cells of mouse brain
Tissues and single cells are indicated by large and small circles respectively.

Second, select cells with x-y coordinate ranges (`x.min`, `x.max`, `y.min`, `y.max`) in the embedding plot and define corresponding desired tissues (`desiredBulk`) in form of a `data.frame` (`df.desired.bulk`). In order to define more accurate coordinates, tune the x-y axis breaks (`x.break`, `y.break`) and set `panel.grid=TRUE` in the first step. In the `data.frame`, the `dimred` represents embedding plots where the coordinates come from. For demonstration, some cells near the tissue `hippocampus` (the large green dot) are selected and `hippocampus` is chosen as the desired tissue.

```
df.desired.bulk <- data.frame(x.min=c(-8), x.max=c(5), y.min=c(1), y.max=c(5), desiredBulk=c('hippocampus'), dimred='PCA')
df.desired.bulk
```

Next, the tissue-cell assignments from co-clustering are updated with the function `refine_asg` by incorporating the desired tissues. The similarities corresponding to desired tissues are internally set at the maximum of 1. After that, single-cell data are separated from bulk data for creating co-visualization plots.

```
# Incorporate desired bulk
coclus.mus.tailor <- refine_asg(sce.all=coclus.mus, df.desired.bulk=df.desired.bulk)
# Separate cells from bulk
coclus.sc.tailor <- subset(coclus.mus.tailor, , bulkCell=='cell')
```

After the above tailoring steps, the co-visualization plot with ‘feature-by-group’ coloring is created on gene ‘Atp2b1’ (Figure [19](#fig:aftertailor)). To reveal the tailoring, only the tissue `hippocampus` is selected to show (`tar.bulk=c('hippocampus')`). Cells of `hippocampus` in the embedding plot include tailored cells in `df.desired.bulk` and those labeled `hippocampus` in co-clustering. All these cells have the same color as the tissue `hippocampus` in SHM. As a comparison, the hippocampus cells before tailoring is shown in Figure [20](#fig:beforetailor).

```
# Store data objects in an SPHM container.
dat.auto.tocell.tailor <- SPHM(svg=svg.mus.brain, bulk=coclus.blk, cell=coclus.sc.tailor)
covis(data=dat.auto.tocell.tailor, ID=c('Atp2b1'), dimred='PCA', tar.bulk=c('hippocampus'), assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.r=1.5)
```

![Co-visualization plot with 'feature-by-group' coloring after tailoring. This plot is created on gene 'Atp2b1'. Only the tissue and cells of hippocampus are shown to indicate the tailoring.](data:image/png;base64...)

Figure 19: Co-visualization plot with ‘feature-by-group’ coloring after tailoring
This plot is created on gene ‘Atp2b1’. Only the tissue and cells of hippocampus are shown to indicate the tailoring.

```
covis(data=dat.auto.tocell, ID=c('Atp2b1'), dimred='PCA', tar.bulk=c('hippocampus'), assay.na='logcounts', legend.nrow=4, dim.lgd.text.size=10, dim.lgd.nrow=2, bar.width=0.08, legend.r=1.5)
```

![Co-visualization plot with 'feature-by-group' coloring before tailoring. This plot is created on gene 'Atp2b1'. Only the tissue and cells of hippocampus are shown.](data:image/png;base64...)

Figure 20: Co-visualization plot with ‘feature-by-group’ coloring before tailoring
This plot is created on gene ‘Atp2b1’. Only the tissue and cells of hippocampus are shown.

### 6.3.2 Graphical Method

This section describes the graphical method for [tailoring](#tailor) co-clustering results through a convenience Shiny App (see the function `desired_bulk_shiny`).

Figure [21](#fig:tailorShiny) is the screenshot of the convenience Shiny App. To use this App, upload the co-clustering result returned by the `cocluster` function (here `coclus.mus`), which should be saved as an ‘.rds’ file using the `saveRDS` function. In the embedding plot on the left, cells are selected using the “Lasso Select” tool. The selected cells and their coordinates are then displayed in a table on the right. From the dropdown list, the desired tissues (aSVG features) are selected, here `hippocampus`. To download the table, simply click on the “Download” button. To refer to more guidance, click on the “Help” button.

![Screenshot of the Shiny App for selecting desired tissues. On the left is the embedding plot of single cells, where target cells are selected with the 'Lasso Select' tool. On the right, desired tissues are assigned for selected cells.](data:image/png;base64...)

Figure 21: Screenshot of the Shiny App for selecting desired tissues
On the left is the embedding plot of single cells, where target cells are selected with the ‘Lasso Select’ tool. On the right, desired tissues are assigned for selected cells.

An example of desired tisssues downloaded from the convenience Shiny App is shown below and imported to `df.desired.bulk`, which is ready to use in the [tailoring](#tailor) section. The x-y coordinates refer to selected single cells in embbeding plots (`dimred`).

```
desired.blk.pa <- system.file("extdata/shinyApp/data", "selected_cells_with_desired_bulk.txt", package="spatialHeatmap")
df.desired.blk <- read.table(desired.blk.pa, header=TRUE, row.names=1, sep='\t')
df.desired.blk[1:3, ]
```

# 7 Version Informaion

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] Seurat_5.4.0                SeuratObject_5.3.0
##  [3] sp_2.2-0                    kableExtra_1.4.0
##  [5] SingleCellExperiment_1.32.0 ggplot2_4.0.1
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.1        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] spatialHeatmap_2.16.3       knitr_1.51
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6               spatstat.sparse_3.1-0  httr_1.4.7
##   [4] RColorBrewer_1.1-3     tools_4.5.2            sctransform_0.4.3
##   [7] utf8_1.2.6             R6_2.6.1               lazyeval_0.2.2
##  [10] uwot_0.2.4             withr_3.0.2            gridExtra_2.3
##  [13] progressr_0.18.0       cli_3.6.5              textshaping_1.0.4
##  [16] spatstat.explore_3.7-0 fastDummies_1.7.5      grImport_0.9-7
##  [19] labeling_0.4.3         sass_0.4.10            S7_0.2.1
##  [22] spatstat.data_3.1-9    genefilter_1.92.0      ggridges_0.5.7
##  [25] pbapply_1.7-4          systemfonts_1.3.1      yulab.utils_0.2.3
##  [28] svglite_2.2.2          dichromat_2.0-0.1      scater_1.38.0
##  [31] parallelly_1.46.1      limma_3.66.0           rstudioapi_0.18.0
##  [34] RSQLite_2.4.5          FNN_1.1.4.1            gridGraphics_0.5-1
##  [37] ica_1.0-3              spatstat.random_3.4-4  dplyr_1.1.4
##  [40] Matrix_1.7-4           ggbeeswarm_0.7.3       abind_1.4-8
##  [43] lifecycle_1.0.5        yaml_2.3.12            edgeR_4.8.2
##  [46] shinytoastr_2.2.0      SparseArray_1.10.8     BiocFileCache_3.0.0
##  [49] Rtsne_0.17             grid_4.5.2             blob_1.3.0
##  [52] promises_1.5.0         dqrng_0.4.1            crayon_1.5.3
##  [55] shinydashboard_0.7.3   miniUI_0.1.2           lattice_0.22-7
##  [58] beachmat_2.26.0        cowplot_1.2.0          annotate_1.88.0
##  [61] KEGGREST_1.50.0        magick_2.9.0           pillar_1.11.1
##  [64] metapod_1.18.0         future.apply_1.20.1    codetools_0.2-20
##  [67] glue_1.8.0             spatstat.univar_3.1-6  data.table_1.18.0
##  [70] vctrs_0.7.0            png_0.1-8              spam_2.11-3
##  [73] gtable_0.3.6           assertthat_0.2.1       cachem_1.1.0
##  [76] xfun_0.56              S4Arrays_1.10.1        mime_0.13
##  [79] survival_3.8-6         tinytex_0.58           statmod_1.5.1
##  [82] bluster_1.20.0         fitdistrplus_1.2-5     ROCR_1.0-11
##  [85] nlme_3.1-168           bit64_4.6.0-1          filelock_1.0.3
##  [88] RcppAnnoy_0.0.23       bslib_0.9.0            irlba_2.3.5.1
##  [91] vipor_0.4.7            KernSmooth_2.23-26     otel_0.2.0
##  [94] spsComps_0.3.4.0       DBI_1.2.3              tidyselect_1.2.1
##  [97] curl_7.0.0             bit_4.6.0              compiler_4.5.2
## [100] httr2_1.2.2            BiocNeighbors_2.4.0    xml2_1.5.2
## [103] DelayedArray_0.36.0    plotly_4.11.0          bookdown_0.46
## [106] scales_1.4.0           lmtest_0.9-40          rappdirs_0.3.4
## [109] stringr_1.6.0          digest_0.6.39          goftest_1.2-3
## [112] spatstat.utils_3.2-1   rmarkdown_2.30         XVector_0.50.0
## [115] htmltools_0.5.9        pkgconfig_2.0.3        dbplyr_2.5.1
## [118] fastmap_1.2.0          rlang_1.1.7            htmlwidgets_1.6.4
## [121] shiny_1.12.1           farver_2.1.2           jquerylib_0.1.4
## [124] zoo_1.8-15             jsonlite_2.0.0         BiocParallel_1.44.0
## [127] BiocSingular_1.26.1    magrittr_2.0.4         scuttle_1.20.0
## [130] ggplotify_0.1.3        dotCall64_1.2          patchwork_1.3.2
## [133] Rcpp_1.1.1             viridis_0.6.5          reticulate_1.44.1
## [136] stringi_1.8.7          MASS_7.3-65            plyr_1.8.9
## [139] parallel_4.5.2         listenv_0.10.0         ggrepel_0.9.6
## [142] deldir_2.0-4           Biostrings_2.78.0      splines_4.5.2
## [145] tensor_1.5.1           locfit_1.5-9.12        igraph_2.2.1
## [148] spatstat.geom_3.7-0    RcppHNSW_0.6.0         reshape2_1.4.5
## [151] ScaledMatrix_1.18.0    XML_3.99-0.20          evaluate_1.0.5
## [154] scran_1.38.0           BiocManager_1.30.27    httpuv_1.6.16
## [157] RANN_2.6.2             tidyr_1.3.2            purrr_1.2.1
## [160] polyclip_1.10-7        future_1.69.0          scattermore_1.2
## [163] rsvd_1.0.5             xtable_1.8-4           rsvg_2.7.0
## [166] RSpectra_0.16-2        later_1.4.5            viridisLite_0.4.2
## [169] tibble_3.3.1           memoise_2.0.1          beeswarm_0.4.0
## [172] AnnotationDbi_1.72.0   cluster_2.1.8.1        globals_0.18.0
## [175] shinyAce_0.4.4
```

# 8 Funding

This project has been funded by NSF awards: [PGRP-1546879](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1546879&HistoricalAwards=false), [PGRP-1810468](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1810468), [PGRP-1936492](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1936492&HistoricalAwards=false).

# 9 References

Amezquita, Robert, Aaron Lun, Etienne Becht, Vince Carey, Lindsay Carpp, Ludwig Geistlinger, Federico Marini, et al. 2020. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods* 17: 137–45. <https://www.nature.com/articles/s41592-019-0654-x>.

Butler, Andrew, Paul Hoffman, Peter Smibert, Efthymia Papalexi, and Rahul Satija. 2018. “Integrating Single-Cell Transcriptomic Data Across Different Conditions, Technologies, and Species.” *Nature Biotechnology* 36: 411–20. <https://doi.org/10.1038/nbt.4096>.

Chang, Winston, Joe Cheng, JJ Allaire, Cars on Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert, and Barbara Borges. 2021. *Shiny: Web Application Framework for R*. [https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny).

Csardi, Gabor, and Tamas Nepusz. 2006. “The Igraph Software Package for Complex Network Research.” *InterJournal* Complex Systems: 1695. <http://igraph.org>.

Gentleman, R, V Carey, W Huber, and F Hahne. 2018. “Genefilter: Methods for Filtering Genes from High-Throughput Experiments.” <http://bioconductor.uib.no/2.7/bioc/html/genefilter.html>.

Hao, Yuhan, Stephanie Hao, Erica Andersen-Nissen, William M. Mauck III, Shiwei Zheng, Andrew Butler, Maddie J. Lee, et al. 2021. “Integrated Analysis of Multimodal Single-Cell Data.” *Cell*. <https://doi.org/10.1016/j.cell.2021.04.048>.

Lun, Aaron T. L., Davis J. McCarthy, and John C. Marioni. 2016. “A Step-by-Step Workflow for Low-Level Analysis of Single-Cell Rna-Seq Data with Bioconductor.” *F1000Res.* 5: 2122. <https://doi.org/10.12688/f1000research.9501.2>.

Marques, Sueli, Amit Zeisel, Simone Codeluppi, David van Bruggen, Ana Mendanha Falcão, Lin Xiao, Huiliang Li, et al. 2016. “Oligodendrocyte Heterogeneity in the Mouse Juvenile and Adult Central Nervous System.” *Science* 352 (6291): 1326–9.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2018. *SummarizedExperiment: SummarizedExperiment Container*.

Ortiz, Cantin, Jose Fernandez Navarro, Aleksandra Jurek, Antje Märtin, Joakim Lundeberg, and Konstantinos Meletis. 2020. “Molecular Atlas of the Adult Mouse Brain.” *Science Advances* 6 (26): eabb3446.

Risso, Davide, and Michael Cole. 2022. *ScRNAseq: Collection of Public Single-Cell Rna-Seq Datasets*.

Satija, Rahul, Jeffrey A Farrell, David Gennert, Alexander F Schier, and Aviv Regev. 2015. “Spatial Reconstruction of Single-Cell Gene Expression Data.” *Nature Biotechnology* 33: 495–502. <https://doi.org/10.1038/nbt.3192>.

Stuart, Tim, Andrew Butler, Paul Hoffman, Christoph Hafemeister, Efthymia Papalexi, William M Mauck III, Yuhan Hao, Marlon Stoeckius, Peter Smibert, and Rahul Satija. 2019. “Comprehensive Integration of Single-Cell Data.” *Cell* 177: 1888–1902. <https://doi.org/10.1016/j.cell.2019.05.031>.

Vacher, Claire-Marie, Helene Lacaille, Jiaqi J O’Reilly, Jacquelyn Salzbank, Dana Bakalar, Sonia Sebaoui, Philippe Liere, et al. 2021. “Placental Endocrine Function Shapes Cerebellar Development and Social Behavior.” *Nat. Neurosci.* 24 (10): 1392–1401.

Zhang, Jianhai, Le Zhang, Brendan Gongol, Jordan Hayes, Alexander T Borowsky, Julia Bailey-Serres, and Thomas Girke. 2024. “SpatialHeatmap: Visualizing Spatial Bulk and Single-Cell Assays in Anatomical Images.” *NAR Genomics and Bioinformatics* 6 (1): lqae006. <https://doi.org/10.1093/nargab/lqae006>.

# Appendix