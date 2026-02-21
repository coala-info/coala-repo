# Umbrella for the alabaster framework

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: January 18, 2023

#### Package

alabaster 1.10.0

# Contents

* [1 Motivation](#motivation)
* [Session information](#session-information)

# 1 Motivation

This is an umbrella package for the **alabaster** framework that serves as an installation target to ensure that all (known) *alabaster.\** packages are installed.
Doing so is necessary because various functions in *[alabaster.base](https://github.com/ArtifactDB/alabaster.base)* dynamically identify the packages required to (un)serialize a particular resource.
By installing all *alabaster.\** packages at once, we ensure that the dynamic look-up does not fail due to a missing package.

This umbrella is only provided for convenient installation and is not otherwise necessary for the functioning of **alabaster** framework.
In fact, advanced users and package/application developers may prefer to install their required *alabaster.\** packages individually rather than relying on this umbrella.
This reduces the number of dependent packages that need to be installed, which is possible in scenarios where a limited subset of resource types are to be processed.

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```