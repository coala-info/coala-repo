# plotgardenerData

#### Nicole Kramer

# Sample experimental data

This package provides subsets of publicly available Hi-C, ChIP-seq, DNA looping, GWAS, and COVID-19 datasets. The genomic datasets are all in reference to the `hg19` genome build. These datasets are included in the `data` directory and can be loaded with the `data()` call:

```
library(plotgardenerData)
data("IMR90_HiC_10kb")
```

The full versions of these datasets can be found at the citations provided in each data documentation file (e.g. `?IMR90_HiC_10kb`).

The `plotgardener` vignettes detail how to visualize these datasets.

# Sample raw files

Small, example `.bigwig` and `.hic` files are included in the `inst/extdata` directory to demonstrate the functionality of the `plotgardener` functions `readBigwig` and `readHic`:

```
bwFile <- system.file("extdata/test.bw", package = "plotgardenerData")
hicFile <- system.file("extdata/test_chr22.hic", package = "plotgardenerData")
```

# Session info

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
## [1] plotgardenerData_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.54
##  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
##  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
## [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
## [17] yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```