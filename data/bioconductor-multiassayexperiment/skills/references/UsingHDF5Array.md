# Using DelayedMatrix with MultiAssayExperiment

MultiAssay Special Interest Group

#### November 17, 2025

# Contents

* [1 Integrating an HDF5 backend for MultiAssayExperiment](#integrating-an-hdf5-backend-for-multiassayexperiment)
  + [1.1 Dependencies](#dependencies)
  + [1.2 HDF5Array and DelayedArray Constructor](#hdf5array-and-delayedarray-constructor)
  + [1.3 Writing to a file with dimnames](#writing-to-a-file-with-dimnames)
  + [1.4 Importing HDF5 files](#importing-hdf5-files)
  + [1.5 Using a `DelayedMatrix` with `MultiAssayExperiment`](#using-a-delayedmatrix-with-multiassayexperiment)
    - [1.5.1 `SummarizedExperiment` with `DelayedMatrix` backend](#summarizedexperiment-with-delayedmatrix-backend)
* [2 Session info](#session-info)

# 1 Integrating an HDF5 backend for MultiAssayExperiment

## 1.1 Dependencies

```
library(MultiAssayExperiment)
library(HDF5Array)
library(SummarizedExperiment)
```

## 1.2 HDF5Array and DelayedArray Constructor

The `HDF5Array` package provides an on-disk representation of large datasets
without the need to load them into memory. Convenient lazy evaluation
operations allow the user to manipulate such large data files based on
metadata. The `DelayedMatrix` class in the `DelayedArray` package provides a
way to connect to a large matrix that is stored on disk.

First, we create a small matrix for constructing the `DelayedMatrix` class.

```
smallMatrix <- matrix(rnorm(10e5), ncol = 20)
```

We add rownames and column names to the matrix object for compatibility with
the `MultiAssayExperiment` representation.

```
rownames(smallMatrix) <- paste0("GENE", seq_len(nrow(smallMatrix)))
colnames(smallMatrix) <- paste0("SampleID", seq_len(ncol(smallMatrix)))
```

Here we use the `DelayedArray` constructor function to create a
`DelayedMatrix` object.

```
smallMatrix <- DelayedArray(smallMatrix)
class(smallMatrix)
```

```
## [1] "DelayedMatrix"
## attr(,"package")
## [1] "DelayedArray"
```

```
# show method
smallMatrix
```

```
## <50000 x 20> DelayedMatrix object of type "double":
##              SampleID1    SampleID2    SampleID3 ...  SampleID19  SampleID20
##     GENE1    0.5164739   -0.2363404    0.5740629   .  0.41484597  0.01513205
##     GENE2   -0.9724493   -0.1776573    0.6932187   .  1.04457095  1.10881790
##     GENE3   -0.5359190    0.4585857    0.1736537   . -1.93880314 -0.65617292
##     GENE4   -0.3731271   -0.3901437   -0.1888025   . -0.55452652 -0.77518177
##     GENE5   -0.3909257   -0.6764543   -1.3734934   .  0.01343677 -0.82173434
##       ...            .            .            .   .           .           .
## GENE49996 -0.039837027 -1.066033663 -0.239186796   .   0.1869983  -0.4143775
## GENE49997  0.045536777  0.358195610 -0.585620374   .  -0.1795559   1.1963955
## GENE49998 -1.050365168  2.119895839 -0.355378500   .  -0.4581261   0.4495450
## GENE49999 -0.118623990  0.435058458 -0.482903886   .   0.8349894  -0.9652298
## GENE50000 -1.382821069  0.006768519 -1.293677569   .  -0.3206401   1.2784837
```

```
dim(smallMatrix)
```

```
## [1] 50000    20
```

## 1.3 Writing to a file with dimnames

Finally, the `rhdf5` package stores `dimnames` in a standard location.

In order to make use of this functionality, we would use `writeHDF5Array`
with the `with.dimnames` argument:

```
testh5 <- tempfile(fileext = ".h5")
writeHDF5Array(smallMatrix, filepath = testh5, name = "smallMatrix",
    with.dimnames = TRUE)
```

```
## <50000 x 20> HDF5Matrix object of type "double":
##              SampleID1    SampleID2    SampleID3 ...  SampleID19  SampleID20
##     GENE1    0.5164739   -0.2363404    0.5740629   .  0.41484597  0.01513205
##     GENE2   -0.9724493   -0.1776573    0.6932187   .  1.04457095  1.10881790
##     GENE3   -0.5359190    0.4585857    0.1736537   . -1.93880314 -0.65617292
##     GENE4   -0.3731271   -0.3901437   -0.1888025   . -0.55452652 -0.77518177
##     GENE5   -0.3909257   -0.6764543   -1.3734934   .  0.01343677 -0.82173434
##       ...            .            .            .   .           .           .
## GENE49996 -0.039837027 -1.066033663 -0.239186796   .   0.1869983  -0.4143775
## GENE49997  0.045536777  0.358195610 -0.585620374   .  -0.1795559   1.1963955
## GENE49998 -1.050365168  2.119895839 -0.355378500   .  -0.4581261   0.4495450
## GENE49999 -0.118623990  0.435058458 -0.482903886   .   0.8349894  -0.9652298
## GENE50000 -1.382821069  0.006768519 -1.293677569   .  -0.3206401   1.2784837
```

To see the file structure we use `h5ls`:

```
h5ls(testh5)
```

```
##                    group                  name       otype dclass        dim
## 0                      / .smallMatrix_dimnames   H5I_GROUP
## 1 /.smallMatrix_dimnames                     1 H5I_DATASET STRING      50000
## 2 /.smallMatrix_dimnames                     2 H5I_DATASET STRING         20
## 3                      /           smallMatrix H5I_DATASET  FLOAT 50000 x 20
```

## 1.4 Importing HDF5 files

Note that a large matrix from an HDF5 file can also be loaded using the
`HDF5ArraySeed` and `DelayedArray` functions.

```
hdf5Data <- HDF5ArraySeed(file = testh5, name = "smallMatrix")
newDelayedMatrix <- DelayedArray(hdf5Data)
class(newDelayedMatrix)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
newDelayedMatrix
```

```
## <50000 x 20> HDF5Matrix object of type "double":
##              SampleID1    SampleID2    SampleID3 ...  SampleID19  SampleID20
##     GENE1    0.5164739   -0.2363404    0.5740629   .  0.41484597  0.01513205
##     GENE2   -0.9724493   -0.1776573    0.6932187   .  1.04457095  1.10881790
##     GENE3   -0.5359190    0.4585857    0.1736537   . -1.93880314 -0.65617292
##     GENE4   -0.3731271   -0.3901437   -0.1888025   . -0.55452652 -0.77518177
##     GENE5   -0.3909257   -0.6764543   -1.3734934   .  0.01343677 -0.82173434
##       ...            .            .            .   .           .           .
## GENE49996 -0.039837027 -1.066033663 -0.239186796   .   0.1869983  -0.4143775
## GENE49997  0.045536777  0.358195610 -0.585620374   .  -0.1795559   1.1963955
## GENE49998 -1.050365168  2.119895839 -0.355378500   .  -0.4581261   0.4495450
## GENE49999 -0.118623990  0.435058458 -0.482903886   .   0.8349894  -0.9652298
## GENE50000 -1.382821069  0.006768519 -1.293677569   .  -0.3206401   1.2784837
```

## 1.5 Using a `DelayedMatrix` with `MultiAssayExperiment`

A `DelayedMatrix` alone conforms to the `MultiAssayExperiment` API requirements.
Shown below, the `DelayedMatrix` can be put into a named `list` and passed into
the `MultiAssayExperiment` constructor function.

```
HDF5MAE <- MultiAssayExperiment(experiments = list(smallMatrix = smallMatrix))
sampleMap(HDF5MAE)
```

```
## DataFrame with 20 rows and 3 columns
##           assay     primary     colname
##        <factor> <character> <character>
## 1   smallMatrix   SampleID1   SampleID1
## 2   smallMatrix   SampleID2   SampleID2
## 3   smallMatrix   SampleID3   SampleID3
## 4   smallMatrix   SampleID4   SampleID4
## 5   smallMatrix   SampleID5   SampleID5
## ...         ...         ...         ...
## 16  smallMatrix  SampleID16  SampleID16
## 17  smallMatrix  SampleID17  SampleID17
## 18  smallMatrix  SampleID18  SampleID18
## 19  smallMatrix  SampleID19  SampleID19
## 20  smallMatrix  SampleID20  SampleID20
```

```
colData(HDF5MAE)
```

```
## DataFrame with 20 rows and 0 columns
```

### 1.5.1 `SummarizedExperiment` with `DelayedMatrix` backend

A more information rich `DelayedMatrix` can be created when used in conjunction
with the `SummarizedExperiment` class and it can even include `rowRanges`.
The flexibility of the `MultiAssayExperiment` API supports classes with
minimal requirements. Additionally, this `SummarizedExperiment` with the
`DelayedMatrix` backend can be part of a bigger `MultiAssayExperiment` object.
Below is a minimal example of how this would work:

```
HDF5SE <- SummarizedExperiment(assays = smallMatrix)
assay(HDF5SE)
```

```
## <50000 x 20> DelayedMatrix object of type "double":
##              SampleID1    SampleID2    SampleID3 ...  SampleID19  SampleID20
##     GENE1    0.5164739   -0.2363404    0.5740629   .  0.41484597  0.01513205
##     GENE2   -0.9724493   -0.1776573    0.6932187   .  1.04457095  1.10881790
##     GENE3   -0.5359190    0.4585857    0.1736537   . -1.93880314 -0.65617292
##     GENE4   -0.3731271   -0.3901437   -0.1888025   . -0.55452652 -0.77518177
##     GENE5   -0.3909257   -0.6764543   -1.3734934   .  0.01343677 -0.82173434
##       ...            .            .            .   .           .           .
## GENE49996 -0.039837027 -1.066033663 -0.239186796   .   0.1869983  -0.4143775
## GENE49997  0.045536777  0.358195610 -0.585620374   .  -0.1795559   1.1963955
## GENE49998 -1.050365168  2.119895839 -0.355378500   .  -0.4581261   0.4495450
## GENE49999 -0.118623990  0.435058458 -0.482903886   .   0.8349894  -0.9652298
## GENE50000 -1.382821069  0.006768519 -1.293677569   .  -0.3206401   1.2784837
```

```
MultiAssayExperiment(list(HDF5SE = HDF5SE))
```

```
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] HDF5SE: SummarizedExperiment with 50000 rows and 20 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Additional scenarios are currently in development where an `HDF5Matrix` is
hosted remotely. Many opportunities exist when considering on-disk and off-disk
representations of data with `MultiAssayExperiment`.

# 2 Session info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] HDF5Array_1.38.0            h5mread_1.2.0
##  [3] rhdf5_2.54.0                DelayedArray_0.36.0
##  [5] SparseArray_1.10.2          S4Arrays_1.10.0
##  [7] abind_1.4-8                 Matrix_1.7-4
##  [9] survminer_0.5.1             ggpubr_0.6.2
## [11] ggplot2_4.0.1               survival_3.8-3
## [13] UpSetR_1.4.0                RaggedExperiment_1.34.0
## [15] MultiAssayExperiment_1.36.1 SummarizedExperiment_1.40.0
## [17] Biobase_2.70.0              GenomicRanges_1.62.0
## [19] Seqinfo_1.0.0               IRanges_2.44.0
## [21] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [23] generics_0.1.4              MatrixGenerics_1.22.0
## [25] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     dplyr_1.1.4          farver_2.1.2
##  [4] S7_0.2.1             fastmap_1.2.0        digest_0.6.38
##  [7] lifecycle_1.0.4      magrittr_2.0.4       compiler_4.5.2
## [10] rlang_1.1.6          sass_0.4.10          tools_4.5.2
## [13] yaml_2.3.10          data.table_1.17.8    knitr_1.50
## [16] ggsignif_0.6.4       labeling_0.4.3       xml2_1.5.0
## [19] plyr_1.8.9           RColorBrewer_1.1-3   withr_3.0.2
## [22] purrr_1.2.0          grid_4.5.2           xtable_1.8-4
## [25] Rhdf5lib_1.32.0      scales_1.4.0         dichromat_2.0-0.1
## [28] tinytex_0.57         cli_3.6.5            rmarkdown_2.30
## [31] crayon_1.5.3         km.ci_0.5-6          reshape2_1.4.5
## [34] commonmark_2.0.0     BiocBaseUtils_1.12.0 cachem_1.1.0
## [37] stringr_1.6.0        splines_4.5.2        BiocManager_1.30.27
## [40] XVector_0.50.0       survMisc_0.5.6       vctrs_0.6.5
## [43] jsonlite_2.0.0       carData_3.0-5        litedown_0.8
## [46] bookdown_0.45        car_3.1-3            rstatix_0.7.3
## [49] Formula_1.2-5        magick_2.9.0         tidyr_1.3.1
## [52] jquerylib_0.1.4      glue_1.8.0           ggtext_0.1.2
## [55] stringi_1.8.7        gtable_0.3.6         tibble_3.3.0
## [58] pillar_1.11.1        rhdf5filters_1.22.0  htmltools_0.5.8.1
## [61] R6_2.6.1             KMsurv_0.1-6         evaluate_1.0.5
## [64] lattice_0.22-7       markdown_2.0         backports_1.5.0
## [67] gridtext_0.1.5       broom_1.0.10         bslib_0.9.0
## [70] Rcpp_1.1.0           gridExtra_2.3        xfun_0.54
## [73] zoo_1.8-14           pkgconfig_2.0.3
```