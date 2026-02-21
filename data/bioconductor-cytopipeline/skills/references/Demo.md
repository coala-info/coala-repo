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
## [1] ggplot2_4.0.0       reshape2_1.4.4      CytoPipeline_1.10.0
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] changepoint_2.3       tidyselect_1.2.1      dplyr_1.1.4
##  [4] farver_2.1.2          blob_1.2.4            filelock_1.0.3
##  [7] S7_0.2.0              fastmap_1.2.0         BiocFileCache_3.0.0
## [10] XML_3.99-0.19         digest_0.6.37         lifecycle_1.0.4
## [13] cluster_2.1.8.1       RSQLite_2.4.3         magrittr_2.0.4
## [16] compiler_4.5.1        rlang_1.1.6           sass_0.4.10
## [19] tools_4.5.1           yaml_2.3.10           data.table_1.17.8
## [22] knitr_1.50            labeling_0.4.3        bit_4.6.0
## [25] curl_7.0.0            diagram_1.6.5         plyr_1.8.9
## [28] RColorBrewer_1.1-3    withr_3.0.2           purrr_1.1.0
## [31] RProtoBufLib_2.22.0   BiocGenerics_0.56.0   PeacoQC_1.20.0
## [34] grid_4.5.1            stats4_4.5.1          flowAI_1.40.0
## [37] colorspace_2.1-2      scales_1.4.0          iterators_1.0.14
## [40] tinytex_0.57          dichromat_2.0-0.1     cli_3.6.5
## [43] rmarkdown_2.30        crayon_1.5.3          ncdfFlow_2.56.0
## [46] generics_0.1.4        rjson_0.2.23          DBI_1.2.3
## [49] cachem_1.1.0          flowCore_2.22.0       stringr_1.5.2
## [52] parallel_4.5.1        BiocManager_1.30.26   matrixStats_1.5.0
## [55] vctrs_0.6.5           jsonlite_2.0.0        cytolib_2.22.0
## [58] bookdown_0.45         IRanges_2.44.0        GetoptLong_1.0.5
## [61] S4Vectors_0.48.0      bit64_4.6.0-1         clue_0.3-66
## [64] Rgraphviz_2.54.0      magick_2.9.0          foreach_1.5.2
## [67] jquerylib_0.1.4       hexbin_1.28.5         glue_1.8.0
## [70] codetools_0.2-20      stringi_1.8.7         gtable_0.3.6
## [73] shape_1.4.6.1         ggcyto_1.38.0         ComplexHeatmap_2.26.0
## [76] tibble_3.3.0          pillar_1.11.1         rappdirs_0.3.3
## [79] htmltools_0.5.8.1     graph_1.88.0          circlize_0.4.16
## [82] R6_2.6.1              dbplyr_2.5.1          httr2_1.2.1
## [85] doParallel_1.0.17     evaluate_1.0.5        flowWorkspace_4.22.0
## [88] lattice_0.22-7        Biobase_2.70.0        png_0.1-8
## [91] memoise_2.0.1         bslib_0.9.0           Rcpp_1.1.0
## [94] gridExtra_2.3         xfun_0.53             zoo_1.8-14
## [97] pkgconfig_2.0.3       GlobalOptions_0.1.2
```