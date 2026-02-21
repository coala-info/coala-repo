# PBMCs profiled with the Chromium Single Cell Multiome ATAC + Gene Expression from 10x

Marcel Ramos Pérez, Al J Abadi, Ricard Argelaguet and Levi Waldron

#### 4 November 2025

#### Package

SingleCellMultiModal 1.22.0

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SingleCellMultiModal")
```

## 1.1 Load

```
library(SingleCellMultiModal)
library(MultiAssayExperiment)
library(scran)
library(scater)
```

# 2 Description

This data set consists of about 10K Peripheral Blood Mononuclear Cells (PBMCs)
derived from a single healthy donor. It is available
[from the 10x Genomics website](https://support.10xgenomics.com/single-cell-multiome-atac-gex/datasets).

Provided are the RNA expression counts quantified at the gene level and the
chromatin accessibility levels quantified at the peak level. Here we provide
the default peaks called by the CellRanger software. If you want to explore
other peak definitions or chromatin accessibility quantifications (at the
promoter level, etc.), you have download the `fragments.tsv.gz` file from the
10x Genomics website.

# 3 Downloading datasets

The user can see the available dataset by using the default options

```
mae <- scMultiome("pbmc_10x", modes = "*", dry.run = FALSE, format = "MTX")
```

```
## Working on: pbmc_atac_se.rds
```

```
## Working on: pbmc_atac.mtx.gz
```

```
## Working on: pbmc_rna_se.rds
```

```
## Working on: pbmc_rna.mtx.gz
```

```
## Working on: pbmc_atac,
##  pbmc_rna
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## Working on: pbmc_atac,
##  pbmc_rna
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## Working on: pbmc_colData
```

```
## Working on: pbmc_sampleMap
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

# 4 Exploring the data structure

