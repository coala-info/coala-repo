Code

* Show All Code
* Hide All Code

# Rounding numeric values

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEde 1.8.0

# 1 Example data

In this example, we use the `?airway` data set.

We briefly adjust the reference level of the treatment factor to the untreated condition.

```
library("airway")
data("airway")
airway$dex <- relevel(airway$dex, "untrt")
```

# 2 Differential expression

To generate some example results, we run a standard *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* analysis using `glmFit()` and
`glmLRT()`.

The differential expression results are fetched using `topTags()`.

```
library("edgeR")

design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

fit <- glmFit(airway, design, dispersion = 0.1)
lrt <- glmLRT(fit, contrast = c(-1, 1, 0, 0, 0))
res_edger <- topTags(lrt, n = Inf)
head(res_edger)
#> Coefficient:  -1*dexuntrt 1*dextrt
#>                         gene_id     gene_name entrezid         gene_biotype gene_seq_start
#> ENSG00000109906 ENSG00000109906        ZBTB16       NA       protein_coding      113930315
#> ENSG00000179593 ENSG00000179593       ALOX15B       NA       protein_coding        7942335
#> ENSG00000127954 ENSG00000127954        STEAP4       NA       protein_coding       87905744
#> ENSG00000152583 ENSG00000152583       SPARCL1       NA       protein_coding       88394487
#> ENSG00000250978 ENSG00000250978 RP11-357D18.1       NA processed_transcript       66759637
#> ENSG00000163884 ENSG00000163884         KLF15       NA       protein_coding      126061478
#>                 gene_seq_end seq_name seq_strand seq_coord_system        symbol     logFC   logCPM
#> ENSG00000109906    114121398       11          1               NA        ZBTB16  7.183385 4.132638
#> ENSG00000179593      7952452       17          1               NA       ALOX15B 10.015847 1.627629
#> ENSG00000127954     87936206        7         -1               NA        STEAP4  5.087069 3.672567
#> ENSG00000152583     88452213        4         -1               NA       SPARCL1  4.498698 5.510213
#> ENSG00000250978     66771420        5         -1               NA RP11-357D18.1  6.128131 1.377260
#> ENSG00000163884    126076285        3         -1               NA         KLF15  4.367962 4.681216
#>                       LR       PValue          FDR
#> ENSG00000109906 238.3947 8.805179e-54 5.606874e-49
#> ENSG00000179593 181.0331 2.883024e-41 9.179116e-37
#> ENSG00000127954 146.9725 7.957020e-34 1.688931e-29
#> ENSG00000152583 140.2205 2.382274e-32 3.792402e-28
#> ENSG00000250978 137.4681 9.526183e-32 1.213198e-27
#> ENSG00000163884 129.2203 6.069471e-30 6.441428e-26
```

Then, we embed this set of differential expression results in the `airway`
object using the `embedContrastResults()` method.

The results embedded in the airway object can be accessed using the `contrastResults()` function.

```
library(iSEEde)
airway <- embedContrastResults(res_edger, airway, name = "edgeR")
contrastResults(airway)
#> DataFrame with 63677 rows and 1 column
#>                              edgeR
#>                 <iSEEedgeRResults>
#> ENSG00000000003 <iSEEedgeRResults>
#> ENSG00000000005 <iSEEedgeRResults>
#> ENSG00000000419 <iSEEedgeRResults>
#> ENSG00000000457 <iSEEedgeRResults>
#> ENSG00000000460 <iSEEedgeRResults>
#> ...                            ...
#> ENSG00000273489 <iSEEedgeRResults>
#> ENSG00000273490 <iSEEedgeRResults>
#> ENSG00000273491 <iSEEedgeRResults>
#> ENSG00000273492 <iSEEedgeRResults>
#> ENSG00000273493 <iSEEedgeRResults>
contrastResults(airway, "edgeR")
#> iSEEedgeRResults with 63677 rows and 5 columns
#>                      logFC    logCPM        LR    PValue       FDR
#>                  <numeric> <numeric> <numeric> <numeric> <numeric>
#> ENSG00000000003 -0.4628153   5.05930  2.018481  0.155394         1
#> ENSG00000000005  0.0000000  -3.45546  0.000000  1.000000         1
#> ENSG00000000419  0.1247724   4.60783  0.146545  0.701860         1
#> ENSG00000000457 -0.0445216   3.48326  0.018241  0.892565         1
#> ENSG00000000460 -0.1618126   1.48518  0.210342  0.646500         1
#> ...                    ...       ...       ...       ...       ...
#> ENSG00000273489    2.48209  -3.28549   3.02143  0.082171         1
#> ENSG00000273490    0.00000  -3.45546   0.00000  1.000000         1
#> ENSG00000273491    0.00000  -3.45546   0.00000  1.000000         1
#> ENSG00000273492   -1.24012  -3.36894   0.91097  0.339857         1
#> ENSG00000273493   -1.75243  -3.36862   1.57193  0.209928         1
```

