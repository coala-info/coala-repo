# An Overview of the BiocIO package

Daniel Van Twisk1 and Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*maintainer@biocondcutor.org

#### 29 October 2025

#### Abstract

BiocIO contains defintions for import and export methods used throughout
Biocondcutor for IO purposes. The BiocFile class which serves as an interface
for File classes within Bioconductor is also defined in this package. This
vignette will describe the functionality of these base methods and classes as
well as an example for developers on how to interface with them.

#### Package

BiocIO 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Import and Export](#import-and-export)
  + [2.2 The BiocFile Class](#the-biocfile-class)
  + [2.3 CompressedFile](#compressedfile)
* [3 For developers](#for-developers)
  + [3.1 Converting existing “File” Classes](#converting-existing-file-classes)
  + [3.2 Creating classes and methods that extend BiocFile’s class and methods](#creating-classes-and-methods-that-extend-biocfiles-class-and-methods)
  + [Session info](#session-info)

# 1 Introduction

The `BiocIO` package is primarily to be used by developers for interfacing with
the abstract classes and generics in this package to develop their own related
classes and methods.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BiocIO")
```

```
library("BiocIO")
```

## 2.1 Import and Export

The functions import and export load and save objects from and to particular
file formats. This package contains the following generics for the import
and export methods used throughout the Bioconductor package suite.

```
getGeneric("import")
```

```
## standardGeneric for "import" defined from package "BiocIO"
##
## function (con, format, text, ...)
## standardGeneric("import")
## <bytecode: 0x5b687262d8a0>
## <environment: 0x5b687281ddd0>
## Methods may be defined for arguments: con, format, text
## Use  showMethods(import)  for currently available ones.
```

```
getGeneric("export")
```

```
## standardGeneric for "export" defined from package "BiocIO"
##
## function (object, con, format, ...)
## standardGeneric("export")
## <bytecode: 0x5b6872b5a100>
## <environment: 0x5b6872b6f9a0>
## Methods may be defined for arguments: object, con, format
## Use  showMethods(export)  for currently available ones.
```

## 2.2 The BiocFile Class

`BiocFile` is a base class for high-level file abstractions, where subclasses
are associated with a particular file format/type. It wraps a low-level
representation of a file, currently either a path/URL or connection.

## 2.3 CompressedFile

`CompressedFile` is a base class that extends the `BiocFile` class that offers
high-level file abstractions for compressed file formats. As with the `BiocFile`
class, it takes either a path/URL of connection as an argument. This package
also includes other File classes that extend `CompressedFile` including:
`BZ2File`, `XZFile`, `GZFile`, and `BGZFile` which extends the `GZfile` class

# 3 For developers

## 3.1 Converting existing “File” Classes

In previous releases, `rtracklayer` package’s `RTLFile`, `RTLList`, and
`CompressedFile` classes threw errors when a class that extended them was
initialized. The error could have been seen with the `LoomFile` class from
`LoomExperiment`.

```
file <- tempfile(fileext = ".loom")
LoomFile(file)

### LoomFile object
### resource: file.loom
### Warning messages:
### 1: This class is extending the deprecated RTLFile class from
###     rtracklayer. Use BiocFile from BiocIO in place of RTLFile.
### 2: Use BiocIO::resource()
```

The first warning indicated that the `RTLFile` class from `rtracklayer` was
deprecated for future releases. The second warning indicated that the
`resource` method from `rtracklayer` was moved to `BiocIO`.

To resolve this issue, developers should simply replace the `contains="RTLFile"`
argument in `setClass` with `contains="BiocFile"`.

```
## Old
setClass('LoomFile', contains='RTLFile')

## New
setClass('LoomFile', contains='BiocFile')
```

## 3.2 Creating classes and methods that extend BiocFile’s class and methods

The primary purpose of this package is to provide high-level classes and
generics to facilitate file IO within the Bioconductor package suite. The
remainder of this vignette will detail how to create File classes that extend
the `BiocFile` class and create methods for these classes. This section will
also detail using the filter and select methods from the tidyverse dplyr package
to facilitate lazy operations on files.

The `CSVFile` class defined in this package will be used as an example. The
purpose of the `CSVFile` class is to represent `CSVFile` so that IO operations
can be performed on the file. The following code defines the `CSVFile` class
that extends the `BiocFile` class using the `contains` argument. The `CSVFile`
function is used as a constructor function requiring only the argument
`resource` (either a `character` or a `connection`).

```
.CSVFile <- setClass("CSVFile", contains = "BiocFile")

CSVFile <- function(resource) .CSVFile(resource = resource)
```

Next, the import and export functions are defined. These functions are meant to
import the data into R in a usable format (a `data.frame` or another
user-friendly R class), then export that R object into a file. For the `CSVFile`
example, the base `read.csv()` and `write.csv()` functions are used as the body
for our methods.

```
setMethod("import", "CSVFile", function(con, format, text, ...) {
    read.csv(resource(con), ...)
})

setMethod("export", c("data.frame", "CSVFile"),
    function(object, con, format, ...) {
        write.csv(object, resource(con), ...)
    }
)
```

And finally a demonstration of the `CSVFile` class and import/export methods in
action.

```
temp <- tempfile(fileext = ".csv")
csv <- CSVFile(temp)

export(mtcars, csv)
df <- import(csv)
```

## Session info

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
## [1] BiocIO_1.20.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          BiocGenerics_0.56.0 htmltools_0.5.8.1
## [10] generics_0.1.4      rmarkdown_2.30      stats4_4.5.1
## [13] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [16] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [19] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [22] BiocManager_1.30.26 S4Vectors_0.48.0    jsonlite_2.0.0
## [25] rlang_1.1.6
```