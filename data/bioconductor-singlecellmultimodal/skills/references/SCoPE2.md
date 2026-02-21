# SCoPE2: macrophage vs monocytes

Christophe Vanderaa

#### 4 November 2025

#### Package

SingleCellMultiModal 1.22.0

This vignette will guide you through how accessing and manipulating
the SCoPE2 data sets available from the `SingleCellMultimodal` package.

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SingleCellMultiModal")
```

## 1.1 Load packages

```
library(SingleCellMultiModal)
library(MultiAssayExperiment)
```

# 2 SCoPE2

SCoPE2 is a mass spectrometry (MS)-based single-cell proteomics
protocol to quantify the proteome of single-cells in an untargeted
fashion. It was initially developed by Specht et al. ([2021](#ref-Specht2021-pm)).

## 2.1 Downloading data sets

The user can see the available data set by using the default options.

```
SCoPE2("macrophage_differentiation",
       mode = "*",
       version = "1.0.0",
       dry.run = TRUE)
```

```
##    ah_id       mode file_size           rdataclass rdatadateadded
## 1 EH4694    protein   33.1 Mb SingleCellExperiment     2020-09-24
## 2 EH4695 rna_assays   68.7 Mb           HDF5Matrix     2020-09-24
## 3 EH4696     rna_se    0.2 Mb SingleCellExperiment     2020-09-24
##   rdatadateremoved
## 1             <NA>
## 2             <NA>
## 3             <NA>
```

Or by simply running:

```
SCoPE2("macrophage_differentiation")
```

```
##    ah_id       mode file_size           rdataclass rdatadateadded
## 1 EH4694    protein   33.1 Mb SingleCellExperiment     2020-09-24
## 2 EH4695 rna_assays   68.7 Mb           HDF5Matrix     2020-09-24
## 3 EH4696     rna_se    0.2 Mb SingleCellExperiment     2020-09-24
##   rdatadateremoved
## 1             <NA>
## 2             <NA>
## 3             <NA>
```

## 2.2 Available projects

Currently, only the `macrophage_differentiation` is available.

## 2.3 Retrieving data

You can retrieve the actual data from `ExperimentHub` by setting
`dry.run = FALSE`. This example retrieves the complete data set
(transcriptome and proteome) for the `macrophage_differentiation`
project:

```
scope2 <- SCoPE2("macrophage_differentiation",
                 modes = "rna|protein",
                 dry.run = FALSE)
scope2
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] protein: SingleCellExperiment with 3042 rows and 1490 columns
##  [2] rna: SingleCellExperiment with 32738 rows and 20274 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 3 The macrophage differentiation project

