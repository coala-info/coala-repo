# Run PathoStat

#### Solaiappan Manimaran, Yue Zhao

#### 2025-10-30

## Introduction

PathoStat is a R shiny package, designed for performing Statistical Microbiome Analysis on metagenomics results from sequencing data samples. In particular, it supports analyses on the PathoScope generated report files.

The package includes:

* Data Summary and Filtering
* Relative Abundance plots (Stacked Bar Plot, Heatmap)
* Multiple species boxplot visualization
* Diversity analysis (Alpha and Beta diversity)
* Differential Expression (DEseq2, edgeR)
* Dimension Reduction (PCA, PCoA)
* Biomarker identification

## Installation

To begin, install [Bioconductor](http://www.bioconductor.org/) and simply run the following to automatically install PathoStat and all the dependencies as follows.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("PathoStat")
```

If you want to install the latest development version of PathoStat from Github, use [devtools](https://github.com/hadley/devtools) to install it as follows:

```
require(devtools)
install_github("mani2012/PathoStat", build_vignettes=TRUE)
```

## Run Pathostat

```
require(PathoStat)
runPathoStat()
```

# Session info

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
#>  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
#>  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
#> [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
#> [17] yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```