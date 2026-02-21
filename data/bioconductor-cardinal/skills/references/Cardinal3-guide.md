# *Cardinal 3*: User guide for mass spectrometry imaging analysis

Kylie Ariel Bemis

#### Revised: 1 September 2024

# Contents

* [1 Introduction](#introduction)
  + [1.1 Latest: Cardinal 3.6](#latest-cardinal-3.6)
  + [1.2 Previous updates from Cardinal 3](#previous-updates-from-cardinal-3)
  + [1.3 Previous updates from Cardinal 2](#previous-updates-from-cardinal-2)
* [2 Installation](#installation)
* [3 Data import](#data-import)
  + [3.1 Reading “continuous” imzML](#reading-continuous-imzml)
  + [3.2 Reading “processed” imzML](#reading-processed-imzml)
* [4 Data structures for MS imaging](#data-structures-for-ms-imaging)
  + [4.1 `MSImagingArrays`: Mass spectra with differing *m/z* values](#msimagingarrays-mass-spectra-with-differing-mz-values)
    - [4.1.1 Accessing spectra arrays with `spectraData()`](#accessing-spectra-arrays-with-spectradata)
    - [4.1.2 Accessing pixel metadata with `pixelData()`](#accessing-pixel-metadata-with-pixeldata)
  + [4.2 `MSImagingExperiment`: Mass spectra with shared *m/z* values](#msimagingexperiment-mass-spectra-with-shared-mz-values)
    - [4.2.1 Accessing feature metadata with `featureData()`](#accessing-feature-metadata-with-featuredata)
    - [4.2.2 Building from scratch](#building-from-scratch)
* [5 Visualization](#visualization)
  + [5.1 Visualizing spectra with `plot()`](#visualizing-spectra-with-plot)
  + [5.2 Visualizing images with `image()`](#visualizing-images-with-image)
  + [5.3 Region-of-interest selection](#region-of-interest-selection)
  + [5.4 Saving plots and images](#saving-plots-and-images)
  + [5.5 Dark themes](#dark-themes)
  + [5.6 A note on plotting speed](#a-note-on-plotting-speed)
* [6 Common operations on MS imaging datasets](#common-operations-on-ms-imaging-datasets)
  + [6.1 Subsetting](#subsetting)
    - [6.1.1 Finding indices of mass spectra and images](#finding-indices-of-mass-spectra-and-images)
    - [6.1.2 Using `subset()` and friends](#using-subset-and-friends)
  + [6.2 Slicing](#slicing)
  + [6.3 Combining](#combining)
  + [6.4 Getters and setters](#getters-and-setters)
  + [6.5 Summarization (e.g., mean spectra, TIC, etc.)](#summarization-e.g.-mean-spectra-tic-etc.)
  + [6.6 Loading data into memory](#loading-data-into-memory)
  + [6.7 Coercion to/from other classes](#coercion-tofrom-other-classes)
* [7 Pre-processing](#pre-processing)
  + [7.1 Normalization](#normalization)
  + [7.2 Smoothing](#smoothing)
  + [7.3 Baseline subtraction](#baseline-subtraction)
  + [7.4 Recalibration](#recalibration)
  + [7.5 Peak processing](#peak-processing)
    - [7.5.1 Peak picking](#peak-picking)
    - [7.5.2 Peak alignment](#peak-alignment)
    - [7.5.3 Peak filtering](#peak-filtering)
    - [7.5.4 Peak picking based on a reference](#peak-picking-based-on-a-reference)
    - [7.5.5 Using `peakProcess()`](#using-peakprocess)
  + [7.6 Binning](#binning)
  + [7.7 Example processing workflow](#example-processing-workflow)
* [8 Data export](#data-export)
* [9 Parallel computing using *BiocParallel*](#parallel-computing-using-biocparallel)
  + [9.1 Using `BPPARAM`](#using-bpparam)
  + [9.2 Backend types](#backend-types)
  + [9.3 Getting available backends](#getting-available-backends)
  + [9.4 Setting a parallel backend](#setting-a-parallel-backend)
  + [9.5 RNG and reproducibility](#rng-and-reproducibility)
* [10 Statistical methods](#statistical-methods)
* [11 Session information](#session-information)

# 1 Introduction

## 1.1 Latest: Cardinal 3.6

*Cardinal 3.6* is a major update with breaking changes. It bring support many of the new low-level signal processing functions implemented for *matter 2.4* and *matter 2.6*. Almost the entire *Cardinal* codebase has been refactored to support these improvements.

The most notable of the new features include:

* Redesign class hierarchy that includes a greater emphasis on spectra: `SpectralImagingData`, `SpectralImagingArrays`, and `SpectralImagingExperiment` lay the groundwork for the new data structures
* Updated `MSImagingExperiment` class with a new counterpart `MSImagingArrays` class for better representing raw spectra.
* New spectral processing methods in `smooth()`:

  + Improved Gaussian filtering
  + Bilateral and adaptive bilateral filtering
  + Nonlinear diffusion filtering
  + Guided filtering
  + Peak-aware guided filtering
  + Savitsky-Golay smoothing
* New spectral baseline reduction methods in `reduceBaseline()`:

  + Interpolation from local minima
  + Convex hull estimation
  + Sensitive nonlinear iterative peak (SNIP) clipping
  + Running medians
* New spectral alignment methods in `recalibrate()`:

  + Local maxima-based alignment using local regression
  + Dynamic time warping
  + Correlation optimized warping
* New peak picking methods in `peakPick()`:

  + Derivative-based noise estimation
  + Quantile-based noise estimation
  + SD/MAD-based noise estimatino
  + Dynamic peak filtering
  + Continuous wavelet transform (CWT)
* Improved `image()` contrast enhancement via `enhance`:

  + Improved histogram equalization
  + Contrast-limited adaptive histogram equalization (CLAHE)
* Improved `image()` spatial smoothing via `smooth`:

  + Improved Gaussian filtering
  + Bilateral and adaptive bilateral filtering
  + Nonlinear diffusion filtering
  + Guided filtering
* All statistical methods improved and updated

  + New and improved `crossValidate()` method
  + New dimension reduction method `NMF()`
  + Updated `PCA()` and `spatialFastmap()`
  + Updated `PLS()` and `OPLS()` with new algorithms
  + Updated `spatialKMeans()` with better initializations
  + Updated `spatialShrunkenCentroids()` with better initializations
  + Updated `spatialDGMM()` with improved stability
  + Updated `meansTest()` with improved data preparation
  + New `SpatialResults` output with simplified interface

And many other updates! Many redundant functions and methods have been merged to simplify and streamline workflows. Many unnecessary functions and methods have been deprecated.

Major improvements from earlier versions are further described below.

## 1.2 Previous updates from Cardinal 3

*Cardinal 3* lays the groundwork for future improvements to the existing toolbox of pre-processing, visualization, and statistical methods for mass spectrometry (MS) imaging experiments. *Cardinal* has been updated to support *matter 2*, and legacy support has been dropped.

Despite minimal user-visible changes in *Cardinal* (at first), the entire *matter* package that provides the backend for *Cardinal*’s computing on larger-than-memory MS imaging datasets has been rewritten. This should provide more robust support for larger-than-memory computations, as well as greater flexibility in handling many data files in the future.

Further changes will be coming soon to *Cardinal 3* in future point updates that are aimed to greatly improve the user experience and simplify the code that users need to write to process and analyze MS imaging data.

Major improvements from earlier versions are further described below.

## 1.3 Previous updates from Cardinal 2

*Cardinal 2* provides new classes and methods for the manipulation, transformation, visualization, and analysis of imaging experiments–specifically MS imaging experiments.

MS imaging is a rapidly advancing field with consistent improvements in instrumentation for both MALDI and DESI imaging experiments. Both mass resolution and spatial resolution are steadily increasing, and MS imaging experiments grow increasingly complex.

The first version of *Cardinal* was written with certain assumptions about MS imaging data that are no longer true. For example, the basic assumption that the raw spectra can be fully loaded into memory is unreasonable for many MS imaging experiments today.

*Cardinal 2* was re-written from the ground up to handle the evolving needs of high-resolution MS imaging experiments. Some advancements include:

* New imaging experiment classes such as `ImagingExperiment`, `SparseImagingExperiment`, and `MSImagingExperiment` provide better support for out-of-memory datasets and a more flexible representation of complex experiments
* New imaging metadata classes such as `PositionDataFrame` and `MassDataFrame` make it easier to manipulate experimental runs, pixel coordinates, and *m/z*-values by storing them as separate slots rather than ordinary columns
* New `plot()` and `image()` visualization methods that can handle non-gridded pixel coordinates and allow assigning the resulting plot (and data) to a variable for later re-plotting
* Support for writing imzML in addition to reading it; more options and support for importing out-of-memory imzML for both *“continuous”* and *“processed”* formats
* Data manipulation and summarization verbs such as `subset()`, `aggregate()`, and `summarizeFeatures()`, etc. for easier subsetting and summarization of imaging datasets
* Delayed pre-processing via a new `process()` method that allows queueing of delayed pre-processing methods such as `normalize()` and `peakPick()` for later execution
* Parallel processing support via the *BiocParallel* package for all pre-processing methods and any statistical analysis methods with a `BPPARAM` option

Classes from older versions of Cardinal should be coerced to their *Cardinal 2* equivalents. For example, to return an updated `MSImageSet` object called `x`, use `as(x, "MSImagingExperiment")`.

# 2 Installation

*Cardinal* can be installed via the *BiocManager* package.

```
install.packages("BiocManager")
BiocManager::install("Cardinal")
```

The same function can be used to update *Cardinal* and other Bioconductor packages.

Once installed, *Cardinal* can be loaded with `library()`:

```
library(Cardinal)
```

# 3 Data import

*Cardinal* natively supports reading and writing imzML (both “continuous” and “processed” types) and Analyze 7.5 formats via the `readMSIData()` and `writeMSIData()` functions.

The imzML format is an open standard designed specifically for interchange of mass spectrometry imaging datasets. Vendor-specific raw formats can be converted to imzML with the help of free applications available online at .

## 3.1 Reading “continuous” imzML

We can read an example of a “continuous” imzML file from the `CardinalIO` package:

```
path_continuous <- CardinalIO::exampleImzMLFile("continuous")
path_continuous
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/CardinalIO/extdata/Example_Continuous_imzML1.1.1/Example_Continuous.imzML"
```

```
mse_tiny <- readMSIData(path_continuous)
mse_tiny
```

```
## MSImagingExperiment with 8399 features and 9 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...3
## runNames(1): Example_Continuous
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## mass range: 100.0833 to 799.9167
## centroided: FALSE
```

A “continuous” imzML file contains mass spectra where all of the spectra have the same *m/z* values. It is returned as an `MSImagingExperiment` object, which contains both the spectra and the experimental metadata.

## 3.2 Reading “processed” imzML

We can also read an example of a “processed” imzML file from the `CardinalIO` package:

```
path_processed <- CardinalIO::exampleImzMLFile("processed")
path_processed
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/CardinalIO/extdata/Example_Processed_imzML1.1.1/Example_Processed.imzML"
```

```
msa_tiny <- readMSIData(path_processed)
msa_tiny
```

```
## MSImagingArrays with 9 spectra
## spectraData(2): intensity, mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...3
## runNames(1): Example_Processed
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## centroided: FALSE
## continuous: FALSE
```

A “processed” imzML file contains mass spectra where each spectrum has its own *m/z* values. Despite the name, it can still contain profile spectra. For “processed” imzML, the data is returned as an `MSImagingArrays` object.

# 4 Data structures for MS imaging

*Cardinal 3.6* introduces a simple set of new data structures for organizing data from MS imaging experiments.

![](data:image/png;base64...)

Cardinal classes

* `SpectraArrays`: Storage for high-throughput spectra
* `SpectralImagingData`: Virtual container for spectral imaging data, i.e., spectra with spatial metadata
* `MSImagingArrays`: Specializes `SpectralImagingData` (via `SpectralImagingArrays`) for representing raw mass spectra where each spectrum has its own *m/z* values
* `MSImagingExperiment`: Specializes `SpectralImagingData` (via `SpectralImagingExperiment`) for representing mass spectra where all spectra have the same *m/z* values

These are further explored in the next sections.

## 4.1 `MSImagingArrays`: Mass spectra with differing *m/z* values

In *Cardinal*, mass spectral data with differing *m/z* values are stored in `MSImagingArrays` objects.

```
msa_tiny
```

```
## MSImagingArrays with 9 spectra
## spectraData(2): intensity, mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...3
## runNames(1): Example_Processed
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## centroided: FALSE
## continuous: FALSE
```

An `MSImagingArrays` object is conceptually a list of mass spectra with a companion data frame of spectrum-level pixel metadata.

This dataset contains 9 mass spectra. It can be subset like a list:

```
msa_tiny[1:3]
```

```
## MSImagingArrays with 3 spectra
## spectraData(2): intensity, mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...1
## runNames(1): Example_Processed
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## centroided: FALSE
## continuous: FALSE
```

### 4.1.1 Accessing spectra arrays with `spectraData()`

The spectral data can be accessed with `spectraData()`.

```
spectraData(msa_tiny)
```

```
## SpectraArrays of length 2
##        names(2):   intensity          mz
##        class(2): matter_list matter_list
##       length(2):         <9>         <9>
##     real mem(2):     6.75 KB     6.75 KB
##   shared mem(2):        0 KB        0 KB
##  virtual mem(2):   302.37 KB   302.37 KB
```

The list of spectral data arrays are stored in a `SpectraArrays` object. An `MSImagingArrays` object must have at least two arrays named “mz” and “intensity”, which are lists of the m/z arrays and intensity arrays.

The `spectra()` accessor can be used to access specific spectra arrays.

```
spectra(msa_tiny, "mz")
```

```
## <9 length> matter_list :: out-of-core list
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=1 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=2 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=3 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=4 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=5 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=6 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

```
spectra(msa_tiny, "intensity")
```

```
## <9 length> matter_list :: out-of-core list
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=1   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=2   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=3   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=4   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=5   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=6   0   0   0   0   0   0 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

Alternatively, we can use the `mz()` and `intensity()` accessors to get these specific arrays.

```
mz(msa_tiny)
```

```
## <9 length> matter_list :: out-of-core list
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=1 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=2 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=3 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=4 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=5 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
##              [1]      [2]      [3]      [4]      [5]      [6] ...
## $Scan=6 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

```
intensity(msa_tiny)
```

```
## <9 length> matter_list :: out-of-core list
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=1   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=2   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=3   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=4   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=5   0   0   0   0   0   0 ...
##         [1] [2] [3] [4] [5] [6] ...
## $Scan=6   0   0   0   0   0   0 ...
## ...
## (6.75 KB real | 0 bytes shared | 302.37 KB virtual)
```

Note that the full spectra are not fully loaded into memory. Instead, they are represented as out-of-memory `matter` lists. For the most part, these lists can be treated as ordinary R lists, but the spectra are only loaded from storage on-the-fly as they are accessed.

### 4.1.2 Accessing pixel metadata with `pixelData()`

The spectrum-level pixel metadata can be accessed with `pixelData()`. Alternatively, `pData()` is a shorter alias that does the same thing.

```
pixelData(msa_tiny)
```

```
## PositionDataFrame with 9 rows and 3 columns
##                x         y               run
##        <numeric> <numeric>          <factor>
## Scan=1         1         1 Example_Processed
## Scan=2         2         1 Example_Processed
## Scan=3         3         1 Example_Processed
## Scan=4         1         2 Example_Processed
## Scan=5         2         2 Example_Processed
## Scan=6         3         2 Example_Processed
## Scan=7         1         3 Example_Processed
## Scan=8         2         3 Example_Processed
## Scan=9         3         3 Example_Processed
## coord(2): x, y
## run(1): run
```

```
pData(msa_tiny)
```

```
## PositionDataFrame with 9 rows and 3 columns
##                x         y               run
##        <numeric> <numeric>          <factor>
## Scan=1         1         1 Example_Processed
## Scan=2         2         1 Example_Processed
## Scan=3         3         1 Example_Processed
## Scan=4         1         2 Example_Processed
## Scan=5         2         2 Example_Processed
## Scan=6         3         2 Example_Processed
## Scan=7         1         3 Example_Processed
## Scan=8         2         3 Example_Processed
## Scan=9         3         3 Example_Processed
## coord(2): x, y
## run(1): run
```

The pixel metadata is stored in a `PositionDataFrame`, with a row for each mass spectrum in the dataset. This data frame stores position information, run information, and all other spectrum-level metadata.

The `coord()` accessor retrieves the columns giving the positions of the spectra.

```
coord(msa_tiny)
```

```
## DataFrame with 9 rows and 2 columns
##                x         y
##        <numeric> <numeric>
## Scan=1         1         1
## Scan=2         2         1
## Scan=3         3         1
## Scan=4         1         2
## Scan=5         2         2
## Scan=6         3         2
## Scan=7         1         3
## Scan=8         2         3
## Scan=9         3         3
```

Use `runNames()` to access the names of the experimental runs (by default set to the file name) and `run()` to access the run for each spectrum.

```
runNames(msa_tiny)
```

```
## [1] "Example_Processed"
```

```
head(run(msa_tiny))
```

```
## [1] Example_Processed Example_Processed Example_Processed Example_Processed
## [5] Example_Processed Example_Processed
## Levels: Example_Processed
```

This data frame is also used to store any other spectrum-level metadata or statistical summaries.

## 4.2 `MSImagingExperiment`: Mass spectra with shared *m/z* values

In *Cardinal*, mass spectral data with the same *m/z* values are stored in `MSImagingExperiment` objects.

```
mse_tiny
```

```
## MSImagingExperiment with 8399 features and 9 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...3
## runNames(1): Example_Continuous
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## mass range: 100.0833 to 799.9167
## centroided: FALSE
```

An `MSImagingExperiment` object is conceptually a matrix where the mass spectra are columns. The rows represent the flattened images for each mass feature.

This dataset contains 9 mass spectra each with the same 8,399 *m/z* values. It can be subset like a matrix:

```
mse_tiny[1:500, 1:3]
```

```
## MSImagingExperiment with 500 features and 3 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...1
## runNames(1): Example_Continuous
## experimentData(14): spectrumType, spectrumRepresentation, contactName, ..., scanType, lineScanDirection, pixelSize
## mass range: 100.0833 to 141.6667
## centroided: FALSE
```

For an `MSImagingExperiment`, the spectral data are stored as a single matrix of intensities that can be accessed with `spectra()`.

```
spectraData(mse_tiny)
```

```
## SpectraArrays of length 1
##        names(1):  intensity
##        class(1): matter_mat
##          dim(1): <8399 x 9>
##     real mem(1):    7.16 KB
##   shared mem(1):       0 KB
##  virtual mem(1):  302.37 KB
```

```
spectra(mse_tiny)
```

```
## <8399 row x 9 col> matter_mat :: out-of-core double matrix
##      Scan=1 Scan=2 Scan=3 Scan=4 Scan=5 Scan=6 ...
## [1,]      0      0      0      0      0      0 ...
## [2,]      0      0      0      0      0      0 ...
## [3,]      0      0      0      0      0      0 ...
## [4,]      0      0      0      0      0      0 ...
## [5,]      0      0      0      0      0      0 ...
## [6,]      0      0      0      0      0      0 ...
## ...     ...    ...    ...    ...    ...    ... ...
## (7.16 KB real | 0 bytes shared | 302.37 KB virtual)
```

The spectrum-level pixel metadata is accessible via `pixelData()` just like `MSImagingArrays`.

```
pixelData(mse_tiny)
```

```
## PositionDataFrame with 9 rows and 3 columns
##                x         y                run
##        <numeric> <numeric>           <factor>
## Scan=1         1         1 Example_Continuous
## Scan=2         2         1 Example_Continuous
## Scan=3         3         1 Example_Continuous
## Scan=4         1         2 Example_Continuous
## Scan=5         2         2 Example_Continuous
## Scan=6         3         2 Example_Continuous
## Scan=7         1         3 Example_Continuous
## Scan=8         2         3 Example_Continuous
## Scan=9         3         3 Example_Continuous
## coord(2): x, y
## run(1): run
```

The primary difference between `MSImagingExperiment` and `MSImagingArrays` is that that all of spectra share the same *m/z* values, so `MSImagingExperiment` can store feature metadata.

### 4.2.1 Accessing feature metadata with `featureData()`

The feature metadata can be accessed with `featureData()`. Alternatively, `fData()` is a shorter alias that does the same thing.

```
featureData(mse_tiny)
```

```
## MassDataFrame with 8399 rows and 1 column
##             mz
##      <numeric>
## 1      100.083
## 2      100.167
## 3      100.250
## 4      100.333
## 5      100.417
## ...        ...
## 8395   799.583
## 8396   799.667
## 8397   799.750
## 8398   799.833
## 8399   799.917
## mz(1): mz
```

```
fData(mse_tiny)
```

```
## MassDataFrame with 8399 rows and 1 column
##             mz
##      <numeric>
## 1      100.083
## 2      100.167
## 3      100.250
## 4      100.333
## 5      100.417
## ...        ...
## 8395   799.583
## 8396   799.667
## 8397   799.750
## 8398   799.833
## 8399   799.917
## mz(1): mz
```

Because all of the mass spectra share the same *m/z* values, a single vector of *m/z* values can be accessed using `mz()`.

```
head(mz(mse_tiny))
```

```
## [1] 100.0833 100.1667 100.2500 100.3333 100.4167 100.5000
```

This data frame is also used to store any other feature-level metadata or statistical summaries.

### 4.2.2 Building from scratch

Typically data is read into R using `readMSIData()`, but sometimes it is necessary to build a `MSImagingExperiment` object from scratch. This may be necessary if trying to import data formats other than imzML or Analyze 7.5.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
s <- simulateSpectra(n=9, npeaks=10, from=500, to=600)

coord <- expand.grid(x=1:3, y=1:3)
run <- factor(rep("run0", nrow(coord)))

fdata <- MassDataFrame(mz=s$mz)
pdata <- PositionDataFrame(run=run, coord=coord)

out <- MSImagingExperiment(spectraData=s$intensity,
    featureData=fdata,
    pixelData=pdata)
out
```

```
## MSImagingExperiment with 456 features and 9 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(3): x, y, run
## coord(2): x = 1...3, y = 1...3
## runNames(1): run0
## mass range: 500.0000 to 599.8071
## centroided: NA
```

For loading other data formats into R, `read.csv()` and `read.table()` can be used to read CSV and tab-delimited text files, respectively.

Likewise, `write.csv()` and `write.table()` can be used to write pixel metadata and feature metadata after coercing them to an ordinary R `data.frame` with `as.data.frame()`.

Use `saveRDS()` and `readRDS()` to save and read and entire R object such as a `MSImagingExperiment`. Note that if intensity data is to be saved as well, it should be pulled into memory and coerced to an R matrix with `as.matrix()` first. However, it is typically better to write an imzML file using `writeMSIData()`.

# 5 Visualization

Visualization of mass spectra and molecular ion images is vital for exploratory analysis of MS imaging experiments. *Cardinal* provides `plot()` methods for plotting mass spectra and a`image()` methods for plotting images.

We will use simulated data for visualization. We will create versions of the dataset represented as both `MSImagingArrays` and `MSImagingExperiment`.

```
# Simulate an MSImagingExperiment
set.seed(2020, kind="L'Ecuyer-CMRG")
mse <- simulateImage(preset=6, dim=c(32,32), baseline=0.5)
mse
```

```
## MSImagingExperiment with 3879 features and 2048 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

```
# Create a version as MSImagingArrays
msa <- convertMSImagingExperiment2Arrays(mse)
msa
```

```
## MSImagingArrays with 2048 spectra
## spectraData(2): intensity, mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## centroided: FALSE
## continuous: TRUE
```

## 5.1 Visualizing spectra with `plot()`

Use `plot()` to plot mass spectra from a `MSImagingArrays` or `MSImagingExperiment` object. Below we plot the 463rd and 628th mass spectra in the dataset.

```
plot(msa, i=c(496, 1520))
```

![](data:image/png;base64...)

Alternatively, we can specify the coordinates.

```
plot(msa, coord=list(x=16, y=16))
```

![](data:image/png;base64...)

We can use `superpose` to overlay the mass spectra and `xlim` to control the mass range.

```
plot(msa, i=c(496, 1520), xlim=c(1000, 1250),
    superpose=TRUE)
```

![](data:image/png;base64...)

## 5.2 Visualizing images with `image()`

Use `image()` to plot ion images from `MSImagingExperiment`. Below we plot the image for the 2,489th m/z value.

```
image(mse, i=1938)
```

![](data:image/png;base64...)

Alternatively, we can specify the m/z value. The closest matching m/z value will be used.

```
image(mse, mz=1003.3)
```

![](data:image/png;base64...)

Use `tolerance` to sum together the images for a all *m/z* values within a certain tolerance.

```
image(mse, mz=1003.3, tolerance=0.5, units="mz")
```

![](data:image/png;base64...)

By default, images from all experimental runs are plotted. Use `run` to specify specific runs to plot by name or index.

```
image(mse, mz=1003.3, run="runA1")
```

![](data:image/png;base64...)

Alternatively, use `subset` to plot an arbitrary subset of pixels.

```
image(mse, mz=1003.3, subset=mse$circleA | mse$circleB)
```

![](data:image/png;base64...)

Multiplicative variance in spectral intensities can cause images to be noisy and dark due to hot spots.

Often, images may require some type of processing and enhancement to improve interpretation.

```
image(mse, mz=1003.3, smooth="gaussian")
```

![](data:image/png;base64...)

```
image(mse, mz=1003.3, enhance="histogram")
```

![](data:image/png;base64...)

Multiple images can be superposed with `superpose=TRUE`. Use `scale=TRUE` to rescale all images to the same intensity range.

```
image(mse, mz=c(1003.3, 1663.6), superpose=TRUE,
    enhance="adaptive", scale=TRUE)
```

![](data:image/png;base64...)

## 5.3 Region-of-interest selection

Use `selectROI()` to select regions-of-interest on an ion image. It is important to specify a subset so that selection is only made on a single experimental run, otherwise results may be unexpected. The form of `selectROI()` is the same as `image()`.

```
sampleA <- selectROI(mse, mz=1003.3, subset=run(mse) == "run0")
sampleB <- selectROI(mse, mz=1003.3, subset=run(mse) == "run1")
```

`selectROI()` returns a logical vector specifying which pixels from the imaging experiment are contained in the selected region.

`makeFactor()` can then be used to combine multiple logical vectors (e.g., from `selectROI()`) into a single factor.

```
regions <- makeFactor(A=sampleA, B=sampleB)
```

## 5.4 Saving plots and images

Plots and images can be saved to a file by using R’s built-in graphics devices.

Use `pdf()` to initialize a PDF graphics device, create the plot, and then use `dev.off()` to turn off the graphics device.

Any plots printed while the graphics device is active will be saved to the specified file(s).

```
pdffile <- tempfile(fileext=".pdf")

pdf(file=pdffile, width=9, height=4)
image(mse, mz=1003.3)
dev.off()
```

Graphics devices for `png()`, `jpeg()`, `bmp()`, and `tiff()` are also available. See their documentation for usage.

## 5.5 Dark themes

While many software for MS imaging data use a light-on-dark theme, *Cardinal* uses a dark-on-light theme by default. However, a dark theme is also provided with `style="dark`.

```
image(mse, mz=1003.3, style="dark")
```

![](data:image/png;base64...)

## 5.6 A note on plotting speed

While plotting spectra should typically be fast, plotting images can be be (much) slower for large out-of-memory datasets.

This is due to the way the spectra are stored in imzML and Analyze files. Exracting the images simply takes longer than reading the spectra.

For the fastest visualization of images, experiments should be coerced to an in-memory matrix.

Also note that all *Cardinal* visualizations produce a `plot()`-able object that can be assigned to a variable and `plot()`-ed later without the need to read the data again. Some parameters can even be updated this way, such as smoothing, contrast enhancement, and scaling.

```
p <- image(mse, mz=1003.3)
plot(p, smooth="guide")
```

![](data:image/png;base64...)

This is useful for re-creating or updating plots without accessing the data again.

# 6 Common operations on MS imaging datasets

## 6.1 Subsetting

`MSImagingArrays` and `MSImagingExperiment` can be subsetted using the `[` operator.

When subsetting `MSImagingArrays`, the object is treated as a list of mass spectra.

```
# subset first 5 mass spectra
msa[1:5]
```

```
## MSImagingArrays with 5 spectra
## spectraData(2): intensity, mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...5, y = 1...1
## runNames(1): runA1
## metadata(1): design
## centroided: FALSE
## continuous: TRUE
```

When subsetting `MSImagingExperiment`, the “rows” are the flattened images, and the “columns” are the mass spectra.

```
# subset first 10 images and first 5 mass spectra
mse[1:10, 1:5]
```

```
## MSImagingExperiment with 10 features and 5 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...5, y = 1...1
## runNames(1): runA1
## metadata(1): design
## mass range: 462.3758 to 464.0434
## centroided: FALSE
```

### 6.1.1 Finding indices of mass spectra and images

Subsetting the dataset this way requires knowing the desired row and column indices.

Use `features()` to find row indices of a `MSImagingExperiment` corresponding to specific *m/z* values or other feature metadata.

```
# get row index corresponding to m/z 1003.3
features(mse, mz=1003.3)
```

```
## [1] 1938
```

```
# get row indices corresponding to m/z 1002 - 1004
features(mse, 1002 < mz & mz < 1004)
```

```
## [1] 1935 1936 1937 1938 1939
```

Use `pixels()` to find indices of `MSImagingArrays` or column indices of `MSImagingExperiment` that correspond to specific mass spectra based on coordinates or other metadata.

```
# get column indices corresponding to x = 10, y = 10 in all runs
pixels(mse, coord=list(x=10, y=10))
```

```
## [1]  298 1322
```

```
# get column indices corresponding to x <= 3, y <= 3 in "runA1"
pixels(mse, x <= 3, y <= 3, run == "runA1")
```

```
## [1]  1  2  3 33 34 35 65 66 67
```

These methods can be used to determine row/column indices of particular *m/z*-values or pixel coordinates to use for subsetting.

```
fid <- features(mse, 1002 < mz, mz < 1004)
pid <- pixels(mse, x <= 3, y <= 3, run == "runA1")
mse[fid, pid]
```

```
## MSImagingExperiment with 5 features and 9 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...3, y = 1...3
## runNames(1): runA1
## metadata(1): design
## mass range: 1002.225 to 1003.830
## centroided: FALSE
```

### 6.1.2 Using `subset()` and friends

Alternatively, `subset()` can be used to subset MS imaging datasets based on metadata.

For `MSImagingArrays`, `subset()` takes a single argument specifying the pixels (i.e., the mass spectra).

```
# subset MSImagingArrays
subset(msa, x <= 3 & x <= 3)
```

```
## MSImagingArrays with 192 spectra
## spectraData(2): intensity, mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...3, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## centroided: FALSE
## continuous: TRUE
```

For `MSImagingExperiment`, `subset()` takes a two arguments specifying both the features and the pixels.

```
# subset MSImagingExperiment
subset(mse, 1002 < mz & mz < 1004, x <= 3 & x <= 3)
```

```
## MSImagingExperiment with 5 features and 192 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...3, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range: 1002.225 to 1003.830
## centroided: FALSE
```

We can also use `subsetFeatures()` and `subsetPixels()` if subsetting an `MSImagingExperiment`.

```
# subset features
subsetFeatures(mse, 1002 < mz, mz < 1004)
```

```
## MSImagingExperiment with 5 features and 2048 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range: 1002.225 to 1003.830
## centroided: FALSE
```

```
# subset pixels
subsetPixels(mse, x <= 3, y <= 3)
```

```
## MSImagingExperiment with 3879 features and 18 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...3, y = 1...3
## runNames(2): runA1, runB1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

## 6.2 Slicing

`MSImagingExperiment` represents the data as a matrix, where each column is a mass spectrum, rather than as a true “data cube”. This is typically simpler when operating on the mass spectra, and more space efficient when the data is non-rectangular.

Sometimes, however, it is useful to index into the data as an actual “data cube”, with explicit array dimensions for each spatial dimension.

Use `sliceImage()` to slice an `MSImagingExperiment` as a data cube and extract images.

```
# slice image for first mass feature
a <- sliceImage(mse, 1)
dim(a)
```

```
##   x   y run
##  32  32   2
```

Because we only sliced a single image, the first 2 dimensions are the spatial dimensions and the 3rd dimension are the experimental runs. We can use `drop=FALSE` to indicate we want to preserve the feature dimension even for a single image.

```
# slice image for m/z 1003.3
a2 <- sliceImage(mse, mz=1003.3, drop=FALSE)
dim(a2)
```

```
##       x       y     run feature
##      32      32       2       1
```

Note that when plotting images from raw arrays, the images are upside-down due to differing coordinate conventions used by `graphics::image()`.

```
par(mfcol=c(1,2), new=FALSE)
image(a2[,,1,1], asp=1)
image(a2[,,2,1], asp=1)
```

![](data:image/png;base64...)

## 6.3 Combining

Because `MSImagingExperiment` is matrix-like, `rbind()` and `cbind()` can be used to combine multiple `MSImagingExperiment` objects by “row” or “column”, assumping certain conditions are met.

Use `cbind()` to combine datasets from different experimental runs. The *m/z*-values must match between all datasets to succesfully combine them.

```
# divide dataset into separate objects for each run
mse_run0 <- mse[,run(mse) == "runA1"]
mse_run1 <- mse[,run(mse) == "runB1"]
mse_run0
```

```
## MSImagingExperiment with 3879 features and 1024 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(1): runA1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

```
mse_run1
```

```
## MSImagingExperiment with 3879 features and 1024 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(1): runB1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

```
# recombine the separate datasets back together
mse_cbind <- cbind(mse_run0, mse_run1)
mse_cbind
```

```
## MSImagingExperiment with 3879 features and 2048 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(2): design, design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

Some processing may be necessary to ensure datasets are compatible before combining them.

## 6.4 Getters and setters

Most components of an `MSImagingExperiment` that can be accessed through getter functions like `spectraData()`, `featureData()`, and `pixelData()` can also be re-assigned with analogous setter functions. These can likewise be used to get and set columns of the pixel and feature metadata.

Note that `pData()` and `fData()` are aliases for `pixelData()` and `featureData()`, respectively. The `$` operator will access the corresponding columns of `pixelData()`.

Here, we use `makeFactor()` to create a new pixel metadata columns.

```
mse$region <- makeFactor(A=mse$circleA, B=mse$circleB,
    other=mse$square1 | mse$square2)
pData(mse)
```

```
## PositionDataFrame with 2048 rows and 9 columns
##              x         y      run   square1   square2   circleA   circleB
##      <integer> <integer> <factor> <logical> <logical> <logical> <logical>
## 1            1         1    runA1     FALSE     FALSE     FALSE     FALSE
## 2            2         1    runA1     FALSE     FALSE     FALSE     FALSE
## 3            3         1    runA1     FALSE     FALSE     FALSE     FALSE
## 4            4         1    runA1     FALSE     FALSE     FALSE     FALSE
## 5            5         1    runA1     FALSE     FALSE     FALSE     FALSE
## ...        ...       ...      ...       ...       ...       ...       ...
## 2044        28        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2045        29        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2046        30        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2047        31        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2048        32        32    runB1     FALSE      TRUE     FALSE     FALSE
##      condition   region
##       <factor> <factor>
## 1            A       NA
## 2            A       NA
## 3            A       NA
## 4            A       NA
## 5            A       NA
## ...        ...      ...
## 2044         B    other
## 2045         B    other
## 2046         B    other
## 2047         B    other
## 2048         B    other
## coord(2): x, y
## run(1): run
```

Here, we create new feature metadata columns based on the design of the simulated data.

```
fData(mse)$region <- makeFactor(
    circle=mz(mse) > 1000 & mz(mse) < 1250,
    square=mz(mse) < 1000 | mz(mse) > 1250)
fData(mse)
```

```
## MassDataFrame with 3879 rows and 2 columns
##             mz   region
##      <numeric> <factor>
## 1      462.376   square
## 2      462.561   square
## 3      462.746   square
## 4      462.931   square
## 5      463.116   square
## ...        ...      ...
## 3875   2177.60   square
## 3876   2178.47   square
## 3877   2179.34   square
## 3878   2180.21   square
## 3879   2181.09   square
## mz(1): mz
```

Use `spectra()` to access elements of the `spectraData()` list of spectra arrays by name or index. It is possible to have multiple spectra arrays. Calling `spectra()` with no other arguments will get or set the first element of `spectraData()`. Providing a name or index will get or set that element.

```
# create a new spectra matrix of log-intensities
spectra(mse, "log2intensity") <- log2(spectra(mse) + 1)
spectraData(mse)
```

```
## SpectraArrays of length 2
##        names(2):     intensity log2intensity
##        class(2):        matrix        matrix
##          dim(2): <3879 x 2048> <3879 x 2048>
##     real mem(2):      63.56 MB      63.56 MB
##   shared mem(2):          0 MB          0 MB
##  virtual mem(2):          0 MB          0 MB
```

```
# examine the new spectra matrix
spectra(mse, "log2intensity")[1:5, 1:5]
```

```
##           [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.5891243 0.7066315 0.5849625 0.6498496 0.6965572
## [2,] 0.5845547 0.5845547 0.5845547 0.5845547 0.5845547
## [3,] 0.5841471 0.5841471 0.5841471 0.7135359 0.5841471
## [4,] 0.6285481 0.5837394 0.6467127 0.7211373 0.5837394
## [5,] 0.6613471 0.5833319 0.6701298 0.7298229 0.5833319
```

Whether or not the spectra have been centroided or not can be accessed using `centroided()`

```
centroided(mse)
```

```
## [1] FALSE
```

This can also be used to set whether the spectra should be treated as centroided or not.

```
centroided(mse) <- FALSE
```

## 6.5 Summarization (e.g., mean spectra, TIC, etc.)

*Cardinal* provides functions for summarizing over the features or pixels of an `MSImagingExperiment`.

* `summarizeFeatures()` summarizes by feature (e.g., mean spectrum)
* `summarizePixels()` summarizes by pixel (e.g., TIC)

When applied to an `MSImagingExperiment`, the summary statistics are stored as new columns in `featureData()` or `pixelData()`, respectively.

Below, we summarize and plot the mean specrum.

```
# calculate mean spectrum
mse <- summarizeFeatures(mse, stat="mean")

# mean spectrum stored in featureData
fData(mse)
```

```
## MassDataFrame with 3879 rows and 3 columns
##             mz   region      mean
##      <numeric> <factor> <numeric>
## 1      462.376   square  0.538982
## 2      462.561   square  0.539069
## 3      462.746   square  0.540151
## 4      462.931   square  0.539510
## 5      463.116   square  0.541830
## ...        ...      ...       ...
## 3875   2177.60   square 0.0410674
## 3876   2178.47   square 0.0406372
## 3877   2179.34   square 0.0390261
## 3878   2180.21   square 0.0412461
## 3879   2181.09   square 0.0400341
## mz(1): mz
```

```
# plot mean spectrum
plot(mse, "mean", xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

Below, we summarize and plot the total ion current.

```
# calculate TIC
mse <- summarizePixels(mse, stat=c(TIC="sum"))

# TIC stored in pixelData
pData(mse)
```

```
## PositionDataFrame with 2048 rows and 10 columns
##              x         y      run   square1   square2   circleA   circleB
##      <integer> <integer> <factor> <logical> <logical> <logical> <logical>
## 1            1         1    runA1     FALSE     FALSE     FALSE     FALSE
## 2            2         1    runA1     FALSE     FALSE     FALSE     FALSE
## 3            3         1    runA1     FALSE     FALSE     FALSE     FALSE
## 4            4         1    runA1     FALSE     FALSE     FALSE     FALSE
## 5            5         1    runA1     FALSE     FALSE     FALSE     FALSE
## ...        ...       ...      ...       ...       ...       ...       ...
## 2044        28        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2045        29        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2046        30        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2047        31        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2048        32        32    runB1     FALSE      TRUE     FALSE     FALSE
##      condition   region       TIC
##       <factor> <factor> <numeric>
## 1            A       NA   655.277
## 2            A       NA   619.358
## 3            A       NA   630.155
## 4            A       NA   633.181
## 5            A       NA   627.942
## ...        ...      ...       ...
## 2044         B    other   856.771
## 2045         B    other   873.250
## 2046         B    other   860.006
## 2047         B    other   851.561
## 2048         B    other   830.818
## coord(2): x, y
## run(1): run
```

```
# plot TIC
image(mse, "TIC", col=matter::cpal("Cividis"))
```

![](data:image/png;base64...)

It is also possible to summarize over different groups.

Here, we summarize over different pixel groups and plot the resulting mean spectra.

```
# calculate mean spectrum
mse <- summarizeFeatures(mse, stat="mean", groups=mse$region)

# mean spectrum stored in featureData
fData(mse)
```

```
## MassDataFrame with 3879 rows and 6 columns
##             mz   region      mean    A.mean    B.mean other.mean
##      <numeric> <factor> <numeric> <numeric> <numeric>  <numeric>
## 1      462.376   square  0.538982  0.532676  0.536587   0.540117
## 2      462.561   square  0.539069  0.535976  0.546470   0.541043
## 3      462.746   square  0.540151  0.543922  0.542662   0.538899
## 4      462.931   square  0.539510  0.539947  0.541177   0.538993
## 5      463.116   square  0.541830  0.540383  0.544032   0.541032
## ...        ...      ...       ...       ...       ...        ...
## 3875   2177.60   square 0.0410674 0.0364042 0.0425991  0.0418534
## 3876   2178.47   square 0.0406372 0.0404122 0.0368558  0.0384662
## 3877   2179.34   square 0.0390261 0.0388301 0.0477074  0.0381444
## 3878   2180.21   square 0.0412461 0.0381640 0.0407892  0.0417756
## 3879   2181.09   square 0.0400341 0.0412113 0.0429291  0.0424167
## mz(1): mz
```

```
# plot mean spectrum
plot(mse, c("A.mean", "B.mean"), xlab="m/z", ylab="Intensity")
```

![](data:image/png;base64...)

Here, we summarize over different feature groups and plot the resulting images.

```
# calculate mean spectrum
mse <- summarizePixels(mse, stat="sum", groups=fData(mse)$region)

# mean spectrum stored in featureData
pData(mse)
```

```
## PositionDataFrame with 2048 rows and 12 columns
##              x         y      run   square1   square2   circleA   circleB
##      <integer> <integer> <factor> <logical> <logical> <logical> <logical>
## 1            1         1    runA1     FALSE     FALSE     FALSE     FALSE
## 2            2         1    runA1     FALSE     FALSE     FALSE     FALSE
## 3            3         1    runA1     FALSE     FALSE     FALSE     FALSE
## 4            4         1    runA1     FALSE     FALSE     FALSE     FALSE
## 5            5         1    runA1     FALSE     FALSE     FALSE     FALSE
## ...        ...       ...      ...       ...       ...       ...       ...
## 2044        28        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2045        29        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2046        30        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2047        31        32    runB1     FALSE      TRUE     FALSE     FALSE
## 2048        32        32    runB1     FALSE      TRUE     FALSE     FALSE
##      condition   region       TIC circle.sum square.sum
##       <factor> <factor> <numeric>  <numeric>  <numeric>
## 1            A       NA   655.277    49.5216    605.756
## 2            A       NA   619.358    39.7829    579.575
## 3            A       NA   630.155    41.4789    588.676
## 4            A       NA   633.181    40.1374    593.043
## 5            A       NA   627.942    41.0550    586.887
## ...        ...      ...       ...        ...        ...
## 2044         B    other   856.771    165.707    691.064
## 2045         B    other   873.250    173.984    699.266
## 2046         B    other   860.006    170.695    689.311
## 2047         B    other   851.561    161.945    689.615
## 2048         B    other   830.818    157.879    672.939
## coord(2): x, y
## run(1): run
```

```
# plot mean spectrum
image(mse, c("circle.sum", "square.sum"), scale=TRUE)
```

![](data:image/png;base64...)

## 6.6 Loading data into memory

By default, *Cardinal* does not load the spectra from imzML and Analyze files into memory, but retrieves them from files when necessary. For very large datasets, this is necessary and memory-efficient.

However, for datasets that are known to fit in computer memory, this may be unnecessarily slow, especially when plotting images (which are perpendicular to how data are stored in the files).

```
# spectra are stored as an out-of-memory matrix
spectra(mse_tiny)
```

```
## <8399 row x 9 col> matter_mat :: out-of-core double matrix
##      Scan=1 Scan=2 Scan=3 Scan=4 Scan=5 Scan=6 ...
## [1,]      0      0      0      0      0      0 ...
## [2,]      0      0      0      0      0      0 ...
## [3,]      0      0      0      0      0      0 ...
## [4,]      0      0      0      0      0      0 ...
## [5,]      0      0      0      0      0      0 ...
## [6,]      0      0      0      0      0      0 ...
## ...     ...    ...    ...    ...    ...    ... ...
## (7.16 KB real | 0 bytes shared | 302.37 KB virtual)
```

```
spectraData(mse_tiny) # 'intensity' array is 'matter_mat' object
```

```
## SpectraArrays of length 1
##        names(1):  intensity
##        class(1): matter_mat
##          dim(1): <8399 x 9>
##     real mem(1):    7.16 KB
##   shared mem(1):       0 KB
##  virtual mem(1):  302.37 KB
```

For `MSImagingExperiment`, use `as.matrix()` on the `spectra()` to load the spectra into memory as a dense matrix.

```
# coerce spectra to an in-memory matrix
spectra(mse_tiny) <- as.matrix(spectra(mse_tiny))
spectraData(mse_tiny) # 'intensity' array is 'matrix' object
```

```
## SpectraArrays of length 1
##        names(1):  intensity
##        class(1):     matrix
##          dim(1): <8399 x 9>
##     real mem(1):   605.8 KB
##   shared mem(1):       0 KB
##  virtual mem(1):       0 KB
```

## 6.7 Coercion to/from other classes

Use `as()` to coerce between different data representations.

Here, we coerce from `MSImagingArrays` to `MSImagingExperiment`.

```
msa
```

```
## MSImagingArrays with 2048 spectra
## spectraData(2): intensity, mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## centroided: FALSE
## continuous: TRUE
```

```
# coerce to MSImagingExperiment
as(msa, "MSImagingExperiment")
```

```
## MSImagingExperiment with 3879 features and 2048 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

We can also coerce from `MSImagingExperiment` to `MSImagingArrays`.

```
mse
```

```
## MSImagingExperiment with 3879 features and 2048 spectra
## spectraData(2): intensity, log2intensity
## featureData(6): mz, region, mean, A.mean, B.mean, other.mean
## pixelData(12): x, y, run, ..., TIC, circle.sum, square.sum
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range:  462.3758 to 2181.0856
## centroided: FALSE
```

```
# coerce to MSImagingArrays
as(mse, "MSImagingArrays")
```

```
## MSImagingArrays with 2048 spectra
## spectraData(2): intensity, mz
## pixelData(12): x, y, run, ..., TIC, circle.sum, square.sum
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## centroided: FALSE
## continuous: TRUE
```

This will often change the underlying data representation, so some information may be lost depending on the coercion.

In practice, it’s rarely necessary to coerce between data representations. Instead, it is more common to process the data into an `MSImagingExperiment`, as in the next section.

# 7 Pre-processing

*Cardinal* provides a full suite of pre-processing methods. Processing steps that are applied to mass spectra individually are be queued to be applied in sequence later. Use `process()` to apply queued processing steps.

* Spectral processing

  + `normalize()` for normalizing mass spectra
  + `smooth()` for smoothing mass spectra
  + `reduceBaseline()` for baseline subtraction
  + `recalibrate()` for recalibration of *m/z* values
  + `peakPick()` for peak detection and summarization
* Peak processing

  + `peakAlign()` for aligning detected peaks
  + `peakProcess()` for streamlined peak detection and alignment
* Other processing

  + `bin()` for binning or resampling mass spectra

We will demonstrate how to apply these pre-processing steps in the following sections.

## 7.1 Normalization

Use `normalize()` to queue normalization on `MSImagingArrays` or `MSImagingExperiment`.

```
msa_pre <- normalize(msa, method="tic")
```

The supported normalization methods include:

* `method="tic"` performs total-ion-current (TIC) normalization
* `method="rms"` performs root-mean-square (RMS) normalization
* `method="reference"` normalizes spectra to a reference feature

TIC normalization is one of the most common normalization methods for mass spectrometry imaging. For comparison between datasets, TIC normalization requires that all spectra are the same length. RMS normalization is more appropriate when spectra are of different lengths.

Normalization to a reference is the most reliable form of normalization, but is only possible when the experiment contains a known reference peak with constant abundance throughout the dataset. This is often not possible in unsupervised and exploratory experiments.

(We won’t plot normalization, because it is simply re-scaling the intensities.)

## 7.2 Smoothing

Use `smooth()` to queue smoothing on `MSImagingArrays` or `MSImagingExperiment`.

```
p1 <- smooth(msa, method="gaussian") |>
    plot(coord=list(x=16, y=16),
        xlim=c(1150, 1450), linewidth=2)

p2 <- smooth(msa, method="sgolay") |>
    plot(coord=list(x=16, y=16),
        xlim=c(1150, 1450), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
    labels=c("Gaussian smoothing", "Savitsky-Golay smoothing"))
```

![](data:image/png;base64...)

Note above we use `|>` to chain together sequences of functions, and we can use `plot()` to preview the results of queued spectral processing before applying it.

The supported smoothing methods include:

* `method="gaussian"` performs Gaussian smoothing
* `method="bilateral"` performs bilateral filtering
* `method="adaptive"` performs adaptive bilateral filtering
* `method="diff"` performs nonlinear diffusion
* `method="guide"` performs guided filtering
* `method="pag"` performs peak-aware guided filtering
* `method="sgolay"` performs Savitzky-Golay smoothing
* `method="ma"` performs moving average smoothing

```
msa_pre <- smooth(msa_pre, method="gaussian")
```

## 7.3 Baseline subtraction

Use `reduceBaseline()` to queue baseline subtraction on `MSImagingArrays` or `MSImagingExperiment`.

```
p1 <- reduceBaseline(mse, method="locmin") |>
    plot(coord=list(x=16, y=16), linewidth=2)

p2 <- reduceBaseline(mse, method="median") |>
    plot(coord=list(x=16, y=16), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
    labels=c("Local minima interpolation", "Running medians"))
```

![](data:image/png;base64...)

The supported smoothing methods include:

* `method="locmin"` interpolates a baseline from local minima
* `method="hull"` uses convex hull estimation
* `method="snip"` uses sensitive nonlinear iterative peak (SNIP) clipping
* `method="median"` estimates a baseline from running medians

```
msa_pre <- reduceBaseline(msa_pre, method="locmin")
```

## 7.4 Recalibration

Although peak alignment (to be discussed shortly) will generally account for small differences in *m/z* values between spectra, alignment of the profile spectra is sometimes desireable as well.

Use `recalibrate()` to queue recalibration on `MSImagingArrays` or `MSImagingExperiment`.

First, we need to simulate spectra that are visibly in need of calibration.

```
set.seed(2020, kind="L'Ecuyer-CMRG")
mse_drift <- simulateImage(preset=1, npeaks=10,
    from=500, to=600, sdmz=750, units="ppm")

plot(mse_drift, i=186:195, xlim=c(535, 570),
    superpose=TRUE, key=FALSE, linewidth=2)
```

![](data:image/png;base64...)

To align the spectra, we need to provide a vector of reference *m/z* values of expected peaks. Here, we will simply use the peaks of the mean spectrum from `estimateReferencePeaks()`.

```
peaks_drift <- estimateReferencePeaks(mse_drift)

mse_nodrift <- recalibrate(mse_drift, ref=peaks_drift,
    method="locmax", tolerance=1500, units="ppm")
mse_nodrift <- process(mse_nodrift)

plot(mse_nodrift, i=186:195, xlim=c(535, 570),
    superpose=TRUE, key=FALSE, linewidth=2)
```

![](data:image/png;base64...)

The supported recalibration methods include:

* `method="locmax"` uses local regression to shift the spectra
* `method="dtw"` uses dynamic time warping (DTW)
* `method="cow"` uses correlation optimized warping (COW)

The algorithms will shift the spectrum to try to match local maxima to the reference peaks. The maximum shift is given by `tolerance`. If `tolerance` is too small, the spectra may not be shifted enough. If `tolerance` is too large, the local maxima may be matched to the wrong reference peaks.

## 7.5 Peak processing

Peak processing encompasses multiple steps, including (1) peak detection, (2) aligning peaks across all spectra, (3) filtering peaks, and/or (4) extracting peaks from spectra based on a reference. Some of these steps are optional.

```
msa_pre <- process(msa_pre)
```

### 7.5.1 Peak picking

Use `peakPick()` to queue peak picking on `MSImagingArrays` or `MSImagingExperiment`.

```
p1 <- peakPick(msa_pre, method="diff", SNR=3) |>
    plot(coord=list(x=16, y=16), linewidth=2)

p2 <- peakPick(msa_pre, method="filter", SNR=3) |>
    plot(coord=list(x=16, y=16), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
    labels=c("Derivative-based SNR", "Dynamic filtering-based SNR"))
```

![](data:image/png;base64...)

We use `SNR` to designate the minimum signal-to-noise threshold for the detected peaks.

The supported peak picking methods include:

* `method="diff"` estimates SNR from deviations between the spectrum and a rolling average of its derivative
* `method="sd"` estimates SNR from the standard deviation of the spectrum convolved with a wavelet
* `method="mad"` estimates SNR from the mean absolute deviation of the spectrum convolved with a wavelet
* `method="quantile"` estimates SNR from a rolling quantile of the difference between the original spectrum and a smoothed spectrum
* `method="filter"` uses dynamic filtering to separate peaks into signal peaks and noise peaks
* `method="cwt"` uses the continuous wavelet transform (CWT)

```
msa_peaks <- peakPick(msa_pre, method="filter", SNR=3)
```

### 7.5.2 Peak alignment

Use `peakAlign()` to align the detected peaks.

Note that `peakAlign()` will automatically call `process()` if there are queued spectral processing steps.

```
mse_peaks <- peakAlign(msa_peaks, tolerance=200, units="ppm")
mse_peaks
```

```
## MSImagingExperiment with 1292 features and 2048 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(4): design, processing_20260212170956, processing_20260212171006, processing_20260212171007
## mass range:  463.1162 to 2180.2133
## centroided: TRUE
```

Note that the result is returned as an `MSImagingExperiment` now that all of the spectra have been aligned to the same *m/z* values.

Peaks are aligned to candidate locations based on the the given `tolerance`. A set of reference peaks to use can be specified via `ref`.

In this case, no reference peaks are specified, so the candidate locations are generated automatically from the detected peaks. This may results in many extraneous peaks that need to be removed.

### 7.5.3 Peak filtering

When peaks are aligned without a reference, `peakAlign()` will return the count and frequency of each peak as `count` and `freq` columns in `featureData()`.

```
fData(mse_peaks)
```

```
## MassDataFrame with 1292 rows and 3 columns
##             mz     count      freq
##      <numeric> <numeric> <numeric>
## 1      463.116       130 0.0634766
## 2      463.672        92 0.0449219
## 3      464.229        93 0.0454102
## 4      464.786        93 0.0454102
## 5      465.344        94 0.0458984
## ...        ...       ...       ...
## 1288   2169.77       103 0.0502930
## 1289   2172.38       109 0.0532227
## 1290   2174.99       119 0.0581055
## 1291   2177.60        93 0.0454102
## 1292   2180.21       133 0.0649414
## mz(1): mz
```

```
# filter to peaks with frequencies > 0.1
mse_filt <- subsetFeatures(mse_peaks, freq > 0.1)
fData(mse_filt)
```

```
## MassDataFrame with 13 rows and 3 columns
##            mz     count      freq
##     <numeric> <numeric> <numeric>
## 1     610.317      1172  0.572266
## 2     796.620       401  0.195801
## 3    1011.488      1427  0.696777
## 4    1041.043      1607  0.784668
## 5    1128.199      1643  0.802246
## ...       ...       ...       ...
## 9     1247.85      1049  0.512207
## 10    1341.01       444  0.216797
## 11    1497.54       614  0.299805
## 12    1797.19       931  0.454590
## 13    1983.02       974  0.475586
## mz(1): mz
```

Here, we use `subsetFeatures()` to subset the data to include only peaks observed in more than 10% of the dataset. For this dataset, that results in 37 peaks. (Note that the dataset was simulated with 30 peaks.)

```
mse_filt <- summarizeFeatures(mse_filt)

plot(mse_filt, "mean", xlab="m/z", ylab="Intensity",
    linewidth=2, annPeaks=10)
```

![](data:image/png;base64...)

### 7.5.4 Peak picking based on a reference

We can also use `peakPick()` to queue peak summarization based on a set of reference peaks.

```
msa_peaks2 <- peakPick(msa_pre, ref=mz(mse_filt), type="area",
    tolerance=600, units="ppm")

mse_peaks2 <- process(msa_peaks2)
```

In this case, local peaks are matched to the reference peaks within `tolerance`. The peak is then expanded to the nearest local minima in both directions. The intensity of the peak is then summarized either by the maximum intensity (`type="height")` or sum of intensities (`type="area")`.

```
mse_peaks2 <- as(mse_peaks2, "MSImagingExperiment")
mse_peaks2 <- summarizeFeatures(mse_peaks2)

plot(mse_peaks2, "mean", xlab="m/z", ylab="Intensity",
    linewidth=2, annPeaks=10)
```

![](data:image/png;base64...)

### 7.5.5 Using `peakProcess()`

We can use `peakProcess()` to streamline the most common peak processing workflows.

Note that `peakProcess()` will automatically call `process()` if there are queued spectral processing steps.

```
mse_peaks3 <- peakProcess(msa_pre, method="diff", SNR=6,
    sampleSize=0.3, filterFreq=0.02)

mse_peaks3
```

```
## MSImagingExperiment with 28 features and 2048 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(3): design, processing_20260212170956, processing_20260212171012
## mass range:  513.6943 to 1983.3448
## centroided: TRUE
```

When `sampleSize` is specified, `peakProcess()` first performs peak picking and alignment on a subset of the spectra (as specified by `sampleSize`) to create a set of reference peaks. Then, these reference peaks are summarized for every spectrum in the full dataset.

The advantage of this approach is that all of the peaks detected in the sample spectra will be summarized for every spectrum. So it is less likely that there will be missing peaks due to low signal-to-noise ratio. However, the drawback is that rare peaks may be less likely to be detected if they are not in the sample.

Alternatively, using `peakProcess()` without setting `sampleSize` will perform peak picking followed by peak alignment as usual.

## 7.6 Binning

Use `bin()` to bin an `MSImagingArrays` or `MSImagingExperiment` dataset to an arbitrary resolution. The binning is applied on-the-fly, whenever data is accessed.

```
mse_binned <- bin(msa, resolution=1, units="mz")
mse_binned
```

```
## MSImagingExperiment with 1721 features and 2048 spectra
## spectraData(1): intensity
## featureData(1): mz
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(1): design
## mass range:  462 to 2182
## centroided: FALSE
```

Here, we bin a dataset to unit *m/z* resolution (i.e., spacing of 1 between *m/z* values).

## 7.7 Example processing workflow

Queueing processing steps makes it easy to chain together processing steps with the `|>` operator, and then apply them all at once.

```
mse_queue <- msa |>
    normalize() |>
    smooth() |>
    reduceBaseline() |>
    peakPick(SNR=6)

# preview processing
plot(mse_queue, coord=list(x=16, y=16), linewidth=2)
```

![](data:image/png;base64...)

```
# apply processing and align peaks
mse_proc <- peakAlign(mse_queue)
mse_proc <- subsetFeatures(mse_proc, freq > 0.1)
mse_proc
```

```
## MSImagingExperiment with 28 features and 2048 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(3): design, processing_20260212171016, processing_20260212171016.1
## mass range:  513.6763 to 1983.3586
## centroided: TRUE
```

# 8 Data export

We can use `writeMSIData()` to write `MSImagingArrays` or `MSImagingExperiment` objects to imzML files.

```
imzfile <- tempfile(fileext=".imzML")

writeMSIData(mse_proc, file=imzfile)

list.files(imzfile)
```

```
## [1] "file2003b01db64679.fdata"    "file2003b01db64679.ibd"
## [3] "file2003b01db64679.imzML"    "file2003b01db64679.log"
## [5] "file2003b01db64679.metadata" "file2003b01db64679.pdata"
```

By default, the “.imzML” and “.ibd” file are bundled into a directory of the specified file name. Note that the `featureData()` and `pixelData()` are also written to tab-delimited files (if they contain more than the default metadata columns).

```
mse_re <- readMSIData(imzfile)

mse_re
```

```
## MSImagingExperiment with 28 features and 2048 spectra
## spectraData(1): intensity
## featureData(3): mz, count, freq
## pixelData(8): x, y, run, ..., circleA, circleB, condition
## coord(2): x = 1...32, y = 1...32
## runNames(2): runA1, runB1
## metadata(3): design, processing_20260212171016, processing_20260212171016.1
## experimentData(3): spectrumType, spectrumRepresentation, instrumentModel
## mass range:  513.6763 to 1983.3586
## centroided: TRUE
```

When reading the data back in with `readMSIData()`, the bundled imzML directory is detected and the files are imported appropriately. The additional `featureData()` and `pixelData()` columns are imported as well.

# 9 Parallel computing using *BiocParallel*

All pre-processing methods and some statistical analysis methods in *Cardinal* can be executed in parallel using *BiocParallel*.

By default, no parallelization is used. This is for maximum stability and compatibility across all users.

## 9.1 Using `BPPARAM`

Any method that supports parallelization includes `BPPARAM` as an argument (see method documentation). The `BPPARAM` argument can be used to specify a parallel backend for the operation, such as `SerialParam()`, `MulticoreParam()`, `SnowParam()`, etc.

```
# run in parallel, rather than serially
mse_mean <- summarizeFeatures(mse, BPPARAM=MulticoreParam())
```

## 9.2 Backend types

Several parallelization backends are available, depending on OS:

* `SerialParam()` creates a serial (non-parallel) backend. Use this to avoid potential issues caused by parallelization.
* `MulticoreParam()` creates a multicore backend by forking the current R session. This is typically the fastest parallelization option, but is only available on macOS and Linux.
* `SnowParam()` creates a SNOW backend by creating new R sessions via socket connections. This is typically slower than multicore, but is available on all platforms including Windows.

Use of `MulticoreParam()` will frequently improve speed on macOS and Linux dramatically. However, due to the extra overhead of `SnowParam()`, Windows users may prefer `SerialParam()` (no parallelization), depending on the size of the dataset.

## 9.3 Getting available backends

Available backends can be viewed with `BiocParallel::registered()`.

```
BiocParallel::registered()
```

```
## $MulticoreParam
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
##
## $SnowParam
## class: SnowParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: SOCK
##
## $SerialParam
## class: SerialParam
##   bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: FALSE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: FALSE
##   bplogdir: NA
##   bpresultdir: NA
```

The current backend used by Cardinal can be viewed with `getCardinalBPPARAM()`:

```
getCardinalBPPARAM()
```

```
## NULL
```

The default is `NULL`, which means no parallelization.

## 9.4 Setting a parallel backend

A new default backend can be set for use with Cardinal by calling `setCardinalBPPARAM()`.

```
# register a SNOW backend
setCardinalBPPARAM(SnowParam(workers=2, progressbar=TRUE))

getCardinalBPPARAM()
```

```
## class: SnowParam
##   bpisup: FALSE; bpnworkers: 2; bptasks: 2147483647; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: TRUE
##   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: SOCK
```

See the *BiocParallel* package documentation for more details on available parallel backends.

```
# reset backend
setCardinalBPPARAM(NULL)
```

## 9.5 RNG and reproducibility

For methods that rely on random number generation to be reproducible when run in parallel, the RNG should be set to “L’Ecuyer-CMRG” to guarantee parallel-safe RNG streams.

```
set.seed(1, kind="L'Ecuyer-CMRG")
```

# 10 Statistical methods

Statistical methods are documented in a separate vignette. See `vignette("Cardinal3-stats")` to read about statistical methods in *Cardinal*.

More in-depth walkthroughs using real experimental data are available in the *CardinalWorkflows* package. You can install it using:

```
BiocManager::install("CardinalWorkflows")
```

Once installed, *CardinalWorkflows* can be loaded with `library()`:

```
library(CardinalWorkflows)
```

# 11 Session information

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
## Random number generation:
##  RNG:     L'Ecuyer-CMRG
##  Normal:  Inversion
##  Sample:  Rejection
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
## [1] Cardinal_3.12.1     S4Vectors_0.48.0    ProtGenerics_1.42.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocParallel_1.44.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        EBImage_4.52.0      jsonlite_2.0.0
##  [4] matter_2.12.0       compiler_4.5.2      BiocManager_1.30.27
##  [7] Rcpp_1.1.1          tinytex_0.58        Biobase_2.70.0
## [10] magick_2.9.0        bitops_1.0-9        parallel_4.5.2
## [13] jquerylib_0.1.4     CardinalIO_1.8.0    png_0.1-8
## [16] yaml_2.3.12         fastmap_1.2.0       lattice_0.22-9
## [19] R6_2.6.1            knitr_1.51          htmlwidgets_1.6.4
## [22] ontologyIndex_2.12  bookdown_0.46       fftwtools_0.9-11
## [25] bslib_0.10.0        tiff_0.1-12         rlang_1.1.7
## [28] cachem_1.1.0        xfun_0.56           sass_0.4.10
## [31] otel_0.2.0          cli_3.6.5           magrittr_2.0.4
## [34] digest_0.6.39       grid_4.5.2          locfit_1.5-9.12
## [37] irlba_2.3.7         nlme_3.1-168        lifecycle_1.0.5
## [40] evaluate_1.0.5      codetools_0.2-20    abind_1.4-8
## [43] RCurl_1.98-1.17     rmarkdown_2.30      tools_4.5.2
## [46] jpeg_0.1-11         htmltools_0.5.9
```