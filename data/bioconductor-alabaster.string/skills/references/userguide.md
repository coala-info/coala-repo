# Saving `XStringSet`s to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: December 27, 2023

#### Package

alabaster.string 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Quality scaled strings](#quality-scaled-strings)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.string](https://bioconductor.org/packages/3.22/alabaster.string)* package implements methods to save `XStringSet` objects to file artifacts and load them back into R.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Given an `XStringSet`, we can use `saveObject()` to save it inside a staging directory:

```
library(Biostrings)
x <- DNAStringSet(c(seq1="CTCNACCAGTAT", seq2="TTGA", seq3="TACCTAGAG"))
mcols(x)$score <- runif(length(x))
x
```

```
## DNAStringSet object of length 3:
##     width seq                                               names
## [1]    12 CTCNACCAGTAT                                      seq1
## [2]     4 TTGA                                              seq2
## [3]     9 TACCTAGAG                                         seq3
```

```
library(alabaster.string)
tmp <- tempfile()
saveObject(x, tmp)

list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"
## [2] "_environment.json"
## [3] "names.txt.gz"
## [4] "sequence_annotations/OBJECT"
## [5] "sequence_annotations/basic_columns.h5"
## [6] "sequences.fasta.gz"
```

We can then load it back into the session with `readObject()`.

```
roundtrip <- readObject(tmp)
class(roundtrip)
```

```
## [1] "DNAStringSet"
## attr(,"package")
## [1] "Biostrings"
```

More details on the metadata and on-disk layout are provided in the [schema](https://artifactdb.github.io/BiocObjectSchemas/html/sequence_string_set/v1.html).

# 3 Quality scaled strings

The same approach works with `QualityScaledXStringSet` objects:

```
x <- DNAStringSet(c("TTGA", "CTCN"))
q <- PhredQuality(c("*+,-", "6789"))
y <- QualityScaledDNAStringSet(x, q)

library(alabaster.string)
tmp <- tempfile()
saveObject(y, tmp)

roundtrip <- readObject(tmp)
class(roundtrip)
```

```
## [1] "QualityScaledDNAStringSet"
## attr(,"package")
## [1] "Biostrings"
```

# Session information

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] alabaster.string_1.10.0 alabaster.base_1.10.0   Biostrings_2.78.0
##  [4] Seqinfo_1.0.0           XVector_0.50.0          IRanges_2.44.0
##  [7] S4Vectors_0.48.0        BiocGenerics_0.56.0     generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3             cli_3.6.5                knitr_1.50
##  [4] rlang_1.1.6              xfun_0.53                jsonlite_2.0.0
##  [7] htmltools_0.5.8.1        sass_0.4.10              rmarkdown_2.30
## [10] evaluate_1.0.5           jquerylib_0.1.4          fastmap_1.2.0
## [13] Rhdf5lib_1.32.0          alabaster.schemas_1.10.0 yaml_2.3.10
## [16] lifecycle_1.0.4          bookdown_0.45            BiocManager_1.30.26
## [19] compiler_4.5.1           Rcpp_1.1.0               rhdf5filters_1.22.0
## [22] rhdf5_2.54.0             digest_0.6.37            R6_2.6.1
## [25] bslib_0.9.0              tools_4.5.1              cachem_1.1.0
```