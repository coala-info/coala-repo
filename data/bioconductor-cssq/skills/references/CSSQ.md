# ChIP-seq signal quantifier (CSSQ)

# Introduction

This vignette introduces the package Bioconductor package *[CSSQ](https://bioconductor.org/packages/3.22/CSSQ)*. This package is designed to perform differential binding analysis for ChIP-seq samples. Differential binding is when there is a significant difference in the signal intensities at a region between two groups. The idea behind CSSQ is to implement a statistically robust pipeline which is built for ChIP-seq datasets to identify regions of differential binding among a set of interesting regions. It contains functions to quantify the signal over a predefined set of regions from the user, transform the data, normalize across samples and perform statistical tests to determine differential binding. There is an ever-increasing number of ChIP-seq samples, and this opens the door to compare these binding events between two groups of samples. CSSQ does this while considering the signal to noise ratios, paired control experiments and the lack of multiple (>2) replicates in a typical ChIP-seq experiment. It controls the false discovery rates while not compromising in its sensitivity. This document will give a brief overview of the processing steps.

# Processing summary

The workflow for `CSSQ` is as follows

1. Quantify regions of interest - A bed file with the regions of interest is used to count the number of reads aligning to these regions for the samples and their respective controls.
2. Data processing - The raw count data is used to perform background correction, data transformation and normalization across samples.
3. Identifying differential regions - The normalized count data is used to perform statistical tests to identify differentially bound regions.

# Example

To use `CSSQ`, you will require a bed file containing the regions of interest as well as sample information file which contains the necessary information about the samples being analyzed. Below are examples of both files.

```
library(CSSQ)
regionBed <- read.table(system.file("extdata", "chr19_regions.bed", package="CSSQ",mustWork = TRUE))
sampleInfo <- read.table(system.file("extdata", "sample_info.txt", package="CSSQ",mustWork = TRUE),sep="\t",header=TRUE)
head(regionBed)
```

```
##      V1      V2      V3              V4 V5 V6
## 1 chr19 1237177 1239177 ENSG00000267778  0  -
## 2 chr19 1240748 1242748 ENSG00000099624  0  -
## 3 chr19 1247551 1249551 ENSG00000167470  0  -
## 4 chr19 1258383 1260383 ENSG00000099622  0  -
## 5 chr19 1267164 1269164 ENSG00000267493  0  -
## 6 chr19 1274025 1276025 ENSG00000228300  0  -
```

```
sampleInfo
```

```
##   Sample.Name Group             IP IP_aligned_reads             IN
## 1     HESC_R1  HESC HESC_IP_R1.bam           282252 HESC_IN_R1.bam
## 2     HESC_R2  HESC HESC_IP_R2.bam           392885 HESC_IN_R2.bam
## 3     HSMM_R1  HSMM HSMM_IP_R1.bam           890043 HSMM_IN_R1.bam
## 4     HSMM_R2  HSMM HSMM_IP_R2.bam           354181 HSMM_IN_R2.bam
##   IN_aligned_reads
## 1           230532
## 2           133898
## 3           201461
## 4           245937
```

`CSSQ` provides two options for obtaining raw count data used to perform the analysis. The first option is to ask `CSSQ` to count the reads and perform background correction. The following commands will perform the steps and return an object with count data and meta data.

```
countData <- getRegionCounts(system.file("extdata", "chr19_regions.bed", package="CSSQ"),sampleInfo,sampleDir = system.file("extdata", package="CSSQ"))
countData
```

```
## class: RangedSummarizedExperiment
## dim: 15 4
## metadata(0):
## assays(1): countData
## rownames(15): 1 2 ... 14 15
## rowData names(2): name score
## colnames(4): HESC_R1 HESC_R2 HSMM_R1 HSMM_R2
## colData names(6): Sample.Name Group ... IN IN_aligned_reads
```

```
head(assays(countData)$countData)
```

```
##     HESC_R1   HESC_R2   HSMM_R1   HSMM_R2
## 1 183.73330 136.07168 300.53868 191.53539
## 2 153.43662 209.88463 699.94899 419.66551
## 3 164.86028 249.60431 451.93156 404.76261
## 4  52.28127  30.87819 -65.09899  12.30791
## 5  88.50546  84.66385  25.06950  83.34102
## 6 158.56927 285.23815 258.11210 328.53040
```

```
colData(countData)
```

```
## DataFrame with 4 rows and 6 columns
##         Sample.Name       Group                     IP IP_aligned_reads
##         <character> <character>            <character>        <integer>
## HESC_R1     HESC_R1        HESC /tmp/Rtmp66kgkr/Rins..           282252
## HESC_R2     HESC_R2        HESC /tmp/Rtmp66kgkr/Rins..           392885
## HSMM_R1     HSMM_R1        HSMM /tmp/Rtmp66kgkr/Rins..           890043
## HSMM_R2     HSMM_R2        HSMM /tmp/Rtmp66kgkr/Rins..           354181
##                             IN IN_aligned_reads
##                    <character>        <integer>
## HESC_R1 /tmp/Rtmp66kgkr/Rins..           230532
## HESC_R2 /tmp/Rtmp66kgkr/Rins..           133898
## HSMM_R1 /tmp/Rtmp66kgkr/Rins..           201461
## HSMM_R2 /tmp/Rtmp66kgkr/Rins..           245937
```

```
rowRanges(countData)
```

```
## GRanges object with 15 ranges and 2 metadata columns:
##      seqnames          ranges strand |            name     score
##         <Rle>       <IRanges>  <Rle> |     <character> <numeric>
##    1    chr19 1237178-1239177      - | ENSG00000267778         0
##    2    chr19 1240749-1242748      - | ENSG00000099624         0
##    3    chr19 1247552-1249551      - | ENSG00000167470         0
##    4    chr19 1258384-1260383      - | ENSG00000099622         0
##    5    chr19 1267165-1269164      - | ENSG00000267493         0
##   ..      ...             ...    ... .             ...       ...
##   11    chr19 1375772-1377771      - | ENSG00000267755         0
##   12    chr19 1382526-1384525      - | ENSG00000115286         0
##   13    chr19 1391169-1393168      - | ENSG00000248015         0
##   14    chr19 1396091-1398090      - | ENSG00000130005         0
##   15    chr19 1406568-1408567      - | ENSG00000071626         0
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The second option is to provide `CSSQ` with the count data in a tab separated format. The count data given will directly be used in transformation and normalization steps and no background correction will be performed.

```
countData <- loadCountData(system.file("extdata", "sample_count_data.txt", package="CSSQ",mustWork = TRUE),system.file("extdata", "chr19_regions.bed", package="CSSQ"),sampleInfo)
countData
```

```
## class: RangedSummarizedExperiment
## dim: 15 4
## metadata(0):
## assays(1): countData
## rownames(15): 1 2 ... 14 15
## rowData names(2): name score
## colnames(4): HESC_R1 HESC_R2 HSMM_R1 HSMM_R2
## colData names(6): Sample.Name Group ... IN IN_aligned_reads
```

```
head(assays(countData)$countData)
```

```
##     HESC_R1   HESC_R2   HSMM_R1   HSMM_R2
## 1 183.73330 136.07168 300.53868 191.53539
## 2 153.43662 209.88463 699.94899 419.66551
## 3 164.86028 249.60431 451.93156 404.76261
## 4  52.28127  30.87819 -65.09899  12.30791
## 5  88.50546  84.66385  25.06950  83.34102
## 6 158.56927 285.23815 258.11210 328.53040
```

```
colData(countData)
```

```
## DataFrame with 4 rows and 6 columns
##         Sample.Name       Group             IP IP_aligned_reads             IN
##         <character> <character>    <character>        <integer>    <character>
## HESC_R1     HESC_R1        HESC HESC_IP_R1.bam           282252 HESC_IN_R1.bam
## HESC_R2     HESC_R2        HESC HESC_IP_R2.bam           392885 HESC_IN_R2.bam
## HSMM_R1     HSMM_R1        HSMM HSMM_IP_R1.bam           890043 HSMM_IN_R1.bam
## HSMM_R2     HSMM_R2        HSMM HSMM_IP_R2.bam           354181 HSMM_IN_R2.bam
##         IN_aligned_reads
##                <integer>
## HESC_R1           230532
## HESC_R2           133898
## HSMM_R1           201461
## HSMM_R2           245937
```

```
rowRanges(countData)
```

```
## GRanges object with 15 ranges and 2 metadata columns:
##      seqnames          ranges strand |            name     score
##         <Rle>       <IRanges>  <Rle> |     <character> <numeric>
##    1    chr19 1237178-1239177      - | ENSG00000267778         0
##    2    chr19 1240749-1242748      - | ENSG00000099624         0
##    3    chr19 1247552-1249551      - | ENSG00000167470         0
##    4    chr19 1258384-1260383      - | ENSG00000099622         0
##    5    chr19 1267165-1269164      - | ENSG00000267493         0
##   ..      ...             ...    ... .             ...       ...
##   11    chr19 1375772-1377771      - | ENSG00000267755         0
##   12    chr19 1382526-1384525      - | ENSG00000115286         0
##   13    chr19 1391169-1393168      - | ENSG00000248015         0
##   14    chr19 1396091-1398090      - | ENSG00000130005         0
##   15    chr19 1406568-1408567      - | ENSG00000071626         0
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Anscombe transformation is then applied to the count data using the `ansTransform` function. This function also has an option parameter to plot the data distribution of the data before and after transformation.

```
ansCountData <- ansTransform(countData)
ansCountData
```

```
## class: RangedSummarizedExperiment
## dim: 12 4
## metadata(0):
## assays(1): ansCount
## rownames(12): 1 2 ... 12 15
## rowData names(2): name score
## colnames(4): HESC_R1 HESC_R2 HSMM_R1 HSMM_R2
## colData names(6): Sample.Name Group ... IN IN_aligned_reads
```

```
head(assays(ansCountData)$ansCount)
```

```
##    HESC_R1  HESC_R2   HSMM_R1   HSMM_R2
## 1 27.13730 23.36208 34.693727 27.706345
## 2 24.80416 29.00066 52.927270 40.989780
## 3 25.70877 31.62147 42.535000 40.256061
## 4 14.51293 11.18091  1.224745  7.122613
## 5 18.85529 18.44330 10.088507 18.299292
## 6 25.21462 33.80019 32.155068 36.271499
```

Anscombe transformed data is then normalized across samples. Normalization in `CSSQ` using the `normalizeData` function. It takes as input the number of clusters to use in the underlying k-means algorithm that is used in the normalization process. It is advised to choose the number of clusters by analyzing the data distribution.

```
normInfo <- normalizeData(ansCountData,numClusters=4)
normInfo
```

```
## class: RangedSummarizedExperiment
## dim: 12 4
## metadata(0):
## assays(3): normCount clusterData varData
## rownames(12): 1 2 ... 12 15
## rowData names(2): name score
## colnames(4): HESC_R1 HESC_R2 HSMM_R1 HSMM_R2
## colData names(6): Sample.Name Group ... IN IN_aligned_reads
```

```
head(assays(normInfo)$normCount)
```

```
##     HESC_R1   HESC_R2    HSMM_R1   HSMM_R2
## 1 0.4589073 0.5021629 0.54439640 0.4733239
## 2 0.4194525 0.6233630 0.83050792 0.7002526
## 3 0.4347500 0.6796967 0.66743768 0.6877181
## 4 0.2454219 0.2403313 0.01921808 0.1216798
## 5 0.3188537 0.3964348 0.15830375 0.3126176
## 6 0.4263936 0.7265277 0.50456105 0.6196474
```

The normalized data is then used by the `DBAnalyze` function to perform statistical tests to identify differentially bound regions. `CSSQ` utilized non-parametric approaches to calculate the test statistics and to calculate the p-value from the test statistics. This is done due to prevalent trend observed in ChIP-seq datasets of not having more than two replicates. The resulting `GRanges` object from this function contains the Benjamini Hochberg adjusted P-value and a Fold change for each of the input regions.

```
result <- DBAnalyze(normInfo,comparison=c("HSMM","HESC"))
result
```

```
## GRanges object with 12 ranges and 4 metadata columns:
##      seqnames          ranges strand |            name     score  adj.pval
##         <Rle>       <IRanges>  <Rle> |     <character> <numeric> <numeric>
##    1    chr19 1237178-1239177      - | ENSG00000267778         0  0.958333
##    2    chr19 1240749-1242748      - | ENSG00000099624         0  0.000000
##    3    chr19 1247552-1249551      - | ENSG00000167470         0  0.250000
##    4    chr19 1258384-1260383      - | ENSG00000099622         0  0.250000
##    5    chr19 1267165-1269164      - | ENSG00000267493         0  0.428571
##   ..      ...             ...    ... .             ...       ...       ...
##    8    chr19 1285153-1287152      - | ENSG00000099617         0  0.000000
##   10    chr19 1320224-1322223      - | ENSG00000267372         0  0.833333
##   11    chr19 1375772-1377771      - | ENSG00000267755         0  0.625000
##   12    chr19 1382526-1384525      - | ENSG00000115286         0  0.958333
##   15    chr19 1406568-1408567      - | ENSG00000071626         0  0.250000
##             FC
##      <numeric>
##    1   1.05894
##    2   1.46791
##    3   1.21599
##    4  -3.44755
##    5  -1.51891
##   ..       ...
##    8  -2.86082
##   10  -3.57866
##   11  -4.41708
##   12   1.04604
##   15   1.24902
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

For convenience, most of the above steps are wrapped in `preprocessData` function to perform them all at one go. All the above steps can be performed using the below commands.

```
#To let CSSQ calculate the counts
processedData <- preprocessData(system.file("extdata", "chr19_regions.bed", package="CSSQ"),system.file("extdata", "sample_info.txt", package="CSSQ"),sampleDir = system.file("extdata", package="CSSQ"),numClusters=4,noNeg=TRUE,plotData=FALSE)
#To provide CSSQ with the counts
processedData <- preprocessData(system.file("extdata", "chr19_regions.bed", package="CSSQ"),system.file("extdata", "sample_info.txt", package="CSSQ"),inputCountData = system.file("extdata", "sample_count_data.txt", package="CSSQ",mustWork = TRUE),numClusters=4,noNeg=TRUE,plotData=FALSE)
#To find differential binding sites
result <- DBAnalyze(processedData,comparison=c("HSMM","HESC"))
processedData
```

```
## class: RangedSummarizedExperiment
## dim: 12 4
## metadata(0):
## assays(3): normCount clusterData varData
## rownames(12): 1 2 ... 12 15
## rowData names(2): name score
## colnames(4): HESC_R1 HESC_R2 HSMM_R1 HSMM_R2
## colData names(6): Sample.Name Group ... IN IN_aligned_reads
```

```
result
```

```
## GRanges object with 12 ranges and 4 metadata columns:
##      seqnames          ranges strand |            name     score  adj.pval
##         <Rle>       <IRanges>  <Rle> |     <character> <numeric> <numeric>
##    1    chr19 1237178-1239177      - | ENSG00000267778         0  0.958333
##    2    chr19 1240749-1242748      - | ENSG00000099624         0  0.000000
##    3    chr19 1247552-1249551      - | ENSG00000167470         0  0.250000
##    4    chr19 1258384-1260383      - | ENSG00000099622         0  0.250000
##    5    chr19 1267165-1269164      - | ENSG00000267493         0  0.428571
##   ..      ...             ...    ... .             ...       ...       ...
##    8    chr19 1285153-1287152      - | ENSG00000099617         0  0.000000
##   10    chr19 1320224-1322223      - | ENSG00000267372         0  0.833333
##   11    chr19 1375772-1377771      - | ENSG00000267755         0  0.625000
##   12    chr19 1382526-1384525      - | ENSG00000115286         0  0.958333
##   15    chr19 1406568-1408567      - | ENSG00000071626         0  0.250000
##             FC
##      <numeric>
##    1   1.05894
##    2   1.46791
##    3   1.21599
##    4  -3.44755
##    5  -1.51891
##   ..       ...
##    8  -2.86082
##   10  -3.57866
##   11  -4.41708
##   12   1.04604
##   15   1.24902
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# Session Info

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
##  [1] CSSQ_1.22.0                 rtracklayer_1.70.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          gtable_0.3.6             rjson_0.2.23
##  [4] xfun_0.53                ggplot2_4.0.0            lattice_0.22-7
##  [7] vctrs_0.6.5              tools_4.5.1              bitops_1.0-9
## [10] curl_7.0.0               parallel_4.5.1           tibble_3.3.0
## [13] AnnotationDbi_1.72.0     RSQLite_2.4.3            blob_1.2.4
## [16] pkgconfig_2.0.3          Matrix_1.7-4             RColorBrewer_1.1-3
## [19] S7_0.2.0                 cigarillo_1.0.0          lifecycle_1.0.4
## [22] compiler_4.5.1           farver_2.1.2             Rsamtools_2.26.0
## [25] Biostrings_2.78.0        codetools_0.2-20         htmltools_0.5.8.1
## [28] RCurl_1.98-1.17          yaml_2.3.10              pillar_1.11.1
## [31] crayon_1.5.3             BiocParallel_1.44.0      DelayedArray_0.36.0
## [34] cachem_1.1.0             abind_1.4-8              tidyselect_1.2.1
## [37] digest_0.6.37            dplyr_1.1.4              restfulr_0.0.16
## [40] fastmap_1.2.0            grid_4.5.1               cli_3.6.5
## [43] SparseArray_1.10.0       magrittr_2.0.4           S4Arrays_1.10.0
## [46] GenomicFeatures_1.62.0   dichromat_2.0-0.1        XML_3.99-0.19
## [49] scales_1.4.0             bit64_4.6.0-1            rmarkdown_2.30
## [52] XVector_0.50.0           httr_1.4.7               bit_4.6.0
## [55] png_0.1-8                memoise_2.0.1            evaluate_1.0.5
## [58] BiocIO_1.20.0            rlang_1.1.6              glue_1.8.0
## [61] DBI_1.2.3                BiocManager_1.30.26      R6_2.6.1
## [64] GenomicAlignments_1.46.0
```