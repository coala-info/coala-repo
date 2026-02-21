# A quick overview of the *S4Arrays* package

Hervé Pagès1

1Fred Hutch Cancer Center, Seattle, WA

#### Compiled 1 December 2025; Modified 7 February 2025

#### Package

S4Arrays 1.10.1

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 The Array virtual class](#the-array-virtual-class)
* [4 The extract\_array() generic function](#the-extract_array-generic-function)
* [5 Block processing of array-like objects](#block-processing-of-array-like-objects)
* [6 Other functionalities](#other-functionalities)
* [7 Session information](#session-information)

# 1 Introduction

*[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* is an infrastructure package that provides a
framework intended to facilitate implementation of *array-like* containers
in other Bioconductor packages. *Array-like* containers are S4 objects that
mimic the behavior of ordinary matrices or arrays in R. Please note that
the package is not intended to be used directly by the end user.

# 2 Installation

Like any other Bioconductor package, *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* should always
be installed with `BiocManager::install()`:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("S4Arrays")
```

However, note that *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* will typically get automatically
installed as a dependency of other Bioconductor packages, so explicit
installation of the package is usually not needed.

# 3 The Array virtual class

At the center of the framework provided by the *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)*
package is the Array virtual class whose only purpose is to be extended
by other S4 classes that wish to implement a container with an array-like
semantic. Examples of such classes are:

* The SparseArray class defined in the *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* package.
* The DelayedArray class defined in the *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* package.
* The ArrayGrid and ArrayViewport classes defined in the
  *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* package itself.

Note that Array is a virtual class with no slots:

```
library(S4Arrays)

showClass("Array")
```

```
## Virtual Class "Array" [package "S4Arrays"]
##
## No Slots, prototype of class "S4"
##
## Known Subclasses:
## Class "ArrayViewport", directly
## Class "ArrayGrid", directly
## Class "DummyArrayViewport", by class "ArrayViewport", distance 2
## Class "SafeArrayViewport", by class "ArrayViewport", distance 2
## Class "DummyArrayGrid", by class "ArrayGrid", distance 2
## Class "ArbitraryArrayGrid", by class "ArrayGrid", distance 2
## Class "RegularArrayGrid", by class "ArrayGrid", distance 2
```

# 4 The extract\_array() generic function

The *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* package also introduces the `extract_array()`
S4 generic function that Arrays subclasses (a.k.a. Arrays extensions)
are expected to support via specific methods. This allows some basic
operations like `type()`, `as.array()` or `as.matrix()` to work
out-of-the-box on instances of these Arrays subclasses (a.k.a.
Arrays derivatives). It also allows them to be used as the seed of a
DelayedArray object.

Please refer to the man page of the `extract_array()` function for more
information: `?extract_array`

# 5 Block processing of array-like objects

The *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* package provides a framework that facilitates
block processing of array-like objects. Note that block processing is
typically used on *on-disk* objects, that is, on objects where the array
data is stored on disk. This framework consists of:

* ArrayGrid and ArrayViewport objects for representing grids and viewports
  on array-like objects. See `?ArrayGrid` for more information.
* The `read_block()` and `write_block()` functions to read and write array
  blocks. See `?read_block` and `?write_block` for more information.
* The `mapToGrid()` and `mapToRef()` functions to map a set of reference
  array positions to grid positions and vice-versa. See `?mapToGrid` for
  more information.

# 6 Other functionalities

In addition to the above, the *[S4Arrays](https://bioconductor.org/packages/3.22/S4Arrays)* package provides
the following functionalities:

* `is_sparse()`: a generic function for determining whether an array-like
  object uses a sparse representation or not. See `?is_sparse` for more
  information.
* Low-level utilities for manipulating array selections. See `?Lindex2Mindex`
  for more information.
* `aperm2()`: an extension of `base::aperm()` that allows dropping and/or
  adding *ineffective dimensions*. See `?aperm2` for more information.
* `abind()`: a generic function for binding multidimensional array-like
  objects along any dimension. See `?abind` for more information.
* `arep_times()` and `arep_each()`: multidimensional versions
  of `base::rep( , times=)` and `base::rep( , each=)`.
  See `?arep` for more information.
* `as_tile()`: a convenient way to control the direction of recycling in
  the context of arithmetic and other binary operations between an array
  and a vector, or between two arrays of distinct dimensions.
  See `?as_tile` for more information.
* `kronecker()` methods for Array objects that work out-of-the-box on
  Array derivatives that support `[` and `*`. See `?kronecker2` for
  more information.

# 7 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] S4Arrays_1.10.1     IRanges_2.44.0      S4Vectors_0.48.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      abind_1.4-8
## [7] Matrix_1.7-4        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.54           jsonlite_2.0.0      htmltools_0.5.8.1
##  [7] sass_0.4.10         rmarkdown_2.30      grid_4.5.2
## [10] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [13] yaml_2.3.11         lifecycle_1.0.4     bookdown_0.45
## [16] BiocManager_1.30.27 compiler_4.5.2      lattice_0.22-7
## [19] digest_0.6.39       R6_2.6.1            bslib_0.9.0
## [22] tools_4.5.2         cachem_1.1.0
```