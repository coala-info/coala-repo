# terraTCGAdata Introduction

Marcel Ramos

#### October 30, 2025

# Contents

* [1 terraTCGAData](#terratcgadata)
  + [1.1 Installation](#installation)
* [2 Overview](#overview)
  + [2.1 Data](#data)
* [3 Requirements](#requirements)
  + [3.1 Loading packages](#loading-packages)
  + [3.2 gcloud sdk installation](#gcloud-sdk-installation)
* [4 Default Data Workspace](#default-data-workspace)
* [5 Clinical data resources](#clinical-data-resources)
* [6 Clinical data download](#clinical-data-download)
* [7 Assay data resources](#assay-data-resources)
* [8 Summary of sample types in the data](#summary-of-sample-types-in-the-data)
* [9 Intermediate function for obtaining only the data](#intermediate-function-for-obtaining-only-the-data)
* [10 MultiAssayExperiment](#multiassayexperiment)
* [11 Session Info](#session-info)

# 1 terraTCGAData

## 1.1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("terraTCGAdata")
```

# 2 Overview

The `terraTCGAdata` R package aims to import TCGA datasets, as
[MultiAssayExperiment](http://bioconductor.org/packages/MultiAssayExperiment/),
available on the Terra platform. The package provides a set of
functions that allow the discovery of relevant datasets. It provides
one main function and two helper functions:

1. `terraTCGAdata` allows the creation of the `MultiAssayExperiment` object
   from the different indicated resources.
2. The `getClinicalTable` and `getAssayTable` functions allow for the
   discovery of datasets within the Terra data model. The column names
   from these tables can be provided as inputs to the `terraTCGAdata`
   function.

## 2.1 Data

Some public Terra workspaces come pre-packaged with TCGA data (i.e., cloud data
resources are linked within the data model). Particularly the workspaces that
are labelled `OpenAccess_V1-0`. Datasets harmonized to the hg38 genome, such as
those from the Genomic Data Commons data repository, use a different data model
/ workflow and are not compatible with the functions in this package. For those
that are, we make use of the Terra data model and represent the data as
`MultiAssayExperiment`.

For more information on `MultiAssayExperiment`, please see the vignette in
that package.

# 3 Requirements

## 3.1 Loading packages

```
library(AnVIL)
library(terraTCGAdata)
```

## 3.2 gcloud sdk installation

A valid GCloud SDK installation is required to use the package. To get set up,
see the Bioconductor tutorials for running RStudio on Terra. Use the
`gcloud_exists()` function from the *[AnVIL](https://bioconductor.org/packages/3.22/AnVIL)* package to
identify whether it is installed in your system.

```
gcloud_exists()
```

```
## Warning in lifeCycle(newpackage = "GCPtools", package = "AnVILGCP", cycle = "deprecated", : 'gcloud_exists' is deprecated.
##   Use 'GCPtools::gcloud_exists' instead.
##   See help('gcloud-deprecated').
```

```
## [1] FALSE
```

You can also use the `gcloud_project` to set a project name by specifying
the project argument:

```
gcloud_project()
```

# 4 Default Data Workspace

To get a table of available TCGA workspaces, use the `selectTCGAworkspace()`
function:

```
selectTCGAworkspace()
```

You can also set the package-wide option with the `terraTCGAworkspace` function
and check the setting with `getOption('terraTCGAdata.workspace')` or by running
`terraTCGAworkspace` function.

```
terraTCGAworkspace("TCGA_COAD_OpenAccess_V1-0_DATA")
getOption("terraTCGAdata.workspace")
```

# 5 Clinical data resources

In order to determine what datasets to download, use the `getClinicalTable`
function to list all of the columns that correspond to clinical data
from the different collection centers.

```
ct <- getClinicalTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")
ct
names(ct)
```

# 6 Clinical data download

After picking the column in the `getClinicalTable` output, use the column
name as input to the `getClinical` function to obtain the data:

```
column_name <- "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin"
clin <- getClinical(
    columnName = column_name,
    participants = TRUE,
    workspace = "TCGA_COAD_OpenAccess_V1-0_DATA"
)
clin[, 1:6]
dim(clin)
```

# 7 Assay data resources

We use the same approach for assay data. We first produce a list of assays
from the `getAssayTable` and then we select one along with any sample
codes of interest.

```
at <- getAssayTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")
at
names(at)
```

# 8 Summary of sample types in the data

You can get a summary table of all the samples in the adata by using the
`sampleTypesTable`:

```
sampleTypesTable(workspace = "TCGA_COAD_OpenAccess_V1-0_DATA")
```

# 9 Intermediate function for obtaining only the data

Note that if you have the package-wide option set, the workspace argument
is not needed in the function call.

```
prot <- getAssayData(
    assayName = "protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
    sampleCode = c("01", "10"),
    workspace = "TCGA_COAD_OpenAccess_V1-0_DATA",
    sampleIdx = 1:4
)
head(prot)
```

# 10 MultiAssayExperiment

Finally, once you have collected all the relevant column names,
these can be inputs to the main `terraTCGAdata` function:

```
mae <- terraTCGAdata(
    clinicalName = "clin__bio__nationwidechildrens_org__Level_1__biospecimen__clin",
    assays =
        c("protein_exp__mda_rppa_core__mdanderson_org__Level_3__protein_normalization__data",
        "rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data"),
    sampleCode = NULL,
    split = FALSE,
    sampleIdx = 1:4,
    workspace = "TCGA_COAD_OpenAccess_V1-0_DATA"
)
mae
```

We expect that most `OpenAccess_V1-0` cancer datasets follow this data model.
If you encounter any errors, please provide a minimally reproducible example
at <https://github.com/waldronlab/terraTCGAdata>.

# 11 Session Info

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
##  [1] terraTCGAdata_1.14.0        MultiAssayExperiment_1.36.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] AnVILGCP_1.4.0              AnVIL_1.22.0
## [15] AnVILBase_1.4.0             dplyr_1.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.53            bslib_0.9.0          httr2_1.2.1
##  [4] htmlwidgets_1.6.4    lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          tibble_3.3.0         pkgconfig_2.0.3
## [10] BiocBaseUtils_1.12.0 rapiclient_0.1.8     Matrix_1.7-4
## [13] lifecycle_1.0.4      compiler_4.5.1       codetools_0.2-20
## [16] httpuv_1.6.16        htmltools_0.5.8.1    sass_0.4.10
## [19] yaml_2.3.10          later_1.4.4          pillar_1.11.1
## [22] jquerylib_0.1.4      tidyr_1.3.1          GCPtools_1.0.0
## [25] DT_0.34.0            cachem_1.1.0         DelayedArray_0.36.0
## [28] abind_1.4-8          mime_0.13            tidyselect_1.2.1
## [31] digest_0.6.37        purrr_1.1.0          bookdown_0.45
## [34] fastmap_1.2.0        grid_4.5.1           SparseArray_1.10.0
## [37] cli_3.6.5            magrittr_2.0.4       S4Arrays_1.10.0
## [40] promises_1.4.0       rappdirs_0.3.3       XVector_0.50.0
## [43] rmarkdown_2.30       lambda.r_1.2.4       httr_1.4.7
## [46] otel_0.2.0           futile.logger_1.4.3  shiny_1.11.1
## [49] evaluate_1.0.5       knitr_1.50           miniUI_0.1.2
## [52] rlang_1.1.6          futile.options_1.0.1 Rcpp_1.1.0
## [55] xtable_1.8-4         glue_1.8.0           BiocManager_1.30.26
## [58] formatR_1.14         jsonlite_2.0.0       R6_2.6.1
```