# ChIPexoQualExample: Accompanying example data for ChIPexoQual

Rene Welch1\* and Sündüz Keleş1,2

1Department of Biostatistics and Medical Informatics, University of Wisconsin-Madison
2Department of Statistics, University of Wisconsin-Madison

\*rwelch2@wisc.edu

#### 30 October 2025

#### Package

ChIPexoQualExample 1.34.0

# Contents

* [1 Overview](#overview)
* [2 SessionInfo](#sessioninfo)
* [References](#references)

`{r style, echo = FALSE, results = 'asis'} BiocStyle::markdown()`

# 1 Overview

*[ChIPexoQualExample](https://bioconductor.org/packages/3.22/ChIPexoQualExample)* is an the accompanying example data package for *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)*. The data was built from the FoxA1 in mouse liver experiment published by (Serandour et al. [2013](#ref-exoillumina)), by considering only the reads aligned to **chr1**. To load the package it is necessary to use:

```
library(ChIPexoQualExample, quietly = TRUE)
```

This package contains these aligned reads and an example run with *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)*:

```
## example raw files
list.files(system.file("extdata", package = "ChIPexoQualExample"))
```

```
## [1] "ChIPexo_carroll_FoxA1_mouse_rep1_chr1.bam"
## [2] "ChIPexo_carroll_FoxA1_mouse_rep1_chr1.bam.bai"
## [3] "ChIPexo_carroll_FoxA1_mouse_rep2_chr1.bam"
## [4] "ChIPexo_carroll_FoxA1_mouse_rep2_chr1.bam.bai"
## [5] "ChIPexo_carroll_FoxA1_mouse_rep3_chr1.bam"
## [6] "ChIPexo_carroll_FoxA1_mouse_rep3_chr1.bam.bai"
```

# 2 SessionInfo

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# References

Serandour, Aurelien, Brown Gordon, Joshua Cohen, and Jason Carroll. 2013. “Development of and Illumina-Based ChIP-Exonuclease Method Provides Insight into FoxA1-DNA Binding Properties.” *Genome Biology*.