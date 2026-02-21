# Converting PharmacoSet Drug Response Data into gDR object

#### Jermiah Joseph

jermiah.joseph@uhn.ca

#### Bartosz Czech

bartosz.w.czech@gmail.com

```
library(PharmacoGx)
library(gDRimport)
```

# Overview

The `gDRimport` package is a part of the gDR suite. It helps to prepare raw drug response data for downstream processing. It mainly contains helper functions for importing/loading/validating dose response data provided from different scanner sources. In collaboration with the BHKLab, `gDRimport` also provides functions that can convert a `PharmacoGx::PharamcoSet` object into a gDR object. With this functionality, users familiar with the gDR suite of packages and methods can utilize the publically available, curated datasets from the PharmacoGx database. The main step in this process is to extract the drug dose-response data from the PharmacoSets and transform them into a `data.table` that can be used as input for the `gDRcore::runDrugResponseProcessingPipeline`.

# Loading a PharmacoSet (PSet)

Whereas a user might already have a pharmacoset loaded in their R session, if they wish to obtain a different pharmacoset or use the same script in the future we provide a helper function to do so. It helps to have a user directory in which to store all pharmacosets, and by passing this directory into the function as a parameter, the function will also check to see if the PSet exists in the user-defined directory. This is to ensure that the PSet is not being re-downloaded if it already has.

```
pset <- getPSet("Tavor_2020")
pset
```

# Converting PharmacoSet to data.table for gDR pipeline

`PharamcoSets` hold data pertaining to the cell lines (@sample slot), drugs (@treatment slot), and dose response experiments (@treatmentResponse slot). The dose response data is stored in a `treatmentResponseExperiment` object and the function `gDRimport::convert_pset_to_df` extracts this information to build a `data.table` that can be used as input to the gDR pipeline.

```
# Store treatment response data in df_
dt <- convert_pset_to_df(pharmacoset = pset)
str(dt)
#> Classes 'data.table' and 'data.frame':   34516 obs. of  7 variables:
#>  $ Barcode              : chr  "PCM-0103090_1_130695_2018-08-28" "PCM-0103090_1_130695_2018-08-28" "PCM-0103090_1_130695_2018-08-28" "PCM-0103090_1_130695_2018-08-28" ...
#>  $ ReadoutValue         : num  75.7 63.1 75.9 87.2 78.8 ...
#>  $ Concentration        : num  0.0021 0.0052 0.01 0.0299 0.0798 ...
#>  $ Clid                 : chr  "130695" "130695" "130695" "130695" ...
#>  $ DrugName             : chr  "Ivosidenib" "Ivosidenib" "Ivosidenib" "Ivosidenib" ...
#>  $ Duration             : num  48 48 48 48 48 48 48 48 48 48 ...
#>  $ ReferenceDivisionTime: logi  NA NA NA NA NA NA ...
#>  - attr(*, ".internal.selfref")=<externalptr>
```

# Subsetting to extract relevant information

Most canonical `PharmacoSets` have data pertaining to many cell lines and their response to many drugs (drug-combination data is available in some but its conversion to gDR is not currently supported). As such, in the interest of time and resources, it may be useful to subset the data before providing it as input for the gDR pipeline.

```
# example subset using only 1 cell line
subset_cl <- dt$Clid[1]
x <- dt[Clid == subset_cl]
x
#>                              Barcode ReadoutValue Concentration   Clid
#>                               <char>        <num>         <num> <char>
#>   1: PCM-0103090_1_130695_2018-08-28       75.733        0.0021 130695
#>   2: PCM-0103090_1_130695_2018-08-28       63.094        0.0052 130695
#>   3: PCM-0103090_1_130695_2018-08-28       75.935        0.0100 130695
#>   4: PCM-0103090_1_130695_2018-08-28       87.159        0.0299 130695
#>   5: PCM-0103090_1_130695_2018-08-28       78.766        0.0798 130695
#>  ---
#> 589: PCM-0064526_5_130695_2018-08-28       71.707        1.4960 130695
#> 590: PCM-0064526_5_130695_2018-08-28       60.488        3.9900 130695
#> 591: PCM-0064526_5_130695_2018-08-28       25.366        9.9750 130695
#> 592: PCM-0064526_5_130695_2018-08-28        5.976       24.9400 130695
#> 593: PCM-0064526_5_130695_2018-08-28      100.000        0.0000 130695
#>         DrugName Duration ReferenceDivisionTime
#>           <char>    <num>                <lgcl>
#>   1:  Ivosidenib       48                    NA
#>   2:  Ivosidenib       48                    NA
#>   3:  Ivosidenib       48                    NA
#>   4:  Ivosidenib       48                    NA
#>   5:  Ivosidenib       48                    NA
#>  ---
#> 589: Azacitidine       48                    NA
#> 590: Azacitidine       48                    NA
#> 591: Azacitidine       48                    NA
#> 592: Azacitidine       48                    NA
#> 593:     vehicle       48                    NA
```

