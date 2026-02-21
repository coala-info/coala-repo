Code

* Show All Code
* Hide All Code

# Introduction

Pau Badia-i-Mompel1 and Jesús Vélez-Santiago2

1Heidelberg Universiy
2National Autonomous University of Mexico

#### 29 October 2025

#### Package

decoupleR 2.16.0

# 1 Installation

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* is an R package distributed as part of the Bioconductor
project. To install the package, start R and enter:

```
install.packages("BiocManager")
BiocManager::install("decoupleR")
```

Alternatively, you can instead install the latest development version from [GitHub](https://github.com/) with:

```
BiocManager::install("saezlab/decoupleR")
```

# 2 Usage

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* (Badia-i-Mompel, Santiago, Braunger, Geiss, Dimitrov, Müller-Dott, Taus, Dugourd, Holland, Flores, and Saez-Rodriguez, 2022) contains different
statistical methods to extract biological activities from omics data using prior
knowledge. Some of them are:

* AUCell: (Aibar, Bravo Gonzalez-Blas, Moerman, Huynh-Thu, Imrichova, Hulselmans, Rambow, Marine, Geurts, Aerts, van den Oord, Kalender Atak, Wouters, and Aerts, 2017)
* Fast GSEA: (Korotkevich, Sukhov, and Sergushichev, 2019)
* GSVA: (H{ä}nzelmann, Castelo, and Guinney, 2013)
* viper: (Alvarez, Shen, Giorgi, Lachmann, Ding, Ye, and Califano, 2016)

In this vignette we showcase how to use it with some toy data.

## 2.1 Libraries

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* can be imported as:

```
library(decoupleR)

# Extra libraries
library(dplyr)
library(pheatmap)
```

## 2.2 Input data

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* needs a matrix (`mat`) of any molecular readouts (gene
expression, logFC, p-values, etc.) and a `network` that relates target
features (genes, proteins, etc.) to “source” biological entities (pathways,
transcription factors, molecular processes, etc.). Some methods also require
the mode of regulation (MoR) for each interaction, defined as negative or
positive weights.

To get an example data-set, run:

```
data <- get_toy_data()

mat <- data$mat
head(mat,5)[,1:5]
#>           S01       S02       S03        S04      S05
#> G01 9.3709584 9.3888607 9.8951935  8.7844590 8.431446
#> G02 8.5646982 8.2787888 8.4304691  8.8509076 8.655648
#> G03 8.3631284 8.1333213 8.2572694 10.4142076 8.321925
#> G04 8.6328626 8.6359504 9.7631631  8.0361226 8.783839
#> G05 0.4042683 0.2842529 0.4600974  0.2059986 1.575728

network <- data$network
network
#> # A tibble: 10 × 3
#>    source target   mor
#>    <chr>  <chr>  <dbl>
#>  1 T1     G01      1
#>  2 T1     G02      1
#>  3 T1     G03      0.7
#>  4 T2     G06      1
#>  5 T2     G07      0.5
#>  6 T2     G08      1
#>  7 T3     G06     -0.5
#>  8 T3     G07     -3
#>  9 T3     G08     -1
#> 10 T3     G11      1
```

This example consists of two small populations of samples (S, cols) with
different gene expression patterns (G, rows):

```
pheatmap(mat, cluster_rows = F, cluster_cols = F)
```

![](data:image/png;base64...)

Here we can see that some genes seem to be more expressed in one group of
samples than in the other and vice-versa. Ideally, we would like to capture
these differences in gene programs into interpretable biological entities.
In this example we will do it by summarizing gene expression into transcription
factor activities.

The toy data also contains a simple net consisting of 3 transcription factors
(Ts) with specific regulation to target genes (either positive or negative).
This network can be visualized like a graph. Green edges are positive regulation
(activation), red edges are negative regulation (inactivation):

![](data:image/png;base64...)

According to this network, the first population of samples should show high
activity for T1 and T3, while the second one only for T2.

## 2.3 Methods

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* contains several methods. To check how many are
available, run:

```
show_methods()
#> # A tibble: 12 × 2
#>    Function      Name
#>    <chr>         <chr>
#>  1 run_aucell    AUCell
#>  2 run_consensus Consensus score between methods
#>  3 run_fgsea     Fast Gene Set Enrichment Analysis (FGSEA)
#>  4 run_gsva      Gene Set Variation Analysis (GSVA)
#>  5 run_mdt       Multivariate Decision Trees (MDT)
#>  6 run_mlm       Multivariate Linear Model (MLM)
#>  7 run_ora       Over Representation Analysis (ORA)
#>  8 run_udt       Univariate Decision Tree (UDT)
#>  9 run_ulm       Univariate Linear Model (ULM)
#> 10 run_viper     Virtual Inference of Protein-activity by Enriched Regulon anal…
#> 11 run_wmean     Weighted Mean (WMEAN)
#> 12 run_wsum      Weighted Sum (WSUM)
```

Each method models biological activities in a different manner, sometimes
returning more than one estimate or providing significance of the estimation.
To know what each method returns, please check their documentation like this
`?run_mlm`.

To have a unified framework, methods have these shared arguments:

* `mat` : input matrix of molecular readouts.
* `network` : input prior knowledge information relating molecular features to
  biological entities.
* `.source`,`.target` and `.mor` : column names where to extract the information
  from `network`.
  + `.source` refers to the biological entities.
  + `.target` refers to the molecular features.
  + `.mor` refers to the “strength” of the interaction (if available, else 1s
    will be used). Only available for methods that can model interaction weights.
* `minsize` : Minimum of target features per biological entity (5 by default).
  If less, sources are removed. This filtering prevents obtaining noisy activities
  from biological entities with very few matching target features in `matrix`. For
  this example data-set we will have to keep it to 0 though.

## 2.4 Running methods

### 2.4.1 Individual methods

As an example, let’s first run the Gene Set Enrichment Analysis method (`gsea`),
one of the most well-known statistics:

```
res_gsea <- run_fgsea(mat, network, .source='source', .target='target', nproc=1, minsize = 0)
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
#>
#>
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
res_gsea
#> # A tibble: 144 × 5
#>    statistic  source condition   score p_value
#>    <chr>      <chr>  <chr>       <dbl>   <dbl>
#>  1 fgsea      T1     S01         0.889  0.0755
#>  2 norm_fgsea T1     S01         1.24   0.0755
#>  3 fgsea      T2     S01        -0.667  0.548
#>  4 norm_fgsea T2     S01        -1.11   0.548
#>  5 fgsea      T3     S01        -0.75   0.01
#>  6 norm_fgsea T3     S01       Inf      0.01
#>  7 fgsea      T1     S02         0.889  0.0764
#>  8 norm_fgsea T1     S02         1.29   0.0764
#>  9 fgsea      T2     S02         0      0.977
#> 10 norm_fgsea T2     S02         0      0.977
#> # ℹ 134 more rows
```

Methods return a result data-frame containing:

* `statistic`: name of the statistic. Depending on the method, there can be more than one per method.
* `source`: name of the biological entity.
* `condition`: sample name.
* `score`: inferred biological activity.
* `p_value`: if available, significance of the inferred activity.

In the case of `gsea`, it returns a simple estimate of activities (`fgsea`),
a normalized estimate (`norm_fgsea`) and p-values after doing permutations.

Other methods can return different things, for example Univariate Linear Model
(`ulm`):

```
res_ulm <- run_ulm(mat, network, .source='source', .target='target', .mor='mor', minsize = 0)
res_ulm
#> # A tibble: 72 × 5
#>    statistic source condition score  p_value
#>    <chr>     <chr>  <chr>     <dbl>    <dbl>
#>  1 ulm       T1     S01        4.21 0.00180
#>  2 ulm       T1     S02        4.07 0.00224
#>  3 ulm       T1     S03        3.85 0.00319
#>  4 ulm       T1     S04        4.60 0.000979
#>  5 ulm       T1     S05        3.90 0.00298
#>  6 ulm       T1     S06        3.66 0.00442
#>  7 ulm       T1     S07        4.31 0.00153
#>  8 ulm       T1     S08        4.65 0.000902
#>  9 ulm       T1     S09        4.49 0.00117
#> 10 ulm       T1     S10        4.07 0.00225
#> # ℹ 62 more rows
```

In this case, `ulm` returns just an estimate (`ulm`) and its associated p-values.
Each method can return different statistics, we recommend to check their
documentation to know more about them.

Let us plot the obtained results, first for `gsea`:

```
# Transform to matrix
mat_gsea <- res_gsea %>%
  filter(statistic=='fgsea') %>%
  pivot_wider_profile(id_cols = source, names_from = condition,
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_gsea, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)
```

![](data:image/png;base64...)

We can observe that for transcription factors T1 and T2, the obtained activities
correctly distinguish the two sample populations. T3, on the other hand, should
be down for the second population of samples since it is a repressor.
This mislabeling of activities happens because `gsea` cannot model weights when
inferring biological activities.

When weights are available in the prior knowledge, we definitely recommend using
any of the methods that take them into account to get better estimates,
one example is `ulm`:

```
# Transform to matrix
mat_ulm <- res_ulm %>%
  filter(statistic=='ulm') %>%
  pivot_wider_profile(id_cols = source, names_from = condition,
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_ulm, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)
```

![](data:image/png;base64...)

Since `ulm` models weights when estimating biological activities, it correctly
assigns T3 as inactive in the second population of samples.

### 2.4.2 Multiple methods

*[decoupleR](https://bioconductor.org/packages/3.22/decoupleR)* also allows to run multiple methods at the same time.
Moreover, it computes a consensus score based on the obtained activities across
methods, called `consensus`.

By default, `deocuple` runs only the top performer methods in our benchmark (`mlm`,
`ulm` and `wsum`), and estimates a consensus score across them. Specific
arguments to specific methods can be passed using the variable `args`. For more
information check `?decouple`.

```
res_decouple <- decouple(mat,
                         network,
                         .source='source',
                         .target='target',
                         minsize = 0)
res_decouple
#> # A tibble: 432 × 6
#>    run_id statistic source condition   score p_value
#>     <dbl> <chr>     <chr>  <chr>       <dbl>   <dbl>
#>  1      1 mlm       T1     S01        3.52   0.00781
#>  2      1 mlm       T2     S01       -1.13   0.290
#>  3      1 mlm       T3     S01       -0.247  0.811
#>  4      1 mlm       T1     S02        3.48   0.00831
#>  5      1 mlm       T2     S02       -0.213  0.837
#>  6      1 mlm       T3     S02       -0.353  0.733
#>  7      1 mlm       T1     S03        3.15   0.0135
#>  8      1 mlm       T2     S03       -0.638  0.541
#>  9      1 mlm       T3     S03        0.0749 0.942
#> 10      1 mlm       T1     S04        3.82   0.00512
#> # ℹ 422 more rows
```

Let us see the result for the consensus score in the previous `decouple` run:

```
# Transform to matrix
mat_consensus <- res_decouple %>%
  filter(statistic=='consensus') %>%
  pivot_wider_profile(id_cols = source, names_from = condition,
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_consensus, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)
```

![](data:image/png;base64...)

We can observe that the consensus score correctly predicts that T1 and T3 should
be active in the first population of samples while T2 in the second one.

# 3 Session information

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
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package      * version date (UTC) lib source
#>  backports      1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex         0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager    1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel   1.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle    * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown       0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib          0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem         1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli            3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools      0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  cowplot        1.2.0   2025-07-07 [2] CRAN (R 4.5.1)
#>  data.table     1.17.8  2025-07-10 [2] CRAN (R 4.5.1)
#>  decoupleR    * 2.16.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  dichromat      2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest         0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr        * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate       1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver         2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap        1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch      1.1-6   2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea          1.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  generics       0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  ggplot2        4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  glue           1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable         0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools      0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr           1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  jquerylib      0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite       2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr          1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice        0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle      1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate      1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magick         2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr       2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix         1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  parallelly     1.45.1  2025-07-24 [2] CRAN (R 4.5.1)
#>  pheatmap     * 1.0.13  2025-06-05 [2] CRAN (R 4.5.1)
#>  pillar         1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig      2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr           1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  purrr          1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6             2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer   1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp           1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR   * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang          1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown      2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S7             0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass           0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales         1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  sessioninfo    1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi        1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr        1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  tibble         3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr          1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect     1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange     0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex        0.57    2025-04-15 [2] CRAN (R 4.5.1)
#>  utf8           1.2.6   2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs          0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr          3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun           0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2           1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  yaml           2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpwS46co/Rinst3e53b4d0d164d
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

[[1]](#cite-aibar2017scenic)
S. Aibar, C. Bravo Gonzalez-Blas, T. Moerman, et al.
“SCENIC: Single-Cell Regulatory Network Inference And Clustering”.
In: *Nature Methods* 14 (2017), pp. 1083-1086.
DOI: [10.1038/nmeth.4463](https://doi.org/10.1038/nmeth.4463).

[[2]](#cite-alvarez2016functional)
M. J. Alvarez, Y. Shen, F. M. Giorgi, et al.
“Functional characterization of somatic mutations in cancer using network-based inference of protein activity”.
In: *Nature genetics* 48.8 (2016), pp. 838–47.

[[3]](#cite-badiaimompel2022decoupler)
P. Badia-i-Mompel, J. V. Santiago, J. Braunger, et al.
“decoupleR: ensemble of computational methods to infer biological activities from omics data”.
In: *Bioinformatics Advances* (2022).
DOI: [https://doi.org/10.1093/bioadv/vbac016](https://doi.org/https%3A//doi.org/10.1093/bioadv/vbac016).

[[4]](#cite-hanzelmann2013gsva)
S. Hänzelmann, R. Castelo, and J. Guinney.
“GSVA: gene set variation analysis for microarray and RNA-Seq data”.
In: *BMC Bioinformatics* 14 (2013), p. 7.
DOI: [10.1186/1471-2105-14-7](https://doi.org/10.1186/1471-2105-14-7).
URL: <https://doi.org/10.1186/1471-2105-14-7>.

[[5]](#cite-korotkevich2019fast)
G. Korotkevich, V. Sukhov, and A. Sergushichev.
“Fast gene set enrichment analysis”.
In: *bioRxiv* (2019).
DOI: [10.1101/060012](https://doi.org/10.1101/060012).
URL: <http://biorxiv.org/content/early/2016/06/20/060012>.