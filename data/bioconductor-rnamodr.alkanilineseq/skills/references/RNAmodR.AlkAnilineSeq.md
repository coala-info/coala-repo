# RNAmodR: AlkAnilineSeq

Felix G.M. Ernst and Denis L.J. Lafontaine

#### 2025-10-30

#### Abstract

detection of m7G, m3C and D modification by AlkAnilineSeq

# 1 Introduction

7-methyl guanosine (m7G), 3-methyl cytidine (m3C) and Dihydrouridine (D)
are commonly found in rRNA and tRNA and can be detected classically by
primer extension analysis. However, since the modifications do not interfere
with Watson-Crick base pairing, a specific chemical treatment needs to be
employed to cause strand breaks specifically at the modified positions.
Initially, this involved a sodium borhydride treatment to create abasic sites
and cleaving the RNA at abasic sites with aniline.

This classical protocol was converted to a high throughput sequencing method
call AlkAnilineSeq and allows modified position be detected by an accumulation
of 5’-ends at the N+1 position [(Marchand et al. [2018](#ref-Marchand.2018))](#References). It was found,
that m3C is susceptible to this treatment, which allows m7G, m3C and D to be
detected by the same method from the same data sets, since the identify of the
unmodified nucleotide informs about the three modified nucleotides.

The `ModAlkAnilineSeq` class uses the the `NormEnd5SequenceData` class to store
and aggregate data along the transcripts. The calculated scores follow the
nomenclature of [(Marchand et al. [2018](#ref-Marchand.2018))](#References) with the names `scoreNC`
(default) and `scoreSR`.

```
## No methods found in package 'rtracklayer' for request: 'trackName<-' when loading 'AnnotationHubData'
```

```
## Warning: replacing previous import 'utils::findMatches' by
## 'S4Vectors::findMatches' when loading 'ExperimentHubData'
```

```
library(rtracklayer)
library(GenomicRanges)
library(RNAmodR.AlkAnilineSeq)
library(RNAmodR.Data)
```

# 2 Example workflow

The example workflow is limited to 18S rRNA and some tRNA from *S.cerevisiae*.
As annotation data either a gff file or a `TxDb` object and for sequence data
a fasta file or a `BSgenome` object can be used. The data is provided as bam
files.

```
annotation <- GFF3File(RNAmodR.Data.example.AAS.gff3())
sequences <- RNAmodR.Data.example.AAS.fasta()
files <- list("wt" = c(treated = RNAmodR.Data.example.wt.1(),
                       treated = RNAmodR.Data.example.wt.2(),
                       treated = RNAmodR.Data.example.wt.3()),
              "Bud23del" = c(treated = RNAmodR.Data.example.bud23.1(),
                             treated = RNAmodR.Data.example.bud23.2()),
              "Trm8del" = c(treated = RNAmodR.Data.example.trm8.1(),
                            treated = RNAmodR.Data.example.trm8.2()))
```

The analysis is triggered by the construction of a `ModSetAlkAnilineSeq` object.
Internally parallelization is used via the `BiocParallel` package, which would
allow optimization depending on number/size of input files (number of samples,
number of replicates, number of transcripts, etc).

```
msaas <- ModSetAlkAnilineSeq(files, annotation = annotation, sequences = sequences)
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ...
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## OK
```

```
msaas
```

```
## ModSetAlkAnilineSeq of length 3
## names(3): wt Bud23del Trm8del
## | Modification type(s):  m7G / m3C / D
##                             wt Bud23del Trm8del
## | Modifications found: yes (9)  yes (8) yes (7)
## | Settings:
##          minCoverage minReplicate  find.mod minLength minSignal minScoreNC
##            <integer>    <integer> <logical> <integer> <integer>  <integer>
## wt                10            1      TRUE         9        10         50
## Bud23del          10            1      TRUE         9        10         50
## Trm8del           10            1      TRUE         9        10         50
##          minScoreSR minScoreBaseScore scoreOperator
##           <numeric>         <numeric>   <character>
## wt              0.5               0.9             &
## Bud23del        0.5               0.9             &
## Trm8del         0.5               0.9             &
```

As expected the m7G1575 is missing from the Bud23del samples.

```
mod <- modifications(msaas)
lapply(mod,head, n = 2L)
```

```
## $wt
## GRanges object with 2 ranges and 6 metadata columns:
##       seqnames    ranges strand |         mod                source        type
##          <Rle> <IRanges>  <Rle> | <character>           <character> <character>
##   [1]     chr1      1575      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##   [2]     chr3        46      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##           score   scoreSR      Parent
##       <numeric> <numeric> <character>
##   [1]   162.228  0.984209           1
##   [2]   373.773  0.841166           3
##   -------
##   seqinfo: 11 sequences from an unspecified genome; no seqlengths
##
## $Bud23del
## GRanges object with 2 ranges and 6 metadata columns:
##       seqnames    ranges strand |         mod                source        type
##          <Rle> <IRanges>  <Rle> | <character>           <character> <character>
##   [1]     chr3        46      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##   [2]     chr5        50      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##           score   scoreSR      Parent
##       <numeric> <numeric> <character>
##   [1]  254.6403  0.858101           3
##   [2]   86.3556  0.605249           5
##   -------
##   seqinfo: 11 sequences from an unspecified genome; no seqlengths
##
## $Trm8del
## GRanges object with 2 ranges and 6 metadata columns:
##       seqnames    ranges strand |         mod                source        type
##          <Rle> <IRanges>  <Rle> | <character>           <character> <character>
##   [1]     chr1      1575      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##   [2]     chr3        37      + |         m7G RNAmodR.AlkAnilineSeq      RNAMOD
##           score   scoreSR      Parent
##       <numeric> <numeric> <character>
##   [1]  117.2479   0.98729           1
##   [2]   69.9604   0.97953           3
##   -------
##   seqinfo: 11 sequences from an unspecified genome; no seqlengths
```

# 3 Visualizing the results

As outlined in the `RNAmodR` package we can compare the samples using the
`plotCompareByCoord` to prepare a heatmap. For this we select some position
from the found modifications. In addition we prepare an alias table.

```
coord <- mod[[1L]]
alias <- data.frame(tx_id = c(1L,3L,5L,6L,7L,8L,10L,11L),
                    name = c("18S rRNA","tF(GAA)B","tG(GCC)B","tT(AGT)B",
                             "tQ(TTG)B","tC(GCA)B","tS(CGA)C","tV(AAC)E1"),
                    stringsAsFactors = FALSE)
```

```
plotCompareByCoord(msaas, coord, score = "scoreSR", alias = alias,
                   normalize = TRUE)
```

![Heatmap showing Stop ratio scores for detected m7G, m3C and D positions.](data:image/png;base64...)

Figure 1: Heatmap showing Stop ratio scores for detected m7G, m3C and D positions

```
plotCompareByCoord(msaas, coord[1L], score = "scoreSR", alias = alias)
```

![Heatmap showing Stop ratio scores for detected m7G1575 on the 18S rRNA.](data:image/png;base64...)

Figure 2: Heatmap showing Stop ratio scores for detected m7G1575 on the 18S rRNA

In addition, the aggregate data along the transcript visualized as well.

```
plotData(msaas, "1", from = 1550L, to = 1600L)
```

![Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence.](data:image/png;base64...)

Figure 3: Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence

This includes raw data as well.

```
plotData(msaas[1L:2L], "1", from = 1550L, to = 1600L, showSequenceData = TRUE)
```

![Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence. The raw sequence data is shown by setting `showSequenceData = TRUE.](data:image/png;base64...)

Figure 4: Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence
The raw sequence data is shown by setting `showSequenceData = TRUE.

# 4 Session info

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
##  [1] Rsamtools_2.26.0             RNAmodR.Data_1.23.0
##  [3] ExperimentHubData_1.36.0     AnnotationHubData_1.40.0
##  [5] futile.logger_1.4.3          ExperimentHub_3.0.0
##  [7] AnnotationHub_4.0.0          BiocFileCache_3.0.0
##  [9] dbplyr_2.5.1                 RNAmodR.AlkAnilineSeq_1.24.0
## [11] RNAmodR_1.24.0               Modstrings_1.26.0
## [13] Biostrings_2.78.0            XVector_0.50.0
## [15] rtracklayer_1.70.0           GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0                IRanges_2.44.0
## [19] S4Vectors_0.48.0             BiocGenerics_0.56.0
## [21] generics_0.1.4               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] BiocIO_1.20.0               bitops_1.0-9
##   [3] filelock_1.0.3              tibble_3.3.0
##   [5] graph_1.88.0                XML_3.99-0.19
##   [7] rpart_4.1.24                lifecycle_1.0.4
##   [9] httr2_1.2.1                 lattice_0.22-7
##  [11] ensembldb_2.34.0            OrganismDbi_1.52.0
##  [13] backports_1.5.0             magrittr_2.0.4
##  [15] Hmisc_5.2-4                 sass_0.4.10
##  [17] rmarkdown_2.30              jquerylib_0.1.4
##  [19] yaml_2.3.10                 RUnit_0.4.33.1
##  [21] Gviz_1.54.0                 DBI_1.2.3
##  [23] RColorBrewer_1.1-3          abind_1.4-8
##  [25] purrr_1.1.0                 AnnotationFilter_1.34.0
##  [27] biovizBase_1.58.0           RCurl_1.98-1.17
##  [29] nnet_7.3-20                 VariantAnnotation_1.56.0
##  [31] rappdirs_0.3.3              AnnotationForge_1.52.0
##  [33] codetools_0.2-20            DelayedArray_0.36.0
##  [35] tidyselect_1.2.1            UCSC.utils_1.6.0
##  [37] farver_2.1.2                matrixStats_1.5.0
##  [39] base64enc_0.1-3             GenomicAlignments_1.46.0
##  [41] jsonlite_2.0.0              Formula_1.2-5
##  [43] tools_4.5.1                 progress_1.2.3
##  [45] stringdist_0.9.15           Rcpp_1.1.0
##  [47] glue_1.8.0                  gridExtra_2.3
##  [49] SparseArray_1.10.0          BiocBaseUtils_1.12.0
##  [51] xfun_0.53                   MatrixGenerics_1.22.0
##  [53] GenomeInfoDb_1.46.0         dplyr_1.1.4
##  [55] withr_3.0.2                 formatR_1.14
##  [57] BiocManager_1.30.26         fastmap_1.2.0
##  [59] latticeExtra_0.6-31         digest_0.6.37
##  [61] R6_2.6.1                    colorspace_2.1-2
##  [63] jpeg_0.1-11                 dichromat_2.0-0.1
##  [65] biomaRt_2.66.0              RSQLite_2.4.3
##  [67] cigarillo_1.0.0             data.table_1.17.8
##  [69] prettyunits_1.2.0           httr_1.4.7
##  [71] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [73] pkgconfig_2.0.3             gtable_0.3.6
##  [75] blob_1.2.4                  S7_0.2.0
##  [77] htmltools_0.5.8.1           bookdown_0.45
##  [79] RBGL_1.86.0                 ProtGenerics_1.42.0
##  [81] scales_1.4.0                Biobase_2.70.0
##  [83] png_0.1-8                   colorRamps_2.3.4
##  [85] knitr_1.50                  lambda.r_1.2.4
##  [87] rstudioapi_0.17.1           reshape2_1.4.4
##  [89] rjson_0.2.23                checkmate_2.3.3
##  [91] curl_7.0.0                  biocViews_1.78.0
##  [93] cachem_1.1.0                stringr_1.5.2
##  [95] BiocVersion_3.22.0          parallel_4.5.1
##  [97] foreign_0.8-90              AnnotationDbi_1.72.0
##  [99] restfulr_0.0.16             pillar_1.11.1
## [101] grid_4.5.1                  vctrs_0.6.5
## [103] cluster_2.1.8.1             htmlTable_2.4.3
## [105] evaluate_1.0.5              magick_2.9.0
## [107] tinytex_0.57                GenomicFeatures_1.62.0
## [109] cli_3.6.5                   compiler_4.5.1
## [111] futile.options_1.0.1        rlang_1.1.6
## [113] crayon_1.5.3                labeling_0.4.3
## [115] interp_1.1-6                plyr_1.8.9
## [117] stringi_1.8.7               deldir_2.0-4
## [119] BiocParallel_1.44.0         BiocCheck_1.46.0
## [121] txdbmaker_1.6.0             lazyeval_0.2.2
## [123] Matrix_1.7-4                BSgenome_1.78.0
## [125] hms_1.1.4                   bit64_4.6.0-1
## [127] ggplot2_4.0.0               KEGGREST_1.50.0
## [129] SummarizedExperiment_1.40.0 ROCR_1.0-11
## [131] memoise_2.0.1               bslib_0.9.0
## [133] bit_4.6.0
```

# References

Marchand, Virginie, Lilia Ayadi, Felix G. M. Ernst, Jasmin Hertler, Valérie Bourguignon-Igel, Adeline Galvanin, Annika Kotter, Mark Helm, Denis L. J. Lafontaine, and Yuri Motorin. 2018. “AlkAniline-Seq: Profiling of m7G and m3C Rna Modifications at Single Nucleotide Resolution.” *Angewandte Chemie International Edition* 57 (51): 16785–90. <https://doi.org/10.1002/anie.201810946>.