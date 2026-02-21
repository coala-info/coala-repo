# nullrangesData package

The *nullrangesData* package provides datasets for the *nullranges* package vignette, in particular example datasets for exclusion regions, DNase hypersensitivity sites (DHS), Single Cell Multiome ATAC and Gene Expression assay, CTCF binding sites, and CTCF genomic interactions.

```
library(nullrangesData)
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: InteractionSet
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
## The following object is masked from 'package:ExperimentHub':
##
##     cache
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
```

```
suppressPackageStartupMessages(library(GenomicRanges))
suppressPackageStartupMessages(library(InteractionSet))
```

A549 DHS peaks (see `?DHSA549Hg38` for details).

```
dhs <- DHSA549Hg38()
```

```
## see ?nullrangesData and browseVignettes('nullrangesData') for documentation
```

```
## loading from cache
```

```
dhs
```

```
## GRanges object with 177085 ranges and 6 metadata columns:
##            seqnames            ranges strand |        name     score
##               <Rle>         <IRanges>  <Rle> | <character> <numeric>
##        [1]     chr1       10181-10330      * |        <NA>         0
##        [2]     chr1     267990-268139      * |        <NA>         0
##        [3]     chr1     629126-629275      * |        <NA>         0
##        [4]     chr1     629306-629455      * |        <NA>         0
##        [5]     chr1     629901-630170      * |        <NA>         0
##        ...      ...               ...    ... .         ...       ...
##   [177081]     chrY 56873654-56873803      * |        <NA>         0
##   [177082]     chrY 56874534-56874683      * |        <NA>         0
##   [177083]     chrY 56883699-56883848      * |        <NA>         0
##   [177084]     chrY 56885199-56885348      * |        <NA>         0
##   [177085]     chrY 56886199-56886348      * |        <NA>         0
##            signalValue    pValue    qValue      peak
##              <numeric> <numeric> <numeric> <numeric>
##        [1]           6        -1        -1        -1
##        [2]          12        -1        -1        -1
##        [3]         378        -1        -1        -1
##        [4]         196        -1        -1        -1
##        [5]         212        -1        -1        -1
##        ...         ...       ...       ...       ...
##   [177081]          12        -1        -1        -1
##   [177082]          17        -1        -1        -1
##   [177083]          19        -1        -1        -1
##   [177084]          18        -1        -1        -1
##   [177085]          14        -1        -1        -1
##   -------
##   seqinfo: 24 sequences from hg38 genome
```

Chromium Single Cell Multiome ATAC + Gene Expression assay. See corresponding man pages for details..

```
data("sc_rna")
data("sc_promoter")
sc_rna
```

```
## GRanges object with 28225 ranges and 2 metadata columns:
##           seqnames            ranges strand |        gene
##              <Rle>         <IRanges>  <Rle> | <character>
##       [1]     chr1     120931-133723      * |  AL627309.1
##       [2]     chr1     140338-140339      * |  AL627309.2
##       [3]     chr1     149706-173862      * |  AL627309.5
##       [4]     chr1     160445-160446      * |  AL627309.4
##       [5]     chr1     266854-266855      * |  AP006222.2
##       ...      ...               ...    ... .         ...
##   [28221]    chr22 50597151-50597152      * |    U62317.3
##   [28222]    chr22 50600792-50600793      * |    MAPK8IP2
##   [28223]    chr22 50628151-50628173      * |        ARSA
##   [28224]    chr22 50674641-50729572      * |      SHANK3
##   [28225]    chr22 50783620-50783663      * |      RABL2B
##                                        counts1
##                                  <NumericList>
##       [1]    -0.227594, 0.249144, 0.419668,...
##       [2]    -0.267261,-0.267261,-0.267261,...
##       [3]       -0.39115,-0.10318, 1.02400,...
##       [4]  0.1516318,-0.0605821, 1.9885284,...
##       [5]    -0.267261,-0.267261,-0.267261,...
##       ...                                  ...
##   [28221]    -0.267261,-0.267261,-0.267261,...
##   [28222]     0.701249,-0.546908,-0.546908,...
##   [28223]    -0.509022, 0.201242, 1.618880,...
##   [28224]    -0.267261,-0.267261,-0.267261,...
##   [28225]  0.9252646,-0.0774203,-0.2877604,...
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

```
sc_promoter
```

```
## GRanges object with 15561 ranges and 2 metadata columns:
##           seqnames            ranges strand |                   peak
##              <Rle>         <IRanges>  <Rle> |            <character>
##       [1]     chr1     777634-779926      * |     chr1:777634-779926
##       [2]     chr1     816881-817647      * |     chr1:816881-817647
##       [3]     chr1     826612-827979      * |     chr1:826612-827979
##       [4]     chr1     869449-870383      * |     chr1:869449-870383
##       [5]     chr1     903617-907386      * |     chr1:903617-907386
##       ...      ...               ...    ... .                    ...
##   [15557]    chr22 50580287-50583942      * | chr22:50580287-50583..
##   [15558]    chr22 50599877-50602115      * | chr22:50599877-50602..
##   [15559]    chr22 50625295-50629340      * | chr22:50625295-50629..
##   [15560]    chr22 50671698-50675683      * | chr22:50671698-50675..
##   [15561]    chr22 50783058-50784322      * | chr22:50783058-50784..
##                                        counts2
##                                  <NumericList>
##       [1]       1.143068,0.383233,0.342632,...
##       [2]    -0.618560,-0.415192, 1.277454,...
##       [3]    -1.162635,-0.571467, 1.045412,...
##       [4]     0.923427, 0.797197,-1.394984,...
##       [5]     0.337377,-0.727911, 1.501327,...
##       ...                                  ...
##   [15557]     1.068434, 0.345541,-0.229966,...
##   [15558]     0.500332, 0.458059,-1.085105,...
##   [15559]  0.2946085,-0.0665503,-0.6663091,...
##   [15560]     0.705884,-0.272306,-0.326069,...
##   [15561]     0.149851, 0.460193,-0.192810,...
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

