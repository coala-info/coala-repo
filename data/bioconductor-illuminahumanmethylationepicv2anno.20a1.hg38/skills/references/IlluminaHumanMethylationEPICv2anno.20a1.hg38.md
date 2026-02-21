# Use of IlluminaHumanMethylationEPICv2anno.20a1.hg38

#### Zuguang Gu (z.gu@dkfz.de)

#### 2024-03-26

This package provides annotations for Illumina methylation EPIC array v2.0. The data is based on the file <https://support.illumina.com/content/dam/illumina-support/documents/downloads/productfiles/methylationepic/MethylationEPIC%20v2%20Files.zip> from <https://support.illumina.com/array/array_kits/infinium-methylationepic-beadchip-kit/downloads.html>.

When using with the **minfi** package, you can manually set the “annotation” element by providing the suffix (removing the string “IlluminaHumanMethylationEPICv2anno.”):

```
RGset = read.metharray.exp(...)

# explained in the IlluminaHumanMethylationEPICv2manifest package
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"

annotation(RGset)["annotation"] = "20a1.hg38"
```

## Compare EPIC array v1 and v2 probes

We compare CpG annotation in the package **IlluminaHumanMethylationEPICv2anno.20a1.hg38** and the package **IlluminaHumanMethylationEPICanno.ilm10b4.hg19**.

```
library(IlluminaHumanMethylationEPICv2anno.20a1.hg38)
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)

cgi1 = IlluminaHumanMethylationEPICanno.ilm10b4.hg19::Islands.UCSC
cgi2 = IlluminaHumanMethylationEPICv2anno.20a1.hg38::Islands.UCSC
```

Following code shows the number of probes in each CpG feature. Note in **IlluminaHumanMethylationEPICanno.ilm10b4.hg19**, CGI shores and shelves are additionally classified as “N\_Shore”/“S\_Shore” and “N\_Shelf”/“S\_Shelf”, while they are simply “Shore” and “Shelf” in **IlluminaHumanMethylationEPICv2anno.20a1.hg38**.

```
t1 = table(gsub("(N|S)_", "", cgi1$Relation_to_Island))
t1
```

```
##
##  Island OpenSea   Shelf   Shore
##  161441  488181   61691  154546
```

```
t2 = table(cgi2$Relation_to_Island)
t2
```

```
##
##  Island OpenSea   Shelf   Shore
##  150679  560737   60836  157823
```

```
t2 - t1
```

```
##
##  Island OpenSea   Shelf   Shore
##  -10762   72556    -855    3277
```

```
(t2 - t1)/t1
```

```
##
##      Island     OpenSea       Shelf       Shore
## -0.06666212  0.14862520 -0.01385940  0.02120404
```

We can see there are more new probes in the CpG seas.

## Probe IDs are coded differently in EPIC v1 and EPIC v2 packages

