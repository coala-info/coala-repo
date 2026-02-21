# scanMiRData

Pierre-Luc Germain1,2, Michael Soutschek3 and Fridolin Groß3

1D-HEST Institute for Neuroscience, ETH
2Lab of Statistical Bioinformatics, UZH
3Lab of Systems Neuroscience, D-HEST Institute for Neuroscience, ETH

#### 4 November 2025

#### Abstract

Introduction to scanMiRData

#### Package

scanMiR 1.16.0

# Contents

* [1 Loading the collections](#loading-the-collections)
* [Session info](#session-info)

The `scanMiRData` package contains `KdModel` collections corresponding to all human, mouse and rat [mirbase](http:///mirbase.org/) miRNAs. These represent the miRNA binding affinities (or more exactly, dissociation rates) predicted using the CNN from [McGeary, Lin et al. (2019)](https://dx.doi.org/10.1126/science.aav1741). To know more about the `KdModel` and `KdModelList` classes, see the corresponding vignette in the `scanMiR` package.

# 1 Loading the collections

The objects can be loaded to the environment using `data`:

```
library(scanMiR)
data("mmu", package="scanMiRData")
summary(mmu)
```

```
## A `KdModelList` object created on 2020-11-22,
##  containing binding affinity models from 1978 miRNAs.
## Mus musculus, miRBase release 22.1
##
##               Low-confidence             Poorly conserved
##                         1215                          346
##     Conserved across mammals Conserved across vertebrates
##                          134                          203
##                         <NA>
##                           80
```

```
head(mmu)
```

```
## An object of class "KdModelList"
## [[1]]
## A `KdModel` for mmu-let-7a-1-3p (Low-confidence)
##   Sequence: CUAUACAAUCUACUGUCUUUCC
##   Canonical target seed: TTGTATA(A)
## [[2]]
## A `KdModel` for mmu-let-7a-2-3p (Low-confidence)
##   Sequence: CUGUACAGCCUCCUAGCUUUC
##   Canonical target seed: CTGTACA(A)
## [[3]]
## A `KdModel` for mmu-let-7a-5p (Conserved across vertebrates)
##   Sequence: UGAGGUAGUAGGUUGUAUAGUU
##   Canonical target seed: CTACCTC(A)
## [[4]]
## A `KdModel` for mmu-let-7b-3p (Low-confidence)
##   Sequence: CUAUACAACCUACUGCCUUCCC
##   Canonical target seed: TTGTATA(A)
## [[5]]
## A `KdModel` for mmu-let-7b-5p (Conserved across vertebrates)
##   Sequence: UGAGGUAGUAGGUUGUGUGGUU
##   Canonical target seed: CTACCTC(A)
## [[6]]
## A `KdModel` for mmu-let-7c-1-3p (Low-confidence)
##   Sequence: CUGUACAACCUUCUAGCUUUCC
##   Canonical target seed: TTGTACA(A)
```

Alternatively, they can also be loaded (and filtered) through a convenient function:

```
library(scanMiRData)
mmu <- getKdModels("mmu", categories=c("Conserved across vertebrates",
                                       "Conserved across mammals"))
summary(mmu)
```

```
## A `KdModelList` object containing binding affinity models from 337 miRNAs.
##
##               Low-confidence             Poorly conserved
##                            0                            0
##     Conserved across mammals Conserved across vertebrates
##                          134                          203
```

Summary of the other two collections:

```
summary(getKdModels("hsa"))
```

```
## A `KdModelList` object containing binding affinity models from 2656 miRNAs.
##
##               Low-confidence             Poorly conserved
##                         1913                          290
##     Conserved across mammals Conserved across vertebrates
##                          136                          192
##                         <NA>
##                          125
```

```
summary(getKdModels("rno"))
```

```
## A `KdModelList` object containing binding affinity models from 764 miRNAs.
##
##               Low-confidence             Poorly conserved
##                          482                            2
##     Conserved across mammals Conserved across vertebrates
##                          112                          165
##                         <NA>
##                            3
```

# Session info

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
## [1] scanMiRData_1.16.0 scanMiR_1.16.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10          generics_0.1.4       stringi_1.8.7
##  [4] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
##  [7] grid_4.5.1           RColorBrewer_1.1-3   bookdown_0.45
## [10] fastmap_1.2.0        jsonlite_2.0.0       BiocManager_1.30.26
## [13] scales_1.4.0         Biostrings_2.78.0    codetools_0.2-20
## [16] jquerylib_0.1.4      cli_3.6.5            rlang_1.1.6
## [19] crayon_1.5.3         XVector_0.50.0       cowplot_1.2.0
## [22] cachem_1.1.0         yaml_2.3.10          tools_4.5.1
## [25] parallel_4.5.1       BiocParallel_1.44.0  seqLogo_1.76.0
## [28] dplyr_1.1.4          ggplot2_4.0.0        BiocGenerics_0.56.0
## [31] vctrs_0.6.5          R6_2.6.1             stats4_4.5.1
## [34] lifecycle_1.0.4      pwalign_1.6.0        Seqinfo_1.0.0
## [37] S4Vectors_0.48.0     IRanges_2.44.0       pkgconfig_2.0.3
## [40] pillar_1.11.1        bslib_0.9.0          gtable_0.3.6
## [43] glue_1.8.0           data.table_1.17.8    xfun_0.54
## [46] tibble_3.3.0         GenomicRanges_1.62.0 tidyselect_1.2.1
## [49] knitr_1.50           dichromat_2.0-0.1    farver_2.1.2
## [52] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
## [55] S7_0.2.0
```