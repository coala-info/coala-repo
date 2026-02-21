# G&T-seq Mouse Embryo (8-cell stage)

Ludwig Geistlinger

#### 4 November 2025

#### Package

SingleCellMultiModal 1.22.0

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SingleCellMultiModal")
```

## 1.1 Load

```
library(SingleCellMultiModal)
library(MultiAssayExperiment)
```

# 2 G&T-seq: parallel sequencing data of single-cell genomes and transcriptomes

G&T-seq is a combination of Picoplex amplified gDNA sequencing (genome) and
SMARTSeq2 amplified cDNA sequencing (transcriptome) of the same cell.
For more information, see Macaulay et al. ([2015](#ref-Macaulay2015)).

## 2.1 Downloading datasets

The user can see the available dataset by using the default options

```
GTseq("mouse_embryo_8_cell", mode = "*", dry.run = TRUE)
```

```
##    ah_id           mode file_size           rdataclass rdatadateadded
## 1 EH5431        genomic      0 Mb     RaggedExperiment     2021-03-24
## 2 EH5433 transcriptomic    2.3 Mb SingleCellExperiment     2021-03-24
##   rdatadateremoved
## 1             <NA>
## 2             <NA>
```

Or by simply running:

```
GTseq()
```

```
##    ah_id           mode file_size           rdataclass rdatadateadded
## 1 EH5431        genomic      0 Mb     RaggedExperiment     2021-03-24
## 2 EH5433 transcriptomic    2.3 Mb SingleCellExperiment     2021-03-24
##   rdatadateremoved
## 1             <NA>
## 2             <NA>
```

## 2.2 Obtaining the data

To obtain the actual datasets:

```
gts <- GTseq(dry.run = FALSE)
```

```
## Warning: sampleMap[['assay']] coerced with as.factor()
```

```
gts
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] genomic: RaggedExperiment with 2366 rows and 112 columns
##  [2] transcriptomic: SingleCellExperiment with 24029 rows and 112 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## 2.3 Exploring the data structure

Check available metadata for each of the 112 mouse embryo cells assayed by G&T-seq:

```
colData(gts)
```

```
## DataFrame with 112 rows and 3 columns
##         Characteristics.organism. Characteristics.sex.
##                       <character>          <character>
## cell1                Mus musculus               female
## cell2                Mus musculus               female
## cell3                Mus musculus                 male
## cell4                Mus musculus                 male
## cell5                Mus musculus               female
## ...                           ...                  ...
## cell108              Mus musculus               female
## cell109              Mus musculus                 male
## cell110              Mus musculus                 male
## cell111              Mus musculus               female
## cell112              Mus musculus               female
##         Characteristics.cell.type.
##                        <character>
## cell1       8_cell_stage_single_..
## cell2       8_cell_stage_single_..
## cell3       8_cell_stage_single_..
## cell4       8_cell_stage_single_..
## cell5       8_cell_stage_single_..
## ...                            ...
## cell108     8_cell_stage_single_..
## cell109     8_cell_stage_single_..
## cell110     8_cell_stage_single_..
## cell111     8_cell_stage_single_..
## cell112     8_cell_stage_single_..
```

Take a peek at the `sampleMap`:

```
sampleMap(gts)
```

```
## DataFrame with 224 rows and 3 columns
##              assay     primary     colname
##           <factor> <character> <character>
## 1   transcriptomic       cell1   ERR861694
## 2   transcriptomic       cell2   ERR861750
## 3   transcriptomic       cell3   ERR861695
## 4   transcriptomic       cell4   ERR861751
## 5   transcriptomic       cell5   ERR861696
## ...            ...         ...         ...
## 220        genomic     cell108   ERR863164
## 221        genomic     cell109   ERR863109
## 222        genomic     cell110   ERR863165
## 223        genomic     cell111   ERR863110
## 224        genomic     cell112   ERR863166
```

## 2.4 Copy numbers

To access the integer copy numbers as detected from scDNA-seq:

```
head(assay(gts, "genomic"))[, 1:4]
```

```
##                          ERR863111 ERR863834 ERR863112 ERR863835
## chr1:23000001-25500000          NA        NA        NA        NA
## chr4:112000001-114500000        NA        NA        NA        NA
## chr4:145000001-148500000        NA        NA        NA        NA
## chr5:14000001-16500000          NA        NA        NA        NA
## chr15:66500001-69000000         NA        NA        NA        NA
## chrX:21500001-36000000          NA        NA        NA        NA
```

## 2.5 RNA-seq

To access raw read counts as quantified from scRNA-seq:

```
head(assay(gts, "transcriptomic"))[, 1:4]
```

```
##                    ERR861694 ERR861750 ERR861695 ERR861751
## ENSMUSG00000000001         4         7        30        32
## ENSMUSG00000000003         0         0         0         0
## ENSMUSG00000000028        11        17        79        94
## ENSMUSG00000000031         0         0         0         0
## ENSMUSG00000000037         0         0         1         0
## ENSMUSG00000000049         0         0         0         0
```

For protocol information, see Macaulay et al. ([2016](#ref-Macaulay2016)).

# 3 sessionInfo

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
##  [1] RaggedExperiment_1.34.0     SingleCellExperiment_1.32.0
##  [3] SingleCellMultiModal_1.22.0 MultiAssayExperiment_1.36.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocStyle_2.38.0
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

Macaulay, Iain C, Wilfried Haerty, Parveen Kumar, Yang I Li, Tim Xiaoming Hu, Mabel J Teng, Mubeen Goolam, et al. 2015. “G&T-seq: Parallel Sequencing of Single-Cell Genomes and Transcriptomes.” *Nat. Methods* 12 (6): 519–22.

Macaulay, Iain C, Mabel J Teng, Wilfried Haerty, Parveen Kumar, Chris P Ponting, and Thierry Voet. 2016. “Separation and Parallel Sequencing of the Genomes and Transcriptomes of Single Cells Using G&T-seq.” *Nat. Protoc.* 11 (11): 2081–2103.