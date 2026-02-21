# Test files for utilities to process droplet-based single cell data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 6 November 2025

#### Package

DropletTestFiles 1.20.0

# Contents

* [1 Motivation](#motivation)
* [2 Functions](#functions)
* [3 Example](#example)
* [Session information](#session-information)

# 1 Motivation

The *[DropletTestFiles](https://bioconductor.org/packages/3.22/DropletTestFiles)* package contains files for testing droplet-based utilities,
such as those in the *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* package.
These files are literally the raw output of pipelines like 10X Genomics’ CellRanger software suite,
and are usually not in an (immediately) analysis-ready state.
After all, the idea is to provide some material to test the utilities to get to such a state!

# 2 Functions

This package doesn’t do anything except pull down and serve up files, so there’s not much to talk about here.
There are two convenience functions to help obtain content from *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*.
The first is to list all available resources managed by *[DropletTestFiles](https://bioconductor.org/packages/3.22/DropletTestFiles)*:

```
library(DropletTestFiles)
out <- listTestFiles()
out
```

```
## DataFrame with 52 rows and 18 columns
##                         title       dataprovider      species taxonomyid
##                   <character>        <character>  <character>  <integer>
## EH3685 10X brain nuclei 1k ..       10X Genomics Mus musculus      10090
## EH3686 10X brain nuclei 1k ..       10X Genomics Mus musculus      10090
## EH3687 10X brain nuclei 1k ..       10X Genomics Mus musculus      10090
## EH3688 10X brain nuclei 1k ..       10X Genomics Mus musculus      10090
## EH3689 10X brain nuclei 1k ..       10X Genomics Mus musculus      10090
## ...                       ...                ...          ...        ...
## EH3732 HiSeq 4000-sequenced.. Jonathan Griffiths Mus musculus      10090
## EH3769 10X PBMC 4k raw coun..       10X Genomics Homo sapiens       9606
## EH3770 10X PBMC 4k filtered..       10X Genomics Homo sapiens       9606
## EH3771 10X PBMC 4k raw HDF5..       10X Genomics Homo sapiens       9606
## EH3772 10X PBMC 4k molecule..       10X Genomics Homo sapiens       9606
##             genome            description coordinate_1_based
##        <character>            <character>          <integer>
## EH3685        mm10 Molecule information..                  1
## EH3686        mm10 Filtered HDF5 matrix..                  1
## EH3687        mm10 Raw HDF5 matrix for ..                  1
## EH3688        mm10 Filtered count matri..                  1
## EH3689        mm10 Raw count matrix for..                  1
## ...            ...                    ...                ...
## EH3732        mm10 Molecule information..                  1
## EH3769        hg38 Raw count matrix for..                  1
## EH3770        hg38 Filtered count matri..                  1
## EH3771        hg38 Raw HDF5 matrix for ..                  1
## EH3772        hg38 Molecule information..                  1
##                    maintainer rdatadateadded    preparerclass
##                   <character>    <character>      <character>
## EH3685 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## EH3686 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## EH3687 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## EH3688 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## EH3689 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## ...                       ...            ...              ...
## EH3732 Aaron Lun <infinite...     2020-08-26 DropletTestFiles
## EH3769 Aaron Lun <infinite...     2020-09-08 DropletTestFiles
## EH3770 Aaron Lun <infinite...     2020-09-08 DropletTestFiles
## EH3771 Aaron Lun <infinite...     2020-09-08 DropletTestFiles
## EH3772 Aaron Lun <infinite...     2020-09-08 DropletTestFiles
##                                                   tags  rdataclass
##                                                 <AsIs> <character>
## EH3685 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3686 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3687 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3688 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3689 ExperimentHub,ExperimentData,ExpressionData,...   character
## ...                                                ...         ...
## EH3732 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3769 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3770 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3771 ExperimentHub,ExperimentData,ExpressionData,...   character
## EH3772 ExperimentHub,ExperimentData,ExpressionData,...   character
##                     rdatapath              sourceurl  sourcetype
##                   <character>            <character> <character>
## EH3685 DropletTestFiles/ten.. https://support.10xg..        HDF5
## EH3686 DropletTestFiles/ten.. https://support.10xg..        HDF5
## EH3687 DropletTestFiles/ten.. https://support.10xg..        HDF5
## EH3688 DropletTestFiles/ten.. https://support.10xg..      tar.gz
## EH3689 DropletTestFiles/ten.. https://support.10xg..      tar.gz
## ...                       ...                    ...         ...
## EH3732 DropletTestFiles/bac.. https://jmlab-gitlab..        HDF5
## EH3769 DropletTestFiles/ten.. https://support.10xg..      tar.gz
## EH3770 DropletTestFiles/ten.. https://support.10xg..      tar.gz
## EH3771 DropletTestFiles/ten.. https://support.10xg..        HDF5
## EH3772 DropletTestFiles/ten.. https://support.10xg..        HDF5
##                 file.dataset file.version              file.name
##                  <character>  <character>            <character>
## EH3685 tenx-2.0.1-nuclei_900        1.0.0            mol_info.h5
## EH3686 tenx-2.0.1-nuclei_900        1.0.0            filtered.h5
## EH3687 tenx-2.0.1-nuclei_900        1.0.0                 raw.h5
## EH3688 tenx-2.0.1-nuclei_900        1.0.0        filtered.tar.gz
## EH3689 tenx-2.0.1-nuclei_900        1.0.0             raw.tar.gz
## ...                      ...          ...                    ...
## EH3732 bach-mammary-swapping        1.0.0 hiseq_4000/mol_info_..
## EH3769     tenx-2.1.0-pbmc4k        1.0.0             raw.tar.gz
## EH3770     tenx-2.1.0-pbmc4k        1.0.0        filtered.tar.gz
## EH3771     tenx-2.1.0-pbmc4k        1.0.0                 raw.h5
## EH3772     tenx-2.1.0-pbmc4k        1.0.0            mol_info.h5
```

The second is to actually obtain a resource.
This is provided in the form of a (read-only!) path on which further operations can be applied.

```
getTestFile(out$rdatapath[1], prefix=FALSE)
```

```
##                                                       EH3685
## "/home/biocbuild/.cache/R/ExperimentHub/182b357e9d6234_3721"
```

Currently, all of the files come from 10X Genomics datasets.
As such, we will see a lot of filtered/raw count matrices, molecule information files and HDF5 barcode matrices.
We refer readers to the (relevant section)[<https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/output/overview>] of the 10X Genomics website for more details.

# 3 Example

Here, we obtain a path to a filtered HDF5 matrix and read it in with a *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* function.
This produces a `SingleCellExperiment` object for use in various Bioconductor pipelines.

```
library(DropletUtils)
path <- getTestFile("tenx-3.1.0-5k_pbmc_protein_v3/1.0.0/filtered.h5", prefix=TRUE)
sce <- read10xCounts(path, type="HDF5")
sce
```

```
## class: SingleCellExperiment
## dim: 33570 5247
## metadata(1): Samples
## assays(1): counts
## rownames(33570): ENSG00000243485 ENSG00000237613 ... IgG2a IgG2b
## rowData names(3): ID Symbol Type
## colnames: NULL
## colData names(2): Sample Barcode
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# Session information

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
##  [1] DropletUtils_1.30.0         SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] DropletTestFiles_1.20.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1          dplyr_1.1.4
##  [3] blob_1.2.4                filelock_1.0.3
##  [5] R.utils_2.13.0            Biostrings_2.78.0
##  [7] fastmap_1.2.0             BiocFileCache_3.0.0
##  [9] digest_0.6.37             lifecycle_1.0.4
## [11] statmod_1.5.1             KEGGREST_1.50.0
## [13] RSQLite_2.4.3             magrittr_2.0.4
## [15] compiler_4.5.1            rlang_1.1.6
## [17] sass_0.4.10               tools_4.5.1
## [19] yaml_2.3.10               knitr_1.50
## [21] dqrng_0.4.1               S4Arrays_1.10.0
## [23] bit_4.6.0                 curl_7.0.0
## [25] DelayedArray_0.36.0       abind_1.4-8
## [27] BiocParallel_1.44.0       HDF5Array_1.38.0
## [29] withr_3.0.2               purrr_1.2.0
## [31] R.oo_1.27.1               grid_4.5.1
## [33] ExperimentHub_3.0.0       beachmat_2.26.0
## [35] edgeR_4.8.0               Rhdf5lib_1.32.0
## [37] cli_3.6.5                 rmarkdown_2.30
## [39] crayon_1.5.3              httr_1.4.7
## [41] DelayedMatrixStats_1.32.0 scuttle_1.20.0
## [43] DBI_1.2.3                 cachem_1.1.0
## [45] rhdf5_2.54.0              parallel_4.5.1
## [47] AnnotationDbi_1.72.0      BiocManager_1.30.26
## [49] XVector_0.50.0            vctrs_0.6.5
## [51] Matrix_1.7-4              jsonlite_2.0.0
## [53] bookdown_0.45             bit64_4.6.0-1
## [55] locfit_1.5-9.12           h5mread_1.2.0
## [57] limma_3.66.0              jquerylib_0.1.4
## [59] glue_1.8.0                codetools_0.2-20
## [61] BiocVersion_3.22.0        tibble_3.3.0
## [63] pillar_1.11.1             rappdirs_0.3.3
## [65] htmltools_0.5.8.1         rhdf5filters_1.22.0
## [67] R6_2.6.1                  dbplyr_2.5.1
## [69] httr2_1.2.1               sparseMatrixStats_1.22.0
## [71] evaluate_1.0.5            lattice_0.22-7
## [73] AnnotationHub_4.0.0       png_0.1-8
## [75] R.methodsS3_1.8.2         memoise_2.0.1
## [77] bslib_0.9.0               Rcpp_1.1.0
## [79] SparseArray_1.10.1        xfun_0.54
## [81] pkgconfig_2.0.3
```