# RNAmodR: RiboMethSeq

Felix G.M. Ernst and Denis L.J. Lafontaine

#### 2025-10-30

#### Abstract

Detection of 2’-O methylations by RiboMethSeq

# 1 Introduction

Among the various post-transcriptional RNA modifications, 2’-O methylations are
commonly found in rRNA and tRNA. They promote the endo conformation of the
ribose and confere resistance to alkaline degradation by preventing a
nucleophilic attack on the 3’-phosphate especially in flexible RNA, which is
fascilitated by high pH conditions. This property can be queried using a method
called RiboMethSeq [(Birkedal et al. [2015](#ref-Birkedal.2015))](#References) for which RNA is treated in
alkaline conditions and RNA fragments are used to prepare a sequencing library
[(Marchand et al. [2017](#ref-Marchand.2017))](#References).

At position containing a 2’-O methylations, read ends are less frequent, which
is used to detect and score the 2’-O methylations.

The `ModRiboMethSeq` class uses the the `ProtectedEndSequenceData` class to
store and aggregate data along the transcripts. The calculated scores follow the
nomenclature of [(Birkedal et al. [2015](#ref-Birkedal.2015); Galvanin et al. [2019](#ref-Galvanin.2019))](#References) with the names
`scoreRMS` (default), `scoreA`, `scoreB` and `scoreMean`.

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
library(RNAmodR.RiboMethSeq)
library(RNAmodR.Data)
```

# 2 Example workflow

The example workflow is limited to two 2’-O methylated position on 5.8S rRNA,
since the size of the raw data is limited. For annotation data either a gff file
or a `TxDb` object and for sequence data a fasta file or a `BSgenome` object can
be used. The data is provided as bam files.

```
annotation <- GFF3File(RNAmodR.Data.example.RMS.gff3())
sequences <- RNAmodR.Data.example.RMS.fasta()
files <- list("Sample1" = c(treated = RNAmodR.Data.example.RMS.1()),
              "Sample2" = c(treated = RNAmodR.Data.example.RMS.2()))
```

# 3 Analysis of data

The analysis is triggered by the construction of a `ModSetRiboMethSeq` object.
Internally parallelization is used via the `BiocParallel` package, which would
allow optimization depending on number/size of input files (number of samples,
number of replicates, number of transcripts, etc).

```
msrms <- ModSetRiboMethSeq(files, annotation = annotation, sequences = sequences)
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
msrms
```

```
## ModSetRiboMethSeq of length 2
## names(2): Sample1 Sample2
## | Modification type(s):  Am / Cm / Gm / Um
##                        Sample1 Sample2
## | Modifications found:      no yes (1)
## | Settings:
##         minCoverage minReplicate  find.mod maxLength minSignal flankingRegion
##           <integer>    <integer> <logical> <integer> <integer>      <integer>
## Sample1          10            1      TRUE        50        10              6
## Sample2          10            1      TRUE        50        10              6
##         minScoreA minScoreB minScoreRMS minScoreMean flankingRegionMean
##         <numeric> <numeric>   <numeric>    <numeric>          <integer>
## Sample1       0.6       3.6        0.75         0.75                  2
## Sample2       0.6       3.6        0.75         0.75                  2
##                 weights
##           <NumericList>
## Sample1 0.9,1.0,0.0,...
## Sample2 0.9,1.0,0.0,...
##         scoreOperator
##           <character>
## Sample1             &
## Sample2             &
```

# 4 Visualizing the results

To compare samples, we need to know, which positions should be part of the
comparison. This can either be done by aggregating the detect over all samples
and use the union or intersect or by using publish data. We want to assemble
a GRanges object from the latter by utilising the infomation from the snoRNAdb
[(Lestrade and Weber [2006](#ref-Lestrade.2006))](#References).

In this specific example only information for the 5.8S RNA is used, since the
example data would be to big otherwise. The information regarding the parent and
seqname must match the information used as the annotation data. Check that it
matches the output of `ranges()` on a `SequenceData`, `Modifier` oder
`ModifierSet` object.

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
table <- table[table$hgnc_id == "53533",] # Subset to RNA5.8S
# keep only the current coordinates
table <- table[,1L:7L]
snoRNAdb <- GRanges(seqnames = "chr1",
              ranges = IRanges(start = table$position,
                               width = 1),
              strand = "+",
              type = "RNAMOD",
              mod = table$modification,
              Parent = "1", #this is the transcript id
              Activity = IRanges::CharacterList(strsplit(table$guide,",")))
coord <- split(snoRNAdb,snoRNAdb$Parent)
```

In addition to the coordinates of published, we also want to include more
meaningful names for the transcripts. For this we provide a `data.frame` with
two columns, `tx_id` and `name`. All values in the first column have to match
transcript IDs.

```
ranges(msrms)
```

```
## GRangesList object of length 1:
## $`1`
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |   exon_id   exon_name exon_rank
##          <Rle> <IRanges>  <Rle> | <integer> <character> <integer>
##   [1]     chr1     1-157      + |         1 NR_003285.2         1
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
alias <- data.frame(tx_id = "1", name = "5.8S rRNA", stringsAsFactors = FALSE)
```

```
plotCompareByCoord(msrms[c(2L,1L)], coord, alias = alias)
```

![Heatmap showing RiboMethSeq scores for 2'-O methylated positions on the 5.8S rRNA.](data:image/png;base64...)

Figure 1: Heatmap showing RiboMethSeq scores for 2’-O methylated positions on the 5.8S rRNA

Results can also be compared on a sequence level, by selecting specific
coordinates to compare.

```
singleCoord <- coord[[1L]][1L,]
plotDataByCoord(msrms, singleCoord)
```

![RiboMethSeq scores around Um(14) on 5.8S rRNA.](data:image/png;base64...)

Figure 2: RiboMethSeq scores around Um(14) on 5.8S rRNA

By default only the RiboMethSeq score and the ScoreMean are shown. The raw
sequence data can be inspected as well

```
singleCoord <- coord[[1L]][1L,]
plotDataByCoord(msrms, singleCoord, showSequenceData = TRUE)
```

![RiboMethSeq scores around Um(14) on 5.8S rRNA. Sequence data is shown by setting `showSequenceData = TRUE`.](data:image/png;base64...)

Figure 3: RiboMethSeq scores around Um(14) on 5.8S rRNA
Sequence data is shown by setting `showSequenceData = TRUE`.

# 5 Performance

To access the performance of the method in combination with samples used, use
the `plotROC` function.

```
plotROC(msrms,coord)
```

![TPR versus FPR plot.](data:image/png;base64...)

Figure 4: TPR versus FPR plot

The example given here should be regarded as a proof of concept. Based on the
results, minimal scores for calling modified positions can be adjusted to the
individual requirements.

```
settings(msrms) <- list(minScoreMean = 0.7)
msrms
```

```
## ModSetRiboMethSeq of length 2
## names(2): Sample1 Sample2
## | Modification type(s):  Am / Cm / Gm / Um
##                        Sample1 Sample2
## | Modifications found:      no yes (1)
## | Settings:
##         minCoverage minReplicate  find.mod maxLength minSignal flankingRegion
##           <integer>    <integer> <logical> <integer> <integer>      <integer>
## Sample1          10            1      TRUE        50        10              6
## Sample2          10            1      TRUE        50        10              6
##         minScoreA minScoreB minScoreRMS minScoreMean flankingRegionMean
##         <numeric> <numeric>   <numeric>    <numeric>          <integer>
## Sample1       0.6       3.6        0.75          0.7                  2
## Sample2       0.6       3.6        0.75          0.7                  2
##                 weights
##           <NumericList>
## Sample1 0.9,1.0,0.0,...
## Sample2 0.9,1.0,0.0,...
##         scoreOperator
##           <character>
## Sample1             &
## Sample2             &
```

```
## Warning: Settings were changed after data aggregation or modification search.
## Rerun with modify(x,force = TRUE) to update with current settings.
```

As the warning suggested, after modifying the settings the results should be
updated by running `modify(x,force = TRUE)`.

```
msrms2 <- modify(msrms,force = TRUE)
```

# 6 Session info

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
##  [1] Rsamtools_2.26.0           RNAmodR.Data_1.23.0
##  [3] ExperimentHubData_1.36.0   AnnotationHubData_1.40.0
##  [5] futile.logger_1.4.3        ExperimentHub_3.0.0
##  [7] AnnotationHub_4.0.0        BiocFileCache_3.0.0
##  [9] dbplyr_2.5.1               RNAmodR.RiboMethSeq_1.24.0
## [11] RNAmodR_1.24.0             Modstrings_1.26.0
## [13] Biostrings_2.78.0          XVector_0.50.0
## [15] rtracklayer_1.70.0         GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0              IRanges_2.44.0
## [19] S4Vectors_0.48.0           BiocGenerics_0.56.0
## [21] generics_0.1.4             BiocStyle_2.38.0
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

Birkedal, Ulf, Mikkel Christensen-Dalsgaard, Nicolai Krogh, Radhakrishnan Sabarinathan, Jan Gorodkin, and Henrik Nielsen. 2015. “Profiling of Ribose Methylations in Rna by High-Throughput Sequencing.” *Angewandte Chemie (International Ed. In English)* 54 (2): 451–55. <https://doi.org/10.1002/anie.201408362>.

Galvanin, Adeline, Lilia Ayadi, Mark Helm, Yuri Motorin, and Virginie Marchand. 2019. “Mapping and Quantification of tRNA 2’-O-Methylation by Ribomethseq.” Edited by Narendra Wajapeyee and Romi Gupta, 273–95. <https://doi.org/10.1007/978-1-4939-8808-2_21>.

Lestrade, Laurent, and Michel J. Weber. 2006. “snoRNA-LBME-db, a comprehensive database of human H/ACA and C/D box snoRNAs.” *Nucleic Acids Research* 34 (January): D158–D162. <https://doi.org/10.1093/nar/gkj002>.

Marchand, Virginie, Lilia Ayadi, Aseel El Hajj, Florence Blanloeil-Oillo, Mark Helm, and Yuri Motorin. 2017. “High-Throughput Mapping of 2’-O-Me Residues in Rna Using Next-Generation Sequencing (Illumina Ribomethseq Protocol).” *Methods in Molecular Biology (Clifton, N.J.)* 1562: 171–87. <https://doi.org/10.1007/978-1-4939-6807-7_12>.