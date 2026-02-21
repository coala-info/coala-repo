# enterotyping

A workflow for identifying enterotypes based on the relative abundance of gut microbiota was implemented refereed on the reports of Arumugam[^2]

```
library(mbOmic)
library(data.table)
```

First of all, the dataset of microbiota relative abundance was retrived from the [enterotypes weblink](http://enterotypes.org/ref_samples_abundance_MetaHIT.txt). The missing value was imputed using **KNN** by `impute` package.

```
dat <- read.delim('http://enterotypes.org/ref_samples_abundance_MetaHIT.txt')
dat <- impute::impute.knn(as.matrix(dat), k = 100)
dat <- as.data.frame(dat$data+0.001)
setDT(dat, keep.rownames = TRUE)
dat
```

Constructe the `bSet` class and then estimate the the proper cluster number using the `estimate_k` function. The `estimate_k` function take advantage of `Jensen-Shannon divergence` to cluster the samples and the number of clusters was optimizated by Calinski-Harabasz (CH) Index and Silhouette Coefficient.

The `estimate_k` returns `verCHI` class, a `S3` class containing a optimal cluster results, optimal number cluster, a minmum CHI, a minmum Silhouette value, and Jensen-Shannon divergence matrix.

```
dat <- bSet(b =  dat)
res <- estimate_k(dat)
res
#> optimal number of cluster: 4
#> Max CHI: 164.642158008611
#> Silhouette: 0.181445495999067
```

![](data:image/png;base64...)

The proper number of cluster is 4.

Next, the `enterotyping` function was used to identify the enterotype for each cluster and it returns a 3-length list. This list contains two enterotypes matrices and a unidentified samples vector. Cluster 2, 3, and 4 was enterotype Bacteroides, Prevotella, and Ruminococcus, resepectively.

```
ret=enterotyping(dat, res$verOptCluster)
ret
#> $enterotypes
#>      Enterotype        max which   cluster
#> 1:  Bacteroides 0.36724946     2 cluster 2
#> 2:   Prevotella 0.29692944     3 cluster 3
#> 3: Ruminococcus 0.02416713     4 cluster 4
#>
#> $data
#>      Samples   Enterotype   cluster
#>   1:  MH0087  Bacteroides cluster 2
#>   2:  MH0156  Bacteroides cluster 2
#>   3:  MH0444  Bacteroides cluster 2
#>   4:  MH0333  Bacteroides cluster 2
#>   5:  MH0233  Bacteroides cluster 2
#>  ---
#> 234:  MH0012 Ruminococcus cluster 4
#> 235:  MH0415 Ruminococcus cluster 4
#> 236:  MH0457 Ruminococcus cluster 4
#> 237:  MH0442 Ruminococcus cluster 4
#> 238:  MH0448 Ruminococcus cluster 4
#>
#> $UnIdentifiedSamples
#>  [1] "MH0277" "MH0161" "MH0046" "MH0175" "MH0152" "MH0104" "MH0151" "MH0189"
#>  [9] "MH0030" "MH0157" "MH0063" "MH0075" "MH0141" "MH0169" "MH0050" "MH0286"
#> [17] "MH0096" "MH0053" "MH0217" "MH0098" "MH0009" "MH0197" "MH0065" "MH0173"
#> [25] "MH0168" "MH0070" "MH0077" "MH0288" "MH0200" "MH0031" "MH0183" "MH0132"
#> [33] "MH0144" "MH0124" "MH0430" "MH0276" "MH0407" "MH0428" "MH0126" "MH0447"
```

Furthermore, this result was validated by enterotypes results given by the [enterotype website](http://enterotypes.org).

```
enterotypes <- read.table(system.file('extdata', 'enterotype.txt', package = 'mbOmic'))
enterotypes <- enterotypes[samples(dat),]
table(res$verOptCluster, enterotypes$ET)
#>
#>     ET_B ET_F ET_P
#>   1    0   21   19
#>   2   67    5    0
#>   3    0    0   40
#>   4    3  123    0
```

## SessionInfo

```
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.2.1 (2022-06-23)
#>  os       Ubuntu 20.04.5 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2022-11-01
#>  pandoc   2.5 @ /usr/bin/ (via rmarkdown)
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package          * version  date (UTC) lib source
#>  ade4               1.7-19   2022-04-19 [2] CRAN (R 4.2.1)
#>  AnnotationDbi      1.60.0   2022-11-01 [2] Bioconductor
#>  assertthat         0.2.1    2019-03-21 [2] CRAN (R 4.2.1)
#>  backports          1.4.1    2021-12-13 [2] CRAN (R 4.2.1)
#>  base64enc          0.1-3    2015-07-28 [2] CRAN (R 4.2.1)
#>  Biobase            2.58.0   2022-11-01 [2] Bioconductor
#>  BiocGenerics       0.44.0   2022-11-01 [2] Bioconductor
#>  Biostrings         2.66.0   2022-11-01 [2] Bioconductor
#>  bit                4.0.4    2020-08-04 [2] CRAN (R 4.2.1)
#>  bit64              4.0.5    2020-08-30 [2] CRAN (R 4.2.1)
#>  bitops             1.0-7    2021-04-24 [2] CRAN (R 4.2.1)
#>  blob               1.2.3    2022-04-10 [2] CRAN (R 4.2.1)
#>  bslib              0.4.0    2022-07-16 [2] CRAN (R 4.2.1)
#>  cachem             1.0.6    2021-08-19 [2] CRAN (R 4.2.1)
#>  callr              3.7.2    2022-08-22 [2] CRAN (R 4.2.1)
#>  checkmate          2.1.0    2022-04-21 [2] CRAN (R 4.2.1)
#>  class              7.3-20   2022-01-16 [2] CRAN (R 4.2.1)
#>  cli                3.4.1    2022-09-23 [2] CRAN (R 4.2.1)
#>  cluster            2.1.4    2022-08-22 [2] CRAN (R 4.2.1)
#>  clusterSim         0.50-1   2022-05-24 [2] CRAN (R 4.2.1)
#>  codetools          0.2-18   2020-11-04 [2] CRAN (R 4.2.1)
#>  colorspace         2.0-3    2022-02-21 [2] CRAN (R 4.2.1)
#>  crayon             1.5.2    2022-09-29 [2] CRAN (R 4.2.1)
#>  data.table       * 1.14.4   2022-10-17 [2] CRAN (R 4.2.1)
#>  DBI                1.1.3    2022-06-18 [2] CRAN (R 4.2.1)
#>  deldir             1.0-6    2021-10-23 [2] CRAN (R 4.2.1)
#>  devtools           2.4.5    2022-10-11 [2] CRAN (R 4.2.1)
#>  digest             0.6.30   2022-10-18 [2] CRAN (R 4.2.1)
#>  doParallel         1.0.17   2022-02-07 [2] CRAN (R 4.2.1)
#>  dplyr              1.0.10   2022-09-01 [2] CRAN (R 4.2.1)
#>  dynamicTreeCut     1.63-1   2016-03-11 [2] CRAN (R 4.2.1)
#>  e1071              1.7-12   2022-10-24 [2] CRAN (R 4.2.1)
#>  ellipsis           0.3.2    2021-04-29 [2] CRAN (R 4.2.1)
#>  evaluate           0.17     2022-10-07 [2] CRAN (R 4.2.1)
#>  fansi              1.0.3    2022-03-24 [2] CRAN (R 4.2.1)
#>  fastcluster        1.2.3    2021-05-24 [2] CRAN (R 4.2.1)
#>  fastmap            1.1.0    2021-01-25 [2] CRAN (R 4.2.1)
#>  foreach            1.5.2    2022-02-02 [2] CRAN (R 4.2.1)
#>  foreign            0.8-83   2022-09-28 [2] CRAN (R 4.2.1)
#>  Formula            1.2-4    2020-10-16 [2] CRAN (R 4.2.1)
#>  fs                 1.5.2    2021-12-08 [2] CRAN (R 4.2.1)
#>  generics           0.1.3    2022-07-05 [2] CRAN (R 4.2.1)
#>  GenomeInfoDb       1.34.0   2022-11-01 [2] Bioconductor
#>  GenomeInfoDbData   1.2.9    2022-09-28 [2] Bioconductor
#>  ggplot2            3.3.6    2022-05-03 [2] CRAN (R 4.2.1)
#>  glue               1.6.2    2022-02-24 [2] CRAN (R 4.2.1)
#>  GO.db              3.16.0   2022-09-27 [2] Bioconductor
#>  gridExtra          2.3      2017-09-09 [2] CRAN (R 4.2.1)
#>  gtable             0.3.1    2022-09-01 [2] CRAN (R 4.2.1)
#>  highr              0.9      2021-04-16 [2] CRAN (R 4.2.1)
#>  Hmisc              4.7-1    2022-08-15 [2] CRAN (R 4.2.1)
#>  htmlTable          2.4.1    2022-07-07 [2] CRAN (R 4.2.1)
#>  htmltools          0.5.3    2022-07-18 [2] CRAN (R 4.2.1)
#>  htmlwidgets        1.5.4    2021-09-08 [2] CRAN (R 4.2.1)
#>  httpuv             1.6.6    2022-09-08 [2] CRAN (R 4.2.1)
#>  httr               1.4.4    2022-08-17 [2] CRAN (R 4.2.1)
#>  igraph             1.3.5    2022-09-22 [2] CRAN (R 4.2.1)
#>  impute             1.72.0   2022-11-01 [2] Bioconductor
#>  interp             1.1-3    2022-07-13 [2] CRAN (R 4.2.1)
#>  IRanges            2.32.0   2022-11-01 [2] Bioconductor
#>  iterators          1.0.14   2022-02-05 [2] CRAN (R 4.2.1)
#>  jpeg               0.1-9    2021-07-24 [2] CRAN (R 4.2.1)
#>  jquerylib          0.1.4    2021-04-26 [2] CRAN (R 4.2.1)
#>  jsonlite           1.8.3    2022-10-21 [2] CRAN (R 4.2.1)
#>  KEGGREST           1.38.0   2022-11-01 [2] Bioconductor
#>  knitr              1.40     2022-08-24 [2] CRAN (R 4.2.1)
#>  later              1.3.0    2021-08-18 [2] CRAN (R 4.2.1)
#>  lattice            0.20-45  2021-09-22 [2] CRAN (R 4.2.1)
#>  latticeExtra       0.6-30   2022-07-04 [2] CRAN (R 4.2.1)
#>  lifecycle          1.0.3    2022-10-07 [2] CRAN (R 4.2.1)
#>  magrittr           2.0.3    2022-03-30 [2] CRAN (R 4.2.1)
#>  MASS               7.3-58.1 2022-08-03 [2] CRAN (R 4.2.1)
#>  Matrix             1.5-1    2022-09-13 [2] CRAN (R 4.2.1)
#>  matrixStats        0.62.0   2022-04-19 [2] CRAN (R 4.2.1)
#>  mbOmic           * 1.2.0    2022-11-01 [1] Bioconductor
#>  memoise            2.0.1    2021-11-26 [2] CRAN (R 4.2.1)
#>  mime               0.12     2021-09-28 [2] CRAN (R 4.2.1)
#>  miniUI             0.1.1.1  2018-05-18 [2] CRAN (R 4.2.1)
#>  mnormt             2.1.1    2022-09-26 [2] CRAN (R 4.2.1)
#>  munsell            0.5.0    2018-06-12 [2] CRAN (R 4.2.1)
#>  nlme               3.1-160  2022-10-10 [2] CRAN (R 4.2.1)
#>  nnet               7.3-18   2022-09-28 [2] CRAN (R 4.2.1)
#>  pillar             1.8.1    2022-08-19 [2] CRAN (R 4.2.1)
#>  pkgbuild           1.3.1    2021-12-20 [2] CRAN (R 4.2.1)
#>  pkgconfig          2.0.3    2019-09-22 [2] CRAN (R 4.2.1)
#>  pkgload            1.3.1    2022-10-28 [2] CRAN (R 4.2.1)
#>  png                0.1-7    2013-12-03 [2] CRAN (R 4.2.1)
#>  preprocessCore     1.60.0   2022-11-01 [2] Bioconductor
#>  prettyunits        1.1.1    2020-01-24 [2] CRAN (R 4.2.1)
#>  processx           3.8.0    2022-10-26 [2] CRAN (R 4.2.1)
#>  profvis            0.3.7    2020-11-02 [2] CRAN (R 4.2.1)
#>  promises           1.2.0.1  2021-02-11 [2] CRAN (R 4.2.1)
#>  proxy              0.4-27   2022-06-09 [2] CRAN (R 4.2.1)
#>  ps                 1.7.2    2022-10-26 [2] CRAN (R 4.2.1)
#>  psych              2.2.9    2022-09-29 [2] CRAN (R 4.2.1)
#>  purrr              0.3.5    2022-10-06 [2] CRAN (R 4.2.1)
#>  R2HTML             2.3.3    2022-05-23 [2] CRAN (R 4.2.1)
#>  R6                 2.5.1    2021-08-19 [2] CRAN (R 4.2.1)
#>  RColorBrewer       1.1-3    2022-04-03 [2] CRAN (R 4.2.1)
#>  Rcpp               1.0.9    2022-07-08 [2] CRAN (R 4.2.1)
#>  RCurl              1.98-1.9 2022-10-03 [2] CRAN (R 4.2.1)
#>  remotes            2.4.2    2021-11-30 [2] CRAN (R 4.2.1)
#>  rlang              1.0.6    2022-09-24 [2] CRAN (R 4.2.1)
#>  rmarkdown          2.17     2022-10-07 [2] CRAN (R 4.2.1)
#>  rpart              4.1.19   2022-10-21 [2] CRAN (R 4.2.1)
#>  RSQLite            2.2.18   2022-10-04 [2] CRAN (R 4.2.1)
#>  rstudioapi         0.14     2022-08-22 [2] CRAN (R 4.2.1)
#>  S4Vectors          0.36.0   2022-11-01 [2] Bioconductor
#>  sass               0.4.2    2022-07-16 [2] CRAN (R 4.2.1)
#>  scales             1.2.1    2022-08-20 [2] CRAN (R 4.2.1)
#>  sessioninfo        1.2.2    2021-12-06 [2] CRAN (R 4.2.1)
#>  shiny              1.7.3    2022-10-25 [2] CRAN (R 4.2.1)
#>  stringi            1.7.8    2022-07-11 [2] CRAN (R 4.2.1)
#>  stringr            1.4.1    2022-08-20 [2] CRAN (R 4.2.1)
#>  survival           3.4-0    2022-08-09 [2] CRAN (R 4.2.1)
#>  tibble             3.1.8    2022-07-22 [2] CRAN (R 4.2.1)
#>  tidyselect         1.2.0    2022-10-10 [2] CRAN (R 4.2.1)
#>  urlchecker         1.0.1    2021-11-30 [2] CRAN (R 4.2.1)
#>  usethis            2.1.6    2022-05-25 [2] CRAN (R 4.2.1)
#>  utf8               1.2.2    2021-07-24 [2] CRAN (R 4.2.1)
#>  vctrs              0.5.0    2022-10-22 [2] CRAN (R 4.2.1)
#>  visNetwork         2.1.2    2022-09-29 [2] CRAN (R 4.2.1)
#>  WGCNA              1.71     2022-04-22 [2] CRAN (R 4.2.1)
#>  xfun               0.34     2022-10-18 [2] CRAN (R 4.2.1)
#>  xtable             1.8-4    2019-04-21 [2] CRAN (R 4.2.1)
#>  XVector            0.38.0   2022-11-01 [2] Bioconductor
#>  yaml               2.3.6    2022-10-18 [2] CRAN (R 4.2.1)
#>  zlibbioc           1.44.0   2022-11-01 [2] Bioconductor
#>
#>  [1] /tmp/RtmpPw8mOP/Rinst1ebacc4c9ccbe5
#>  [2] /home/biocbuild/bbs-3.16-bioc/R/library
#>
#> ──────────────────────────────────────────────────────────────────────────────
```