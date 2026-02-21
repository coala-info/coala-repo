# RNAmodR.Data: example data for RNAmodR packages

Felix G.M. Ernst and Denis L.J. Lafontaine

#### 2025-11-04

#### Package

RNAmodR.Data 1.24.0

# 1 Available resources

`RNAmodR.Data` contains example data for the `RNAmodR` and related packages.
The data is provided as gff3, fasta and bam files.

Four sets of data with multiple files are included

```
## No methods found in package 'rtracklayer' for request: 'trackName<-' when loading 'AnnotationHubData'
```

```
## Warning: replacing previous import 'utils::findMatches' by
## 'S4Vectors::findMatches' when loading 'ExperimentHubData'
```

```
library(RNAmodR.Data)
```

```
eh <- ExperimentHub()
ExperimentHub::listResources(eh, "RNAmodR.Data")
```

```
##  [1] "RNAmodR.Data.example.fasta"     "RNAmodR.Data.example.gff3"
##  [3] "RNAmodR.Data.example.bam.1"     "RNAmodR.Data.example.bam.2"
##  [5] "RNAmodR.Data.example.bam.3"     "RNAmodR.Data.example.RMS.fasta"
##  [7] "RNAmodR.Data.example.RMS.gff3"  "RNAmodR.Data.example.RMS.1"
##  [9] "RNAmodR.Data.example.RMS.2"     "RNAmodR.Data.example.AAS.fasta"
## [11] "RNAmodR.Data.example.AAS.gff3"  "RNAmodR.Data.example.bud23.1"
## [13] "RNAmodR.Data.example.bud23.2"   "RNAmodR.Data.example.trm8.1"
## [15] "RNAmodR.Data.example.trm8.2"    "RNAmodR.Data.example.wt.1"
## [17] "RNAmodR.Data.example.wt.2"      "RNAmodR.Data.example.wt.3"
## [19] "RNAmodR.Data.example.man.fasta" "RNAmodR.Data.example.man.gff3"
## [21] "RNAmodR.Data.snoRNAdb"
```

These resources are grouped based on topic. Please have a look at the following
man pages:

* `?RNAmodR.Data.example` for general example data used for different purposes
* `?RNAmodR.Data.RMS` for example data for RiboMethSeq
* `?RNAmodR.Data.AAS` for example data for AlkAnilineSeq
* `?RNAmodR.Data.man` for small data set for man page examples
* `?RNAmodR.Data.snoRNAdb` for snoRNAdb as csv file

# 2 snoRNAdb

