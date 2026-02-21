# Using gDRstyle

gDR team\*

\*gdr-support-d@gene.com

#### 30 October 2025

#### Package

gDRstyle 1.8.0

# 1 Overview

The `gDRstyle` package is intended to be used during development of packages
within the gDR platform. It has 3 primary uses: (1)to set a style guide with
functions that check that the style is upheld, (2) during CI to ensure code
passes `R CMD check` to maintain the state of the code in high quality, and (3)
for package dependency installation during gDR platform image building.

# 2 Use Cases

## 2.1 Style guide

See the written [Style guide](https://gdrplatform.github.io/gDRstyle/articles/style_guide.html).
The function `lintPkgDirs` can be used to ensure the package is appropriately
linted.

## 2.2 CI/CD

The `checkPackage` function will check that the package abides by gDRstyle
stylistic requirements, passes `rcmdcheck`, and ensures that the
`dependencies.yml` file used to build gDR platform’s docker image is kept
up-to-date with the dependencies listed in the package’s `DESCRIPTION` file.
This is called in gDR platform packages’ CI/CD.

## 2.3 Package installation

The function `installAllDeps` assists in installing package dependencies.
For example, it’s used in gdrplatform packages (see e.g. [link](https://github.com/gdrplatform/gDR/blob/main/Dockerfile)).

# SessionInfo

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
## [1] gDRstyle_1.8.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           rex_1.2.1           jsonlite_2.0.0
##  [7] glue_1.8.0          backports_1.5.0     htmltools_0.5.8.1
## [10] sass_0.4.10         rmarkdown_2.30      evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [19] compiler_4.5.1      lintr_3.2.0         digest_0.6.37
## [22] R6_2.6.1            bslib_0.9.0         tools_4.5.1
## [25] lazyeval_0.2.2      xml2_1.4.1          cachem_1.1.0
## [28] desc_1.4.3
```