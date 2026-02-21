# A quick introduction to the *updateObject* package

Hervé Pagès

#### Compiled 30 October 2025; Modified 16 February 2022

#### Package

updateObject 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Out-of-sync objects](#out-of-sync-objects)
* [3 The updateObject() generic function](#the-updateobject-generic-function)
* [4 A tedious process](#a-tedious-process)
* [5 updateBiocPackageRepoObjects()](#updatebiocpackagerepoobjects)
* [6 List of tools provided by the updateObject package](#list-of-tools-provided-by-the-updateobject-package)
* [7 Session information](#session-information)

# 1 Introduction

*[updateObject](https://bioconductor.org/packages/3.22/updateObject)* is an R package that provides a set of
tools built around the `updateObject()` generic function to make it
easy to work with old serialized S4 instances.

The package is primarily useful to package maintainers who want to
update the serialized S4 instances included in their package.

# 2 Out-of-sync objects

Out-of-sync objects (a.k.a. *outdated* or *old* objects) are R objects
that got serialized at some point and became out-of-sync later on when
the authors/maintainers of an S4 class made some changes to the internals
of the class.

A typical example of this situation is when some slots of an S4 class `A`
get added, removed, or renamed. When this happens, any object of class `A`
(a.k.a. `A` *instance*) that got serialized before this change (i.e. written
to disk with `saveRDS()`, `save()`, or `serialize()`) becomes out-of-sync
with the new class definition.

Note that this is also the case of any `A` *derivative* (i.e. any object
that belongs to a class that extends `A`), as well as any object that
*contains* an `A` instance or derivative. For example, if `B` extends `A`,
then any serialized list of `A` or `B` objects is now an *old* object,
and any S4 object of class `C` that has `A` or `B` objects in some of its
slots now is also an *old* object.

An important thing to keep in mind is that, in fact, the exact parts of a
serialized object `x` that are out-of-sync with their class definition can
be deeply nested inside `x`.

# 3 The updateObject() generic function

`updateObject()` is the core function used in Bioconductor for updating
old R objects. The function is an S4 generic currently defined in the
*[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)* package and with dozens of methods defined
across many Bioconductor packages. For example, the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)*
package defines `updateObject()` methods for Vector, SimpleList, DataFrame,
and Hits objects, the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* package defines
methods for SummarizedExperiment, RangedSummarizedExperiment, and Assays
objects, the *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* package defines a method
for MultiAssayExperiment objects, the *[QFeatures](https://bioconductor.org/packages/3.22/QFeatures)* package a
method for QFeatures objects, etc…

See `?BiocGenerics::updateObject` in the *[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)*
package for more information.

# 4 A tedious process

Serialized objects are typically (but not exclusively) found in R packages.
To update all the serialized objects contained in a given package, one
usually needs to perform the following steps:

* Identify all the files in the package that contain serialized R objects.
  Serialized R objects are normally written to RDS or RDA files. These
  files typically use file extensions `.rds` (for RDS files), and `.rda`
  or `.RData` (for RDA files).
* Load each serialized object into R. This is usually done by calling
  `readRDS()` on each RDS file, and `load()` on each RDA file. Note that
  unlike RDS files which can only contain a single object per file, RDA
  files can contain an arbitrary number of objects per file.
* Pass each object thru `updateObject()`:

  ```
  x <- updateObject(x)
  ```

  Note that if `x` doesn’t contain any out-of-sync parts then `updateObject()`
  will act as a no-op, that is, it will return an object that is strictly
  identical to the original object.
* Write each object back to its original file. This is done with `saveRDS()`
  or `save()`, depending on whether the object came from an RDS or RDA file.
  Note that this only needs to be done for objects that *actually* contained
  out-of-sync parts i.e. for objects on which `updateObject()` did *not* act
  as a no-op.

In addition to the above steps, the package maintainer also needs to perform
the usual steps required for updating a package and publishing its new version.
In the case of a Bioconductor package, these steps are:

* Bump the package version.
* Set its `Date` field (if present) to the current date.
* Commit the changes.
* Push the changes to `git.bioconductor.org`.

Performing all the above steps manually can be tedious and error prone,
especially if the package contains many serialized objects, or if the
entire procedure needs to be performed on a big collection of packages.
The *[updateObject](https://bioconductor.org/packages/3.22/updateObject)* package provides a set of tools that
intend to make this much easier.

# 5 updateBiocPackageRepoObjects()

`updateBiocPackageRepoObjects()` is the central function in the
*[updateObject](https://bioconductor.org/packages/3.22/updateObject)* package. It takes care of updating the
serialized objects contained in a given Bioconductor package by
performing all the steps described in the previous section.

Let’s load *[updateObject](https://bioconductor.org/packages/3.22/updateObject)*:

```
library(updateObject)
```

and try `updateBiocPackageRepoObjects()` on the `RELEASE_3_14` branch
of the *[BiSeq](https://bioconductor.org/packages/3.22/BiSeq)* package:

```
repopath <- file.path(tempdir(), "BiSeq")
updateBiocPackageRepoObjects(repopath, branch="RELEASE_3_14", use.https=TRUE)
```

```
## Cloning into '/tmp/Rtmp8qsRTy/BiSeq'...
```

```
##
```

```
## RUNNING 'updatePackageObjects("/tmp/Rtmp8qsRTy/BiSeq", bump.Version=TRUE)'...
```

```
## File /tmp/Rtmp8qsRTy/BiSeq/data/DMRs.RData: load().. ok [1 object(s)]; updateObject(GRanges, check=FALSE).. object updated; saving file.. OK ==> 1
## File /tmp/Rtmp8qsRTy/BiSeq/data/betaResults.RData: load().. ok [1 object(s)]; updateObject(data.frame, check=FALSE).. no-op; nothing to update ==> 0
## File /tmp/Rtmp8qsRTy/BiSeq/data/betaResultsNull.RData: load().. ok [1 object(s)]; updateObject(data.frame, check=FALSE).. no-op; nothing to update ==> 0
## File /tmp/Rtmp8qsRTy/BiSeq/data/predictedMeth.RData: load().. ok [1 object(s)]; updateObject(BSrel, check=FALSE).. object updated; saving file.. OK ==> 1
## File /tmp/Rtmp8qsRTy/BiSeq/data/promoters.RData: load().. ok [1 object(s)]; updateObject(GRanges, check=FALSE).. object updated; saving file.. OK ==> 1
## File /tmp/Rtmp8qsRTy/BiSeq/data/rrbs.RData: load().. ok [1 object(s)]; updateObject(BSraw, check=FALSE).. object updated; saving file.. OK ==> 1
## File /tmp/Rtmp8qsRTy/BiSeq/data/vario.RData: load().. ok [1 object(s)]; updateObject(list, check=FALSE).. no-op; nothing to update ==> 0
```

```
## diff --git a/DESCRIPTION b/DESCRIPTION
## index df756f4..183d159 100644
## --- a/DESCRIPTION
## +++ b/DESCRIPTION
## @@ -1,8 +1,8 @@
##  Package: BiSeq
##  Type: Package
##  Title: Processing and analyzing bisulfite sequencing data
## -Version: 1.34.0
## -Date: 2020-03-27
## +Version: 1.34.1
## +Date: 2025-10-30
##  Author: Katja Hebestreit, Hans-Ulrich Klein
##  Maintainer: Katja Hebestreit <katja.hebestreit@gmail.com>
##  Depends: R (>= 2.15.2), methods, S4Vectors, IRanges (>= 1.17.24),
## diff --git a/data/DMRs.RData b/data/DMRs.RData
## index 4d94fd5..45d7cc1 100644
## Binary files a/data/DMRs.RData and b/data/DMRs.RData differ
## diff --git a/data/predictedMeth.RData b/data/predictedMeth.RData
## index c3d927e..962e068 100644
## Binary files a/data/predictedMeth.RData and b/data/predictedMeth.RData differ
## diff --git a/data/promoters.RData b/data/promoters.RData
## index ffb1482..8962a4a 100644
## Binary files a/data/promoters.RData and b/data/promoters.RData differ
## diff --git a/data/rrbs.RData b/data/rrbs.RData
## index a84972c..5087efc 100644
## Binary files a/data/rrbs.RData and b/data/rrbs.RData differ
##
## [RELEASE_3_14 97a459b] Pass serialized S4 instances thru updateObject()
##  5 files changed, 2 insertions(+), 2 deletions(-)
```

```
##
## UPDATE OBJECTS >> UPDATE DESCRIPTION FILE >> COMMIT SUCCESSFUL.
```

Important notes:

* By default `updateBiocPackageRepoObjects()` does *not* try to push the
  changes to `git.bioconductor.org`. Only the authorized maintainers of
  the *[BiSeq](https://bioconductor.org/packages/3.22/BiSeq)* package can do that. If you are
  using `updateBiocPackageRepoObjects()` on a package that you maintain
  and you wish to push the changes to `git.bioconductor.org`, then do NOT
  use HTTPS access (i.e. don’t use `use.https=TRUE`) and use `push=TRUE`.
* The `RELEASE_3_14` branch of all Bioconductor packages got frozen in
  April 2022. The above example is for illustrative purpose only.
  A more realistic situation would be to use `updateBiocPackageRepoObjects()`
  on the development version (i.e. the `devel` branch) of a package
  that you maintain, and to push the changes by calling the function
  with `push=TRUE`:

  ```
  updateBiocPackageRepoObjects(repopath, push=TRUE)
  ```

See `?updateBiocPackageRepoObjects` for more information and more
examples.

# 6 List of tools provided by the updateObject package

The package provides the following tools:

* `updateBiocPackageRepoObjects()`: See above.
* `updatePackageObjects()`: A simpler version of
  `updateBiocPackageRepoObjects()` that doesn’t know anything about
  Git. That is, `updatePackageObjects()` will do the same thing
  as `updateBiocPackageRepoObjects()` except that it won’t commit
  or push the changes. This means that the function can be used on
  any local package source tree, whether it’s a Git clone or not,
  and whether it’s a Bioconductor package or not.
* `updateAllBiocPackageRepoObjects()` and `updateAllPackageObjects()`:
  Similar to `updateBiocPackageRepoObjects()` and `updatePackageObjects()`
  but for processing *a set* of Bioconductor package Git repositories (for
  `updateAllBiocPackageRepoObjects()`) and *a set* of packages (for
  `updateAllPackageObjects()`).
* `updateSerializedObjects()`: The workhorse behind the above functions.

See individual man pages in the package for more information e.g.
`?updatePackageObjects`.

# 7 Session information

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
## [1] SummarizedExperiment_1.40.0 BiSeq_1.50.0
## [3] IRanges_2.44.0              GenomicRanges_1.62.0
## [5] updateObject_1.14.0         S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0         generics_0.1.4
## [9] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
##  [4] bslib_0.9.0              globaltest_5.64.0        Biobase_2.70.0
##  [7] lattice_0.22-7           vctrs_0.6.5              tools_4.5.1
## [10] bitops_1.0-9             curl_7.0.0               parallel_4.5.1
## [13] flexmix_2.3-20           sandwich_3.1-1           RSQLite_2.4.3
## [16] AnnotationDbi_1.72.0     blob_1.2.4               lokern_1.1-12
## [19] Matrix_1.7-4             cigarillo_1.0.0          lifecycle_1.0.4
## [22] compiler_4.5.1           Rsamtools_2.26.0         Biostrings_2.78.0
## [25] Seqinfo_1.0.0            codetools_0.2-20         htmltools_0.5.8.1
## [28] sass_0.4.10              RCurl_1.98-1.17          yaml_2.3.10
## [31] Formula_1.2-5            crayon_1.5.3             jquerylib_0.1.4
## [34] BiocParallel_1.44.0      DelayedArray_0.36.0      cachem_1.1.0
## [37] betareg_3.2-4            abind_1.4-8              digest_0.6.37
## [40] restfulr_0.0.16          bookdown_0.45            splines_4.5.1
## [43] fastmap_1.2.0            grid_4.5.1               cli_3.6.5
## [46] SparseArray_1.10.0       S4Arrays_1.10.0          survival_3.8-3
## [49] XML_3.99-0.19            bit64_4.6.0-1            rmarkdown_2.30
## [52] XVector_0.50.0           httr_1.4.7               matrixStats_1.5.0
## [55] bit_4.6.0                nnet_7.3-20              png_0.1-8
## [58] zoo_1.8-14               modeltools_0.2-24        memoise_2.0.1
## [61] evaluate_1.0.5           knitr_1.50               BiocIO_1.20.0
## [64] lmtest_0.9-40            rtracklayer_1.70.0       rlang_1.1.6
## [67] DBI_1.2.3                xtable_1.8-4             BiocManager_1.30.26
## [70] annotate_1.88.0          jsonlite_2.0.0           R6_2.6.1
## [73] MatrixGenerics_1.22.0    GenomicAlignments_1.46.0 sfsmisc_1.1-22
```