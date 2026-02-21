# Get started

Kim Philipp Jablonski

#### 1 November 2022

#### Package

pareg 1.2.0

# Contents

* [1 Overview](#overview)
* [2 Installation](#installation)
* [3 Load required packages](#load-required-packages)
* [4 Introductory example](#introductory-example)
  + [4.1 Generate pathway database](#generate-pathway-database)
  + [4.2 Term similarities](#term-similarities)
  + [4.3 Create synthetic study](#create-synthetic-study)
  + [4.4 Enrichment analysis](#enrichment-analysis)
  + [4.5 Session information](#session-information)
  + [References](#references)

# 1 Overview

This vignette is an introduction to the usage of `pareg`. It estimates pathway enrichment scores by regressing differential expression p-values of all genes considered in an experiment on their membership to a set of biological pathways. These scores are computed using a regularized generalized linear model with LASSO and network regularization terms. The network regularization term is based on a pathway similarity matrix (e.g., defined by Jaccard similarity) and thus classifies this method as a modular enrichment analysis tool (Huang, Sherman, and Lempicki 2009).

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("pareg")
```

# 3 Load required packages

We start our analysis by loading the `pareg` package and other required libraries.

```
library(ggraph)
library(tidyverse)
library(ComplexHeatmap)
library(enrichplot)

library(pareg)

set.seed(42)
```

# 4 Introductory example

## 4.1 Generate pathway database

For the sake of this introductory example, we generate a synthetic pathway database with a pronounced clustering of pathways.

```
group_num <- 2
pathways_from_group <- 10

gene_groups <- purrr::map(seq(1, group_num), function(group_idx) {
  glue::glue("g{group_idx}_gene_{seq_len(15)}")
})
genes_bg <- paste0("bg_gene_", seq(1, 50))

df_terms <- purrr::imap_dfr(
  gene_groups,
  function(current_gene_list, gene_list_idx) {
    purrr::map_dfr(seq_len(pathways_from_group), function(pathway_idx) {
      data.frame(
        term = paste0("g", gene_list_idx, "_term_", pathway_idx),
        gene = c(
          sample(current_gene_list, 10, replace = FALSE),
          sample(genes_bg, 10, replace = FALSE)
        )
      )
    })
  }
)

df_terms %>%
  sample_n(5)
```

```
##        term       gene
## 1 g1_term_9 g1_gene_12
## 2 g1_term_5  g1_gene_7
## 3 g2_term_2  g2_gene_2
## 4 g1_term_3 bg_gene_47
## 5 g1_term_8  g1_gene_1
```

## 4.2 Term similarities

Before starting the actual enrichment estimation, we compute pairwise pathway similarities with `pareg`’s helper function.

```
mat_similarities <- compute_term_similarities(
  df_terms,
  similarity_function = jaccard
)

hist(mat_similarities, xlab = "Term similarity")
```

![](data:image/png;base64...)

We can see a clear clustering of pathways.

```
Heatmap(
  mat_similarities,
  name = "Similarity",
  col = circlize::colorRamp2(c(0, 1), c("white", "black"))
)
```

![](data:image/png;base64...)

## 4.3 Create synthetic study

We then select a subset of pathways to be activated. In a performance evaluation, these would be considered to be true positives.

```
active_terms <- similarity_sample(mat_similarities, 5)
active_terms
```

```
## [1] "g2_term_6" "g2_term_3" "g2_term_3" "g2_term_2" "g2_term_8"
```

The genes contained in the union of active pathways are considered to be differentially expressed.

```
de_genes <- df_terms %>%
  filter(term %in% active_terms) %>%
  distinct(gene) %>%
  pull(gene)

other_genes <- df_terms %>%
  distinct(gene) %>%
  pull(gene) %>%
  setdiff(de_genes)
```

The p-values of genes considered to be differentially expressed are sampled from a Beta distribution centered at \(0\). The p-values for all other genes are drawn from a Uniform distribution.

```
df_study <- data.frame(
  gene = c(de_genes, other_genes),
  pvalue = c(rbeta(length(de_genes), 0.1, 1), rbeta(length(other_genes), 1, 1)),
  in_study = c(
    rep(TRUE, length(de_genes)),
    rep(FALSE, length(other_genes))
  )
)

table(
  df_study$pvalue <= 0.05,
  df_study$in_study, dnn = c("sig. p-value", "in study")
)
```

```
##             in study
## sig. p-value FALSE TRUE
##        FALSE    34   17
##        TRUE      1   28
```

## 4.4 Enrichment analysis

Finally, we compute pathway enrichment scores.

```
fit <- pareg(
  df_study %>% select(gene, pvalue),
  df_terms,
  network_param = 1, term_network = mat_similarities
)
```

```
## Loaded Tensorflow version 2.4.1
```

The results can be exported to a dataframe for further processing…

```
fit %>%
  as.data.frame() %>%
  arrange(desc(abs(enrichment))) %>%
  head() %>%
  knitr::kable()
```

| term | enrichment |
| --- | --- |
| g2\_term\_6 | -0.6760687 |
| g2\_term\_3 | -0.6005415 |
| g2\_term\_2 | -0.5818557 |
| g2\_term\_4 | -0.4233026 |
| g2\_term\_8 | -0.4123425 |
| g1\_term\_2 | 0.3978593 |

…and also visualized in a pathway network view.

```
plot(fit, min_similarity = 0.1)
```

![](data:image/png;base64...)

To provide a wider range of visualization options, the result can be transformed into an object which is understood by the functions of the [enrichplot](https://github.com/YuLab-SMU/enrichplot) package.

```
obj <- as_enrichplot_object(fit)

dotplot(obj) +
  scale_colour_continuous(name = "Enrichment Score")
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

![](data:image/png;base64...)

```
treeplot(obj) +
  scale_colour_continuous(name = "Enrichment Score")
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

![](data:image/png;base64...)

## 4.5 Session information

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
##  [1] pareg_1.2.0           tfprobability_0.15.1  tensorflow_2.9.0
##  [4] enrichplot_1.18.0     ComplexHeatmap_2.14.0 forcats_0.5.2
##  [7] stringr_1.4.1         dplyr_1.0.10          purrr_0.3.5
## [10] readr_2.1.3           tidyr_1.2.1           tibble_3.1.8
## [13] tidyverse_1.3.2       ggraph_2.1.0          ggplot2_3.3.6
## [16] BiocStyle_2.26.0
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
##  [37] bitops_1.0-7           cachem_1.0.6           fgsea_1.24.0
##  [40] gridGraphics_0.5-1     assertthat_0.2.1       scales_1.2.1
##  [43] googlesheets4_1.0.1    gtable_0.3.1           Cairo_1.6-0
##  [46] globals_0.16.1         tidygraph_1.2.2        rlang_1.0.6
##  [49] zeallot_0.1.0          scatterplot3d_0.3-42   GlobalOptions_0.1.2
##  [52] splines_4.2.1          lazyeval_0.2.2         gargle_1.2.1
##  [55] broom_1.0.1            BiocManager_1.30.19    yaml_2.3.6
##  [58] reshape2_1.4.4         modelr_0.1.9           backports_1.4.1
##  [61] qvalue_2.30.0          tools_4.2.1            bookdown_0.29
##  [64] ggplotify_0.1.0        ellipsis_0.3.2         jquerylib_0.1.4
##  [67] RColorBrewer_1.1-3     proxy_0.4-27           BiocGenerics_0.44.0
##  [70] Rcpp_1.0.9             plyr_1.8.7             base64enc_0.1-3
##  [73] progress_1.2.2         zlibbioc_1.44.0        RCurl_1.98-1.9
##  [76] prettyunits_1.1.1      GetoptLong_1.0.5       viridis_0.6.2
##  [79] cowplot_1.1.1          S4Vectors_0.36.0       haven_2.5.1
##  [82] ggrepel_0.9.1          cluster_2.1.4          fs_1.5.2
##  [85] furrr_0.3.1            magrittr_2.0.3         magick_2.7.3
##  [88] data.table_1.14.4      circlize_0.4.15        reprex_2.0.2
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

## References

Huang, Da Wei, Brad T Sherman, and Richard A Lempicki. 2009. “Bioinformatics Enrichment Tools: Paths Toward the Comprehensive Functional Analysis of Large Gene Lists.” *Nucleic Acids Research* 37 (1): 1–13.