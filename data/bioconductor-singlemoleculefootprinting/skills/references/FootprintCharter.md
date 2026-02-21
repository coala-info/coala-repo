# FootprintCharter

## Introduction

This vignette exemplifies how to perform unsupervised footprint detection and quantification using *FootprintCharter* as per Baderna & Barzaghi et al., 2024 and Barzaghi et al., 2024.

*FootprintCharter* partitions molecules by their methylation patterns without relying on orthogonal genomic annotations such as TF motifs.
At the core, *FootprintCharter* performs a series of filtering steps to obtain a dense matrix of cytosines spanning 80bps. The molecules populating this matrix are than partitioned using the *k*-medoids algorithm. Footprints for TFs and nucleosomes are then detected by segmenting the average SMF signal separately for each partition. Optionally, TF footprints can be annotated with a given list of annotated motifs. Finally, biologically equivalent TF footprints are aggregated based on coordinates overlaps. For more details consult Barzaghi et al., 2024.

## Loading libraries

```
suppressWarnings(library(SingleMoleculeFootprinting))
suppressWarnings(library(GenomicRanges))
suppressWarnings(library(tidyverse))
suppressWarnings(library(ggplot2))
```

## Prepare inputs

```
Methylation = qs::qread(system.file("extdata", "Methylation_4.qs", package="SingleMoleculeFootprinting"))
MethSM = Methylation[[2]]
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))
RegionOfInterest = IRanges::resize(RegionOfInterest, 80, "center")
```

## Run FootprintCharter

The function *FootprintCharter* is tuned with 5 key parameters

* *k*, the number of desired partitions. This number is better set higher than lower. The tool will reduce it iteratively if partitions are not covered enough (set by *n*).
* *n*, the minimum number of molecules per partition.
* *TF.length*, length thresholds of expected TF footprints (in bps).
* *nucleosome.length*, length thresholds of expected nucleosome footprints (in bps).
* *cytosine.coverage.thr*, discards cytosines not covered enough from footprint detection step.

```
FootprintCharter(
  MethSM = MethSM,
  RegionOfInterest = RegionOfInterest,
  coverage = 30,
  k = 16,
  n = 5,
  TF.length = c(5,75),
  nucleosome.length = c(120,1000),
  cytosine.coverage.thr = 5,
  verbose = TRUE
) -> FC_results
## 1. Pooling molecules from all samples
## 2. Computing sliding windows
## Discarding 1973/2233 molecules that do not entirely cover the RegionOfInterest
## Discarding 41/59 cytosines that are NA in more than 0% of the reads
## Discarding 0/260 molecules that have NAs in more than 0% of the remaining cytosines
## 3. computing distance matrix
## 4. Partitioning
## partitions too slim detected...retrying with k=15
## partitions too slim detected...retrying with k=14
## partitions too slim detected...retrying with k=13
## partitions too slim detected...retrying with k=12
## partitions too slim detected...retrying with k=11
## partitions too slim detected...retrying with k=10
## partitions too slim detected...retrying with k=9
## partitions too slim detected...retrying with k=8
## 5. Footprints detection
## 6. Footprints annotation (skipping)
## 7. Footprints aggregation
## 8. Results wrangling
```

The function *FootprintCharter* outputs a list of two items.
The first is a vector of *partitioned.molecules*, structured in the same way as the one output by the function *SortReads*.

