# Large-scale data handling and processing with Spectra

#### 25 December 2025

**Package**: *[Spectra](https://bioconductor.org/packages/3.22/Spectra)*
**Authors**: RforMassSpectrometry Package Maintainer [cre],
Laurent Gatto [aut] (ORCID: <https://orcid.org/0000-0002-1520-2268>),
Johannes Rainer [aut] (ORCID: <https://orcid.org/0000-0002-6977-7147>),
Sebastian Gibb [aut] (ORCID: <https://orcid.org/0000-0001-7406-4443>),
Philippine Louail [aut] (ORCID:
<https://orcid.org/0009-0007-5429-6846>),
Jan Stanstrup [ctb] (ORCID: <https://orcid.org/0000-0003-0541-7369>),
Nir Shahaf [ctb],
Mar Garcia-Aloy [ctb] (ORCID: <https://orcid.org/0000-0002-1330-6610>),
Guillaume Deflandre [ctb] (ORCID:
<https://orcid.org/0009-0008-1257-2416>),
Ahlam Mentag [ctb] (ORCID: <https://orcid.org/0009-0008-5438-7067>)
**Last modified:** 2025-10-29 20:09:40.485261
**Compiled**: Thu Dec 25 20:23:42 2025

# 1 Introduction

The *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* package supports handling and processing of also very
large mass spectrometry (MS) data sets. Through dedicated backends, that only
load MS data when requested/needed, the memory demand can be minimized. Examples
for such backends are the `MsBackendMzR` and the `MsBackendOfflineSql` (defined
in the *[MsBackendSql](https://bioconductor.org/packages/3.22/MsBackendSql)* package). In addition, `Spectra` supports
chunk-wise data processing, hence only parts of the data are loaded into memory
and processed at a time. In this document we provide information on how large
scale data can be best processed with the *Spectra* package.

# 2 Memory requirements of different data representations

The *Spectra* package separates functionality to process and analyze MS data
(implemented for the `Spectra` class) from the code that defines how and where
the MS data is stored. For the latter, different implementations of the
`MsBackend` class are available, that either are optimized for performance (such
as the `MsBackendMemory` and `MsBackendDataFrame`) or for low memory requirement
(such as the `MsBackendMzR`, or the `MsBackendOfflineSql` implemented in the
*[MsBackendSql](https://bioconductor.org/packages/3.22/MsBackendSql)* package, that through the smallest possible memory
footprint enables also the analysis of very large data sets). Below we load MS
data from 4 test files into a `Spectra` using a `MsBackendMzR` backend.

```
library(Spectra)

#' Define the file names from which to import the data
fls <- c(
    system.file("TripleTOF-SWATH", "PestMix1_DDA.mzML", package = "msdata"),
    system.file("TripleTOF-SWATH", "PestMix1_SWATH.mzML", package = "msdata"),
    system.file("sciex", "20171016_POOL_POS_1_105-134.mzML",
                package = "msdata"),
    system.file("sciex", "20171016_POOL_POS_3_105-134.mzML",
                package = "msdata"))

#' Creating a Spectra object representing the MS data
sps_mzr <- Spectra(fls, source = MsBackendMzR())
sps_mzr
```

```
## MSn data (Spectra) with 18463 spectra in a MsBackendMzR backend:
##         msLevel     rtime scanIndex
##       <integer> <numeric> <integer>
## 1             1     0.231         1
## 2             1     0.351         2
## 3             1     0.471         3
## 4             1     0.591         4
## 5             1     0.711         5
## ...         ...       ...       ...
## 18459         1   258.636       927
## 18460         1   258.915       928
## 18461         1   259.194       929
## 18462         1   259.473       930
## 18463         1   259.752       931
##  ... 34 more variables/columns.
##
## file(s):
## PestMix1_DDA.mzML
## PestMix1_SWATH.mzML
## 20171016_POOL_POS_1_105-134.mzML
##  ... 1 more files
```

The resulting `Spectra` uses a `MsBackendMzR` for data representation. This
backend does only load general spectra data into memory while the *full* MS data
(i.e., the *m/z* and intensity values of the individual mass peaks) is only
loaded when requested or needed. In contrast to an *in-memory* backend, the
memory footprint of this backend is thus lower.

Below we create a `Spectra` that keeps the full data in memory by changing the
backend to a `MsBackendMemory` backend and compare the sizes of both objects.

```
sps_mem <- setBackend(sps_mzr, MsBackendMemory())

print(object.size(sps_mzr), units = "MB")
```

```
## 5.3 Mb
```

```
print(object.size(sps_mem), units = "MB")
```

```
## 140.2 Mb
```

Keeping the full data in memory requires thus considerably more memory.

We next disable parallel processing for *Spectra* to allow an unbiased
estimation of memory usage.

```
#' Disable parallel processing globally
register(SerialParam())
```

# 3 Chunk-wise and parallel processing

Operations on peaks data are the most time and memory demanding tasks. These
generally apply a function to, or modify the *m/z* and/or intensity
values. Among these functions are for example functions that filter, remove or
combine mass peaks (such as `filterMzRange()`, `filterIntensity()` or
`combinePeaks()`) or functions that perform calculations on the peaks data (such
as `bin()` or `pickPeaks()`) or also functions that provide information on, or
summarize spectra (such as `lengths()` or `ionCount()`). For all these
functions, the peaks data needs to be present in memory and on-disk backends,
such as the `MsBackendMzR`, need thus to first import the data from their data
storage. However, loading the full peaks data at once into memory might not be
possible for large data sets. Loading and processing the data in smaller chunks
would however reduce the memory demand and hence allow to process also such data
sets. For the `MsBackendMzR` and `MsBackendHdf5Peaks` backends the data is
automatically split and processed by the data storage files. For all other
backends chunk-wise processing can be enabled by defining the
`processingChunkSize` of a `Spectra`, i.e. the number of spectra for which peaks
data should be loaded and processed in each iteration. The
`processingChunkFactor()` function can be used to evaluate how the data will be
split. Below we use this function to evaluate how chunk-wise processing would be
performed with the two `Spectra` objects.

```
processingChunkFactor(sps_mem)
```

```
## factor()
## Levels:
```

For the `Spectra` with the in-memory backend an empty `factor()` is returned,
thus, no chunk-wise processing will be performed. We next evaluate whether the
`Spectra` with the `MsBackendMzR` on-disk backend would use chunk-wise
processing.

```
processingChunkFactor(sps_mzr) |> table()
```

```
##
##      /home/biocbuild/bbs-3.22-bioc/R/site-library/msdata/TripleTOF-SWATH/PestMix1_DDA.mzML
##                                                                                       7602
##    /home/biocbuild/bbs-3.22-bioc/R/site-library/msdata/TripleTOF-SWATH/PestMix1_SWATH.mzML
##                                                                                       8999
## /home/biocbuild/bbs-3.22-bioc/R/site-library/msdata/sciex/20171016_POOL_POS_1_105-134.mzML
##                                                                                        931
## /home/biocbuild/bbs-3.22-bioc/R/site-library/msdata/sciex/20171016_POOL_POS_3_105-134.mzML
##                                                                                        931
```

The data would thus be split and processed by the original file, from which the
data is imported. We next specifically define the chunk-size for both `Spectra`
with the `processingChunkSize()` function.

```
processingChunkSize(sps_mem) <- 3000
processingChunkFactor(sps_mem) |> table()
```

```
##
##    1    2    3    4    5    6    7
## 3000 3000 3000 3000 3000 3000  463
```

After setting the chunk size, also the `Spectra` with the in-memory backend
would use chunk-wise processing. We repeat with the other `Spectra` object:

```
processingChunkSize(sps_mzr) <- 3000
processingChunkFactor(sps_mzr) |> table()
```

```
##
##    1    2    3    4    5    6    7
## 3000 3000 3000 3000 3000 3000  463
```

The `Spectra` with the `MsBackendMzR` backend would now split the data in about
equally sized arbitrary chunks and no longer by original data file. Setting
`processingChunkSize` thus overrides any splitting suggested by the backend.

After having set a `processingChunkSize`, any operation involving peaks data
will by default be performed in a chunk-wise manner. Thus, calling `ionCount()`
on our `Spectra` will now split the data in chunks of 3000 spectra and sum the
intensities (per spectrum) chunk by chunk.

```
tic <- ionCount(sps_mem)
```

While chunk-wise processing reduces the memory demand of operations, the
splitting and merging of the data and results can negatively impact
performance. Thus, small data sets or `Spectra` with in-memory backends
will generally not benefit from this type of processing. For computationally
intense operation on the other hand, chunk-wise processing has the advantage,
that chunks can (and will) be processed in parallel (depending on the parallel
processing setup).

Note that this chunk-wise processing only affects functions that involve actual
peak data. Subset operations that only reduce the number of spectra (such as
`filterRt()` or `[`) bypass this mechanism and are applied immediately to the
data.

For an evaluation of chunk-wise processing see also this
[issue](https://github.com/rformassspectrometry/Spectra/issues/304#issuecomment-1825699576)
on the *Spectra* github repository.

# 4 Notes and suggestions for parallel or chunk-wise processing

* Estimating memory usage in R tends to be difficult, but for MS data sets with
  more than about 100 samples or whenever processing tends to take longer than
  expected it is suggested to enable chunk-wise processing (if not already used,
  as with `MsBackendMzR`).
* `Spectra` uses the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package for parallel
  processing. The parallel processing setup can be configured globally by
  *registering* the preferred setup using the `register()` function (e.g.
  `register(SnowParam(4))` to use socket-based parallel processing on Windows
  using 4 different R processes). Parallel processing can be disabled by setting
  `register(SerialParam())`.
* Chunk-wise processing will by default run in parallel, depending on the
  configured parallel processing setup.
* Parallel processing (and also chunk-wise processing) have a computational
  overhead, because the data needs to be split and merged. Thus, for some
  operations or data sets avoiding this mechanism can be more efficient
  (e.g. for in-memory backends or small data sets).

# 5 `Spectra` functions supporting or using parallel processing

Some functions allow to configure parallel processing using a dedicated
parameter that allows to define how to split the data for parallel (or
chunk-wise) processing. These functions are:

* `applyProcessing()`: parameter `f` (defaults to
  `processingChunkFactor(object)`) can be used to define how to split and
  process the data in parallel.
* `combineSpectra()`: parameter `p` (defaults to `x$dataStorage`) defines how
  the data should be split and processed in parallel.
* `estimatePrecursorIntensity()`: parameter `f` (defaults to `dataOrigin(x)`)
  defines the splitting and processing. This should represent the original data
  files the spectra data derives from.
* `intensity()`: parameter `f` (defaults to `processingChunkFactor(object)`)
  defines if and how the data should be split for parallel processing.
* `mz()`: parameter `f` (defaults to `processingChunkFactor(object)`)
  defines if and how the data should be split for parallel processing.
* `peaksData()`: parameter `f` (defaults to `processingChunkFactor(object)`)
  defines if and how the data should be split for parallel processing.
* `setBackend()`: parameter `f` (defaults to `processingChunkFactor(object)`)
  defines if and how the data should be split for parallel processing.

Functions that perform chunk-wise (parallel) processing *natively*, i.e., based
on the `processingChunkFactor`:

* `containsMz()`.
* `containsNeutralLoss()`.
* `ionCount()`.
* `isCentroided()`.
* `isEmpty()`.

# 6 Session information

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
## [1] MsCoreUtils_1.22.1  IRanges_2.44.0      Spectra_1.20.1
## [4] BiocParallel_1.44.0 S4Vectors_0.48.0    BiocGenerics_0.56.0
## [7] generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0         compiler_4.5.2         BiocManager_1.30.27
##  [4] Rcpp_1.1.0             Biobase_2.70.0         parallel_4.5.2
##  [7] cluster_2.1.8.1        jquerylib_0.1.4        yaml_2.3.12
## [10] fastmap_1.2.0          R6_2.6.1               ProtGenerics_1.42.0
## [13] knitr_1.51             MASS_7.3-65            bookdown_0.46
## [16] bslib_0.9.0            rlang_1.1.6            cachem_1.1.0
## [19] xfun_0.55              fs_1.6.6               sass_0.4.10
## [22] otel_0.2.0             cli_3.6.5              digest_0.6.39
## [25] ncdf4_1.24             mzR_2.44.0             MetaboCoreUtils_1.18.1
## [28] lifecycle_1.0.4        clue_0.3-66            evaluate_1.0.5
## [31] codetools_0.2-20       rmarkdown_2.30         tools_4.5.2
## [34] htmltools_0.5.9
```