This data set has been acquired by the Slavov Lab (Specht et al. ([2021](#ref-Specht2021-pm))).
It contains single-cell proteomics and single-cell
RNA sequencing data for macrophages and monocytes. The objective of the
research that led to generate the data is to understand whether
homogeneous monocytes differentiate in the absence of cytokines to
macrophages with homogeneous or heterogeneous profiles. The transcriptomic and
proteomic acquisitions are conducted on two separate subset of similar
cells (same experimental design). The cell type of the samples are known only
for the **proteomics** data. The proteomics data was retrieved from
the authors’ [website](https://scope2.slavovlab.net/docs/data) and the
transcriptomic data was retrieved from the GEO database (accession id:
[GSE142392](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE142392)).

For more information on the protocol, see Specht et al. ([2021](#ref-Specht2021-pm)).

## 3.1 Data versions

Only version `1.0.0` is currently available.

The `macrophage_differentiation` data set in this package contains two
assays: `rna` and `protein`.

### 3.1.1 Cell annotation

The single-cell proteomics data contains cell type annotation
(`celltype`), sample preparation batch (`batch_digest` and
`batch_sort`), chromatography batch (`batch_chromatography`), and the
MS acquisition run (`batch_MS`). The single-cell transcriptomics data
was acquired in two batches (`batch_Chromium`). Note that because the
cells that compose the two assays are distinct, there is no common
cell annotation available for both proteomics and transcriptomics. The
annotation were therefore filled with `NA`s accordingly.

```
colData(scope2)
```

```
## DataFrame with 21764 rows and 6 columns
##                         celltype batch_digest  batch_sort batch_chromatography
##                      <character>  <character> <character>          <character>
## AAACCTGAGAAACCAT-1.1          NA           NA          NA                   NA
## AAACCTGAGACTAGGC-1.2          NA           NA          NA                   NA
## AAACCTGAGAGGTAGA-1.2          NA           NA          NA                   NA
## AAACCTGAGATGCGAC-1.1          NA           NA          NA                   NA
## AAACCTGAGGCTAGGT-1.1          NA           NA          NA                   NA
## ...                          ...          ...         ...                  ...
## i985                  Macrophage            Q          s8                LCA10
## i986                    Monocyte            Q          s8                LCA10
## i987                    Monocyte            Q          s8                LCA10
## i998                    Monocyte            R          s9                 LCB3
## i999                    Monocyte            R          s9                 LCB3
##                                    batch_MS batch_Chromium
##                                 <character>       <factor>
## AAACCTGAGAAACCAT-1.1                     NA              1
## AAACCTGAGACTAGGC-1.2                     NA              2
## AAACCTGAGAGGTAGA-1.2                     NA              2
## AAACCTGAGATGCGAC-1.1                     NA              1
## AAACCTGAGGCTAGGT-1.1                     NA              1
## ...                                     ...            ...
## i985                 X190321S_LCA10_X_FP9..             NA
## i986                 X190321S_LCA10_X_FP9..             NA
## i987                 X190321S_LCA10_X_FP9..             NA
## i998                 X190914S_LCB3_X_16pl..             NA
## i999                 X190914S_LCB3_X_16pl..             NA
```

### 3.1.2 Transcriptomic data

You can extract and check the transcriptomic data through subsetting:

```
scope2[["rna"]]
```

```
## class: SingleCellExperiment
## dim: 32738 20274
## metadata(0):
## assays(1): counts
## rownames(32738): MIR1302-10 FAM138A ... AC002321.2 AC002321.1
## rowData names(0):
## colnames(20274): AAACCTGAGAAACCAT-1.1 AAACCTGAGATGCGAC-1.1 ...
##   TTTGTCATCGCTTAGA-1.2 TTTGTCATCGTAGATC-1.2
## colData names(1): Batch
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

The data is rather large and is therefore stored on-disk using the
HDF5 backend. You can verify this by looking at the assay data matrix.
Note that the counts are UMI counts.

```
assay(scope2[["rna"]])[1:5, 1:5]
```

```
## <5 x 5> sparse DelayedMatrix object of type "integer":
##              AAACCTGAGAAACCAT-1.1 ... AAACCTGCAATAACGA-1.1
## MIR1302-10                      0   .                    0
## FAM138A                         0   .                    0
## OR4F5                           0   .                    0
## RP11-34P13.7                    0   .                    0
## RP11-34P13.8                    0   .                    0
```

### 3.1.3 Proteomic data

The `protein` assay contains MS-based proteomic data.
The data have been passed sample and feature quality control,
normalized, log transformed, imputed and batch corrected. Detailed
information about the data processing is available in
[another vignette](https://uclouvain-cbio.github.io/SCP.replication/articles/SCoPE2.html). You can extract the proteomic data similarly to the
transcriptomic data:

```
scope2[["protein"]]
```

```
## class: SingleCellExperiment
## dim: 3042 1490
## metadata(0):
## assays(1): logexprs
## rownames(3042): A0A075B6H9 A0A0B4J1V0 ... Q9Y6X6 Q9Y6Z7
## rowData names(0):
## colnames(1490): i4 i5 ... i2766 i2767
## colData names(5): celltype batch_digest batch_sort batch_chromatography
##   batch_MS
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

In this case, the protein data have reasonable size and are loaded
directly into memory. The data matrix is stored in `logexprs`. We
decided to not use the traditional `logcounts` because MS proteomics
measures intensities rather than counts as opposed to scRNA-Seq.

```
assay(scope2[["protein"]])[1:5, 1:5]
```

```
##                     i4         i5          i7         i10         i11
## A0A075B6H9 -0.01366062 -0.1824640  0.12977307  0.08940234  0.05711272
## A0A0B4J1V0  0.13875137  0.5383824 -0.35823777 -0.10122993 -0.10688821
## A0A0B4J237  0.54897085 -0.2247036  0.50132075 -0.14652437 -0.40384721
## A0A1B0GTH6  0.05392801 -0.3811629  0.07532757  0.29708811 -0.03003732
## A0A1B0GUA6 -0.16910887  0.1542946 -0.14959632  0.14745758  0.03578250
```

# 4 sessionInfo

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
##  [1] rhdf5_2.54.0                RaggedExperiment_1.34.0
##  [3] SingleCellExperiment_1.32.0 SingleCellMultiModal_1.22.0
##  [5] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.54
##  [4] bslib_0.9.0              httr2_1.2.1              lattice_0.22-7
##  [7] rhdf5filters_1.22.0      vctrs_0.6.5              tools_4.5.1
## [10] curl_7.0.0               tibble_3.3.0             AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3            blob_1.2.4               pkgconfig_2.0.3
## [16] BiocBaseUtils_1.12.0     Matrix_1.7-4             dbplyr_2.5.1
## [19] lifecycle_1.0.4          compiler_4.5.1           Biostrings_2.78.0
## [22] htmltools_0.5.8.1        sass_0.4.10              yaml_2.3.10
## [25] pillar_1.11.1            crayon_1.5.3             jquerylib_0.1.4
## [28] DelayedArray_0.36.0      cachem_1.1.0             magick_2.9.0
## [31] abind_1.4-8              ExperimentHub_3.0.0      AnnotationHub_4.0.0
## [34] tidyselect_1.2.1         digest_0.6.37            purrr_1.1.0
## [37] dplyr_1.1.4              bookdown_0.45            BiocVersion_3.22.0
## [40] fastmap_1.2.0            grid_4.5.1               cli_3.6.5
## [43] SparseArray_1.10.1       magrittr_2.0.4           S4Arrays_1.10.0
## [46] h5mread_1.2.0            withr_3.0.2              filelock_1.0.3
## [49] rappdirs_0.3.3           bit64_4.6.0-1            rmarkdown_2.30
## [52] XVector_0.50.0           httr_1.4.7               bit_4.6.0
## [55] png_0.1-8                SpatialExperiment_1.20.0 HDF5Array_1.38.0
## [58] memoise_2.0.1            evaluate_1.0.5           knitr_1.50
## [61] BiocFileCache_3.0.0      rlang_1.1.6              Rcpp_1.1.0
## [64] glue_1.8.0               DBI_1.2.3                formatR_1.14
## [67] BiocManager_1.30.26      jsonlite_2.0.0           Rhdf5lib_1.32.0
## [70] R6_2.6.1
```

# References

Specht, Harrison, Edward Emmott, Aleksandra A Petelski, R Gray Huffman, David H Perlman, Marco Serra, Peter Kharchenko, Antonius Koller, and Nikolai Slavov. 2021. “Single-Cell Proteomic and Transcriptomic Analysis of Macrophage Heterogeneity Using SCoPE2.” *Genome Biol.* 22 (1): 50.