# Using MMAPPR2data Resources

Kyle Johnsen1

1Brigham Young University, Provo, UT

#### 5 November 2019

#### Abstract

Instructions on loading BAM files and indices in MMAPPR2data package.

#### Package

MMAPPR2data 1.0.0

---

We first load the `MMAPPR2data` package:

```
library(MMAPPR2data, quietly = TRUE)
```

This package contains the following two functions, which
provide easy access to the BAM files and their indices,
returning `BamFile` objects:

```
exampleWTbam()
```

```
## class: BamFile
## path: /tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/wt.bam
## index: /tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/wt.bam.bai
## isOpen: FALSE
## yieldSize: NA
## obeyQname: FALSE
## asMates: FALSE
## qnamePrefixEnd: NA
## qnameSuffixStart: NA
```

```
exampleMutBam()
```

```
## class: BamFile
## path: /tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/mut.bam
## index: /tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/mut.bam.bai
## isOpen: FALSE
## yieldSize: NA
## obeyQname: FALSE
## asMates: FALSE
## qnamePrefixEnd: NA
## qnameSuffixStart: NA
```

Annotation data for the region is also included with the package and can
be accessed with these two functions:

```
goldenFasta()
```

```
## [1] "/tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/slc24a5.fa.gz"
```

```
goldenGFF()
```

```
## [1] "/tmp/RtmpDyLiFb/Rinst557a7959ae48/MMAPPR2data/extdata/slc24a5.gff.gz"
```

For details on the source of these files, and on their construction
see `?MMAPPR2data` and the `inst/scripts/`folder.

```
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MMAPPR2data_1.0.0 BiocStyle_2.14.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.2             XVector_0.26.0         knitr_1.25
##  [4] magrittr_1.5           GenomicRanges_1.38.0   BiocGenerics_0.32.0
##  [7] zlibbioc_1.32.0        IRanges_2.20.0         BiocParallel_1.20.0
## [10] rlang_0.4.1            stringr_1.4.0          GenomeInfoDb_1.22.0
## [13] tools_3.6.1            parallel_3.6.1         xfun_0.10
## [16] htmltools_0.4.0        yaml_2.2.0             digest_0.6.22
## [19] bookdown_0.14          GenomeInfoDbData_1.2.2 BiocManager_1.30.9
## [22] S4Vectors_0.24.0       bitops_1.0-6           RCurl_1.95-4.12
## [25] evaluate_0.14          rmarkdown_1.16         stringi_1.4.3
## [28] compiler_3.6.1         Biostrings_2.54.0      Rsamtools_2.2.0
## [31] stats4_3.6.1
```

Thanks to Mike Love’s *[alpineData](https://bioconductor.org/packages/3.10/alpineData)* package for
vignette structure inspiration.