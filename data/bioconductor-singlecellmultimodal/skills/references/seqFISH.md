# seqFISH Mouse Visual Cortex

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

## 1.1 Load packages

```
library(MultiAssayExperiment)
library(SpatialExperiment)
library(SingleCellMultiModal)
```

# 2 seq-FISH dataset

The dataset consists of two data types,
seq-FISH data was provided by Zhu et al. ([2018](#ref-Zhu2018identification)), while scRNA-seq data
was provided by Tasic et al. ([2016](#ref-Tasic2016adult)).

Data have been retrievedas part of the
[Hackathon](https://github.com/BIRSBiointegration/Hackathon/tree/master/seqFISH)
in the
[Mathematical Frameworks for Integrative Analysis of Emerging Biological DataTypes](https://www.birs.ca/events/2020/5-day-workshops/20w5197) workshop.

## 2.1 Downloading datasets

The user can see the available dataset by using the default options

```
seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=TRUE, version="2.0.0"
)
```

```
##    ah_id                mode file_size rdataclass rdatadateadded
## 1 EH3785        scRNA_Counts    0.2 Mb     matrix     2020-09-14
## 2 EH3786        scRNA_Labels      0 Mb data.frame     2020-09-14
## 3 EH3787 seqFISH_Coordinates      0 Mb data.frame     2020-09-14
## 4 EH3788      seqFISH_Counts    0.2 Mb     matrix     2020-09-14
## 5 EH3789      seqFISH_Labels      0 Mb data.frame     2020-09-14
##   rdatadateremoved
## 1             <NA>
## 2             <NA>
## 3             <NA>
## 4             <NA>
## 5             <NA>
```

Or simply by running:

```
seqfish <- seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=FALSE, version="2.0.0"
)
```

```
## Working on: scRNA_Counts
```

```
## Working on: scRNA_Labels
```

```
## Working on: seqFISH_Coordinates
```

```
## Working on: seqFISH_Counts
```

```
## Working on: seqFISH_Labels
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
## Note: spatialData and spatialDataNames have been deprecated; all columns should be stored in colData and spatialCoords
```

```
seqfish
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] seqFISH: SpatialExperiment with 113 rows and 1597 columns
##  [2] scRNAseq: SingleCellExperiment with 113 rows and 1722 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Extract the list of experiments *without* the associated colData.

```
experiments(seqfish)
```

```
## ExperimentList class object of length 2:
##  [1] seqFISH: SpatialExperiment with 113 rows and 1597 columns
##  [2] scRNAseq: SingleCellExperiment with 113 rows and 1722 columns
```

## 2.2 Exploring the data structure

Check row annotations for all experiments:

```
rownames(seqfish)
```

```
## CharacterList of length 2
## [["seqFISH"]] abca15 abca9 acta2 adcy4 aldh3b2 ... wrn zfp182 zfp715 zfp90
## [["scRNAseq"]] abca15 abca9 acta2 adcy4 aldh3b2 ... wrn zfp182 zfp715 zfp90
```

Take a peek at the `sampleMap` (graph representation of assays, cells, and
barcodes):

```
sampleMap(seqfish)
```

```
## DataFrame with 3319 rows and 3 columns
##         assay     primary     colname
##      <factor> <character> <character>
## 1     seqFISH          V2          V2
## 2     seqFISH          V3          V3
## 3     seqFISH          V4          V4
## 4     seqFISH          V5          V5
## 5     seqFISH          V6          V6
## ...       ...         ...         ...
## 3315 scRNAseq       V1719       V1719
## 3316 scRNAseq       V1720       V1720
## 3317 scRNAseq       V1721       V1721
## 3318 scRNAseq       V1722       V1722
## 3319 scRNAseq       V1723       V1723
```

## 2.3 Visualize matching cell identifiers across assays

```
upsetSamples(seqfish)
```

![](data:image/png;base64...)

This shows that about 1597 cells match across both modalities / assays.

## 2.4 scRNA-seq data

The scRNA-seq data are accessible with `$scRNAseq`, which returns a
*SingleCellExperiment* class object, with all its associated methods.

```
seqfish[["scRNAseq"]]
```

```
## class: SingleCellExperiment
## dim: 113 1722
## metadata(0):
## assays(1): counts
## rownames(113): abca15 abca9 ... zfp715 zfp90
## rowData names(0):
## colnames(1722): V2 V3 ... V1722 V1723
## colData names(3): broad_type sample_name dissection
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Otherwhise the `assay` function can be used to access the *scRNAseq* assay
stored in the `seqfish` *MultiAssayExperiment* object.

```
head(assay(seqfish, "scRNAseq"))[,1:4]
```

```
##         V2 V3  V4 V5
## abca15  11 42  17 42
## abca9   22 46  22 46
## acta2   15 47  15 42
## adcy4   12 45  12 45
## aldh3b2 27 49  27 49
## amigo2  23 43 101 43
```

## 2.5 seq-FISH data

The seq-FISH data are accessible with `$seqFISH`, which returns a
**SpatialExperiment** class object.

```
seqfish[["seqFISH"]]
```

```
## class: SpatialExperiment
## dim: 113 1597
## metadata(0):
## assays(1): counts
## rownames(113): abca15 abca9 ... zfp715 zfp90
## rowData names(1): X
## colnames(1597): V2 V3 ... V1597 V1598
## colData names(7): Cell_ID cluster ... Prob sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

Otherwhise the `assay` function can be used to access the *seqFISH* assay
stored in the `seqfish` *MultiAssayExperiment* object.

```
head(assay(seqfish, "seqFISH"))[,1:4]
```

```
##          V2 V3 V4 V5
## abca15   68 49 50 39
## abca9    41 42 38 36
## acta2    25 23 16 21
## adcy4    39 54 37 18
## aldh3b2 101 47 41 52
## amigo2   93 64 93 93
```

Spatial data can be retrieved with `spatialData` function on the
*SpatialExperiment* object.

```
(sd <- spatialData(seqfish[["seqFISH"]]))
```

```
## Note: spatialData and spatialDataNames have been deprecated; all columns should be stored in colData and spatialCoords
```

```
## DataFrame with 1597 rows and 2 columns
##         Cell_ID Irrelevant
##       <integer>  <integer>
## V2            1        100
## V3            2        100
## V4            3        100
## V5            4        100
## V6            5        100
## ...         ...        ...
## V1594      1593        100
## V1595      1594        100
## V1596      1595        100
## V1597      1596        100
## V1598      1597        100
```

Spatial coordinates within the spatial data can be retrieved in matrix form
with `spatialCoords` function on the *SpatialExperiment* object.

```
head(sc <- spatialCoords(seqfish[["seqFISH"]]))
```

```
##           x       y
## [1,] 265.76 -231.14
## [2,] 290.48 -261.52
## [3,] 257.12 -133.35
## [4,] 753.46 -261.14
## [5,] 700.01 -169.05
## [6,] 415.63 -252.45
```

Direct access to the colnames of the spacial coordinates with
`spatialCoordsNames` function.

```
spatialCoordsNames(seqfish[["seqFISH"]])
```

```
## [1] "x" "y"
```

## 2.6 Other data version

The provided seqFISH dataset comes out in two different versions:

* 1.0.0 - provides the same seqFISH data as shown in the rest of this
  vignette, but it returns the full normalized scRNA-seq data matrix (with
  labels), as released from the original authors on the GEO database.
* 2.0.0 - provides the same seqFISH data as shown in the rest of this
  vignette, but it returns a processed subset of the original scRNA-seq data,
  providing only the same genes present in the seqFISH data matrix.

### 2.6.1 Data version 1.0.0

The full scRNA-seq data matrix is 24057 rows x 1809 columns.

To access the v1.0.0 simply run

```
seqFISH(
    DataType="mouse_visual_cortex", modes="*", dry.run=FALSE, version="1.0.0"
)
```

```
## Working on: scRNA_Full_Counts
```

```
## Working on: scRNA_Full_Labels
```

```
## Working on: seqFISH_Coordinates
```

```
## Working on: seqFISH_Counts
```

```
## Working on: seqFISH_Labels
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## see ?SingleCellMultiModal and browseVignettes('SingleCellMultiModal') for documentation
```

```
## loading from cache
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
## Note: spatialData and spatialDataNames have been deprecated; all columns should be stored in colData and spatialCoords
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] seqFISH: SpatialExperiment with 113 rows and 1597 columns
##  [2] scRNAseq: SingleCellExperiment with 24057 rows and 1809 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 3 Session Info

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
##  [1] SpatialExperiment_1.20.0    scater_1.38.0
##  [3] ggplot2_4.0.0               scran_1.38.0
##  [5] scuttle_1.20.0              rhdf5_2.54.0
##  [7] RaggedExperiment_1.34.0     SingleCellExperiment_1.32.0
##  [9] SingleCellMultiModal_1.22.0 MultiAssayExperiment_1.36.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
##   [4] formatR_1.14         rlang_1.1.6          magrittr_2.0.4
##   [7] RcppAnnoy_0.0.22     compiler_4.5.1       RSQLite_2.4.3
##  [10] png_0.1-8            vctrs_0.6.5          pkgconfig_2.0.3
##  [13] crayon_1.5.3         fastmap_1.2.0        dbplyr_2.5.1
##  [16] magick_2.9.0         XVector_0.50.0       labeling_0.4.3
##  [19] rmarkdown_2.30       ggbeeswarm_0.7.2     UpSetR_1.4.0
##  [22] tinytex_0.57         purrr_1.1.0          bit_4.6.0
##  [25] xfun_0.54            bluster_1.20.0       cachem_1.1.0
##  [28] beachmat_2.26.0      jsonlite_2.0.0       blob_1.2.4
##  [31] rhdf5filters_1.22.0  DelayedArray_0.36.0  Rhdf5lib_1.32.0
##  [34] BiocParallel_1.44.0  irlba_2.3.5.1        parallel_4.5.1
##  [37] cluster_2.1.8.1      R6_2.6.1             RColorBrewer_1.1-3
##  [40] bslib_0.9.0          limma_3.66.0         jquerylib_0.1.4
##  [43] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
##  [46] BiocBaseUtils_1.12.0 Matrix_1.7-4         igraph_2.2.1
##  [49] tidyselect_1.2.1     viridis_0.6.5        dichromat_2.0-0.1
##  [52] abind_1.4-8          yaml_2.3.10          codetools_0.2-20
##  [55] curl_7.0.0           plyr_1.8.9           lattice_0.22-7
##  [58] tibble_3.3.0         S7_0.2.0             withr_3.0.2
##  [61] KEGGREST_1.50.0      evaluate_1.0.5       BiocFileCache_3.0.0
##  [64] ExperimentHub_3.0.0  Biostrings_2.78.0    pillar_1.11.1
##  [67] BiocManager_1.30.26  filelock_1.0.3       BiocVersion_3.22.0
##  [70] scales_1.4.0         glue_1.8.0           metapod_1.18.0
##  [73] tools_4.5.1          AnnotationHub_4.0.0  BiocNeighbors_2.4.0
##  [76] ScaledMatrix_1.18.0  locfit_1.5-9.12      cowplot_1.2.0
##  [79] grid_4.5.1           AnnotationDbi_1.72.0 edgeR_4.8.0
##  [82] beeswarm_0.4.0       BiocSingular_1.26.0  HDF5Array_1.38.0
##  [85] vipor_0.4.7          cli_3.6.5            rsvd_1.0.5
##  [88] rappdirs_0.3.3       viridisLite_0.4.2    S4Arrays_1.10.0
##  [91] dplyr_1.1.4          uwot_0.2.3           gtable_0.3.6
##  [94] sass_0.4.10          digest_0.6.37        ggrepel_0.9.6
##  [97] SparseArray_1.10.1   dqrng_0.4.1          farver_2.1.2
## [100] rjson_0.2.23         memoise_2.0.1        htmltools_0.5.8.1
## [103] lifecycle_1.0.4      h5mread_1.2.0        httr_1.4.7
## [106] statmod_1.5.1        bit64_4.6.0-1
```

Tasic, Bosiljka, Vilas Menon, Thuc Nghi Nguyen, Tae Kyung Kim, Tim Jarsky, Zizhen Yao, Boaz Levi, et al. 2016. “Adult Mouse Cortical Cell Taxonomy Revealed by Single Cell Transcriptomics.” *Nature Neuroscience* 19 (2): 335.

Zhu, Qian, Sheel Shah, Ruben Dries, Long Cai, and Guo-Cheng Yuan. 2018. “Identification of Spatially Associated Subpopulations by Combining scRNAseq and Sequential Fluorescence in Situ Hybridization Data.” *Nature Biotechnology* 36 (12): 1183.