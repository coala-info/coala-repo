# Save/load spatial omics data to/from file

Aaron Lun

#### Revised: December 29, 2023

#### Package

alabaster.spatial 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [Session info](#session-info)

# 1 Overview

The `SpatialExperiment` class (from the *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* package) provides a representation of spatial transcriptomics data that is compatible with Bioconductor’s `SummarizedExperiment` ecosystem.
The *[alabaster.spatial](https://bioconductor.org/packages/3.22/alabaster.spatial)* package contains methods to save and load `SpatialExperiment` objects into and out of file.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

To demonstrate, we’ll use the example dataset provided in the *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* package:

```
library(SpatialExperiment)

# Copying the example from ?read10xVisium.
dir <- system.file("extdata", "10xVisium", package = "SpatialExperiment")
sample_ids <- c("section1", "section2")
samples <- file.path(dir, sample_ids, "outs")
spe <- read10xVisium(
   samples,
   sample_ids,
   type = "sparse",
   data = "raw",
   images = "lowres",
   load = FALSE
)
colnames(spe) <- make.unique(colnames(spe)) # Making the column names unique.

spe
```

```
## class: SpatialExperiment
## dim: 50 99
## metadata(0):
## assays(1): counts
## rownames(50): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000005886 ENSMUSG00000101476
## rowData names(1): symbol
## colnames(99): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ...
##   AAAGTCGACCCTCAGT-1.1 AAAGTGCCATCAATTA-1.1
## colData names(4): in_tissue array_row array_col sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

We call the usual `saveObject()` function to save its contents to file:

```
library(alabaster.spatial)
tmp <- tempfile()
saveObject(spe, tmp)
list.files(tmp, recursive=TRUE)
```

```
##  [1] "OBJECT"                       "_environment.json"
##  [3] "assays/0/OBJECT"              "assays/0/matrix.h5"
##  [5] "assays/names.json"            "column_data/OBJECT"
##  [7] "column_data/basic_columns.h5" "coordinates/OBJECT"
##  [9] "coordinates/array.h5"         "images/0.png"
## [11] "images/1.png"                 "images/mapping.h5"
## [13] "row_data/OBJECT"              "row_data/basic_columns.h5"
```

This goes through the usual saving process for `SingleCellExperiment`s, with an additional saving step for the spatial data (see the `coordinates/` and `images/` subdirectories).
We can then load it back in using the `readObject()` function:

```
roundtrip <- readObject(tmp)
plot(imgRaster(getImg(roundtrip, "section1")))
```

![](data:image/png;base64...)

More details on the metadata and on-disk layout are provided in the [schema](https://artifactdb.github.io/BiocObjectSchemas/html/spatial_experiment/v1.html).

# Session info

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
##  [1] alabaster.spatial_1.10.0    alabaster.base_1.10.0
##  [3] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rjson_0.2.23              xfun_0.53
##  [3] bslib_0.9.0               rhdf5_2.54.0
##  [5] lattice_0.22-7            rhdf5filters_1.22.0
##  [7] tools_4.5.1               parallel_4.5.1
##  [9] R.oo_1.27.1               Matrix_1.7-4
## [11] sparseMatrixStats_1.22.0  dqrng_0.4.1
## [13] lifecycle_1.0.4           compiler_4.5.1
## [15] tinytex_0.57              statmod_1.5.1
## [17] alabaster.se_1.10.0       codetools_0.2-20
## [19] htmltools_0.5.8.1         sass_0.4.10
## [21] alabaster.matrix_1.10.0   yaml_2.3.10
## [23] jquerylib_0.1.4           R.utils_2.13.0
## [25] BiocParallel_1.44.0       DelayedArray_0.36.0
## [27] cachem_1.1.0              limma_3.66.0
## [29] magick_2.9.0              abind_1.4-8
## [31] locfit_1.5-9.12           digest_0.6.37
## [33] bookdown_0.45             fastmap_1.2.0
## [35] grid_4.5.1                cli_3.6.5
## [37] SparseArray_1.10.0        magrittr_2.0.4
## [39] S4Arrays_1.10.0           h5mread_1.2.0
## [41] edgeR_4.8.0               DelayedMatrixStats_1.32.0
## [43] rmarkdown_2.30            XVector_0.50.0
## [45] DropletUtils_1.30.0       R.methodsS3_1.8.2
## [47] beachmat_2.26.0           alabaster.sce_1.10.0
## [49] HDF5Array_1.38.0          evaluate_1.0.5
## [51] knitr_1.50                rlang_1.1.6
## [53] Rcpp_1.1.0                scuttle_1.20.0
## [55] BiocManager_1.30.26       alabaster.ranges_1.10.0
## [57] alabaster.schemas_1.10.0  jsonlite_2.0.0
## [59] R6_2.6.1                  Rhdf5lib_1.32.0
```