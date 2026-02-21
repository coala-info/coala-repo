# RNAmodR: creating classes for additional modification detection from high throughput sequencing.

Felix G.M. Ernst

#### 2025-10-30

#### Package

RNAmodR 1.24.0

# 1 Introduction

For users interested in the general aspect of any `RNAmodR` based package please
have a look at the [main vignette](RNAmodR.html) of the package.

This vignette is aimed at developers and researchers, who want to use the
functionality of the `RNAmodR` package to develop a new modification strategy
based on high throughput sequencing data.

```
library(RNAmodR)
```

Two classes have to be considered to establish a new analysis pipeline using
`RNAmodR`. These are the `SequenceData` and the `Modifier` class.

# 2 A new `SequenceData` class

First, the `SequenceData` class has to be considered. Several classes are
already implemented, which are:

* `End5SequenceData`
* `End3SequenceData`
* `EndSequenceData`
* `ProtectedEndSequenceData`
* `CoverageSequenceData`
* `PileupSequenceData`
* `NormEnd5SequenceData`
* `NormEnd3SequenceData`

If these cannot be reused, a new class can be implemented quite easily. First
the DataFrame class, the Data class and a constructor has to defined. The only
value, which has to be provided, is a default `minQuality` integer value and
some basic information.

```
setClass(Class = "ExampleSequenceDataFrame",
         contains = "SequenceDFrame")
ExampleSequenceDataFrame <- function(df, ranges, sequence, replicate,
                                      condition, bamfiles, seqinfo){
  RNAmodR:::.SequenceDataFrame("Example",df, ranges, sequence, replicate,
                               condition, bamfiles, seqinfo)
}
setClass(Class = "ExampleSequenceData",
         contains = "SequenceData",
         slots = c(unlistData = "ExampleSequenceDataFrame"),
         prototype = list(unlistData = ExampleSequenceDataFrame(),
                          unlistType = "ExampleSequenceDataFrame",
                          minQuality = 5L,
                          dataDescription = "Example data"))
ExampleSequenceData <- function(bamfiles, annotation, sequences, seqinfo, ...){
  RNAmodR:::SequenceData("Example", bamfiles = bamfiles,
                         annotation = annotation, sequences = sequences,
                         seqinfo = seqinfo, ...)
}
```

Second, the `getData` function has to be implemented. This is used to load
the data from a bam file and must return a named list `IntegerList`,
`NumericList` or `CompressedSplitDataFrameList` per file.

```
setMethod("getData",
          signature = c(x = "ExampleSequenceData",
                        bamfiles = "BamFileList",
                        grl = "GRangesList",
                        sequences = "XStringSet",
                        param = "ScanBamParam"),
          definition = function(x, bamfiles, grl, sequences, param, args){
            ###
          }
)
```

Third, the `aggregate` function has to be implemented. This function is used to
aggregate data over replicates for all or one of the conditions. The resulting
data is passed on to the `Modifier` class.

```
setMethod("aggregateData",
          signature = c(x = "ExampleSequenceData"),
          function(x, condition = c("Both","Treated","Control")){
            ###
          }
)
```

# 3 A new `Modifier` class

A new `Modifier` class is probably the main class, which needs to be
implemented. Three variable have to be set. `mod` must be a single element from
the `Modstrings::shortName(Modstrings::ModRNAString())`. `score` is the default
score, which is used for several function. A column with this name should be
returned from the `aggregate` function. `dataType` defines the `SequenceData`
class to be used. `dataType` can contain multiple names of a `SequenceData`
class, which are then combined to form a `SequenceDataSet`.

```
setClass("ModExample",
         contains = c("RNAModifier"),
         prototype = list(mod = "X",
                          score = "score",
                          dataType = "ExampleSequenceData"))
ModExample <- function(x, annotation, sequences, seqinfo, ...){
  RNAmodR:::Modifier("ModExample", x = x, annotation = annotation,
                     sequences = sequences, seqinfo = seqinfo, ...)
}
```

`dataType` can also be a `list` of `character` vectors, which leads then to the
creation of `SequenceDataList`. However, for now this is a hypothetical case and
should only be used, if the detection of a modification requires bam files from
two or more different methods to be used to detect one modification.

