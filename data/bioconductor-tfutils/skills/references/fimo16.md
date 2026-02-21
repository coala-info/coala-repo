# A note on fimo16 in TFutils

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Importing with `scanTabix`](#importing-with-scantabix)

# 1 Introduction

Sequence-based TF affinity scoring can be conducted with the FIMO
suite, see @Sonawane2017. We have serialized an object with
references to FIMO outputs for 16 TFs.

```
suppressPackageStartupMessages({
library(TFutils)
library(GenomicRanges)
})
fimo16
```

```
## GenomicFiles object with 1 ranges and 16 files:
## files: M0635_1.02sort.bed.gz, M3433_1.02sort.bed.gz, ..., M6159_1.02sort.bed.gz, M6497_1.02sort.bed.gz
## detail: use files(), rowRanges(), colData(), ...
```

While the token `bed` is used in the filenames, the files are
not actually bed format!

# 2 Importing with `scanTabix`

We can use `reduceByRange` to import selected scans.

```
if (.Platform$OS.type != "windows") {
 si = TFutils::seqinfo_hg19_chr17
 myg = GRanges("chr17", IRanges(38.07e6,38.09e6), seqinfo=si)
 colnames(fimo16) = fimo16$HGNC
 lk2 = GenomicFiles::reduceByRange(fimo16[, c("POU2F1", "VDR")],
   MAP=function(r,f) scanTabix(f, param=r))
 str(lk2)
}
```

```
## List of 1
##  $ :List of 2
##   ..$ POU2F1:List of 1
##   .. ..$ chr17:38077000-38084000: chr [1:12] "chr17\t38077313\t38077331\tchr17:38077313-38077331\t2.15306\t+\t0.000352" "chr17\t38078549\t38078567\tchr17:38078549-38078567\t0.102041\t-\t0.000634" "chr17\t38078556\t38078574\tchr17:38078556-38078574\t-0.0408163\t-\t0.00066" "chr17\t38080045\t38080063\tchr17:38080045-38080063\t1.66327\t-\t0.000407" ...
##   ..$ VDR   :List of 1
##   .. ..$ chr17:38077000-38084000: chr [1:18] "chr17\t38077445\t38077460\tchr17:38077445-38077460\t-1.9899\t-\t0.000666" "chr17\t38078536\t38078551\tchr17:38078536-38078551\t-2.66667\t-\t0.0008" "chr17\t38078574\t38078589\tchr17:38078574-38078589\t1.65657\t+\t0.000235" "chr17\t38078796\t38078811\tchr17:38078796-38078811\t2.07071\t-\t0.000207" ...
```

This result can be massaged into a GRanges or other desirable structure.
`fimo_granges` takes care of this.

```
#fimo_ranges = function(gf, query) { # prototypical code
# rowRanges(gf) = query
# ans = GenomicFiles::reduceByRange(gf, MAP=function(r,f) scanTabix(f, param=r))
# ans = unlist(ans, recursive=FALSE)  # drop top list structure
# tabs = lapply(ans, lapply, function(x) {
#     con = textConnection(x)
#     on.exit(close(con))
#     dtf = read.delim(con, h=FALSE, stringsAsFactors=FALSE, sep="\t")
#     colnames(dtf) = c("chr", "start", "end", "rname", "score", "dir", "pval")
#     ans = with(dtf, GRanges(seqnames=chr, IRanges(start, end),
#            rname=rname, score=score, dir=dir, pval=pval))
#     ans
#     })
# GRangesList(unlist(tabs, recursive=FALSE))
#}
if (.Platform$OS.type != "windows") {
 rr = fimo_granges(fimo16[, c("POU2F1", "VDR")], myg)
 rr
}
```

```
## $POU2F1
## $POU2F1$`chr17:38070000-38090000`
## GRanges object with 76 ranges and 4 metadata columns:
##        seqnames            ranges strand |                  rname      score
##           <Rle>         <IRanges>  <Rle> |            <character>  <numeric>
##    [1]    chr17 38070239-38070257      * | chr17:38070239-38070.. -1.5408200
##    [2]    chr17 38070579-38070597      * | chr17:38070579-38070.. -0.9693880
##    [3]    chr17 38070851-38070869      * | chr17:38070851-38070..  0.1224490
##    [4]    chr17 38071025-38071043      * | chr17:38071025-38071..  0.0918367
##    [5]    chr17 38071253-38071271      * | chr17:38071253-38071..  3.6734700
##    ...      ...               ...    ... .                    ...        ...
##   [72]    chr17 38088602-38088620      * | chr17:38088602-38088..    4.06122
##   [73]    chr17 38088637-38088655      * | chr17:38088637-38088..   11.69390
##   [74]    chr17 38089141-38089159      * | chr17:38089141-38089..   13.18370
##   [75]    chr17 38089439-38089457      * | chr17:38089439-38089..   -1.35714
##   [76]    chr17 38089822-38089840      * | chr17:38089822-38089..    3.67347
##                dir      pval
##        <character> <numeric>
##    [1]           +  0.000989
##    [2]           -  0.000849
##    [3]           -  0.000631
##    [4]           -  0.000636
##    [5]           +  0.000222
##    ...         ...       ...
##   [72]           +  1.98e-04
##   [73]           -  1.32e-05
##   [74]           -  7.09e-06
##   [75]           -  9.42e-04
##   [76]           -  2.22e-04
##   -------
##   seqinfo: 1 sequence from hg19 genome
##
##
## $VDR
## $VDR$`chr17:38070000-38090000`
## GRanges object with 40 ranges and 4 metadata columns:
##        seqnames            ranges strand |                  rname      score
##           <Rle>         <IRanges>  <Rle> |            <character>  <numeric>
##    [1]    chr17 38070016-38070031      * | chr17:38070016-38070..  0.0505051
##    [2]    chr17 38070387-38070402      * | chr17:38070387-38070.. -3.3838400
##    [3]    chr17 38070925-38070940      * | chr17:38070925-38070..  5.7171700
##    [4]    chr17 38071183-38071198      * | chr17:38071183-38071.. -0.6767680
##    [5]    chr17 38072289-38072304      * | chr17:38072289-38072.. -0.3333330
##    ...      ...               ...    ... .                    ...        ...
##   [36]    chr17 38086915-38086930      * | chr17:38086915-38086..  -0.353535
##   [37]    chr17 38087304-38087319      * | chr17:38087304-38087..   0.101010
##   [38]    chr17 38087866-38087881      * | chr17:38087866-38087..   5.343430
##   [39]    chr17 38088893-38088908      * | chr17:38088893-38088..  -0.111111
##   [40]    chr17 38089214-38089229      * | chr17:38089214-38089..   1.101010
##                dir      pval
##        <character> <numeric>
##    [1]           +  3.77e-04
##    [2]           +  9.66e-04
##    [3]           -  6.44e-05
##    [4]           +  4.63e-04
##    [5]           -  4.21e-04
##    ...         ...       ...
##   [36]           -  0.000423
##   [37]           -  0.000371
##   [38]           +  0.000073
##   [39]           -  0.000395
##   [40]           -  0.000277
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] UpSetR_1.4.0                magrittr_2.0.4
##  [3] dplyr_1.1.4                 gwascat_2.42.0
##  [5] GSEABase_1.72.0             graph_1.88.0
##  [7] annotate_1.88.0             XML_3.99-0.19
##  [9] png_0.1-8                   ggplot2_4.0.0
## [11] knitr_1.50                  data.table_1.17.8
## [13] GO.db_3.22.0                GenomicFiles_1.46.0
## [15] SummarizedExperiment_1.40.0 rtracklayer_1.70.0
## [17] Rsamtools_2.26.0            Biostrings_2.78.0
## [19] XVector_0.50.0              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           GenomicRanges_1.62.0
## [23] Seqinfo_1.0.0               BiocParallel_1.44.0
## [25] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
## [27] IRanges_2.44.0              S4Vectors_0.48.0
## [29] Biobase_2.70.0              BiocGenerics_0.56.0
## [31] generics_0.1.4              TFutils_1.30.0
## [33] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
##  [4] httr2_1.2.1              readxl_1.4.5             rlang_1.1.6
##  [7] otel_0.2.0               compiler_4.5.1           RSQLite_2.4.3
## [10] GenomicFeatures_1.62.0   vctrs_0.6.5              pkgconfig_2.0.3
## [13] crayon_1.5.3             fastmap_1.2.0            dbplyr_2.5.1
## [16] labeling_0.4.3           promises_1.4.0           rmarkdown_2.30
## [19] UCSC.utils_1.6.0         bit_4.6.0                xfun_0.53
## [22] cachem_1.1.0             cigarillo_1.0.0          GenomeInfoDb_1.46.0
## [25] jsonlite_2.0.0           blob_1.2.4               later_1.4.4
## [28] DelayedArray_0.36.0      parallel_4.5.1           R6_2.6.1
## [31] VariantAnnotation_1.56.0 RColorBrewer_1.1-3       bslib_0.9.0
## [34] jquerylib_0.1.4          cellranger_1.1.0         bookdown_0.45
## [37] Rcpp_1.1.0               BiocBaseUtils_1.12.0     splines_4.5.1
## [40] httpuv_1.6.16            Matrix_1.7-4             tidyselect_1.2.1
## [43] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
## [46] codetools_0.2-20         miniUI_0.1.2             curl_7.0.0
## [49] plyr_1.8.9               lattice_0.22-7           tibble_3.3.0
## [52] withr_3.0.2              S7_0.2.0                 shiny_1.11.1
## [55] KEGGREST_1.50.0          evaluate_1.0.5           survival_3.8-3
## [58] BiocFileCache_3.0.0      snpStats_1.60.0          pillar_1.11.1
## [61] BiocManager_1.30.26      filelock_1.0.3           RCurl_1.98-1.17
## [64] scales_1.4.0             xtable_1.8-4             glue_1.8.0
## [67] tools_4.5.1              BiocIO_1.20.0            BSgenome_1.78.0
## [70] GenomicAlignments_1.46.0 restfulr_0.0.16          cli_3.6.5
## [73] rappdirs_0.3.3           S4Arrays_1.10.0          gtable_0.3.6
## [76] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
## [79] rjson_0.2.23             farver_2.1.2             memoise_2.0.1
## [82] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
## [85] mime_0.13                bit64_4.6.0-1
```