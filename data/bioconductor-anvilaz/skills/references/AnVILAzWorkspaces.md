Code

* Show All Code
* Hide All Code

# Working with workspaces on AnVIL Azure

Marcel Ramos1\* and Martin Morgan1\*\*

1Roswell Park Comprehensive Cancer Center

\*marcel.ramos@sph.cuny.edu
\*\*Martin.Morgan@RoswellPark.org

#### 29 October 2025

#### Package

AnVILAz 1.4.0

```
library(AnVILAz)
```

# 1 Workspaces

Workspaces on AnVIL Azure are a way to organize and manage data and analysis
resources. Workspaces are created by users and can be shared with other users.

## 1.1 Listing workspaces

The `avworkspaces()` function lists the workspaces available to the current
user.

```
avworkspaces()
```

## 1.2 Caveats

Workspaces on AnVIL are managed resources and do not provide a lot of freedom
to work across workspaces. The `AnVILAz` package mainly provides functions to
work with workspaces within the same namespace.

There may be some workspaces that still operate using the Google Cloud Platform
(GCP) and these workspaces are not accessible through the `AnVILAz` package
though they may be listed in `avworkspaces()`. We refer users to `AnVILGCP`
for working with GCP-based workspaces.

## 1.3 Current workspace

The `avworkspace()` function returns the name of the current workspace provided
that it is set.

```
avworkspace()
```

## 1.4 Setting the current workspace

The `avworkspace()` function can be used to set the current workspace.

```
avworkspace("my-namespace/my-workspace")
avworkspace()
```

Typically this is not necessary as these values can be gathered from the
AnVIL Azure environment.

## 1.5 Namespace and workspace

The `avworkspace_namespace()` and `avworkspace_name()` functions return the
namespace and name of the current workspace.

```
avworkspace_namespace()
```

```
avworkspace_name()
```

# 2 Cloning a workspace

The `avworkspace_clone()` function clones a workspace.

```
avworkspace_clone(
    namespace = "my-namespace",
    name = "my-workspace",
    to_namespace = "my-new-namespace",
    to_name = "my-workspace-clone"
)
avworkspaces()
```

Note that currently, the `createdBy` field is not populated with the user’s
information. This is a known issue and will be addressed in a future release.

# 3 Deleting a workspace

To delete a workspace, it is recommended to use the AnVIL Azure interface.

# 4 Notebooks

Notebooks are a way to interact with the data and analysis resources in a
workspace. The `avnotebooks()` function lists the notebooks available in the
current workspace.

```
avnotebooks()
```

Typically, notebooks are kept on the Azure Blob Storage (ABS) Container in a
`analyses/` folder.

## 4.1 Localize / Delocalize

The `avnotebooks_localize()` function downloads a notebook to the local
filesystem. By default, it will download all the notebooks located in the
`analyses/` folder to a matching `analyses` local folder. Note that this is a
convenience function for `avcopy` file transfer operations.

```
avnotebooks_localize(destination = "./analyses")
```

On the other hand, the `avnotebooks_delocalize()` function uploads all the
notebooks within the given directory (by default, the current directory) to the
Azure Blob Storage Container. It places them in the `analyses/` folder on
the ABS Container.

```
avnotebooks_delocalize(source = "./")
```

# 5 Workflows

## 5.1 Listing current workflow runs

The `avworkflows_jobs()` function reports the status of the current workflows
within the workspace.

```
avworkflows_jobs()
```

It provides a tibble with workflow information such as the `run_set_id`,
`run_set_name`, `submission_timestamp`, `error_count`, `run_count`, `state`,
etc.

## 5.2 Listing workflow inputs

The `avworkflows_jobs_inputs()` function lists the inputs for a given workflow.
It returns a list of `tibbles` with the inputs for each workflow within the
current workspace.

```
avworkflows_jobs_inputs()
```

# 6 sessionInfo

```
sessionInfo()
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
## [1] AnVILAz_1.4.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5          httr_1.4.7           cli_3.6.5
##  [4] knitr_1.50           rlang_1.1.6          xfun_0.53
##  [7] jsonlite_2.0.0       glue_1.8.0           rjsoncons_1.3.2
## [10] htmltools_0.5.8.1    BiocBaseUtils_1.12.0 sass_0.4.10
## [13] rmarkdown_2.30       rappdirs_0.3.3       evaluate_1.0.5
## [16] jquerylib_0.1.4      tibble_3.3.0         fastmap_1.2.0
## [19] yaml_2.3.10          lifecycle_1.0.4      httr2_1.2.1
## [22] bookdown_0.45        BiocManager_1.30.26  compiler_4.5.1
## [25] pkgconfig_2.0.3      digest_0.6.37        R6_2.6.1
## [28] pillar_1.11.1        magrittr_2.0.4       bslib_0.9.0
## [31] tools_4.5.1          AnVILBase_1.4.0      cachem_1.1.0
```