The `settings<-` function can be amended to save specifc settings (
`.norm_example_args` must be defined seperatly to normalize input arguments in
any way one sees fit).

```
setReplaceMethod(f = "settings",
                 signature = signature(x = "ModExample"),
                 definition = function(x, value){
                   x <- callNextMethod()
                   # validate special setting here
                   x@settings[names(value)] <- unname(.norm_example_args(value))
                   x
                 })
```

The `aggregateData` function is used to take the aggregated data from the
`SequenceData` object and to calculate the specific scores, which are then
stored in the `aggregate` slot.

```
setMethod(f = "aggregateData",
          signature = signature(x = "ModExample"),
          definition =
            function(x, force = FALSE){
              # Some data with element per transcript
            }
)
```

The `findMod` function takes the aggregate data and searches for modifications,
which are then returned as a GRanges object and stored in the `modifications`
slot.

```
setMethod("findMod",
          signature = c(x = "ModExample"),
          function(x){
            # an element per modification found.
          }
)
```

## 3.1 A new `ModifierSet` class

The `ModifierSet` class is implemented very easily by defining the class and
the constructor. The functionality is defined by the `Modifier` class.

```
setClass("ModSetExample",
         contains = "ModifierSet",
         prototype = list(elementType = "ModExample"))
ModSetExample <- function(x, annotation, sequences, seqinfo, ...){
  RNAmodR:::ModifierSet("ModExample", x = x, annotation = annotation,
                        sequences = sequences, seqinfo = seqinfo, ...)
}
```

# 4 Visualization functions

Additional functions, which need to be implemented, are `getDataTrack` for the
new `SequenceData` and new `Modifier` classes and
`plotData`/`plotDataByCoord` for the new `Modifier` and `ModifierSet`
classes. `name` defines a transcript name found in `names(ranges(x))` and
`type` is the data type typically found as a column in the `aggregate` slot.

```
setMethod(
  f = "getDataTrack",
  signature = signature(x = "ExampleSequenceData"),
  definition = function(x, name, ...) {
    ###
  }
)
setMethod(
  f = "getDataTrack",
  signature = signature(x = "ModExample"),
  definition = function(x, name, type, ...) {
  }
)
setMethod(
  f = "plotDataByCoord",
  signature = signature(x = "ModExample", coord = "GRanges"),
  definition = function(x, coord, type = "score", window.size = 15L, ...) {
  }
)
setMethod(
  f = "plotData",
  signature = signature(x = "ModExample"),
  definition = function(x, name, from, to, type = "score", ...) {
  }
)
setMethod(
  f = "plotDataByCoord",
  signature = signature(x = "ModSetExample", coord = "GRanges"),
  definition = function(x, coord, type = "score", window.size = 15L, ...) {
  }
)
setMethod(
  f = "plotData",
  signature = signature(x = "ModSetExample"),
  definition = function(x, name, from, to, type = "score", ...) {
  }
)
```

If unsure, how to modify these functions, have a look a the code in the
`Modifier-Inosine-viz.R` file of this package.

# 5 Summary

As suggested directly above, for a more detailed example have a look at the
`ModInosine` class source code found in the `Modifier-Inosine-class.R` and
`Modifier-Inosine-viz.R` files of this package.