In **IlluminaHumanMethylationEPICanno.ilm10b4.hg19** and other related EPIC-v1 packages, probe IDs (e.g. in the format of “cg18478105”) are unique in the array. But in the packages related to EPIC-v2, probe IDs may be duplicated. Thus, we use the “illumina\_ID” (column “IlmnID” in the manifest file, <https://knowledge.illumina.com/microarray/general/microarray-general-reference_material-list/000001568>) as the ID type for probes in v2-packages. The duplicated probes have the same probe sequence, but locate randomly on the array. The illumina ID is a combination of probe ID and a “duplication ID”.

Let’s take `cgi1` and `cgi2` as an example:

```
dim(cgi1)
```

```
## [1] 865859      2
```

```
head(cgi1)
```

```
## DataFrame with 6 rows and 2 columns
##                      Islands_Name Relation_to_Island
##                       <character>        <character>
## cg18478105 chr20:61846843-61848..             Island
## cg09835024 chrX:24072558-24073135             Island
## cg14361672 chr9:131464843-13146..            N_Shore
## cg01763666                                   OpenSea
## cg12950382                                   OpenSea
## cg02115394 chr13:115000148-1150..             Island
```

```
dim(cgi2)
```

```
## [1] 930075      2
```

```
head(cgi2)
```

```
## DataFrame with 6 rows and 2 columns
##                           Islands_Name Relation_to_Island
##                            <character>        <character>
## cg25324105_BC11 chr19:37691892-37692..             Island
## cg25383568_TC11 chr19:38726890-38727..             Island
## cg25455143_BC11 chr19:1591428-159162..             Island
## cg25459778_BC11  chr16:1610053-1615094             Island
## cg25487775_BC11 chr2:161237949-16123..              Shore
## cg25595446_BC11 chr19:49676753-49677..             Island
```

```
any(duplicated(rownames(cgi1)))
```

```
## [1] FALSE
```

Let’s check how many probes have duplicated probe IDs. First remove the suffix to only keep the probe IDs.

```
illumina_ID = rownames(cgi2)
probe_ID = gsub("_.*$", "", illumina_ID)
```

Check the duplication of probe IDs:

```
tb = table(probe_ID)
table(tb)
```

```
## tb
##      1      2      3      4      5      6     10
## 918546   4174    942     23     47      3      1
```

We can see in the most extreme case, a probe ID is repeated 10 times in the array. Let’s check what it is:

```
tb[tb == 10]
```

```
## cg06373096
##         10
```

```
illumina_ID[probe_ID == "cg06373096"]
```

```
##  [1] "cg06373096_TC11"  "cg06373096_TC12"  "cg06373096_TC13"  "cg06373096_TC14"
##  [5] "cg06373096_TC15"  "cg06373096_TC16"  "cg06373096_TC17"  "cg06373096_TC18"
##  [9] "cg06373096_TC19"  "cg06373096_TC110"
```

But the locations of these 10 probes are the same:

```
cgi2[probe_ID == "cg06373096", ]
```

```
## DataFrame with 10 rows and 2 columns
##                            Islands_Name Relation_to_Island
##                             <character>        <character>
## cg06373096_TC11  chr19:12880876-12881..              Shore
## cg06373096_TC12  chr19:12880876-12881..              Shore
## cg06373096_TC13  chr19:12880876-12881..              Shore
## cg06373096_TC14  chr19:12880876-12881..              Shore
## cg06373096_TC15  chr19:12880876-12881..              Shore
## cg06373096_TC16  chr19:12880876-12881..              Shore
## cg06373096_TC17  chr19:12880876-12881..              Shore
## cg06373096_TC18  chr19:12880876-12881..              Shore
## cg06373096_TC19  chr19:12880876-12881..              Shore
## cg06373096_TC110 chr19:12880876-12881..              Shore
```

## Change illumina IDs to probe IDs

If you think illumina IDs as “probe IDs” as in the v1 packages, you can basically do all the same analyses without worrying aboutn the format of the probe IDs. But if you really need the original probe IDs, you can use the `aggregate_to_probes()` function. It works for both annotation data frames in **IlluminaHumanMethylationEPICv2anno.20a1.hg38** and the beta matrix normalized by the **minfi** package.

The following example reads raw data from one sample and performs preprocessing with **minfi**. `aggregate_to_probes()` calculates mean value for duplicated probes.

```
tempdir = tempdir()
datadir = paste0(tempdir, "/206891110001")
dir.create(datadir, showWarnings = FALSE)

url = "https://github.com/jokergoo/IlluminaHumanMethylationEPICv2manifest/files/11008723/206891110001_R01C01.zip"
local = paste0(tempdir, "/206891110001_R01C01.zip")
download.file(url, dest = local, quiet = TRUE)

unzip(local, exdir = datadir)

library(minfi)
RGset = read.metharray.exp(datadir)
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
obj = preprocessRaw(RGset)
# there can be more intermediate steps ...
beta = getBeta(obj)
dim(beta)
```

```
## [1] 936990      1
```

```
head(beta)
```

```
##                 206891110001_R01C01
## cg25324105_BC11          0.86065794
## cg25383568_TC11          0.93799357
## cg25455143_BC11          0.02141582
## cg25459778_BC11          0.01751512
## cg25487775_BC11          0.94253932
## cg25595446_BC11          0.02561140
```

```
beta2 = aggregate_to_probes(beta)
dim(beta2)
```

```
## [1] 930596      1
```

```
head(beta2)
```

```
##            206891110001_R01C01
## cg25324105          0.86065794
## cg25383568          0.93799357
## cg25455143          0.02141582
## cg25459778          0.01751512
## cg25487775          0.94253932
## cg25595446          0.02561140
```

`aggregate_to_probes()` can also be applied to the annotation data frames in **IlluminaHumanMethylationEPICv2anno.20a1.hg38**.

```
head(aggregate_to_probes(cgi2))
```

```
## DataFrame with 6 rows and 2 columns
##                      Islands_Name Relation_to_Island
##                       <character>        <character>
## cg25324105 chr19:37691892-37692..             Island
## cg25383568 chr19:38726890-38727..             Island
## cg25455143 chr19:1591428-159162..             Island
## cg25459778  chr16:1610053-1615094             Island
## cg25487775 chr2:161237949-16123..              Shore
## cg25595446 chr19:49676753-49677..             Island
```

## Session info

```
## R Under development (unstable) (2023-10-25 r85412)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/lorikern/R-Installs/bin/R-devel/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] IlluminaHumanMethylationEPICv2manifest_0.99.2
##  [2] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
##  [3] IlluminaHumanMethylationEPICv2anno.20a1.hg38_1.0.0
##  [4] minfi_1.49.1
##  [5] bumphunter_1.45.1
##  [6] locfit_1.5-9.9
##  [7] iterators_1.0.14
##  [8] foreach_1.5.2
##  [9] Biostrings_2.71.5
## [10] XVector_0.43.1
## [11] SummarizedExperiment_1.33.3
## [12] Biobase_2.63.0
## [13] MatrixGenerics_1.15.0
## [14] matrixStats_1.2.0
## [15] GenomicRanges_1.55.4
## [16] GenomeInfoDb_1.39.9
## [17] IRanges_2.37.1
## [18] S4Vectors_0.41.5
## [19] BiocGenerics_0.49.1
## [20] knitr_1.45
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_1.8.8
##   [3] magrittr_2.0.3            GenomicFeatures_1.55.4
##   [5] rmarkdown_2.26            BiocIO_1.13.0
##   [7] zlibbioc_1.49.3           vctrs_0.6.5
##   [9] multtest_2.59.0           memoise_2.0.1
##  [11] Rsamtools_2.19.4          DelayedMatrixStats_1.25.1
##  [13] RCurl_1.98-1.14           askpass_1.2.0
##  [15] htmltools_0.5.7           S4Arrays_1.3.6
##  [17] progress_1.2.3            curl_5.2.1
##  [19] Rhdf5lib_1.25.1           SparseArray_1.3.4
##  [21] rhdf5_2.47.6              sass_0.4.9
##  [23] nor1mix_1.3-2             bslib_0.6.2
##  [25] plyr_1.8.9                httr2_1.0.0
##  [27] cachem_1.0.8              GenomicAlignments_1.39.4
##  [29] lifecycle_1.0.4           pkgconfig_2.0.3
##  [31] Matrix_1.6-5              R6_2.5.1
##  [33] fastmap_1.1.1             GenomeInfoDbData_1.2.11
##  [35] digest_0.6.35             siggenes_1.77.0
##  [37] reshape_0.8.9             AnnotationDbi_1.65.2
##  [39] RSQLite_2.3.5             base64_2.0.1
##  [41] filelock_1.0.3            fansi_1.0.6
##  [43] httr_1.4.7                abind_1.4-5
##  [45] compiler_4.4.0            beanplot_1.3.1
##  [47] rngtools_1.5.2            bit64_4.0.5
##  [49] BiocParallel_1.37.1       DBI_1.2.2
##  [51] HDF5Array_1.31.6          biomaRt_2.59.1
##  [53] MASS_7.3-60.2             openssl_2.1.1
##  [55] rappdirs_0.3.3            DelayedArray_0.29.9
##  [57] rjson_0.2.21              tools_4.4.0
##  [59] glue_1.7.0                quadprog_1.5-8
##  [61] restfulr_0.0.15           nlme_3.1-164
##  [63] rhdf5filters_1.15.4       grid_4.4.0
##  [65] generics_0.1.3            tzdb_0.4.0
##  [67] preprocessCore_1.65.0     tidyr_1.3.1
##  [69] data.table_1.15.2         hms_1.1.3
##  [71] xml2_1.3.6                utf8_1.2.4
##  [73] pillar_1.9.0              stringr_1.5.1
##  [75] limma_3.59.6              genefilter_1.85.1
##  [77] splines_4.4.0             dplyr_1.1.4
##  [79] BiocFileCache_2.11.1      lattice_0.22-6
##  [81] survival_3.5-8            rtracklayer_1.63.1
##  [83] bit_4.0.5                 GEOquery_2.71.0
##  [85] annotate_1.81.2           tidyselect_1.2.1
##  [87] xfun_0.42                 scrime_1.3.5
##  [89] statmod_1.5.0             stringi_1.8.3
##  [91] yaml_2.3.8                evaluate_0.23
##  [93] codetools_0.2-19          tibble_3.2.1
##  [95] cli_3.6.2                 xtable_1.8-4
##  [97] jquerylib_0.1.4           Rcpp_1.0.12
##  [99] dbplyr_2.5.0              png_0.1-8
## [101] XML_3.99-0.16.1           readr_2.1.5
## [103] blob_1.2.4                prettyunits_1.2.0
## [105] mclust_6.1                doRNG_1.8.6
## [107] sparseMatrixStats_1.15.0  bitops_1.0-7
## [109] illuminaio_0.45.0         purrr_1.0.2
## [111] crayon_1.5.2              rlang_1.1.3
## [113] KEGGREST_1.43.0
```