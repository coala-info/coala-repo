Code

* Show All Code
* Hide All Code

# Example report using bumphunter results

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 30 October 2025

#### Package

regionReport 1.44.0

# 1 *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)* example

The *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)* package can be used for methylation analyses where you are interested in identifying differentially methylated regions. The [vignette](http://bioconductor.org/packages/release/bioc/vignettes/bumphunter/inst/doc/bumphunter.pdf) explains in greater detail the data set we are using in this example.

```
## Load bumphunter
library("bumphunter")
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: parallel
```

```
## Loading required package: locfit
```

```
## locfit 1.5-9.12   2025-03-05
```

```
## Create data from the vignette
pos <- list(
    pos1 = seq(1, 1000, 35),
    pos2 = seq(2001, 3000, 35),
    pos3 = seq(1, 1000, 50)
)
chr <- rep(paste0("chr", c(1, 1, 2)), times = sapply(pos, length))
pos <- unlist(pos, use.names = FALSE)

## Find clusters
cl <- clusterMaker(chr, pos, maxGap = 300)

## Build simulated bumps
Indexes <- split(seq_along(cl), cl)
beta1 <- rep(0, length(pos))
for (i in seq(along = Indexes)) {
    ind <- Indexes[[i]]
    x <- pos[ind]
    z <- scale(x, median(x), max(x) / 12)
    beta1[ind] <- i * (-1)^(i + 1) * pmax(1 - abs(z)^3, 0)^3 ## multiply by i to vary size
}

## Build data
beta0 <- 3 * sin(2 * pi * pos / 720)
X <- cbind(rep(1, 20), rep(c(0, 1), each = 10))
set.seed(23852577)
error <- matrix(rnorm(20 * length(beta1), 0, 1), ncol = 20)
y <- t(X[, 1]) %x% beta0 + t(X[, 2]) %x% beta1 + error

## Perform bumphunting
tab <- bumphunter(y, X, chr, pos, cl, cutoff = .5)
```

```
## [bumphunterEngine] Using a single core (backend: doSEQ, version: 1.5.2).
```

```
## [bumphunterEngine] Computing coefficients.
```

```
## [bumphunterEngine] Finding regions.
```

```
## [bumphunterEngine] Found 15 bumps.
```

```
## Explore data
lapply(tab, head)
```

```
## $table
##     chr start  end      value       area cluster indexStart indexEnd  L
## 10 chr1  2316 2631 -1.5814747 15.8147473       2         39       48 10
## 7  chr2   451  551  1.5891293  4.7673878       3         68       70  3
## 2  chr1   456  526  1.0678828  3.2036485       1         14       16  3
## 5  chr1  2176 2211  0.7841794  1.5683589       2         35       36  2
## 6  chr1  2841 2841  1.2010184  1.2010184       2         54       54  1
## 4  chr1   771  771  0.7780902  0.7780902       1         23       23  1
##    clusterL
## 10       29
## 7        20
## 2        29
## 5        29
## 6        29
## 4        29
##
## $coef
##             [,1]
## [1,]  0.60960932
## [2,] -0.09052769
## [3,] -0.21482638
## [4,]  0.13053755
## [5,] -0.21723642
## [6,]  0.39934961
##
## $fitted
##             [,1]
## [1,]  0.60960932
## [2,] -0.09052769
## [3,] -0.21482638
## [4,]  0.13053755
## [5,] -0.21723642
## [6,]  0.39934961
##
## $pvaluesMarginal
## [1] NA
```

Once we have the regions we can proceed to build the required `GRanges` object.

```
library("GenomicRanges")

## Build GRanges with sequence lengths
regions <- GRanges(
    seqnames = tab$table$chr,
    IRanges(start = tab$table$start, end = tab$table$end),
    strand = "*", value = tab$table$value, area = tab$table$area,
    cluster = tab$table$cluster, L = tab$table$L, clusterL = tab$table$clusterL
)

## Assign chr lengths
library(GenomeInfoDb)  # for getChromInfoFromUCSC()
seqlengths(regions) <- seqlengths(
    getChromInfoFromUCSC("hg19", as.Seqinfo = TRUE)
)[
    names(seqlengths(regions))
]

## Explore the regions
regions
```

```
## GRanges object with 15 ranges and 5 metadata columns:
##        seqnames    ranges strand |     value      area   cluster         L
##           <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
##    [1]     chr1 2316-2631      * | -1.581475  15.81475         2        10
##    [2]     chr2   451-551      * |  1.589129   4.76739         3         3
##    [3]     chr1   456-526      * |  1.067883   3.20365         1         3
##    [4]     chr1 2176-2211      * |  0.784179   1.56836         2         2
##    [5]     chr1      2841      * |  1.201018   1.20102         2         1
##    ...      ...       ...    ... .       ...       ...       ...       ...
##   [11]     chr1       631      * |  0.618603  0.618603         1         1
##   [12]     chr1         1      * |  0.609609  0.609609         1         1
##   [13]     chr1      2911      * | -0.576423  0.576423         2         1
##   [14]     chr2       251      * | -0.556160  0.556160         3         1
##   [15]     chr1      2806      * | -0.521606  0.521606         2         1
##         clusterL
##        <integer>
##    [1]        29
##    [2]        20
##    [3]        29
##    [4]        29
##    [5]        29
##    ...       ...
##   [11]        29
##   [12]        29
##   [13]        29
##   [14]        20
##   [15]        29
##   -------
##   seqinfo: 2 sequences from an unspecified genome
```

Now that we have identified a set of differentially methylated regions we can proceed to creating the HTML report. Note that this report has less information than the [DiffBind example](http://leekgroup.github.io/regionReportSupp/DiffBind.html) because we don’t have a p-value variable.

```
## Load regionReport
library("regionReport")
```

```
## Now create the report
report <- renderReport(regions, "Example bumphunter",
    pvalueVars = NULL,
    densityVars = c(
        "Area" = "area", "Value" = "value",
        "Cluster Length" = "clusterL"
    ), significantVar = NULL,
    output = "bumphunter-example", outdir = "bumphunter-example",
    device = "png"
)
```

You can view the final report at `bumphunter-example/bumphunter-example.html` [or here](http://leekgroup.github.io/regionReport/reference/bumphunter-example/bumphunter-example.html).

In case the link does not work, a [pre-compiled version of this document](http://leekgroup.github.io/regionReportSupp/bumphunterExample.html) and its [corresponding report](http://leekgroup.github.io/regionReportSupp/bumphunter-example/index.html) are available at [leekgroup.github.io/regionReportSupp/](http://leekgroup.github.io/regionReportSupp/index.html).

# 2 Reproducibility

```
## Date generated:
Sys.time()
```

```
## [1] "2025-10-30 02:01:04 EDT"
```

```
## Time spent making this page:
proc.time()
```

```
##    user  system elapsed
##  14.375   0.896  15.268
```

```
## R and packages info:
options(width = 120)
sessioninfo::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package              * version   date (UTC) lib source
##  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
##  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
##  base64enc              0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
##  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
##  Biobase                2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
##  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
##  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
##  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
##  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
##  BSgenome               1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
##  bumphunter           * 1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
##  checkmate              2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
##  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
##  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
##  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
##  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
##  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
##  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
##  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
##  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
##  DEFormats              1.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinder              1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderHelper        1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DESeq2                 1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
##  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
##  doRNG                  1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
##  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
##  edgeR                  4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
##  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
##  foreach              * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
##  foreign                0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
##  Formula                1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
##  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
##  GenomeInfoDb         * 1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicAlignments      1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFiles           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
##  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
##  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
##  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
##  Hmisc                  5.2-4     2025-10-05 [2] CRAN (R 4.5.1)
##  htmlTable              2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
##  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
##  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
##  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  iterators            * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
##  knitrBootstrap         1.0.3     2024-02-06 [2] CRAN (R 4.5.1)
##  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
##  limma                  3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  locfit               * 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
##  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
##  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
##  markdown               2.0       2025-03-23 [2] CRAN (R 4.5.1)
##  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics         1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
##  nnet                   7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
##  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
##  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
##  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
##  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
##  qvalue                 2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
##  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
##  RefManageR             1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
##  regionReport         * 1.44.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
##  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
##  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
##  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
##  rngtools               1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
##  rpart                  4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
##  Rsamtools              2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
##  rstudioapi             0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
##  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
##  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
##  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo            1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
##  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
##  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
##  SummarizedExperiment   1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
##  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
##  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
##  UCSC.utils             1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  VariantAnnotation      1.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
##  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
##  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
##  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
##  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpMXtm6m/Rinst27c90313432f82
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```