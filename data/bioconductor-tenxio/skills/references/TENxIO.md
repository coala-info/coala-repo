# TENxIO: Import Single Cell Data Files

Marcel Ramos

#### December 08, 2025

#### Package

TENxIO 1.12.1

# Contents

* [Introduction](#introduction)
* [Supported Formats](#supported-formats)
* [Tested 10X Products](#tested-10x-products)
* [Bioconductor implementations](#bioconductor-implementations)
* [Installation](#installation)
* [Load the package](#load-the-package)
* [Description](#description)
* [Procedure](#procedure)
* [Dataset versioning](#dataset-versioning)
* [File classes](#file-classes)
  + [TENxFile](#tenxfile)
    - [`ExperimentHub` resources](#experimenthub-resources)
    - [TENxH5](#tenxh5)
    - [import TENxH5 method](#import-tenxh5-method)
  + [TENxMTX](#tenxmtx)
  + [import MTX method](#import-mtx-method)
  + [TENxFileList](#tenxfilelist)
  + [TENxPeaks](#tenxpeaks)
  + [TENxFragments](#tenxfragments)
* [Session Information](#session-information)

# Introduction

`TENxIO` allows users to import 10X pipeline files into known Bioconductor
classes. The package is not comprehensive, there are file types that are not
supported. For Visium datasets, we direct users to the `VisiumIO` package on
Bioconductor. TENxIO consolidates functionality from `DropletUtils`. If you
would like a file format to be supported, open an issue at
<https://github.com/waldronlab/TENxIO>.

# Supported Formats

| **Extension** | **Class** | **Imported as** |
| --- | --- | --- |
| .h5 | TENxH5 | SingleCellExperiment w/ TENxMatrix |
| .mtx / .mtx.gz | TENxMTX | SummarizedExperiment w/ dgCMatrix |
| .tar.gz | TENxFileList | SingleCellExperiment w/ dgCMatrix |
| peak\_annotation.tsv | TENxPeaks | GRanges |
| fragments.tsv.gz | TENxFragments | RaggedExperiment |
| .tsv / .tsv.gz | TENxTSV | tibble |
| spatial.tar.gz | TENxSpatialList | inter. DataFrame list |

# Tested 10X Products

We have tested these functions with *some*
[datasets](https://www.10xgenomics.com/resources/datasets) from 10x Genomics
including those from:

* Single Cell Gene Expression
* Single Cell ATAC
* Single Cell Multiome ATAC + Gene Expression
* Spatial Gene Expression

Note. That extensive testing has not been performed and the codebase may require
some adaptation to ensure compatibility with all pipeline outputs.

# Bioconductor implementations

We are aware of existing functionality in both `DropletUtils` and
`SpatialExperiment`. We are working with the authors of those packages to cover
the use cases in both those packages and possibly port I/O functionality into
`TENxIO`. We are using long tests and the `DropletTestFiles` package to
cover example datasets on `ExperimentHub`, if you would like to know more, see
the `longtests` directory on GitHub.

# Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("waldronlab/TENxIO")
```

# Load the package

```
library(TENxIO)
```

# Description

`TENxIO` offers an set of classes that allow users to easily work with files
typically obtained from the 10X Genomics website. Generally, these are outputs
from the Cell Ranger pipeline.

# Procedure

Loading the data into a Bioconductor class is a two step process. First, the
file must be identified by either the user or the `TENxFile` function. The
appropriate function will be evoked to provide a `TENxIO` class representation,
e.g., `TENxH5` for HDF5 files with an `.h5` extension. Secondly, the `import`
method for that particular file class will render a common Bioconductor class
representation for the user. The main representations used by the package are
`SingleCellExperiment`, `SummarizedExperiment`, `GRanges`, and
`RaggedExperiment`.

# Dataset versioning

The versioning schema in the package mostly applies to HDF5 resources and is
loosely based on versions of 10X datasets. For the most part, version 3 datasets
usually contain ranged information at specific locations in the data file.
Version 2 datasets will usually contain a `genes.tsv` file, rather than
`features.tsv` as in version 3. If the file version is unknown, the software
will attempt to derive the version from the data where possible.

# File classes

## TENxFile

The `TENxFile` class is the catch-all class superclass that allows transition
to subclasses pertinent to specific files. It inherits from the `BiocFile`
class and allows for easy dispatching `import` methods.

```
showClass("TENxFile")
```

```
## Class "TENxFile" [package "TENxIO"]
##
## Slots:
##
## Name:                extension                  colidx                  rowidx
## Class:               character                 integer                 integer
##
## Name:                   remote              compressed                resource
## Class:                 logical                 logical character_OR_connection
##
## Extends: "BiocFile"
##
## Known Subclasses: "TENxFragments", "TENxH5", "TENxMTX", "TENxPeaks", "TENxTSV"
```

### `ExperimentHub` resources

`TENxFile` can handle resources from `ExperimentHub` with careful inputs.
For example, one can import a `TENxBrainData` dataset via the appropriate
`ExperimentHub` identifier (`EH1039`):

```
hub <- ExperimentHub::ExperimentHub()
hub["EH1039"]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-07
## # names(): EH1039
## # package(): TENxBrainData
## # $dataprovider: 10X Genomics
## # $species: Mus musculus
## # $rdataclass: character
## # $rdatadateadded: 2017-10-26
## # $title: Brain scRNA-seq data, 'HDF5-based 10X Genomics' format
## # $description: Single-cell RNA-seq data for 1.3 million brain cells from E1...
## # $taxonomyid: 10090
## # $genome: mm10
## # $sourcetype: HDF5
## # $sourceurl: http://cf.10xgenomics.com/samples/cell-exp/1.3.0/1M_neurons/1M...
## # $sourcesize: NA
## # $tags: c("SequencingData", "RNASeqData", "ExpressionData",
## #   "SingleCell")
## # retrieve record with 'object[["EH1039"]]'
```

Currently, `ExperimentHub` resources do not have an extension and it is best to
provide that to the `TENxFile` constructor function.

```
fname <- hub[["EH1039"]]
TENxFile(fname, extension = "h5", group = "mm10", version = "2")
```

Note. `EH1039` is a large ~ 4GB file and files without extension as those
obtained from `ExperimentHub` will emit a warning so that the user is aware that
the import operation may fail, esp. if the internal structure of the file is
modified.

### TENxH5

`TENxIO` mainly supports version 3 and 2 type of H5 files. These are files
with specific groups and names as seen in `h5.version.map`, an internal
`data.frame` map that guides the import operations.

```
TENxIO:::h5.version.map
```

```
##   Version           ID         Symbol                   Type             Ranges
## 1       3 /features/id /features/name /features/feature_type /features/interval
## 2       2       /genes    /gene_names                   <NA>               <NA>
```

In the case that, there is a file without genomic coordinate information, the
constructor function can take an `NA_character_` input for the `ranges`
argument.

The `TENxH5` constructor function can be used on either version of these H5
files. In this example, we use a subset of the PBMC granulocyte
H5 file obtained from the [10X website](https://cf.10xgenomics.com/samples/cell-arc/2.0.0/pbmc_granulocyte_sorted_3k/pbmc_granulocyte_sorted_3k_filtered_feature_bc_matrix.h5).

```
h5f <- system.file(
    "extdata", "pbmc_granulocyte_ff_bc_ex.h5",
    package = "TENxIO", mustWork = TRUE
)
library(rhdf5)
h5ls(h5f)
```

```
##               group          name       otype  dclass dim
## 0                 /        matrix   H5I_GROUP
## 1           /matrix      barcodes H5I_DATASET  STRING  10
## 2           /matrix          data H5I_DATASET INTEGER   2
## 3           /matrix      features   H5I_GROUP
## 4  /matrix/features _all_tag_keys H5I_DATASET  STRING   2
## 5  /matrix/features  feature_type H5I_DATASET  STRING  10
## 6  /matrix/features        genome H5I_DATASET  STRING  10
## 7  /matrix/features            id H5I_DATASET  STRING  10
## 8  /matrix/features      interval H5I_DATASET  STRING  10
## 9  /matrix/features          name H5I_DATASET  STRING  10
## 10          /matrix       indices H5I_DATASET INTEGER   2
## 11          /matrix        indptr H5I_DATASET INTEGER  11
## 12          /matrix         shape H5I_DATASET INTEGER   2
```

Note. The `h5ls` function gives an overview of the structure of the file.
It matches version 3 in our version map.

The show method gives an overview of the data components in the file:

```
con <- TENxH5(h5f)
con
```

```
## TENxH5 object
## resource: /tmp/Rtmp1oKEpY/Rinst30f658170f626a/TENxIO/extdata/pbmc_granulocyte_ff_bc_ex.h5
## dim: 10 10
## rownames: ENSG00000243485 ENSG00000237613 ... ENSG00000286448 ENSG00000236601
## rowData names(3): ID Symbol Type
##   Type: Gene Expression
## colnames: AAACAGCCAAATATCC-1 AAACAGCCAGGAACTG-1 ... AAACCGCGTGAGGTAG-1 AAACGCGCATACCCGG-1
```

### import TENxH5 method

We can simply use the import method to convert the file representation to
a Bioconductor class representation, typically a `SingleCellExperiment`.

```
import(con)
```

```
## preview <= 12 rowRanges: pbmc_granulocyte_ff_bc_ex.h5
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(1): TENxFile
## assays(1): counts
## rownames(10): ENSG00000243485 ENSG00000237613 ... ENSG00000286448
##   ENSG00000236601
## rowData names(3): ID Symbol Type
## colnames(10): AAACAGCCAAATATCC-1 AAACAGCCAGGAACTG-1 ...
##   AAACCGCGTGAGGTAG-1 AAACGCGCATACCCGG-1
## colData names(0):
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(0):
```

**Note**. Although the main representation in the package is
`SingleCellExperiment`, there could be a need for alternative data class
representations of the data. The `projection` field in the `TENxH5` show method
is an initial attempt to allow alternative representations.

## TENxMTX

Matrix Market formats are also supported (`.mtx` extension). These are typically
imported as SummarizedExperiment as they usually contain count data.

```
mtxf <- system.file(
    "extdata", "pbmc_3k_ff_bc_ex.mtx",
    package = "TENxIO", mustWork = TRUE
)
con <- TENxMTX(mtxf)
con
```

```
## TENxMTX object
## resource: /tmp/Rtmp1oKEpY/Rinst30f658170f626a/TENxIO/extdata/pbmc_3k_ff_bc_ex.mtx
```

## import MTX method

The `import` method yields a `SummarizedExperiment` without colnames or
rownames.

```
import(con)
```

```
## class: SummarizedExperiment
## dim: 171 10
## metadata(1): TENxFile
## assays(1): counts
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(0):
```

## TENxFileList

Generally, the 10X website will provide tarballs (with a `.tar.gz`
extension) which can be imported with the `TENxFileList` class. The tarball
can contain components of a gene expression experiment including the matrix
data, row data (aka ‘features’) expressed as Ensembl identifiers, gene symbols,
etc. and barcode information for the columns.

The `TENxFileList` class allows importing multiple files within a `tar.gz`
archive. The `untar` function with the `list = TRUE` argument shows all the file
names in the tarball.

```
fl <- system.file(
    "extdata", "pbmc_granulocyte_sorted_3k_ff_bc_ex_matrix.tar.gz",
    package = "TENxIO", mustWork = TRUE
)
untar(fl, list = TRUE)
```

```
## [1] "./pbmc_granulocyte_sorted_3k_filtered_feature_bc_matrix/filtered_feature_bc_matrix/"
## [2] "./pbmc_granulocyte_sorted_3k_filtered_feature_bc_matrix/filtered_feature_bc_matrix/barcodes.tsv.gz"
## [3] "./pbmc_granulocyte_sorted_3k_filtered_feature_bc_matrix/filtered_feature_bc_matrix/features.tsv.gz"
## [4] "./pbmc_granulocyte_sorted_3k_filtered_feature_bc_matrix/filtered_feature_bc_matrix/matrix.mtx.gz"
```

We then use the `import` method across all file types to obtain an integrated
Bioconductor representation that is ready for analysis. Files in `TENxFileList`
can be represented as a `SingleCellExperiment` with row names and column names.

```
con <- TENxFileList(fl)
import(con)
```

```
## class: SingleCellExperiment
## dim: 10 10
## metadata(1): TENxFileList
## assays(1): counts
## rownames(10): ENSG00000243485 ENSG00000237613 ... ENSG00000286448
##   ENSG00000236601
## rowData names(3): ID Symbol Type
## colnames(10): AAACAGCCAAATATCC-1 AAACAGCCAGGAACTG-1 ...
##   AAACCGCGTGAGGTAG-1 AAACGCGCATACCCGG-1
## colData names(0):
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(0):
```

## TENxPeaks

Peak files can be handled with the `TENxPeaks` class. These files are usually
named `*peak_annotation` files with a `.tsv` extension. Peak files are
represented as `GRanges`.

```
pfl <- system.file(
    "extdata", "pbmc_granulocyte_sorted_3k_ex_atac_peak_annotation.tsv",
    package = "TENxIO", mustWork = TRUE
)
tenxp <- TENxPeaks(pfl)
peak_anno <- import(tenxp)
peak_anno
```

```
## GRanges object with 10 ranges and 3 metadata columns:
##        seqnames        ranges strand |        gene  distance   peak_type
##           <Rle>     <IRanges>  <Rle> | <character> <numeric> <character>
##    [1]     chr1    9768-10660      * | MIR1302-2HG    -18894      distal
##    [2]     chr1 180582-181297      * |  AL627309.5     -6721      distal
##    [3]     chr1 181404-181887      * |  AL627309.5     -7543      distal
##    [4]     chr1 191175-192089      * |  AL627309.5    -17314      distal
##    [5]     chr1 267561-268455      * |  AP006222.2       707      distal
##    [6]     chr1 270864-271747      * |  AP006222.2      4010      distal
##    [7]     chr1 273947-274758      * |  AP006222.2      7093      distal
##    [8]     chr1 585751-586647      * |  AC114498.1      -982    promoter
##    [9]     chr1 629484-630393      * |  AC114498.1     41856      distal
##   [10]     chr1 633556-634476      * |  AC114498.1     45928      distal
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## TENxFragments

Fragment files are quite large and we make use of the `Rsamtools` package to
import them with the `yieldSize` parameter. By default, we use a `yieldSize` of
200.

```
fr <- system.file(
    "extdata", "pbmc_3k_atac_ex_fragments.tsv.gz",
    package = "TENxIO", mustWork = TRUE
)
```

Internally, we use the `TabixFile` constructor function to work with indexed
`tsv.gz` files.

**Note**. A warning is emitted whenever a `yieldSize` parameter is not set.

```
tfr <- TENxFragments(fr)
```

```
## Warning in TENxFragments(fr): Using default 'yieldSize' parameter
```

```
tfr
```

```
## TENxFragments object
## resource: /tmp/Rtmp1oKEpY/Rinst30f658170f626a/TENxIO/extdata/pbmc_3k_atac_ex_fragments.tsv.gz
```

Because there may be a variable number of fragments per barcode, we use a
`RaggedExperiment` representation for this file type.

```
fra <- import(tfr)
fra
```

```
## class: RaggedExperiment
## dim: 10 10
## assays(2): barcode readSupport
## rownames: NULL
## colnames(10): AAACCGCGTGAGGTAG-1 AAGCCTCCACACTAAT-1 ...
##   TGATTAGTCTACCTGC-1 TTTAGCAAGGTAGCTT-1
## colData names(0):
```

Similar operations to those used with `SummarizedExperiment` are supported. For
example, the genomic ranges can be displayed via `rowRanges`:

```
rowRanges(fra)
```

```
## GRanges object with 10 ranges and 0 metadata columns:
##        seqnames      ranges strand
##           <Rle>   <IRanges>  <Rle>
##    [1]     chr1 10152-10180      *
##    [2]     chr1 10152-10195      *
##    [3]     chr1 10080-10333      *
##    [4]     chr1 10091-10346      *
##    [5]     chr1 10152-10180      *
##    [6]     chr1 10152-10202      *
##    [7]     chr1 10097-10344      *
##    [8]     chr1 10080-10285      *
##    [9]     chr1 10090-10560      *
##   [10]     chr1 10074-10209      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# Session Information

Click to expand `sessionInfo()`

```
R version 4.5.2 (2025-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] rhdf5_2.54.1                TENxIO_1.12.1
 [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
 [5] Biobase_2.70.0              GenomicRanges_1.62.1
 [7] Seqinfo_1.0.0               IRanges_2.44.0
 [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
[11] generics_0.1.4              MatrixGenerics_1.22.0
[13] matrixStats_1.5.0           BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1        dplyr_1.1.4             blob_1.2.4
 [4] bitops_1.0-9            filelock_1.0.3          R.utils_2.13.0
 [7] Biostrings_2.78.0       RaggedExperiment_1.34.0 fastmap_1.2.0
[10] BiocFileCache_3.0.0     digest_0.6.39           lifecycle_1.0.4
[13] KEGGREST_1.50.0         RSQLite_2.4.5           magrittr_2.0.4
[16] compiler_4.5.2          rlang_1.1.6             sass_0.4.10
[19] tools_4.5.2             yaml_2.3.11             knitr_1.50
[22] S4Arrays_1.10.1         bit_4.6.0               curl_7.0.0
[25] DelayedArray_0.36.0     BiocParallel_1.44.0     abind_1.4-8
[28] HDF5Array_1.38.0        withr_3.0.2             purrr_1.2.0
[31] R.oo_1.27.1             grid_4.5.2              ExperimentHub_3.0.0
[34] Rhdf5lib_1.32.0         cli_3.6.5               rmarkdown_2.30
[37] crayon_1.5.3            otel_0.2.0              httr_1.4.7
[40] tzdb_0.5.0              BiocBaseUtils_1.12.0    DBI_1.2.3
[43] cachem_1.1.0            parallel_4.5.2          AnnotationDbi_1.72.0
[46] BiocManager_1.30.27     XVector_0.50.0          vctrs_0.6.5
[49] Matrix_1.7-4            jsonlite_2.0.0          bookdown_0.46
[52] hms_1.1.4               bit64_4.6.0-1           archive_1.1.12
[55] h5mread_1.2.1           jquerylib_0.1.4         glue_1.8.0
[58] codetools_0.2-20        BiocVersion_3.22.0      BiocIO_1.20.0
[61] tibble_3.3.0            pillar_1.11.1           rappdirs_0.3.3
[64] htmltools_0.5.9         rhdf5filters_1.22.0     R6_2.6.1
[67] dbplyr_2.5.1            httr2_1.2.2             vroom_1.6.7
[70] evaluate_1.0.5          lattice_0.22-7          readr_2.1.6
[73] AnnotationHub_4.0.0     Rsamtools_2.26.0        png_0.1-8
[76] R.methodsS3_1.8.2       memoise_2.0.1           bslib_0.9.0
[79] SparseArray_1.10.6      xfun_0.54               pkgconfig_2.0.3
```