# EpiTxDb: creating an EpiTxDb object

Felix G.M. Ernst

#### 2025-10-29

#### Package

EpiTxDb 1.22.0

# 1 Introduction

To create an `EpiTxDb` object a number of different functions are available.
The most univeral functions are `makeEpiTxDb` and `makeEpiTxDbFromGRanges`.
`makeEpiTxDb` uses four `data.frame`s as input, whereas `makeEpiTxDbFromGRanges`
is a wrapper for information available as a `GRanges` object.

The other functions are `makeEpiTxDbFromRMBase` and `makeEpiTxDbFromtRNAdb`,
which are aimed to make data available from the RMBase v2.0 database
[(Xuan et al. [2017](#ref-Xuan.2017); Sun et al. [2015](#ref-Sun.2015))](#References) or the tRNAdb
[(Jühling et al. [2009](#ref-Juehling.2009); Sprinzl and Vassilenko [2005](#ref-Sprinzl.2005))](#References). However, before creating your
`EpiTxDb` objects, have a look at the already available resources for
`H. sapiens`, `M. musculus` and `S. cerevisiae.`

Additional metadata can be provided as separate `data.frame` for all functions.
The `data.frame` must have two columns `name` and `value`.

```
library(GenomicRanges)
library(EpiTxDb)
```

# 2 `makeEpiTxDb` and `makeEpiTxDbFromGRanges`

The creation of an etdb object is quite easy starting with a `GRanges` object.

```
gr <- GRanges(seqnames = "test",
              ranges = IRanges::IRanges(1,1),
              strand = "+",
              DataFrame(mod_id = 1L,
                        mod_type = "Am",
                        mod_name = "Am_1"))
etdb <- makeEpiTxDbFromGRanges(gr, metadata = data.frame(name = "test",
                                                         value = "Yes"))
```

```
## Creating EpiTxDb object ... done
```

```
etdb
```

```
## EpiTxDb object:
## # Db type: EpiTxDb
## # Supporting package: EpiTxDb
## # test: Yes
## # Nb of modifications: 1
## # Db created by: EpiTxDb package from Bioconductor
## # Creation time: 2025-10-29 23:51:12 -0400 (Wed, 29 Oct 2025)
## # EpiTxDb version at creation time: 1.22.0
## # RSQLite version at creation time: 2.4.3
## # DBSCHEMAVERSION: 1.0
```

```
metadata(etdb)
```

Additional data can be provided via the metadata columns of the `GRanges`
object. For supported columns have a look at `?makeEpiTxDb` or
`?makeEpiTxDbFromGRanges`.

# 3 `makeEpiTxDbFromtRNAdb`

The information of the tRNAdb can be accessed via the `tRNAdbImport` package
using the RNA database. As a result a `ModRNAStringSet` object is returned from
which the modifications can be extracted using `separate()`.

The only input require is a valid organism name returned by
`listAvailableOrganismsFromtRNAdb()`.

```
# Currently not run since the server is not available
etdb <- makeEpiTxDbFromtRNAdb("Saccharomyces cerevisiae")
etdb
```

For additional information have a look at `?makeEpiTxDbFromtRNAdb`. The result
returned from the tRNAdb is also available as `GRanges` object, if
`gettRNAdbDataAsGRanges()` is used.

# 4 `makeEpiTxDbFromRMBase`

Analogous to the example above `makeEpiTxDbFromRMBase()` will download the data
from the RMBase v2.0. Three inputs are required, `organism`, `genome` and
`modtype`, which have to valid bia the functions
`listAvailableOrganismsFromRMBase()`, `.listAvailableGenomesFromRMBase()` and
`listAvailableModFromRMBase`.

```
etdb <- makeEpiTxDbFromRMBase(organism = "yeast",
                              genome = "sacCer3",
                              modtype = "m1A")
```

Internally, the files are cached using the `BiocFileCache` package and passed
to `makeEpiTxDbFromRMBaseFiles()`, which can also be used with locally stored
files. The resuls for creating the `EpiTxDb` class are processed from these
files via the `getRMBaseDataAsGRanges()` function.

# 5 Session info

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
##  [1] EpiTxDb_1.22.0       Modstrings_1.26.0    Biostrings_2.78.0
##  [4] XVector_0.50.0       AnnotationDbi_1.72.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
## [10] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tRNAdbImport_1.28.0         tidyselect_1.2.1
##  [3] farver_2.1.2                dplyr_1.1.4
##  [5] blob_1.2.4                  S7_0.2.0
##  [7] filelock_1.0.3              bitops_1.0-9
##  [9] fastmap_1.2.0               RCurl_1.98-1.17
## [11] BiocFileCache_3.0.0         GenomicAlignments_1.46.0
## [13] rex_1.2.1                   XML_3.99-0.19
## [15] digest_0.6.37               lifecycle_1.0.4
## [17] KEGGREST_1.50.0             RSQLite_2.4.3
## [19] magrittr_2.0.4              compiler_4.5.1
## [21] progress_1.2.3              rlang_1.1.6
## [23] sass_0.4.10                 tools_4.5.1
## [25] yaml_2.3.10                 rtracklayer_1.70.0
## [27] knitr_1.50                  prettyunits_1.2.0
## [29] S4Arrays_1.10.0             bit_4.6.0
## [31] curl_7.0.0                  DelayedArray_0.36.0
## [33] xml2_1.4.1                  RColorBrewer_1.1-3
## [35] abind_1.4-8                 BiocParallel_1.44.0
## [37] txdbmaker_1.6.0             grid_4.5.1
## [39] ggplot2_4.0.0               scales_1.4.0
## [41] dichromat_2.0-0.1           biomaRt_2.66.0
## [43] SummarizedExperiment_1.40.0 cli_3.6.5
## [45] rmarkdown_2.30              crayon_1.5.3
## [47] httr_1.4.7                  rjson_0.2.23
## [49] DBI_1.2.3                   cachem_1.1.0
## [51] stringr_1.5.2               parallel_4.5.1
## [53] BiocManager_1.30.26         restfulr_0.0.16
## [55] matrixStats_1.5.0           vctrs_0.6.5
## [57] Matrix_1.7-4                jsonlite_2.0.0
## [59] bookdown_0.45               hms_1.1.4
## [61] bit64_4.6.0-1               GenomicFeatures_1.62.0
## [63] jquerylib_0.1.4             glue_1.8.0
## [65] codetools_0.2-20            gtable_0.3.6
## [67] stringi_1.8.7               GenomeInfoDb_1.46.0
## [69] BiocIO_1.20.0               UCSC.utils_1.6.0
## [71] tibble_3.3.0                pillar_1.11.1
## [73] rappdirs_0.3.3              htmltools_0.5.8.1
## [75] R6_2.6.1                    dbplyr_2.5.1
## [77] httr2_1.2.1                 evaluate_1.0.5
## [79] lattice_0.22-7              png_0.1-8
## [81] Rsamtools_2.26.0            cigarillo_1.0.0
## [83] memoise_2.0.1               bslib_0.9.0
## [85] Structstrings_1.26.0        tRNA_1.28.0
## [87] SparseArray_1.10.0          xfun_0.53
## [89] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.

Sprinzl, Mathias, and Konstantin S. Vassilenko. 2005. “Compilation of tRNA Sequences and Sequences of tRNA Genes.” *Nucleic Acids Research* 33: D139–D140. <https://doi.org/10.1093/nar/gki012>.

Sun, Wen-Ju, Jun-Hao Li, Shun Liu, Jie Wu, Hui Zhou, Liang-Hu Qu, and Jian-Hua Yang. 2015. “RMBase: a resource for decoding the landscape of RNA modifications from high-throughput sequencing data.” *Nucleic Acids Research* 44 (D1): D259–D265. <https://doi.org/10.1093/nar/gkv1036>.

Xuan, Jia-Jia, Wen-Ju Sun, Peng-Hui Lin, Ke-Ren Zhou, Shun Liu, Ling-Ling Zheng, Liang-Hu Qu, and Jian-Hua Yang. 2017. “RMBase v2.0: deciphering the map of RNA modifications from epitranscriptome sequencing data.” *Nucleic Acids Research* 46 (D1): D327–D334. <https://doi.org/10.1093/nar/gkx934>.