`RNAmodR.Data.snoRNAdb` consists of a table containing the published data from
the snoRNAdb [(Lestrade and Weber [2006](#ref-Lestrade.2006))](#References). The can be loaded as a GRanges
object.

```
library(GenomicRanges)
```

```
table <- read.csv2(RNAmodR.Data.snoRNAdb(), stringsAsFactors = FALSE)
```

```
## see ?RNAmodR.Data and browseVignettes('RNAmodR.Data') for documentation
```

```
## loading from cache
```

```
head(table, n = 2)
```

```
# keep only the current coordinates
table <- table[,1:7]
snoRNAdb <- GRanges(seqnames = table$hgnc_symbol,
              ranges = IRanges(start = table$position, width = 1),strand = "+",
              type = "RNAMOD",
              mod = table$modification,
              Parent = table$hgnc_symbol,
              Activity = CharacterList(strsplit(table$guide,",")))
# convert to current gene name
snoRNAdb <- snoRNAdb[vapply(snoRNAdb$Activity != "unknown",all,logical(1)),]
snoRNAdb <- split(snoRNAdb,snoRNAdb$Parent)
head(snoRNAdb)
```

```
## GRangesList object of length 6:
## $RNA18SN5
## GRanges object with 69 ranges and 4 metadata columns:
##        seqnames    ranges strand |        type         mod      Parent
##           <Rle> <IRanges>  <Rle> | <character> <character> <character>
##    [1] RNA18SN5        27      + |      RNAMOD          Am    RNA18SN5
##    [2] RNA18SN5        34      + |      RNAMOD           Y    RNA18SN5
##    [3] RNA18SN5        36      + |      RNAMOD           Y    RNA18SN5
##    [4] RNA18SN5        93      + |      RNAMOD           Y    RNA18SN5
##    [5] RNA18SN5        99      + |      RNAMOD          Am    RNA18SN5
##    ...      ...       ...    ... .         ...         ...         ...
##   [65] RNA18SN5      1643      + |      RNAMOD           Y    RNA18SN5
##   [66] RNA18SN5      1678      + |      RNAMOD          Am    RNA18SN5
##   [67] RNA18SN5      1692      + |      RNAMOD           Y    RNA18SN5
##   [68] RNA18SN5      1703      + |      RNAMOD          Cm    RNA18SN5
##   [69] RNA18SN5      1804      + |      RNAMOD          Um    RNA18SN5
##                              Activity
##                       <CharacterList>
##    [1]                        SNORD27
##    [2]               SNORA50A,SNORA76
##    [3]                SNORA69,SNORA55
##    [4]                        SNORA75
##    [5]                        SNORD57
##    ...                            ...
##   [65]                        SNORA41
##   [66]                        SNORD82
##   [67] SNORD70A,SNORD70B,SNORD70C,...
##   [68]                        SNORD43
##   [69]                        SNORD20
##   -------
##   seqinfo: 9 sequences from an unspecified genome; no seqlengths
##
## ...
## <5 more elements>
```

# 3 Sessioninfo

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
##  [1] RNAmodR.Data_1.24.0      ExperimentHubData_1.36.0 AnnotationHubData_1.40.0
##  [4] futile.logger_1.4.3      GenomicRanges_1.62.0     Seqinfo_1.0.0
##  [7] IRanges_2.44.0           S4Vectors_0.48.0         ExperimentHub_3.0.0
## [10] AnnotationHub_4.0.0      BiocFileCache_3.0.0      dbplyr_2.5.1
## [13] BiocGenerics_0.56.0      generics_0.1.4           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] Biostrings_2.78.0           bitops_1.0-9
##  [7] fastmap_1.2.0               RCurl_1.98-1.17
##  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
## [11] digest_0.6.37               lifecycle_1.0.4
## [13] KEGGREST_1.50.0             RSQLite_2.4.3
## [15] magrittr_2.0.4              compiler_4.5.1
## [17] rlang_1.1.6                 sass_0.4.10
## [19] tools_4.5.1                 yaml_2.3.10
## [21] lambda.r_1.2.4              rtracklayer_1.70.0
## [23] knitr_1.50                  S4Arrays_1.10.0
## [25] bit_4.6.0                   curl_7.0.0
## [27] DelayedArray_0.36.0         abind_1.4-8
## [29] BiocParallel_1.44.0         withr_3.0.2
## [31] purrr_1.1.0                 grid_4.5.1
## [33] SummarizedExperiment_1.40.0 cli_3.6.5
## [35] rmarkdown_2.30              crayon_1.5.3
## [37] stringdist_0.9.15           httr_1.4.7
## [39] rjson_0.2.23                BiocBaseUtils_1.12.0
## [41] RUnit_0.4.33.1              DBI_1.2.3
## [43] cachem_1.1.0                parallel_4.5.1
## [45] AnnotationDbi_1.72.0        formatR_1.14
## [47] BiocManager_1.30.26         XVector_0.50.0
## [49] restfulr_0.0.16             matrixStats_1.5.0
## [51] vctrs_0.6.5                 Matrix_1.7-4
## [53] jsonlite_2.0.0              bookdown_0.45
## [55] bit64_4.6.0-1               RBGL_1.86.0
## [57] GenomicFeatures_1.62.0      jquerylib_0.1.4
## [59] glue_1.8.0                  codetools_0.2-20
## [61] GenomeInfoDb_1.46.0         BiocVersion_3.22.0
## [63] BiocCheck_1.46.0            UCSC.utils_1.6.0
## [65] BiocIO_1.20.0               tibble_3.3.0
## [67] pillar_1.11.1               rappdirs_0.3.3
## [69] htmltools_0.5.8.1           graph_1.88.0
## [71] R6_2.6.1                    httr2_1.2.1
## [73] AnnotationForge_1.52.0      evaluate_1.0.5
## [75] OrganismDbi_1.52.0          Biobase_2.70.0
## [77] lattice_0.22-7              futile.options_1.0.1
## [79] png_0.1-8                   Rsamtools_2.26.0
## [81] cigarillo_1.0.0             memoise_2.0.1
## [83] bslib_0.9.0                 SparseArray_1.10.1
## [85] xfun_0.54                   MatrixGenerics_1.22.0
## [87] biocViews_1.78.0            pkgconfig_2.0.3
```

# References

Lestrade, Laurent, and Michel J. Weber. 2006. “snoRNA-LBME-db, a comprehensive database of human H/ACA and C/D box snoRNAs.” *Nucleic Acids Research* 34 (January): D158–D162. <https://doi.org/10.1093/nar/gkj002>.