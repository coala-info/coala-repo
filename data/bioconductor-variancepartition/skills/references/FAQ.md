# Frequently asked questions

#### Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-12-11 21:37:01

* [Interperting the residual variance](#interperting-the-residual-variance)
* [Current GitHub issues](#current-github-issues)
* [Session Info](#session-info)

# Interperting the residual variance

In general, I recommend against interpreting the fraction of variance explained by residuals. This fraction is driven by:

1. the particulars of the study design
2. measurement precision (i.e. high read counts give more precise measurements)
3. biological variability
4. technical variability (i.e. batch effects).

If you have additional variables that explain variation in measured gene expression, you should include them in order to avoid confounding with your variable of interest. But a particular residual fraction is not ‘good’ or ‘bad’ and is not a good metric of determining whether more variables should be included.

# Current GitHub issues

See [GitHub page](https://github.com/DiseaseNeuroGenomics/variancePartition/issues) for up-to-date responses to users’ questions.

# Session Info

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
## loaded via a namespace (and not attached):
##  [1] digest_0.6.39   R6_2.6.1        fastmap_1.2.0   xfun_0.54       cachem_1.1.0    knitr_1.50
##  [7] htmltools_0.5.9 rmarkdown_2.30  lifecycle_1.0.4 cli_3.6.5       sass_0.4.10     jquerylib_0.1.4
## [13] compiler_4.5.2  tools_4.5.2     evaluate_1.0.5  bslib_0.9.0     yaml_2.3.12     rlang_1.1.6
## [19] jsonlite_2.0.0
```