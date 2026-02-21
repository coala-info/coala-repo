# Differential abundance testing with Milo

Emma Dann and Mike Morgan

#### 30 October 2025

#### Package

miloR 2.6.0

```
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
```

# 1 Introduction

Milo is a tool for analysis of complex single cell datasets generated from replicated multi-condition experiments, which detects changes in composition between conditions. While differential abundance (DA) is commonly quantified in discrete cell clusters, Milo uses partially overlapping neighbourhoods of cells on a KNN graph. Starting from a graph that faithfully recapitulates the biology of the cell population, Milo analysis consists of 3 steps:

1. Sampling of representative neighbourhoods
2. Testing for differential abundance of conditions in all neighbourhoods
3. Accounting for multiple hypothesis testing using a weighted FDR procedure that accounts for the overlap of neighbourhoods

In this vignette we will elaborate on how these steps are implemented in the `miloR` package.

# 2 Load data

For this demo we will use a synthetic dataset simulating a developmental trajectory, generated using [dyntoy](https://github.com/dynverse/dyntoy).

```
data("sim_trajectory", package = "miloR")

## Extract SingleCellExperiment object
traj_sce <- sim_trajectory[['SCE']]

## Extract sample metadata to use for testing
traj_meta <- sim_trajectory[["meta"]]

## Add metadata to colData slot
colData(traj_sce) <- DataFrame(traj_meta)
colnames(traj_sce) <- colData(traj_sce)$cell_id

redim <- reducedDim(traj_sce, "PCA")
dimnames(redim) <- list(colnames(traj_sce), paste0("PC", c(1:50)))
reducedDim(traj_sce, "PCA") <- redim
```

# 3 Pre-processing

For DA analysis we need to construct an undirected KNN graph of single-cells. Standard single-cell analysis pipelines usually do this from distances in PCA. We normalize and calculate principal components using `scater`. I also run UMAP for visualization purposes.

```
logcounts(traj_sce) <- log(counts(traj_sce) + 1)
traj_sce <- runPCA(traj_sce, ncomponents=30)
traj_sce <- runUMAP(traj_sce)

plotUMAP(traj_sce)
```

![](data:image/png;base64...)

# 4 Create a Milo object

For differential abundance analysis on graph neighbourhoods we first construct a `Milo` object. This extends the [`SingleCellExperiment`](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) class to store information about neighbourhoods on the KNN graph.

## 4.1 From SingleCellExperiment object

The `Milo` constructor takes as input a `SingleCellExperiment` object.

```
traj_milo <- Milo(traj_sce)
reducedDim(traj_milo, "UMAP") <- reducedDim(traj_sce, "UMAP")

traj_milo
```

```
## class: Milo
## dim: 500 500
## metadata(0):
## assays(2): counts logcounts
## rownames(500): G1 G2 ... G499 G500
## rowData names(0):
## colnames(500): C1 C2 ... C499 C500
## colData names(5): cell_id group_id Condition Replicate Sample
## reducedDimNames(2): PCA UMAP
## mainExpName: NULL
## altExpNames(0):
## nhoods dimensions(2): 1 1
## nhoodCounts dimensions(2): 1 1
## nhoodDistances dimension(1): 0
## graph names(0):
## nhoodIndex names(1): 0
## nhoodExpression dimension(2): 1 1
## nhoodReducedDim names(0):
## nhoodGraph names(0):
## nhoodAdjacency dimension(2): 1 1
```

## 4.2 From AnnData object (.h5ad)

We can use the [`zellkonverter`](https://theislab.github.io/zellkonverter/articles/zellkonverter.html) package to make a `SingleCellExperiment` object from an `AnnData` object stored as `h5ad` file.

```
library(zellkonverter)

# Obtaining an example H5AD file.
example_h5ad <- system.file("extdata", "krumsiek11.h5ad",
                            package = "zellkonverter")

example_h5ad_sce <- readH5AD(example_h5ad)
example_h5ad_milo <- Milo(example_h5ad_sce)
```

## 4.3 From Seurat object

The `Seurat` package includes a converter to `SingleCellExperiment`.

```
library(Seurat)
data("pbmc_small")
pbmc_small_sce <- as.SingleCellExperiment(pbmc_small)
pbmc_small_milo <- Milo(pbmc_small_sce)
```

# 5 Construct KNN graph

We need to add the KNN graph to the Milo object. This is stored in the `graph` slot, in [`igraph`](https://igraph.org/r/) format. The `miloR` package includes functionality to build and store the graph from the PCA dimensions stored in the `reducedDim` slot.

```
traj_milo <- buildGraph(traj_milo, k = 10, d = 30)
```

```
## Constructing kNN graph with k:10
```

**In progress:** we are perfecting the functionality to add a precomputed KNN graph (for example constructed with Seurat or scanpy) to the `graph` slot using the adjacency matrix.

# 6 1. Defining representative neighbourhoods

We define the neighbourhood of a cell, the index, as the group of cells connected by an edge in the KNN graph to the index cell. For efficiency, we don’t test for DA in the neighbourhood of every cell, but we sample as indices a subset of representative cells, using a KNN sampling algorithm used by [Gut et al. 2015](https://www.nature.com/articles/nmeth.3545).

For sampling you need to define a few parameters:

* `prop`: the proportion of cells to randomly sample to start with (usually 0.1 - 0.2 is sufficient)
* `k`: the k to use for KNN refinement (we recommend using the same k used for KNN graph building)
* `d`: the number of reduced dimensions to use for KNN refinement (we recommend using the same d used for KNN graph building)
* `refined` indicated whether you want to use the sampling refinement algorithm, or just pick cells at random. The default and recommended way to go is to use refinement. The only situation in which you might consider using random instead, is if you have batch corrected your data with a graph based correction algorithm, such as [BBKNN](https://github.com/Teichlab/bbknn), but the results of DA testing will be suboptimal.

```
traj_milo <- makeNhoods(traj_milo, prop = 0.1, k = 10, d=30, refined = TRUE)
```

```
## Checking valid object
```

```
## Running refined sampling with reduced_dim
```

Once we have defined neighbourhoods, it’s good to take a look at how big the neighbourhoods are (i.e. how many cells form each neighbourhood). This affects the power of DA testing. We can check this out using the `plotNhoodSizeHist` function. Empirically, we found it’s best to have a distribution peaking between 50 and 100. Otherwise you might consider rerunning `makeNhoods` increasing `k` and/or `prop` (here the distribution looks ludicrous because it’s a small dataset).

```
plotNhoodSizeHist(traj_milo)
```

![](data:image/png;base64...)

# 7 Counting cells in neighbourhoods

Now we have to count how many cells from each sample are in each neighbourhood. We need to use the cell metadata and specify which column contains the sample information.

```
traj_milo <- countCells(traj_milo, meta.data = data.frame(colData(traj_milo)), samples="Sample")
```

```
## Checking meta.data validity
```

```
## Counting cells in neighbourhoods
```

This adds to the `Milo` object a `n \times m` matrix, where n is the number of neighbourhoods and \(m\) is the number of experimental samples. Values indicate the number of cells from each sample counted in a neighbourhood. This count matrix will be used for DA testing.

```
head(nhoodCounts(traj_milo))
```

```
## 6 x 6 sparse Matrix of class "dgCMatrix"
##   B_R1 A_R1 A_R2 B_R2 B_R3 A_R3
## 1   15    .    1   22   29    1
## 2    3    5    4    4    4    3
## 3   13    2    1   19   21    1
## 4    6    6    3    3    7    5
## 5    9    6    7    7    6   10
## 6    6    6    4    5    9    8
```

# 8 Differential abundance testing

Now we are all set to test for differential abundance in neighbourhoods. We implement this hypothesis testing in a generalized linear model (GLM) framework, specifically using the Negative Binomial GLM implementation in [`edgeR`](https://bioconductor.org/packages/release/bioc/html/edgeR.html).

We first need to think about our experimental design. The design matrix should match samples to a condition of interest. In this case the `Condition` is the covariate we are going to test for.

```
traj_design <- data.frame(colData(traj_milo))[,c("Sample", "Condition")]
traj_design <- distinct(traj_design)
rownames(traj_design) <- traj_design$Sample
## Reorder rownames to match columns of nhoodCounts(milo)
traj_design <- traj_design[colnames(nhoodCounts(traj_milo)), , drop=FALSE]

traj_design
```

```
##      Sample Condition
## B_R1   B_R1         B
## A_R1   A_R1         A
## A_R2   A_R2         A
## B_R2   B_R2         B
## B_R3   B_R3         B
## A_R3   A_R3         A
```

Milo uses an adaptation of the Spatial FDR correction introduced by [cydar](https://bioconductor.org/packages/release/bioc/html/cydar.html), which accounts for the overlap between neighbourhoods. Specifically, each hypothesis test P-value is weighted by the reciprocal of the kth nearest neighbour distance. To use this statistic we first need to store the distances between nearest neighbors in the Milo object.

```
traj_milo <- calcNhoodDistance(traj_milo, d=30)
```

```
## 'as(<dgTMatrix>, "dgCMatrix")' is deprecated.
## Use 'as(., "CsparseMatrix")' instead.
## See help("Deprecated") and help("Matrix-deprecated").
```

Now we can do the test, explicitly defining our experimental design.

```
rownames(traj_design) <- traj_design$Sample
da_results <- testNhoods(traj_milo, design = ~ Condition, design.df = traj_design)
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with k-distance weighting
```

This calculates a Fold-change and corrected P-value for each neighbourhood, which indicates whether there is significant differential abundance between conditions.

```
da_results %>%
  arrange(- SpatialFDR) %>%
  head()
```

```
##         logFC   logCPM        F    PValue       FDR Nhood SpatialFDR
## 13  0.1136068 15.89283 0.108962 0.8027533 0.8027533    13  0.8027533
## 8  -0.5352258 15.64496 1.817189 0.2693130 0.2796712     8  0.2793966
## 20 -1.1299016 15.10437 1.507524 0.2221866 0.2399615    20  0.2395509
## 27  0.7579818 15.64487 2.939485 0.1599397 0.1799322    27  0.1793246
## 2  -1.1216882 15.18932 2.368938 0.1266961 0.1487302     2  0.1488131
## 4  -0.8192245 15.45233 2.455988 0.1200029 0.1473200     4  0.1477191
```

# 9 Visualize neighbourhoods displaying DA

To visualize DA results, we build an abstracted graph of neighbourhoods that we can superimpose on the single-cell embedding.

```
traj_milo <- buildNhoodGraph(traj_milo)

plotUMAP(traj_milo) + plotNhoodGraphDA(traj_milo, da_results, alpha=0.05) +
  plot_layout(guides="collect")
```

```
## Adding nhood effect sizes to neighbourhood graph attributes
```

![](data:image/png;base64...)

**Session Info**

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
##  [1] MouseThymusAgeing_1.17.0    patchwork_1.3.2
##  [3] dplyr_1.1.4                 scran_1.38.0
##  [5] scater_1.38.0               ggplot2_4.0.0
##  [7] scuttle_1.20.0              SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] miloR_2.6.0                 edgeR_4.8.0
## [21] limma_3.66.0                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2     magick_2.9.0         farver_2.1.2
##   [7] rmarkdown_2.30       vctrs_0.6.5          memoise_2.0.1
##  [10] tinytex_0.57         htmltools_0.5.8.1    S4Arrays_1.10.0
##  [13] AnnotationHub_4.0.0  curl_7.0.0           BiocNeighbors_2.4.0
##  [16] SparseArray_1.10.0   sass_0.4.10          pracma_2.4.6
##  [19] bslib_0.9.0          httr2_1.2.1          cachem_1.1.0
##  [22] igraph_2.2.1         lifecycle_1.0.4      pkgconfig_2.0.3
##  [25] rsvd_1.0.5           Matrix_1.7-4         R6_2.6.1
##  [28] fastmap_1.2.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [31] AnnotationDbi_1.72.0 dqrng_0.4.1          irlba_2.3.5.1
##  [34] ExperimentHub_3.0.0  RSQLite_2.4.3        beachmat_2.26.0
##  [37] filelock_1.0.3       labeling_0.4.3       httr_1.4.7
##  [40] polyclip_1.10-7      abind_1.4-8          compiler_4.5.1
##  [43] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [46] BiocParallel_1.44.0  viridis_0.6.5        DBI_1.2.3
##  [49] ggforce_0.5.0        MASS_7.3-65          rappdirs_0.3.3
##  [52] DelayedArray_0.36.0  bluster_1.20.0       gtools_3.9.5
##  [55] tools_4.5.1          vipor_0.4.7          beeswarm_0.4.0
##  [58] glue_1.8.0           grid_4.5.1           cluster_2.1.8.1
##  [61] gtable_0.3.6         tidyr_1.3.1          BiocSingular_1.26.0
##  [64] tidygraph_1.3.1      ScaledMatrix_1.18.0  metapod_1.18.0
##  [67] XVector_0.50.0       ggrepel_0.9.6        BiocVersion_3.22.0
##  [70] pillar_1.11.1        stringr_1.5.2        splines_4.5.1
##  [73] tweenr_2.0.3         BiocFileCache_3.0.0  lattice_0.22-7
##  [76] FNN_1.1.4.1          bit_4.6.0            tidyselect_1.2.1
##  [79] locfit_1.5-9.12      Biostrings_2.78.0    knitr_1.50
##  [82] gridExtra_2.3        bookdown_0.45        xfun_0.53
##  [85] graphlayouts_1.2.2   statmod_1.5.1        stringi_1.8.7
##  [88] yaml_2.3.10          evaluate_1.0.5       codetools_0.2-20
##  [91] ggraph_2.2.2         tibble_3.3.0         BiocManager_1.30.26
##  [94] cli_3.6.5            uwot_0.2.3           jquerylib_0.1.4
##  [97] dichromat_2.0-0.1    Rcpp_1.1.0           dbplyr_2.5.1
## [100] png_0.1-8            parallel_4.5.1       blob_1.2.4
## [103] viridisLite_0.4.2    scales_1.4.0         purrr_1.1.0
## [106] crayon_1.5.3         rlang_1.1.6          cowplot_1.2.0
## [109] KEGGREST_1.50.0
```