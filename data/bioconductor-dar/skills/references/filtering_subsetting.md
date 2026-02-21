# Filtering and Subsetting

The `step_filter_taxa` function is a general function that allows for flexible filtering of OTUs based on across-sample abundance criteria. The other functions, `step_filter_by_prevalence`, `step_filter_by_variance`, `step_filter_by_abundance`, and `step_filter_by_rarity`, are convenience wrappers around `step_filter_taxa`, each designed to filter OTUs based on a specific criterion: prevalence, variance, abundance, and rarity, respectively.

The `step_subset_taxa` function is used to subset taxa based on their taxonomic level.

The phyloseq or TSE used as input can be pre-filtered using methods that are most convenient to the user. However, the `dar` package provides several functions to perform this filtering directly on the recipe object.

## step\_filter\_taxa

The `step_filter_taxa` function applies an arbitrary set of functions to OTUs as across-sample criteria. It takes a phyloseq object as input and returns a logical vector indicating whether each OTU passed the criteria. If the “prune” option is set to FALSE, it returns the already-trimmed version of the phyloseq object.

```
library(dar)
data("metaHIV_phy")

rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_filter_taxa(rec, .f = "function(x) sum(x > 0) >= (0 * length(x))") |>
  prep()
```

## Convenience Wrappers

### step\_filter\_by\_abundance

This function filters OTUs based on their abundance. The taxa retained in the dataset are those where the sum of their abundance is greater than the product of the total abundance and the provided threshold.

```
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_filter_by_abundance(rec, threshold = 0.01) |>
  prep()
```

### step\_filter\_by\_prevalence

This function filters OTUs based on their prevalence. The taxa retained in the dataset are those where the prevalence is greater than the provided threshold.

```
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_filter_by_prevalence(rec, threshold = 0.01) |>
  prep()
```

### step\_filter\_by\_rarity

This function filters OTUs based on their rarity. The taxa retained in the dataset are those where the sum of their rarity is less than the provided threshold.

```
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_filter_by_rarity(rec, threshold = 0.01) |>
  prep()
```

### step\_filter\_by\_variance

This function filters OTUs based on their variance. The taxa retained in the dataset are those where the variance of their abundance is greater than the provided threshold.

```
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_filter_by_variance(rec, threshold = 0.01) |>
  prep()
```

## subset\_taxa

The `subset_taxa` function subsets taxa based on their taxonomic level. The taxa retained in the dataset are those where the taxonomic level matches the provided taxa.

```
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")
rec <-
  step_subset_taxa(rec, tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  prep()
```

## Conclusion

These functions provide a powerful and flexible way to filter and subset OTUs in phyloseq objects contained within a recipe object, making it easier to work with complex experimental data. By understanding how to use these functions effectively, you can streamline your data analysis workflow and focus on the aspects of your data that are most relevant to your research questions. The `dar` package offers the added convenience of performing these operations directly on the recipe object.

## Session info

