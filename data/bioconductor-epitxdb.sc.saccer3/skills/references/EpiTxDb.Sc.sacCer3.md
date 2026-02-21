# EpiTxDb.Sc.sacCer3: Annotation package for EpiTxDb objects

Felix G.M. Ernst

#### 2021-01-20

#### Package

EpiTxDb.Sc.sacCer3 0.99.5

# 1 Available resources

`EpiTxDb.Sc.sacCer3` contains post-transcriptional RNA modifications from RMBase
v2.0 [(Xuan et al. 2017)](#References) and tRNAdb [(Jühling et al. 2009)](#References) and
can be accessed through the functions `EpiTxDb.Sc.sacCer3.tRNAdb()` and
`EpiTxDb.Sc.sacCer3.RMBase()`

```
library(EpiTxDb.Sc.sacCer3)
```

```
etdb <- EpiTxDb.Sc.sacCer3.tRNAdb()
```

```
## snapshotDate(): 2021-01-14
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
## # Organism: Saccharomyces cerevisiae
## # Genome: sacCer3
## # Coordinates: per Transcript
## # Nb of modifications: 2990
## # Db created by: EpiTxDb package from Bioconductor
## # Creation time: 2020-02-26 10:43:09 +0100 (Wed, 26 Feb 2020)
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
## GRanges object with 2990 ranges and 3 metadata columns:
##               seqnames    ranges strand |    mod_id    mod_type
##                  <Rle> <IRanges>  <Rle> | <integer> <character>
##      [1] tA(AGC)D_tRNA         9      + |         1         m1G
##      [2] tA(AGC)F_tRNA         9      + |         2         m1G
##      [3] tA(AGC)G_tRNA         9      + |         3         m1G
##      [4] tA(AGC)H_tRNA         9      + |         4         m1G
##      [5] tA(AGC)J_tRNA         9      + |         5         m1G
##      ...           ...       ...    ... .       ...         ...
##   [2986] tY(GUA)Q_tRNA        29      + |      3860         m2G
##   [2987] tY(GUA)Q_tRNA        30      + |      3861           Y
##   [2988] tY(GUA)Q_tRNA        40      + |      3862         i6A
##   [2989] tY(GUA)Q_tRNA        66      + |      3863         m5U
##   [2990] tY(GUA)Q_tRNA        67      + |      3864           Y
##                      mod_name
##                   <character>
##      [1]  m1G_9_tA(AGC)D_tRNA
##      [2]  m1G_9_tA(AGC)F_tRNA
##      [3]  m1G_9_tA(AGC)G_tRNA
##      [4]  m1G_9_tA(AGC)H_tRNA
##      [5]  m1G_9_tA(AGC)J_tRNA
##      ...                  ...
##   [2986] m2G_29_tY(GUA)Q_tRNA
##   [2987]   Y_30_tY(GUA)Q_tRNA
##   [2988] i6A_40_tY(GUA)Q_tRNA
##   [2989] m5U_66_tY(GUA)Q_tRNA
##   [2990]   Y_67_tY(GUA)Q_tRNA
##   -------
##   seqinfo: 258 sequences from sacCer3 genome; no seqlengths
```

For a more detailed overview and explanation of the functionality of the
`EpiTxDb` class, have a look at the `EpiTxDb` package.

# 2 Sessioninfo

```
sessionInfo()
```

```
## R Under development (unstable) (2021-01-20 r79850)
## Platform: x86_64-apple-darwin17.7.0 (64-bit)
## Running under: macOS High Sierra 10.13.6
##
## Matrix products: default
## BLAS:   /Users/ka36530_ca/R-stuff/bin/R-devel/lib/libRblas.dylib
## LAPACK: /Users/ka36530_ca/R-stuff/bin/R-devel/lib/libRlapack.dylib
##
## locale:
## [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] EpiTxDb.Sc.sacCer3_0.99.5 EpiTxDb_1.3.1
##  [3] Modstrings_1.7.1          Biostrings_2.59.2
##  [5] XVector_0.31.1            AnnotationDbi_1.53.0
##  [7] IRanges_2.25.6            S4Vectors_0.29.6
##  [9] Biobase_2.51.0            AnnotationHub_2.23.0
## [11] BiocFileCache_1.15.1      dbplyr_2.0.0
## [13] BiocGenerics_0.37.0       BiocStyle_2.19.1
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-6                  matrixStats_0.57.0
##  [3] bit64_4.0.5                   filelock_1.0.2
##  [5] progress_1.2.2                httr_1.4.2
##  [7] GenomeInfoDb_1.27.3           tools_4.1.0
##  [9] R6_2.5.0                      DBI_1.1.1
## [11] colorspace_2.0-0              withr_2.4.0
## [13] tidyselect_1.1.0              prettyunits_1.1.1
## [15] bit_4.0.4                     curl_4.3
## [17] compiler_4.1.0                xml2_1.3.2
## [19] DelayedArray_0.17.7           rtracklayer_1.51.4
## [21] bookdown_0.21                 scales_1.1.1
## [23] tRNA_1.9.0                    askpass_1.1
## [25] rappdirs_0.3.1                stringr_1.4.0
## [27] digest_0.6.27                 Rsamtools_2.7.1
## [29] rmarkdown_2.6                 pkgconfig_2.0.3
## [31] htmltools_0.5.1               MatrixGenerics_1.3.0
## [33] fastmap_1.0.1                 rlang_0.4.10
## [35] RSQLite_2.2.2                 shiny_1.5.0
## [37] BiocIO_1.1.2                  generics_0.1.0
## [39] BiocParallel_1.25.2           dplyr_1.0.3
## [41] RCurl_1.98-1.2                magrittr_2.0.1
## [43] GenomeInfoDbData_1.2.4        Matrix_1.3-2
## [45] Rcpp_1.0.6                    munsell_0.5.0
## [47] lifecycle_0.2.0               stringi_1.5.3
## [49] yaml_2.2.1                    SummarizedExperiment_1.21.1
## [51] zlibbioc_1.37.0               grid_4.1.0
## [53] blob_1.2.1                    promises_1.1.1
## [55] crayon_1.3.4                  lattice_0.20-41
## [57] tRNAdbImport_1.9.0            GenomicFeatures_1.43.3
## [59] hms_1.0.0                     knitr_1.30
## [61] pillar_1.4.7                  GenomicRanges_1.43.3
## [63] rjson_0.2.20                  biomaRt_2.47.1
## [65] XML_3.99-0.5                  glue_1.4.2
## [67] BiocVersion_3.13.1            evaluate_0.14
## [69] Structstrings_1.7.2           BiocManager_1.30.10
## [71] vctrs_0.3.6                   httpuv_1.5.5
## [73] gtable_0.3.0                  openssl_1.4.3
## [75] purrr_0.3.4                   assertthat_0.2.1
## [77] ggplot2_3.3.3                 xfun_0.20
## [79] mime_0.9                      xtable_1.8-4
## [81] restfulr_0.0.13               later_1.1.0.1
## [83] tibble_3.0.5                  GenomicAlignments_1.27.2
## [85] memoise_1.1.0                 ellipsis_0.3.1
## [87] interactiveDisplayBase_1.29.0
```

# References

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.

Xuan, Jia-Jia, Wen-Ju Sun, Peng-Hui Lin, Ke-Ren Zhou, Shun Liu, Ling-Ling Zheng, Liang-Hu Qu, and Jian-Hua Yang. 2017. “RMBase v2.0: deciphering the map of RNA modifications from epitranscriptome sequencing data.” *Nucleic Acids Research* 46 (D1): D327–D334. <https://doi.org/10.1093/nar/gkx934>.