# Parallel Annotation

#### 2020-10-11

#### Package

peakPantheR 1.24.0

**Package**: *[peakPantheR](https://bioconductor.org/packages/3.22/peakPantheR)*
**Authors**: Arnaud Wolfer, Goncalo Correia

# 1 Introduction

The `peakPantheR` package is designed for the detection, integration and
reporting of pre-defined features in MS files (*e.g. compounds, fragments,
adducts, …*).

The **Parallel Annotation** is set to detect and integrate **multiple**
compounds in **multiple** files in **parallel** and store results in a
**single** object. It can be employed to integrate a large number of expected
features across a dataset.

Using the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* raw MS dataset as an example, this vignette
will:

* Detail the **Parallel Annotation** concept
* Apply the **Parallel Annotation** to a subset of pre-defined features in the
  *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* dataset

## 1.1 Abbreviations

* **ROI**: *Regions Of Interest*
  + reference *RT* / *m/z* windows in which to search for a feature
* **uROI**: *updated Regions Of Interest*
  + modifed ROI adapted to the current dataset which override the reference
    ROI
* **FIR**: *Fallback Integration Regions*
  + *RT* / *m/z* window to integrate if no peak is found
* **TIC**: *Total Ion Chromatogram*
  + the intensities summed across all masses for each scan
* **EIC**: *Extracted Ion Chromatogram*
  + the intensities summed over a mass range, for each scan

# 2 Parallel Annotation Concept

Parallel compound integration is set to process **multiple** compounds in
**multiple** files in **parallel**, and store results in a **single** object.

![](data:image/png;base64...)

To achieve this, `peakPantheR` will:

1. load a list of expected *RT* / *m/z* ROI and a list of files to process
2. initialise an output object with expected ROI and file paths
3. first pass (*without peak filling*) on a subset of representative samples
   (e.g QC samples):
   * for each file, detect features in each ROI and keep highest intensity
   * determine peak statistics for each feature
   * store results + EIC for each ROI
4. visual inspection of first pass results, update ROI:
   * diagnostic plots: all EICs, peak apex *RT* / *m/z* & peak width evolution
   * correct ROI (remove interfering feature, correct *RT* shift)
   * define fallback integration regions (FIR) if no feature is detected
     (median *RT* / *m/z* start and end of found features)
5. initialise a new output object, with updated regions of interest (uROI) and
   fallback integration regions (FIR), with all samples
6. second pass (*with peak filling*) on all samples:
   * for each file, detect features in each uROI and keep highest intensity
   * determine peak statistics for each feature
   * integrate FIR when no peaks are found
   * store results + EIC for each uROI
7. summary statistics:
   * plot EICs, apex and peakwidth evolution
   * compare first and second pass
8. return the resulting object and/or table (*row: file, col: compound*)

![](data:image/png;base64...)

> Diagram of the workflow and functions used for parallel annotation.

# 3 Parallel Annotation Example

We can target 2 pre-defined features in 6 raw MS spectra file from the
*[faahKO](https://bioconductor.org/packages/3.22/faahKO)* package using `peakPantheR_parallelAnnotation()`. For more
details on the installation and input data employed, please consult the
[Getting Started with peakPantheR](getting-started.html) vignette.

## 3.1 Input Data

First the paths to 3 MS file from the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* are located and used
as input spectras. In this example these 3 samples are considered as
representative of the whole run (e.g. Quality Control samples):

```
library(faahKO)
## file paths
input_spectraPaths  <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko18.CDF', package = "faahKO"))
input_spectraPaths
#> [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko15.CDF"
#> [2] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko16.CDF"
#> [3] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko18.CDF"
```

Two targeted features (*e.g. compounds, fragments, adducts, …*) are defined
and stored in a table with as columns:

* `cpdID` (character)
* `cpdName` (character)
* `rtMin` (sec)
* `rtMax` (sec)
* `rt` (sec, optional / `NA`)
* `mzMin` (m/z)
* `mzMax` (m/z)
* `mz` (m/z, optional / `NA`)

```
# targetFeatTable
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
                            "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
                                522.194778, 522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
                                496.195038, 496.2, 496.204962)
input_targetFeatTable[,c(3:8)] <- sapply(input_targetFeatTable[,c(3:8)],
                                        as.numeric)
```

| cpdID | cpdName | rtMin | rt | rtMax | mzMin | mz | mzMax |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ID-1 | Cpd 1 | 3310 | 3344.888 | 3390 | 522.194778 | 522.2 | 522.205222 |
| ID-2 | Cpd 2 | 3280 | 3385.577 | 3440 | 496.195038 | 496.2 | 496.204962 |

Additional compound and spectra metadata can be provided but isn’t employed
during the fitting procedure:

```
# spectra Metadata
input_spectraMetadata  <- data.frame(matrix(c("sample type 1", "sample type 2",
                            "sample type 1"), 3, 1,
                            dimnames=list(c(),c("sampleType"))),
                            stringsAsFactors=FALSE)
```

| sampleType |
| --- |
| sample type 1 |
| sample type 2 |
| sample type 1 |

## 3.2 Initialise and Run Parallel Annotation

A `peakPantheRAnnotation` object is first initialised with the path to the files
to process (`spectraPaths`), features to integrate (`targetFeatTable`) and
additional information and parameters such as `spectraMetadata`, `uROI`, `FIR`
and if they should be used (`useUROI=TRUE`, `useFIR=TRUE`):

```
library(peakPantheR)
init_annotation <- peakPantheRAnnotation(spectraPaths = input_spectraPaths,
                        targetFeatTable = input_targetFeatTable,
                        spectraMetadata = input_spectraMetadata)
```

The resulting `peakPantheRAnnotation` object is not annotated, does not contain
and use `uROI` and `FIR`

```
init_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 3 samples.
#>   updated ROI do not exist (uROI)
#>   does not use updated ROI (uROI)
#>   does not use fallback integration regions (FIR)
#>   is not annotated
```

`peakPantheR_parallelAnnotation()` will run the annotation across files in
parallel (if `ncores` >0) and return the successful annotations
(`result$annotation`) and failures (`result$failures`):

```
# annotate files serially
annotation_result <- peakPantheR_parallelAnnotation(init_annotation, ncores=0,
                                                    curveModel='skewedGaussian',
                                                    verbose=TRUE)
#> Processing 2 compounds in 3 samples:
#>   uROI:  FALSE
#>   FIR:   FALSE
#> ----- ko15 -----
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Check input, mzMLPath must be a .mzML
#> Reading data from 2 windows
#> Data read in: 2.9 secs
#> Warning: rtMin/rtMax outside of ROI; datapoints cannot be used for mzMin/mzMax calculation, approximate mz and returning ROI$mzMin and ROI$mzMax for ROI #1
#> Found 2/2 features in 0.03 secs
#> Peak statistics done in: 0 secs
#> Feature search done in: 3.92 secs
#> ----- ko16 -----
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Check input, mzMLPath must be a .mzML
#> Reading data from 2 windows
#> Data read in: 2.72 secs
#> Warning: rtMin/rtMax outside of ROI; datapoints cannot be used for mzMin/mzMax calculation, approximate mz and returning ROI$mzMin and ROI$mzMax for ROI #1
#> Warning: rtMin/rtMax outside of ROI; datapoints cannot be used for mzMin/mzMax calculation, approximate mz and returning ROI$mzMin and ROI$mzMax for ROI #2
#> Found 2/2 features in 0.02 secs
#> Peak statistics done in: 0 secs
#> Feature search done in: 3.67 secs
#> ----- ko18 -----
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Check input, mzMLPath must be a .mzML
#> Reading data from 2 windows
#> Data read in: 2.65 secs
#> Warning: rtMin/rtMax outside of ROI; datapoints cannot be used for mzMin/mzMax calculation, approximate mz and returning ROI$mzMin and ROI$mzMax for ROI #1
#> Warning: rtMin/rtMax outside of ROI; datapoints cannot be used for mzMin/mzMax calculation, approximate mz and returning ROI$mzMin and ROI$mzMax for ROI #2
#> Found 2/2 features in 0.02 secs
#> Peak statistics done in: 0 secs
#> Feature search done in: 3.58 secs
#> Annotation object cannot be reordered by sample acquisition date
#> ----------------
#> Parallel annotation done in: 13.62 secs
#>   0 failure(s)

# successful fit
nbSamples(annotation_result$annotation)
#> [1] 3
data_annotation   <- annotation_result$annotation
data_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 3 samples.
#>   updated ROI do not exist (uROI)
#>   does not use updated ROI (uROI)
#>   does not use fallback integration regions (FIR)
#>   is annotated

# list failed fit
annotation_result$failures
#> [1] file  error
#> <0 rows> (or 0-length row.names)
```

## 3.3 Process Parallel Annotation Results

Based on the fit results, updated ROI (`uROI`) and fallback integration region
(`FIR`) can be automatically determined using `annotationParamsDiagnostic()`:

* `uROI` are established as the min/max (`rt` and `m/z`) of the found peaks
  (+/- 5% in RT)
* `FIR` are established as the median of found `rtMin`, `rtMax`, `mzMin`,
  `mzMax`

```
updated_annotation  <- annotationParamsDiagnostic(data_annotation, verbose=TRUE)
#> uROI will be set as mimimum/maximum of found peaks (+/-5% of ROI in retention time)
#> FIR will be calculated as the median of found "rtMin","rtMax","mzMin","mzMax"

# uROI now exist
updated_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 3 samples.
#>   updated ROI exist (uROI)
#>   does not use updated ROI (uROI)
#>   does not use fallback integration regions (FIR)
#>   is annotated
```

`outputAnnotationDiagnostic()` will save to disk
`annotationParameters_summary.csv` containing the original `ROI` and newly
determined `uROI` and `FIR` for manual validation. Additionnaly a diagnostic
plot for each compound is saved for reference and can be generated in parallel
with the argument `ncores`:

```
# create a colourScale based on the sampleType
uniq_sType <- sort(unique(spectraMetadata(updated_annotation)$sampleType),
                    na.last=TRUE)
col_sType  <- unname( setNames(c('blue', 'red'),
                c(uniq_sType))[spectraMetadata(updated_annotation)$sampleType] )

# create a temporary location to save the diagnotic (otherwise provide the path
# to the selected location)
output_folder <- tempdir()

# output fit diagnostic to disk
outputAnnotationDiagnostic(updated_annotation, saveFolder=output_folder,
                            savePlots=TRUE, sampleColour=col_sType,
                            verbose=TRUE, ncores=2)
```

The data saved in `annotationParameters_summary.csv` is as follow:

Table continues below

| cpdID | cpdName | X | ROI\_rt | ROI\_mz | ROI\_rtMin | ROI\_rtMax | ROI\_mzMin |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ID-1 | Cpd 1 | | | 3344.888 | 522.2 | 3310 | 3390 | 522.194778 |
| ID-2 | Cpd 2 | | | 3385.577 | 496.2 | 3280 | 3440 | 496.195038 |

Table continues below

| ROI\_mzMax | X | uROI\_rtMin | uROI\_rtMax | uROI\_mzMin | uROI\_mzMax | uROI\_rt |
| --- | --- | --- | --- | --- | --- | --- |
| 522.205222 | | | 3305.75893 | 3411.43628 | 522.194778 | 522.205222 | 3344.888 |
| 496.204962 | | | 3337.37666 | 3462.44903 | 496.195038 | 496.204962 | 3385.577 |

| uROI\_mz | X | FIR\_rtMin | FIR\_rtMax | FIR\_mzMin | FIR\_mzMax |
| --- | --- | --- | --- | --- | --- |
| 522.2 | | | 3326.10635 | 3407.27265 | 522.194778 | 522.205222 |
| 496.2 | | | 3365.02386 | 3453.40496 | 496.195038 | 496.204962 |

![](data:image/png;base64...)

> Diagnostic plot for compound 1: The top panel is an overlay of the extracted
> EIC across all samples with the fitted curve as dotted line. The panel under the
> EIC represent each found peak RT peakwidth (`rtMin`, `rtMax` and apex marked as
> dot), ordered with the first sample at the top. The bottom 3 panels represent
> found `RT` (peakwidth), `m/z` (peakwidth) and `peak area` by run order, with the
> corresponding histograms to the right

`ROI` exported to `.csv` can be updated based on the diagnostic plots; `uROI`
(updated ROI potentially used for all samples) and `FIR` (fallback integration
regions for when no peak is found) can also be tweaked to better fit the peaks.

### 3.3.1 Retention time correction

The optional `retentionTimeCorrection()` method provides an interface to adjust
the expected ROI rt values and account for chromatographic batch effects. By
comparing expected and found rt values for a set of reference compounds, a model
of the chromatographic shift for the present batch can be established. This
model can be in turned used to correct the expected retention time of all
targeted compounds.
In order to apply this method, the `peakPantheRAnnotation` must be previously
annotated (`isAnnotated=TRUE`).
The retention time correction algorithm to use can be selected using the
`method` argument (currently `polynomial` and
`constant` methods are available).
`retentionTimeCorrection()` fits a correction function to model the dependency
of the mean `rt_dev_sec` per reference feature with the expected databased
retention time.
If `useUROI=TRUE`, the expected retention time value is taken from the `UROI_rt`
field, otherwise `ROI_rt` is used.
If `robust=TRUE`, the RANSAC algorithm is used to automatically detect outliers
and exclude them from the fit (this should only be used with a large number of
reference features).
`retentionTimeCorrection()` returns a list with 2 elements:
\* a modified `peakPantheRAnnotation` object
\* a `ggplot2` diagnostic plot (optional, depending on whether `TRUE` or `FALSE`
is passed to the `diagnostic` argument).
The returned `peakPantheRAnnotation` object contains the same `uROI` and `FIR`
`mz` values as the original annotation, but the retention time related
parameters (`rt`, `rtMin` and `rtMax`) are replaced by the adjusted values.
The `rtMax` and `rtMin` are set as the corrected `rt` value plus or minus half
the value passed to the `rtWindowWidth` argument, respectively.
`useUROI` is also set to TRUE.
To continue with the workflow, simply set a new annotation object with the
fit parameters established by `retentionTimeCorrection()` and call
`peakPantheR_parallelAnnotation()` for the final annotation.

![](data:image/png;base64...)

```
#> Warning in applyRTCorrection_checkInputParams(params, method, referenceTable):
#> `polynomialOrder` is larger than the number of references passed.
#> `polynomialOrder` will be set equal to number of reference compounds - 1
```

## 3.4 New Initialisation with Updated Parameters to be Applied to All Study Samples

Following this manual validation of the fit on reference samples, the modified
parameters in the `.csv` file can be reloaded and applied to all study samples.

### 3.4.1 Load new fit parameters

`peakPantheR_loadAnnotationParamsCSV()` will load the new `.csv` parameters (as
generated by `outputAnnotationDiagnostic()`) and initialise a
`peakPantheRAnnotation` object without `spectraPaths`, `spectraMetadata` or
`cpdMetadata` which will need to be added before annotation. `useUROI` and
`useFIR` are set to `FALSE` by default and will need to be modified according to
the analysis to run. `uROIExist` is established depending on the `.csv` uROI
column, and will only be set to TRUE if no `NA` are present. It is possible to
reset the `FIR` values with the `uROI` windows using `resetFIR()`.

```
update_csv_path <- '/path_to_new_csv/'

# load csv
new_annotation <- peakPantheR_loadAnnotationParamsCSV(update_csv_path)
#> uROIExist set to TRUE
#> New peakPantheRAnnotation object initialised for 2 compounds

new_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 0 samples.
#>   updated ROI exist (uROI)
#>   does not use updated ROI (uROI)
#>   does not use fallback integration regions (FIR)
#>   is not annotated

new_annotation <- resetFIR(new_annotation)
#> FIR will be reset with uROI values
```

### 3.4.2 Add new samples to process

Now that the fit parameters were set on 3 representative samples (e.g. QC), the
same processing can be applied to all study samples. `resetAnnotation()` will
reinitialise all the results and modify the samples or compounds targeted as
required:

```
## new files
new_spectraPaths   <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                        system.file('cdf/WT/wt15.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                        system.file('cdf/WT/wt16.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko18.CDF', package = "faahKO"),
                        system.file('cdf/WT/wt18.CDF', package = "faahKO"))

new_spectraPaths
#> [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko15.CDF"
#> [2] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt15.CDF"
#> [3] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko16.CDF"
#> [4] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt16.CDF"
#> [5] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko18.CDF"
#> [6] "/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt18.CDF"
```

Below we define the metadata of these new samples:

```
## new spectra metadata
new_spectraMetadata  <- data.frame(matrix(c("KO", "WT", "KO", "WT", "KO", "WT"),
                                        6, 1, dimnames=list(c(), c("Group"))),
                                    stringsAsFactors=FALSE)
```

| Group |
| --- |
| KO |
| WT |
| KO |
| WT |
| KO |
| WT |

```
## add new samples to the annotation loaded from csv, useUROI, useFIR

new_annotation <- resetAnnotation(new_annotation, spectraPaths=new_spectraPaths,
                                spectraMetadata=new_spectraMetadata,
                                useUROI=TRUE, useFIR=TRUE)
#> peakPantheRAnnotation object being reset:
#>   Previous "ROI", "cpdID" and "cpdName" value kept
#>   Previous "uROI" value kept
#>   Previous "FIR" value kept
#>   Previous "cpdMetadata" value kept
#>   New "spectraPaths" value set
#>   New "spectraMetadata" value set
#>   Previous "uROIExist" value kept
#>   New "useUROI" value set
#>   New "useFIR" value set
```

```
new_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 6 samples.
#>   updated ROI exist (uROI)
#>   uses updated ROI (uROI)
#>   uses fallback integration regions (FIR)
#>   is not annotated
```

## 3.5 Run Final Parallel Annotation

We can now run the final annotation on all samples with the optimised targeted
features:

```
# annotate files serially
new_annotation_result <- peakPantheR_parallelAnnotation(new_annotation,
                                                        ncores=0, verbose=FALSE)
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Warning in minpack.lm::nls.lm(par = init, lower = lower, upper = upper, : lmdif: info = -1. Number of iterations has reached `maxiter' == 50.
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Fit of ROI #1 is unsuccessful (cannot determine rtMin/rtMax)
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Warning in minpack.lm::nls.lm(par = init, lower = lower, upper = upper, : lmdif: info = -1. Number of iterations has reached `maxiter' == 50.
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Warning in min(tmpPt$mz): no non-missing arguments to min; returning Inf
#> Warning in max(tmpPt$mz): no non-missing arguments to max; returning -Inf
#> Polarity can not be extracted from netCDF files, please set manually the polarity with the 'polarity' method.
#> Warning in minpack.lm::nls.lm(par = init, lower = lower, upper = upper, : lmdif: info = -1. Number of iterations has reached `maxiter' == 50.

# successful fit
nbSamples(new_annotation_result$annotation)
#> [1] 6

final_annotation      <- new_annotation_result$annotation
final_annotation
#> An object of class peakPantheRAnnotation
#>  2 compounds in 6 samples.
#>   updated ROI exist (uROI)
#>   uses updated ROI (uROI)
#>   uses fallback integration regions (FIR)
#>   is annotated

# list failed fit
new_annotation_result$failures
#> [1] file  error
#> <0 rows> (or 0-length row.names)
```

### 3.5.1 Output final results

The final fits can be saved to disk with `outputAnnotationDiagnostic()`:

```
# create a colourScale based on the sampleType
uniq_group <- sort(unique(spectraMetadata(final_annotation)$Group),na.last=TRUE)
col_group  <- unname( setNames(c('blue', 'red'),
                    c(uniq_sType))[spectraMetadata(final_annotation)$Group] )

# create a temporary location to save the diagnotic (otherwise provide the path
# to the selected location)
final_output_folder <- tempdir()

# output fit diagnostic to disk
outputAnnotationDiagnostic(final_annotation, saveFolder=final_output_folder,
                        savePlots=TRUE, sampleColour=col_group, verbose=TRUE)
```

For each processed sample, a `peakTables` contains all the fit information for
all compounds targeted. `annotationTable( , column)` will group the values
across all samples and compounds for any `peakTables` column:

```
# peakTables for the first sample
peakTables(final_annotation)[[1]]
```

Table continues below

| found | rtMin | rt | rtMax | mzMin | mz | mzMax | peakArea | peakAreaRaw |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TRUE | 3322 | 3337 | 3337 | 522.2 | 522.2 | 522.2 | 4289965 | 4289965 |
| TRUE | 3363 | 3378 | 3378 | 496.2 | 496.2 | 496.2 | 7312556 | 7312556 |

Table continues below

| maxIntMeasured | maxIntPredicted | is\_filled | ppm\_error | rt\_dev\_sec |
| --- | --- | --- | --- | --- |
| 711872 | NA | TRUE | NA | NA |
| 982976 | NA | TRUE | NA | NA |

| tailingFactor | asymmetryFactor | cpdID | cpdName |
| --- | --- | --- | --- |
| NA | NA | ID-1 | Cpd 1 |
| NA | NA | ID-2 | Cpd 2 |

```
# Extract the found peak area for all compounds and all samples
annotationTable(final_annotation, column='peakArea')
```

Table continues below

|  | ID-1 |
| --- | --- |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko15.CDF** | 4289965 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt15.CDF** | 4355690 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko16.CDF** | 46184 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt16.CDF** | 28157 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko18.CDF** | 141309 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt18.CDF** | 101738 |

|  | ID-2 |
| --- | --- |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko15.CDF** | 7312556 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt15.CDF** | 9278578 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko16.CDF** | 473801 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt16.CDF** | 475297 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko18.CDF** | 743452 |
| **/home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/WT/wt18.CDF** | 1480713 |

Finally all annotation results can be saved to disk as `.csv` with
`outputAnnotationResult()`. These `.csv` will contain the compound metadata,
spectra metadata and a file for each column of peakTables (with samples as rows
and compounds as columns):

```
# create a temporary location to save the diagnotic (otherwise provide the path
# to the selected location)
final_output_folder <- tempdir()

# save
outputAnnotationResult(final_annotation, saveFolder=final_output_folder,
                        annotationName='ProjectName', verbose=TRUE)
#> Compound metadata saved at /final_output_folder/ProjectName_cpdMetadata.csv
#> Spectra metadata saved at
#>     /final_output_folder/ProjectName_spectraMetadata.csv
#> Peak measurement "found" saved at /final_output_folder/ProjectName_found.csv
#> Peak measurement "rtMin" saved at /final_output_folder/ProjectName_rtMin.csv
#> Peak measurement "rt" saved at /final_output_folder/ProjectName_rt.csv
#> Peak measurement "rtMax" saved at /final_output_folder/ProjectName_rtMax.csv
#> Peak measurement "mzMin" saved at /final_output_folder/ProjectName_mzMin.csv
#> Peak measurement "mz" saved at /final_output_folder/ProjectName_mz.csv
#> Peak measurement "mzMax" saved at /final_output_folder/ProjectName_mzMax.csv
#> Peak measurement "peakArea" saved at
#>     /final_output_folder/ProjectName_peakArea.csv
#> Peak measurement "maxIntMeasured" saved at
#>     /final_output_folder/ProjectName_maxIntMeasured.csv
#> Peak measurement "maxIntPredicted" saved at
#>     /final_output_folder/ProjectName_maxIntPredicted.csv
#> Peak measurement "is_filled" saved at
#>     /final_output_folder/ProjectName_is_filled.csv
#> Peak measurement "ppm_error" saved at
#>     /final_output_folder/ProjectName_ppm_error.csv
#> Peak measurement "rt_dev_sec" saved at
#>     /final_output_folder/ProjectName_rt_dev_sec.csv
#> Peak measurement "tailingFactor" saved at
#>     /final_output_folder/ProjectName_tailingFactor.csv
#> Peak measurement "asymmetryFactor" saved at
#>     /final_output_folder/ProjectName_asymmetryFactor.csv
#> Summary saved at /final_output_folder/ProjectName_summary.csv
```

# 4 See Also

* [Getting Started with peakPantheR](getting-started.html)
* [Real Time Annotation](real-time-annotation.html)
* [Graphical user interface use](peakPantheR-GUI.html)

# 5 Session Information

```
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  affy                   1.88.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  affyio                 1.80.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationFilter       1.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocBaseUtils          1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66    2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6     2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel           * 1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2     2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  faahKO               * 1.49.1    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach              * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges          1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms                    1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  impute                 1.84.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  IRanges                2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators            * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  MALDIquant             1.22.3    2024-08-19 [2] CRAN (R 4.5.1)
#>  MASS                   7.3-65    2025-02-28 [3] CRAN (R 4.5.1)
#>  MassSpecWavelet        1.76.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  MetaboCoreUtils        1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mime                   0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  minpack.lm             1.2-4     2023-09-11 [2] CRAN (R 4.5.1)
#>  MsCoreUtils            1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsExperiment           1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsFeatures             1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MSnbase              * 2.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MultiAssayExperiment   1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzID                   1.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzR                  * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ncdf4                  1.24      2025-03-25 [2] CRAN (R 4.5.1)
#>  otel                   0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  pander               * 0.6.6     2025-03-01 [2] CRAN (R 4.5.1)
#>  pcaMethods             2.2.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  peakPantheR          * 1.24.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild               1.4.8     2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1     2025-09-23 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  pracma                 2.4.6     2025-10-22 [2] CRAN (R 4.5.1)
#>  preprocessCore         1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress               1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  promises               1.4.0     2025-10-22 [2] CRAN (R 4.5.1)
#>  ProtGenerics         * 1.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  PSMatch                1.14.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  QFeatures              1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                 * 1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0     2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo                1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  shinycssloaders        1.1.0     2024-07-30 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Spectra                1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment   1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  svglite                2.2.2     2025-10-21 [2] CRAN (R 4.5.1)
#>  systemfonts            1.3.1     2025-10-01 [2] CRAN (R 4.5.1)
#>  textshaping            1.0.4     2025-10-10 [2] CRAN (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  usethis                3.2.1     2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vsn                    3.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xcms                   4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp46dGQn/Rinst22f71f76053c79
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```