# Herper Quick Start Guide

Matt Paul - mpaul@rockefeller.edu

#### 10/30/2025

#### Package

Herper 1.20.0

# Contents

* [0.1 Installation](#installation)
* [0.2 Install Conda packages with **install\_CondaTools**.](#install-conda-packages-with-install_condatools.)
* [0.3 Install R package dependencies with **install\_CondaSysReqs**.](#install-r-package-dependencies-with-install_condasysreqs.)
* [0.4 Acknowledgements](#acknowledgements)
* [0.5 Session Information](#session-information)

The Herper package is a simple toolset to install and manage Conda packages and environments from R.

The Herper package was developed by [Matt Paul](https://github.com/matthew-paul-2006), [Doug Barrows](https://github.com/dougbarrows) and [Thomas Carroll](https://github.com/ThomasCarroll) at the [Rockefeller University Bioinformatics Resources Center](https://rockefelleruniversity.github.io) with contributions from [Kathryn Rozen-Gagnon](https://github.com/kathrynrozengagnon).

---

This Quick start gives a brief intro into getting up and running with Herper. Check the [documentation website](https://rockefelleruniversity.github.io/Herper_Page/) for more detailed information and use case examples.

## 0.1 Installation

Use the `BiocManager` package to download and install the package from our Github repository:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Herper")
```

Once installed, load it into your R session:

```
library(Herper)
```

## 0.2 Install Conda packages with **install\_CondaTools**.

The **install\_CondaTools()** function allows the user to specify required Conda software and the desired environment to install into.

Miniconda is installed as part of the process (by default into the r-reticulate’s default Conda location). If you already have Miniconda installed (or want to control the location of miniconda installation), you can specify the path with the *pathToMiniConda* parameter.

```
myMiniconda <- file.path(tempdir(),"Test")
install_CondaTools("salmon==1.3.0", "herper", pathToMiniConda = myMiniconda)
```

## 0.3 Install R package dependencies with **install\_CondaSysReqs**.

The **install\_CondaSysReqs** checks the System Requirements for the specified R package, and uses Conda to install this software.

```
testPkg <- system.file("extdata/HerperTestPkg",package="Herper")
install.packages(testPkg,type = "source",repos = NULL)
condaDir <- file.path(tempdir(),"r-miniconda")
condaPaths <- install_CondaSysReqs("HerperTestPkg", pathToMiniConda = myMiniconda,SysReqsAsJSON=FALSE)
#' system2(file.path(condaPaths$pathToEnvBin,"samtools"),args = "--help")
```

## 0.4 Acknowledgements

Thank you to Ji-Dung Luo and Wei Wang for testing/vignette review/critical feedback and Ziwei Liang for their support.

## 0.5 Session Information

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Herper_1.20.0     reticulate_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6         xfun_0.53
##  [5] png_0.1-8           jsonlite_2.0.0      rjson_0.2.23        htmltools_0.5.8.1
##  [9] sass_0.4.10         rmarkdown_2.30      grid_4.5.1          evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [17] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1      Rcpp_1.1.0
## [21] lattice_0.22-7      digest_0.6.37       R6_2.6.1            bslib_0.9.0
## [25] Matrix_1.7-4        withr_3.0.2         tools_4.5.1         cachem_1.1.0
```