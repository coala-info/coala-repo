# marinerData package

The *marinerData* package provides some small Hi-C files for the *mariner* package vignettes and tests.

```
library(marinerData)
hicFiles <- c(
    LEUK_HEK_PJA27_inter_30.hic(),
    LEUK_HEK_PJA30_inter_30.hic()
)
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
names(hicFiles) <- c("FS", "WT")
hicFiles
```

```
##                                                          FS
## "/home/biocbuild/.cache/R/ExperimentHub/de71649df05eb_8147"
##                                                          WT
## "/home/biocbuild/.cache/R/ExperimentHub/de716144f3170_8148"
```

It also provides two sets of loop calls. The following two files correspond to the test Hi-C files described above.

```
library(marinerData)
nha9Loops <- c(
  FS_5kbLoops.txt(),
  WT_5kbLoops.txt()
)
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

Additionally, loop calls from a THP-1 activation timecourse are also provided. These cells were exposed to LPS & IF-G for 0, 30, 60, 90, 120, 240, 360, or 1440 minutes. The dataset is abbreviated as LIMA (LPS/IF-G Induced Macrophage Activation).

```
library(marinerData)
limaLoops <- c(
  LIMA_0000.bedpe(),
  LIMA_0030.bedpe(),
  LIMA_0060.bedpe(),
  LIMA_0090.bedpe(),
  LIMA_0120.bedpe(),
  LIMA_0240.bedpe(),
  LIMA_0360.bedpe(),
  LIMA_1440.bedpe()
)
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
## see ?marinerData and browseVignettes('marinerData') for documentation
```

```
## loading from cache
```

```
names(limaLoops) <- c(
  "LIMA_0000",
  "LIMA_0030",
  "LIMA_0060",
  "LIMA_0090",
  "LIMA_0120",
  "LIMA_0240",
  "LIMA_0360",
  "LIMA_1440"
)
limaLoops
```

```
##                                                    LIMA_0000
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f205b56d2ed_8168"
##                                                    LIMA_0030
##  "/home/biocbuild/.cache/R/ExperimentHub/2f3f20e6eda21_8169"
##                                                    LIMA_0060
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f20739e8212_8170"
##                                                    LIMA_0090
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f207bc1a2b4_8171"
##                                                    LIMA_0120
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f205a6d48d3_8172"
##                                                    LIMA_0240
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f2022493419_8173"
##                                                    LIMA_0360
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f203f0e98b7_8174"
##                                                    LIMA_1440
## "/home/biocbuild/.cache/R/ExperimentHub/2f3f20632c5eb6_8175"
```

# Session information

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
## [1] marinerData_1.10.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
##  [4] BiocVersion_3.22.0   RSQLite_2.4.3        digest_0.6.37
##  [7] magrittr_2.0.4       evaluate_1.0.5       fastmap_1.2.0
## [10] blob_1.2.4           AnnotationHub_4.0.0  jsonlite_2.0.0
## [13] AnnotationDbi_1.72.0 DBI_1.2.3            BiocManager_1.30.26
## [16] httr_1.4.7           purrr_1.1.0          Biostrings_2.78.0
## [19] httr2_1.2.1          jquerylib_0.1.4      cli_3.6.5
## [22] crayon_1.5.3         rlang_1.1.6          XVector_0.50.0
## [25] dbplyr_2.5.1         Biobase_2.70.0       bit64_4.6.0-1
## [28] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
## [31] tools_4.5.1          memoise_2.0.1        dplyr_1.1.4
## [34] filelock_1.0.3       ExperimentHub_3.0.0  BiocGenerics_0.56.0
## [37] curl_7.0.0           vctrs_0.6.5          R6_2.6.1
## [40] png_0.1-8            stats4_4.5.1         BiocFileCache_3.0.0
## [43] lifecycle_1.0.4      Seqinfo_1.0.0        KEGGREST_1.50.0
## [46] S4Vectors_0.48.0     IRanges_2.44.0       bit_4.6.0
## [49] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
## [52] glue_1.8.0           xfun_0.54            tibble_3.3.0
## [55] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.8.1
## [58] rmarkdown_2.30       compiler_4.5.1
```