```
rrapply::rrapply(FC_results$partitioned.molecules, f = head, n = 2)
## $SMF_MM_TKO_DE_
## $SMF_MM_TKO_DE_$`1`
## [1] "D00404:273:H5757BCXY:1:1102:14949:3420"
## [2] "D00404:273:H5757BCXY:1:2116:7810:26400"
##
## $SMF_MM_TKO_DE_$`2`
## [1] "D00404:273:H5757BCXY:1:1102:20457:73436"
## [2] "D00404:273:H5757BCXY:1:1110:7624:25325"
##
## $SMF_MM_TKO_DE_$`3`
## [1] "D00404:273:H5757BCXY:1:1205:4416:100764"
## [2] "D00404:273:H5757BCXY:1:1206:16663:42295"
##
## $SMF_MM_TKO_DE_$`4`
## [1] "D00404:273:H5757BCXY:1:1209:3401:67031"
## [2] "D00404:273:H5757BCXY:1:2215:17233:16460"
##
## $SMF_MM_TKO_DE_$`5`
## [1] "D00404:273:H5757BCXY:1:1211:14401:50622"
## [2] "D00404:273:H5757BCXY:2:1101:1697:87040"
##
## $SMF_MM_TKO_DE_$`6`
## [1] "D00404:273:H5757BCXY:1:1215:8843:22685"
## [2] "D00404:273:H5757BCXY:2:1107:2792:41093"
##
## $SMF_MM_TKO_DE_$`7`
## [1] "D00404:273:H5757BCXY:1:2212:1496:27605"
## [2] "D00404:273:H5757BCXY:2:1102:9323:16615"
##
## $SMF_MM_TKO_DE_$`8`
## [1] "D00404:273:H5757BCXY:2:1103:16878:7787"
## [2] "D00404:283:HCFT7BCXY:2:1103:6140:48231"
```

The second is a data.frame of detected footprints. The *biological.state* column indicates the putative nature of the detected footprints and it can be either of TF, nucleosome, accessible, unrecognized and noise.
The last two represent cases in which footprints couldn’t be interpreted either because too short (noise) or because they are detected at the edge of molecules and hence their true width cannot be established.

```
head(FC_results$footprints.df)
##   partition.nr         sample partition.coverage    start      end width
## 1            2 SMF_MM_TKO_DE_                 47 88106070 88106131    62
## 2            1 SMF_MM_TKO_DE_                 46 88106098 88106209   112
## 3            3 SMF_MM_TKO_DE_                 42 88106098 88106104     7
## 4            3 SMF_MM_TKO_DE_                 42 88106105 88106209   105
## 5            6 SMF_MM_TKO_DE_                 21 88106113 88106113     1
## 6            7 SMF_MM_TKO_DE_                 40 88106113 88106317   205
##   nr.cytosines biological.state seqnames TF TF.name footprint.idx
## 1            6       accessible     chr6 NA      NA             9
## 2           15       accessible     chr6 NA      NA             1
## 3            1     unrecognized     chr6 NA      NA            36
## 4           14       accessible     chr6 NA      NA             1
## 5            1            noise     chr6 NA      NA            40
## 6           30       accessible     chr6 NA      NA             1
```

Optionally, it is possible to annotate TF footprints by providing the argument *TFBSs* with user-provided motifs. *TFBSs* needs a GRanges with at least two metadata columns: TF and absolute.idx for TF identity and unique motif index, respectively.

```
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
TFBSs$absolute.idx = names(TFBSs)
TFBSs
## GRanges object with 2 ranges and 2 metadata columns:
##                seqnames            ranges strand |          TF absolute.idx
##                   <Rle>         <IRanges>  <Rle> | <character>  <character>
##   TFBS_4305215     chr6 88106216-88106226      - |        NRF1 TFBS_4305215
##   TFBS_4305216     chr6 88106253-88106263      - |        NRF1 TFBS_4305216
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
```

