# gDRimport

gDR team

#### 8 December 2025

# Contents

* [1 Overview](#overview)
* [2 Use Cases](#use-cases)
  + [2.1 Test Data](#test-data)
  + [2.2 Load data](#load-data)
* [3 PRISM](#prism)
  + [3.0.1 Processing LEVEL5 PRISM Data](#processing-level5-prism-data)
  + [3.0.2 Processing LEVEL6 PRISM Data](#processing-level6-prism-data)
  + [3.1 Package installation](#package-installation)
* [SessionInfo](#sessioninfo)

# 1 Overview

The `gDRimport` package is a part of the gDR suite. It helps to prepare raw drug response data for downstream processing. It mainly contains helper functions for importing/loading/validating dose response data provided in different file formats.

# 2 Use Cases

## 2.1 Test Data

There are currently four test datasets that can be used to see what’s the expected input data for the gDRimport.

```
# primary test data
td1 <- get_test_data()
summary(td1)
```

```
##        Length         Class          Mode
##             1 gdr_test_data            S4
```

```
td1
```

```
## class: gdr_test_data
## slots: manifest_path result_path template_path ref_m_df ref_r1_r2 ref_r1 ref_t1_t2 ref_t1
```

```
# test data in Tecan format
td2 <- get_test_Tecan_data()
summary(td2)
```

```
##          Length Class  Mode
## m_file   1      -none- character
## r_files  1      -none- character
## t_files  1      -none- character
## ref_m_df 1      -none- character
## ref_r_df 1      -none- character
## ref_t_df 1      -none- character
```

```
# test data in D300 format
td3 <- get_test_D300_data()
summary(td3)
```

```
##        Length Class  Mode
## f_96w  6      -none- list
## f_384w 6      -none- list
```

```
# test data obtained from EnVision
td4 <- get_test_EnVision_data()
summary(td4)
```

```
##            Length Class  Mode
## m_file      1     -none- character
## r_files    28     -none- character
## t_files     2     -none- character
## ref_l_path  1     -none- character
```

## 2.2 Load data

The `load_data` is the key function. It wraps `load_manifest`, `load_templates` and `load_results` functions and supports different file formats.

```
ml <- load_manifest(manifest_path(td1))
summary(ml)
```

```
##         Length Class      Mode
## data     4     data.table list
## headers 27     -none-     list
```

```
t_df <- load_templates(template_path(td1))
summary(t_df)
```

```
##    WellRow           WellColumn          Gnumber          Concentration
##  Length:768         Length:768         Length:768         Length:768
##  Class :character   Class :character   Class :character   Class :character
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character
##   Gnumber_2         Concentration_2      Template
##  Length:768         Length:768         Length:768
##  Class :character   Class :character   Class :character
##  Mode  :character   Mode  :character   Mode  :character
```

```
r_df <- suppressMessages(load_results(result_path(td1)))
summary(r_df)
```

```
##    Barcode            WellRow            WellColumn     ReadoutValue
##  Length:4587        Length:4587        Min.   : 1.00   Min.   :  12627
##  Class :character   Class :character   1st Qu.: 6.50   1st Qu.:  67905
##  Mode  :character   Mode  :character   Median :12.00   Median : 140865
##                                        Mean   :12.49   Mean   : 263996
##                                        3rd Qu.:18.00   3rd Qu.: 324707
##                                        Max.   :24.00   Max.   :2423054
##  BackgroundValue
##  Min.   :332.0
##  1st Qu.:351.0
##  Median :374.0
##  Mean   :453.2
##  3rd Qu.:570.0
##  Max.   :704.0
```

```
l_tbl <-
  suppressMessages(
    load_data(manifest_path(td1), template_path(td1), result_path(td1)))
summary(l_tbl)
```

```
##            Length Class      Mode
## manifest   4      data.table list
## treatments 7      data.table list
## data       5      data.table list
```

# 3 PRISM

PRISM, the Multiplexed cancer cell line screening platform, facilitates rapid screening of a broad spectrum of drugs across more than 900 human cancer cell line models, employing a high-throughput, multiplexed approach. Publicly available PRISM data can be downloaded from the DepMap website ([DepMap](https://depmap.org/portal/download/all/)).

The `gDRimport` package provides support for processing PRISM data at two levels: LEVEL5 and LEVEL6.

* LEVEL5 Data: This format encapsulates all information about drugs, cell lines, and viability within a single file. To process LEVEL5 PRISM data, you can use the `convert_LEVEL5_prism_to_gDR_input()` function. This function not only transforms and cleans the data but also executes the gDR pipeline for further analysis.
* LEVEL6 Data: In LEVEL6, PRISM data is distributed across three separate files:

prism\_data: containing collapsed log fold change data for viability assays.
cell\_line\_data: providing information about cell lines.
treatment\_data: containing treatment data.

Processing LEVEL6 PRISM data can be accomplished using the `convert_LEVEL6_prism_to_gDR_input()` function, which requires paths to these three files as input arguments.

### 3.0.1 Processing LEVEL5 PRISM Data

To process LEVEL5 PRISM data, you can use the following function:

```
convert_LEVEL5_prism_to_gDR_input("path_to_file")
```

Replace “path\_to\_file” with the actual path to your LEVEL5 PRISM data file. This function will handle the transformation, cleaning, and execution of the gDR pipeline automatically.

### 3.0.2 Processing LEVEL6 PRISM Data

To process LEVEL6 PRISM data, you can use the following function:

```
convert_LEVEL6_prism_to_gDR_input("prism_data_path", "cell_line_data_path", "treatment_data_path")
```

Replace “prism\_data\_path”, “cell\_line\_data\_path”, and “treatment\_data\_path” with the respective paths to your LEVEL6 PRISM data files.

## 3.1 Package installation

The function `installAllDeps` assists in installing package dependencies.

# SessionInfo

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
##  [1] BiocStyle_2.38.0            MultiAssayExperiment_1.36.1
##  [3] gDRimport_1.8.1             PharmacoGx_3.14.0
##  [5] CoreGx_2.14.0               SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.1
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocGenerics_0.56.0
## [15] generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9          formatR_1.14          readxl_1.4.5
##   [4] testthat_3.3.1        rlang_1.1.6           magrittr_2.0.4
##   [7] shinydashboard_0.7.3  otel_0.2.0            compiler_4.5.2
##  [10] vctrs_0.6.5           reshape2_1.4.5        relations_0.6-15
##  [13] stringr_1.6.0         pkgconfig_2.0.3       crayon_1.5.3
##  [16] fastmap_1.2.0         backports_1.5.0       XVector_0.50.0
##  [19] caTools_1.18.3        promises_1.5.0        rmarkdown_2.30
##  [22] coop_0.6-3            xfun_0.54             cachem_1.1.0
##  [25] jsonlite_2.0.0        SnowballC_0.7.1       later_1.4.4
##  [28] DelayedArray_0.36.0   BiocParallel_1.44.0   parallel_4.5.2
##  [31] sets_1.0-25           cluster_2.1.8.1       R6_2.6.1
##  [34] bslib_0.9.0           stringi_1.8.7         RColorBrewer_1.1-3
##  [37] qs_0.27.3             limma_3.66.0          boot_1.3-32
##  [40] cellranger_1.1.0      brio_1.1.5            jquerylib_0.1.4
##  [43] bookdown_0.46         assertthat_0.2.1      Rcpp_1.1.0
##  [46] knitr_1.50            downloader_0.4.1      BiocBaseUtils_1.12.0
##  [49] httpuv_1.6.16         Matrix_1.7-4          igraph_2.2.1
##  [52] tidyselect_1.2.1      dichromat_2.0-0.1     abind_1.4-8
##  [55] yaml_2.3.11           stringfish_0.17.0     gplots_3.3.0
##  [58] codetools_0.2-20      lattice_0.22-7        tibble_3.3.0
##  [61] plyr_1.8.9            withr_3.0.2           shiny_1.12.0
##  [64] BumpyMatrix_1.18.0    S7_0.2.1              evaluate_1.0.5
##  [67] lambda.r_1.2.4        futile.logger_1.4.3   RcppParallel_5.1.11-1
##  [70] bench_1.1.4           BiocManager_1.30.27   pillar_1.11.1
##  [73] lsa_0.73.3            KernSmooth_2.23-26    checkmate_2.3.3
##  [76] DT_0.34.0             shinyjs_2.1.0         piano_2.26.0
##  [79] ggplot2_4.0.1         scales_1.4.0          RApiSerialize_0.1.4
##  [82] gtools_3.9.5          xtable_1.8-4          marray_1.88.0
##  [85] glue_1.8.0            slam_0.1-55           tools_4.5.2
##  [88] data.table_1.17.8     gDRutils_1.8.0        fgsea_1.36.0
##  [91] visNetwork_2.1.4      fastmatch_1.1-6       cowplot_1.2.0
##  [94] grid_4.5.2            cli_3.6.5             futile.options_1.0.1
##  [97] S4Arrays_1.10.1       rematch_2.0.0         dplyr_1.1.4
## [100] gtable_0.3.6          sass_0.4.10           digest_0.6.39
## [103] SparseArray_1.10.6    htmlwidgets_1.6.4     farver_2.1.2
## [106] htmltools_0.5.9       lifecycle_1.0.4       statmod_1.5.1
## [109] mime_0.13
```