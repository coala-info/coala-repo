# Probabilistic Outlier Identification for RNA Sequencing Generalized Linear Models

Stefano Mangiola

#### 2025-10-30

#### Package

ppcseq 1.18.0

# 1 Introduction

Relative transcript abundance has proven to be a valuable tool for understanding the function of genes in biological systems. For the differential analysis of transcript abundance using RNA sequencing data, the negative binomial model is by far the most frequently adopted. However, common methods that are based on a negative binomial model are not robust to extreme outliers, which we found to be abundant in public datasets. So far, no rigorous and probabilistic methods for detection of outliers have been developed for RNA sequencing data, leaving the identification mostly to visual inspection. Recent advances in Bayesian computation allow large-scale comparison of observed data against its theoretical distribution given in a statistical model. Here we propose ppcseq, a key quality-control tool for identifying transcripts that include outlier data points in differential expression analysis, which do not follow a negative binomial distribution. Applying ppcseq to analyse several publicly available datasets using popular tools, we show that from 3 to 10 percent of differentially abundant transcripts across algorithms and datasets had statistics inflated by the presence of outliers.

# 2 Installation and use

The input data set is a tidy representation of a differential gene transcript abundance analysis

```
library(dplyr)
library(ppcseq)
```

To install:

Before install, for linux systems, in order to exploit multi-threading, from R write:

```
fileConn<-file("~/.R/Makevars")
writeLines(c( "CXX14FLAGS += -O3","CXX14FLAGS += -DSTAN_THREADS", "CXX14FLAGS += -pthread"), fileConn)
close(fileConn)
```

Multi-threading allows the sampling or variational bayes to share the computation on multiple cores.

Then, install with

```
if(!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ppcseq")
```

You can get the test dataset with

```
data("counts")
counts
```

```
## # A tibble: 394,821 × 9
##    sample  symbol   logCPM    LR   PValue        FDR value       W Label
##    <chr>   <chr>     <dbl> <dbl>    <dbl>      <dbl> <int>   <dbl> <chr>
##  1 10922PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   160 -0.129  High
##  2 10935PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   150 -0.127  High
##  3 10973PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   146 -0.426  High
##  4 10976PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   347 -0.0164 High
##  5 10985PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   175 -0.135  High
##  6 11026PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   244  0.125  High
##  7 11045PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   399 -0.0892 High
##  8 11082PP SLC16A12   1.39  41.1 1.46e-10 0.00000274   100  0.261  Neoadjuvant
##  9 11086PP SLC16A12   1.39  41.1 1.46e-10 0.00000274    37 -0.132  Neoadjuvant
## 10 11103PP SLC16A12   1.39  41.1 1.46e-10 0.00000274    73  0.146  Neoadjuvant
## # ℹ 394,811 more rows
```

You can identify anrtefactual calls from your differential transcribt anundance analysis, due to outliers.

```
# Import libraries

if(Sys.info()[['sysname']] == "Linux")
counts.ppc =
    counts %>%
    mutate(is_significant = FDR < 0.0001) %>%
    identify_outliers(
        formula = ~ Label,
        .sample = sample,
        .transcript = symbol,
        .abundance = value,
        .significance = PValue,
        .do_check = is_significant,
        percent_false_positive_genes = 5,
        approximate_posterior_inference = FALSE,
        cores = 1,

        # This is ONLY for speeding up the Vignette execution
        draws_after_tail = 1
    )
```

The new posterior predictive check has been added to the original data frame

```
if(Sys.info()[['sysname']] == "Linux")
counts.ppc
```

```
## # A tibble: 1 × 4
##   symbol   sample_wise_data   ppc_samples_failed tot_deleterious_outliers
##   <chr>    <list>                          <int>                    <int>
## 1 SLC16A12 <tibble [21 × 13]>                  0                        0
```

The new data frame contains plots for each gene

We can visualise the top five differentially transcribed genes

```
if(Sys.info()[['sysname']] == "Linux")
counts.ppc_plots =
    counts.ppc %>%
    plot_credible_intervals()
```

```
if(Sys.info()[['sysname']] == "Linux")
counts.ppc_plots %>%
    pull(plot) %>%
    .[seq_len(1)]
```

```
## [[1]]
```

![](data:image/png;base64...)

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
## [1] ppcseq_1.18.0       rstan_2.32.7        StanHeaders_2.32.10
## [4] dplyr_1.1.4         knitr_1.50          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] benchmarkmeData_1.0.4 gtable_0.3.6          tensorA_0.36.2.1
##  [4] xfun_0.53             bslib_0.9.0           ggplot2_4.0.0
##  [7] QuickJSR_1.8.1        inline_0.3.21         lattice_0.22-7
## [10] vctrs_0.6.5           tools_4.5.1           generics_0.1.4
## [13] stats4_4.5.1          curl_7.0.0            parallel_4.5.1
## [16] tibble_3.3.0          pkgconfig_2.0.3       Matrix_1.7-4
## [19] checkmate_2.3.3       RColorBrewer_1.1-3    S7_0.2.0
## [22] distributional_0.5.0  RcppParallel_5.1.11-1 lifecycle_1.0.4
## [25] stringr_1.5.2         compiler_4.5.1        farver_2.1.2
## [28] tinytex_0.57          statmod_1.5.1         codetools_0.2-20
## [31] htmltools_0.5.8.1     sass_0.4.10           yaml_2.3.10
## [34] pillar_1.11.1         jquerylib_0.1.4       tidyr_1.3.1
## [37] arrayhelpers_1.1-0    cachem_1.1.0          limma_3.66.0
## [40] magick_2.9.0          iterators_1.0.14      foreach_1.5.2
## [43] abind_1.4-8           posterior_1.6.1       tidybayes_3.0.7
## [46] tidyselect_1.2.1      locfit_1.5-9.12       digest_0.6.37
## [49] svUnit_1.0.8          stringi_1.8.7         purrr_1.1.0
## [52] bookdown_0.45         labeling_0.4.3        fastmap_1.2.0
## [55] grid_4.5.1            cli_3.6.5             magrittr_2.0.4
## [58] loo_2.8.0             utf8_1.2.6            dichromat_2.0-0.1
## [61] pkgbuild_1.4.8        withr_3.0.2           edgeR_4.8.0
## [64] scales_1.4.0          backports_1.5.0       httr_1.4.7
## [67] rmarkdown_2.30        matrixStats_1.5.0     benchmarkme_1.0.8
## [70] gridExtra_2.3         coda_0.19-4.1         evaluate_1.0.5
## [73] doParallel_1.0.17     V8_8.0.1              ggdist_3.3.3
## [76] rstantools_2.5.0      rlang_1.1.6           Rcpp_1.1.0
## [79] glue_1.8.0            BiocManager_1.30.26   jsonlite_2.0.0
## [82] R6_2.6.1
```