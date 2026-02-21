# Accessing RLHub Data

Henry Miller1,2

1Alex Bishop Laboratory, UT Health San Antonio
2Bioinformatics Research Network

#### 30 October 2021

#### Package

RLHub 1.0.0

# 1 Introduction

![logo](data:image/png;base64...)

RLHub (“R-Loop Hub”) provides processed data sets for the RLSuite toolchain. It is an `ExperimentHub` package containing annotations of R-Loop consensus regions, genomic features directly relevant to R-loops, such as R-loop-forming sequences (RLFS), G-or-C skew regions, and other data of relevance to RLSuite.

All data were generated via the protocol in the [RLBase-data repository](https://github.com/Bishop-Laboratory/RLBase-data).

# 2 Installation

RLHub can be installed from Bioconductor via the following command:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RLHub")
```

RLHub may also be installed from GitHub:

```
remotes::install_github("Bishop-Laboratory/RLHub")
```

# 3 Accessing RLHub Data

```
library(RLHub)
```

Data can be conveniently accessed through `ExperimentHub` functions or with the built-in accessors available through `RLHub`.

A summary of the data can also be found by running the following:

```
?`RLHub-package`
```

The full manifest of the available data is found here:

```
DT::datatable(
    read.csv(system.file("extdata", "metadata.csv", package = "RLHub")),
    options = list(
        scrollX=TRUE,
        pageLength = 5
    )
)
```

The **Tags** column list the function names used to access each data set. This method of access is detailed below.

## 3.1 Built-in functions

In the below example, we show how one can access data using convenient built-in functions.

```
# Access the R-loop binding proteins (RLBPs) data set
rlbps <- RLHub::rlbps()
DT::datatable(rlbps)
```

The data access function name is simply the value in **Tags** corresponding to the entry for that data set in the `metadata.csv` table. In this example,“rlbps” is the tag corresponding to entry #5: “R-loop-binding proteins discovered from mass-spec studies.” Therefore, the function to access this data is simply `RLHub::rlbps()`.

For examples of all accessors, please run the following:

```
?`RLHub-package`
```

## 3.2 ExperimentHub objects

```
library(ExperimentHub)
```

In this example, we show how to access RLHub data using the ExperimentHub object.

```
eh <- ExperimentHub()
rlhub <- query(eh, "RLHub")
rlhub
```

```
## ExperimentHub with 16 records
## # snapshotDate(): 2021-10-18
## # $dataprovider: Multiple
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: tbl, list, SummarizedExperiment, preProcess, caretStack
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6793"]]'
##
##            title
##   EH6793 | Primary Genomic Annotations (hg38)
##   EH6794 | Primary Genomic Annotations (mm10)
##   EH6795 | Full Genomic Annotations (hg38)
##   EH6796 | Full Genomic Annotations (mm10)
##   EH6797 | R-loop Binding Proteins
##   ...      ...
##   EH6804 | RLFS-Test Results
##   EH6805 | RLRegion Annotations
##   EH6806 | RLRegion Metadata
##   EH6807 | RLRegion Read Counts
##   EH6808 | RLBase Sample Manifest
```

If we want to obtain the R-loop-binding proteins, for example, we can do so with corresponding ExperimentHub ID.

```
rlbps <- rlhub[["EH6797"]]
DT::datatable(rlbps)
```

Finally, all package resources may be loaded as a list using `loadResources()`.

```
rlhublst <- loadResources(rlhub, package = "RLHub")
names(rlhublst) <- listResources(rlhub, package = "RLHub")
```

# 4 Session info

```
sessionInfo()
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ExperimentHub_2.2.0 AnnotationHub_3.2.0 BiocFileCache_2.2.0
## [4] dbplyr_2.1.1        BiocGenerics_0.40.0 RLHub_1.0.0
## [7] BiocStyle_2.22.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.7                    png_0.1-7
##  [3] Biostrings_2.62.0             assertthat_0.2.1
##  [5] digest_0.6.28                 utf8_1.2.2
##  [7] mime_0.12                     R6_2.5.1
##  [9] GenomeInfoDb_1.30.0           stats4_4.1.1
## [11] RSQLite_2.2.8                 evaluate_0.14
## [13] httr_1.4.2                    pillar_1.6.4
## [15] zlibbioc_1.40.0               rlang_0.4.12
## [17] curl_4.3.2                    jquerylib_0.1.4
## [19] blob_1.2.2                    S4Vectors_0.32.0
## [21] DT_0.19                       rmarkdown_2.11
## [23] stringr_1.4.0                 htmlwidgets_1.5.4
## [25] RCurl_1.98-1.5                bit_4.0.4
## [27] shiny_1.7.1                   compiler_4.1.1
## [29] httpuv_1.6.3                  xfun_0.27
## [31] pkgconfig_2.0.3               htmltools_0.5.2
## [33] tidyselect_1.1.1              KEGGREST_1.34.0
## [35] GenomeInfoDbData_1.2.7        tibble_3.1.5
## [37] interactiveDisplayBase_1.32.0 bookdown_0.24
## [39] IRanges_2.28.0                fansi_0.5.0
## [41] withr_2.4.2                   crayon_1.4.1
## [43] dplyr_1.0.7                   later_1.3.0
## [45] bitops_1.0-7                  rappdirs_0.3.3
## [47] jsonlite_1.7.2                xtable_1.8-4
## [49] lifecycle_1.0.1               DBI_1.1.1
## [51] magrittr_2.0.1                stringi_1.7.5
## [53] cachem_1.0.6                  XVector_0.34.0
## [55] promises_1.2.0.1              bslib_0.3.1
## [57] ellipsis_0.3.2                filelock_1.0.2
## [59] generics_0.1.1                vctrs_0.3.8
## [61] tools_4.1.1                   bit64_4.0.5
## [63] Biobase_2.54.0                glue_1.4.2
## [65] purrr_0.3.4                   BiocVersion_3.14.0
## [67] crosstalk_1.1.1               fastmap_1.1.0
## [69] yaml_2.2.1                    AnnotationDbi_1.56.1
## [71] BiocManager_1.30.16           memoise_2.0.0
## [73] knitr_1.36                    sass_0.4.0
```