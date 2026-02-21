# Introduction to singleCellTK

Yichen Wang1, Irzam Sarfraz1, Rui Hong1,2, Yusuke Koga1,2, Salam Abdullatif1, Nida Pervaiz1, David Jenkins1,2, Vidya Akavoor3, Xinyun Cao3, Shruthi Bandyadka1,2, Anastasia Leshchyk1,2, Tyler Faits1,2, Mohammed Muzamil Khan1,2, Zhe Wang1,2, W. Evan Johnson1,2, Ming Liu1,2 and Joshua D. Campbell1,2\*

1The Section of Computational Biomedicine, Boston University School of Medicine, Boston, MA
2Program in Bioinformatics, Boston University, Boston, MA
3Rafik B. Hariri Institute for Computing and Computational Science and Engineering, Boston University, Boston, MA

\*camp@bu.edu

#### 22 January 2026

#### Package

singleCellTK 2.20.1

# Contents

* [1 Vignettes](#vignettes)
* [Session info](#session-info)

The Single Cell Toolkit (SCTK) is an interactive scRNA-Seq analysis package that
allows a user to upload raw scRNA-Seq count matrices and perform downstream
scRNA-Seq analysis interactively through a web interface, or through a set of
R functions through the command line. The package is written in R with a
graphical user interface (GUI) written in Shiny. Users can perform analysis with
modules for conducting quality control, clustering, batch correction, differential
expression, pathway enrichment, and sample size calculator, all in a simple to
use point and click interface. The toolkit also supports command line data
processing, and results can be loaded into the GUI for additional exploration
and downstream analysis.

# 1 Vignettes

Due to the range of features that are available in SCTK, we have prepared several
vignettes to help you get started, which are all available at <https://www.camplab.net/sctk/>

# Session info

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
##  [1] digest_0.6.39       R6_2.6.1            bookdown_0.46
##  [4] fastmap_1.2.0       xfun_0.56           cachem_1.1.0
##  [7] knitr_1.51          htmltools_0.5.9     rmarkdown_2.30
## [10] lifecycle_1.0.5     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.2      tools_4.5.2
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.12
## [19] otel_0.2.0          BiocManager_1.30.27 jsonlite_2.0.0
## [22] rlang_1.1.7
```