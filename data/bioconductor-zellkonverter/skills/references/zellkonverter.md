# Converting single-cell data structures between Bioconductor and Python

Luke Zappia\* and Aaron Lun\*\*

\*luke@lazappi.id.au
\*\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 17 April 2022

#### Package

zellkonverter 1.20.1

# 1 Overview

This package provides a lightweight interface between the Bioconductor
`SingleCellExperiment` data structure and the Python `AnnData`-based single-cell
analysis environment. The idea is to enable users and developers to easily move
data between these frameworks to construct a multi-language analysis pipeline
across R/Bioconductor and Python.

# 2 Reading and writing H5AD files

The `readH5AD()` function can be used to read a `SingleCellExperiment` from a
H5AD file. This can be manipulated in the usual way as described in the
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* documentation.

```
library(zellkonverter)

# Obtaining an example H5AD file.
example_h5ad <- system.file(
    "extdata", "krumsiek11.h5ad",
    package = "zellkonverter"
)
readH5AD(example_h5ad)
```

```
## class: SingleCellExperiment
## dim: 11 640
## metadata(2): highlights iroot
## assays(1): X
## rownames(11): Gata2 Gata1 ... EgrNab Gfi1
## rowData names(0):
## colnames(640): 0 1 ... 158-3 159-3
## colData names(1): cell_type
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

We can also write a `SingleCellExperiment` to a H5AD file with the
`writeH5AD()` function. This is demonstrated below on the classic Zeisel mouse
brain dataset from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package. The resulting file can
then be directly used in compatible Python-based analysis frameworks.

```
library(scRNAseq)

sce_zeisel <- ZeiselBrainData()
out_path <- tempfile(pattern = ".h5ad")
writeH5AD(sce_zeisel, file = out_path)
```

# 3 Converting between `SingleCellExperiment` and `AnnData` objects

Developers and power users who control their Python environments can directly
convert between `SingleCellExperiment` and
[`AnnData` objects](https://anndata.readthedocs.io/en/stable/) using the
`SCE2AnnData()` and `AnnData2SCE()` utilities. These functions expect that
*[reticulate](https://CRAN.R-project.org/package%3Dreticulate)* has already been loaded along with an appropriate
version of the [*anndata*](https://pypi.org/project/anndata/) package. We
suggest using the *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* package to set up the Python
environment before using these functions.

```
library(basilisk)
library(scRNAseq)

seger <- SegerstolpePancreasData()
roundtrip <- basiliskRun(fun = function(sce) {
    # Convert SCE to AnnData:
    adata <- SCE2AnnData(sce)

    # Maybe do some work in Python on 'adata':
    # BLAH BLAH BLAH

    # Convert back to an SCE:
    AnnData2SCE(adata)
}, env = zellkonverterAnnDataEnv(), sce = seger)
```

Package developers can guarantee that they are using the same versions of Python
packages as *[zellkonverter](https://bioconductor.org/packages/3.22/zellkonverter)* by using the `AnnDataDependencies()`
function to set up their Python environments.

```
AnnDataDependencies()
```

```
## [1] "python=3.14.0"   "anndata==0.12.3" "h5py==3.15.1"    "natsort==8.4.0"
## [5] "numpy==2.3.4"    "pandas==2.3.3"   "scipy==1.16.2"
```

This function can also be used to return dependencies for environments using
older versions of *anndata*.

```
AnnDataDependencies(version = "0.7.6")
```

```
## [1] "python==3.9.23" "anndata==0.7.6" "h5py==3.14.0"   "natsort==8.4.0"
## [5] "numpy==1.26.4"  "pandas==1.5.3"  "scipy==1.13.1"
```

# 4 Progress messages

By default the functions in *[zellkonverter](https://bioconductor.org/packages/3.22/zellkonverter)* don’t display any
information about their progress but this can be turned on by setting the
`verbose = TRUE` argument.

```
readH5AD(example_h5ad, verbose = TRUE)
```

```
## class: SingleCellExperiment
## dim: 11 640
## metadata(2): highlights iroot
## assays(1): X
## rownames(11): Gata2 Gata1 ... EgrNab Gfi1
## rowData names(0):
## colnames(640): 0 1 ... 158-3 159-3
## colData names(1): cell_type
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

If you would like to see progress messages for all functions by default you can
turn this on using the `setZellkonverterVerbose()` function.

```
# This is not run here
setZellkonverterVerbose(TRUE)
```

# 5 Session information

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
##  [1] basilisk_1.22.0             reticulate_1.44.1
##  [3] scRNAseq_2.24.0             SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.1        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] zellkonverter_1.20.1        knitr_1.51
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             httr2_1.2.2
##  [4] rlang_1.1.6              magrittr_2.0.4           otel_0.2.0
##  [7] gypsum_1.6.0             compiler_4.5.2           RSQLite_2.4.5
## [10] GenomicFeatures_1.62.0   dir.expiry_1.18.0        png_0.1-8
## [13] vctrs_0.6.5              ProtGenerics_1.42.0      pkgconfig_2.0.3
## [16] crayon_1.5.3             fastmap_1.2.0            dbplyr_2.5.1
## [19] XVector_0.50.0           Rsamtools_2.26.0         rmarkdown_2.30
## [22] UCSC.utils_1.6.1         bit_4.6.0                xfun_0.55
## [25] cachem_1.1.0             cigarillo_1.0.0          GenomeInfoDb_1.46.2
## [28] jsonlite_2.0.0           blob_1.2.4               rhdf5filters_1.22.0
## [31] DelayedArray_0.36.0      Rhdf5lib_1.32.0          BiocParallel_1.44.0
## [34] parallel_4.5.2           R6_2.6.1                 bslib_0.9.0
## [37] rtracklayer_1.70.1       jquerylib_0.1.4          Rcpp_1.1.0
## [40] bookdown_0.46            Matrix_1.7-4             tidyselect_1.2.1
## [43] abind_1.4-8              yaml_2.3.12              codetools_0.2-20
## [46] curl_7.0.0               alabaster.sce_1.10.0     lattice_0.22-7
## [49] tibble_3.3.0             KEGGREST_1.50.0          evaluate_1.0.5
## [52] BiocFileCache_3.0.0      alabaster.schemas_1.10.0 ExperimentHub_3.0.0
## [55] Biostrings_2.78.0        pillar_1.11.1            BiocManager_1.30.27
## [58] filelock_1.0.3           RCurl_1.98-1.17          BiocVersion_3.22.0
## [61] ensembldb_2.34.0         alabaster.base_1.10.0    alabaster.ranges_1.10.0
## [64] glue_1.8.0               lazyeval_0.2.2           alabaster.matrix_1.10.0
## [67] tools_4.5.2              AnnotationHub_4.0.0      BiocIO_1.20.0
## [70] GenomicAlignments_1.46.0 XML_3.99-0.20            rhdf5_2.54.1
## [73] grid_4.5.2               AnnotationDbi_1.72.0     HDF5Array_1.38.0
## [76] restfulr_0.0.16          cli_3.6.5                rappdirs_0.3.3
## [79] S4Arrays_1.10.1          dplyr_1.1.4              AnnotationFilter_1.34.0
## [82] alabaster.se_1.10.0      sass_0.4.10              digest_0.6.39
## [85] SparseArray_1.10.8       rjson_0.2.23             memoise_2.0.1
## [88] htmltools_0.5.9          lifecycle_1.0.4          h5mread_1.2.1
## [91] httr_1.4.7               bit64_4.6.0-1
```