# CITEseq Cord Blood

Dario Righelli

#### 04 November, 2025

#### Package

SingleCellMultiModal 1.22.0

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SingleCellMultiModal")
```

# 2 Load libraries

```
library(MultiAssayExperiment)
library(SingleCellMultiModal)
library(SingleCellExperiment)
```

# 3 CITE-seq dataset

CITE-seq data are a combination of two data types extracted at the same
time from the same cell. First data type is scRNA-seq data, while the second
one consists of about a hundread of antibody-derived tags (ADT).
In particular this dataset is provided by Stoeckius et al. ([2017](#ref-stoeckius2017simultaneous)).

## 3.1 Downloading datasets

The user can see the available dataset by using the default options

```
CITEseq(DataType="cord_blood", modes="*", dry.run=TRUE, version="1.0.0")
```

```
## Dataset: cord_blood
```

```
##    ah_id             mode file_size rdataclass rdatadateadded rdatadateremoved
## 1 EH3795     scADT_Counts    0.2 Mb     matrix     2020-09-23             <NA>
## 2 EH3796  scRNAseq_Counts   22.2 Mb     matrix     2020-09-23             <NA>
## 3 EH8228 coldata_scRNAseq    0.1 Mb data.frame     2023-05-17             <NA>
## 4 EH8305  scADT_clrCounts    0.8 Mb     matrix     2023-07-05             <NA>
```

Or simply by setting `dry.run = FALSE` it downloads the data and creates the
`MultiAssayExperiment` object.

In this example, we will use one of the two available datasets `scADT_Counts`:

```
mae <- CITEseq(
    DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0"
)
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
mae
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] scADT: matrix with 13 rows and 7858 columns
##  [2] scADT_clr: matrix with 13 rows and 7858 columns
##  [3] scRNAseq: matrix with 36280 rows and 7858 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Example with actual data:

```
experiments(mae)
```

```
## ExperimentList class object of length 3:
##  [1] scADT: matrix with 13 rows and 7858 columns
##  [2] scADT_clr: matrix with 13 rows and 7858 columns
##  [3] scRNAseq: matrix with 36280 rows and 7858 columns
```

## 3.2 Exploring the data structure

Check row annotations:

```
rownames(mae)
```

```
## CharacterList of length 3
## [["scADT"]] CD3 CD4 CD8 CD45RA CD56 CD16 CD10 CD11c CD14 CD19 CD34 CCR5 CCR7
## [["scADT_clr"]] CD3 CD4 CD8 CD45RA CD56 CD16 CD10 CD11c CD14 CD19 CD34 CCR5 CCR7
## [["scRNAseq"]] ERCC_ERCC-00104 HUMAN_A1BG ... MOUSE_n-R5s25 MOUSE_n-R5s31
```

Take a peek at the `sampleMap`:

```
sampleMap(mae)
```

```
## DataFrame with 23574 rows and 3 columns
##          assay          primary          colname
##       <factor>      <character>      <character>
## 1        scADT TACAGTGTCTCGGACG TACAGTGTCTCGGACG
## 2        scADT GTTTCTACATCATCCC GTTTCTACATCATCCC
## 3        scADT GTACGTATCCCATTTA GTACGTATCCCATTTA
## 4        scADT ATGTGTGGTCGCCATG ATGTGTGGTCGCCATG
## 5        scADT AACGTTGTCAGTTAGC AACGTTGTCAGTTAGC
## ...        ...              ...              ...
## 23570 scRNAseq AGCGTCGAGTCAAGGC AGCGTCGAGTCAAGGC
## 23571 scRNAseq GTCGGGTAGTAGCCGA GTCGGGTAGTAGCCGA
## 23572 scRNAseq GTCGGGTAGTTCGCAT GTCGGGTAGTTCGCAT
## 23573 scRNAseq TTGCCGTGTAGATTAG TTGCCGTGTAGATTAG
## 23574 scRNAseq GGCGTGTAGTGTACTC GGCGTGTAGTGTACTC
```

## 3.3 scRNA-seq data

The scRNA-seq data are accessible with the name `scRNAseq`, which returns a
*matrix* object.

```
head(experiments(mae)$scRNAseq)[, 1:4]
```

