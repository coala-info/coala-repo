# CB2 improves power of cell detection in droplet-based single-cell RNA sequencing data

Zijian Ni and Christina Kendziorski

#### 06/23/2020

#### Package

scCB2 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
  + [2.1 Installation](#installation)
  + [2.2 All-in-one function](#all-in-one-function)
  + [2.3 Running Speed](#running-speed)
  + [2.4 Saving a sparse matrix to 10x format](#saving-a-sparse-matrix-to-10x-format)
* [3 Detailed Steps](#detailed-steps)
  + [3.1 Read count matrix from 10x output raw data](#read-count-matrix-from-10x-output-raw-data)
  + [3.2 Choose an appropriate background cutoff](#choose-an-appropriate-background-cutoff)
  + [3.3 Run **CB2** to distinguish real cells from empty droplets](#run-cb2-to-distinguish-real-cells-from-empty-droplets)
  + [3.4 Extract real cell matrix](#extract-real-cell-matrix)
  + [3.5 Downstream analysis](#downstream-analysis)
  + [3.6 All-in-one function](#all-in-one-function-1)
* [4 Session Information](#session-information)
* [5 Citation](#citation)

# 1 Introduction

Droplet-based single-cell RNA sequencing (scRNA-seq) is a powerful and widely-used approach for profiling genome-wide gene expression in individual cells. Current commercial droplet-based technologies such as 10X Genomics utilize gel beads, each containing oligonucleotide indexes made up of bead-specific barcodes combined with unique molecular identifiers (UMIs) and oligo-dT tags to prime polyadenylated RNA. Single cells of interest are combined with reagents in one channel of a microfluidic chip, and gel beads in another, to form gel-beads in emulsion, or GEMs. Oligonucleotide indexes bind polyadenylated RNA within each GEM reaction vesicle before gel beads are dissolved releasing the bound oligos into solution for reverse transcription. By design, each resulting cDNA molecule contains a UMI and a GEM-specific barcode that, ideally, tags mRNA from an individual cell, but this is often not the case in practice. To distinguish true cells from background barcodes in droplet-based single cell RNA-seq experiments, we introduce **CB2** and `scCB2`, its corresponding R package.

**CB2** extends the EmptyDrops approach by introducing a clustering step that groups similar barcodes and then conducts a statistical test to identify groups with expression distributions that vary from the background. While advantages are expected in many settings, users will benefit from noting that **CB2** does not test for doublets or multiplets and, consequently, some of the high count identifications may consist of two or more cells. Methods for identifying multiplets may prove useful after applying **CB2**. It is also important to note that any method for distinguishing cells from background barcodes is technically correct in identifying low-quality cells given that damaged cells exhibit expression profiles that differ from the background. Specifically, mitochondrial gene expression is often high in damaged cells. Such cells are typically not of interest in downstream analysis and should therefore be removed. The GetCellMat function in `scCB2` can be used toward this end.

# 2 Quick Start

## 2.1 Installation

Install from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("scCB2")
```

## 2.2 All-in-one function

`QuickCB2` is an all-in-one function to apply CB2 on 10x Cell Ranger raw data and get a matrix of real cells identified by CB2 under default settings. By specifying `AsSeurat = TRUE`, a Seurat object is returned so that users can directly apply the Seurat pipeline for downstream analyses.

Usage:

```
library(scCB2)

# If raw data has three separate files within one directory
# and you want to control FDR at the default 1%:
RealCell <-  QuickCB2(dir = "/path/to/raw/data/directory")

# If raw data is in HDF5 format and
# you'd like a Seurat object under default FDR threshold:
RealCell_S <-  QuickCB2(h5file = "/path/to/raw/data/HDF5",
                        AsSeurat = TRUE)
```

An example illustrating how it works and what the final output looks like can be found at the end of *Detailed Steps*.

## 2.3 Running Speed

The computational speed is related to the size and structure of input datasets. As a reference, scCB2 running on a medium-size dataset (around 30,000 genes and 8,000 cells after cell calling) using 6 cores takes less than 10 minutes.

## 2.4 Saving a sparse matrix to 10x format

For users who would like to save the CB2 output cell matrix to 10x format (e.g. “matrix.mtx”, “barcodes.tsv” and “genes.tsv”), there are existing packages to help. For example in package `DropletUtils`:

```
DropletUtils::write10xCounts(path = "/path/to/save/data",
                             x = RealCell)
```

# 3 Detailed Steps

## 3.1 Read count matrix from 10x output raw data

Currently, the most widely-used droplet-based protocol is 10x Chromium. Our package provides functions to directly read 10x Cell Ranger output files and generate a feature-by-barcode count matrix that may be read into R. Public 10x datasets can be found [here](https://www.10xgenomics.com/resources/datasets).

Our package contains a small subset of 10x data, `mbrainSub`, corresponding to the first 50,000 barcodes of [1k Brain Cells from an E18 Mouse](http://cf.10xgenomics.com/samples/cell-exp/2.1.0/neurons_900/neurons_900_raw_gene_bc_matrices.tar.gz).

We first generate 10x output files of `mbrainSub`, then read it using our built-in functions.

```
library(scCB2)
library(SummarizedExperiment)

data(mbrainSub)

data.dir <- file.path(tempdir(),"CB2_example")
DropletUtils::write10xCounts(data.dir,
                             mbrainSub,
                             version = "3")

list.files(data.dir)
```

```
## [1] "barcodes.tsv.gz" "features.tsv.gz" "matrix.mtx.gz"
```

For Cell Ranger version <3, the raw data from 10x Cell Ranger output contains “barcodes.tsv”, “genes.tsv” and “matrix.mtx”. For Cell Ranger version >=3, the output files are “barcodes.tsv.gz”, “features.tsv.gz” and “matrix.mtx.gz”. We now read these files back into R and compare with original data matrix.

```
mbrainSub_2 <- Read10xRaw(data.dir)
identical(mbrainSub, mbrainSub_2)
```

```
## [1] TRUE
```

If raw data is not from the 10x Chromium pipeline, a user may manually create the feature-by-barcode count matrix with rows representing genes and columns representing barcodes. Gene and barcode IDs should be unique. The format of the count matrix can be either a sparse matrix or standard matrix.

## 3.2 Choose an appropriate background cutoff

The key parameter of CB2 as well as other similar methods is the background cutoff, which divides barcodes into two groups: (1) small barcodes that are most likely to be background empty droplets; (2) the rest barcodes that can be either background or cell, and remain to be tested. Those small barcodes will be used to estimate a background distribution, which guides the identification of cells from background. It is crucial to have an unbiased estimation of the background distribution.

By default, the background cutoff is set to be 100, meaning all barcodes with total UMI counts less or equal to 100 are used to estimate the background distribution. Empirically, this setting has worked well in most real world datasets. However, for datasets with special structures, or with unexpectedly lower or higher number of detected cells, it is recommended to re-evaluate the choice of background cutoff.

An appropriate background cutoff should be reasonably large to contain enough background information, but shouldn’t be too large to mistakenly put real cells into the background group. Based on empirical knowledge, we recommend a background cutoff which (1) puts more than 90% barcodes into background, or (2) puts more than 10% UMI counts into background. This guarantees us to have enough information for an unbiased estimation of the background cutoff. Starting from 100, the smallest cutoff satisfying either condition is the recommended cutoff.

```
check_cutoff <- CheckBackgroundCutoff(mbrainSub)
check_cutoff$summary_table
```

```
##   cutoff n_bg_bcs n_bg_counts prop_bg_bcs prop_bg_counts
## 1    100    49714       97013     0.99428     0.09659609
## 2    150    49791      106163     0.99582     0.10570677
## 3    200    49822      111577     0.99644     0.11109750
## 4    250    49846      116966     0.99692     0.11646334
## 5    300    49861      121121     0.99722     0.12060049
## 6    350    49870      124047     0.99740     0.12351391
## 7    400    49873      125155     0.99746     0.12461715
## 8    450    49876      126456     0.99752     0.12591256
## 9    500    49879      127901     0.99758     0.12735135
```

```
check_cutoff$recommended_cutoff
```

```
## [1] 100
```

In this example, the default background cutoff 100 is appropriate as it puts more than 90% barcodes into background as well as more than 10% UMI counts into background. In general, we recommend always checking the background cutoff.

## 3.3 Run **CB2** to distinguish real cells from empty droplets

The main function `CB2FindCell` takes a raw count matrix as input and returns real cells, test statistics, and p-values. Now we apply `CB2FindCell` on `mbrainSub`, controlling FDR at 0.01 level (Default), assuming all barcodes with total counts less than or equal to 100 are background empty droplets (Default), using 2 cores parallel computation (Default: 2). For detailed information, see `?CB2FindCell`.

```
CBOut <- CB2FindCell(mbrainSub, FDR_threshold = 0.01, lower = 100, Ncores = 2)
```

```
## Time difference of 1.135781 mins
```

```
str(assay(CBOut)) # cell matrix
```

```
## Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
##   ..@ i       : int [1:270366] 7 10 33 37 38 62 70 117 125 131 ...
##   ..@ p       : int [1:162] 0 2284 4389 6069 6293 6577 6975 7116 8384 8896 ...
##   ..@ Dim     : int [1:2] 27998 161
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:27998] "Xkr4" "Gm1992" "Gm37381" "Rp1" ...
##   .. ..$ : chr [1:161] "AAACGGGAGCCACGTC-1" "AAACGGGAGCGAGAAA-1" "AAACGGGCAGTTTACG-1" "AAACGGGCATGTCGAT-1" ...
##   ..@ x       : num [1:270366] 2 2 1 1 1 14 1 2 1 1 ...
##   ..@ factors : list()
```

```
str(metadata(CBOut)) # test statistics, p-values, etc
```

```
## List of 4
##  $ ClusterStat:'data.frame': 5 obs. of  4 variables:
##   ..$ corr : num [1:5] 0.6715 0.6773 0.0509 0.38 0.5547
##   ..$ count: num [1:5] 260 315 271 113 4679
##   ..$ pval : num [1:5] 0.277722 0.085914 0.000999 0.004995 0.000999
##   ..$ padj : num [1:5] 0.27772 0.10739 0.0025 0.00833 0.0025
##  $ Cluster    :List of 5
##   ..$ : chr [1:85] "AACACGTAGGCAAAGA-1" "ACAGCCGCAAACGCGA-1" "AACACGTGTATAGGTA-1" "AACTCAGTCTCGGACG-1" ...
##   ..$ : chr [1:41] "AACTTTCAGGCCCGTT-1" "AACTCTTTCGCCGTGA-1" "AACTTTCGTACCGTTA-1" "AACCATGGTTGCCTCT-1" ...
##   ..$ : chr [1:3] "AAGGCAGGTCTTGCGG-1" "ACATCAGCACATTAGC-1" "AAGACCTAGACTGGGT-1"
##   ..$ : chr [1:6] "AATCCAGAGATCTGAA-1" "AACCATGTCTCGCATC-1" "AACACGTTCTCTAGGA-1" "AACTCCCGTGCTTCTC-1" ...
##   ..$ : chr [1:23] "ACCAGTAAGTGCGATG-1" "AAGTCTGAGGACAGCT-1" "ACATACGCAAGCCGTC-1" "AAGGCAGGTCTAGAGG-1" ...
##  $ BarcodeStat:'data.frame': 203 obs. of  4 variables:
##   ..$ logLH: num [1:203] -774 -769 -868 -465 -7681 ...
##   ..$ count: num [1:203] 337 304 312 207 5717 ...
##   ..$ pval : num [1:203] 0.9968 0.8595 0.0591 1 0.0001 ...
##   ..$ padj : num [1:203] 1 1 0.106453 1 0.000237 ...
##  $ background : Named num [1:11121] 8 3 2 0 2 2 0 1 3 1 ...
##   ..- attr(*, "names")= chr [1:11121] "Mrpl15" "Lypla1" "Tcea1" "Rgs20" ...
```

## 3.4 Extract real cell matrix

If readers are not interested in the output testing information, `GetCellMat` can extract the real cell matrix directly from `CB2FindCell` output. It also provides a filtering option to remove broken cells based on the proportion of mitochondrial gene expressions. Now we apply `GetCellMat` on `CBOut`, filtering out cells whose mitochondrial proportions are greater than 0.25 (Default: 1, No filtering).

```
RealCell <- GetCellMat(CBOut, MTfilter = 0.25)
str(RealCell)
```

```
## Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
##   ..@ i       : int [1:269348] 7 10 33 37 38 62 70 117 125 131 ...
##   ..@ p       : int [1:159] 0 2284 4389 6069 6293 6577 6975 7116 8384 8896 ...
##   ..@ Dim     : int [1:2] 27998 158
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:27998] "Xkr4" "Gm1992" "Gm37381" "Rp1" ...
##   .. ..$ : chr [1:158] "AAACGGGAGCCACGTC-1" "AAACGGGAGCGAGAAA-1" "AAACGGGCAGTTTACG-1" "AAACGGGCATGTCGAT-1" ...
##   ..@ x       : num [1:269348] 2 2 1 1 1 14 1 2 1 1 ...
##   ..@ factors : list()
```

## 3.5 Downstream analysis

After `CB2` pre-processing, the real cell matrix is still in matrix format, so it can be directly used in downstream statistical analyses. For example, if we want to use the *Seurat* pipeline, we can easily create a Seurat object using

```
SeuratObj <- Seurat::CreateSeuratObject(counts = RealCell,
                                        project = "mbrain_example")
SeuratObj
```

```
## An object of class Seurat
## 27998 features across 158 samples within 1 assay
## Active assay: RNA (27998 features, 0 variable features)
##  1 layer present: counts
```

## 3.6 All-in-one function

Under default parameters, we can directly use the all-in-one function `QuickCB2` to get the real cell matrix from 10x raw data.

```
RealCell_Quick <- QuickCB2(dir = data.dir, Ncores = 2)
```

```
## Time difference of 1.347854 mins
```

```
str(RealCell_Quick)
```

```
## Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
##   ..@ i       : int [1:270366] 7 10 33 37 38 62 70 117 125 131 ...
##   ..@ p       : int [1:162] 0 2284 4389 6069 6293 6577 6975 7116 8384 8896 ...
##   ..@ Dim     : int [1:2] 27998 161
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:27998] "Xkr4" "Gm1992" "Gm37381" "Rp1" ...
##   .. ..$ : chr [1:161] "AAACGGGAGCCACGTC-1" "AAACGGGAGCGAGAAA-1" "AAACGGGCAGTTTACG-1" "AAACGGGCATGTCGAT-1" ...
##   ..@ x       : num [1:270366] 2 2 1 1 1 14 1 2 1 1 ...
##   ..@ factors : list()
```

Now it’s ready for downstream analysis such as normalization and clustering. Example Seurat tutorial: <https://satijalab.org/seurat/v3.1/pbmc3k_tutorial.html>

# 4 Session Information

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] scCB2_1.20.0                knitr_1.50
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              spatstat.utils_3.2-0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] vctrs_0.6.5                 ROCR_1.0-11
##   [9] spatstat.explore_3.5-3      DelayedMatrixStats_1.32.0
##  [11] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [13] Rhdf5lib_1.32.0             SparseArray_1.10.0
##  [15] rhdf5_2.54.0                sctransform_0.4.2
##  [17] sass_0.4.10                 parallelly_1.45.1
##  [19] KernSmooth_2.23-26          bslib_0.9.0
##  [21] htmlwidgets_1.6.4           ica_1.0-3
##  [23] plyr_1.8.9                  plotly_4.11.0
##  [25] zoo_1.8-14                  cachem_1.1.0
##  [27] igraph_2.2.1                mime_0.13
##  [29] lifecycle_1.0.4             iterators_1.0.14
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] fitdistrplus_1.2-4          future_1.67.0
##  [37] shiny_1.11.1                digest_0.6.37
##  [39] patchwork_1.3.2             tensor_1.5.1
##  [41] Seurat_5.3.1                dqrng_0.4.1
##  [43] RSpectra_0.16-2             irlba_2.3.5.1
##  [45] beachmat_2.26.0             progressr_0.17.0
##  [47] spatstat.sparse_3.1-0       polyclip_1.10-7
##  [49] httr_1.4.7                  abind_1.4-8
##  [51] compiler_4.5.1              doParallel_1.0.17
##  [53] S7_0.2.0                    BiocParallel_1.44.0
##  [55] fastDummies_1.7.5           HDF5Array_1.38.0
##  [57] R.utils_2.13.0              MASS_7.3-65
##  [59] DelayedArray_0.36.0         tools_4.5.1
##  [61] lmtest_0.9-40               otel_0.2.0
##  [63] httpuv_1.6.16               future.apply_1.20.0
##  [65] goftest_1.2-3               R.oo_1.27.1
##  [67] glue_1.8.0                  h5mread_1.2.0
##  [69] nlme_3.1-168                rhdf5filters_1.22.0
##  [71] promises_1.4.0              grid_4.5.1
##  [73] Rtsne_0.17                  reshape2_1.4.4
##  [75] cluster_2.1.8.1             spatstat.data_3.1-9
##  [77] gtable_0.3.6                R.methodsS3_1.8.2
##  [79] tidyr_1.3.1                 data.table_1.17.8
##  [81] sp_2.2-0                    XVector_0.50.0
##  [83] spatstat.geom_3.6-0         RcppAnnoy_0.0.22
##  [85] stringr_1.5.2               ggrepel_0.9.6
##  [87] RANN_2.6.2                  foreach_1.5.2
##  [89] pillar_1.11.1               spam_2.11-1
##  [91] RcppHNSW_0.6.0              limma_3.66.0
##  [93] later_1.4.4                 splines_4.5.1
##  [95] dplyr_1.1.4                 lattice_0.22-7
##  [97] deldir_2.0-4                survival_3.8-3
##  [99] tidyselect_1.2.1            SingleCellExperiment_1.32.0
## [101] locfit_1.5-9.12             miniUI_0.1.2
## [103] scuttle_1.20.0              pbapply_1.7-4
## [105] gridExtra_2.3               bookdown_0.45
## [107] edgeR_4.8.0                 scattermore_1.2
## [109] xfun_0.53                   statmod_1.5.1
## [111] DropletUtils_1.30.0         stringi_1.8.7
## [113] lazyeval_0.2.2              yaml_2.3.10
## [115] evaluate_1.0.5              codetools_0.2-20
## [117] tibble_3.3.0                BiocManager_1.30.26
## [119] cli_3.6.5                   uwot_0.2.3
## [121] reticulate_1.44.0           xtable_1.8-4
## [123] jquerylib_0.1.4             dichromat_2.0-0.1
## [125] Rcpp_1.1.0                  spatstat.random_3.4-2
## [127] globals_0.18.0              png_0.1-8
## [129] spatstat.univar_3.1-4       parallel_4.5.1
## [131] ggplot2_4.0.0               dotCall64_1.2
## [133] sparseMatrixStats_1.22.0    listenv_0.9.1
## [135] viridisLite_0.4.2           scales_1.4.0
## [137] ggridges_0.5.7              purrr_1.1.0
## [139] SeuratObject_5.2.0          rlang_1.1.6
## [141] cowplot_1.2.0
```

# 5 Citation

Ni, Z., Chen, S., Brown, J., & Kendziorski, C. (2020). CB2 improves power of cell detection in droplet-based single-cell RNA sequencing data. Genome Biology, 21(1), 137. <https://doi.org/10.1186/s13059-020-02054-8>