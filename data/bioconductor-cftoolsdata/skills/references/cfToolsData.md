# cfToolsData package

Ran Hu1,2,3\*, Shuo Li1, Xianghong Jasmine Zhou1,2 and Wenyuan Li1

1Department of Pathology and Laboratory Medicine, UCLA
2Institute for Quantitative and Computational Biosciences, UCLA
3Bioinformatics Interdepartmental Graduate Program, UCLA

\*huran@ucla.edu

#### 30 October 2025

#### Package

cfToolsData 1.8.0

The *[cfToolsData](https://bioconductor.org/packages/3.22/cfToolsData)* package provides two pre-trained deep neural
network (DNN) models for the *cfSort()* function in *[cfTools](https://bioconductor.org/packages/3.22/cfTools)*.

```
library(cfToolsData)
models <- c(DNN1(), DNN2())
names(models) <- c("DNN1", "DNN2")
models
```

```
##                                                        DNN1
## "/home/biocbuild/.cache/R/ExperimentHub/17a5424f197c1_8476"
##                                                        DNN2
## "/home/biocbuild/.cache/R/ExperimentHub/17a541e3f4d21_8477"
```

Users can locate the data file at the specified output file path.

It also provides the shape parameters of beta distribution characterizing
methylation markers associated with four cancer types for the
*CancerDetector()* function in *[cfTools](https://bioconductor.org/packages/3.22/cfTools)*.

```
tumorMarkerParams <- c(
    COAD.tumorMarkerParams.hg19(),
    LIHC.tumorMarkerParams.hg19(),
    LUNG.tumorMarkerParams.hg19(),
    STAD.tumorMarkerParams.hg19()
)
names(tumorMarkerParams) <- c(
    "COAD.tumorMarkerParams",
    "LIHC.tumorMarkerParams",
    "LUNG.tumorMarkerParams",
    "STAD.tumorMarkerParams"
)
tumorMarkerParams
```

```
##                                       COAD.tumorMarkerParams
## "/home/biocbuild/.cache/R/ExperimentHub/17f1e116f37a49_8470"
##                                       LIHC.tumorMarkerParams
##  "/home/biocbuild/.cache/R/ExperimentHub/17f1e1459c490_8471"
##                                       LUNG.tumorMarkerParams
## "/home/biocbuild/.cache/R/ExperimentHub/17f1e15de7cce1_8472"
##                                       STAD.tumorMarkerParams
## "/home/biocbuild/.cache/R/ExperimentHub/17f1e14a94dab2_8473"
```

Additionally, it includes the shape parameters of beta distribution
characterizing methylation markers specific to 29 primary human tissue types
for the *cfDeconvolve()* function in *[cfTools](https://bioconductor.org/packages/3.22/cfTools)*, as well as the
annotations of these markers.

```
tissueMarkerParams <- tissueMarkerParams.hg19()
tissueMarkerParams
```

```
##                                                      EH8415
## "/home/biocbuild/.cache/R/ExperimentHub/17f1e1fa43534_8474"
```

```
tissueMarkerAnnot <- tissueMarkerParams.annot()
tissueMarkerAnnot
```

```
##                                                       EH8416
## "/home/biocbuild/.cache/R/ExperimentHub/17f1e16c0239b0_8475"
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
## [1] cfToolsData_1.8.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
##  [4] BiocVersion_3.22.0   RSQLite_2.4.3        digest_0.6.37
##  [7] magrittr_2.0.4       evaluate_1.0.5       bookdown_0.45
## [10] fastmap_1.2.0        blob_1.2.4           AnnotationHub_4.0.0
## [13] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
## [16] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0
## [19] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
## [22] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
## [25] XVector_0.50.0       dbplyr_2.5.1         Biobase_2.70.0
## [28] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
## [31] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
## [34] dplyr_1.1.4          filelock_1.0.3       ExperimentHub_3.0.0
## [37] BiocGenerics_0.56.0  curl_7.0.0           vctrs_0.6.5
## [40] R6_2.6.1             png_0.1-8            stats4_4.5.1
## [43] BiocFileCache_3.0.0  lifecycle_1.0.4      Seqinfo_1.0.0
## [46] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
## [49] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
## [52] bslib_0.9.0          glue_1.8.0           xfun_0.53
## [55] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
## [58] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```