# Contents

* [1 Introduction](#introduction)
* [2 Parameter Settings](#parameter-settings)
* [3 Session Information](#session-information)

# 1 Introduction

In some cases you have certain genes of interest and you would like to find
other genes that are close to the genes of interest. This can be done using the
`genefinder` function.

You need to specify either the index position of the genes you want (which row
of the expression array the gene is in) or the name (consistent with the
`featureNames` of the ExpressionSet).

A vector of names can be specified and matches for all will be computed. The
number of matches and the distance measure used can all be specified. The
examples will be carried out using the artificial data set, `sample.ExpressionSet`.

Two other options for `genefinder` are `scale` and `method`. The `scale` option
controls the scaling of the rows (this is often desirable), while the `method`
option controls the distance measure used between genes. The possible values and
their meanings are listed at the end of this document.

```
library("Biobase")
library("genefilter")
data(sample.ExpressionSet)
igenes <- c(300,333,355,419) ##the interesting genes
closeg <- genefinder(sample.ExpressionSet, igenes, 10, method="euc", scale="none")
names(closeg)
```

```
## [1] "31539_r_at" "31572_at"   "31594_at"   "31658_at"
```

The Affymetrix identifiers (since these were originally Affymetrix data) are
`31539_r_at`, `31572_at`, `31594_at` and `31658_at`. We can find the nearest
genes (by index) for any of these by simply accessing the relevant component of
`closeg`.

```
closeg$"31539_r_at"
```

```
## $indices
##  [1] 220 425 457 131 372 137 380 231 161  38
##
## $dists
##  [1] 70.30643 70.94069 71.66043 71.66962 73.55186 73.66967 74.77823 77.42745
##  [9] 77.86960 83.57073
```

```
Nms1 <- featureNames(sample.ExpressionSet)[closeg$"31539_r_at"$indices]
Nms1
```

```
##  [1] "31459_i_at"      "31664_at"        "31696_at"        "31370_at"
##  [5] "31611_s_at"      "31376_at"        "31619_at"        "31470_at"
##  [9] "31400_at"        "AFFX-TrpnX-3_at"
```

You could then take these names (from `Nms1`) and the *[annotate](https://bioconductor.org/packages/3.22/annotate)*
package and explore them further. See the various HOWTO’s in annotate to see how
to further explore your data. Examples include finding and searching all PubMed
abstracts associated with these data. Finding and downloading associated
sequence information. The data can also be visualized using the
*[geneplotter](https://bioconductor.org/packages/3.22/geneplotter)* package (again there are a number of HOWTO documents there).

# 2 Parameter Settings

The scale parameter can take the following values:

**none** No scaling is done.

**range** Scaling is done by \((x\_{i} − x\_{(1)})/(x\_{(n)} − x\_{(1)})\).

**zscore** Scaling is done by \((x\_{i} − \bar{x})/s\_{x}\). Where sx is the standard deviation.

The `method` parameter can take the following values:

**euclidean** Euclidean distance is used.

**maximum** Maximum distance between any two elements of x and y (supremum norm).

**manhattan** Absolute distance between the two vectors (1 norm).

**canberra** The \(\sum(|x\_{i} − y\_{i}|/|x\_{i} + y\_{i}|)\). Terms with zero numerator
and denominator are omitted from the sum and treated as if the values were missing.

**binary** (aka asymmetric binary): The vectors are regarded as binary bits, so
non-zero elements are on and zero elements are off. The distance is the
proportion of bits in which only one is on amongst those in which at least one is on.

# 3 Session Information

The version number of R and packages loaded for generating
the vignette were:

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