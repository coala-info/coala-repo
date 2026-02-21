Code

* Show All Code
* Hide All Code

# Applying CTSV to Spatial Transcriptomics Data

Jinge Yu1\* and Xiangyu Luo1\*\*

1Institute of Statistics and Big Data, Renmin University of China

\*yjgruc@ruc.edu.cn
\*\*xiangyuluo@ruc.edu.cn

#### 29 October 2025

#### Package

CTSV 1.12.0

# 1 Introduction

Cell-Type-specific Spatially Variable gene detection, or CTSV, is an R package for identifying cell-type-specific spatially variable genes in bulk sptial transcriptomics data. In this Vignette, we will introduce a standard workflow of CTSV. By utilizing single-cell RNA sequencing data as reference, we can first use existing deconvolution methods to obtain cell type proportions for each spot. Subsequently, we take the cell type proportions, location coordinates and spatial expression data as input to CTSV.

# 2 Usage guide

## 2.1 Install `CTSV`

*[CTSV](https://bioconductor.org/packages/3.22/CTSV)* is an `R` package available in the [Bioconductor](http://bioconductor.org) repository. It requires installing the `R` open source statistical programming language, which can be accessed on any operating system from [CRAN](https://cran.r-project.org/). Next, you can install *[CTSV](https://bioconductor.org/packages/3.22/CTSV)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("CTSV", version = "devel")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

If there are any issues with the installation procedure or package features, the best place would be to commit an issue at the GitHub [repository](https://github.com/jingeyu/CTSV).

## 2.2 Load example data

In order to run RCTD, the first step is to get cell-type proportions. There are some deconvolution methods such as RCTD, SPOTlight, SpatialDWLS and CARD. We provide an example data including the observed raw count bulk ST data, the location coordinate matrix, the cell-type proportion matrix and the true SV gene patterns.

```
suppressPackageStartupMessages(library(CTSV))
suppressPackageStartupMessages(library(SpatialExperiment))
```

```
data("CTSVexample_data", package="CTSV")
spe <- CTSVexample_data[[1]]
W <- CTSVexample_data[[2]]
gamma_true <- CTSVexample_data[[3]]
Y <- assay(spe)
# dimension of bulk ST data
dim(Y)
#> [1]  20 100
# dimension of cell-type proportion matrix:
dim(W)
#> [1] 100   2
# SV genes in each cell type:
colnames(Y)[which(gamma_true[,1] == 1)]
#> [1] "spot11" "spot12" "spot13"
colnames(Y)[which(gamma_true[,2] == 1)]
#> [1] "spot14" "spot15" "spot16"
# Number of SV genes at the aggregated level:
sum(rowSums(gamma_true)>0)
#> [1] 6
```

## 2.3 Running CTSV

We are now ready to run CTSV on the bulk ST data using `ctsv` function.

* `spe` is a SpatialExperiment class object.
* `W` is the cell-type-specific matrix with \(n\times K\) dimensions, where \(K\) is the number of cell types.
* `num_core:` for parallel processing, the number of cores used. If set to 1, parallel processing is not used. The system will additionally be checked for number of available cores. Note, that we recommend setting `num_core` to at least `4` or `8` to improve efficiency.
* `BPPARAM:` Optional additional argument for parallelization. The default is NULL, in which case `num_core` will be used.

```
result <- CTSV(spe,W,num_core = 8)
#> Warning:   'IS_BIOC_BUILD_MACHINE' environment variable detected, setting
#>   BiocParallel workers to 4 (was 8)
```

## 2.4 CTSV results

The results of CTSV are located in a list.

* `pval`, combined p-values, a \(G\times 2K\) matrix.
* `qval` stores adjusted q-values of the combined p-values, it is a \(G \times 2K\) matrix.

```
# View on q-value matrix
head(result$qval)
#>             [,1]      [,2]      [,3]      [,4]
#> gene1 0.19608207 0.0551131 0.4798779 0.1473743
#> gene2 0.48137993 0.1340525 0.5496449 0.1111611
#> gene3 0.51617639 0.4432447 0.5396361 0.4848865
#> gene4 0.32941853 0.4644303 0.3294185 0.5622570
#> gene5 0.06301154 0.4137664 0.5202110 0.1050798
#> gene6 0.13405253 0.5223834 0.3294185 0.3078814
```

Then we want to extra SV genes with an FDR level at 0.05 using `svGene` function. We use the q-value matrix `qval` returned by the `CTSV` function and a threshold of 0.05 as input. The output of the `svGene` is a list containing two elements, the first of which is a \(G\times 2K\) 0-1 matrix indicating SV genes in each cell type and axis, denoted as `SV`. The second element is a list with names of SV genes in each cell type, denoted as `SVGene`.

```
re <- svGene(result$qval,0.05)
# SV genes in each cell type:
re$SVGene
#> [[1]]
#> [1] "gene8"  "gene11" "gene12" "gene13"
#>
#> [[2]]
#> [1] "gene7"  "gene14" "gene15" "gene16" "gene17" "gene19"
```

# 3 Session information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] CTSV_1.12.0                 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
#>  [4] stringi_1.8.7       digest_0.6.37       magrittr_2.0.4
#>  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
#> [10] bookdown_0.45       fastmap_1.2.0       Matrix_1.7-4
#> [13] plyr_1.8.9          jsonlite_2.0.0      BiocManager_1.30.26
#> [16] scales_1.4.0        codetools_0.2-20    jquerylib_0.1.4
#> [19] abind_1.4-8         cli_3.6.5           rlang_1.1.6
#> [22] XVector_0.50.0      splines_4.5.1       DelayedArray_0.36.0
#> [25] cachem_1.1.0        yaml_2.3.10         S4Arrays_1.10.0
#> [28] tools_4.5.1         parallel_4.5.1      reshape2_1.4.4
#> [31] BiocParallel_1.44.0 dplyr_1.1.4         ggplot2_4.0.0
#> [34] vctrs_0.6.5         R6_2.6.1            magick_2.9.0
#> [37] lifecycle_1.0.4     stringr_1.5.2       MASS_7.3-65
#> [40] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [43] gtable_0.3.6        glue_1.8.0          Rcpp_1.1.0
#> [46] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
#> [49] qvalue_2.42.0       knitr_1.50          dichromat_2.0-0.1
#> [52] rjson_0.2.23        farver_2.1.2        htmltools_0.5.8.1
#> [55] rmarkdown_2.30      pscl_1.5.9          compiler_4.5.1
#> [58] S7_0.2.0
```