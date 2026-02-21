# Pathway similarities

Kim Philipp Jablonski

#### 1 November 2022

#### Package

pareg 1.2.0

# Contents

* [1 Prelude](#prelude)
* [2 Introduction](#introduction)
* [3 Comparison of similarity measures](#comparison-of-similarity-measures)
* [4 Session information](#session-information)
* [References](#references)

# 1 Prelude

```
library(tidyverse)
library(ComplexHeatmap)
library(circlize)
library(GGally)

library(pareg)
data(pathway_similarities, package = "pareg")

set.seed(42)
```

# 2 Introduction

Pathway similarities describe how similar two pathways are (you’re welcome). For example, when interpreting pathways as gene sets, one could count how many genes are shared between two sets. Many more sophisticated methods, such as the Jaccard index, exist (Gu and Huebschmann 2021).

`pareg` provides various pre-computed similarity measures (jaccard, overlap\_coefficient, semantic) for selected pathway databases (C2@CP:KEGG, C5@GO:BP) in matrix form.

```
mat <- pathway_similarities$`C2@CP:KEGG`$jaccard %>%
  as_dense_sim()
mat[1:3, 1:3]
```

```
##          hsa00970    hsa05340    hsa04621
## hsa00970        1 0.000000000 0.000000000
## hsa05340        0 1.000000000 0.008196721
## hsa04621        0 0.008196721 1.000000000
```

```
Heatmap(
  mat,
  name = "similarity",
  col = colorRamp2(c(0, 1), c("white", "black")),
  show_row_names = FALSE,
  show_column_names = FALSE
)
```

![](data:image/png;base64...)

# 3 Comparison of similarity measures

On the Gene Ontology’s Biological Process subcategory, we can observe how much pathway similarity measures can differ from each other.

```
df_sim <- pathway_similarities$`C5@GO:BP` %>%
  map_dfr(function(mat) {
    if (is.null(mat)) {
      return(NULL)
    }

    mat %>%
      as_dense_sim() %>%
      as.data.frame %>%
      rownames_to_column() %>%
      pivot_longer(-rowname)
  }, .id = "measure") %>%
  filter(value > 0) %>%
  pivot_wider(names_from = measure, values_from = value) %>%
  select(-rowname, -name)

ggpairs(df_sim) +
  theme_minimal()
```

```
## Warning: Removed 514552 rows containing non-finite values (stat_density).
```

```
## Warning in ggally_statistic(data = data, mapping = mapping, na.rm = na.rm, :
## Removed 514552 rows containing missing values
```

```
## Warning in ggally_statistic(data = data, mapping = mapping, na.rm = na.rm, :
## Removed 586334 rows containing missing values
```

```
## Warning: Removed 514552 rows containing missing values (geom_point).
```

```
## Warning: Removed 514552 rows containing non-finite values (stat_density).
```

```
## Warning in ggally_statistic(data = data, mapping = mapping, na.rm = na.rm, :
## Removed 586334 rows containing missing values
```

```
## Warning: Removed 586334 rows containing missing values (geom_point).
## Removed 586334 rows containing missing values (geom_point).
```

```
## Warning: Removed 71782 rows containing non-finite values (stat_density).
```

![](data:image/png;base64...)

# 4 Session information

```
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] GGally_2.1.2          circlize_0.4.15       pareg_1.2.0
##  [4] tfprobability_0.15.1  tensorflow_2.9.0      enrichplot_1.18.0
##  [7] ComplexHeatmap_2.14.0 forcats_0.5.2         stringr_1.4.1
## [10] dplyr_1.0.10          purrr_0.3.5           readr_2.1.3
## [13] tidyr_1.2.1           tibble_3.1.8          tidyverse_1.3.2
## [16] ggraph_2.1.0          ggplot2_3.3.6         BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##   [1] utf8_1.2.2             reticulate_1.26        tidyselect_1.2.0
##   [4] RSQLite_2.2.18         AnnotationDbi_1.60.0   BiocParallel_1.32.0
##   [7] scatterpie_0.1.8       munsell_0.5.0          codetools_0.2-18
##  [10] future_1.28.0          withr_2.5.0            keras_2.9.0
##  [13] colorspace_2.0-3       GOSemSim_2.24.0        Biobase_2.58.0
##  [16] highr_0.9              knitr_1.40             stats4_4.2.1
##  [19] DOSE_3.24.0            listenv_0.8.0          labeling_0.4.2
##  [22] GenomeInfoDbData_1.2.9 matrixLaplacian_1.0    polyclip_1.10-4
##  [25] bit64_4.0.5            farver_2.1.1           parallelly_1.32.1
##  [28] vctrs_0.5.0            treeio_1.22.0          generics_0.1.3
##  [31] xfun_0.34              R6_2.5.1               doParallel_1.0.17
##  [34] GenomeInfoDb_1.34.0    clue_0.3-62            graphlayouts_0.8.3
##  [37] reshape_0.8.9          bitops_1.0-7           cachem_1.0.6
##  [40] fgsea_1.24.0           gridGraphics_0.5-1     assertthat_0.2.1
##  [43] scales_1.2.1           googlesheets4_1.0.1    gtable_0.3.1
##  [46] Cairo_1.6-0            globals_0.16.1         tidygraph_1.2.2
##  [49] rlang_1.0.6            zeallot_0.1.0          scatterplot3d_0.3-42
##  [52] GlobalOptions_0.1.2    splines_4.2.1          lazyeval_0.2.2
##  [55] gargle_1.2.1           broom_1.0.1            BiocManager_1.30.19
##  [58] yaml_2.3.6             reshape2_1.4.4         modelr_0.1.9
##  [61] backports_1.4.1        qvalue_2.30.0          tools_4.2.1
##  [64] bookdown_0.29          ggplotify_0.1.0        ellipsis_0.3.2
##  [67] jquerylib_0.1.4        RColorBrewer_1.1-3     proxy_0.4-27
##  [70] BiocGenerics_0.44.0    Rcpp_1.0.9             plyr_1.8.7
##  [73] base64enc_0.1-3        progress_1.2.2         zlibbioc_1.44.0
##  [76] RCurl_1.98-1.9         prettyunits_1.1.1      GetoptLong_1.0.5
##  [79] viridis_0.6.2          cowplot_1.1.1          S4Vectors_0.36.0
##  [82] haven_2.5.1            ggrepel_0.9.1          cluster_2.1.4
##  [85] fs_1.5.2               furrr_0.3.1            magrittr_2.0.3
##  [88] magick_2.7.3           data.table_1.14.4      reprex_2.0.2
##  [91] googledrive_2.0.0      whisker_0.4            ggnewscale_0.4.8
##  [94] matrixStats_0.62.0     hms_1.1.2              patchwork_1.1.2
##  [97] evaluate_0.17          HDO.db_0.99.1          readxl_1.4.1
## [100] IRanges_2.32.0         gridExtra_2.3          shape_1.4.6
## [103] tfruns_1.5.1           compiler_4.2.1         crayon_1.5.2
## [106] shadowtext_0.1.2       htmltools_0.5.3        ggfun_0.0.7
## [109] tzdb_0.3.0             aplot_0.1.8            lubridate_1.8.0
## [112] DBI_1.1.3              tweenr_2.0.2           dbplyr_2.2.1
## [115] MASS_7.3-58.1          Matrix_1.5-1           cli_3.4.1
## [118] parallel_4.2.1         igraph_1.3.5           pkgconfig_2.0.3
## [121] xml2_1.3.3             foreach_1.5.2          ggtree_3.6.0
## [124] bslib_0.4.0            XVector_0.38.0         rvest_1.0.3
## [127] yulab.utils_0.0.5      digest_0.6.30          Biostrings_2.66.0
## [130] rmarkdown_2.17         cellranger_1.1.0       fastmatch_1.1-3
## [133] tidytree_0.4.1         rjson_0.2.21           nloptr_2.0.3
## [136] lifecycle_1.0.3        nlme_3.1-160           jsonlite_1.8.3
## [139] viridisLite_0.4.1      fansi_1.0.3            pillar_1.8.1
## [142] lattice_0.20-45        KEGGREST_1.38.0        fastmap_1.1.0
## [145] httr_1.4.4             GO.db_3.16.0           glue_1.6.2
## [148] png_0.1-7              iterators_1.0.14       bit_4.0.4
## [151] ggforce_0.4.1          stringi_1.7.8          sass_0.4.2
## [154] blob_1.2.3             memoise_2.0.1          ape_5.6-2
```

# References

Gu, Zuguang, and Daniel Huebschmann. 2021. “SimplifyEnrichment: An R/Bioconductor Package for Clustering and Visualizing Functional Enrichment Results.” *bioRxiv*.