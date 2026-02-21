# BiocBaseUtils Quick Start

Bioconductor Core Team

#### October 29, 2025

# Contents

* [1 BiocBaseUtils](#biocbaseutils)
* [2 Installation](#installation)
* [3 Load Package](#load-package)
* [4 Assertions](#assertions)
  + [4.1 Logical](#logical)
  + [4.2 Character](#character)
  + [4.3 Numeric](#numeric)
* [5 Slot replacement](#slot-replacement)
* [6 `show` method](#show-method)
* [7 Contributing](#contributing)
* [8 Session Info](#session-info)

# 1 BiocBaseUtils

The `BiocBaseUtils` package provides a suite of helper functions designed to
help developers. Currently, it covers three topics often encountered during
the development process.

1. Assertions - Type checks for logical, character, and numeric inputs
2. Slot replacement - Replacing the value of object slots
3. `show` method - Limiting the output of internal components of a class

# 2 Installation

Install the package directly from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BiocBaseUtils")
```

# 3 Load Package

```
library(BiocBaseUtils)
```

# 4 Assertions

We provide a number of functions that helps the developer establish the
type of class of a particular object. These include `integer`, `numeric`,
`character`, and `logical`; types often used in R / Bioconductor.

## 4.1 Logical

```
isTRUEorFALSE(TRUE)
#> [1] TRUE
isTRUEorFALSE(FALSE)
#> [1] TRUE
isTRUEorFALSE(NA, na.ok = TRUE)
#> [1] TRUE
```

## 4.2 Character

```
isScalarCharacter(LETTERS)
#> [1] FALSE
isScalarCharacter("L")
#> [1] TRUE
isCharacter(LETTERS)
#> [1] TRUE
isCharacter(NA_character_, na.ok = TRUE)
#> [1] TRUE
isZeroOneCharacter("")
#> [1] FALSE
isZeroOneCharacter("", zchar = TRUE)
#> [1] TRUE
```

## 4.3 Numeric

```
isScalarInteger(1L)
#> [1] TRUE
isScalarInteger(1)
#> [1] FALSE

isScalarNumber(1)
#> [1] TRUE
isScalarNumber(1:2)
#> [1] FALSE
```

# 5 Slot replacement

This function is often used in packages that establish formal S4 classes.
When updating the value of a slot, one often uses the `setSlots` function.

```
setClass("A", representation = representation(slot1 = "numeric"))
aclass <- new("A", slot1 = 1:10)
aclass
#> An object of class "A"
#> Slot "slot1":
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

Now we use the `setSlots` function to update the values in the object.

```
aclass <- setSlots(aclass, slot1 = 11:20)
aclass
#> An object of class "A"
#> Slot "slot1":
#>  [1] 11 12 13 14 15 16 17 18 19 20
```

Note that `setSlots` provides the same functionality as
`BiocGenerics:::replaceSlots` but is more consistent with Bioconductor the
setter and getter language.

# 6 `show` method

The `selectSome` function allows the developer to display a limited amount of
information from a developed class. Note that the use of the `@` here is due
to the minimal implementation in the examples provided. The developer should
always provide an interface to access the internal components of the class
via an ‘accessor’ function.

```
setMethod("show", signature = "A", function(object) {
    s1info <- getElement(object, "slot1")
    cat("A sequence:", selectSome(s1info))
})
aclass
#> A sequence: 11 12 ... 19 20
```

# 7 Contributing

`BiocBaseUtils` is a work in progress and we welcome contributions. There
are quite a few often-used utility functions that are yet to be included in the
package. We would like to keep the dependencies in this package minimal;
therefore, contributions should mostly use base R.

# 8 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] BiocBaseUtils_1.12.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
#>  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
#> [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
#> [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

Please report minimally reproducible bugs at our [github issue page](https://github.com/Bioconductor/BiocBaseUtils/issues).