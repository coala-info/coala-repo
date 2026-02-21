# Demonstration of the CytoPipeline R package suite functionalities

Philippe Hauchamps and Laurent Gatto

#### 29 October 2025

#### Abstract

This vignette provides links to videos demonstrating some of the functionalities of CytoPipeline R package suite. It is distributed, as well as the accompanying videos, under a CC BY-SA license.

#### Package

CytoPipeline 1.10.0

# 1 Introduction

# 2 Background information

# 3 Illustrating dataset

# 4 Specifying the pipeline

# 5 Running the pipeline

# 6 Visualizing the results

# 7 Comparing pipelines

# 8 Example with two different QC methods

# 9 Visualizing scale transformations

# 10 Defining technical run parameters

# Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] patchwork_1.3.2       CytoPipelineGUI_1.8.0 CytoPipeline_1.10.0
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3             gridExtra_2.3         httr2_1.2.1
##   [4] rlang_1.1.6           magrittr_2.0.4        clue_0.3-66
##   [7] GetoptLong_1.0.5      otel_0.2.0            matrixStats_1.5.0
##  [10] compiler_4.5.1        RSQLite_2.4.3         png_0.1-8
##  [13] vctrs_0.6.5           reshape2_1.4.4        stringr_1.5.2
##  [16] pkgconfig_2.0.3       shape_1.4.6.1         crayon_1.5.3
##  [19] fastmap_1.2.0         magick_2.9.0          dbplyr_2.5.1
##  [22] labeling_0.4.3        promises_1.4.0        ncdfFlow_2.56.0
##  [25] rmarkdown_2.30        graph_1.88.0          tinytex_0.57
##  [28] purrr_1.1.0           bit_4.6.0             xfun_0.53
##  [31] cachem_1.1.0          jsonlite_2.0.0        flowWorkspace_4.22.0
##  [34] blob_1.2.4            later_1.4.4           parallel_4.5.1
##  [37] cluster_2.1.8.1       R6_2.6.1              bslib_0.9.0
##  [40] stringi_1.8.7         RColorBrewer_1.1-3    jquerylib_0.1.4
##  [43] Rcpp_1.1.0            bookdown_0.45         iterators_1.0.14
##  [46] knitr_1.50            zoo_1.8-14            IRanges_2.44.0
##  [49] flowCore_2.22.0       httpuv_1.6.16         tidyselect_1.2.1
##  [52] dichromat_2.0-0.1     yaml_2.3.10           doParallel_1.0.17
##  [55] codetools_0.2-20      curl_7.0.0            lattice_0.22-7
##  [58] tibble_3.3.0          plyr_1.8.9            Biobase_2.70.0
##  [61] shiny_1.11.1          withr_3.0.2           S7_0.2.0
##  [64] evaluate_1.0.5        BiocFileCache_3.0.0   circlize_0.4.16
##  [67] pillar_1.11.1         BiocManager_1.30.26   filelock_1.0.3
##  [70] foreach_1.5.2         flowAI_1.40.0         stats4_4.5.1
##  [73] generics_0.1.4        S4Vectors_0.48.0      ggplot2_4.0.0
##  [76] ggcyto_1.38.0         scales_1.4.0          xtable_1.8-4
##  [79] PeacoQC_1.20.0        glue_1.8.0            changepoint_2.3
##  [82] tools_4.5.1           hexbin_1.28.5         data.table_1.17.8
##  [85] XML_3.99-0.19         grid_4.5.1            RProtoBufLib_2.22.0
##  [88] colorspace_2.1-2      cli_3.6.5             rappdirs_0.3.3
##  [91] cytolib_2.22.0        ComplexHeatmap_2.26.0 dplyr_1.1.4
##  [94] Rgraphviz_2.54.0      gtable_0.3.6          sass_0.4.10
##  [97] digest_0.6.37         BiocGenerics_0.56.0   rjson_0.2.23
## [100] farver_2.1.2          memoise_2.0.1         htmltools_0.5.8.1
## [103] lifecycle_1.0.4       GlobalOptions_0.1.2   mime_0.13
## [106] bit64_4.6.0-1
```