```
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package                  * version  date (UTC) lib source
#>  abind                      1.4-8    2024-09-12 [2] CRAN (R 4.5.1)
#>  ade4                       1.7-23   2025-02-14 [2] CRAN (R 4.5.1)
#>  ape                        5.8-1    2024-12-16 [2] CRAN (R 4.5.1)
#>  assertthat                 0.2.1    2019-03-21 [2] CRAN (R 4.5.1)
#>  beachmat                   2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm                   0.4.0    2021-06-01 [2] CRAN (R 4.5.1)
#>  Biobase                  * 2.70.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocBaseUtils              1.12.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics             * 0.56.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocNeighbors              2.4.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel               1.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular               1.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomformat                 1.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings               * 2.78.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bitops                     1.0-9    2024-10-03 [2] CRAN (R 4.5.1)
#>  bluster                    1.20.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  brio                       1.1.5    2024-04-24 [2] CRAN (R 4.5.1)
#>  bslib                      0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  ca                         0.71.1   2020-01-24 [2] CRAN (R 4.5.1)
#>  cachem                     1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo                      1.7-0    2025-10-29 [2] CRAN (R 4.5.1)
#>  caTools                    1.18.3   2024-09-04 [2] CRAN (R 4.5.1)
#>  cellranger                 1.1.0    2016-07-27 [2] CRAN (R 4.5.1)
#>  circlize                   0.4.16   2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                        3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                       0.3-66   2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                    2.1.8.1  2025-03-12 [3] CRAN (R 4.5.1)
#>  coda                       0.19-4.1 2024-01-31 [2] CRAN (R 4.5.1)
#>  codetools                  0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace                 2.1-2    2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap             2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  crayon                     1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
#>  crosstalk                  1.2.2    2025-08-26 [2] CRAN (R 4.5.1)
#>  dar                      * 1.6.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  data.table                 1.17.8   2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                        1.2.3    2024-06-02 [2] CRAN (R 4.5.1)
#>  DECIPHER                   3.6.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  decontam                   1.30.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DelayedArray               0.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DelayedMatrixStats         1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dendextend                 1.19.1   2025-07-15 [2] CRAN (R 4.5.1)
#>  devtools                   2.4.6    2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat                  2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                     0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  DirichletMultinomial       1.52.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  doParallel                 1.0.17   2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                      1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis                   0.3.2    2021-04-29 [2] CRAN (R 4.5.1)
#>  emmeans                    2.0.0    2025-10-29 [2] CRAN (R 4.5.1)
#>  estimability               1.5.1    2024-05-12 [2] CRAN (R 4.5.1)
#>  evaluate                   1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                     2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                    1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  fillpattern                1.0.2    2024-06-24 [2] CRAN (R 4.5.1)
#>  foreach                    1.5.2    2022-02-02 [2] CRAN (R 4.5.1)
#>  fs                         1.6.6    2025-04-12 [2] CRAN (R 4.5.1)
#>  furrr                      0.3.1    2022-08-15 [2] CRAN (R 4.5.1)
#>  future                     1.67.0   2025-07-29 [2] CRAN (R 4.5.1)
#>  generics                 * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges            * 1.62.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong                 1.0.5    2020-12-15 [2] CRAN (R 4.5.1)
#>  ggbeeswarm                 0.7.2    2023-04-29 [2] CRAN (R 4.5.1)
#>  ggnewscale                 0.5.2    2025-06-20 [2] CRAN (R 4.5.1)
#>  ggplot2                    4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                    0.9.6    2024-09-07 [2] CRAN (R 4.5.1)
#>  ggtext                     0.1.2    2022-09-16 [2] CRAN (R 4.5.1)
#>  GlobalOptions              0.1.2    2020-06-10 [2] CRAN (R 4.5.1)
#>  globals                    0.18.0   2025-05-08 [2] CRAN (R 4.5.1)
#>  glue                       1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  gplots                     3.2.0    2024-10-05 [2] CRAN (R 4.5.1)
#>  gridExtra                  2.3      2017-09-09 [2] CRAN (R 4.5.1)
#>  gridtext                   0.1.5    2022-09-16 [2] CRAN (R 4.5.1)
#>  gtable                     0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  gtools                     3.9.5    2023-11-20 [2] CRAN (R 4.5.1)
#>  heatmaply                  1.6.0    2025-07-12 [2] CRAN (R 4.5.1)
#>  hms                        1.1.4    2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools                  0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets                1.6.4    2023-12-06 [2] CRAN (R 4.5.1)
#>  httr                       1.4.7    2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph                     2.2.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges                  * 2.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                      2.3.5.1  2022-10-03 [2] CRAN (R 4.5.1)
#>  iterators                  1.0.14   2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib                  0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite                   2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
#>  KernSmooth                 2.23-26  2025-01-01 [3] CRAN (R 4.5.1)
#>  knitr                      1.50     2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling                   0.4.3    2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                    0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval                   0.2.2    2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle                  1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
#>  listenv                    0.9.1    2024-01-29 [2] CRAN (R 4.5.1)
#>  magick                     2.9.0    2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr                   2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
#>  MASS                       7.3-65   2025-02-28 [3] CRAN (R 4.5.1)
#>  Matrix                     1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics           * 1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats              * 1.5.0    2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                    2.0.1    2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                       1.9-3    2025-04-04 [3] CRAN (R 4.5.1)
#>  mia                      * 1.18.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  microbiome                 1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  multcomp                   1.4-29   2025-10-20 [2] CRAN (R 4.5.1)
#>  MultiAssayExperiment     * 1.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  multtest                   2.66.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mvtnorm                    1.3-3    2025-01-10 [2] CRAN (R 4.5.1)
#>  nlme                       3.1-168  2025-03-31 [3] CRAN (R 4.5.1)
#>  parallelly                 1.45.1   2025-07-24 [2] CRAN (R 4.5.1)
#>  patchwork                  1.3.2    2025-08-25 [2] CRAN (R 4.5.1)
#>  permute                    0.9-8    2025-06-25 [2] CRAN (R 4.5.1)
#>  phyloseq                 * 1.54.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  pillar                     1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild                   1.4.8    2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig                  2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                    1.4.1    2025-09-23 [2] CRAN (R 4.5.1)
#>  plotly                     4.11.0   2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr                       1.8.9    2023-10-02 [2] CRAN (R 4.5.1)
#>  png                        0.1-8    2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                      1.1.0    2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                         2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  ragg                       1.5.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  rappdirs                   0.3.3    2021-01-31 [2] CRAN (R 4.5.1)
#>  rbiom                      2.2.1    2025-06-27 [2] CRAN (R 4.5.1)
#>  RColorBrewer               1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                       1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  readr                      2.1.5    2024-01-10 [2] CRAN (R 4.5.1)
#>  readxl                     1.4.5    2025-03-07 [2] CRAN (R 4.5.1)
#>  registry                   0.5-1    2019-03-05 [2] CRAN (R 4.5.1)
#>  remotes                    2.5.0    2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2                   1.4.4    2020-04-09 [2] CRAN (R 4.5.1)
#>  rhdf5                      2.54.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters               1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib                   1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson                      0.2.23   2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                      1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown                  2.30     2025-09-28 [2] CRAN (R 4.5.1)
#>  rsvd                       1.0.5    2021-04-16 [2] CRAN (R 4.5.1)
#>  Rtsne                      0.17     2023-12-07 [2] CRAN (R 4.5.1)
#>  S4Arrays                   1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors                * 0.48.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                         0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
#>  sandwich                   3.1-1    2024-09-15 [2] CRAN (R 4.5.1)
#>  sass                       0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix               1.18.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                     1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
#>  scater                     1.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle                    1.20.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo                  * 1.0.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  seriation                  1.5.8    2025-08-20 [2] CRAN (R 4.5.1)
#>  sessioninfo                1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                      1.4.6.1  2024-02-23 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment     * 1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  slam                       0.1-55   2024-11-13 [2] CRAN (R 4.5.1)
#>  SparseArray                1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sparseMatrixStats          1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                    1.8.7    2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                    1.5.2    2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment     * 1.40.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  survival                   3.8-3    2024-12-17 [3] CRAN (R 4.5.1)
#>  systemfonts                1.3.1    2025-10-01 [2] CRAN (R 4.5.1)
#>  testthat                   3.2.3    2025-01-13 [2] CRAN (R 4.5.1)
#>  textshaping                1.0.4    2025-10-10 [2] CRAN (R 4.5.1)
#>  TH.data                    1.1-4    2025-09-02 [2] CRAN (R 4.5.1)
#>  tibble                     3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                      1.3.1    2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect                 1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
#>  tidytree                   0.4.6    2023-12-12 [2] CRAN (R 4.5.1)
#>  treeio                     1.34.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  TreeSummarizedExperiment * 2.18.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  TSP                        1.2-5    2025-05-27 [2] CRAN (R 4.5.1)
#>  tzdb                       0.5.0    2025-03-15 [2] CRAN (R 4.5.1)
#>  UpSetR                     1.4.0    2019-05-22 [2] CRAN (R 4.5.1)
#>  usethis                    3.2.1    2025-09-06 [2] CRAN (R 4.5.1)
#>  utf8                       1.2.6    2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs                      0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
#>  vegan                      2.7-2    2025-10-08 [2] CRAN (R 4.5.1)
#>  vipor                      0.4.7    2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                    0.6.5    2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite                0.4.2    2023-05-02 [2] CRAN (R 4.5.1)
#>  webshot                    0.5.5    2023-06-26 [2] CRAN (R 4.5.1)
#>  withr                      3.0.2    2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                       0.53     2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                       1.4.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                     1.8-4    2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                  * 0.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                       2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
#>  yulab.utils                0.2.1    2025-08-19 [2] CRAN (R 4.5.1)
#>  zoo                        1.8-14   2025-04-10 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpxvaRZh/Rinst3e30fb71cf6981
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```