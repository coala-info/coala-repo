# Scoring potential doublets from simulated densities

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 2025-10-30

#### Package

scDblFinder 1.24.0

# Contents

* [1 tl;dr](#tldr)
* [2 Algorithm overview](#overview)
* [3 Size factor handling](#size-factor-handling)
  + [3.1 Normalization size factors](#normalization-size-factors)
  + [3.2 RNA content size factors](#rna-content-size-factors)
  + [3.3 Interactions between them](#interactions-between-them)
* [4 Doublet score calculations](#doublet-score-calculations)
* [Session information](#session-information)

# 1 tl;dr

To demonstrate, we’ll use one of the mammary gland datasets from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
We will subset it down to a random set of 1000 cells for speed.

```
library(scRNAseq)
sce <- BachMammaryData(samples="G_1")

set.seed(1001)
sce <- sce[,sample(ncol(sce), 1000)]
```

For the purposes of this demonstration, we’ll perform an extremely expedited analysis.
One would usually take more care here and do some quality control,
create some diagnostic plots, etc., but we don’t have the space for that.

```
library(scuttle)
sce <- logNormCounts(sce)

library(scran)
dec <- modelGeneVar(sce)
hvgs <- getTopHVGs(dec, n=1000)

library(scater)
set.seed(1002)
sce <- runPCA(sce, ncomponents=10, subset_row=hvgs)
sce <- runTSNE(sce, dimred="PCA")
```

We run `computeDoubletDensity()` to obtain a doublet score for each cell based on the density of simulated doublets around it.
We log this to get some better dynamic range.

```
set.seed(1003)
library(scDblFinder)
scores <- computeDoubletDensity(sce, subset.row=hvgs)
plotTSNE(sce, colour_by=I(log1p(scores)))
```

![](data:image/png;base64...)

# 2 Algorithm overview

We use a fairly simple approach in `doubletCells` that involves creating simulated doublets from the original data set:

1. Perform a PCA on the log-normalized expression for all cells in the dataset.
2. Randomly select two cells and add their count profiles together.
   Compute the log-normalized profile and project it into the PC space.
3. Repeat **2** to obtain \(N\_s\) simulated doublet cells.
4. For each cell, compute the local density of simulated doublets, scaled by the density of the original cells.
   This is used as the doublet score.

# 3 Size factor handling

## 3.1 Normalization size factors

We allow specification of two sets of size factors for different purposes.
The first set is the normalization set: division of counts by these size factors yields expression values to be compared across cells.
This is necessary to compute log-normalized expression values for the PCA.

These size factors are usually computed from some method that assumes most genes are not DE.
We default to library size normalization though any arbitrary set of size factors can be used.
The size factor for each doublet is computed as the sum of size factors for the individual cells, based on the additivity of scaling biases.

## 3.2 RNA content size factors

The second set is the RNA content set: division of counts by these size factors yields expression values that are proportional to absolute abundance across cells.
This affects the creation of simulated doublets by controlling the scaling of the count profiles for the individual cells.
These size factors would normally be estimated with spike-ins, but in their absence we default to using unity for all cells.

The use of unity values implies that the library size for each cell is a good proxy for total RNA content.
This is unlikely to be true: technical biases mean that the library size is an imprecise relative estimate of the content.
Saturation effects and composition biases also mean that the expected library size for each population is not an accurate estimate of content.
The imprecision will spread out the simulated doublets while the inaccuracy will result in a systematic shift from the location of true doublets.

Arguably, such problems exist for any doublet estimation method without spike-in information.
We can only hope that the inaccuracies have only minor effects on the creation of simulated cells.
Indeed, the first effect does mitigate the second to some extent by ensuring that some simulated doublets will occupy the neighbourhood of the true doublets.

## 3.3 Interactions between them

These two sets of size factors play different roles so it is possible to specify both of them.
We use the following algorithm to accommodate non-unity values for the RNA content size factors:

1. The RNA content size factors are used to scale the counts first.
   This ensures that RNA content has the desired effect in step **2** of Section [2](#overview).
2. The normalization size factors are also divided by the content size factors.
   This ensures that normalization has the correct effect, see below.
3. The rest of the algorithm proceeds as if the RNA content size factors were unity.
   Addition of count profiles is done without further scaling, and normalized expression values are computed with the rescaled normalization size factors.

To understand the correctness of the rescaled normalization size factors, consider a non-DE gene with abundance \(\lambda\_g\).
The expected count in each cell is \(\lambda\_g s\_i\) for scaling bias \(s\_i\) (i.e., normalization size factor).
The rescaled count is \(\lambda\_g s\_i c\_i^{-1}\) for some RNA content size factor \(c\_i\).
The rescaled normalization size factor is \(s\_i c\_i^{-1}\), such that normalization yields \(\lambda\_g\) as desired.
This also holds for doublets where the scaling biases and size factors are additive.

# 4 Doublet score calculations

We assume that the simulation accurately mimics doublet creation - amongst other things, we assume that doublets are equally likely to form between any cell populations and any differences in total RNA between subpopulations are captured or negligible.
If these assumptions hold, then at any given region in the expression space, the number of doublets among the real cells is proportional to the number of simulated doublets lying in the same region.
Thus, the probability that a cell is a doublet is proportional to the ratio of the number of neighboring simulated doublets to the number of neighboring real cells.

A mild additional challenge here is that the number of simulated cells \(N\_s\) can vary.
Ideally, we would like the expected output of the function to be the same regardless of the user’s choice of \(N\_s\), i.e., the chosen value should only affect the precision/speed trade-off.
Many other doublet-based methods take a \(k\)-nearest neighbours approach to compute densities; but if \(N\_s\) is too large relative to the number of real cells, all of the \(k\) nearest neighbours will be simulated, while if \(N\_s\) is too small, all of the nearest neighbors will be original cells.

Thus, we use a modified version of the \(k\)NN approach whereby we identify the distance from each cell to its \(k\)-th nearest neighbor.
This defines a hypersphere around that cell in which we count the number of simulated cells.
We then compute the odds ratio of the number of simulated cells in the hypersphere to \(N\_s\), divided by the ratio of \(k\) to the total number of cells in the dataset.
This score captures the relative frequency of simulated cells to real cells while being robust to changes to \(N\_s\).

# Session information

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
##  [1] bluster_1.20.0              scDblFinder_1.24.0
##  [3] scater_1.38.0               ggplot2_4.0.0
##  [5] scran_1.38.0                scuttle_1.20.0
##  [7] ensembldb_2.34.0            AnnotationFilter_1.34.0
##  [9] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
## [11] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] magick_2.9.0             ggbeeswarm_0.7.2         gypsum_1.6.0
##   [7] farver_2.1.2             rmarkdown_2.30           BiocIO_1.20.0
##  [10] vctrs_0.6.5              memoise_2.0.1            Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17          tinytex_0.57             htmltools_0.5.8.1
##  [16] S4Arrays_1.10.0          AnnotationHub_4.0.0      curl_7.0.0
##  [19] BiocNeighbors_2.4.0      xgboost_1.7.11.1         Rhdf5lib_1.32.0
##  [22] SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
##  [34] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
##  [37] fastmap_1.2.0            digest_0.6.37            dqrng_0.4.1
##  [40] irlba_2.3.5.1            ExperimentHub_3.0.0      RSQLite_2.4.3
##  [43] beachmat_2.26.0          labeling_0.4.3           filelock_1.0.3
##  [46] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [49] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [52] BiocParallel_1.44.0      viridis_0.6.5            DBI_1.2.3
##  [55] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [58] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [61] rjson_0.2.23             tools_4.5.1              vipor_0.4.7
##  [64] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [67] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1
##  [70] Rtsne_0.17               cluster_2.1.8.1          gtable_0.3.6
##  [73] data.table_1.17.8        BiocSingular_1.26.0      ScaledMatrix_1.18.0
##  [76] metapod_1.18.0           XVector_0.50.0           ggrepel_0.9.6
##  [79] BiocVersion_3.22.0       pillar_1.11.1            limma_3.66.0
##  [82] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [85] rtracklayer_1.70.0       bit_4.6.0                tidyselect_1.2.1
##  [88] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
##  [91] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [94] edgeR_4.8.0              xfun_0.53                statmod_1.5.1
##  [97] UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
## [100] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
## [103] tibble_3.3.0             alabaster.matrix_1.10.0  BiocManager_1.30.26
## [106] cli_3.6.5                jquerylib_0.1.4          dichromat_2.0-0.1
## [109] Rcpp_1.1.0               GenomeInfoDb_1.46.0      dbplyr_2.5.1
## [112] png_0.1-8                XML_3.99-0.19            parallel_4.5.1
## [115] blob_1.2.4               bitops_1.0-9             viridisLite_0.4.2
## [118] alabaster.se_1.10.0      scales_1.4.0             purrr_1.1.0
## [121] crayon_1.5.3             rlang_1.1.6              cowplot_1.2.0
## [124] KEGGREST_1.50.0
```