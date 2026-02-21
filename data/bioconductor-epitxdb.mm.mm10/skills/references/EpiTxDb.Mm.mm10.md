# EpiTxDb.Mm.mm10: Annotation package for EpiTxDb objects

Felix G.M. Ernst

#### 2020-09-03

#### Package

EpiTxDb.Mm.mm10 0.99.6

# 1 Available resources

`EpiTxDb.Mm.mm10` contains post-transcriptional RNA modifications from
RMBase v2.0 [(Xuan et al. 2017)](#References) and tRNAdb [(Jühling et al. 2009)](#References) and
can be accessed through the functions `EpiTxDb.Mm.mm10.tRNAdb()` and
`EpiTxDb.Mm.mm10.RMBase()`

```
library(EpiTxDb.Mm.mm10)
```

```
etdb <- EpiTxDb.Mm.mm10.tRNAdb()
```

```
## snapshotDate(): 2020-09-03
```

```
## loading from cache
```

```
etdb
```

```
## EpiTxDb object:
## # Db type: EpiTxDb
## # Supporting package: EpiTxDb
## # Data source: tRNAdb
## # Organism: Mus musculus
## # Genome: mm10
## # Coordinates: per Transcript
## # Checked against sequence: Yes
## # Nb of modifications: 1032
## # Db created by: EpiTxDb package from Bioconductor
## # Creation time: 2020-02-26 10:43:52 +0100 (Wed, 26 Feb 2020)
## # EpiTxDb version at creation time: 0.99.0
## # RSQLite version at creation time: 2.2.0
## # DBSCHEMAVERSION: 1.0
```

Modification information can be accessed through the typical function for an
`EpiTxDb` object, for example `modifications()`:

```
modifications(etdb)
```

```
## GRanges object with 1032 ranges and 3 metadata columns:
##                      seqnames    ranges strand |    mod_id    mod_type
##                         <Rle> <IRanges>  <Rle> | <integer> <character>
##      [1] chr1.tRNA1004-GluCTC        10      + |         1         m2G
##      [2] chr1.tRNA1007-GluCTC        10      + |         2         m2G
##      [3] chr1.tRNA1010-GluCTC        10      + |         3         m2G
##      [4]  chr1.tRNA709-GluCTC        10      + |         4         m2G
##      [5]  chr10.tRNA90-GluCTC        10      + |         5         m2G
##      ...                  ...       ...    ... .       ...         ...
##   [1028]  chr13.tRNA90-MetCAT        57      + |      1891         m1A
##   [1029] chr13.tRNA959-MetCAT        57      + |      1892         m1A
##   [1030] chr13.tRNA995-MetCAT        57      + |      1893         m1A
##   [1031] chr15.tRNA876-MetCAT        57      + |      1894         m1A
##   [1032]  chr3.tRNA792-MetCAT        57      + |      1895         m1A
##                        mod_name
##                     <character>
##      [1] m2G_10_chr1.tRNA1004..
##      [2] m2G_10_chr1.tRNA1007..
##      [3] m2G_10_chr1.tRNA1010..
##      [4] m2G_10_chr1.tRNA709-..
##      [5] m2G_10_chr10.tRNA90-..
##      ...                    ...
##   [1028] m1A_57_chr13.tRNA90-..
##   [1029] m1A_57_chr13.tRNA959..
##   [1030] m1A_57_chr13.tRNA995..
##   [1031] m1A_57_chr15.tRNA876..
##   [1032] m1A_57_chr3.tRNA792-..
##   -------
##   seqinfo: 93 sequences from mm10 genome; no seqlengths
```

For a more detailed overview and explanation of the functionality of the
`EpiTxDb` class, have a look at the `EpiTxDb` package.

# 2 Sessioninfo

```
sessionInfo()
```

```
## R version 4.0.0 alpha (2020-04-07 r78171)
## Platform: x86_64-apple-darwin17.7.0 (64-bit)
## Running under: macOS High Sierra 10.13.6
##
## Matrix products: default
## BLAS:   /Users/ka36530_ca/R-stuff/bin/R-4-0/lib/libRblas.dylib
## LAPACK: /Users/ka36530_ca/R-stuff/bin/R-4-0/lib/libRlapack.dylib
##
## locale:
## [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] EpiTxDb.Mm.mm10_0.99.6 EpiTxDb_1.1.0          Modstrings_1.5.1
##  [4] Biostrings_2.57.2      XVector_0.29.3         AnnotationDbi_1.51.3
##  [7] IRanges_2.23.10        S4Vectors_0.27.12      Biobase_2.49.0
## [10] AnnotationHub_2.21.5   BiocFileCache_1.13.1   dbplyr_1.4.4
## [13] BiocGenerics_0.35.4    BiocStyle_2.17.0
##
## loaded via a namespace (and not attached):
##  [1] httr_1.4.2                    bit64_4.0.4
##  [3] shiny_1.5.0                   assertthat_0.2.1
##  [5] interactiveDisplayBase_1.27.5 askpass_1.1
##  [7] BiocManager_1.30.10           blob_1.2.1
##  [9] GenomeInfoDbData_1.2.3        Rsamtools_2.5.3
## [11] yaml_2.2.1                    progress_1.2.2
## [13] BiocVersion_3.12.0            pillar_1.4.6
## [15] RSQLite_2.2.0                 lattice_0.20-41
## [17] glue_1.4.2                    digest_0.6.25
## [19] Structstrings_1.5.2           GenomicRanges_1.41.6
## [21] promises_1.1.1                colorspace_1.4-1
## [23] tRNA_1.7.1                    htmltools_0.5.0
## [25] httpuv_1.5.4                  Matrix_1.2-18
## [27] XML_3.99-0.5                  pkgconfig_2.0.3
## [29] biomaRt_2.45.2                bookdown_0.20
## [31] zlibbioc_1.35.0               purrr_0.3.4
## [33] xtable_1.8-4                  scales_1.1.1
## [35] later_1.1.0.1                 BiocParallel_1.23.2
## [37] tibble_3.0.3                  openssl_1.4.2
## [39] ggplot2_3.3.2                 generics_0.0.2
## [41] ellipsis_0.3.1                SummarizedExperiment_1.19.6
## [43] GenomicFeatures_1.41.2        magrittr_1.5
## [45] crayon_1.3.4                  mime_0.9
## [47] memoise_1.1.0                 evaluate_0.14
## [49] xml2_1.3.2                    tools_4.0.0
## [51] prettyunits_1.1.1             hms_0.5.3
## [53] matrixStats_0.56.0            lifecycle_0.2.0
## [55] stringr_1.4.0                 munsell_0.5.0
## [57] tRNAdbImport_1.7.1            DelayedArray_0.15.7
## [59] compiler_4.0.0                GenomeInfoDb_1.25.10
## [61] rlang_0.4.7                   grid_4.0.0
## [63] RCurl_1.98-1.2                rappdirs_0.3.1
## [65] bitops_1.0-6                  rmarkdown_2.3
## [67] gtable_0.3.0                  DBI_1.1.0
## [69] curl_4.3                      R6_2.4.1
## [71] GenomicAlignments_1.25.3      knitr_1.29
## [73] dplyr_1.0.2                   rtracklayer_1.49.5
## [75] fastmap_1.0.1                 bit_4.0.4
## [77] stringi_1.4.6                 Rcpp_1.0.5
## [79] vctrs_0.3.3                   tidyselect_1.1.0
## [81] xfun_0.16
```

# References

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.

Xuan, Jia-Jia, Wen-Ju Sun, Peng-Hui Lin, Ke-Ren Zhou, Shun Liu, Ling-Ling Zheng, Liang-Hu Qu, and Jian-Hua Yang. 2017. “RMBase v2.0: deciphering the map of RNA modifications from epitranscriptome sequencing data.” *Nucleic Acids Research* 46 (D1): D327–D334. <https://doi.org/10.1093/nar/gkx934>.