# 6 Sessioninfo

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] RNAmodR_1.24.0           Modstrings_1.26.0        RNAmodR.Data_1.23.0
##  [4] ExperimentHubData_1.36.0 AnnotationHubData_1.40.0 futile.logger_1.4.3
##  [7] ExperimentHub_3.0.0      AnnotationHub_4.0.0      BiocFileCache_3.0.0
## [10] dbplyr_2.5.1             txdbmaker_1.6.0          GenomicFeatures_1.62.0
## [13] AnnotationDbi_1.72.0     Biobase_2.70.0           Rsamtools_2.26.0
## [16] Biostrings_2.78.0        XVector_0.50.0           rtracklayer_1.70.0
## [19] GenomicRanges_1.62.0     Seqinfo_1.0.0            IRanges_2.44.0
## [22] S4Vectors_0.48.0         BiocGenerics_0.56.0      generics_0.1.4
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] vctrs_0.6.5                 ROCR_1.0-11
##  [11] memoise_2.0.1               RCurl_1.98-1.17
##  [13] base64enc_0.1-3             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] BiocBaseUtils_1.12.0        progress_1.2.3
##  [19] lambda.r_1.2.4              curl_7.0.0
##  [21] SparseArray_1.10.0          Formula_1.2-5
##  [23] sass_0.4.10                 bslib_0.9.0
##  [25] htmlwidgets_1.6.4           plyr_1.8.9
##  [27] Gviz_1.54.0                 httr2_1.2.1
##  [29] futile.options_1.0.1        cachem_1.1.0
##  [31] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [33] pkgconfig_2.0.3             Matrix_1.7-4
##  [35] R6_2.6.1                    fastmap_1.2.0
##  [37] BiocCheck_1.46.0            MatrixGenerics_1.22.0
##  [39] digest_0.6.37               colorspace_2.1-2
##  [41] OrganismDbi_1.52.0          Hmisc_5.2-4
##  [43] RSQLite_2.4.3               labeling_0.4.3
##  [45] filelock_1.0.3              colorRamps_2.3.4
##  [47] httr_1.4.7                  abind_1.4-8
##  [49] compiler_4.5.1              withr_3.0.2
##  [51] bit64_4.6.0-1               htmlTable_2.4.3
##  [53] S7_0.2.0                    biocViews_1.78.0
##  [55] backports_1.5.0             BiocParallel_1.44.0
##  [57] DBI_1.2.3                   biomaRt_2.66.0
##  [59] rappdirs_0.3.3              DelayedArray_0.36.0
##  [61] rjson_0.2.23                tools_4.5.1
##  [63] foreign_0.8-90              nnet_7.3-20
##  [65] glue_1.8.0                  restfulr_0.0.16
##  [67] grid_4.5.1                  stringdist_0.9.15
##  [69] checkmate_2.3.3             reshape2_1.4.4
##  [71] cluster_2.1.8.1             gtable_0.3.6
##  [73] BSgenome_1.78.0             ensembldb_2.34.0
##  [75] data.table_1.17.8           hms_1.1.4
##  [77] BiocVersion_3.22.0          pillar_1.11.1
##  [79] stringr_1.5.2               dplyr_1.1.4
##  [81] lattice_0.22-7              deldir_2.0-4
##  [83] bit_4.6.0                   biovizBase_1.58.0
##  [85] tidyselect_1.2.1            RBGL_1.86.0
##  [87] knitr_1.50                  gridExtra_2.3
##  [89] bookdown_0.45               ProtGenerics_1.42.0
##  [91] SummarizedExperiment_1.40.0 xfun_0.53
##  [93] matrixStats_1.5.0           stringi_1.8.7
##  [95] UCSC.utils_1.6.0            lazyeval_0.2.2
##  [97] yaml_2.3.10                 evaluate_1.0.5
##  [99] codetools_0.2-20            cigarillo_1.0.0
## [101] interp_1.1-6                tibble_3.3.0
## [103] BiocManager_1.30.26         graph_1.88.0
## [105] cli_3.6.5                   rpart_4.1.24
## [107] jquerylib_0.1.4             Rcpp_1.1.0
## [109] dichromat_2.0-0.1           GenomeInfoDb_1.46.0
## [111] png_0.1-8                   XML_3.99-0.19
## [113] RUnit_0.4.33.1              parallel_4.5.1
## [115] ggplot2_4.0.0               blob_1.2.4
## [117] prettyunits_1.2.0           jpeg_0.1-11
## [119] latticeExtra_0.6-31         AnnotationFilter_1.34.0
## [121] AnnotationForge_1.52.0      bitops_1.0-9
## [123] VariantAnnotation_1.56.0    scales_1.4.0
## [125] purrr_1.1.0                 crayon_1.5.3
## [127] rlang_1.1.6                 KEGGREST_1.50.0
## [129] formatR_1.14
```