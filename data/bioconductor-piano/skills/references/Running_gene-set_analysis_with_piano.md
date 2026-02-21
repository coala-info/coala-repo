# Running gene-set anaysis with `piano`

Leif Varemo Wigge1,2

1Department of Biology and Biological Engineering, Chalmers University of Technology
2National Bioinformatics Infrastructure Sweden (NBIS), SciLifeLab

#### 30 October 2025

#### Package

piano 2.26.0

# Contents

* [1 Quick start](#quick-start)
* [2 Session info](#session-info)

# 1 Quick start

1. Load piano and example data:

```
library(piano)
data("gsa_input")
```

2. Take a look at the structure of the input data:

```
head(gsa_input$gsc,10)
```

```
##       g      s
##  [1,] "g103" "s1"
##  [2,] "g106" "s19"
##  [3,] "g118" "s16"
##  [4,] "g130" "s21"
##  [5,] "g130" "s6"
##  [6,] "g131" "s46"
##  [7,] "g132" "s32"
##  [8,] "g132" "s3"
##  [9,] "g139" "s1"
## [10,] "g140" "s21"
```

```
head(gsa_input$pvals, 10)
```

```
##           g1           g2           g3           g4           g5           g6
## 2.351900e-05 2.838832e-05 2.885141e-05 6.566243e-05 7.107615e-05 7.770070e-05
##           g7           g8           g9          g10
## 1.436830e-04 1.532264e-04 1.626607e-04 1.644806e-04
```

```
head(gsa_input$directions, 10)
```

```
##  g1  g2  g3  g4  g5  g6  g7  g8  g9 g10
##  -1  -1   1  -1  -1   1  -1  -1  -1  -1
```

3. Load gene-set collection and take a look at the resulting object:

```
geneSets <- loadGSC(gsa_input$gsc)
geneSets
```

```
## First 50 (out of 50) gene set names:
##  [1] "s1"  "s19" "s16" "s21" "s6"  "s46" "s32" "s3"  "s34" "s14" "s7"  "s13"
## [13] "s5"  "s42" "s2"  "s11" "s22" "s8"  "s15" "s10" "s33" "s37" "s35" "s43"
## [25] "s36" "s27" "s17" "s9"  "s23" "s30" "s18" "s25" "s41" "s24" "s20" "s39"
## [37] "s31" "s12" "s29" "s4"  "s26" "s44" "s28" "s47" "s38" "s49" "s50" "s40"
## [49] "s45" "s48"
##
## First 50 (out of 1136) gene names:
##  [1] "g103" "g139" "g150" "g235" "g304" "g479" "g130" "g157" "g171" "g180"
## [11] "g218" "g243" "g251" "g302" "g319" "g32"  "g329" "g372" "g373" "g403"
## [21] "g41"  "g43"  "g456" "g476" "g48"  "g521" "g527" "g554" "g581" "g585"
## [31] "g591" "g62"  "g660" "g665" "g698" "g71"  "g711" "g723" "g726" "g75"
## [41] "g758" "g77"  "g808" "g816" "g838" "g9"   "g907" "g924" "g931" "g935"
##
## Gene set size summary:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    2.00   20.50   39.00   39.50   53.75   95.00
##
## No additional info available.
```

4. Run gene-set analysis:

```
gsares <- runGSA(gsa_input$pvals,
                 gsa_input$directions,
                 gsc = geneSets,
                 nPerm = 500) # set to 500 for fast run
```

*Note: `nPerm` was set to 500 to get a short runtime for this vignette, in reality use a higher number, e.g. 10,000 (default).*

5. Explore the results in an interactive Shiny app:

```
exploreGSAres(gsares)
```

This opens a browser window with an interactive interface where the results can be explored in detail.

# 2 Session info

Here is the output of `sessionInfo()` on the system on which this document was compiled.

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
## [1] piano_2.26.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] fastmatch_1.1-6      gtable_0.3.6         xfun_0.53
##  [4] bslib_0.9.0          ggplot2_4.0.0        visNetwork_2.1.4
##  [7] shinyjs_2.1.0        htmlwidgets_1.6.4    sets_1.0-25
## [10] caTools_1.18.3       Biobase_2.70.0       lattice_0.22-7
## [13] vctrs_0.6.5          tools_4.5.1          bitops_1.0-9
## [16] generics_0.1.4       parallel_4.5.1       tibble_3.3.0
## [19] cluster_2.1.8.1      pkgconfig_2.0.3      Matrix_1.7-4
## [22] KernSmooth_2.23-26   data.table_1.17.8    RColorBrewer_1.1-3
## [25] S7_0.2.0             lifecycle_1.0.4      compiler_4.5.1
## [28] farver_2.1.2         gplots_3.2.0         statmod_1.5.1
## [31] fgsea_1.36.0         codetools_0.2-20     httpuv_1.6.16
## [34] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [37] marray_1.88.0        later_1.4.4          pillar_1.11.1
## [40] jquerylib_0.1.4      relations_0.6-15     DT_0.34.0
## [43] BiocParallel_1.44.0  cachem_1.1.0         limma_3.66.0
## [46] mime_0.13            gtools_3.9.5         tidyselect_1.2.1
## [49] digest_0.6.37        slam_0.1-55          dplyr_1.1.4
## [52] bookdown_0.45        cowplot_1.2.0        fastmap_1.2.0
## [55] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
## [58] dichromat_2.0-0.1    scales_1.4.0         promises_1.4.0
## [61] rmarkdown_2.30       igraph_2.2.1         otel_0.2.0
## [64] shiny_1.11.1         evaluate_1.0.5       knitr_1.50
## [67] rlang_1.1.6          Rcpp_1.1.0           xtable_1.8-4
## [70] glue_1.8.0           BiocManager_1.30.26  BiocGenerics_0.56.0
## [73] shinydashboard_0.7.3 jsonlite_2.0.0       R6_2.6.1
```