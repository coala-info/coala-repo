Code

* Show All Code
* Hide All Code

# Introduction to the AnVILAz package

Marcel Ramos1\* and Martin Morgan1\*\*

1Roswell Park Comprehensive Cancer Center

\*marcel.ramos@sph.cuny.edu
\*\*Martin.Morgan@RoswellPark.org

#### 29 October 2025

#### Package

AnVILAz 1.4.0

# 1 Installation

The package is not yet available from [Bioconductor](https://bioconductor.org).

Install the development version of the *AnVILAz* package from GitHub
with

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install("Bioconductor/AnVILAz")
```

Once installed, load the package with

```
library(AnVILAz)
```

# 2 File Management

For this tutorial we will refer to the Azure Blob Storage service as ABS.
Within the ABS, we are given access to a Container. For more information,
follow this [link](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction#containers)
to Microsoft’s definition of containers and blobs.

## 2.1 List Azure Blob Storage Container Files

```
avlist()
```

The `avlist` command corresponds to a view of the files in the Blob
container on Azure. They can also be accessed via the
[Microsoft Azure Storage Explorer](https://azure.microsoft.com/en-us/products/storage/storage-explorer).

![](data:image/png;base64...)

Azure Storage Explorer

## 2.2 Uploading a file

As an example, we load the internal `mtcars` dataset and save it as an `.Rda`
file with `save`. We can then upload this file to the ABS.

```
data("mtcars", package = "datasets")
test <- head(mtcars)
save(test, file = "mydata.Rda")
```

Now we can upload the data to the `analyses/` folder in the Azure Blob Storage
(ABS) Container.

```
avcopy("mydata.Rda", "analyses/")
```

We can also use a small log file for demonstration purposes. The `jupyter.log`
file is already present in our workspace directory.

```
avcopy("jupyter.log", "analyses/")
```

## 2.3 Deleting a file

We can remove the data with `avremove` and the *relative* path to the `.Rda`
file.

```
avremove("analyses/mydata.Rda")
```

## 2.4 Downloading from the ABS

The reverse operation is also possible with a remote and local paths as the
first and second arguments, respectively.

```
avcopy("analyses/jupyter.log", "./test/")
```

## 2.5 Folder-wise upload to ABS

To upload an entire folder, we can use `avbackup`. Note that the entire `test`
folder becomes a subfolder of the remote `analyses` folder in this example.

```
avbackup("./test/", "analyses/")
```

## 2.6 Folder-wise download from ABS

By default, the entire `source` directory will be copied to the current working
directory `"."`, i.e., the base workspace directory.

```
avrestore("analyses/test")
```

You may also move this to another folder by providing a folder name as the
second argument.

```
avrestore("analyses/test", "test")
```

# 3 The `DATA` tab

## 3.1 `mtcars` example

First we create an example dataset for uploading to the `DATA` tab. We create a
`model_id` column from the `rownames`.

```
library(dplyr)
mtcars_tbl <-
    mtcars |>
    as_tibble(rownames = "model_id") |>
    mutate(model_id = gsub(" ", "-", model_id))
```

## 3.2 Uploading data

The `avtable_import` command takes an existing R object (usually a `tibble`) and
uploads to the `DATA` tab in the AnVIL User Interface. The `table` argument will
set the name of the table. We also need to provide the `primaryKey` which
corresponds to the column name that uniquely identifies each row in the data.
Typically, the `primaryKey` column provides a list of patient or UUID
identifiers and is in the first column of the data.

```
mtcars_tbl |> avtable_import(table = "testData", primaryKey = "model_id")
```

## 3.3 Downloading data

The `avtable` function will pull the data from the `DATA` tab and represent the
data locally as a `tibble`. It works by using the same `type` identifier (i.e.,
the `table` argument) that was used when the data was uploaded.

```
model_data <- avtable(table = "testData")
head(model_data)
```

## 3.4 Delete a row in the table

The API allows deletion of specific rows in the data using
`avtable_delete_values`. To indicate which row to delete, provide the a value or
set of values that correspond to row identifiers in the `primaryKey`. In this
example, we remove the `AMC-Javelin` entry from the data. We are left with 31
records.

```
avtable_delete_values(table = "testData", values = "AMC-Javelin")
```

## 3.5 Delete entire table

To remove the entire table from the `DATA` tab, we can use the `avtable_delete`
method with the corresponding table name.

```
avtable_delete(table = "testData")
```

# 4 Bug Reports

If you experience issues, please feel free to contact us with a reproducible
example on GitHub:

<https://github.com/Bioconductor/AnVILAz/issues>

# Session information

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