```
FootprintCharter(
  MethSM = MethSM,
  RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs,
  coverage = 30,
  k = 16,
  n = 5,
  TF.length = c(5,75),
  nucleosome.length = c(120,1000),
  cytosine.coverage.thr = 5,
  verbose = FALSE
) -> FC_results

FC_results$footprints.df %>%
  filter(biological.state == "TF") %>%
  dplyr::select(start, end, partition.nr, TF, TF.name) %>%
  tidyr::unnest(cols = c(TF, TF.name))
## # A tibble: 11 × 5
##       start      end partition.nr TF    TF.name
##       <int>    <int> <chr>        <chr> <chr>
##  1 88106132 88106144 2            NA    <NA>
##  2 88106156 88106160 5            NA    <NA>
##  3 88106210 88106237 1            NRF1  TFBS_4305215
##  4 88106210 88106237 2            NRF1  TFBS_4305215
##  5 88106210 88106237 3            NRF1  TFBS_4305215
##  6 88106238 88106255 8            NA    <NA>
##  7 88106241 88106275 3            NRF1  TFBS_4305216
##  8 88106246 88106275 1            NRF1  TFBS_4305216
##  9 88106246 88106275 5            NRF1  TFBS_4305216
## 10 88106318 88106342 1            NA    <NA>
## 11 88106318 88106388 2            NA    <NA>
```

This way, the footprints data.frame reports TF motif annotations by populating two columns: TF and TF.name, each a list of annotations for each putative TF footprint.

## Inspect detected footprints

The function *PlotFootprints* allows to visually inspect the footprint detection results.

```
x.axis.breaks = c(
  start(resize(RegionOfInterest, width = 500, fix = "center")),
  end(resize(RegionOfInterest, width = 500, fix = "center"))
  )
PlotFootprints(
  MethSM = MethSM,
  partitioned.molecules = FC_results$partitioned.molecules,
  footprints.df = FC_results$footprints.df,
  TFBSs = TFBSs
    ) +
  scale_x_continuous(
    limits = x.axis.breaks,
    breaks = x.axis.breaks,
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    ) +
  theme(legend.position = "top", axis.text.x = element_text(angle = 30, hjust = 1))
```

![](data:image/png;base64...)

The function plots the average SMF signal separately for each partition alongside the biological.state annotation. The dashed line indicates the footprint detection threshold.

## Plot single molecule heatmaps

The function *PlotSM* can be used to plot binary heatmaps of single molecules partitioned by *FootprintCharter*.

```
PlotSM(
  MethSM = MethSM,
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"),
  SortedReads = FC_results$partitioned.molecules,
  sorting.strategy = "custom"
  ) +
  scale_x_continuous(
    limits = x.axis.breaks,
    breaks = x.axis.breaks,
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )
## Arranging reads according to custom sorting.strategy
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
```

![](data:image/png;base64...)

It might be desirable to arrange partitions according to a biologically meaningful order, such as TF binding and cobinding.

Users can leverage the plot produced with the *PlotFootprints* function as exemplified above and instruct a preferred order. In this case, we plot the partitions with two NRF1 footprints (3,1) on top, followed by partitions with single TF footprints (2,5), accessibility (6,7) and nucleosome footprints (4,8).

```
partitions.order = c(3,1,2,5,6,7,4,8)
ordered.molecules = lapply(FC_results$partitioned.molecules, function(x){x[rev(partitions.order)]})

PlotSM(
  MethSM = MethSM,
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"),
  SortedReads = ordered.molecules,
  sorting.strategy = "custom"
  ) +
  scale_x_continuous(
    limits = x.axis.breaks,
    breaks = x.axis.breaks,
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )
## Arranging reads according to custom sorting.strategy
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
```

![](data:image/png;base64...)

Single molecules displaying *FootprintCharter* annotations can be plotted using the *Plot\_FootprintCharter\_SM* function.

```
Plot_FootprintCharter_SM(
  footprints.df = FC_results$footprints.df,
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"),
  partitions.order = partitions.order
) +
  scale_x_continuous(
    limits = x.axis.breaks,
    breaks = x.axis.breaks,
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )
```

![](data:image/png;base64...)

