# Using the genefilter function to filter genes from a microarray dataset

Khadijah Amusat1

1Vignette translation from Sweave to R Markdown / HTML

#### October 30 , 2025

#### Package

genefilter 1.92.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Selecting genes that appear useful for prediction](#selecting-genes-that-appear-useful-for-prediction)
* [2 Session Information](#session-information)

# 1 Introduction

The *[genefilter](https://bioconductor.org/packages/3.22/genefilter)* package can be used to filter (select) genes from
a microarray dataset according to a variety of different filtering mechanisms.
Here, we will consider the example dataset in the `sample.ExpressionSet` example
from the *[Biobase](https://bioconductor.org/packages/3.22/Biobase)* package. This experiment has 26 samples, and
there are 500 genes and 3 covariates. The covariates are named `sex`, `type` and
`score`. The first two have two levels and the last one is continuous.

```
library("Biobase")
library("genefilter")
data(sample.ExpressionSet)
varLabels(sample.ExpressionSet)
```

```
## [1] "sex"   "type"  "score"
```

```
table(sample.ExpressionSet$sex)
```

```
##
## Female   Male
##     11     15
```

```
table(sample.ExpressionSet$type)
```

```
##
##    Case Control
##      15      11
```

One dichotomy that can be of interest for subsequent analyses is whether the
filter is *specific* or *non-specific*. Here, specific means that we are
filtering with reference to sample metadata, for example, `type`. For example,
if we want to select genes that are differentially expressed in the two groups
defined by `type`, that is a specific filter. If on the other hand we want to
select genes that are expressed in more than 5 samples, that is an example of a
non–specific filter.

First, let us see how to perform a non–specific filter. Suppose we want to
select genes that have an expression measure above 200 in at least 5 samples. To
do that we use the function `kOverA`.

There are three steps that must be performed.

1. Create function(s) implementing the filtering criteria.
2. Assemble it (them) into a (combined) filtering function.
3. Apply the filtering function to the expression matrix.

```
f1 <- kOverA(5, 200)
ffun <- filterfun(f1)
wh1 <- genefilter(exprs(sample.ExpressionSet), ffun)
sum(wh1)
```

```
## [1] 159
```

Here `f1` is a function that implies our “expression measure above 200 in at
least 5 samples” criterion, the function `ffun` is the filtering function (which
in this case consists of only one criterion), and we apply it using `r Biocpkg("genefilter")`. There were 159 genes that satisfied the
criterion and passed the filter. As an example for a specific filter, let us
select genes that are differentially expressed in the groups defined by `type`.

```
f2 <- ttest(sample.ExpressionSet$type, p=0.1)
wh2 <- genefilter(exprs(sample.ExpressionSet), filterfun(f2))
sum(wh2)
```

```
## [1] 88
```

Here, `ttest` is a function from the *[genefilter](https://bioconductor.org/packages/3.22/genefilter)* package which
provides a suitable wrapper around `t.test` from package *stats*.
Now we see that there are 88 genes that satisfy the selection
criterion. Suppose that we want to combine the two filters. We want those genes
for which at least 5 have an expression measure over 200 *and* which also are
differentially expressed between the groups defined by `type`

```
ffun_combined <- filterfun(f1, f2)
wh3 <- genefilter(exprs(sample.ExpressionSet), ffun_combined)
sum(wh3)
```

```
## [1] 35
```

Now we see that there are only 35 genes that satisfy both conditions.

## 1.1 Selecting genes that appear useful for prediction

The function `knnCV` defined below performs \(k\)–nearest neighbour
classification using leave–one–out cross–validation. At the same time it
aggregates the genes that were selected. The function returns the predicted
classifications as its returned value. However, there is an additional side
effect. The number of times that each gene was used (provided it was at least
one) are recorded and stored in the environment of the aggregator `Agg`. These
can subsequently be retrieved and used for other purposes.

```
knnCV <- function(x, selectfun, cov, Agg, pselect = 0.01, scale=FALSE) {
   nc <- ncol(x)
   outvals <- rep(NA, nc)
   for(i in seq_len(nc)) {
      v1 <- x[,i]
      expr <- x[,-i]
      glist <- selectfun(expr, cov[-i], p=pselect)
      expr <- expr[glist,]
      if( scale ) {
        expr <- scale(expr)
        v1 <- as.vector(scale(v1[glist]))
      }
      else
         v1 <- v1[glist]
      out <- paste("iter ",i, " num genes= ", sum(glist), sep="")
      print(out)
      Aggregate(row.names(expr), Agg)
      if( length(v1) == 1)
         outvals[i] <- knn(expr, v1, cov[-i], k=5)
      else
          outvals[i] <- knn(t(expr), v1, cov[-i], k=5)
    }
    return(outvals)
}
```

```
gfun <- function(expr, cov, p=0.05) {
   f2 <- ttest(cov, p=p)
   ffun <- filterfun(f2)
   which <- genefilter(expr, ffun)
  }
```

Next we show how to use this function on the dataset `geneData`

```
library("class")
##scale the genes
##genescale is a slightly more flexible "scale"
##work on a subset -- for speed only
geneData <- genescale(exprs(sample.ExpressionSet)[1:75,], 1)
Agg <- new("aggregator")
testcase <- knnCV(geneData, gfun, sample.ExpressionSet$type,
       Agg,pselect=0.05)
```

```
sort(sapply(aggenv(Agg), c), decreasing=TRUE)
```

```
##          AFFX-MurIL4_at         AFFX-TrpnX-M_at         AFFX-hum_alu_at
##                      26                      26                      26
##        AFFX-YEL018w/_at                31308_at          AFFX-PheX-M_at
##                      20                      15                      15
##                31312_at          AFFX-BioC-3_st AFFX-HUMRGE/M10098_M_at
##                       3                       3                       1
##          AFFX-DapX-5_at         AFFX-TrpnX-5_at         AFFX-BioDn-5_at
##                       1                       1                       1
##          AFFX-PheX-5_at
##                       1
```

The environment `Agg` contains, for each gene, the number of times it was selected in the cross-validation.

# 2 Session Information

The version number of R and packages loaded for generating the vignette were:

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
## [1] class_7.3-23        genefilter_1.92.0   Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10           RSQLite_2.4.3         lattice_0.22-7
##  [4] digest_0.6.37         evaluate_1.0.5        grid_4.5.1
##  [7] bookdown_0.45         fastmap_1.2.0         blob_1.2.4
## [10] jsonlite_2.0.0        Matrix_1.7-4          AnnotationDbi_1.72.0
## [13] DBI_1.2.3             survival_3.8-3        BiocManager_1.30.26
## [16] httr_1.4.7            XML_3.99-0.19         Biostrings_2.78.0
## [19] jquerylib_0.1.4       cli_3.6.5             rlang_1.1.6
## [22] crayon_1.5.3          XVector_0.50.0        bit64_4.6.0-1
## [25] splines_4.5.1         cachem_1.1.0          yaml_2.3.10
## [28] tools_4.5.1           memoise_2.0.1         annotate_1.88.0
## [31] vctrs_0.6.5           R6_2.6.1              png_0.1-8
## [34] matrixStats_1.5.0     stats4_4.5.1          lifecycle_1.0.4
## [37] KEGGREST_1.50.0       Seqinfo_1.0.0         S4Vectors_0.48.0
## [40] IRanges_2.44.0        bit_4.6.0             bslib_0.9.0
## [43] xfun_0.53             MatrixGenerics_1.22.0 knitr_1.50
## [46] xtable_1.8-4          htmltools_0.5.8.1     rmarkdown_2.30
## [49] compiler_4.5.1
```