# 3 Set a default rounding configuration

Differential expression methods generally return precise numeric values with several digits after the decimal point.
This level of precision can be unnecessarily overwhelming and users may wish to round numeric values to a limited number of significant digits.

The builtin default configuration for rounding in *[iSEEde](https://bioconductor.org/packages/3.22/iSEEde)* is `RoundDigit = FALSE` and `SignifDigits = 3`.
In other words, numeric values are not rounded, and if users do activate the rounding functionality, numeric values are rounded to three significant digits.

Those defaults can be changed using the `panelDefaults()` function.

```
panelDefaults(RoundDigits = TRUE, SignifDigits = 2L)
```

With the default panel settings configured, we use the `DETable()` function to display the contrast results with rounded numeric values.

```
library(iSEE)
app <- iSEE(airway, initial = list(
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}
```

![](data:image/png;base64...)

# 4 Configuring rounding in individual panels

The default rounding configuration can be overridden in individual panel configurations.

The slots `RoundDigits` and `SignifDigits` can be set directly in the individual calls to the `DETable()` constructor function.

In the example below, we add two tables, one rounding numeric values to the default value of two significant digits set above, the other rounding the same values to three significant digits.

```
library(iSEE)
app <- iSEE(airway, initial = list(
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 6L, RoundDigits = TRUE),
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", "LR"),
          PanelWidth = 6L, RoundDigits = TRUE, SignifDigits = 3L)
))

if (interactive()) {
  shiny::runApp(app)
}
```

![](data:image/png;base64...)

# 5 Reproducibility

The *[iSEEde](https://bioconductor.org/packages/3.22/iSEEde)* package (Rue-Albrecht, 2025) was made possible
thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight et al., 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("rounding.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("rounding.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:39:37 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 4.515 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version  date (UTC) lib source
#>  abind                  1.4-8    2024-09-12 [2] CRAN (R 4.5.1)
#>  airway               * 1.29.0   2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationDbi        * 1.72.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0    2024-05-23 [2] CRAN (R 4.5.1)
#>  beachmat               2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bibtex                 0.5.1    2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26  2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0    2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1  2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4    2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45     2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  circlize               0.4.16   2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66   2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1  2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2    2025-09-22 [2] CRAN (R 4.5.1)
#>  colourpicker           1.3.0    2023-08-21 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  crayon                 1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3    2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DESeq2               * 1.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17   2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0   2025-09-02 [2] CRAN (R 4.5.1)
#>  edgeR                * 4.8.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  fontawesome            0.5.3    2024-11-16 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2    2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5    2020-12-15 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6    2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2    2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4    2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16   2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7    2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEE                 * 2.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEEde               * 1.8.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14   2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50     2025-03-16 [2] CRAN (R 4.5.1)
#>  later                  1.4.4    2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                * 3.66.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  listviewer             4.0.0    2023-09-30 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12 2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4    2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0    2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1    2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                   1.9-3    2025-04-04 [3] CRAN (R 4.5.1)
#>  mime                   0.13     2025-03-17 [2] CRAN (R 4.5.1)
#>  miniUI                 0.1.2    2025-04-17 [2] CRAN (R 4.5.1)
#>  nlme                   3.1-168  2025-03-31 [3] CRAN (R 4.5.1)
#>  org.Hs.eg.db         * 3.22.0   2025-10-08 [2] Bioconductor
#>  otel                   0.2.0    2025-08-29 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9    2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8    2022-11-29 [2] CRAN (R 4.5.1)
#>  promises               1.4.0    2025-10-22 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0    2022-09-30 [2] CRAN (R 4.5.1)
#>  rintrojs               0.3.4    2024-01-11 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23   2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30     2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3    2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
#>  scuttle              * 1.20.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1  2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1   2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyAce               0.4.4    2025-02-03 [2] CRAN (R 4.5.1)
#>  shinydashboard         0.7.3    2025-04-21 [2] CRAN (R 4.5.1)
#>  shinyjs                2.1.0    2021-12-23 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0    2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1    2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7    2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2    2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0    2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7    2023-12-18 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2    2023-05-02 [2] CRAN (R 4.5.1)
#>  xfun                   0.53     2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4    2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmppPdLow/Rinst11d9906f7587f2
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* `r Citep(bib[["BiocStyle"]])` with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the
scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[4]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[5]](#cite-ruealbrecht2025iseede)
K. Rue-Albrecht.
*iSEEde: iSEE extension for panels related to differential expression analysis*.
R package version 1.8.0.
2025.
DOI: [10.18129/B9.bioc.iSEEde](https://doi.org/10.18129/B9.bioc.iSEEde).
URL: <https://bioconductor.org/packages/iSEEde>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.