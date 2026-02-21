# Large-scale single-cell omics data manipulation with GDS files

#### Dr. Xiuwen Zheng (Genomics Research Center, AbbVie)

#### Jan 2023

* [Introduction](#introduction)
* [Installation](#installation)
* [Format conversion](#format-conversion)
  + [Conversion from SingleCellExperiment](#conversion-from-singlecellexperiment)
  + [Conversion from a matrix](#conversion-from-a-matrix)
* [Examples](#examples)
* [Data Manipulation and Analysis](#data-manipulation-and-analysis)
  + [1. Row and Column Summarization](#row-and-column-summarization)
  + [2. PCA analysis](#pca-analysis)
  + [3. UMAP analysis](#umap-analysis)
* [Miscellaneous](#miscellaneous)
  + [Debugging](#debugging)
* [Session Information](#session-information)

~

~

## Introduction

The SCArray package provides large-scale single-cell omics data manipulation using Genomic Data Structure ([GDS](http://www.bioconductor.org/packages/gdsfmt)) files. It combines dense/sparse matrices stored in GDS files and the Bioconductor infrastructure framework ([SingleCellExperiment](http://www.bioconductor.org/packages/SingleCellExperiment) and [DelayedArray](http://www.bioconductor.org/packages/DelayedArray)) to provide out-of-memory data storage and manipulation using the R programming language. As shown in the figure, SCArray provides a `SingleCellExperiment` object for downstream data analyses. GDS is an alternative to HDF5. Unlike HDF5, GDS supports the direct storage of a sparse matrix without converting it to multiple vectors.

![](data:image/svg+xml;base64...)

**Figure 1**: Workflow of SCArray

~

~

## Installation

* Requires R (>= v3.5.0), [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) (>= v1.35.4)
* Bioconductor repository

To install this package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("SCArray")
```

~

~

## Format conversion

### Conversion from SingleCellExperiment

The SCArray package can convert a single-cell experiment object (SingleCellExperiment) to a GDS file using the function `scConvGDS()`. For example,

```
suppressPackageStartupMessages(library(SCArray))
suppressPackageStartupMessages(library(SingleCellExperiment))

# load a SingleCellExperiment object
fn <- system.file("extdata", "example.rds", package="SCArray")
sce <- readRDS(fn)

# convert to a GDS file
scConvGDS(sce, "test.gds")
```

```
## Output: test.gds
## Compression: LZMA_RA
## Dimension: 250 x 500
## Assay List [counts]:
##     counts   !==================================================
##     |+ counts   { SparseReal32 250x500 LZMA_ra(13.2%), 77.2K }
## rowData:
## colData:
##     Cell_ID  [character]
##     Cell_type    [character]
##     Timepoint    [character]
## Done.
```

```
# list data structure in the GDS file
(f <- scOpen("test.gds"))
```

```
## Object of class "SCArrayFileClass"
## File: test.gds (82.6K)
## +    [  ] *
## |--+ feature.id   { Str8 250 LZMA_ra(71.2%), 1.1K }
## |--+ sample.id   { Str8 500 LZMA_ra(15.1%), 1.2K }
## |--+ counts   { SparseReal32 250x500 LZMA_ra(13.2%), 77.2K }
## |--+ feature.data   [  ]
## |--+ sample.data   [  ]
## |  |--+ Cell_ID   { Str8 500 LZMA_ra(15.1%), 1.2K }
## |  |--+ Cell_type   { Str8 500 LZMA_ra(4.49%), 141B }
## |  \--+ Timepoint   { Str8 500 LZMA_ra(5.31%), 193B }
## \--+ meta.data   [  ]
```

```
scClose(f)
```

### Conversion from a matrix

The input of `scConvGDS()` can be a dense or sparse matrix for count data:

```
library(Matrix)

cnt <- matrix(0, nrow=4, ncol=8)
set.seed(100); cnt[sample.int(length(cnt), 8)] <- rpois(8, 4)
(cnt <- as(cnt, "sparseMatrix"))
```

```
## 4 x 8 sparse Matrix of class "dgCMatrix"
##
## [1,] . . . . . . . 6
## [2,] 3 1 . . . 4 . .
## [3,] . . . . . 3 . 4
## [4,] 4 . 3 . . . . .
```

```
# convert to a GDS file
scConvGDS(cnt, "test.gds")
```

```
## Warning in scConvGDS(cnt, "test.gds"): rownames=NULL, use c("g1", "g2", ...) instead.
```

```
## Warning in scConvGDS(cnt, "test.gds"): colnames=NULL, use c("c1", "c2", ...) instead.
```

```
## Output: test.gds
## Compression: LZMA_RA
## Dimension: 4 x 8
## Assay List [counts]:
##     counts   !==================================================
##     |+ counts   { SparseReal32 4x8 LZMA_ra(159.4%), 109B }
## Done.
```

~

~

## Examples

When a single-cell GDS file is available, users can use `scExperiment()` to load a SingleCellExperiment object from the GDS file. The assay data in the SingleCellExperiment object are DelayedMatrix objects.

```
# a GDS file in the SCArray package
(fn <- system.file("extdata", "example.gds", package="SCArray"))
```

```
## [1] "/tmp/RtmpSmKz9v/Rinst2c2a4d49e0c140/SCArray/extdata/example.gds"
```

```
# load a SingleCellExperiment object from the file
sce <- scExperiment(fn)
sce
```

```
## class: SingleCellExperiment
## dim: 1000 850
## metadata(0):
## assays(1): counts
## rownames(1000): MRPL20 GNB1 ... RPS4Y1 CD24
## rowData names(0):
## colnames(850): 1772122_301_C02 1772122_180_E05 ... 1772122_180_B06 1772122_180_D09
## colData names(3): Cell_ID Cell_type Timepoint
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
# it is a DelayedMatrix (the whole matrix is not loaded)
assays(sce)$counts
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 1772122_300_H02 ... 1772122_180_B06 1772122_180_D09
##       MRPL20               3               2               3   .               0               2
##         GNB1              11               6              15   .               0               0
##        RPL22               3               5               7   .               6               6
##        PARK7               1               7               3   .               2               2
##         ENO1               8              19              20   .               7               4
##          ...               .               .               .   .               .               .
##         SSR4               0               6               3   .               5               1
##        RPL10              11               4               8   .               1               3
## SLC25A6-loc1               4               5               5   .               3               1
##       RPS4Y1               0               5               0   .               2               4
##         CD24              18               3               7   .               0               2
```

```
# column data
colData(sce)
```

```
## DataFrame with 850 rows and 3 columns
##                         Cell_ID   Cell_type   Timepoint
##                     <character> <character> <character>
## 1772122_301_C02 1772122_301_C02        eNb1      day_35
## 1772122_180_E05 1772122_180_E05        eNb1      day_35
## 1772122_300_H02 1772122_300_H02        eNb1      day_35
## 1772122_180_B09 1772122_180_B09        eNb1      day_35
## 1772122_180_G04 1772122_180_G04        eNb1      day_35
## ...                         ...         ...         ...
## 1772122_181_F11 1772122_181_F11       eRgld      day_35
## 1772122_181_E02 1772122_181_E02       eRgld      day_35
## 1772122_180_C03 1772122_180_C03       eRgld      day_35
## 1772122_180_B06 1772122_180_B06       eRgld      day_35
## 1772122_180_D09 1772122_180_D09       eRgld      day_35
```

```
# row data
rowData(sce)
```

```
## DataFrame with 1000 rows and 0 columns
```

~

~

## Data Manipulation and Analysis

SCArray provides a `SingleCellExperiment` object for downstream data analyses. At first, we create a log count matrix `logcnt` from the count matrix. Note that `logcnt` is also a DelayedMatrix without actually generating the whole matrix.

```
cnt <- assays(sce)$counts
logcnt <- log2(cnt + 1)
logcnt
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 1772122_300_H02 ... 1772122_180_B06 1772122_180_D09
##       MRPL20        2.000000        1.584963        2.000000   .        0.000000        1.584963
##         GNB1        3.584963        2.807355        4.000000   .        0.000000        0.000000
##        RPL22        2.000000        2.584963        3.000000   .        2.807355        2.807355
##        PARK7        1.000000        3.000000        2.000000   .        1.584963        1.584963
##         ENO1        3.169925        4.321928        4.392317   .        3.000000        2.321928
##          ...               .               .               .   .               .               .
##         SSR4        0.000000        2.807355        2.000000   .        2.584963        1.000000
##        RPL10        3.584963        2.321928        3.169925   .        1.000000        2.000000
## SLC25A6-loc1        2.321928        2.584963        2.584963   .        2.000000        1.000000
##       RPS4Y1        0.000000        2.584963        0.000000   .        1.584963        2.321928
##         CD24        4.247928        2.000000        3.000000   .        0.000000        1.584963
```

**Formally**, we call `logNormCounts()` in the scuttle package to normalize the raw counts.

```
suppressPackageStartupMessages(library(scuttle))

sce <- logNormCounts(sce)
logcounts(sce)
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 1772122_300_H02 ... 1772122_180_B06 1772122_180_D09
##       MRPL20        2.318287        1.425944        1.693629   .        0.000000        1.835269
##         GNB1        3.965364        2.599486        3.605669   .        0.000000        0.000000
##        RPL22        2.318287        2.383291        2.635589   .        3.463948        3.121867
##        PARK7        1.219792        2.787466        1.693629   .        2.119300        1.835269
##         ENO1        3.540158        4.089631        3.990770   .        3.667541        2.617477
##          ...               .               .               .   .               .               .
##         SSR4        0.000000        2.599486        1.693629   .        3.226828        1.191683
##        RPL10        3.965364        2.128889        2.798918   .        1.418144        2.278749
## SLC25A6-loc1        2.659132        2.383291        2.240159   .        2.589103        1.191683
##       RPS4Y1        0.000000        2.383291        0.000000   .        2.119300        2.617477
##         CD24        4.639485        1.819813        2.635589   .        0.000000        1.835269
```

### 1. Row and Column Summarization

The [DelayedMatrixStats](http://www.bioconductor.org/packages/DelayedMatrixStats) package provides summarization functions operating on rows and columns of DelayedMatrix objects. SCArray has provided the optimized implementations for the row and column summarization. For example, we can calculate the mean for each column or row of the log count matrix.

```
col_mean <- colMeans(logcnt)
str(col_mean)
```

```
##  Named num [1:850] 1.51 1.95 2.25 1.95 1.75 ...
##  - attr(*, "names")= chr [1:850] "1772122_301_C02" "1772122_180_E05" "1772122_300_H02" "1772122_180_B09" ...
```

```
row_mean <- rowMeans(logcnt)
str(row_mean)
```

```
##  Named num [1:1000] 1.27 1.51 2.62 1.98 3.75 ...
##  - attr(*, "names")= chr [1:1000] "MRPL20" "GNB1" "RPL22" "PARK7" ...
```

```
# calculate the mean and variance at the same time
mvar <- scRowMeanVar(logcnt)
head(mvar)
```

```
##          mean       var
## [1,] 1.271806 0.9867109
## [2,] 1.514454 1.0162891
## [3,] 2.623583 1.0823599
## [4,] 1.976739 1.1728957
## [5,] 3.754426 1.0599877
## [6,] 1.315402 0.9287027
```

### 2. PCA analysis

The [scater](http://www.bioconductor.org/packages/scater) package can perform the Principal component analysis (PCA) on the normalized cell data.

```
suppressPackageStartupMessages(library(scater))

# run umap analysis
sce <- runPCA(sce)
```

`scater::runPCA()` will call the function `beachmat::realizeFileBackedMatrix()` internally to realize a scaled and centered DelayedMatrix into its corresponding in-memory format, so it is memory-intensive for large-scale PCA.

**Instead**, the SCArray package provides `scRunPCA()` for reducing the memory usage in large-scale PCA by perform SVD on the relatively small covariance matrix.

```
sce <- scRunPCA(sce)
```

```
## Select top 500 features with the highest variances ...
## Start PCA on the covariance matrix ...
```

`plotReducedDim()` plots cell-level reduced dimension results (PCA) stored in the SingleCellExperiment object:

```
plotReducedDim(sce, dimred="PCA")
```

![](data:image/png;base64...)

### 3. UMAP analysis

The [scater](http://www.bioconductor.org/packages/scater) package can perform the uniform manifold approximation and projection (UMAP) for the cell data, based on the data in a SingleCellExperiment object.

```
suppressPackageStartupMessages(library(scater))

# run umap analysis
sce <- runUMAP(sce)
```

`plotReducedDim()` plots cell-level reduced dimension results (UMAP) stored in the SingleCellExperiment object:

```
plotReducedDim(sce, dimred="UMAP")
```

![](data:image/png;base64...)

~

~

## Miscellaneous

### Debugging

`options(SCArray.verbose=TRUE)` is used to enable displaying debug information when calling the functions in the SCArray packages. For example,

```
options(SCArray.verbose=TRUE)

m <- rowMeans(logcnt)
```

```
## Calling SCArray:::x_rowMeans() with SC_GDSMatrix [1000x850] ...
```

```
str(m)
```

```
##  Named num [1:1000] 1.27 1.51 2.62 1.98 3.75 ...
##  - attr(*, "names")= chr [1:1000] "MRPL20" "GNB1" "RPL22" "PARK7" ...
```

~

~

## Session Information

```
# print version information about R, the OS and attached or loaded packages
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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] scater_1.38.0               ggplot2_4.0.0               scuttle_1.20.0
##  [4] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0               SCArray_1.18.0
## [10] DelayedArray_0.36.0         SparseArray_1.10.0          S4Arrays_1.10.0
## [13] abind_1.4-8                 IRanges_2.44.0              S4Vectors_0.48.0
## [16] MatrixGenerics_1.22.0       matrixStats_1.5.0           BiocGenerics_0.56.0
## [19] generics_0.1.4              Matrix_1.7-4                gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] beeswarm_0.4.0            gtable_0.3.6              xfun_0.53                 bslib_0.9.0
##  [5] ggrepel_0.9.6             lattice_0.22-7            vctrs_0.6.5               tools_4.5.1
##  [9] parallel_4.5.1            tibble_3.3.0              pkgconfig_2.0.3           BiocNeighbors_2.4.0
## [13] RColorBrewer_1.1-3        S7_0.2.0                  sparseMatrixStats_1.22.0  lifecycle_1.0.4
## [17] FNN_1.1.4.1               compiler_4.5.1            farver_2.1.2              codetools_0.2-20
## [21] vipor_0.4.7               htmltools_0.5.8.1         sass_0.4.10               yaml_2.3.10
## [25] pillar_1.11.1             crayon_1.5.3              jquerylib_0.1.4           uwot_0.2.3
## [29] BiocParallel_1.44.0       cachem_1.1.0              viridis_0.6.5             tidyselect_1.2.1
## [33] rsvd_1.0.5                digest_0.6.37             BiocSingular_1.26.0       dplyr_1.1.4
## [37] labeling_0.4.3            cowplot_1.2.0             fastmap_1.2.0             grid_4.5.1
## [41] cli_3.6.5                 magrittr_2.0.4            dichromat_2.0-0.1         withr_3.0.2
## [45] DelayedMatrixStats_1.32.0 scales_1.4.0              ggbeeswarm_0.7.2          rmarkdown_2.30
## [49] XVector_0.50.0            gridExtra_2.3             ScaledMatrix_1.18.0       beachmat_2.26.0
## [53] evaluate_1.0.5            knitr_1.50                viridisLite_0.4.2         irlba_2.3.5.1
## [57] rlang_1.1.6               Rcpp_1.1.0                glue_1.8.0                jsonlite_2.0.0
## [61] R6_2.6.1
```