There are two assays: `rna` and `atac`, stored as
[SingleCellExperiment](http://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html)
objects

```
mae
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] atac: SingleCellExperiment with 108344 rows and 10032 columns
##  [2] rna: SingleCellExperiment with 36549 rows and 10032 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

where the cells are the same in both assays:

```
upsetSamples(mae)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 4.1 Cell metadata

Columns:

* **nCount\_RNA**: number of read counts
* **nFeature\_RNA**: number of genes with at least one read count
* **nCount\_ATAC**: number of ATAC read counts
* **nFeature\_ATAC**: number of ATAC peaks with at least one read count
* **celltype**: The cell types have been annotated by the 10x Genomics R&D team using gene markers. They provide a rough characterisation of the cell type diversity, but keep in mind that they are not ground truth labels.
* **broad\_celltype**: `Lymphoid` or `Myeloid` origin

The cells have not been QC-ed, choosing a minimum number of genes/peaks per
cell depends is left to you! In addition, there are further quality control
criteria that you may want to apply, including mitochondrial coverage, fraction
of reads overlapping ENCODE Blacklisted regions, Transcription start site
enrichment, etc. See suggestions below for software that can perform a
semi-automated quality control pipeline

```
head(colData(mae))
```

```
## DataFrame with 6 rows and 6 columns
##                  nCount_RNA nFeature_RNA nCount_ATAC nFeature_ATAC
##                   <integer>    <integer>   <integer>     <integer>
## AAACAGCCAAGGAATC       8380         3308       55582         13878
## AAACAGCCAATCCCTT       3771         1896       20495          7253
## AAACAGCCAATGCGCT       6876         2904       16674          6528
## AAACAGCCAGTAGGTG       7614         3061       39454         11633
## AAACAGCCAGTTTACG       3633         1691       20523          7245
## AAACAGCCATCCAGGT       7782         3028       22412          8602
##                                celltype broad_celltype
##                             <character>    <character>
## AAACAGCCAAGGAATC      naive CD4 T cells       Lymphoid
## AAACAGCCAATCCCTT     memory CD4 T cells       Lymphoid
## AAACAGCCAATGCGCT      naive CD4 T cells       Lymphoid
## AAACAGCCAGTAGGTG      naive CD4 T cells       Lymphoid
## AAACAGCCAGTTTACG     memory CD4 T cells       Lymphoid
## AAACAGCCATCCAGGT non-classical monocy..        Myeloid
```

## 4.2 RNA expression

The RNA expression consists of 36,549 genes and 10,032 cells, stored using
the `dgCMatrix` sparse matrix format

```
dim(experiments(mae)[["rna"]])
```

```
## [1] 36549 10032
```

```
names(experiments(mae))
```

```
## [1] "atac" "rna"
```

Let’s do some standard dimensionality reduction plot:

```
sce.rna <- experiments(mae)[["rna"]]

# Normalisation
sce.rna <- logNormCounts(sce.rna)

# Feature selection
decomp <- modelGeneVar(sce.rna)
hvgs <- rownames(decomp)[decomp$mean>0.01 & decomp$p.value <= 0.05]
sce.rna <- sce.rna[hvgs,]

# PCA
sce.rna <- runPCA(sce.rna, ncomponents = 25)

# UMAP
set.seed(42)
sce.rna <- runUMAP(sce.rna, dimred="PCA", n_neighbors = 25, min_dist = 0.3)
plotUMAP(sce.rna, colour_by="celltype", point_size=0.5, point_alpha=1)
```

![](data:image/png;base64...)

## 4.3 Chromatin Accessibility

The ATAC expression consists of 108,344 peaks and 10,032 cells:

```
dim(experiments(mae)[["atac"]])
```

```
## [1] 108344  10032
```

Let’s do some standard dimensionality reduction plot. Note that scATAC-seq data is sparser than scRNA-seq, almost binary. The log normalisation + PCA approach that `scater` implements for scRNA-seq is not a good strategy for scATAC-seq data. Topic modelling or TFIDF+SVD are a better strategy. Please see the package recommendations below.

```
sce.atac <- experiments(mae)[["atac"]]

# Normalisation
sce.atac <- logNormCounts(sce.atac)

# Feature selection
decomp <- modelGeneVar(sce.atac)
hvgs <- rownames(decomp)[decomp$mean>0.25]
sce.atac <- sce.atac[hvgs,]

# PCA
sce.atac <- runPCA(sce.atac, ncomponents = 25)

# UMAP
set.seed(42)
sce.atac <- runUMAP(sce.atac, dimred="PCA", n_neighbors = 25, min_dist = 0.3)
plotUMAP(sce.atac, colour_by="celltype", point_size=0.5, point_alpha=1)
```

![](data:image/png;base64...)

# 5 Suggested software for the downstream analysis

These are my personal recommendations of R-based analysis software:

* **RNA expression**: [scater](http://bioconductor.org/packages/release/bioc/html/scater.html), [scran](https://bioconductor.org/packages/release/bioc/html/scran.html)
* **ATAC accessibility**: [archR](https://www.archrproject.com/), [snapATAC](https://github.com/r3fang/SnapATAC), [cisTopic](https://github.com/aertslab/cisTopic), [Signac](https://satijalab.org/signac), [chromVar](https://bioconductor.org/packages/release/bioc/html/chromVAR.html), [Cicero](https://www.bioconductor.org/packages/release/bioc/html/cicero.html)
* **Integrative analysis**: [MOFA+](https://biofam.github.io/MOFA2), [Seurat](https://satijalab.org/seurat). Note that both methods have released vignettes in their website where they analysed this same data set.

# 6 sessionInfo

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
##  [1] scater_1.38.0               ggplot2_4.0.0
##  [3] scran_1.38.0                scuttle_1.20.0
##  [5] rhdf5_2.54.0                RaggedExperiment_1.34.0
##  [7] SingleCellExperiment_1.32.0 SingleCellMultiModal_1.22.0
##  [9] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                gridExtra_2.3            httr2_1.2.1
##   [4] formatR_1.14             rlang_1.1.6              magrittr_2.0.4
##   [7] RcppAnnoy_0.0.22         compiler_4.5.1           RSQLite_2.4.3
##  [10] png_0.1-8                vctrs_0.6.5              pkgconfig_2.0.3
##  [13] SpatialExperiment_1.20.0 crayon_1.5.3             fastmap_1.2.0
##  [16] dbplyr_2.5.1             magick_2.9.0             XVector_0.50.0
##  [19] labeling_0.4.3           rmarkdown_2.30           ggbeeswarm_0.7.2
##  [22] UpSetR_1.4.0             tinytex_0.57             purrr_1.1.0
##  [25] bit_4.6.0                xfun_0.54                bluster_1.20.0
##  [28] cachem_1.1.0             beachmat_2.26.0          jsonlite_2.0.0
##  [31] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
##  [34] Rhdf5lib_1.32.0          BiocParallel_1.44.0      irlba_2.3.5.1
##  [37] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
##  [40] RColorBrewer_1.1-3       bslib_0.9.0              limma_3.66.0
##  [43] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
##  [46] knitr_1.50               BiocBaseUtils_1.12.0     Matrix_1.7-4
##  [49] igraph_2.2.1             tidyselect_1.2.1         viridis_0.6.5
##  [52] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
##  [55] codetools_0.2-20         curl_7.0.0               plyr_1.8.9
##  [58] lattice_0.22-7           tibble_3.3.0             S7_0.2.0
##  [61] withr_3.0.2              KEGGREST_1.50.0          evaluate_1.0.5
##  [64] BiocFileCache_3.0.0      ExperimentHub_3.0.0      Biostrings_2.78.0
##  [67] pillar_1.11.1            BiocManager_1.30.26      filelock_1.0.3
##  [70] BiocVersion_3.22.0       scales_1.4.0             glue_1.8.0
##  [73] metapod_1.18.0           tools_4.5.1              AnnotationHub_4.0.0
##  [76] BiocNeighbors_2.4.0      ScaledMatrix_1.18.0      locfit_1.5-9.12
##  [79] cowplot_1.2.0            grid_4.5.1               AnnotationDbi_1.72.0
##  [82] edgeR_4.8.0              beeswarm_0.4.0           BiocSingular_1.26.0
##  [85] HDF5Array_1.38.0         vipor_0.4.7              cli_3.6.5
##  [88] rsvd_1.0.5               rappdirs_0.3.3           viridisLite_0.4.2
##  [91] S4Arrays_1.10.0          dplyr_1.1.4              uwot_0.2.3
##  [94] gtable_0.3.6             sass_0.4.10              digest_0.6.37
##  [97] ggrepel_0.9.6            SparseArray_1.10.1       dqrng_0.4.1
## [100] farver_2.1.2             rjson_0.2.23             memoise_2.0.1
## [103] htmltools_0.5.8.1        lifecycle_1.0.4          h5mread_1.2.0
## [106] httr_1.4.7               statmod_1.5.1            bit64_4.6.0-1
```