```
##                 TACAGTGTCTCGGACG GTTTCTACATCATCCC GTACGTATCCCATTTA
## ERCC_ERCC-00104                0                0                0
## HUMAN_A1BG                     0                0                0
## HUMAN_A1BG-AS1                 0                0                0
## HUMAN_A1CF                     0                0                0
## HUMAN_A2M                      0                0                0
## HUMAN_A2M-AS1                  0                0                0
##                 ATGTGTGGTCGCCATG
## ERCC_ERCC-00104                0
## HUMAN_A1BG                     0
## HUMAN_A1BG-AS1                 0
## HUMAN_A1CF                     0
## HUMAN_A2M                      0
## HUMAN_A2M-AS1                  0
```

## 3.4 scADT data

The scADT data are accessible with the name `scADT`, which returns a
**matrix** object.

```
head(experiments(mae)$scADT)[, 1:4]
```

```
##        TACAGTGTCTCGGACG GTTTCTACATCATCCC GTACGTATCCCATTTA ATGTGTGGTCGCCATG
## CD3                  36               34               49               35
## CD4                  28               21               38               29
## CD8                  34               41               52               47
## CD45RA              228              228              300              303
## CD56                 26               18               48               36
## CD16                 44               38               51               59
```

# 4 SingleCellExperiment object conversion

Because of already large use of some methodologies (such as
in the [SingleCellExperiment vignette](https://www.bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html#5_adding_alternative_feature_sets) or [CiteFuse Vignette](http://www.bioconductor.org/packages/release/bioc/vignettes/CiteFuse/inst/doc/CiteFuse.html) where the
`SingleCellExperiment` object is used for CITE-seq data,
we provide a function for the conversion of our CITE-seq `MultiAssayExperiment`
object into a `SingleCellExperiment` object with scRNA-seq data as counts and
scADT data as `altExp`s.

```
sce <- CITEseq(DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0",
              DataClass="SingleCellExperiment")
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 36280 7858
## metadata(0):
## assays(1): counts
## rownames(36280): ERCC_ERCC-00104 HUMAN_A1BG ... MOUSE_n-R5s25
##   MOUSE_n-R5s31
## rowData names(0):
## colnames(7858): TACAGTGTCTCGGACG GTTTCTACATCATCCC ... TTGCCGTGTAGATTAG
##   GGCGTGTAGTGTACTC
## colData names(6): adt.discard mito.discard ... celltype markers
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(1): scADT
```

# 5 Session Info

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
##  [1] SingleCellExperiment_1.32.0 SingleCellMultiModal_1.22.0
##  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.54
##  [4] bslib_0.9.0              httr2_1.2.1              lattice_0.22-7
##  [7] vctrs_0.6.5              tools_4.5.1              curl_7.0.0
## [10] tibble_3.3.0             AnnotationDbi_1.72.0     RSQLite_2.4.3
## [13] blob_1.2.4               pkgconfig_2.0.3          BiocBaseUtils_1.12.0
## [16] Matrix_1.7-4             dbplyr_2.5.1             lifecycle_1.0.4
## [19] compiler_4.5.1           Biostrings_2.78.0        htmltools_0.5.8.1
## [22] sass_0.4.10              yaml_2.3.10              pillar_1.11.1
## [25] crayon_1.5.3             jquerylib_0.1.4          DelayedArray_0.36.0
## [28] cachem_1.1.0             magick_2.9.0             abind_1.4-8
## [31] ExperimentHub_3.0.0      AnnotationHub_4.0.0      tidyselect_1.2.1
## [34] digest_0.6.37            purrr_1.1.0              dplyr_1.1.4
## [37] bookdown_0.45            BiocVersion_3.22.0       fastmap_1.2.0
## [40] grid_4.5.1               cli_3.6.5                SparseArray_1.10.1
## [43] magrittr_2.0.4           S4Arrays_1.10.0          withr_3.0.2
## [46] filelock_1.0.3           rappdirs_0.3.3           bit64_4.6.0-1
## [49] rmarkdown_2.30           XVector_0.50.0           httr_1.4.7
## [52] bit_4.6.0                png_0.1-8                SpatialExperiment_1.20.0
## [55] memoise_2.0.1            evaluate_1.0.5           knitr_1.50
## [58] BiocFileCache_3.0.0      rlang_1.1.6              Rcpp_1.1.0
## [61] glue_1.8.0               DBI_1.2.3                formatR_1.14
## [64] BiocManager_1.30.26      jsonlite_2.0.0           R6_2.6.1
```

# References

Stoeckius, Marlon, Christoph Hafemeister, William Stephenson, Brian Houck-Loomis, Pratip K Chattopadhyay, Harold Swerdlow, Rahul Satija, and Peter Smibert. 2017. “Simultaneous Epitope and Transcriptome Measurement in Single Cells.” *Nature Methods* 14 (9): 865.