# Running drug response pipeline with data

The subsetted data can now be used as input for the `gDRcore::runDrugResponseProcessingPipeline()`. The output of this function is a `MultiAssayExperiment` object which can be accessed with `gDRutils::convert_se_assay_to_dt()`

```
# RUN DRUG RESPONSE PROCESSING PIPELINE
se <- gDRcore::runDrugResponseProcessingPipeline(x)
se
```

```
# Convert Summarized Experiments to data.table
# Available SEs : "RawTreatred", "Controls", "Normalized", "Averaged", "Metrics"

str(gDRutils::convert_se_assay_to_dt(se[[1]], "Averaged"))
str(gDRutils::convert_se_assay_to_dt(se[[1]], "Metrics"))
```

# SessionInfo

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] MultiAssayExperiment_1.36.1 gDRimport_1.8.1
#>  [3] PharmacoGx_3.14.0           CoreGx_2.14.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9          testthat_3.3.1        rlang_1.1.6
#>   [4] magrittr_2.0.4        shinydashboard_0.7.3  otel_0.2.0
#>   [7] compiler_4.5.2        vctrs_0.6.5           reshape2_1.4.5
#>  [10] relations_0.6-15      stringr_1.6.0         pkgconfig_2.0.3
#>  [13] crayon_1.5.3          fastmap_1.2.0         backports_1.5.0
#>  [16] XVector_0.50.0        caTools_1.18.3        promises_1.5.0
#>  [19] rmarkdown_2.30        coop_0.6-3            xfun_0.54
#>  [22] cachem_1.1.0          jsonlite_2.0.0        SnowballC_0.7.1
#>  [25] later_1.4.4           DelayedArray_0.36.0   BiocParallel_1.44.0
#>  [28] parallel_4.5.2        sets_1.0-25           cluster_2.1.8.1
#>  [31] R6_2.6.1              bslib_0.9.0           stringi_1.8.7
#>  [34] RColorBrewer_1.1-3    qs_0.27.3             limma_3.66.0
#>  [37] boot_1.3-32           brio_1.1.5            jquerylib_0.1.4
#>  [40] assertthat_0.2.1      Rcpp_1.1.0            knitr_1.50
#>  [43] downloader_0.4.1      BiocBaseUtils_1.12.0  httpuv_1.6.16
#>  [46] Matrix_1.7-4          igraph_2.2.1          tidyselect_1.2.1
#>  [49] dichromat_2.0-0.1     abind_1.4-8           yaml_2.3.11
#>  [52] stringfish_0.17.0     gplots_3.3.0          codetools_0.2-20
#>  [55] lattice_0.22-7        tibble_3.3.0          plyr_1.8.9
#>  [58] withr_3.0.2           shiny_1.12.0          BumpyMatrix_1.18.0
#>  [61] S7_0.2.1              evaluate_1.0.5        RcppParallel_5.1.11-1
#>  [64] bench_1.1.4           pillar_1.11.1         lsa_0.73.3
#>  [67] KernSmooth_2.23-26    checkmate_2.3.3       DT_0.34.0
#>  [70] shinyjs_2.1.0         piano_2.26.0          ggplot2_4.0.1
#>  [73] scales_1.4.0          RApiSerialize_0.1.4   gtools_3.9.5
#>  [76] xtable_1.8-4          marray_1.88.0         glue_1.8.0
#>  [79] slam_0.1-55           tools_4.5.2           data.table_1.17.8
#>  [82] gDRutils_1.8.0        fgsea_1.36.0          visNetwork_2.1.4
#>  [85] fastmatch_1.1-6       cowplot_1.2.0         grid_4.5.2
#>  [88] cli_3.6.5             S4Arrays_1.10.1       dplyr_1.1.4
#>  [91] gtable_0.3.6          sass_0.4.10           digest_0.6.39
#>  [94] SparseArray_1.10.6    htmlwidgets_1.6.4     farver_2.1.2
#>  [97] htmltools_0.5.9       lifecycle_1.0.4       statmod_1.5.1
#> [100] mime_0.13
```