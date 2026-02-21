# interacCircos

#### Zhe Cui

#### 2025-10-30

## Introduction

JavaScript-based Circos libraries have been widely implemented to generate interactive Circos plots on web applications. However, these libraries require either local installation that requires compiling extra libraries or extra data processing procedures to prepare input and configuration for each track of plot, which limits the utility and capability of integration with powerful packages of R. Here, we present interacCircos, an R package for creating interactive Circos plots through the intregration of JavaScript-based libraries. interacCircos can simply and flexibly implement 14 track-plot functions and 7 auxiliary functions for presenting large-scale genomic data in interactive Circos plots.

## Quick Start

The Quick Start step for interacCircos is available at <https://mrcuizhe.github.io/interacCircos_documentation/html/quick_start.html>

## Example

### Default genome track

```
library(interacCircos)
Circos(width = 700,height = 550)
```

### Try changing genome list and its color

```
library(interacCircos)
Circos(zoom = TRUE,genome=list("Example1"=100,"Example2"=200,
      "Example3"=300),genomeFillColor = c("red","blue","green"),
      width = 700,height = 550)
```

### Try automatically filling genome color

```
library(interacCircos)
set.seed(1)
Circos(zoom = FALSE,genome=list("Example1"=100,"Example2"=200,
      "Example3"=300),genomeFillColor = "Blues",
      width = 700,height = 550)
```

### Simple example with multiple modules

#### Histogram module

```
library(interacCircos)

histogramData <- histogramExample
Circos(moduleList=CircosHistogram('HISTOGRAM01', data = histogramData,
      fillColor= "#ff7f0e",maxRadius = 210,minRadius = 175,
      animationDisplay = TRUE),genome=list("2L"=23011544,"2R"=21146708,"3L"=24543557,"3R"= 27905053,"X"=22422827,"4"=1351857),
      outerRadius = 220, width = 700,height = 550)
```

#### SNP and Background module

```
library(interacCircos)

snpData <- snpExample
Circos(moduleList=CircosSnp('SNP01', minRadius =150,
      maxRadius = 190, data = snpExample,SNPFillColor= "#9ACD32",
      circleSize= 2, SNPAxisColor= "#B8B8B8", SNPAxisWidth= 0.5,
      animationDisplay=TRUE,animationTime= 2000, animationDelay= 0,
      animationType= "linear") +
      CircosBackground('BG01',minRadius = 145,maxRadius = 200),
      width = 700,height = 550)
```

## Session info

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
## [1] interacCircos_1.20.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37      RColorBrewer_1.1-3 R6_2.6.1           fastmap_1.2.0
##  [5] xfun_0.53          cachem_1.1.0       knitr_1.50         htmltools_0.5.8.1
##  [9] rmarkdown_2.30     lifecycle_1.0.4    cli_3.6.5          sass_0.4.10
## [13] jquerylib_0.1.4    compiler_4.5.1     plyr_1.8.9         tools_4.5.1
## [17] evaluate_1.0.5     bslib_0.9.0        Rcpp_1.1.0         yaml_2.3.10
## [21] htmlwidgets_1.6.4  rlang_1.1.6        jsonlite_2.0.0
```

## Document

Please visit <https://mrcuizhe.github.io/interacCircos_documentation/index.html> for a full document of interacCircos.

## Contact

Please visit <https://github.com/mrcuizhe/interacCircos/issues> for bug issues or contact cuizhet[at]hit.edu.cn for helping.