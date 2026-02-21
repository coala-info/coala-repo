# EpiTxDb.Hs.hg38: Annotation package for EpiTxDb objects

Felix G.M. Ernst

#### 2020-09-18

#### Package

EpiTxDb.Hs.hg38 0.99.7

# 1 Available resources

`EpiTxDb.Hs.hg38` contains post-transcriptional RNA modifications from RMBase
v2.0 [(Xuan et al. 2017)](#References), tRNAdb [(Jühling et al. 2009)](#References) and
snoRNAdb [(Lestrade and Weber 2006)](#References) and can be accessed through the
functions `EpiTxDb.Hs.hg38.tRNAdb()`, `EpiTxDb.Hs.hg38.snoRNAdb()` and
`EpiTxDb.Hs.hg38.RMBase()`

```
library(EpiTxDb.Hs.hg38)
```

```
etdb <- EpiTxDb.Hs.hg38.tRNAdb()
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
## # Organism: Homo sapiens
## # Genome: hg38
## # Coordinates: per Transcript
## # Checked against sequence: Yes
## # Nb of modifications: 1843
## # Db created by: EpiTxDb package from Bioconductor
## # Creation time: 2020-02-26 10:35:24 +0100 (Wed, 26 Feb 2020)
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
## GRanges object with 1843 ranges and 3 metadata columns:
##                   seqnames    ranges strand |    mod_id    mod_type
##                      <Rle> <IRanges>  <Rle> | <integer> <character>
##      [1] tRNA-Ala-AGC-11-1        10      + |         1         m2G
##      [2] tRNA-Ala-AGC-15-1        10      + |         2         m2G
##      [3]  tRNA-Ala-AGC-8-1        10      + |         3         m2G
##      [4]  tRNA-Ala-AGC-8-2        10      + |         4         m2G
##      [5] tRNA-Ala-AGC-11-1        17      + |         5           D
##      ...               ...       ...    ... .       ...         ...
##   [1839]   ENST00000386347        50      + |      2546        f5Cm
##   [1840]   ENST00000386347        56      + |      2547         m5U
##   [1841]   ENST00000386347        57      + |      2548           Y
##   [1842]   ENST00000386347        60      + |      2549         m1A
##   [1843]   ENST00000387449        23      + |      2550         t6A
##                        mod_name
##                     <character>
##      [1] m2G_10_tRNA-Ala-AGC-..
##      [2] m2G_10_tRNA-Ala-AGC-..
##      [3] m2G_10_tRNA-Ala-AGC-..
##      [4] m2G_10_tRNA-Ala-AGC-..
##      [5] D_17_tRNA-Ala-AGC-11-1
##      ...                    ...
##   [1839] f5Cm_50_ENST00000386..
##   [1840] m5U_56_ENST00000386347
##   [1841]   Y_57_ENST00000386347
##   [1842] m1A_60_ENST00000386347
##   [1843] t6A_23_ENST00000387449
##   -------
##   seqinfo: 160 sequences from hg38 genome; no seqlengths
```

For a more detailed overview and explanation of the functionality of the
`EpiTxDb` class, have a look at the `EpiTxDb` package.

# 2 Chain files for rRNA

The rRNA sequence annotation for ribosomal RNA has undergone some clarification
processes in recent years. Therefore some of the annotation of modification
refer to an older rRNA annotation.

In order to help using and updating older information, a chain file was
generated for use with `liftOver`, which allows conversion of hg19 coordinates
to hg38 coordinates and back. The resources can be loaded via
`chain.rRNA.hg19Tohg38()` and `chain.rRNA.hg38Tohg19()`.

```
cf <- chain.rRNA.hg19Tohg38()
```

```
## snapshotDate(): 2020-09-03
```

```
## loading from cache
```

```
## require("rtracklayer")
```

```
cf
```

```
## Chain of length 3
## names(3): 5.8S 18S 28S
```

The following example illustrate a use case, in which data from the Modomics
[(“MODOMICS: A Database of Rna Modification Pathways. 2017 Update” 2018)](#References) database will be used. The sequence data
currently stored, is the hg19 version. First we load the sequence as
`ModRNAStringSet`.

```
library(rtracklayer)
library(Modstrings)
files <- c(system.file("extdata","Modomics.LSU.Hs.txt",
                       package = "EpiTxDb.Hs.hg38"),
           system.file("extdata","Modomics.SSU.Hs.txt",
                       package = "EpiTxDb.Hs.hg38"))
seq <- lapply(files,readLines,encoding = "UTF-8")
seq <- unlist(seq)
names <- seq[seq.int(1L,6L,2L)]
seq <- seq[seq.int(2L,6L,2L)]
seq <- ModRNAStringSet(sanitizeFromModomics(gsub("-","",seq)))
names(seq) <- c("28S","5.8S","18S")
mod <- separate(seq)
```

The position for the one `m7G` and two `m6A` are of for the current rRNA
sequences. This is also the case for the other modifications.

```
mod[mod$mod == "m7G" | mod$mod == "m6A"]
```

```
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames    ranges strand |         mod
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]      28S      4180      + |         m6A
##   [2]      18S      1640      + |         m7G
##   [3]      18S      1833      + |         m6A
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

Using the chain file we can `liftOver` the coordinates, which matches the
expected coordinates.

```
mod_new <- unlist(liftOver(mod,cf))
mod_new[mod_new$mod == "m7G" | mod_new$mod == "m6A"]
```

```
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames    ranges strand |         mod
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]      28S      4220      + |         m6A
##   [2]      18S      1639      + |         m7G
##   [3]      18S      1832      + |         m6A
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

In addition, the `ModRNAStringSet` object can be update with the current
sequence.

```
rna <- getSeq(snoRNA.targets.hg38())
```

```
## snapshotDate(): 2020-09-03
```

```
## loading from cache
```

```
## require("Rsamtools")
```

```
names(rna)[1:4] <- c("5S","18S","5.8S","28S")
seqtype(rna) <- "RNA"
seq_new <- combineIntoModstrings(rna, mod_new)
seq_new
```

```
##   A ModRNAStringSet instance of length 10
##      width seq                                              names
##  [1]   121 GUCUACGGCCAUACCACCCUGAA...AAUACCGGGUGCUGUAGGCUUU 5S
##  [2]  1869 UACCUGGUUGAUCCUGCCAGUAG...UGζζCCUGCGGAAGGAUCAUUA 18S
##  [3]   157 CGACUCUUAGCGGJGGAUCACUC...UACGCCUGUCUGAGCGUCGCUU 5.8S
##  [4]  5070 CGCGACCUCAGAUCAGACGUGGC...GCCCUCGACACAAGGGUUUGUC 28S
##  [5]   164 AUACUUACCUGGCAGGGGAGAUA...ACUGCGUUCGCGCUUUCCCCUG NR_004430
##  [6]   188 AUCGCUUCUCGGCCUUUUGGCUA...UACCUCCAGGAACGGUGCACCC NR_002716
##  [7]   144 AGCUUUGCGCAGUGGCAGUAUCG...UUGACAGUCUCUACGGAGACUG NR_003925
##  [8]   117 AUACUCUGGUUUCUCUUCAGAUC...AGGCCUUGCUUUGGCAAGGCUA NR_002756
##  [9]   106 GUGCUCGCUUCGGCAGCACAUAU...UUCGUGAAGCGUUCCAUAUUUU NR_004394
## [10]   150 NUGCCUUAAACUUAUGAGUAAGG...CCUGGGAGUUGCGAUCUGCCCG NR_029422
```

# 3 Sessioninfo

```
sessionInfo()
```

```
## R version 4.0.2 Patched (2020-09-15 r79213)
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
##  [1] Rsamtools_2.5.3        rtracklayer_1.49.5     GenomicRanges_1.41.6
##  [4] GenomeInfoDb_1.25.11   EpiTxDb.Hs.hg38_0.99.7 EpiTxDb_1.1.0
##  [7] Modstrings_1.5.1       Biostrings_2.57.2      XVector_0.29.3
## [10] AnnotationDbi_1.51.3   IRanges_2.23.10        S4Vectors_0.27.12
## [13] Biobase_2.49.1         AnnotationHub_2.21.5   BiocFileCache_1.13.1
## [16] dbplyr_1.4.4           BiocGenerics_0.35.4    BiocStyle_2.17.0
##
## loaded via a namespace (and not attached):
##  [1] httr_1.4.2                    bit64_4.0.5
##  [3] shiny_1.5.0                   assertthat_0.2.1
##  [5] interactiveDisplayBase_1.27.5 askpass_1.1
##  [7] BiocManager_1.30.10           blob_1.2.1
##  [9] GenomeInfoDbData_1.2.3        yaml_2.2.1
## [11] progress_1.2.2                BiocVersion_3.12.0
## [13] pillar_1.4.6                  RSQLite_2.2.0
## [15] lattice_0.20-41               glue_1.4.2
## [17] digest_0.6.25                 Structstrings_1.5.2
## [19] promises_1.1.1                colorspace_1.4-1
## [21] tRNA_1.7.1                    htmltools_0.5.0
## [23] httpuv_1.5.4                  Matrix_1.2-18
## [25] XML_3.99-0.5                  pkgconfig_2.0.3
## [27] biomaRt_2.45.2                bookdown_0.20
## [29] zlibbioc_1.35.0               purrr_0.3.4
## [31] xtable_1.8-4                  scales_1.1.1
## [33] later_1.1.0.1                 BiocParallel_1.23.2
## [35] tibble_3.0.3                  openssl_1.4.2
## [37] ggplot2_3.3.2                 generics_0.0.2
## [39] ellipsis_0.3.1                SummarizedExperiment_1.19.6
## [41] GenomicFeatures_1.41.3        magrittr_1.5
## [43] crayon_1.3.4                  mime_0.9
## [45] memoise_1.1.0                 evaluate_0.14
## [47] xml2_1.3.2                    tools_4.0.2
## [49] prettyunits_1.1.1             hms_0.5.3
## [51] matrixStats_0.56.0            lifecycle_0.2.0
## [53] stringr_1.4.0                 munsell_0.5.0
## [55] tRNAdbImport_1.7.1            DelayedArray_0.15.7
## [57] compiler_4.0.2                rlang_0.4.7
## [59] grid_4.0.2                    RCurl_1.98-1.2
## [61] rappdirs_0.3.1                bitops_1.0-6
## [63] rmarkdown_2.3                 gtable_0.3.0
## [65] DBI_1.1.0                     curl_4.3
## [67] R6_2.4.1                      GenomicAlignments_1.25.3
## [69] knitr_1.29                    dplyr_1.0.2
## [71] fastmap_1.0.1                 bit_4.0.4
## [73] stringi_1.5.3                 Rcpp_1.0.5
## [75] vctrs_0.3.4                   tidyselect_1.1.0
## [77] xfun_0.17
```

# References

Jühling, Frank, Mario Mörl, Roland K. Hartmann, Mathias Sprinzl, Peter F. Stadler, and Joern Pütz. 2009. “TRNAdb 2009: Compilation of tRNA Sequences and tRNA Genes.” *Nucleic Acids Research* 37: D159–D162. <https://doi.org/10.1093/nar/gkn772>.

Lestrade, Laurent, and Michel J. Weber. 2006. “snoRNA-LBME-db, a comprehensive database of human H/ACA and C/D box snoRNAs.” *Nucleic Acids Research* 34 (January): D158–D162. <https://doi.org/10.1093/nar/gkj002>.

“MODOMICS: A Database of Rna Modification Pathways. 2017 Update.” 2018. *Nucleic Acids Research* 46 (D1): D303–D307. <https://doi.org/10.1093/nar/gkx1030>.

Xuan, Jia-Jia, Wen-Ju Sun, Peng-Hui Lin, Ke-Ren Zhou, Shun Liu, Ling-Ling Zheng, Liang-Hu Qu, and Jian-Hua Yang. 2017. “RMBase v2.0: deciphering the map of RNA modifications from epitranscriptome sequencing data.” *Nucleic Acids Research* 46 (D1): D327–D334. <https://doi.org/10.1093/nar/gkx934>.