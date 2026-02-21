# Overview of pathway network databases

Kim Philipp Jablonski, Martin Pirkl

#### 2021-05-19

# Contents

* [1 Introduction](#introduction)
  + [1.1 Load required packages](#load-required-packages)
* [2 Pathway database overview](#pathway-database-overview)
* [3 Plotting pathways](#plotting-pathways)
* [4 Session information](#session-information)
* [References](#references)

# 1 Introduction

## 1.1 Load required packages

Load the package with the library function.

```
library(tidyverse)
library(ggplot2)

library(dce)

set.seed(42)
```

```
dce::df_pathway_statistics %>%
  sample_n(10) %>%
  arrange(desc(node_num)) %>%
  knitr::kable()
```

| database | pathway\_id | pathway\_name | node\_num | edge\_num |
| --- | --- | --- | --- | --- |
| kegg | hsa:04151 | PI3K-Akt signaling pathway | 354 | 4552 |
| kegg | hsa:04371 | Apelin signaling pathway | 134 | 942 |
| kegg | hsa:04520 | Adherens junction | 68 | 170 |
| kegg | hsa:04970 | Salivary secretion | 48 | 96 |
| kegg | hsa:05321 | Inflammatory bowel disease | 48 | 81 |
| nci | pid\_4166 | Beta2 integrin cell surface interactions | 29 | 140 |
| kegg | hsa:00563 | Glycosylphosphatidylinositol (GPI)-anchor biosynthesis | 23 | 116 |
| kegg | hsa:00900 | Terpenoid backbone biosynthesis | 21 | 69 |
| biocarta | pid\_10459 | rna polymerase iii transcription | 7 | 42 |
| biocarta | pid\_9732 | estrogen responsive protein efp controls cell cycle and breast tumors growth | 4 | 2 |

# 2 Pathway database overview

We provide access to the following topological pathway databases using
graphite (Sales et al. 2012):

```
dce::df_pathway_statistics %>%
  count(database, sort = TRUE, name = "pathway_number") %>%
  knitr::kable()
```

| database | pathway\_number |
| --- | --- |
| kegg | 317 |
| biocarta | 247 |
| nci | 212 |
| panther | 94 |
| pharmgkb | 66 |

```
dce::df_pathway_statistics %>%
  ggplot(aes(x = node_num)) +
    geom_histogram(bins = 30) +
    facet_wrap(~ database, scales = "free") +
    theme_minimal()
```

![](data:image/png;base64...)

# 3 Plotting pathways

It is easily possible to plot pathways:

```
pathways <- get_pathways(
  pathway_list = list(
    kegg = c("Citrate cycle (TCA cycle)")
  )
)
```

```
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
```

```
lapply(pathways, function(x) {
  plot_network(as(x$graph, "matrix"), visualize_edge_weights = FALSE) +
    ggtitle(x$pathway_name)
})
```

```
## [[1]]
```

![](data:image/png;base64...)

# 4 Session information

```
sessionInfo()
```

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.13.0         AnnotationDbi_1.54.0
##  [3] dce_1.0.0                   graph_1.70.0
##  [5] cowplot_1.1.1               forcats_0.5.1
##  [7] stringr_1.4.0               dplyr_1.0.6
##  [9] purrr_0.3.4                 readr_1.4.0
## [11] tidyr_1.1.3                 tibble_3.1.2
## [13] tidyverse_1.3.1             TCGAutils_1.12.0
## [15] curatedTCGAData_1.13.9      MultiAssayExperiment_1.18.0
## [17] SummarizedExperiment_1.22.0 Biobase_2.52.0
## [19] GenomicRanges_1.44.0        GenomeInfoDb_1.28.0
## [21] IRanges_2.26.0              S4Vectors_0.30.0
## [23] BiocGenerics_0.38.0         MatrixGenerics_1.4.0
## [25] matrixStats_0.58.0          ggraph_2.0.5
## [27] ggplot2_3.3.3               BiocStyle_2.20.0
##
## loaded via a namespace (and not attached):
##   [1] rappdirs_0.3.3                rtracklayer_1.52.0
##   [3] prabclus_2.3-2                bit64_4.0.5
##   [5] knitr_1.33                    multcomp_1.4-17
##   [7] DelayedArray_0.18.0           data.table_1.14.0
##   [9] wesanderson_0.3.6             KEGGREST_1.32.0
##  [11] RCurl_1.98-1.3                generics_0.1.0
##  [13] metap_1.4                     GenomicFeatures_1.44.0
##  [15] TH.data_1.0-10                RSQLite_2.2.7
##  [17] proxy_0.4-25                  CombinePValue_1.0
##  [19] bit_4.0.4                     mutoss_0.1-12
##  [21] xml2_1.3.2                    lubridate_1.7.10
##  [23] httpuv_1.6.1                  assertthat_0.2.1
##  [25] viridis_0.6.1                 amap_0.8-18
##  [27] xfun_0.23                     hms_1.1.0
##  [29] jquerylib_0.1.4               evaluate_0.14
##  [31] promises_1.2.0.1              DEoptimR_1.0-8
##  [33] fansi_0.4.2                   restfulr_0.0.13
##  [35] progress_1.2.2                dbplyr_2.1.1
##  [37] readxl_1.3.1                  Rgraphviz_2.36.0
##  [39] igraph_1.2.6                  DBI_1.1.1
##  [41] tmvnsim_1.0-2                 apcluster_1.4.8
##  [43] RcppArmadillo_0.10.4.0.0      ellipsis_0.3.2
##  [45] backports_1.2.1               bookdown_0.22
##  [47] permute_0.9-5                 harmonicmeanp_3.0
##  [49] biomaRt_2.48.0                vctrs_0.3.8
##  [51] abind_1.4-5                   Linnorm_2.16.0
##  [53] cachem_1.0.5                  RcppEigen_0.3.3.9.1
##  [55] withr_2.4.2                   sfsmisc_1.1-11
##  [57] ggforce_0.3.3                 robustbase_0.93-7
##  [59] bdsmatrix_1.3-4               checkmate_2.0.0
##  [61] vegan_2.5-7                   GenomicAlignments_1.28.0
##  [63] pcalg_2.7-2                   prettyunits_1.1.1
##  [65] mclust_5.4.7                  mnormt_2.0.2
##  [67] cluster_2.1.2                 ExperimentHub_2.0.0
##  [69] GenomicDataCommons_1.16.0     crayon_1.4.1
##  [71] ellipse_0.4.2                 labeling_0.4.2
##  [73] FMStable_0.1-2                edgeR_3.34.0
##  [75] pkgconfig_2.0.3               tweenr_1.0.2
##  [77] nlme_3.1-152                  ggm_2.5
##  [79] nnet_7.3-16                   rlang_0.4.11
##  [81] diptest_0.76-0                lifecycle_1.0.0
##  [83] sandwich_3.0-1                filelock_1.0.2
##  [85] BiocFileCache_2.0.0           mathjaxr_1.4-0
##  [87] modelr_0.1.8                  AnnotationHub_3.0.0
##  [89] cellranger_1.1.0              polyclip_1.10-0
##  [91] Matrix_1.3-3                  zoo_1.8-9
##  [93] reprex_2.0.0                  png_0.1-7
##  [95] viridisLite_0.4.0             rjson_0.2.20
##  [97] bitops_1.0-7                  Biostrings_2.60.0
##  [99] blob_1.2.1                    scales_1.1.1
## [101] plyr_1.8.6                    memoise_2.0.0
## [103] graphite_1.38.0               magrittr_2.0.1
## [105] gdata_2.18.0                  zlibbioc_1.38.0
## [107] compiler_4.1.0                BiocIO_1.2.0
## [109] clue_0.3-59                   plotrix_3.8-1
## [111] Rsamtools_2.8.0               cli_2.5.0
## [113] XVector_0.32.0                ps_1.6.0
## [115] MASS_7.3-54                   mgcv_1.8-35
## [117] tidyselect_1.1.1              stringi_1.6.2
## [119] highr_0.9                     yaml_2.2.1
## [121] locfit_1.5-9.4                ggrepel_0.9.1
## [123] grid_4.1.0                    sass_0.4.0
## [125] tools_4.1.0                   rstudioapi_0.13
## [127] snowfall_1.84-6.1             gridExtra_2.3
## [129] farver_2.1.0                  Rtsne_0.15
## [131] digest_0.6.27                 BiocManager_1.30.15
## [133] flexclust_1.4-0               shiny_1.6.0
## [135] mnem_1.8.0                    fpc_2.2-9
## [137] ppcor_1.1                     Rcpp_1.0.6
## [139] broom_0.7.6                   BiocVersion_3.13.1
## [141] later_1.2.0                   httr_1.4.2
## [143] ggdendro_0.1.22               kernlab_0.9-29
## [145] naturalsort_0.1.3             Rdpack_2.1.1
## [147] colorspace_2.0-1              rvest_1.0.0
## [149] XML_3.99-0.6                  fs_1.5.0
## [151] splines_4.1.0                 RBGL_1.68.0
## [153] statmod_1.4.36                sn_2.0.0
## [155] expm_0.999-6                  graphlayouts_0.7.1
## [157] multtest_2.48.0               flexmix_2.3-17
## [159] xtable_1.8-4                  jsonlite_1.7.2
## [161] tidygraph_1.2.0               corpcor_1.6.9
## [163] modeltools_0.2-23             R6_2.5.0
## [165] gmodels_2.18.1                TFisher_0.2.0
## [167] pillar_1.6.1                  htmltools_0.5.1.1
## [169] mime_0.10                     glue_1.4.2
## [171] fastmap_1.1.0                 BiocParallel_1.26.0
## [173] class_7.3-19                  interactiveDisplayBase_1.30.0
## [175] codetools_0.2-18              tsne_0.1-3
## [177] mvtnorm_1.1-1                 utf8_1.2.1
## [179] lattice_0.20-44               bslib_0.2.5.1
## [181] logger_0.2.0                  numDeriv_2016.8-1.1
## [183] curl_4.3.1                    gtools_3.8.2
## [185] magick_2.7.2                  survival_3.2-11
## [187] limma_3.48.0                  rmarkdown_2.8
## [189] fastICA_1.2-2                 munsell_0.5.0
## [191] e1071_1.7-6                   fastcluster_1.1.25
## [193] GenomeInfoDbData_1.2.6        reshape2_1.4.4
## [195] haven_2.4.1                   gtable_0.3.0
## [197] rbibutils_2.1.1
```

# References

Sales, Gabriele, Enrica Calura, Duccio Cavalieri, and Chiara Romualdi. 2012. “Graphite-a Bioconductor Package to Convert Pathway Topology to Gene Network.” *BMC Bioinformatics* 13 (1): 20.