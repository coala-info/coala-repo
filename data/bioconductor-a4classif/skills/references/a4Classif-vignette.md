# Vignette of the a4Classif package

#### 2025-10-29

# 1 Introduction

This document explains the functionalities available in the **a4Classif** package.

This package contains for classification of Affymetrix microarray data, stored in an `ExpressionSet`. This package integrates within the Automated Affymetrix Array Analysis suite of packages.

```
## Loading required package: a4Core
```

```
## Loading required package: a4Preproc
```

```
##
## a4Classif version 1.58.0
```

```
## Loading required package: Biobase
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
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

To demonstrate the functionalities of the package, the `ALL` dataset is used. The genes are annotated thanks to the `addGeneInfo` utility function of the `a4Preproc` package.

```
data(ALL, package = "ALL")
ALL <- addGeneInfo(ALL)
```

```
## Loading required package: hgu95av2.db
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: stats4
```

```
## Loading required package: IRanges
```

```
## Loading required package: S4Vectors
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
## Loading required package: org.Hs.eg.db
```

```
##
```

```
##
```

```
ALL$BTtype <- as.factor(substr(ALL$BT,0,1))
```

# 2 Classify microarray data

## 2.1 Lasso regression

```
resultLasso <- lassoClass(object = ALL, groups = "BTtype")
plot(resultLasso,
    label = TRUE,
    main = "Lasso coefficients in relation to degree of penalization."
)
```

![](data:image/png;base64...)

```
topTable(resultLasso, n = 15)
```

```
## The lasso selected 16 genes. The top 15 genes are:
##
##             Gene Coefficient
## 38319_at    CD3D  0.95966733
## 35016_at    CD74 -0.60928095
## 38147_at  SH2D1A  0.49240967
## 35792_at    MGLL  0.46856925
## 37563_at  SRGAP3  0.26648240
## 38917_at  YME1L1  0.25100075
## 40278_at    GGA2 -0.25017550
## 41164_at    IGHM -0.12387272
## 41409_at THEMIS2 -0.10581122
## 38242_at    BLNK -0.10309606
## 35523_at   HPGDS  0.10169706
## 38949_at   PRKCQ  0.07832802
## 33316_at     TOX  0.06963509
## 33839_at   ITPR2  0.05801832
## 40570_at   FOXO1 -0.04858863
```

## 2.2 PAM regression

```
resultPam <- pamClass(object = ALL, groups = "BTtype")
plot(resultPam,
    main = "Pam misclassification error versus number of genes."
)
```

![](data:image/png;base64...)

```
topTable(resultPam, n = 15)
```

```
## Pam selected  1  genes. The top  15  genes are:
##
##          GeneSymbol B.score T.score av.rank.in.CV prop.selected.in.CV
## 38319_at       CD3D -0.1693  0.4875             1                   1
```

```
confusionMatrix(resultPam)
```

```
##     predicted
## true  B  T
##    B 95  0
##    T  1 32
```

## 2.3 Random forest

```
# select only a subset of the data for computation time reason
ALLSubset <- ALL[sample.int(n = nrow(ALL), size = 100, replace = FALSE), ]

resultRf <- rfClass(object = ALLSubset, groups = "BTtype")
plot(resultRf)
```

![](data:image/png;base64...)

```
topTable(resultRf, n = 15)
```

```
## Random forest selected 4 genes. The top 15 genes are:
##
##          GeneSymbol
## 33196_at      NFRKB
## 38631_at    TNFAIP2
## 39296_at  LINC00342
## 41409_at    THEMIS2
```

## 2.4 ROC curve

```
ROCcurve(gene = "ABL1", object = ALL, groups = "BTtype")
```

```
## Warning in ROCcurve(gene = "ABL1", object = ALL, groups = "BTtype"): Gene ABL1 corresponds to 6 probesets; only the first probeset ( 1635_at ) has been displayed on the plot.
```

![](data:image/png;base64...)

# 3 Appendix

## 3.1 Session information

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB              LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] hgu95av2.db_3.13.0   org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0     ALL_1.51.0           Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4       a4Classif_1.58.0     a4Preproc_1.58.0     a4Core_1.58.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10          varSelRF_0.7-8       shape_1.4.6.1        RSQLite_2.4.3        lattice_0.22-7       digest_0.6.37        evaluate_1.0.5       grid_4.5.1           iterators_1.0.14     fastmap_1.2.0        blob_1.2.4           foreach_1.5.2        jsonlite_2.0.0       glmnet_4.1-10        Matrix_1.7-4         DBI_1.2.3            survival_3.8-3       httr_1.4.7           Biostrings_2.78.0    codetools_0.2-20     jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
## [24] rlang_1.1.6          XVector_0.50.0       pamr_1.57            bit64_4.6.0-1        splines_4.5.1        cachem_1.1.0         yaml_2.3.10          tools_4.5.1          parallel_4.5.1       memoise_2.0.1        ROCR_1.0-11          vctrs_0.6.5          R6_2.6.1             png_0.1-8            lifecycle_1.0.4      Seqinfo_1.0.0        KEGGREST_1.50.0      randomForest_4.7-1.2 bit_4.6.0            cluster_2.1.8.1      pkgconfig_2.0.3      bslib_0.9.0          Rcpp_1.1.0
## [47] xfun_0.53            knitr_1.50           htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```