## sessionInfo

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
##  [1] lubridate_1.9.4                  forcats_1.0.1
##  [3] stringr_1.5.2                    dplyr_1.1.4
##  [5] purrr_1.1.0                      readr_2.1.5
##  [7] tidyr_1.3.1                      tibble_3.3.0
##  [9] ggplot2_4.0.0                    tidyverse_2.0.0
## [11] GenomicRanges_1.62.0             Seqinfo_1.0.0
## [13] IRanges_2.44.0                   S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0              generics_0.1.4
## [17] SingleMoleculeFootprinting_2.4.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              GenomicFeatures_1.62.0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] BiocIO_1.20.0               vctrs_0.6.5
##   [9] memoise_2.0.1               Rsamtools_2.26.0
##  [11] RCurl_1.98-1.17             QuasR_1.50.0
##  [13] ggpointdensity_0.2.0        htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             progress_1.2.3
##  [17] curl_7.0.0                  SparseArray_1.10.0
##  [19] sass_0.4.10                 bslib_0.9.0
##  [21] httr2_1.2.1                 cachem_1.1.0
##  [23] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [25] pkgconfig_2.0.3             Matrix_1.7-4
##  [27] R6_2.6.1                    fastmap_1.2.0
##  [29] MatrixGenerics_1.22.0       digest_0.6.37
##  [31] miscTools_0.6-28            ShortRead_1.68.0
##  [33] patchwork_1.3.2             AnnotationDbi_1.72.0
##  [35] RSQLite_2.4.3               hwriter_1.3.2.1
##  [37] labeling_0.4.3              filelock_1.0.3
##  [39] timechange_0.3.0            httr_1.4.7
##  [41] abind_1.4-8                 compiler_4.5.1
##  [43] Rbowtie_1.50.0              bit64_4.6.0-1
##  [45] withr_3.0.2                 S7_0.2.0
##  [47] BiocParallel_1.44.0         viridis_0.6.5
##  [49] DBI_1.2.3                   qs_0.27.3
##  [51] biomaRt_2.66.0              rappdirs_0.3.3
##  [53] DelayedArray_0.36.0         rjson_0.2.23
##  [55] tools_4.5.1                 glue_1.8.0
##  [57] restfulr_0.0.16             grid_4.5.1
##  [59] cluster_2.1.8.1             gtable_0.3.6
##  [61] BSgenome_1.78.0             tzdb_0.5.0
##  [63] RApiSerialize_0.1.4         hms_1.1.4
##  [65] utf8_1.2.6                  stringfish_0.17.0
##  [67] XVector_0.50.0              ggrepel_0.9.6
##  [69] pillar_1.11.1               BiocFileCache_3.0.0
##  [71] lattice_0.22-7              rtracklayer_1.70.0
##  [73] bit_4.6.0                   deldir_2.0-4
##  [75] tidyselect_1.2.1            Biostrings_2.78.0
##  [77] knitr_1.50                  gridExtra_2.3
##  [79] SummarizedExperiment_1.40.0 xfun_0.53
##  [81] Biobase_2.70.0              matrixStats_1.5.0
##  [83] stringi_1.8.7               UCSC.utils_1.6.0
##  [85] yaml_2.3.10                 evaluate_1.0.5
##  [87] codetools_0.2-20            cigarillo_1.0.0
##  [89] interp_1.1-6                GenomicFiles_1.46.0
##  [91] cli_3.6.5                   RcppParallel_5.1.11-1
##  [93] jquerylib_0.1.4             dichromat_2.0-0.1
##  [95] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
##  [97] dbplyr_2.5.1                png_0.1-8
##  [99] XML_3.99-0.19               parallel_4.5.1
## [101] blob_1.2.4                  prettyunits_1.2.0
## [103] latticeExtra_0.6-31         jpeg_0.1-11
## [105] parallelDist_0.2.7          plyranges_1.30.0
## [107] bitops_1.0-9                pwalign_1.6.0
## [109] txdbmaker_1.6.0             viridisLite_0.4.2
## [111] VariantAnnotation_1.56.0    scales_1.4.0
## [113] crayon_1.5.3                rrapply_1.2.7
## [115] rlang_1.1.6                 KEGGREST_1.50.0
```