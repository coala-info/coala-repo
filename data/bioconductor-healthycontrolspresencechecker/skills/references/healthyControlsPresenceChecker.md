# healthyControlsPresenceChecker vignette

Davide Chicco

#### 2025-11-06

#### Abstract

healthyControlsPresenceChecker allows users to verify if a specific GEO dataset contains data of healthy controls amongside data of patients.

#### Package

healthyControlsPresenceChecker 1.14.0

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Description](#description)
* [0.3 Installation via Bioconductor](#installation-via-bioconductor)
* [0.4 Usage](#usage)
* [0.5 Contacts](#contacts)

```
library(healthyControlsPresenceChecker)
#> Setting options('download.file.method.GEOquery'='auto')
#> Setting options('GEOquery.inmemory.gpl'=FALSE)
```

## 0.1 Introduction

Bioinformatics projects regarding the analysis of data of patients with cancer or other diseases often require the comparison between the results obtained on patients’ data and results obtained on healthy controls’ data. This step, although crucial, often cannot be performed if the dataset contains no healthy control data.
Looking for datasets containing both these kinds of the data can be tedious, and checking a specific dataset can be time-consuming, too.
Here we propose a software package that can immedaitely inform the user if data of healthy controls are present or not in a specific dataset.

## 0.2 Description

healthyControlsPresenceChecker allows users to verify if a specific GEO dataset contains data of healthy controls amongside data of patients.

## 0.3 Installation via Bioconductor

Once this package will be available on Bioconductor, it will be possibile to install it through the following commands.

Start R (version “4.1”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))`
        `install.packages("BiocManager")

BiocManager::install("healthyControlsPresenceChecker")
```

It will be possible to load the package with the following command:

```
library("healthyControlsPresenceChecker")
```

## 0.4 Usage

The usage of healthyControlsPresenceChecker is very easy. The main function `healthyControlsCheck()` reads two input arguments: the GEO accession code of the dataset for which the user wants to verify the presence of the healthy controls, and a verbose flag.
For example, if the user wants to know if the [GSE47407](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE47407) dataset contains data of healthy controls, she/he can type on a terminal shell within the R environment:

```
outcomeGSE47407 <- healthyControlsCheck("GSE47407", TRUE)
#> Processed URL: https://ftp.ncbi.nlm.nih.gov/geo/series/GSE47nnn/GSE47407
#> Found 1 file(s)
#> GSE47407_series_matrix.txt.gz
#> === === === === === GSE47407 === === === === ===
#> :: The keyword "healthy" was NOT found among the annotations of this dataset (GSE47407)
#> :: The keyword "control" was NOT found among the annotations of this dataset (GSE47407)
#> === === === === === === === === === === === ===
#>
#> healthyControlsCheck() call output: were healthy controls found in the GSE47407 dataset? FALSE
```

The function will print all the intermediate messages, and eventually the `outcomeGSE47407` variable will be true if healthy controls were found, or false otherwise.

## 0.5 Contacts

This software was developed by [Davide Chicco](https://www.DavideChicco.it), who can be contacted via email at davidechicco(AT)davidechicco.it

Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] healthyControlsPresenceChecker_1.14.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3              tidyr_1.3.1
#>  [3] sass_0.4.10                 generics_0.1.4
#>  [5] xml2_1.4.1                  SparseArray_1.10.1
#>  [7] lattice_0.22-7              hms_1.1.4
#>  [9] digest_0.6.37               magrittr_2.0.4
#> [11] evaluate_1.0.5              grid_4.5.1
#> [13] bookdown_0.45               fastmap_1.2.0
#> [15] R.oo_1.27.1                 jsonlite_2.0.0
#> [17] Matrix_1.7-4                R.utils_2.13.0
#> [19] limma_3.66.0                formatR_1.14
#> [21] BiocManager_1.30.26         purrr_1.2.0
#> [23] XML_3.99-0.19               httr2_1.2.1
#> [25] jquerylib_0.1.4             abind_1.4-8
#> [27] cli_3.6.5                   rlang_1.1.6
#> [29] XVector_0.50.0              R.methodsS3_1.8.2
#> [31] Biobase_2.70.0              withr_3.0.2
#> [33] cachem_1.1.0                DelayedArray_0.36.0
#> [35] yaml_2.3.10                 S4Arrays_1.10.0
#> [37] tools_4.5.1                 tzdb_0.5.0
#> [39] dplyr_1.1.4                 SummarizedExperiment_1.40.0
#> [41] BiocGenerics_0.56.0         curl_7.0.0
#> [43] vctrs_0.6.5                 R6_2.6.1
#> [45] matrixStats_1.5.0           stats4_4.5.1
#> [47] lifecycle_1.0.4             Seqinfo_1.0.0
#> [49] S4Vectors_0.48.0            IRanges_2.44.0
#> [51] pkgconfig_2.0.3             bslib_0.9.0
#> [53] pillar_1.11.1               rentrez_1.2.4
#> [55] data.table_1.17.8           glue_1.8.0
#> [57] statmod_1.5.1               xfun_0.54
#> [59] tibble_3.3.0                GenomicRanges_1.62.0
#> [61] tidyselect_1.2.1            MatrixGenerics_1.22.0
#> [63] knitr_1.50                  htmltools_0.5.8.1
#> [65] rmarkdown_2.30              GEOquery_2.78.0
#> [67] readr_2.1.5                 compiler_4.5.1
#> [69] geneExpressionFromGEO_1.2
```