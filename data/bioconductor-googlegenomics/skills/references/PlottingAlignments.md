# Plotting Alignments

#### *30 October 2018*

# Contents

* [0.1 Working with Reads](#working-with-reads)
* [0.2 Plotting Alignments](#plotting-alignments)
* [0.3 Provenance](#provenance)

## 0.1 Working with Reads

[Google Genomics](http://cloud.google.com/genomics) implements the [GA4GH](http://ga4gh.org/) reads API and this R package can retrieve data from that implementation. For more detail, see <https://cloud.google.com/genomics/v1beta2/reference/reads>

```
library(GoogleGenomics)
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate
```

By default, this function retrieves reads for a small genomic region for one sample in [1,000 Genomes](http://googlegenomics.readthedocs.org/en/latest/use_cases/discover_public_data/1000_genomes.html).

```
reads <- getReads()
```

```
## Fetching reads page.
```

```
## Reads are now available.
```

```
length(reads)
```

```
## [1] 18
```

We can see that 18 individual reads were returned and that the JSON response was deserialized into an R list object:

```
class(reads)
```

```
## [1] "list"
```

```
mode(reads)
```

```
## [1] "list"
```

The top level field names are:

```
names(reads[[1]])
```

```
##  [1] "id"                        "readGroupId"
##  [3] "readGroupSetId"            "fragmentName"
##  [5] "properPlacement"           "duplicateFragment"
##  [7] "fragmentLength"            "readNumber"
##  [9] "numberReads"               "failedVendorQualityChecks"
## [11] "alignment"                 "secondaryAlignment"
## [13] "supplementaryAlignment"    "alignedSequence"
## [15] "alignedQuality"            "nextMatePosition"
## [17] "info"
```

And examining the alignment we see:

```
reads[[1]]$alignedSequence
```

```
## [1] "AACAAAAAACTGTCTAACAAGATTTTATGGTTTATAGACCATGATTCCCCGGACACATTAGATAGAAATCTGGGCAAGAGAAGAAAAAAAGGTCAGAGTT"
```

```
reads[[1]]$alignment$position$referenceName
```

```
## [1] "22"
```

```
reads[[1]]$alignment$position$position
```

```
## [1] "16051308"
```

This is good, but this data becomes **much** more useful when it is converted to Bioconductor data types. For example, we can convert reads in this list representation to *[GAlignments](https://bioconductor.org/packages/3.8/GAlignments)*:

```
readsToGAlignments(reads)
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## GAlignments object with 18 alignments and 1 metadata column:
##                      seqnames strand       cigar    qwidth     start
##                         <Rle>  <Rle> <character> <integer> <integer>
##   ERR251039.44923356    chr22      -        100M       100  16051309
##   ERR251039.28556355    chr22      +        100M       100  16051323
##   ERR016214.27010769    chr22      +     75M1D6M        81  16051330
##   ERR016213.15718767    chr22      +         68M        68  16051400
##   ERR016213.29749886    chr22      -         68M        68  16051403
##                  ...      ...    ...         ...       ...       ...
##    ERR251040.1475552    chr22      +        100M       100  16051454
##    ERR251040.3762117    chr22      +        100M       100  16051469
##   ERR251040.11853979    chr22      +        100M       100  16051478
##   ERR251040.34469189    chr22      +        100M       100  16051486
##   ERR251040.38772006    chr22      -        100M       100  16051498
##                            end     width     njunc |      flag
##                      <integer> <integer> <integer> | <numeric>
##   ERR251039.44923356  16051408       100         0 |       147
##   ERR251039.28556355  16051422       100         0 |       163
##   ERR016214.27010769  16051411        82         0 |        99
##   ERR016213.15718767  16051467        68         0 |       163
##   ERR016213.29749886  16051470        68         0 |       153
##                  ...       ...       ...       ... .       ...
##    ERR251040.1475552  16051553       100         0 |       163
##    ERR251040.3762117  16051568       100         0 |       163
##   ERR251040.11853979  16051577       100         0 |       163
##   ERR251040.34469189  16051585       100         0 |        99
##   ERR251040.38772006  16051597       100         0 |        83
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 0.2 Plotting Alignments

Let’s take a look at the reads that overlap [rs9536314](http://www.ncbi.nlm.nih.gov/SNP/snp_ref.cgi?rs=9536314) for sample NA12893 within the [Illumina Platinum Genomes](http://googlegenomics.readthedocs.org/en/latest/use_cases/discover_public_data/platinum_genomes.html) dataset. This SNP resides on chromosome 13 at position 33628137 in 0-based coordinates.

```
# Change the values of 'chromosome', 'start', or 'end' here if you wish to plot
# alignments from a different portion of the genome.
alignments <- getReads(readGroupSetId="CMvnhpKTFhD3he72j4KZuyc",
                       chromosome="chr13",
                       start=33628130,
                       end=33628145,
                       converter=readsToGAlignments)
```

```
## Fetching reads page.
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Reads are now available.
```

```
alignments
```

```
## GAlignments object with 67 alignments and 1 metadata column:
##                                             seqnames strand       cigar
##                                                <Rle>  <Rle> <character>
##    HSQ1008:141:D0CC8ACXX:4:2201:3978:155671    chr13      +        101M
##    HSQ1008:141:D0CC8ACXX:3:1206:7108:129302    chr13      -        101M
##    HSQ1008:141:D0CC8ACXX:2:1307:18541:80804    chr13      +        101M
##    HSQ1008:141:D0CC8ACXX:4:2108:12961:30710    chr13      -        101M
##     HSQ1008:141:D0CC8ACXX:1:2308:18484:6721    chr13      -        101M
##                                         ...      ...    ...         ...
##   HSQ1008:141:D0CC8ACXX:2:1308:19101:126736    chr13      +        101M
##    HSQ1008:141:D0CC8ACXX:2:1302:13881:79089    chr13      -        101M
##     HSQ1008:141:D0CC8ACXX:2:2108:1700:58641    chr13      -        101M
##     HSQ1008:141:D0CC8ACXX:1:2104:4131:31083    chr13      +        101M
##     HSQ1008:141:D0CC8ACXX:4:2302:3851:18256    chr13      +        101M
##                                                qwidth     start       end
##                                             <integer> <integer> <integer>
##    HSQ1008:141:D0CC8ACXX:4:2201:3978:155671       101  33628031  33628131
##    HSQ1008:141:D0CC8ACXX:3:1206:7108:129302       101  33628033  33628133
##    HSQ1008:141:D0CC8ACXX:2:1307:18541:80804       101  33628039  33628139
##    HSQ1008:141:D0CC8ACXX:4:2108:12961:30710       101  33628042  33628142
##     HSQ1008:141:D0CC8ACXX:1:2308:18484:6721       101  33628043  33628143
##                                         ...       ...       ...       ...
##   HSQ1008:141:D0CC8ACXX:2:1308:19101:126736       101  33628133  33628233
##    HSQ1008:141:D0CC8ACXX:2:1302:13881:79089       101  33628136  33628236
##     HSQ1008:141:D0CC8ACXX:2:2108:1700:58641       101  33628136  33628236
##     HSQ1008:141:D0CC8ACXX:1:2104:4131:31083       101  33628139  33628239
##     HSQ1008:141:D0CC8ACXX:4:2302:3851:18256       101  33628141  33628241
##                                                 width     njunc |      flag
##                                             <integer> <integer> | <numeric>
##    HSQ1008:141:D0CC8ACXX:4:2201:3978:155671       101         0 |       163
##    HSQ1008:141:D0CC8ACXX:3:1206:7108:129302       101         0 |        83
##    HSQ1008:141:D0CC8ACXX:2:1307:18541:80804       101         0 |        99
##    HSQ1008:141:D0CC8ACXX:4:2108:12961:30710       101         0 |        83
##     HSQ1008:141:D0CC8ACXX:1:2308:18484:6721       101         0 |       147
##                                         ...       ...       ... .       ...
##   HSQ1008:141:D0CC8ACXX:2:1308:19101:126736       101         0 |        99
##    HSQ1008:141:D0CC8ACXX:2:1302:13881:79089       101         0 |        83
##     HSQ1008:141:D0CC8ACXX:2:2108:1700:58641       101         0 |       147
##     HSQ1008:141:D0CC8ACXX:1:2104:4131:31083       101         0 |        99
##     HSQ1008:141:D0CC8ACXX:4:2302:3851:18256       101         0 |        99
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Notice that we passed the converter to the getReads method so that we’re immediately working with GAlignments which means that we can start taking advantage of other Bioconductor functionality. Also keep in mind that the parameters `start` and `end` are expressed in 0-based coordinates per the GA4GH specification but the Bioconductor data type converters in *[GoogleGenomics](https://bioconductor.org/packages/3.8/GoogleGenomics)*, by default, transform the returned data to 1-based coordinates.

```
library(ggbio)
```

We can display the basic alignments and coverage data:

```
alignmentPlot <- autoplot(alignments, aes(color=strand, fill=strand))
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Scale for 'fill' is already present. Adding another scale for 'fill',
## which will replace the existing scale.
```

```
coveragePlot <- ggplot(as(alignments, "GRanges")) +
                stat_coverage(color="gray40", fill="skyblue")
tracks(alignmentPlot, coveragePlot,
       xlab="Reads overlapping rs9536314 for NA12893")
```

![](data:image/png;base64...)

And also display the ideogram for the corresponding location on the chromosome:

```
ideogramPlot <- plotIdeogram(genome="hg19", subchr="chr13")
```

```
## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead

## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead
```

```
ideogramPlot + xlim(as(alignments, "GRanges"))
```

```
## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead

## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
## instead
```

![](data:image/png;base64...)

## 0.3 Provenance

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ggbio_1.30.0
##  [2] ggplot2_3.1.0
##  [3] org.Hs.eg.db_3.7.0
##  [4] BSgenome.Hsapiens.UCSC.hg19_1.4.0
##  [5] BSgenome_1.50.0
##  [6] rtracklayer_1.42.0
##  [7] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
##  [8] GenomicFeatures_1.34.0
##  [9] AnnotationDbi_1.44.0
## [10] GoogleGenomics_2.4.0
## [11] VariantAnnotation_1.28.0
## [12] GenomicAlignments_1.18.0
## [13] Rsamtools_1.34.0
## [14] Biostrings_2.50.0
## [15] XVector_0.22.0
## [16] SummarizedExperiment_1.12.0
## [17] DelayedArray_0.8.0
## [18] BiocParallel_1.16.0
## [19] matrixStats_0.54.0
## [20] Biobase_2.42.0
## [21] GenomicRanges_1.34.0
## [22] GenomeInfoDb_1.18.0
## [23] IRanges_2.16.0
## [24] S4Vectors_0.20.0
## [25] BiocGenerics_0.28.0
## [26] knitr_1.20
## [27] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] ProtGenerics_1.14.0    bitops_1.0-6           bit64_0.9-7
##  [4] RColorBrewer_1.1-2     progress_1.2.0         httr_1.3.1
##  [7] rprojroot_1.3-2        tools_3.5.1            backports_1.1.2
## [10] R6_2.3.0               rpart_4.1-13           Hmisc_4.1-1
## [13] DBI_1.0.0              lazyeval_0.2.1         colorspace_1.3-2
## [16] nnet_7.3-12            withr_2.1.2            tidyselect_0.2.5
## [19] gridExtra_2.3          prettyunits_1.0.2      GGally_1.4.0
## [22] bit_1.1-14             curl_3.2               compiler_3.5.1
## [25] graph_1.60.0           htmlTable_1.12         labeling_0.3
## [28] bookdown_0.7           checkmate_1.8.5        scales_1.0.0
## [31] RBGL_1.58.0            stringr_1.3.1          digest_0.6.18
## [34] foreign_0.8-71         rmarkdown_1.10         dichromat_2.0-0
## [37] base64enc_0.1-3        pkgconfig_2.0.2        htmltools_0.3.6
## [40] ensembldb_2.6.0        htmlwidgets_1.3        rlang_0.3.0.1
## [43] rstudioapi_0.8         RSQLite_2.1.1          bindr_0.1.1
## [46] jsonlite_1.5           acepack_1.4.1          dplyr_0.7.7
## [49] RCurl_1.95-4.11        magrittr_1.5           Formula_1.2-3
## [52] GenomeInfoDbData_1.2.0 Matrix_1.2-14          Rcpp_0.12.19
## [55] munsell_0.5.0          stringi_1.2.4          yaml_2.2.0
## [58] zlibbioc_1.28.0        plyr_1.8.4             grid_3.5.1
## [61] blob_1.1.1             crayon_1.3.4           lattice_0.20-35
## [64] splines_3.5.1          hms_0.4.2              pillar_1.3.0
## [67] rjson_0.2.20           reshape2_1.4.3         biomaRt_2.38.0
## [70] XML_3.98-1.16          glue_1.3.0             evaluate_0.12
## [73] biovizBase_1.30.0      latticeExtra_0.6-28    data.table_1.11.8
## [76] BiocManager_1.30.3     gtable_0.2.0           purrr_0.2.5
## [79] reshape_0.8.8          assertthat_0.2.0       xfun_0.4
## [82] AnnotationFilter_1.6.0 survival_2.43-1        OrganismDbi_1.24.0
## [85] tibble_1.4.2           memoise_1.1.0          cluster_2.0.7-1
## [88] bindrcpp_0.2.2
```