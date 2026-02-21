# A short introduction to *MSnbase* development

Laurent Gatto1, Johannes Rainer2 and Sebastian Gibb3

1de Duve Institute, UCLouvain, Belgium
2Institute for Biomedicine, Eurac Research, Bolzano, Italy.
3Department of Anesthesiology and Intensive Care, University Medicine Greifswald, Germany.

#### 30 October 2025

#### Abstract

This vignette describes the classes implemented in package. It is intended as a starting point for developers or users who would like to learn more or further develop/extend mass spectrometry and proteomics data structures.

#### Package

MSnbase 2.36.0

# Foreword

This software is free and open-source software. If you use it, please
support the project by citing it in publications:

> Gatto L, Lilley KS. MSnbase-an R/Bioconductor package for isobaric
> tagged mass spectrometry data visualization, processing and
> quantitation. Bioinformatics. 2012 Jan 15;28(2):288-9. doi:
> [10.1093/bioinformatics/btr645](https://doi.org/10.1093/bioinformatics/btr645).
> PMID: [22113085](https://www.ncbi.nlm.nih.gov/pubmed/22113085).

> *`MSnbase`, efficient and elegant R-based processing and
> visualisation of raw mass spectrometry data*. Laurent Gatto,
> Sebastian Gibb, Johannes Rainer. bioRxiv 2020.04.29.067868; doi:
> <https://doi.org/10.1101/2020.04.29.067868>

# Questions and bugs

For bugs, typos, suggestions or other questions, please file an issue
in our tracking system (<https://github.com/lgatto/MSnbase/issues>)
providing as much information as possible, a reproducible example and
the output of `sessionInfo()`.

If you don’t have a GitHub account or wish to reach a broader audience
for general questions about proteomics analysis using R, you may want
to use the Bioconductor support site: <https://support.bioconductor.org/>.

**NB** This document is going to be updated based on current major
development plans in `MSnbase`.

# 1 Introduction

This document is not a replacement for the individual manual pages,
that document the slots of the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* classes. It is a
centralised high-level description of the package design.

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* aims at being compatible with the
*[Biobase](https://bioconductor.org/packages/3.22/Biobase)* infrastructure (Gentleman et al. [2004](#ref-Gentleman2004)). Many meta data
structures that are used in `eSet` and associated classes are also
used here. As such, knowledge of the *Biobase development and the new
eSet* vignette would be beneficial; the vignette can directly be
accessed with `vignette("BiobaseDevelopment", package="Biobase")`.

The initial goal is to use the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* infrastructure
for MS2 labelled (iTRAQ (Ross et al. [2004](#ref-Ross2004)) and TMT (Thompson et al. [2003](#ref-Thompson2003))) and
label-free (spectral counting, index and abundance) quantitation
- see the documentation for the `quantify` function for details. The
infrastructure is currently extended to support a wider range of
technologies, including metabolomics.

# 2 Coding style

`MSnbase` follows the [Bioconductor style
guide](https://bioconductor.org/developers/how-to/coding-style/). In
particular

* Do not use `.` when naming symbols.
* A leading `.` can be used for hidden/local functions or variables.
* Snake case should be restricted to internal functions. For
  consistency, we favour camel case for public functions.
* Class names should start with a capital and each class should posses
  a constructor with identical name. Running the constructor without
  any input should produce a valid empty object.
* Use `##` to start full-line comments.
* For roxygen headers `#'` is preferred, although `##'` is tolerated.
* Use spaces between `=` in function arguments or class definition:
  `f(a = 1, b = 2)`.
* Always use a space after a comma: `a, b, c`.
* Always use spaces around binary operators: `a + b`.
* Lines should be kept shorter than 80 characters. For example the
  following code isn’t accepted

```
# no wrap at 80
someVeryLongVariableName <- someVeryLongFunctionName(withSomeEvenLongerFunctionArgumentA = 1, withSomeEvenLongerFunctionArgumentB = 2)
```

and should be wrapped as shown below:

```
# alternative 1
someVeryLongVariableName <-
    someVeryLongFunctionName(withSomeEvenLongerFunctionArgumentA = 1,
                             withSomeEvenLongerFunctionArgumentB = 2)

# alternative 2
someVeryLongVariableName <- someVeryLongFunctionName(
    withSomeEvenLongerFunctionArgumentA = 1,
    withSomeEvenLongerFunctionArgumentB = 2)
```

# 3 *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* classes

All classes have a `.__classVersion__` slot, of class `Versioned` from
the *[Biobase](https://bioconductor.org/packages/3.22/Biobase)* package. This slot documents the class
version for any instance to be used for debugging and object update
purposes. Any change in a class implementation should trigger a
version change.

## 3.1 `pSet`: a virtual class for raw mass spectrometry data and meta data

This virtual class is the main container for mass spectrometry data,
i.e spectra, and meta data. It is based on the `eSet` implementation
for genomic data. The main difference with `eSet` is that the
`assayData` slot is an environment containing any number of
`Spectrum` instances (see the [`Spectrum` section](#Spectrum)).

One new slot is introduced, namely `processingData`, that contains one
`MSnProcess` instance (see the [`MSnProcess` section](#MSnProcess)).
and the `experimentData` slot is now expected to contain `MIAPE` data.
The `annotation` slot has not been implemented, as no prior feature
annotation is known in shotgun proteomics.

```
getClass("pSet")
```

```
## Virtual Class "pSet" [package "MSnbase"]
##
## Slots:
##
## Name:           assayData          phenoData        featureData
## Class:        environment AnnotatedDataFrame AnnotatedDataFrame
##
## Name:      experimentData       protocolData     processingData
## Class:              MIAxE AnnotatedDataFrame         MSnProcess
##
## Name:              .cache  .__classVersion__
## Class:        environment           Versions
##
## Extends: "Versioned"
##
## Known Subclasses:
## Class "MSnExp", directly
## Class "OnDiskMSnExp", by class "MSnExp", distance 2, with explicit coerce
```

## 3.2 `MSnExp`: a class for MS experiments

`MSnExp` extends `pSet` to store MS experiments. It does not add any
new slots to `pSet`. Accessors and setters are all inherited from
`pSet` and new ones should be implemented for `pSet`. Methods that
manipulate actual data in experiments are implemented for
`MSnExp` objects.

```
getClass("MSnExp")
```

```
## Class "MSnExp" [package "MSnbase"]
##
## Slots:
##
## Name:           assayData          phenoData        featureData
## Class:        environment AnnotatedDataFrame AnnotatedDataFrame
##
## Name:      experimentData       protocolData     processingData
## Class:              MIAxE AnnotatedDataFrame         MSnProcess
##
## Name:              .cache  .__classVersion__
## Class:        environment           Versions
##
## Extends:
## Class "pSet", directly
## Class "Versioned", by class "pSet", distance 2
##
## Known Subclasses:
## Class "OnDiskMSnExp", directly, with explicit coerce
```

## 3.3 `OnDiskMSnExp`: a on-disk implementation of the `MSnExp` class

The `OnDiskMSnExp` class extends `MSnExp` and inherits all of its
functionality but is aimed to use as little memory as possible based
on a balance between memory demand and performance. Most of the
spectrum-specific data, like retention time, polarity, total ion
current are stored within the object’s `featureData` slot. The actual
M/Z and intensity values from the individual spectra are, in contrast
to `MSnExp` objects, not kept in memory (in the `assayData` slot), but
are fetched from the original files on-demand. Because mzML files are
indexed, using the *[mzR](https://bioconductor.org/packages/3.22/mzR)* package to read the relevant
spectrum data is fast and only moderately slower than for in-memory
`MSnExp`111 The *benchmarking* vignette compares data size and operation speed of the two implementations..

To keep track of data manipulation steps that are applied to spectrum
data (such as performed by methods `removePeaks` or `clean`) a *lazy
execution* framework was implemented. Methods that manipulate or
subset a spectrum’s M/Z or intensity values can not be applied
directly to a `OnDiskMSnExp` object, since the relevant data is not
kept in memory. Thus, any call to a processing method that changes or
subset M/Z or intensity values are added as `ProcessingStep` items to
the object’s `spectraProcessingQueue`. When the spectrum data is then
queried from an `OnDiskMSnExp`, the spectra are read in from the file
and all these processing steps are applied on-the-fly to the spectrum
data before being returned to the user.

The operations involving extracting or manipulating spectrum data are
applied on a per-file basis, which enables parallel processing. Thus,
all corresponding method implementations for `OnDiskMSnExp` objects
have an argument `BPPARAM` and users can set a `PARALLEL_THRESH`
option flag222 see `?MSnbaseOptions` for details. that enables to
define how and when parallel processing should be performed (using the
*[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package).

Note that all data manipulations that are not applied to M/Z or
intensity values of a spectrum (e.g. sub-setting by retention time
etc) are very fast as they operate directly to the object’s
`featureData` slot.

```
getClass("OnDiskMSnExp")
```

```
## Class "OnDiskMSnExp" [package "MSnbase"]
##
## Slots:
##
## Name:  spectraProcessingQueue                backend              assayData
## Class:                   list              character            environment
##
## Name:               phenoData            featureData         experimentData
## Class:     AnnotatedDataFrame     AnnotatedDataFrame                  MIAxE
##
## Name:            protocolData         processingData                 .cache
## Class:     AnnotatedDataFrame             MSnProcess            environment
##
## Name:       .__classVersion__
## Class:               Versions
##
## Extends:
## Class "MSnExp", directly
## Class "pSet", by class "MSnExp", distance 2
## Class "Versioned", by class "MSnExp", distance 3
```

The distinction between `MSnExp` and `OnDiskMSnExp` is often not
explicitly stated as it should not matter, from a user’s perspective,
which data structure they are working with, as both behave in
equivalent ways. Often, they are referred to as *in-memory* and
*on-disk* `MSnExp` implementations.

## 3.4 `MSnSet`: a class for quantitative proteomics data

This class stores quantitation data and meta data after running
`quantify` on an `MSnExp` object or by creating an `MSnSet` instance
from an external file, as described in the *MSnbase-io* vignette and
in `?readMSnSet`, `readMzTabData`, etc. The quantitative data is in
form of a *n* by *p* matrix, where *n* is the number of
features/spectra originally in the `MSnExp` used as parameter in
`quantify` and *p* is the number of reporter ions. If read from an
external file, *n* corresponds to the number of features (protein
groups, proteins, peptides, spectra) in the file and \(p\) is the number
of columns with quantitative data (samples) in the file.

This prompted to keep a similar implementation as the `ExpressionSet`
class, while adding the proteomics-specific annotation slot introduced
in the `pSet` class, namely `processingData` for objects of class
`MSnProcess`.

```
getClass("MSnSet")
```

```
## Class "MSnSet" [package "MSnbase"]
##
## Slots:
##
## Name:      experimentData     processingData               qual
## Class:              MIAPE         MSnProcess         data.frame
##
## Name:           assayData          phenoData        featureData
## Class:          AssayData AnnotatedDataFrame AnnotatedDataFrame
##
## Name:          annotation       protocolData  .__classVersion__
## Class:          character AnnotatedDataFrame           Versions
##
## Extends:
## Class "eSet", directly
## Class "VersionedBiobase", by class "eSet", distance 2
## Class "Versioned", by class "eSet", distance 3
```

The `MSnSet` class extends the virtual `eSet` class to provide
compatibility for `ExpressionSet`-like behaviour. The experiment
meta-data in `experimentData` is also of class `MIAPE` . The
`annotation` slot, inherited from `eSet` is not used. As a result, it
is easy to convert `ExpressionSet` data from/to `MSnSet` objects with
the coersion method `as`.

```
data(msnset)
class(msnset)
```

```
## [1] "MSnSet"
## attr(,"package")
## [1] "MSnbase"
```

```
class(as(msnset, "ExpressionSet"))
```

```
## [1] "ExpressionSet"
## attr(,"package")
## [1] "Biobase"
```

```
data(sample.ExpressionSet)
class(sample.ExpressionSet)
```

```
## [1] "ExpressionSet"
## attr(,"package")
## [1] "Biobase"
```

```
class(as(sample.ExpressionSet, "MSnSet"))
```

```
## [1] "MSnSet"
## attr(,"package")
## [1] "MSnbase"
```

## 3.5 `MSnProcess`: a class for logging processing meta data

This class aims at recording specific manipulations applied to
`MSnExp` or `MSnSet` instances. The `processing`
slot is a `character` vector that describes major
processing. Most other slots are of class `logical` that
indicate whether the data has been centroided, smoothed,
although many of the functionality is not implemented yet. Any new
processing that is implemented should be documented and logged here.

It also documents the raw data file from which the data originates
(`files` slot) and the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* version that was in
use when the `MSnProcess` instance, and hence the
`MSnExp`/`MSnSet` objects, were originally created.

```
getClass("MSnProcess")
```

```
## Class "MSnProcess" [package "MSnbase"]
##
## Slots:
##
## Name:              files        processing            merged           cleaned
## Class:         character         character           logical           logical
##
## Name:       removedPeaks          smoothed           trimmed        normalised
## Class:         character           logical           numeric           logical
##
## Name:     MSnbaseVersion .__classVersion__
## Class:         character          Versions
##
## Extends: "Versioned"
```

## 3.6 `MIAPE`: Minimum Information About a Proteomics Experiment

The Minimum Information About a Proteomics Experiment
(Taylor et al. [2007](#ref-Taylor2007), [2008](#ref-Taylor2008)) `MIAPE` class describes the experiment,
including contact details, information about the mass spectrometer and
control and analysis software.

```
getClass("MIAPE")
```

```
## Class "MIAPE" [package "MSnbase"]
##
## Slots:
##
## Name:                     title                      url
## Class:                character                character
##
## Name:                  abstract                pubMedIds
## Class:                character                character
##
## Name:                   samples            preprocessing
## Class:                     list                     list
##
## Name:                     other                dateStamp
## Class:                     list                character
##
## Name:                      name                      lab
## Class:                character                character
##
## Name:                   contact                    email
## Class:                character                character
##
## Name:           instrumentModel   instrumentManufacturer
## Class:                character                character
##
## Name:  instrumentCustomisations             softwareName
## Class:                character                character
##
## Name:           softwareVersion        switchingCriteria
## Class:                character                character
##
## Name:            isolationWidth            parameterFile
## Class:                  numeric                character
##
## Name:                 ionSource         ionSourceDetails
## Class:                character                character
##
## Name:                  analyser          analyserDetails
## Class:                character                character
##
## Name:              collisionGas        collisionPressure
## Class:                character                  numeric
##
## Name:           collisionEnergy             detectorType
## Class:                character                character
##
## Name:       detectorSensitivity        .__classVersion__
## Class:                character                 Versions
##
## Extends:
## Class "MIAxE", directly
## Class "Versioned", by class "MIAxE", distance 2
```

## 3.7 `Spectrum` *et al.*: classes for MS spectra

`Spectrum` is a virtual class that defines common attributes to all
types of spectra. MS1 and MS2 specific attributes are defined in the
`Spectrum1` and `Spectrum2` classes, that directly extend `Spectrum`.

```
getClass("Spectrum")
```

```
## Virtual Class "Spectrum" [package "MSnbase"]
##
## Slots:
##
## Name:            msLevel        peaksCount                rt    acquisitionNum
## Class:           integer           integer           numeric           integer
##
## Name:          scanIndex               tic                mz         intensity
## Class:           integer           numeric           numeric           numeric
##
## Name:           fromFile        centroided          smoothed          polarity
## Class:           integer           logical           logical           integer
##
## Name:  .__classVersion__
## Class:          Versions
##
## Extends: "Versioned"
##
## Known Subclasses: "Spectrum2", "Spectrum1"
```

```
getClass("Spectrum1")
```

```
## Class "Spectrum1" [package "MSnbase"]
##
## Slots:
##
## Name:            msLevel        peaksCount                rt    acquisitionNum
## Class:           integer           integer           numeric           integer
##
## Name:          scanIndex               tic                mz         intensity
## Class:           integer           numeric           numeric           numeric
##
## Name:           fromFile        centroided          smoothed          polarity
## Class:           integer           logical           logical           integer
##
## Name:  .__classVersion__
## Class:          Versions
##
## Extends:
## Class "Spectrum", directly
## Class "Versioned", by class "Spectrum", distance 2
```

```
getClass("Spectrum2")
```

```
## Class "Spectrum2" [package "MSnbase"]
##
## Slots:
##
## Name:              merged        precScanNum        precursorMz
## Class:            numeric            integer            numeric
##
## Name:  precursorIntensity    precursorCharge    collisionEnergy
## Class:            numeric            integer            numeric
##
## Name:             msLevel         peaksCount                 rt
## Class:            integer            integer            numeric
##
## Name:      acquisitionNum          scanIndex                tic
## Class:            integer            integer            numeric
##
## Name:                  mz          intensity           fromFile
## Class:            numeric            numeric            integer
##
## Name:          centroided           smoothed           polarity
## Class:            logical            logical            integer
##
## Name:   .__classVersion__
## Class:           Versions
##
## Extends:
## Class "Spectrum", directly
## Class "Versioned", by class "Spectrum", distance 2
```

## 3.8 `ReporterIons`: a class for isobaric tags

The iTRAQ and TMT (or any other peak of interest) are implemented
`ReporterIons` instances, that essentially defines an expected MZ
position for the peak and a width around this value as well a names
for the reporters.

```
getClass("ReporterIons")
```

```
## Class "ReporterIons" [package "MSnbase"]
##
## Slots:
##
## Name:               name     reporterNames       description                mz
## Class:         character         character         character           numeric
##
## Name:                col             width .__classVersion__
## Class:         character           numeric          Versions
##
## Extends: "Versioned"
```

## 3.9 `Chromatogram` and `MChromatograms`: classes to handle chromatographic data

The `Chromatogram` class represents chromatographic MS data, i.e. retention time
and intensity duplets for one file/sample. The `MChromatograms` class (Matrix of
Chromatograms) allows to arrange multiple `Chromatogram` instances in a
two-dimensional grid, with columns supposed to represent different samples and
rows two-dimensional areas in the plane spanned by the m/z and retention time
dimensions from which the intensities are extracted (e.g. an extracted ion
chromatogram for a specific ion). The `MChromatograms` class extends the base
`matrix` class. `MChromatograms` objects can be extracted from an `MSnExp` or
`OnDiskMSnExp` object using the `chromatogram` method.

```
getClass("Chromatogram")
```

```
## Class "Chromatogram" [package "MSnbase"]
##
## Slots:
##
## Name:              rtime         intensity                mz          filterMz
## Class:           numeric           numeric           numeric           numeric
##
## Name:        precursorMz         productMz          fromFile    aggregationFun
## Class:           numeric           numeric           integer         character
##
## Name:            msLevel .__classVersion__
## Class:           integer          Versions
##
## Extends: "Versioned"
```

```
getClass("MChromatograms")
```

```
## Class "MChromatograms" [package "MSnbase"]
##
## Slots:
##
## Name:               .Data          phenoData        featureData
## Class:             matrix AnnotatedDataFrame AnnotatedDataFrame
##
## Extends:
## Class "matrix", from data part
## Class "array", by class "matrix", distance 2
## Class "dataframeOrDataFrameOrmatrix", by class "matrix", distance 2
## Class "structure", by class "matrix", distance 3
## Class "matrix_OR_array_OR_table_OR_numeric", by class "matrix", distance 3
## Class "vector", by class "matrix", distance 4, with explicit coerce
## Class "vector_OR_factor", by class "matrix", distance 5, with explicit coerce
## Class "vector_OR_Vector", by class "matrix", distance 5, with explicit coerce
```

## 3.10 Other classes

### Lists of `MSnSet` instances

When several `MSnSet` instances are related to each other and should
be stored together as different objects, they can be grouped as a list
into and `MSnSetList` object. In addition to the actual `list` slot,
this class also has basic logging functionality and enables iteration
over the `MSnSet` instances using a dedicated `lapply` methods.

```
getClass("MSnSetList")
```

```
## Class "MSnSetList" [package "MSnbase"]
##
## Slots:
##
## Name:                  x               log       featureData .__classVersion__
## Class:              list              list         DataFrame          Versions
##
## Extends: "Versioned"
```

# 4 Miscellaneous

#### Unit tests

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* implements unit tests with the
*[testthat](https://CRAN.R-project.org/package%3Dtestthat)* package.

#### Processing methods

Methods that process raw data, i.e. spectra should be implemented for
`Spectrum` objects first and then `eapply`ed (or similar) to the
`assayData` slot of an `MSnExp` instance in the specific method.

# 5 Session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] microbenchmark_1.5.0 pryr_0.1.6           magrittr_2.0.4
##  [4] gplots_3.2.0         msdata_0.49.0        pRoloc_1.50.0
##  [7] BiocParallel_1.44.0  MLInterfaces_1.90.0  cluster_2.1.8.1
## [10] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
## [13] IRanges_2.44.0       pRolocdata_1.47.0    Rdisop_1.70.0
## [16] zoo_1.8-14           MSnbase_2.36.0       ProtGenerics_1.42.0
## [19] S4Vectors_0.48.0     mzR_2.44.0           Rcpp_1.1.0
## [22] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [25] ggplot2_4.0.0        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               bitops_1.0-9
##   [3] filelock_1.0.3              tibble_3.3.0
##   [5] hardhat_1.4.2               preprocessCore_1.72.0
##   [7] pROC_1.19.0.1               rpart_4.1.24
##   [9] lifecycle_1.0.4             httr2_1.2.1
##  [11] doParallel_1.0.17           globals_0.18.0
##  [13] lattice_0.22-7              MASS_7.3-65
##  [15] MultiAssayExperiment_1.36.0 dendextend_1.19.1
##  [17] limma_3.66.0                plotly_4.11.0
##  [19] sass_0.4.10                 rmarkdown_2.30
##  [21] jquerylib_0.1.4             yaml_2.3.10
##  [23] lobstr_1.1.2                MsCoreUtils_1.22.0
##  [25] DBI_1.2.3                   RColorBrewer_1.1-3
##  [27] lubridate_1.9.4             multcomp_1.4-29
##  [29] abind_1.4-8                 GenomicRanges_1.62.0
##  [31] purrr_1.1.0                 mixtools_2.0.0.1
##  [33] AnnotationFilter_1.34.0     TH.data_1.1-4
##  [35] nnet_7.3-20                 sandwich_3.1-1
##  [37] rappdirs_0.3.3              ipred_0.9-15
##  [39] lava_1.8.1                  listenv_0.9.1
##  [41] parallelly_1.45.1           ncdf4_1.24
##  [43] codetools_0.2-20            DelayedArray_0.36.0
##  [45] tidyselect_1.2.1            Spectra_1.20.0
##  [47] farver_2.1.2                viridis_0.6.5
##  [49] matrixStats_1.5.0           BiocFileCache_3.0.0
##  [51] Seqinfo_1.0.0               jsonlite_2.0.0
##  [53] caret_7.0-1                 e1071_1.7-16
##  [55] survival_3.8-3              iterators_1.0.14
##  [57] foreach_1.5.2               segmented_2.1-4
##  [59] tools_4.5.1                 progress_1.2.3
##  [61] glue_1.8.0                  prodlim_2025.04.28
##  [63] gridExtra_2.3               SparseArray_1.10.0
##  [65] BiocBaseUtils_1.12.0        mgcv_1.9-3
##  [67] xfun_0.53                   MatrixGenerics_1.22.0
##  [69] dplyr_1.1.4                 withr_3.0.2
##  [71] BiocManager_1.30.26         fastmap_1.2.0
##  [73] caTools_1.18.3              digest_0.6.37
##  [75] timechange_0.3.0            R6_2.6.1
##  [77] colorspace_2.1-2            gtools_3.9.5
##  [79] lpSolve_5.6.23              dichromat_2.0-0.1
##  [81] biomaRt_2.66.0              RSQLite_2.4.3
##  [83] tidyr_1.3.1                 hexbin_1.28.5
##  [85] data.table_1.17.8           recipes_1.3.1
##  [87] FNN_1.1.4.1                 class_7.3-23
##  [89] prettyunits_1.2.0           PSMatch_1.14.0
##  [91] httr_1.4.7                  htmlwidgets_1.6.4
##  [93] S4Arrays_1.10.0             ModelMetrics_1.2.2.2
##  [95] pkgconfig_2.0.3             gtable_0.3.6
##  [97] timeDate_4051.111           blob_1.2.4
##  [99] S7_0.2.0                    impute_1.84.0
## [101] XVector_0.50.0              htmltools_0.5.8.1
## [103] bookdown_0.45               MALDIquant_1.22.3
## [105] clue_0.3-66                 scales_1.4.0
## [107] png_0.1-8                   gower_1.0.2
## [109] knitr_1.50                  MetaboCoreUtils_1.18.0
## [111] reshape2_1.4.4              coda_0.19-4.1
## [113] nlme_3.1-168                curl_7.0.0
## [115] proxy_0.4-27                cachem_1.1.0
## [117] stringr_1.5.2               KernSmooth_2.23-26
## [119] parallel_4.5.1              mzID_1.48.0
## [121] vsn_3.78.0                  pillar_1.11.1
## [123] vctrs_0.6.5                 pcaMethods_2.2.0
## [125] randomForest_4.7-1.2        dbplyr_2.5.1
## [127] xtable_1.8-4                evaluate_1.0.5
## [129] magick_2.9.0                tinytex_0.57
## [131] mvtnorm_1.3-3               cli_3.6.5
## [133] compiler_4.5.1              rlang_1.1.6
## [135] crayon_1.5.3                future.apply_1.20.0
## [137] labeling_0.4.3              LaplacesDemon_16.1.6
## [139] mclust_6.1.1                QFeatures_1.20.0
## [141] affy_1.88.0                 plyr_1.8.9
## [143] fs_1.6.6                    stringi_1.8.7
## [145] viridisLite_0.4.2           Biostrings_2.78.0
## [147] lazyeval_0.2.2              Matrix_1.7-4
## [149] hms_1.1.4                   bit64_4.6.0-1
## [151] future_1.67.0               KEGGREST_1.50.0
## [153] statmod_1.5.1               SummarizedExperiment_1.40.0
## [155] kernlab_0.9-33              igraph_2.2.1
## [157] memoise_2.0.1               affyio_1.80.0
## [159] bslib_0.9.0                 sampling_2.11
## [161] bit_4.6.0
```

# References

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biol* 5 (10): –80. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Ross, Philip L., Yulin N. Huang, Jason N. Marchese, Brian Williamson, Kenneth Parker, Stephen Hattan, Nikita Khainovski, et al. 2004. “Multiplexed Protein Quantitation in Saccharomyces Cerevisiae Using Amine-Reactive Isobaric Tagging Reagents.” *Mol Cell Proteomics* 3 (12): 1154–69. <https://doi.org/10.1074/mcp.M400129-MCP200>.

Taylor, Chris F, Pierre-Alain Binz, Ruedi Aebersold, Michel Affolter, Robert Barkovich, Eric W Deutsch, David M Horn, et al. 2008. “Guidelines for Reporting the Use of Mass Spectrometry in Proteomics.” *Nat. Biotechnol.* 26 (8): 860–1. <https://doi.org/10.1038/nbt0808-860>.

Taylor, Chris F., Norman W. Paton, Kathryn S. Lilley, Pierre-Alain Binz, Randall K. Julian, Andrew R. Jones, Weimin Zhu, et al. 2007. “The Minimum Information About a Proteomics Experiment (Miape).” *Nat Biotechnol* 25 (8): 887–93. <https://doi.org/10.1038/nbt1329>.

Thompson, Andrew, Jürgen Schäfer, Karsten Kuhn, Stefan Kienle, Josef Schwarz, Günter Schmidt, Thomas Neumann, R Johnstone, A Karim A Mohammed, and Christian Hamon. 2003. “Tandem Mass Tags: A Novel Quantification Strategy for Comparative Analysis of Complex Protein Mixtures by MS/MS.” *Anal. Chem.* 75 (8): 1895–1904.