CTCF binding sites, 10kb bins with CTCF and DHS peaks, and CTCF-bound genomics interactions. See corresponding man pages for details.

```
bins <- hg19_10kb_bins()
```

```
## see ?nullrangesData and browseVignettes('nullrangesData') for documentation
```

```
## loading from cache
```

```
binPairs <- hg19_10kb_ctcfBoundBinPairs()
```

```
## see ?nullrangesData and browseVignettes('nullrangesData') for documentation
## loading from cache
```

```
bins
```

```
## GRanges object with 303641 ranges and 5 metadata columns:
##            seqnames              ranges strand | n_ctcf_sites ctcfSignal
##               <Rle>           <IRanges>  <Rle> |    <numeric>  <numeric>
##        [1]     chr1             1-10000      * |            0          0
##        [2]     chr1         10001-20000      * |            0          0
##        [3]     chr1         20001-30000      * |            0          0
##        [4]     chr1         30001-40000      * |            0          0
##        [5]     chr1         40001-50000      * |            0          0
##        ...      ...                 ...    ... .          ...        ...
##   [303637]     chrX 155230001-155240000      * |            0    0.00000
##   [303638]     chrX 155240001-155250000      * |            0    0.00000
##   [303639]     chrX 155250001-155260000      * |            1    4.09522
##   [303640]     chrX 155260001-155270000      * |            0    0.00000
##   [303641]     chrX 155270001-155270560      * |            0    0.00000
##            n_dnase_sites dnaseSignal    looped
##                 <factor>   <numeric> <logical>
##        [1]             0     0.00000     FALSE
##        [2]             0     5.03572     FALSE
##        [3]             0     0.00000     FALSE
##        [4]             0     0.00000     FALSE
##        [5]             0     0.00000     FALSE
##        ...           ...         ...       ...
##   [303637]             0     8.42068     FALSE
##   [303638]             0     4.08961     FALSE
##   [303639]             0     6.00443     FALSE
##   [303640]             0     8.07179     FALSE
##   [303641]             0     0.00000     FALSE
##   -------
##   seqinfo: 23 sequences from hg19 genome
```

```
binPairs
```

```
## StrictGInteractions object with 198120 interactions and 5 metadata columns:
##            seqnames1             ranges1     seqnames2             ranges2 |
##                <Rle>           <IRanges>         <Rle>           <IRanges> |
##        [1]      chr1       230001-240000 ---      chr1       520001-530000 |
##        [2]      chr1       230001-240000 ---      chr1       710001-720000 |
##        [3]      chr1       230001-240000 ---      chr1       800001-810000 |
##        [4]      chr1       230001-240000 ---      chr1       840001-850000 |
##        [5]      chr1       230001-240000 ---      chr1       870001-880000 |
##        ...       ...                 ... ...       ...                 ... .
##   [198116]      chrX 154310001-154320000 ---      chrX 154370001-154380000 |
##   [198117]      chrX 154310001-154320000 ---      chrX 155250001-155260000 |
##   [198118]      chrX 154320001-154330000 ---      chrX 154370001-154380000 |
##   [198119]      chrX 154320001-154330000 ---      chrX 155250001-155260000 |
##   [198120]      chrX 154370001-154380000 ---      chrX 155250001-155260000 |
##               looped ctcfSignal  n_sites  distance convergent
##            <logical>  <numeric> <factor> <integer>  <logical>
##        [1]     FALSE    5.18038        2    290000      FALSE
##        [2]     FALSE    5.46775        2    480000       TRUE
##        [3]     FALSE    7.30942        2    570000      FALSE
##        [4]     FALSE    7.34338        2    610000      FALSE
##        [5]     FALSE    6.31338        3    640000       TRUE
##        ...       ...        ...      ...       ...        ...
##   [198116]     FALSE    6.79246        2     60000      FALSE
##   [198117]     FALSE    6.12447        3    940000       TRUE
##   [198118]     FALSE    7.40868        2     50000       TRUE
##   [198119]     FALSE    7.00936        3    930000      FALSE
##   [198120]     FALSE    6.73402        3    880000       TRUE
##   -------
##   regions: 20612 ranges and 5 metadata columns
##   seqinfo: 23 sequences from hg19 genome
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] nullrangesData_1.16.0       InteractionSet_1.38.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [13] BiocFileCache_3.0.0         dbplyr_2.5.1
## [15] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
## [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
## [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
## [16] compiler_4.5.1       Biostrings_2.78.0    htmltools_0.5.8.1
## [19] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [22] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
## [25] DelayedArray_0.36.0  abind_1.4-8          tidyselect_1.2.1
## [28] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [31] BiocVersion_3.22.0   fastmap_1.2.0        grid_4.5.1
## [34] SparseArray_1.10.1   cli_3.6.5            magrittr_2.0.4
## [37] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
## [40] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [43] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [46] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
## [49] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
## [52] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [55] jsonlite_2.0.0       R6_2.6.1
```