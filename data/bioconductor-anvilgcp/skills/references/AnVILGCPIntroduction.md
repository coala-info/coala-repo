# Working with AnVIL on GCP

Nitesh Turaga1, Vincent Carey, BJ Stubbs, Marcel Ramos and Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*Martin.Morgan@RoswellPark.org

#### 16 November 2025

#### Package

AnVILGCP 1.4.1

# Contents

* [1 Installation](#installation)
  + [1.1 Additional Setup](#additional-setup)
  + [1.2 Use in the AnVIL cloud](#use-in-the-anvil-cloud)
  + [1.3 Local use](#local-use)
  + [1.4 Graphical interfaces](#graphical-interfaces)
  + [1.5 Working with Google cloud-based resources](#working-with-google-cloud-based-resources)
    - [Using `gcloud_*()` for account management](#using-gcloud_-for-account-management)
    - [Using `gsutil_*()` for file and bucket management](#using-gsutil_-for-file-and-bucket-management)
  + [1.6 Using `av*()` to work with AnVIL tables and data](#using-av-to-work-with-anvil-tables-and-data)
    - [Tables, reference data, and persistent files](#tables-reference-data-and-persistent-files)
    - [Using `avtable*()` for accessing tables](#using-avtable-for-accessing-tables)
    - [Using `avdata()` for accessing Workspace Data](#using-avdata-for-accessing-workspace-data)
    - [Using `avstorage()` and workspace files](#using-avstorage-and-workspace-files)
  + [1.7 Using `avnotebooks*()` for notebook management](#using-avnotebooks-for-notebook-management)
  + [1.8 Using `avworkflows_*()` for workflows](#using-avworkflows_-for-workflows)
  + [1.9 Using `avworkspace_*()` for workspaces](#using-avworkspace_-for-workspaces)
* [2 Session Info](#session-info)

# 1 Installation

Install the `AnVILGCP` package from Bioconductor with:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("AnVILGCP")
```

Once installed, load the package with

```
library(AnVILGCP)
```

## 1.1 Additional Setup

For reproducibility, it is advisable to install packages into libraries on a
project-specific basis, e.g., to create a ‘snapshot’ of packages for
reproducible analysis. Use

```
add_libpaths("~/my/project")
```

as a convenient way to prepend a project-specific library path to
`.libPaths()`. New packages will be installed into this library.

## 1.2 Use in the AnVIL cloud

In the AnVIL cloud environment, clone or create a new workspace. Click
on the `Cloud Environment` button at the top right of the
screen. Choose the `R / Bioconductor` runtime to use in a Jupyter
notebook, or `RStudio` to use in RStudio. When creating a Jupyter
notebook, choose `R` as the engine.

A new layout is being introduced in Fall of 2022. If the workspace has
an ‘Analyses’ tab, navigate to it and look for the ‘Environment
Configuration’ button to the right of the screen. For a Jupyter
notebook-based environment, select `jupyter` ‘Environment Settings’
followed by `Customize` and the `R / Bioconductor` application
configuration. *RStudio* is available by clicking on the `RStudio / Bioconductor` ‘Environment Settings’ button.

For tasks more complicated than manipulation and visualization of
tabular data (e.g., performing steps of a single-cell work flow) the
default Jupyter notebook configuration of 1 CPU and 3.75 GB of memory
will be insufficient; the RStudio image defaults to 4 CPU and 15 GB of
memory.

## 1.3 Local use

Local use requires that the gcloud SDK is installed, and that the
billing account used by AnVIL can be authenticated with the
user. These requirements are satisfied when using the AnVIL compute
cloud. For local use, one must

* [Install][install-gcloud-sdk] the gcloud sdk (for Linux and Windows,
  `cloudml::gcloud_install()` provides an alternative way to install
  gcloud).
* Define an environment variable or `option()` named `GCLOUD_SDK_PATH`
  pointing to the root of the SDK installation, e.g,

  ```
  dir(file.path(Sys.getenv("GCLOUD_SDK_PATH"), "bin"), "^(gcloud|gsutil)$")
  ## [1] "gcloud" "gsutil"
  ```

  Test the installation with `gcloud_exists()`

  ```
  ## the code chunks in this vignette are fully evaluated when
  ## gcloud_exists() returns TRUE
  gcloud_exists()
  ## Warning in lifeCycle(newpackage = "GCPtools", package = "AnVILGCP", cycle = "deprecated", : 'gcloud_exists' is deprecated.
  ##   Use 'GCPtools::gcloud_exists' instead.
  ##   See help('gcloud-deprecated').
  ## [1] FALSE
  ```

## 1.4 Graphical interfaces

Several commonly used functions have an additional ‘gadget’ interface,
allowing selection of workspaces (`avworkspace_gadget()`, DATA tables
(`avtable_gadget()`) and workflows `avworkflow_gadget()` using a
simple tabular graphical user interface. The `browse_workspace()`
function allows selection of a workspace to be opened as a browser
tab.

## 1.5 Working with Google cloud-based resources

The AnVIL package implements functions to facilitate access to Google
cloud resources.

### Using `gcloud_*()` for account management

The `gcloud_*()` family of functions provide access to Google cloud
functions implemented by the `gcloud` binary. `gcloud_project()`
returns the current billing account.

```
gcloud_account() # authentication account
gcloud_project() # billing project information
```

A convenient way to access *any* `gcloud` SDK command is to use
`gcloud_cmd()`, e.g.,

```
gcloud_cmd("projects", "list") |>
    readr::read_table() |>
    filter(startsWith(PROJECT_ID, "anvil"))
```

This translates into the command line `gcloud projects list`. Help is
also available within *R*, e.g.,

```
gcloud_help("projects")
```

Use `gcloud_help()` (with no arguments) for an overview of available
commands.

### Using `gsutil_*()` for file and bucket management

The `gsutil_*()` family of functions provides an interface to google
bucket manipulation. The following refers to publicly available 1000
genomes data available in Google Cloud Storage.

```
src <- "gs://genomics-public-data/1000-genomes/"
```

`gsutil_ls()` lists bucket content; `gsutil_stat()` additional detail
about fully-specified buckets.

```
avlist(src)

other <- paste0(src, "other")
avlist(other, recursive = TRUE)

sample_info <- paste0(src, "other/sample_info/sample_info.csv")
gsutil_stat(sample_info)
```

`gsutil_cp()` copies buckets from or to Google cloud storage; copying
to cloud storage requires write permission, of course. One or both of
the arguments can be cloud endpoints.

```
fl <- tempfile()
avcopy(sample_info, fl)

csv <- readr::read_csv(fl, guess_max = 5000L, col_types = readr::cols())
csv
```

`gsutil_pipe()` provides a streaming interface that does not require
intermediate disk storage.

```
pipe <- gsutil_pipe(fl, "rb")
readr::read_csv(pipe, guess_max = 5000L, col_types = readr::cols()) |>
    dplyr::select("Sample", "Family_ID", "Population", "Gender")
```

`gsutil_rsync()` synchronizes a local file hierarchy with a remote
bucket. This can be a powerful operation when `delete = TRUE`
(removing local or remote files), and has default option `dry = TRUE`
to indicate the consequences of the sync.

```
destination <- tempfile()
stopifnot(dir.create(destination))
source <- paste0(src, "other/sample_info")

## dry run
gsutil_rsync(source, destination)

gsutil_rsync(source, destination, dry = FALSE)
dir(destination, recursive = TRUE)

## nothing to synchronize
gsutil_rsync(source, destination, dry = FALSE)

## one file requires synchronization
unlink(file.path(destination, "README"))
gsutil_rsync(source, destination, dry = FALSE)
```

`localize()` and `delocalize()` provide ‘one-way’
synchronization. `localize()` moves the content of the `gs://`
`source` to the local file system. `localize()` could be used at the
start of an analysis to retrieve data stored in the google cloud to
the local compute instance. `delocalize()` performs the complementary
operation, copying local files to a `gs://` destination. The `unlink = TRUE` option to `delocalize()` unlinks local `source` files
recursively. It could be used at the end of an analysis to move
results to the cloud for long-term persistent storage.

## 1.6 Using `av*()` to work with AnVIL tables and data

### Tables, reference data, and persistent files

AnVIL organizes data and analysis environments into
‘workspaces’. AnVIL-provided data resources in a workspace are managed
under the ‘DATA’ tab as ‘TABLES’, ‘REFERENCE DATA’, and ‘OTHER DATA’;
the latter includes ‘’Workspace Data’ and ‘Files’, with ‘Files’
corresponding to a Google Cloud Bucket associated with the
workspace. These components of the graphical user interface are
illustrated in the figure below.

The AnVIL package provides programmatic tools to access different
components of the data workspace, as summarized in the following
table.

| Workspace | AnVIL function |
| --- | --- |
| TABLES | `avtables()` |
| REFERENCE DATA | None |
| OTHER DATA | `avstorage()` |
| Workspace Data | `avdata()` |
| Files | `avlist()`, `avbackup()`, `avrestore()` |

Data tables in a workspace are available by specifying the `namespace`
(billing account) and `name` (workspace name) of the workspace. When
on the AnVIL in a Jupyter notebook or RStudio, this information can be
discovered with

```
avworkspace_namespace()
avworkspace_name()
```

It is also possible to specify, when not in the AnVIL compute
environment, the data resource to work with.

```
## N.B.: IT MAY NOT BE NECESSARY TO SET THESE WHEN ON ANVIL
avworkspace_namespace("pathogen-genomic-surveillance")
avworkspace_name("COVID-19")
```

### Using `avtable*()` for accessing tables

Accessing data tables use the `av*()` functions. Use `avtables()` to
discover available tables, and `avtable()` to retrieve a particular
table

```
avtables()
sample <- avtable("sample_set")
sample
```

The data in the table can then be manipulated using standard *R*
commands, e.g., to identify SRA samples for which a final assembly
fasta file is available.

```
sample |>
    dplyr::select("sample_set_id", contains("fasta")) |>
    dplyr::filter(!is.na("Successful_Assembly_group"))
```

Users can easily add tables to their own workspace using
`avtable_import()`, perhaps as the final stage of a pipe

```
my_cars <-
    mtcars |>
    as_tibble(rownames = "model") |>
    mutate(model = gsub(" ", "_", model))
job_status <- avtable_import(my_cars)
```

Tables are imported ‘asynchronously’, and large tables (more than 1.5
million elements; see the `pageSize` argument) are uploaded in
pages. The `job status` is a tibble summarizing each page; the status
of the upload can be checked with

```
avtable_import_status(job_status)
```

The transcript of a session where page size is set intentionally small
for illustration is

```
(job_status <- avtable_import(my_cars, pageSize = 10))
## pageSize = 10 rows (4 pages)
##   |======================================================================| 100%
## # A tibble: 4 × 5
##    page from_row to_row job_id                               status
##   <int>    <int>  <int> <chr>                                <chr>
## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Uploaded
## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Uploaded
## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 Uploaded
## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 Uploaded
(job_status <- avtable_import_status(job_status))
## checking status of 4 avtable import jobs
##   |======================================================================| 100%
## # A tibble: 4 × 5
##    page from_row to_row job_id                               status
##   <int>    <int>  <int> <chr>                                <chr>
## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Done
## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Done
## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 ReadyForUpsert
## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 ReadyForUpsert
(job_status <- avtable_import_status(job_status))
## checking status of 4 avtable import jobs
##   |======================================================================| 100%
## # A tibble: 4 × 5
##    page from_row to_row job_id                               status
##   <int>    <int>  <int> <chr>                                <chr>
## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Done
## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Done
## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 Done
## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 Done
```

The Terra data model allows for tables that represent samples of other
tables. The following create or add rows to `participant_set` and
`sample_set` tables. Each row represents a sample from the
corresponding ‘origin’ table.

```
## editable copy of '1000G-high-coverage-2019' workspace
avworkspace("anvil-datastorage/1000G-high-coverage-2019")
sample <-
    avtable("sample") |>                               # existing table
    mutate(set = sample(head(LETTERS), nrow(.), TRUE))  # arbitrary groups
sample |>                                   # new 'participant_set' table
    avtable_import_set("participant", "set", "participant")
sample |>                                   # new 'sample_set' table
    avtable_import_set("sample", "set", "name")
```

The `TABLES` data in a workspace are usually provided as curated
results from AnVIL. Nonetheless, it can sometimes be useful to delete
individual rows from a table. Use `avtable_delete_values()`.

### Using `avdata()` for accessing Workspace Data

The ‘Workspace Data’ is accessible through `avdata()` (the example
below shows that some additional parsing may be necessary).

```
avdata()
```

### Using `avstorage()` and workspace files

Each workspace is associated with a google bucket, with the content
summarized in the ‘Files’ portion of the workspace. The location of
the files is

```
bucket <- avstorage()
bucket
```

The content of the bucket can be viewed with (if permissions allow)

```
avlist()
```

If the workspace is owned by the user, then persistent data can be
written to the bucket.

```
## requires workspace ownership
uri <- avstorage()                             # discover bucket
bucket <- file.path(uri, "mtcars.tab")
write.table(mtcars, gsutil_pipe(bucket, "w")) # write to bucket
```

A particularly convenient operation is to back up files or directories
from the compute node to the bucket

```
## backup all files and folders in the current working directory
avbackup(getwd(), recursive = TRUE)

## backup all files in the current directory
avbackup(dir())

## backup all files to gs://<avstorage()>/scratch/
avbackup(dir, paste0(avstorage(), "/scratch"))
```

Note that the backup operations have file naming behavior like the
Linux `cp` command; details are described in the help page
`gsutil_help("cp")`.

Use `avrestore()` to restore files or directories from the
workspace bucket to the compute node.

## 1.7 Using `avnotebooks*()` for notebook management

Python (`.ipynb`) or R (`.Rmd`) notebooks are associated with
individual workspaces under the DATA tab, `Files/notebooks`
location.

Jupyter notebooks are exposed through the Terra interface under the
NOTEBOOKS tab, and are automatically synchronized between the
workspace and the current runtime.

R markdown documents may also be associated with the workspace (under
DATA `Files/notebooks`) but are not automatically synchronized with
the current runtime. The functions in this section help manage R
markdown documents.

Available notebooks in the workspace are listed with
`avnotebooks()`. Copies of the notebooks on the current runtime are
listed with `avnotebooks(local = TRUE)`. The default location of the
notebooks is `~/<avworkspace_name()>/notebooks/`.

Use `avnotebooks_localize()` to synchronize the version of the
notebooks in the workspace to the current runtime. This operation
might be used when a new runtime is created, and one wishes to start
with the notebooks found in the workspace. If a newer version of the
notebook exists in the workspace, this will overwrite the older
version on the runtime, potentially causing data loss. For this
reason, `avnotebooks_localize()` by default reports the actions that
will be performed, without actually performing them. Use
`avnotebooks_localize(dry = FALSE)` to perform the localization.

Use `avnotebooks_delocalize()` to synchronize local versions of the
notebooks on the current runtime to the workspace. This operation
might be used when developing a workspace, and wishing to update the
definitive notebook in the workspace. When `dry = FALSE`, this
operation also overwrites older workspace notebook files with their
runtime version.

## 1.8 Using `avworkflows_*()` for workflows

See the vignette “Running an AnVIL workflow within R”, in this
package, for details on running workflows and managing output.

## 1.9 Using `avworkspace_*()` for workspaces

`avworkspace()` is used to define or return the ‘namespace’ (billing
project) and ‘name’ of the workspace on which operations are to
act. `avworkspace_namespace()` and `avworkspace_name()` can be used to
set individual elements of the workspace.

`avworkspace_clone()` clones a workspace to a new location. The clone
includes the ‘DATA’, ‘NOTEBOOK’, and ‘WORKFLOWS’ elements of the
workspace.

# 2 Session Info

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
## [1] AnVILGCP_1.4.1   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5          httr_1.4.7           cli_3.6.5
##  [4] knitr_1.50           rlang_1.1.6          xfun_0.54
##  [7] purrr_1.2.0          generics_0.1.4       jsonlite_2.0.0
## [10] glue_1.8.0           htmltools_0.5.8.1    BiocBaseUtils_1.12.0
## [13] sass_0.4.10          rmarkdown_2.30       rappdirs_0.3.3
## [16] GCPtools_1.0.0       evaluate_1.0.5       jquerylib_0.1.4
## [19] tibble_3.3.0         fastmap_1.2.0        yaml_2.3.10
## [22] lifecycle_1.0.4      httr2_1.2.1          bookdown_0.45
## [25] BiocManager_1.30.27  compiler_4.5.1       codetools_0.2-20
## [28] dplyr_1.1.4          pkgconfig_2.0.3      tidyr_1.3.1
## [31] digest_0.6.38        R6_2.6.1             tidyselect_1.2.1
## [34] pillar_1.11.1        magrittr_2.0.4       bslib_0.9.0
## [37] tools_4.5.1          AnVILBase_1.4.0      cachem_1.1.0
```