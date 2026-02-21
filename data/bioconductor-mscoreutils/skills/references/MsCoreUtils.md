# Core Utils for Mass Spectrometry Data

MsCoreUtils Package Maintainers

#### 27 November 2025

#### Package

MsCoreUtils 1.22.1

# 1 Introduction

The `MsCoreUtils` package low-level functions for mass spectrometry data and is
independent of any high-level data structures [@rainer\_modular\_2022]. These
functions include mass spectra processing functions (noise estimation,
smoothing, binning), quantitative aggregation functions (median polish, robust
summarisation, …), missing data imputation, data normalisation (quantiles,
vsn, …) as well as misc helper functions, that are used across high level
data structure within the R for Mass Spectrometry packages.

For a full list of function, see

```
library("MsCoreUtils")
ls(pos = "package:MsCoreUtils")
```

```
##  [1] "%between%"                  "aggregate_by_matrix"
##  [3] "aggregate_by_vector"        "asInteger"
##  [5] "between"                    "bin"
##  [7] "breaks_ppm"                 "closest"
##  [9] "coefMA"                     "coefSG"
## [11] "coefWMA"                    "colCounts"
## [13] "colMeansMat"                "colSumsMat"
## [15] "common"                     "common_path"
## [17] "entropy"                    "estimateBaseline"
## [19] "estimateBaselineConvexHull" "estimateBaselineMedian"
## [21] "estimateBaselineSnip"       "estimateBaselineTopHat"
## [23] "force_sorted"               "formatRt"
## [25] "getImputeMargin"            "gnps"
## [27] "group"                      "i2index"
## [29] "imputeMethods"              "impute_MinDet"
## [31] "impute_MinProb"             "impute_QRILC"
## [33] "impute_RF"                  "impute_bpca"
## [35] "impute_fun"                 "impute_knn"
## [37] "impute_matrix"              "impute_min"
## [39] "impute_mixed"               "impute_mle"
## [41] "impute_neighbour_average"   "impute_with"
## [43] "impute_zero"                "isPeaksMatrix"
## [45] "join"                       "join_gnps"
## [47] "localMaxima"                "maxi"
## [49] "medianPolish"               "navdist"
## [51] "ndotproduct"                "nentropy"
## [53] "neuclidean"                 "noise"
## [55] "normalizeMethods"           "normalize_matrix"
## [57] "nspectraangle"              "ppm"
## [59] "rbindFill"                  "reduce"
## [61] "refineCentroids"            "rla"
## [63] "robustSummary"              "rowRla"
## [65] "rt2character"               "rt2numeric"
## [67] "smooth"                     "sumi"
## [69] "validPeaksMatrix"           "valleys"
## [71] "vapply1c"                   "vapply1d"
## [73] "vapply1l"                   "which.first"
## [75] "which.last"
```

or the [reference
page](https://rformassspectrometry.github.io/MsCoreUtils/reference/index.html)
on the package webpage.

# 2 Examples

The functions defined in this package utilise basic classes with the
aim of being reused in packages that provide a more formal, high-level
interface.

As an examples, let’s take the `robustSummary()` function, that
calculates the robust summary of the columns of a matrix:

```
x <- matrix(rnorm(30), nrow = 3)
colnames(x) <- letters[1:10]
rownames(x) <- LETTERS[1:3]
x
```

```
##            a           b          c          d          e          f          g
## A -0.3939900 -0.08250703 -0.2741229  0.7653249  0.6244175  0.6705018  1.1144940
## B  0.1955855  1.30673260  0.9555620 -0.4302837 -0.8137711  0.2949613 -0.0537986
## C -0.7714493 -0.20862993 -0.6758294  0.8101337  2.1147175 -0.5392013 -0.6453068
##              h          i          j
## A -0.001209583 -0.6852936 -0.9631042
## B -0.669700526 -1.8866449  1.4215897
## C  0.702878784  0.9112612  1.6060634
```

```
robustSummary(x)
```

```
##            a            b            c            d            e            f
## -0.323284602  0.338531879  0.001869884  0.381724959  0.650158415  0.142087292
##            g            h            i            j
##  0.138462874  0.010656225 -0.600492490  0.887799002
```

This function is typicall to be used to summarise peptide quantitation
values into protein intensities111 See Sticker *et al.* Robust summarization and inference
in proteome-wide label-free
quantification. <https://doi.org/10.1101/668863>.. This functionality is
available in

* the
  [MSnbase::combineFeatures()](http://lgatto.github.io/MSnbase/reference/combineFeatures.html)
  function for `MSnSet` objects and
* the
  [QFeatures::aggregateFeatures()](https://rformassspectrometry.github.io/QFeatures/reference/Features-aggregate.html)
  function for `QFeatures` objects.

# 3 Contributions

If you would like to contribute any low-level functionality, please
[open a GitHub
issue](https://github.com/RforMassSpectrometry/MsCoreUtils/issues) to
discuss it. Please note that any
[contributions](https://rformassspectrometry.github.io/RforMassSpectrometry/articles/RforMassSpectrometry.html#contributions)
should follow the [style
guide](https://rformassspectrometry.github.io/RforMassSpectrometry/articles/RforMassSpectrometry.html#coding-style)
and will require an appropriate unit test.

If you wish to reuse any functions in this package, please just go
ahead. If you would like any advice or seek help, please either [open
a GitHub
issue](https://github.com/RforMassSpectrometry/MsCoreUtils/issues).

# Session information

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MsCoreUtils_1.22.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.54           generics_0.1.4      jsonlite_2.0.0
##  [7] clue_0.3-66         S4Vectors_0.48.0    htmltools_0.5.8.1
## [10] sass_0.4.10         stats4_4.5.2        rmarkdown_2.30
## [13] evaluate_1.0.5      jquerylib_0.1.4     MASS_7.3-65
## [16] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [19] bookdown_0.45       BiocManager_1.30.27 cluster_2.1.8.1
## [22] compiler_4.5.2      digest_0.6.39       R6_2.6.1
## [25] bslib_0.9.0         tools_4.5.2         BiocGenerics_0.56.0
## [28] cachem_1.1.0
```

# References