# Data sets for the book ‘Modern Statistics for Biology’

Wolfgang Huber

#### 4 November 2025

#### Package

MSMB 1.28.0

# Contents

* [1 Demo](#demo)
* [2 Session Info](#session-info)

# 1 Demo

(Online version of the book)[<https://www.huber.embl.de//msmb>]

```
library("MSMB")
```

```
## Loading required package: tibble
```

```
dir(system.file("extdata", package = "MSMB"))
```

```
##  [1] "01126211_NB8_I025.fcs"  "01247181_NB06_I025.fcs" "02276161_NB8_I025.fcs"
##  [4] "03157141_NB06_I025.fcs" "05107251_NB06_I025.fcs" "06226101_NB8_I025.fcs"
##  [7] "07115141_NB8_I025.fcs"  "07215281_NB8_I025.fcs"  "08045071_NB8_I025.fcs"
## [10] "09225121_NB8_I025.fcs"  "10175181_NB8_I025.fcs"  "10276181_NB8_I025.fcs"
## [13] "11145351_NB8_I025.fcs"  "12015151_NB8_I025.fcs"  "PaintedTurtles.txt"
## [16] "annotation.txt"         "statecancerdeaths.csv"
```

```
dir(system.file("images", package = "MSMB"))
```

```
## [1] "hiv.png"        "image-Cy3.tif"  "image-DAPI.tif" "image-FITC.tif"
## [5] "mosquito.png"
```

```
dir(system.file("data", package = "MSMB"))
```

```
## [1] "brcalymphnode.RData"  "ukraine_coords.RData" "ukraine_dists.RData"
```

```
dir(system.file("scripts", package = "MSMB"))
```

```
## [1] "ukraine-dists.R"
```

# 2 Session Info

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
## [1] MSMB_1.28.0      tibble_3.3.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.54           magrittr_2.0.4
##  [7] glue_1.8.0          cachem_1.1.0        knitr_1.50
## [10] pkgconfig_2.0.3     htmltools_0.5.8.1   rmarkdown_2.30
## [13] lifecycle_1.0.4     cli_3.6.5           vctrs_0.6.5
## [16] sass_0.4.10         jquerylib_0.1.4     compiler_4.5.1
## [19] tools_4.5.1         pillar_1.11.1       evaluate_1.0.5
## [22] bslib_0.9.0         yaml_2.3.10         BiocManager_1.30.26
## [25] jsonlite_2.0.0      rlang_1.1.6
```