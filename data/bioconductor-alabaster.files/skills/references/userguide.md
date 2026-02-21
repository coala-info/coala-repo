# Saving common bioinformatics file formats

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: December 30, 2023

#### Package

alabaster.files 1.8.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Integration with other objects](#integration-with-other-objects)
* [4 Validation](#validation)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.files](https://bioconductor.org/packages/3.22/alabaster.files)* package implements methods to save common bioinformatics file formats within the **alabaster** framework.
It does not perform any validation or parsing of the files, it just provides very light-weight wrappers for processing via `alabaster.base::stageObject()`.
Check out the *[alabaster.base](https://bioconductor.org/packages/3.22/alabaster.base)* package for more details on the motivation and concepts behind **alabaster**.

# 2 Quick start

We’ll start with an indexed BAM file from the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package:

```
bam.file <- system.file("extdata", "ex1.bam", package="Rsamtools", mustWork=TRUE)
bam.index <- paste0(bam.file, ".bai")
```

We can wrap this inside a `BamFileReference` class:

```
library(alabaster.files)
library(S4Vectors)
wrapped.bam <- BamFileReference(bam.file, index=bam.index)
```

Then we can save it to file:

```
dir <- tempfile()
saveObject(wrapped.bam, dir)
```

… and load it back at some later time.

```
readObject(dir)
```

```
## BamFileReference object
## path: /tmp/RtmpitWkHy/file316075380cfe77/file.bam
## index: /tmp/RtmpitWkHy/file316075380cfe77/file.bam.bai
```

# 3 Integration with other objects

The example above isn’t very exciting, but it demonstrates how these files can be easily added to an **alabaster** project.
This allows us to incorporate the `Wrapper` objects into other Bioconductor data structures, like:

```
df <- DataFrame(Sample=LETTERS[1:4])

# Adding a column of assorted wrapper files:
df$File <- list(
    wrapped.bam,
    BigWigFileReference(system.file("tests", "test.bw", package = "rtracklayer")),
    BigBedFileReference(system.file("tests", "test.bb", package = "rtracklayer")),
    BcfFileReference(system.file("extdata", "ex1.bcf.gz", package = "Rsamtools"))
)

# Saving it all to the staging directory:
dir <- tempfile()
saveObject(df, dir)

# Now reading it back in:
roundtrip <- readObject(dir)
roundtrip$File
```

```
## [[1]]
## BamFileReference object
## path: /tmp/RtmpitWkHy/file31607562fa8357/other_columns/1/other_contents/0/file.bam
## index: /tmp/RtmpitWkHy/file31607562fa8357/other_columns/1/other_contents/0/file.bam.bai
##
## [[2]]
## BigWigFileReference object
## path: /tmp/RtmpitWkHy/file31607562fa8357/other_columns/1/other_contents/1/file.bw
##
## [[3]]
## BigBedFileReference object
## path: /tmp/RtmpitWkHy/file31607562fa8357/other_columns/1/other_contents/2/file.bb
##
## [[4]]
## BcfFileReference object
## path: /tmp/RtmpitWkHy/file31607562fa8357/other_columns/1/other_contents/3/file.bcf
## index: NULL
```

Similarly, if the staging directory is uploaded to a remote store, the wrapped files will automatically be included in the upload.
This avoids the need for a separate process to handle these files.

# 4 Validation

*[alabaster.files](https://bioconductor.org/packages/3.22/alabaster.files)* will try to perform some cursory validation of the wrapped file to catch errors in user inputs.
The level of validation is format-dependent but should be fast, e.g., BAM file validation is performed by scanning the header.
In all cases, users should not expect an exhaustive check of file validity, as that would take too long and involve more parsing than desired for the scope of *[alabaster.files](https://bioconductor.org/packages/3.22/alabaster.files)*.
If stricter validation is required, applications calling *[alabaster.files](https://bioconductor.org/packages/3.22/alabaster.files)* should override the `saveObject()` methods for the relevant `FileReference` classes.

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
## [1] S4Vectors_0.48.0      BiocGenerics_0.56.0   generics_0.1.4
## [4] alabaster.files_1.8.0 alabaster.base_1.10.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3             cli_3.6.5                knitr_1.50
##  [4] rlang_1.1.6              xfun_0.53                jsonlite_2.0.0
##  [7] Biostrings_2.78.0        htmltools_0.5.8.1        sass_0.4.10
## [10] rmarkdown_2.30           Seqinfo_1.0.0            evaluate_1.0.5
## [13] jquerylib_0.1.4          bitops_1.0-9             fastmap_1.2.0
## [16] IRanges_2.44.0           yaml_2.3.10              alabaster.schemas_1.10.0
## [19] lifecycle_1.0.4          Rhdf5lib_1.32.0          bookdown_0.45
## [22] BiocManager_1.30.26      compiler_4.5.1           codetools_0.2-20
## [25] Rcpp_1.1.0               rhdf5filters_1.22.0      XVector_0.50.0
## [28] BiocParallel_1.44.0      rhdf5_2.54.0             digest_0.6.37
## [31] R6_2.6.1                 parallel_4.5.1           GenomicRanges_1.62.0
## [34] bslib_0.9.0              tools_4.5.1              Rsamtools_2.26.0
## [37] cachem_1.1.0
```