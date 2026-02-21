# Introduction to AnVILBase

Bioconductor AnVIL SIG

#### October 29, 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Overview](#overview)
* [4 Cloud Platforms](#cloud-platforms)
  + [4.0.1 Developer Note](#developer-note)
* [5 Base generics](#base-generics)
* [6 Table generics](#table-generics)
* [7 Workspace generics](#workspace-generics)
* [8 Workflow generics](#workflow-generics)
* [9 Notebook generics](#notebook-generics)
* [10 sessionInfo](#sessioninfo)

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AnVILBase")
```

```
library(AnVILBase)
```

# 2 Introduction

The `AnVILBase` package defines S4 generics for AnVIL packages. The package is
designed to be used in conjunction with either `AnVILGCP` or `AnVILAz` packages.
The `AnVILBase` package is not intended to be used as a standalone package.

# 3 Overview

The `AnVILBase` package defines S4 generics for the AnVIL package. These
include methods for copying, listing, removing, and backing up files in the
cloud. All generics in the package have methods defined for ‘missing’ and ‘ANY’
signatures.

# 4 Cloud Platforms

The `AnVILBase` package is designed to support packages that work with the AnVIL
cloud platforms. Downstream packages expose Google Cloud Platform (AnVILGCP) and
the Azure Cloud Platform (AnVILAz) application programming interfaces (APIs).
To increase usability, the `AnVILBase` package attempts to deduce the user’s
cloud platform from environment variables. This is codified in the
`cloud_platform` function:

```
cloud_platform()
```

### 4.0.1 Developer Note

Packages that use the `AnVILBase` package can conditionally run tests using the
`avplatform_namespace()` function. It will return either `AnVILGCP` or `AnVILAz`
depending on the cloud environment variables that are set. If no environment
variables are set, the function will return `""`.

```
avplatform_namespace()
```

```
## [1] ""
```

# 5 Base generics

The following generics are defined in the `AnVILBase` package:

* `avcopy()`: Copy a file to and from the cloud
* `avlist()`: List files in the cloud storage location
* `avremove()`: Remove a file from the cloud
* `avbackup()`: Backup files to the cloud
* `avrestore()`: Restore files from the cloud
* `avstorage()`: Get the storage address in the cloud

# 6 Table generics

The following generics are defined in the `AnVILBase` package for tables:

* `avtable` : Get a table by name from a workspace
* `avtables` : List tables in the workspace(s)
* `avtable_import`: Upload a table to a workspace
* `avtable_import_set`: Create a set (grouped) table from an existing table
* `avtable_delete`: Remove a table from a workspace
* `avtable_delete_values`: Delete values from a table

# 7 Workspace generics

The following generics are defined in the `AnVILBase` package for workspaces:

* `avworkspace`: Set the active workspace
* `avworkspaces`: List current workspace(s) on AnVIL
* `avworkspace_name`: Get the workspace name
* `avworkspace_namespace`: Get the workspace namespace

Note that the `AnVILBase` package also includes helper functions that are
used across `AnVIL` cloud platforms. These include functions mainly for working
with the `AnVIL` API responses.

# 8 Workflow generics

The following generics are defined in the `AnVILBase` package for workflows:

* `avworkflow_jobs`: Get the execution status of a workflow

# 9 Notebook generics

The following generics are defined in the `AnVILBase` package for notebooks:

* `avnotebooks`: List notebooks in the workspace
* `avnotebooks_localize`: Download notebooks from a cloud to a workspace
* `avnotebooks_delocalize`: Upload notebooks from a workspace to a cloud

# 10 sessionInfo

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] AnVILBase_1.4.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         httr_1.4.7          cli_3.6.5
##  [4] knitr_1.50          rlang_1.1.6         xfun_0.53
##  [7] jsonlite_2.0.0      glue_1.8.0          htmltools_0.5.8.1
## [10] sass_0.4.10         rmarkdown_2.30      rappdirs_0.3.3
## [13] evaluate_1.0.5      jquerylib_0.1.4     tibble_3.3.0
## [16] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [19] httr2_1.2.1         bookdown_0.45       BiocManager_1.30.26
## [22] compiler_4.5.1      pkgconfig_2.0.3     digest_0.6.37
## [25] R6_2.6.1            pillar_1.11.1       magrittr_2.0.4
## [28] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```