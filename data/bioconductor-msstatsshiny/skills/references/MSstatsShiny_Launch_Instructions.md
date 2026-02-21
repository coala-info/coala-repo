# MSstatsShiny Launch Instructions

#### Devon Kohler (kohler.d@northeastern.edu)

#### 2026-01-26

This Vignette goes over how to launch the `MSstatsShiny` R shiny application.

## Installation

To install this package, start R (version “4.0”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstatsShiny")
```

```
library(MSstatsShiny)
```

# 1. Introduction

`MSstatsShiny` is an R-shiny based GUI package integrated with the `MSstats` family of packages. The package allows users to analyze a variety of proteomic experiments, including those processed using different labeling methods, spectral processing tools, and targeting different biological questions of interest. It is designed to enhance the usability of the `MSstats` packages, bringing them to a wider user base, including those who do not have have experience coding in R. The GUI is designed to be general, reproducible, and scalable, as well as easily usable by all users. Finally, it enhances both reproducibility and collaboration through documenting analyses via code, which recreates the user’s analysis exactly.

# 2. Launch Function

After installation, running the application is as simple as executing a single command.

```
launch_MSstatsShiny()
```

Once this command is executed, the application will automatically start up in a different window. You can still view any warnings or errors in the R console where you ran the function. This can be helpful when debugging.

# 3. Cloud Version

`MSstatsShiny` is also available on the cloud at . Due to RAM constraints, the cloud version of the application is limited to files under 250 MB. Any larger files should be processed in a local instance of the application.

# 4. Session Info

```
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.2 (2025-10-31)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2026-01-26
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package         * version    date (UTC) lib source
#>  arrow             23.0.0     2026-01-23 [2] CRAN (R 4.5.2)
#>  assertthat        0.2.1      2019-03-21 [2] CRAN (R 4.5.2)
#>  backports         1.5.0      2024-05-23 [2] CRAN (R 4.5.2)
#>  base64enc         0.1-3      2015-07-28 [2] CRAN (R 4.5.2)
#>  base64url         1.4        2018-05-14 [2] CRAN (R 4.5.2)
#>  BiocGenerics      0.56.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  BiocParallel      1.44.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  Biostrings        2.78.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  bit               4.6.0      2025-03-06 [2] CRAN (R 4.5.2)
#>  bit64             4.6.0-1    2025-01-16 [2] CRAN (R 4.5.2)
#>  bitops            1.0-9      2024-10-03 [2] CRAN (R 4.5.2)
#>  boot              1.3-32     2025-08-29 [3] CRAN (R 4.5.2)
#>  brio              1.1.5      2024-04-24 [2] CRAN (R 4.5.2)
#>  bslib             0.10.0     2026-01-26 [2] CRAN (R 4.5.2)
#>  cachem            1.1.0      2024-05-16 [2] CRAN (R 4.5.2)
#>  caTools           1.18.3     2024-09-04 [2] CRAN (R 4.5.2)
#>  cellranger        1.1.0      2016-07-27 [2] CRAN (R 4.5.2)
#>  checkmate         2.3.3      2025-08-18 [2] CRAN (R 4.5.2)
#>  cli               3.6.5      2025-04-23 [2] CRAN (R 4.5.2)
#>  cluster           2.1.8.1    2025-03-12 [3] CRAN (R 4.5.2)
#>  codetools         0.2-20     2024-03-31 [3] CRAN (R 4.5.2)
#>  colorspace        2.1-2      2025-09-22 [2] CRAN (R 4.5.2)
#>  crayon            1.5.3      2024-06-20 [2] CRAN (R 4.5.2)
#>  data.table        1.18.0     2025-12-24 [2] CRAN (R 4.5.2)
#>  dichromat         2.0-0.1    2022-05-02 [2] CRAN (R 4.5.2)
#>  digest            0.6.39     2025-11-19 [2] CRAN (R 4.5.2)
#>  dplyr             1.1.4      2023-11-17 [2] CRAN (R 4.5.2)
#>  DT                0.34.0     2025-09-02 [2] CRAN (R 4.5.2)
#>  evaluate          1.0.5      2025-08-27 [2] CRAN (R 4.5.2)
#>  farver            2.1.2      2024-05-13 [2] CRAN (R 4.5.2)
#>  fastmap           1.2.0      2024-05-15 [2] CRAN (R 4.5.2)
#>  foreign           0.8-90     2025-03-31 [3] CRAN (R 4.5.2)
#>  Formula           1.2-5      2023-02-24 [2] CRAN (R 4.5.2)
#>  fs                1.6.6      2025-04-12 [2] CRAN (R 4.5.2)
#>  generics          0.1.4      2025-05-09 [2] CRAN (R 4.5.2)
#>  ggplot2           4.0.1      2025-11-14 [2] CRAN (R 4.5.2)
#>  ggrepel           0.9.6      2024-09-07 [2] CRAN (R 4.5.2)
#>  glue              1.8.0      2024-09-30 [2] CRAN (R 4.5.2)
#>  gplots            3.3.0      2025-11-30 [2] CRAN (R 4.5.2)
#>  graph             1.88.1     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  gridExtra         2.3        2017-09-09 [2] CRAN (R 4.5.2)
#>  gtable            0.3.6      2024-10-25 [2] CRAN (R 4.5.2)
#>  gtools            3.9.5      2023-11-20 [2] CRAN (R 4.5.2)
#>  Hmisc             5.2-5      2026-01-09 [2] CRAN (R 4.5.2)
#>  htmlTable         2.4.3      2024-07-21 [2] CRAN (R 4.5.2)
#>  htmltools         0.5.9      2025-12-04 [2] CRAN (R 4.5.2)
#>  htmlwidgets       1.6.4      2023-12-06 [2] CRAN (R 4.5.2)
#>  httpuv            1.6.16     2025-04-16 [2] CRAN (R 4.5.2)
#>  httr              1.4.7      2023-08-15 [2] CRAN (R 4.5.2)
#>  IRanges           2.44.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  IRdisplay         1.1        2022-01-04 [2] CRAN (R 4.5.2)
#>  IRkernel          1.3.2      2023-01-20 [2] CRAN (R 4.5.2)
#>  jquerylib         0.1.4      2021-04-26 [2] CRAN (R 4.5.2)
#>  jsonlite          2.0.0      2025-03-27 [2] CRAN (R 4.5.2)
#>  KernSmooth        2.23-26    2025-01-01 [3] CRAN (R 4.5.2)
#>  knitr             1.51       2025-12-20 [2] CRAN (R 4.5.2)
#>  later             1.4.5      2026-01-08 [2] CRAN (R 4.5.2)
#>  lattice           0.22-7     2025-04-02 [3] CRAN (R 4.5.2)
#>  lazyeval          0.2.2      2019-03-15 [2] CRAN (R 4.5.2)
#>  lifecycle         1.0.5      2026-01-08 [2] CRAN (R 4.5.2)
#>  limma             3.66.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  lme4              1.1-38     2025-12-02 [2] CRAN (R 4.5.2)
#>  lmerTest          3.2-0      2026-01-13 [2] CRAN (R 4.5.2)
#>  log4r             0.4.4      2024-10-12 [2] CRAN (R 4.5.2)
#>  magrittr          2.0.4      2025-09-12 [2] CRAN (R 4.5.2)
#>  marray            1.88.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MASS              7.3-65     2025-02-28 [3] CRAN (R 4.5.2)
#>  Matrix            1.7-4      2025-08-28 [3] CRAN (R 4.5.2)
#>  mime              0.13       2025-03-17 [2] CRAN (R 4.5.2)
#>  minqa             1.2.8      2024-08-17 [2] CRAN (R 4.5.2)
#>  mockery           0.4.5      2025-09-04 [2] CRAN (R 4.5.2)
#>  MSstats           4.18.1     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsBioNet     1.2.0      2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsConvert    1.20.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsPTM        2.12.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsResponse   1.0.0      2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsShiny    * 1.12.1     2026-01-26 [1] Bioconductor 3.22 (R 4.5.2)
#>  MSstatsTMT        2.18.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  nlme              3.1-168    2025-03-31 [3] CRAN (R 4.5.2)
#>  nloptr            2.2.1      2025-03-17 [2] CRAN (R 4.5.2)
#>  nnet              7.3-20     2025-01-01 [3] CRAN (R 4.5.2)
#>  numDeriv          2016.8-1.1 2019-06-06 [2] CRAN (R 4.5.2)
#>  otel              0.2.0      2025-08-29 [2] CRAN (R 4.5.2)
#>  pbdZMQ            0.3-14     2025-04-13 [2] CRAN (R 4.5.2)
#>  pillar            1.11.1     2025-09-17 [2] CRAN (R 4.5.2)
#>  pkgconfig         2.0.3      2019-09-22 [2] CRAN (R 4.5.2)
#>  plotly            4.12.0     2026-01-24 [2] CRAN (R 4.5.2)
#>  preprocessCore    1.72.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  promises          1.5.0      2025-11-01 [2] CRAN (R 4.5.2)
#>  purrr             1.2.1      2026-01-09 [2] CRAN (R 4.5.2)
#>  r2r               0.1.2      2024-11-09 [2] CRAN (R 4.5.2)
#>  R6                2.6.1      2025-02-15 [2] CRAN (R 4.5.2)
#>  rbibutils         2.4.1      2026-01-21 [2] CRAN (R 4.5.2)
#>  RColorBrewer      1.1-3      2022-04-03 [2] CRAN (R 4.5.2)
#>  Rcpp              1.1.1      2026-01-10 [2] CRAN (R 4.5.2)
#>  RCurl             1.98-1.17  2025-03-22 [2] CRAN (R 4.5.2)
#>  RCy3              2.30.1     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  Rdpack            2.6.5      2026-01-23 [2] CRAN (R 4.5.2)
#>  readxl            1.4.5      2025-03-07 [2] CRAN (R 4.5.2)
#>  reformulas        0.4.3.1    2026-01-08 [2] CRAN (R 4.5.2)
#>  repr              1.1.7      2024-03-22 [2] CRAN (R 4.5.2)
#>  RJSONIO           2.0.0      2025-04-05 [2] CRAN (R 4.5.2)
#>  rlang             1.1.7      2026-01-09 [2] CRAN (R 4.5.2)
#>  rmarkdown         2.30       2025-09-28 [2] CRAN (R 4.5.2)
#>  rpart             4.1.24     2025-01-07 [3] CRAN (R 4.5.2)
#>  rstudioapi        0.18.0     2026-01-16 [2] CRAN (R 4.5.2)
#>  S4Vectors         0.48.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  S7                0.2.1      2025-11-14 [2] CRAN (R 4.5.2)
#>  sass              0.4.10     2025-04-11 [2] CRAN (R 4.5.2)
#>  scales            1.4.0      2025-04-24 [2] CRAN (R 4.5.2)
#>  Seqinfo           1.0.0      2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  sessioninfo       1.2.3      2025-02-05 [2] CRAN (R 4.5.2)
#>  shiny             1.12.1     2025-12-09 [2] CRAN (R 4.5.2)
#>  shinyBS           0.63.0     2025-12-17 [2] CRAN (R 4.5.2)
#>  shinybusy         0.3.3      2024-03-09 [2] CRAN (R 4.5.2)
#>  shinydashboard    0.7.3      2025-04-21 [2] CRAN (R 4.5.2)
#>  shinyjs           2.1.1      2026-01-15 [2] CRAN (R 4.5.2)
#>  statmod           1.5.1      2025-10-09 [2] CRAN (R 4.5.2)
#>  stringi           1.8.7      2025-03-27 [2] CRAN (R 4.5.2)
#>  stringr           1.6.0      2025-11-04 [2] CRAN (R 4.5.2)
#>  survival          3.8-6      2026-01-16 [3] CRAN (R 4.5.2)
#>  testthat          3.3.2      2026-01-11 [2] CRAN (R 4.5.2)
#>  tibble            3.3.1      2026-01-11 [2] CRAN (R 4.5.2)
#>  tidyr             1.3.2      2025-12-19 [2] CRAN (R 4.5.2)
#>  tidyselect        1.2.1      2024-03-11 [2] CRAN (R 4.5.2)
#>  uuid              1.2-2      2026-01-23 [2] CRAN (R 4.5.2)
#>  vctrs             0.7.1      2026-01-23 [2] CRAN (R 4.5.2)
#>  viridisLite       0.4.2      2023-05-02 [2] CRAN (R 4.5.2)
#>  xfun              0.56       2026-01-18 [2] CRAN (R 4.5.2)
#>  XML               3.99-0.20  2025-11-08 [2] CRAN (R 4.5.2)
#>  xtable            1.8-4      2019-04-21 [2] CRAN (R 4.5.2)
#>  XVector           0.50.0     2026-01-26 [2] Bioconductor 3.22 (R 4.5.2)
#>  yaml              2.3.12     2025-12-10 [2] CRAN (R 4.5.2)
#>
#>  [1] /tmp/RtmpNVdpo6/Rinst39e238178c092d
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```