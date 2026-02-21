# scanMiRApp: shiny app and related convenience functions

Pierre-Luc Germain1,2, Michael Soutschek3 and Fridolin Groß3

1D-HEST Institute for Neuroscience, ETH
2Lab of Statistical Bioinformatics, UZH
3Lab of Systems Neuroscience, D-HEST Institute for Neuroscience, ETH

#### 30 October 2025

#### Abstract

Covers the creation of ScanMiRAnno objects, setting up the shiny app, and
using the wrappers.

#### Package

scanMiRApp 1.16.0

# Contents

* [1 ScanMiRAnno objects](#scanmiranno-objects)
* [2 Convenience functions](#convenience-functions)
  + [2.1 Obtaining the UTR sequence of a transcript](#obtaining-the-utr-sequence-of-a-transcript)
  + [2.2 Plotting sites on the UTR sequence of a transcript](#plotting-sites-on-the-utr-sequence-of-a-transcript)
  + [2.3 Running a full-transcriptome scan](#running-a-full-transcriptome-scan)
  + [2.4 Detecting enriched miRNA-target pairs](#detecting-enriched-mirna-target-pairs)
* [3 Shiny app](#shiny-app)
  + [3.1 Setting up the application](#setting-up-the-application)
  + [3.2 Multi-threading](#multi-threading)
  + [3.3 Caching](#caching)
* [Session info](#session-info)

`ScanMiRApp` offers a *[shiny](https://CRAN.R-project.org/package%3Dshiny)* interface to the `scanMiR` package,
as well as convenience function to simplify its use with common annotations.

# 1 ScanMiRAnno objects

Both the shiny app and the convenience functions rely on objects of the class
`ScanMiRAnno`, which contain the different pieces of annotation relating to a
species and genome build. Annotations for human (GRCh38), mouse (GRCm38) and
rat (Rnor\_6) can be obtained as follows:

```
library(scanMiRApp)
# anno <- ScanMiRAnno("Rnor_6")
# for this vignette, we'll work with a lightweight fake annotation:
anno <- ScanMiRAnno("fake")
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
anno
```

```
## Genome: /tmp/RtmpIJWaDP/file2c3384f720f28
## Annotation: Fake falsus (fake1)
## Models: KdModelList of length 1
```

You can also build your own `ScanMiRAnno` object by providing the function with
the different components (minimally, a *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* and an
*[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* object - see `?ScanMiRAnno` for more information). For
minimal functioning with the shiny app, the `models` slot additionally needs to
be populated with a `KdModelList` (see the corresponding vignette of the
`scanMiR` package for more information).

In addition, `ScanMiRAnno` objects can contain pre-compiled scans and
aggregations, which are especially meant to speed up the shiny application.
These should be saved as [IndexedFst](IndexedFST.html) files and should be
respectively indexed by transcript and by miRNA, and stored in the `scan` and
`aggregated` slot of the object.

# 2 Convenience functions

## 2.1 Obtaining the UTR sequence of a transcript

The transcript (or UTR) sequence for any (set of) transcript(s) in the
annotation can be obtained with:

```
seq <- getTranscriptSequence("ENSTFAKE0000056456", anno)
seq
```

```
## DNAStringSet object of length 1:
##     width seq                                               names
## [1]   688 CGTATTAAATTTAGCAAGGTTCC...ACCTTCAGATTTCAGCAGACTAG ENSTFAKE0000056456
```

## 2.2 Plotting sites on the UTR sequence of a transcript

Binding sites of a given miRNA on a transcript can be visualized with:

```
plotSitesOnUTR(tx="ENSTFAKE0000056456", annotation=anno, miRNA="hsa-miR-155-5p")
```

```
## Prepare miRNA model
```

```
## Get Transcript Sequence
```

```
## Scan
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the scanMiRApp package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

This will fetch the sequence, perform the scan, and plot the results.

## 2.3 Running a full-transcriptome scan

The `runFullScan` function can be used to launch a the scan for all miRNAs on
all protein-coding transcripts (or their UTRs) of a genome. These scans can then
be used to speed up the shiny app (see below). They can simply be launched as:

```
m <- runFullScan(anno)
```

```
## Loading annotation
```

```
## Extracting transcripts
```

```
## Scanning with 1 thread(s)
```

```
m
```

```
## GRanges object with 2 ranges and 4 metadata columns:
##                 seqnames    ranges strand |     type    log_kd  p3.score  note
##                    <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <Rle>
##   [1] ENSTFAKE0000056456   281-288      * |  8mer        -4868        12 TDMD?
##   [2] ENSTFAKE0000056456   482-489      * |  7mer-m8     -3702         0     -
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Multi-threading can be enabled through the `ncores` argument. See `?runFullScan`
for more options.

## 2.4 Detecting enriched miRNA-target pairs

The `enrichedMirTxPairs` identifies miRNA-target enrichments (which could
indicate sponge- or cargo-like behaviors) by means of a binomial model
estimating the probability of the given number of binding sites for a given
pair given the total number of bindings sites for the miRNA (across all
transcripts) and transcript (across all miRNAs) in question. The output is
a data.frame indicating, for each pair passing some lenient filtering, the
transcript, miRNA, the number of 7mer/8mer sites, and the binomial log(p-value)
of the combination. We strongly recommend further filtering this list by
expression of the transcript in the system of interest, otherwise some
transcripts with very low expression (and hence biologically irrelevant) might
come up as strongly enriched.

# 3 Shiny app

The features of the shiny app are organized into two main components:

* transcript (or sequence) -centered features are available in the
  *search in gene/sequence* tab. These for instance allow to scan custom
  sequences or selected transcript sequences for miRNA binding sites, visualize
  them on the transcript, and visualize the sequence pairing of specific matches.
* the miRNA-centered features are available in the *miRNA-based* tab. It shows
  the general binding specificity of a given miRNA. If the `scanMiRAnno` object
  contained aggregated data (see below), the tab also shows the top predicted
  targets for the miRNAs.

## 3.1 Setting up the application

A `ScanMiRAnno` object is the minimal input for the shiny app, and multiple such
objects can be provided in the form of a named list:

```
scanMiRApp( list( nameOfAnnotation=anno ) )
```

Launched with this object, the app will not have access to any pre-compiled
scans or to aggregated data. This means that scans will be performed on the fly,
which also means that they will be slower. In addition, it means that the top
targets based on aggregated repression estimates (in the *miRNA-based* tab)
will not be available. To provide this additional information, you first need to
prepare the objects as [IndexedFst](IndexedFST.html) files. Assuming you’ve
saved (or downloaded) the scans as `scan.rds` and the aggregated data as
`aggregated.rds`, you can re-save them as `IndexedFst` (here in the folder
`out_path`) and add them to the `anno` object as follows:

```
# not run
anno <- ScanMiRAnno("Rnor_6")
saveIndexedFst(readRDS("scan.rds"), "seqnames", file.prefix="out_path/scan")
saveIndexedFst(readRDS("aggregated.rds"), "miRNA",
               file.prefix="out_path/aggregated")
anno$scan <- loadIndexedFst("out_path/scan")
anno$aggregated <- loadIndexedFst("out_path/aggregated")
# then launch the app
scanMiRApp(list(Rnor_6=anno))
```

The same could be done for multiple ScanMiRAnno objects. If `scanMiRApp` is
launched without any `annotation` argument, it will generate anno objects for
the three base species (without any pre-compiled data).

## 3.2 Multi-threading

Multithreading can be enabled in the shiny app by calling `scanMiRApp()` (or
the underlying `scanMiRserver()`) with the `BP` argument, e.g.:

```
scanMiRApp(..., BP=BiocParallel::MulticoreParam(ncores))
```

where `ncores` is the number of threads to use. This will enable
multi-threading for the scanning functions, which makes a big difference when
scanning for many miRNAs at a time. In addition, multi-threading can be
used to read the `IndexedFst` files, which is enabled by the `nthreads` of the
`loadIndexedFst` function. However, since reading is quite fast already with a
single core, improvements there are typically fairly marginal.

## 3.3 Caching

By default, the app has a caching system which means that if a user wants to
launch the same scan with the same parameters twice, the results will be
re-used instead of re-computed. The cache has a maximum size (by default 10MB)
per user, beyond which older cache items will be removed. The cache size can be
manipulated through the `maxCacheSize` argument.

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
##  [4] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
##  [7] fstcore_0.10.0       scanMiRApp_1.16.0    scanMiR_1.16.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] shinyjqui_0.4.1             GenomicFeatures_1.62.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] BiocIO_1.20.0               vctrs_0.6.5
##  [11] memoise_2.0.1               Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] progress_1.2.3              AnnotationHub_4.0.0
##  [19] curl_7.0.0                  SparseArray_1.10.0
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] htmlwidgets_1.6.4           httr2_1.2.1
##  [25] plotly_4.11.0               cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    mime_0.13
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [35] shiny_1.11.1                digest_0.6.37
##  [37] AnnotationDbi_1.72.0        shinycssloaders_1.1.0
##  [39] RSQLite_2.4.3               labeling_0.4.3
##  [41] seqLogo_1.76.0              filelock_1.0.3
##  [43] httr_1.4.7                  abind_1.4-8
##  [45] compiler_4.5.1              withr_3.0.2
##  [47] bit64_4.6.0-1               S7_0.2.0
##  [49] BiocParallel_1.44.0         DBI_1.2.3
##  [51] biomaRt_2.66.0              rappdirs_0.3.3
##  [53] DelayedArray_0.36.0         waiter_0.2.5.1
##  [55] rjson_0.2.23                tools_4.5.1
##  [57] otel_0.2.0                  httpuv_1.6.16
##  [59] fst_0.9.8                   glue_1.8.0
##  [61] restfulr_0.0.16             promises_1.4.0
##  [63] grid_4.5.1                  gtable_0.3.6
##  [65] tidyr_1.3.1                 ensembldb_2.34.0
##  [67] hms_1.1.4                   data.table_1.17.8
##  [69] XVector_0.50.0              stringr_1.5.2
##  [71] BiocVersion_3.22.0          pillar_1.11.1
##  [73] later_1.4.4                 rintrojs_0.3.4
##  [75] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [77] lattice_0.22-7              rtracklayer_1.70.0
##  [79] bit_4.6.0                   tidyselect_1.2.1
##  [81] Biostrings_2.78.0           knitr_1.50
##  [83] bookdown_0.45               ProtGenerics_1.42.0
##  [85] SummarizedExperiment_1.40.0 xfun_0.53
##  [87] shinydashboard_0.7.3        Biobase_2.70.0
##  [89] matrixStats_1.5.0           DT_0.34.0
##  [91] stringi_1.8.7               UCSC.utils_1.6.0
##  [93] lazyeval_0.2.2              yaml_2.3.10
##  [95] evaluate_1.0.5              codetools_0.2-20
##  [97] cigarillo_1.0.0             tibble_3.3.0
##  [99] BiocManager_1.30.26         cli_3.6.5
## [101] xtable_1.8-4                jquerylib_0.1.4
## [103] dichromat_2.0-0.1           Rcpp_1.1.0
## [105] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [107] png_0.1-8                   XML_3.99-0.19
## [109] parallel_4.5.1              ggplot2_4.0.0
## [111] blob_1.2.4                  prettyunits_1.2.0
## [113] AnnotationFilter_1.34.0     bitops_1.0-9
## [115] pwalign_1.6.0               txdbmaker_1.6.0
## [117] viridisLite_0.4.2           scales_1.4.0
## [119] scanMiRData_1.15.0          purrr_1.1.0
## [121] crayon_1.5.3                rlang_1.1.6
## [123] cowplot_1.2.0               KEGGREST_1.50.0
```