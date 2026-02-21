# Integrative analysis of metabolome and microbiome

#### Congcong Gong

```
library(mbOmic)
```

# Introduction

The `mbOmic` package contains a set of analysis functions for microbiomics and metabolomics data, designed to analyze the inter-omic correlation between microbiology and metabolites, referencing the workflow of Jonathan Braun et al[1](#fn1).

```
# knitr::include_graphics(system.file('extdata', 'intro.png', 'mbOmic'))
```

# Examples

Load metabolites and OTU abundance data of plant.[2](#fn2) The OTU had been binned into genera level and were save as the metabolites\_and\_genera.rda file

```
path <- system.file('extdata', 'metabolites_and_genera.rda', package = 'mbOmic')

load(path)
```

### Construct `mbSet` object.

`bSet` is S4 class containing the metabolites abundance matrix.

We can use `bSet` function to directly create `bSet` class.

```
names(metabolites)[1] <- 'rn'
m <- mSet(m = metabolites)
m
#> 1. Features( 12 ):
#>   Delavirdine Leucoside 山奈酚3-O-桑布双糖苷 (3S)-2'-(Methylsulfanyl)-4'H-spiro[indole-3,5'-[1,3]thiazol]-2(1H)-one Cefepime versicotide A ...
#> 2. Samples( 247 ):
#>   BS1 BS2 BS3 BS4 BS5 ...
#> 3. Top 5 Samples data:
#> [1] 1 2 3 4 5
```

There are some function to get or set information of a `bSet`, such as `samples` and `features`.

Extract the samples names from `bSet` class by function `Samples`.

```
samples(m)
#>  [1] "BS1" "BS2" "BS3" "BS4" "BS5" "BS6" "SS1" "SS2" "SS3" "SS4" "SS5" "SS6"
#[1] "BS1" "BS2" "BS3" "BS4" "BS5" "BS6" "SS1" "SS2" "SS3" "SS4" "SS5" "SS6"
```

### Remove bad analytes (OTU and metatoblites)

Removal of analytes only measured in <2 of samples can perform by `clean_analytes`.

```
m <- clean_analytes(m, fea_num = 2)
```

### Generate metabolite module

`mbOmic` can generate metabolite module by `coExpress` function. The `coExpress` function is the encapsulation of one-step network construction and module detection of `WGCNA` package. The `coExpress` function firstly pick up the soft-threshold. The `threshold.d` and `threshold` parameters are used to detect whether is \(R^2\) changing and appropriate.

If there are no appropriate threshold was detected and you do not set the `power` parameter, the `coExpress` will throw a error, “No power detected! pls set the power parameter”.

```
net <- try({
coExpress(m,message = TRUE,threshold.d = 0.02, threshold = 0.8, plot = TRUE)
})
```

![](data:image/png;base64...)

```
#> Error in coExpress(m, message = TRUE, threshold.d = 0.02, threshold = 0.8,  :
#>   No power detected! pls set the power parameter
class(net)
#> [1] "try-error"
```

If you can’t get a good scale-free topology index no matter how high set the soft-thresholding power, you can directly set the power value by the parameter `power`, **but should be looked into carefully**. The appropriate soft-thresholding power can be chosen based on the number of samples as in the table below (recommend by `WGCNA` package).

| **Number of samples** | **Unsigned and signed hybrid networks** | **Signed networks** |
| --- | --- | --- |
| <20 | 9 | 18 |
| 20~30 | 8 | 16 |
| 30~40 | 7 | 14 |
| >40 | 6 | 12 |

```
net <- coExpress(m,message = TRUE,threshold.d = 0.02, threshold = 0.8, power = 9)
```

### Calculate the Spearman metabolite-genera correlation

you can calculate the correlation between metabolites and OTUs by `corr` function. It return a data table containing `rho`, `p value`, and `adjust p value`. Moreover, the `corr` can run in parallel mode.

```
b <- genera
names(b)[1] <- 'rn'
b <- bSet(b=b)
spearm <- corr(m = m, b = b, method = 'spearman')
# head(spearm)
spearm[p<=0.001]
#>                                b                                       m
#>   1: unidentified_Acidimicrobiia                             Delavirdine
#>   2:                 Acidibacter          Leucoside 山奈酚3-O-桑布双糖苷
#>   3:                      Dongia          Leucoside 山奈酚3-O-桑布双糖苷
#>   4:  unidentified_Clostridiales          Leucoside 山奈酚3-O-桑布双糖苷
#>   5:                 Acidibacter                           versicotide A
#>  ---
#> 366: unidentified_Acidimicrobiia                        Methyl cinnamate
#> 367:                Chujaibacter                               Catharine
#> 368:                   Ralstonia                               Catharine
#> 369:  unidentified_Clostridiales                               Catharine
#> 370:      Candidatus_Udaeobacter Tri-2,5-cyclohexadien-1-yl(octyl)silane
#>             rho            p        padj
#>   1:  0.8391608 0.0006428260 0.010134767
#>   2: -0.8321678 0.0007854417 0.010744842
#>   3:  0.8601399 0.0003316683 0.008057909
#>   4: -0.8391608 0.0006428260 0.010134767
#>   5: -0.8881119 0.0001141336 0.006342975
#>  ---
#> 366:  0.8671329 0.0002598118 0.007310908
#> 367: -0.8321678 0.0007854417 0.010744842
#> 368: -0.8861660 0.0001239889 0.006526816
#> 369: -0.8881119 0.0001141336 0.006342975
#> 370:  0.8531469 0.0004181179 0.008646290
```

### plot the network

Finally, you can vaisulize the network by `plot_network` function, taking the `coExpress`and `corr` output. The orange nodes correspondes to OTU(genera)).

```
# svg('../inst/doc/network1.svg')
plot_network(net, spearm[abs(rho) >= 0.8 & p <= 0.001], interaction = FALSE)
```

![](data:image/png;base64...)

```
# dev.off()
```

```
plot_network(net, spearm[abs(rho) >= 0.8 & p <= 0.001], seed = 123, interaction = TRUE, return =  TRUE)
```

# visSave(tmp, file = '../inst/doc/network2.html')

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
#>  cli                3.4.1    2022-09-23 [2] CRAN (R 4.2.1)
#>  cluster            2.1.4    2022-08-22 [2] CRAN (R 4.2.1)
#>  codetools          0.2-18   2020-11-04 [2] CRAN (R 4.2.1)
#>  colorspace         2.0-3    2022-02-21 [2] CRAN (R 4.2.1)
#>  crayon             1.5.2    2022-09-29 [2] CRAN (R 4.2.1)
#>  data.table         1.14.4   2022-10-17 [2] CRAN (R 4.2.1)
#>  DBI                1.1.3    2022-06-18 [2] CRAN (R 4.2.1)
#>  deldir             1.0-6    2021-10-23 [2] CRAN (R 4.2.1)
#>  devtools           2.4.5    2022-10-11 [2] CRAN (R 4.2.1)
#>  digest             0.6.30   2022-10-18 [2] CRAN (R 4.2.1)
#>  doParallel         1.0.17   2022-02-07 [2] CRAN (R 4.2.1)
#>  dplyr              1.0.10   2022-09-01 [2] CRAN (R 4.2.1)
#>  dynamicTreeCut     1.63-1   2016-03-11 [2] CRAN (R 4.2.1)
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
#>  ps                 1.7.2    2022-10-26 [2] CRAN (R 4.2.1)
#>  psych              2.2.9    2022-09-29 [2] CRAN (R 4.2.1)
#>  purrr              0.3.5    2022-10-06 [2] CRAN (R 4.2.1)
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

---

1. McHardy, I. H., Goudarzi, M., Tong, M., Ruegger, P. M., Schwager, E., Weger, J. R., Graeber, T. G., Sonnenburg, J. L., Horvath, S., Huttenhower, C., McGovern, D. P., Fornace, A. J., Borneman, J., & Braun, J. (2013). Integrative analysis of the microbiome and metabolome of the human intestinal mucosal surface reveals exquisite inter-relationships. *Microbiome*, *1*(1), 17. <https://doi.org/10.1186/2049-2618-1-17>[↩](#fnref1)
2. Huang, W., Sun, D., Chen, L., & An, Y. (2021). Integrative analysis of the microbiome and metabolome in understanding the causes of sugarcane bitterness. Scientific Reports, 11(1), 1-11.[↩](#fnref2)