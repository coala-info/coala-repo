# Using a MySQL server backend

Johannes Rainer

#### 29 October 2025

#### Package

ensembldb 2.34.0

# 1 Introduction

`ensembldb` uses by default, similar to other annotation packages in Bioconductor,
a SQLite database backend, i.e. annotations are retrieved from file-based SQLite
databases that are provided *via* packages, such as the `EnsDb.Hsapiens.v86`
package. In addition, `ensembldb` allows to switch the backend from SQLite to
MariaDB/MySQL and thus to retrieve annotations from a MySQL server instead. Such
a setup might be useful for a lab running a well-configured MySQL server that
would require installation of EnsDb databases only on the database server and
not on the individual clients.

**Note** the code in this document is not executed during vignette generation as
this would require access to a MySQL server.

# 2 Using `ensembldb` with a MySQL server

Installation of `EnsDb` databases in a MySQL server is straight forward - given
that the user has write access to the server:

```
library(ensembldb)
## Load the EnsDb package that should be installed on the MySQL server
library(EnsDb.Hsapiens.v86)

## Call the useMySQL method providing the required credentials to create
## databases and inserting data on the MySQL server
edb_mysql <- useMySQL(EnsDb.Hsapiens.v86, host = "localhost",
                      user = "userwrite", pass = "userpass")

## Use this EnsDb object
genes(edb_mysql)
```

To use an `EnsDb` in a MySQL server without the need to install the corresponding
R-package, the connection to the database can be passed to the `EnsDb` constructor
function. With the resulting `EnsDb` object annotations can be retrieved from the
MySQL database.

```
library(ensembldb)
library(RMariaDB)

## Connect to the MySQL database to list the databases.
dbcon <- dbConnect(MariaDB(), host = "localhost", user = "readonly",
                   pass = "readonly")

## List the available databases
listEnsDbs(dbcon)

## Connect to one of the databases and use that one.
dbcon <- dbConnect(MariaDB(), host = "localhost", user = "readonly",
                   pass = "readonly", dbname = "ensdb_hsapiens_v75")
edb <- EnsDb(dbcon)
edb
```

# 3 Session information

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```