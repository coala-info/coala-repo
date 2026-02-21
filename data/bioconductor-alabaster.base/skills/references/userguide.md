# Saving objects to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 1, 2024

#### Package

alabaster.base 1.10.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick start](#quick-start)
* [3 Class-specific methods](#class-specific-methods)
* [4 Operating on directories](#operating-on-directories)
* [5 Extending to new classes](#extending-to-new-classes)
* [6 Creating applications](#creating-applications)
* [Session information](#session-information)

# 1 Introduction

The *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* package (and its family) implements methods to save common Bioconductor objects to file artifacts and load them back into R.
This aims to provide a functional equivalent to RDS-based serialization that is:

* More stable to changes in the class definition.
  Such changes would typically require costly `updateObject()` operations at best, or invalidate RDS files at worst.
* More interoperable with other analysis frameworks.
  All artifacts are saved in standard formats (e.g., JSON, HDF5) and can be easily parsed by applications in other languages by following the [relevant specifications](https://github.com/ArtifactDB/takane).
* More modular, with each object split into multiple artifacts.
  This enables parts of the object to be loaded into memory according to each application’s needs.
  Parts can also be updated cheaply on disk without rewriting all files.

# 2 Quick start

To demonstrate, let’s mock up a `DataFrame` object from the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package.

```
library(S4Vectors)
df <- DataFrame(X=1:10, Y=letters[1:10])
df
```

```
## DataFrame with 10 rows and 2 columns
##            X           Y
##    <integer> <character>
## 1          1           a
## 2          2           b
## 3          3           c
## 4          4           d
## 5          5           e
## 6          6           f
## 7          7           g
## 8          8           h
## 9          9           i
## 10        10           j
```

We’ll save this `DataFrame` to a directory:

```
tmp <- tempfile()
library(alabaster.base)
saveObject(df, tmp)
```

And read it back in:

```
readObject(tmp)
```

```
## DataFrame with 10 rows and 2 columns
##            X           Y
##    <integer> <character>
## 1          1           a
## 2          2           b
## 3          3           c
## 4          4           d
## 5          5           e
## 6          6           f
## 7          7           g
## 8          8           h
## 9          9           i
## 10        10           j
```

# 3 Class-specific methods

Each class implements a saving and reading method for use by the *alabaster* framework.
The saving method (for the `saveObject()` generic) will save the object to one or more files inside a user-specified directory:

```
tmp <- tempfile()
saveObject(df, tmp)
list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"            "_environment.json" "basic_columns.h5"
```

Conversely, the reading function will - as the name suggests - load the object back into memory, given the path to its directory.
The correct loading function for each class is automatically called by the `readObject()` function:

```
readObject(tmp)
```

```
## DataFrame with 10 rows and 2 columns
##            X           Y
##    <integer> <character>
## 1          1           a
## 2          2           b
## 3          3           c
## 4          4           d
## 5          5           e
## 6          6           f
## 7          7           g
## 8          8           h
## 9          9           i
## 10        10           j
```

*[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* also provides a `validateObject()` function, which checks that each object’s on-disk representation follows its associated specification.
For all **alabaster**-supported objects, this validates the file contents against the [**takane** specifications](https://github.com/ArtifactDB/takane) -
successful validation provides guarantees for readers like `readObject()` and [**dolomite-base**](https://github.com/ArtifactDB/dolomite-base) (for Python).
In fact, `saveObject()` will automatically run `validateObject()` on the directory to ensure compliance.

```
validateObject(tmp)
```

*[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* itself supports a small set of classes from the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* packages;
support for additional classes can be found in other packages like *[alabaster.ranges](https://bioconductor.org/packages/3.22/alabaster.ranges)* and *[alabaster.se](https://bioconductor.org/packages/3.22/alabaster.se)*.
Third-party developers can also add support for their own classes by defining new methods, see [below](#extending-to-new-classes) for details.

# 4 Operating on directories

Users can move freely rename or relocate directories and `readObject()` function will still work.
For example, we can easily copy the entire directory to a new file system and everything will still be correctly referenced within the directory.
The simplest way to share objects is to just `zip` or `tar` the staging directory for *ad hoc* distribution.
For more serious applications, *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* can be used in conjunction with storage systems like AWS S3 for large-scale distribution.

```
tmp <- tempfile()
saveObject(df, tmp)

tmp2 <- tempfile()
file.rename(tmp, tmp2)
```

```
## [1] TRUE
```

```
readObject(tmp2)
```

```
## DataFrame with 10 rows and 2 columns
##            X           Y
##    <integer> <character>
## 1          1           a
## 2          2           b
## 3          3           c
## 4          4           d
## 5          5           e
## 6          6           f
## 7          7           g
## 8          8           h
## 9          9           i
## 10        10           j
```

That said, it is unwise to manipulate the files inside the directory created by `saveObject()`.
Reading functions will usually depend on specific file names or subdirectory structures within the directory, and fiddling with them may cause unexpected results.
Advanced users can exploit this by loading components from subdirectories if only the full object is not required:

```
# Creating a nested DF to be a little spicy:
df2 <- DataFrame(Z=factor(1:5), AA=I(DataFrame(B=runif(5), C=rnorm(5))))
tmp <- tempfile()
meta2 <- saveObject(df2, tmp)

# Now reading in the nested DF:
list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"                           "_environment.json"
## [3] "basic_columns.h5"                 "other_columns/1/OBJECT"
## [5] "other_columns/1/basic_columns.h5"
```

```
readObject(file.path(tmp, "other_columns/1"))
```

```
## DataFrame with 5 rows and 2 columns
##           B          C
##   <numeric>  <numeric>
## 1  0.398859 -0.0792857
## 2  0.759863 -0.0664193
## 3  0.868532  2.6981326
## 4  0.636374  0.8097302
## 5  0.859753  1.4514450
```

# 5 Extending to new classes

The *alabaster* framework is easily extended to new classes by:

1. Writing a method for `saveObject()`.
   This should accept an instance of the object and a path to a directory, and save the contents of the object inside the directory.
   It should also produce an `OBJECT` file that specifies the type of the object, e.g., `data_frame`, `hdf5_sparse_matrix`.
2. Writing a function for `readObject()` and registering it with `registerReadObjectFunction()` (or, for core Bioconductor classes, by requesting a change to the default registry in *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)*).
   This should accept a path to a directory and read its contents to reconstruct the object.
   The registered type should be the same as that used in the `OBJECT` file.
3. Writing a function for `validateObject()` and registering it with `registerValidateObjectFunction()`.
   This should accept a path to a directory and read its contents to determine if it is a valid on-disk representation.
   The registered type should be the same as that used in the `OBJECT` file.
   * (optional) Devleopers can alternatively formalize the on-disk representation by adding a specification to the [**takane**](https://github.com/ArtifactDB/takane) repository.
     This aims to provide C++-based validators for each representation, allowing us to enforce consistency across multiple languages (e.g., Python).
     Any **takane** validator is automatically used by `validateObject()` so no registration is required.

To illustrate, let’s extend *alabaster* to the `dgTMatrix` from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.
First, the saving method:

```
library(Matrix)
setMethod("saveObject", "dgTMatrix", function(x, path, ...) {
    # Create a directory to stash our contents.
    dir.create(path)

    # Saving a DataFrame with the triplet data.
    df <- DataFrame(i = x@i, j = x@j, x = x@x)
    write.csv(df, file.path(path, "matrix.csv"), row.names=FALSE)

    # Adding some more information.
    write(dim(x), file=file.path(path, "dimensions.txt"), ncol=1)

    # Creating an object file.
    saveObjectFile(path, "triplet_sparse_matrix")
})
```

And now the reading and validation methods.
The registration is usually done in the extension package’s `onLoad()` function.

```
readSparseTripletMatrix <- function(path, metadata, ...) {
    df <- read.table(file.path(path, "matrix.csv"), header=TRUE, sep=",")
    dims <- readLines(file.path(path, "dimensions.txt"))
    sparseMatrix(
         i=df$i + 1L,
         j=df$j + 1L,
         x=df$x,
         dims=as.integer(dims),
         repr="T"
    )
}
registerReadObjectFunction("triplet_sparse_matrix", readSparseTripletMatrix)

validateSparseTripletMatrix <- function(path, metadata) {
    df <- read.table(file.path(path, "matrix.csv"), header=TRUE, sep=",")
    dims <- as.integer(readLines(file.path(path, "dimensions.txt")))
    stopifnot(is.integer(df$i), all(df$i >= 0 & df$i < dims[1]))
    stopifnot(is.integer(df$j), all(df$j >= 0 & df$j < dims[2]))
    stopifnot(is.numeric(df$x))
}
registerValidateObjectFunction("triplet_sparse_matrix", validateSparseTripletMatrix)
```

```
## NULL
```

Let’s run them and see how it works:

```
x <- sparseMatrix(
    i=c(1,2,3,5,6),
    j=c(3,6,1,3,8),
    x=runif(5),
    dims=c(10, 10),
    repr="T"
)
x
```

```
## 10 x 10 sparse Matrix of class "dgTMatrix"
##
##  [1,] .         . 0.7191600 . . .         . .         . .
##  [2,] .         . .         . . 0.3151283 . .         . .
##  [3,] 0.9783064 . .         . . .         . .         . .
##  [4,] .         . .         . . .         . .         . .
##  [5,] .         . 0.7012915 . . .         . .         . .
##  [6,] .         . .         . . .         . 0.7545482 . .
##  [7,] .         . .         . . .         . .         . .
##  [8,] .         . .         . . .         . .         . .
##  [9,] .         . .         . . .         . .         . .
## [10,] .         . .         . . .         . .         . .
```

```
tmp <- tempfile()
saveObject(x, tmp)
list.files(tmp, recursive=TRUE)
```

```
## [1] "OBJECT"         "dimensions.txt" "matrix.csv"
```

```
readObject(tmp)
```

```
## 10 x 10 sparse Matrix of class "dgTMatrix"
##
##  [1,] .         . 0.7191600 . . .         . .         . .
##  [2,] .         . .         . . 0.3151283 . .         . .
##  [3,] 0.9783064 . .         . . .         . .         . .
##  [4,] .         . .         . . .         . .         . .
##  [5,] .         . 0.7012915 . . .         . .         . .
##  [6,] .         . .         . . .         . 0.7545482 . .
##  [7,] .         . .         . . .         . .         . .
##  [8,] .         . .         . . .         . .         . .
##  [9,] .         . .         . . .         . .         . .
## [10,] .         . .         . . .         . .         . .
```

For more complex objects that are composed of multiple smaller “child” objects, developers should consider saving each of their children in subdirectories of `path`.
This can be achieved by calling `altSaveObject()` and `altReadObject()` in the saving and reading functions, respectively.
(We use the `alt*` versions of these functions to respect application overrides, see below.)

# 6 Creating applications

Developers can also create applications that customize the machinery of the *alabaster* framework for specific needs.
In most cases, this involves storing more metadata to describe the object in more detail.
For example, we might want to remember the identity of the author for each object.
This is achieved by creating an application-specific saving generic with the same signature as `saveObject()`:

```
setGeneric("appSaveObject", function(x, path, ...) {
    ans <- standardGeneric("appSaveObject")

    # File names with leading underscores are reserved for application-specific
    # use, so they won't clash with anything produced by saveObject.
    metapath <- file.path(path, "_metadata.json")
    write(jsonlite::toJSON(ans, auto_unbox=TRUE), file=metapath)
})
```

```
## [1] "appSaveObject"
```

```
setMethod("appSaveObject", "ANY", function(x, path, ...) {
    saveObject(x, path, ...) # does the real work
    list(authors=I(Sys.info()[["user"]])) # adds the desired metadata
})

# We can specialize the behavior for specific classes like DataFrames.
setMethod("appSaveObject", "DFrame", function(x, path, ...) {
    ans <- callNextMethod()
    ans$columns <- I(colnames(x))
    ans
})
```

Applications should call `altSaveObjectFunction()` to instruct `altSaveObject()` to use this new generic.
This ensures that the customizations are applied to all child objects, such as the nested `DataFrame` below.

```
# Create a friendly user-visible function to handle the generic override; this
# is reversed on function exit to avoid interfering with other applications.
saveForApplication <- function(x, path, ...) {
    old <- altSaveObjectFunction(appSaveObject)
    on.exit(altSaveObjectFunction(old))
    altSaveObject(x, path, ...)
}

# Saving our mocked up DataFrame with our overrides active.
df2 <- DataFrame(Z=factor(1:5), AA=I(DataFrame(B=runif(5), C=rnorm(5))))
tmp <- tempfile()
saveForApplication(df2, tmp)

# Both the parent and child DataFrames have new metadata.
cat(readLines(file.path(tmp, "_metadata.json")), sep="\n")
```

```
## {"authors":["biocbuild"],"columns":["Z","AA"]}
```

```
cat(readLines(file.path(tmp, "other_columns/1/_metadata.json")), sep="\n")
```

```
## {"authors":["biocbuild"],"columns":["B","C"]}
```

The reading function can be similarly overridden by setting `altReadObjectFunction()` to instruct all `altReadObject()` calls to use the override.
This allows applications to, e.g., do something with the metadata that we just added.

```
# Defining the override for altReadObject().
appReadObject <- function(path, metadata=NULL, ...) {
    if (is.null(metadata)) {
        metadata <- readObjectFile(path)
    }

    # Print custom message based on the type and application-specific metadata.
    appmeta <- jsonlite::fromJSON(file.path(path, "_metadata.json"))
    cat("I am a ", metadata$type, " created by ", appmeta$authors[1], ".\n", sep="")
    if (metadata$type == "data_frame") {
        all.cols <- paste(appmeta$columns, collapse=", ")
        cat("I have the following columns: ", all.cols, ".\n", sep="")
    }

    readObject(path, metadata=metadata, ...)
}

# Creating a user-friendly function to set the override before the read.
readForApplication <- function(path, metadata=NULL, ...) {
    old <- altReadObjectFunction(appReadObject)
    on.exit(altReadObjectFunction(old))
    altReadObject(path, metadata, ...)
}

# This diverts to the override with printing of custom messages.
readForApplication(tmp)
```

```
## I am a data_frame created by biocbuild.
## I have the following columns: Z, AA.
## I am a data_frame created by biocbuild.
## I have the following columns: B, C.
```

```
## DataFrame with 5 rows and 2 columns
##          Z                    AA
##   <factor>           <DataFrame>
## 1        1 0.70089376: 2.1297855
## 2        2 0.19108920:-0.0451785
## 3        3 0.96087726: 1.0391725
## 4        4 0.39971985: 1.0407852
## 5        5 0.00473267:-1.8897802
```

By overriding the saving and reading process for one or more classes, each application can customize the behavior of *alabaster* to their own needs.

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
## [1] Matrix_1.7-4          alabaster.base_1.10.0 S4Vectors_0.48.0
## [4] BiocGenerics_0.56.0   generics_0.1.4        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0           compiler_4.5.1           BiocManager_1.30.26
##  [4] Rcpp_1.1.0               rhdf5filters_1.22.0      alabaster.matrix_1.10.0
##  [7] jquerylib_0.1.4          IRanges_2.44.0           yaml_2.3.10
## [10] fastmap_1.2.0            lattice_0.22-7           R6_2.6.1
## [13] XVector_0.50.0           S4Arrays_1.10.0          knitr_1.50
## [16] DelayedArray_0.36.0      bookdown_0.45            MatrixGenerics_1.22.0
## [19] h5mread_1.2.0            bslib_0.9.0              rlang_1.1.6
## [22] cachem_1.1.0             HDF5Array_1.38.0         xfun_0.53
## [25] sass_0.4.10              SparseArray_1.10.0       cli_3.6.5
## [28] Rhdf5lib_1.32.0          digest_0.6.37            grid_4.5.1
## [31] alabaster.schemas_1.10.0 rhdf5_2.54.0             lifecycle_1.0.4
## [34] evaluate_1.0.5           abind_1.4-8              rmarkdown_2.30
## [37] matrixStats_1.5.0        tools_4.5.1              htmltools_0.5.8.1
```