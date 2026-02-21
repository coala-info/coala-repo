# MsQuality: Calculation of QC metrics from mass spectrometry data

Thomas Naake and Johannes Rainer1

1European Molecular Biology Laboratory, Meyerhofstrasse 1, 69117 Heidelberg/ EURAC Research, Viale Druso 1, 39100 Bolzano

#### 30 October 2025

#### Package

MsQuality 1.10.0

# 1 Introduction

Data quality assessment is an integral part of preparatory data analysis
to ensure sound biological information retrieval.

We present here the `MsQuality` package, which provides functionality to
calculate quality metrics for mass spectrometry-derived, spectral data at the
per-sample level. `MsQuality` relies on the
[`mzQC`](https://github.com/HUPO-PSI/mzQC) framework of quality metrics defined
by the Human Proteome Organization-Proteomics Standards Intitiative (HUPO-PSI).
These metrics quantify the quality of spectral raw files using a controlled
vocabulary. The package is especially addressed towards users that acquire
mass spectrometry data on a large scale (e.g. data sets from clinical settings
consisting of several thousands of samples): while it is easier to control
for high-quality data acquisition in small-scale experiments, typically run
in one or few batches, clinical data sets are often acquired over longer
time frames and are prone to higher technical variation that is often
unnoticed. `MsQuality` tries to address this problem by calculating metrics that
can be stored along the spectral data sets (raw files or feature-extracted
data sets). `MsQuality`, thus, facilitates the tracking of shifts in data
quality and quantifies the quality using multiple metrics. It should be thus
easier to identify samples that are of low quality (high-number of missing
values, termination of chromatographic runs, low instrument sensitivity, etc.).

We would like to note here that these metrics only give an indication of
data quality, and, before removing indicated low-quality samples from the
analysis more advanced analytics, e.g. using the implemented functionality
and visualizations in the `MatrixQCvis` package, should be scrutinized.
Also, data quality
should always be regarded in the context of the sample type and experimental
settings, i.e. quality metrics should always be compared with regard to the
sample type, experimental setup, instrumentation, etc..

The `MsQuality` package allows to calculate low-level quality metrics that
require minimum information on mass spectrometry data: retention time,
m/z values, and associated intensities.
The list included in the `mzQC` framework is excessive, also including
metrics that rely on more high-level information, that might not be readily
accessible from .raw or .mzML files, e.g. pump pressure mean, or rely
on alignment results, e.g. retention time mean shift, signal-to-noise ratio,
precursor errors (ppm).

The `MsQuality` package is built upon the `Spectra` and the `MsExperiment`
package.
Metrics will be calculated based on the information stored in a
`Spectra` object and the respective `dataOrigin` entries are used to
distinguish between the mass spectral data of multiple samples.
The `MsExperiment` serves as a container to
store the mass spectral data of multiple samples. `MsQuality` enables the user
to calculate quality metrics both on `Spectra` and `MsExperiment` objects.

`MsQuality` can be used for any type of experiment that can be represented as
a `Spectra` or `MsExperiment` object. This includes simple LC-MS data, DIA or
DDA-based data, ion mobility data or MS data in general. The tool can thus
be used for any type of targeted or untargeted metabolomics or proteomics
workflow. Also, we are not limited to data files in mzML format, but, through
`Spectra` and related `MsBackend` packages, data can be imported from a large
variety of formats, including some raw vendor formats.

In this vignette, we will (i) create some exemplary `Spectra` and `MsExperiment`
objects, (ii) calculate the quality metrics on these
data sets, and (iii) visualize some of the metrics.

## 1.1 Alternative software for data quality assessment

Other `R` packages are available in Bioconductor that are able to assess
the quality of mass spectrometry data:

[`artMS`](https://bioconductor.org/packages/release/bioc/html/artMS.html)
uses MaxQuant output and enables to calculate several QC metrics, e.g.
correlation matrix for technical replicates, calculation of total sum of
intensities in biological replicates, total peptide counts in biological
replicates, charge state distribution of PSMs identified in each biological
replicates, or MS1 scan counts in each biological replicate.

[`MSstatsQC`](https://bioconductor.org/packages/release/bioc/html/MSstatsQC.html)
and the visualization tool
[`MSstatsQCgui`](https://bioconductor.org/packages/release/bioc/html/MSstatsQCgui.html)
require csv files in long format from spectral processing tools such as
Skyline and Panorama autoQC or `MSnbase` objects. `MSstatsQC` enables to
generate individual, moving range, cumulative sum for mean, and/or
cumulative sum for variability control charts for each metric. Metrics
can be any kind of user-defined metric stored in the data columns for a given
peptide, e.g. retention time and peak area.

[`MQmetrics`](https://bioconductor.org/packages/release/bioc/html/MQmetrics.html)
provides a pipeline to analyze the quality of proteomics data sets from
MaxQuant files and focuses on proteomics-/MaxQuant-specific metrics, e.g.
proteins identified, peptides identified, or proteins versus
peptide/protein ratio.

[`MatrixQCvis`](https://bioconductor.org/packages/release/bioc/html/MatrixQCvis.html)
provides an interactive shiny-based interface to assess data quality at various
processing steps (normalization, transformation, batch correction, and
imputation) of rectangular matrices. The package includes several diagnostic
plots and metrics such as barplots of intensity distributions, plots to
visualize drifts, MA plots and Hoeffding’s D value calculation, and
dimension reduction plots and provides specific tools to analyze data sets
containing missing values as commonly observed in mass spectrometry.

[`proBatch`](https://bioconductor.org/packages/release/bioc/html/proBatch.html)
enables to assess batch effects in (prote)omics data sets and corrects these
batch effects in subsequent steps. Several tools to visualize data quality are
included in the `proBatch` packages, such as barplots of intensity
distributions, cluster and heatmap analysis tools, and PCA dimension
reduction plots. Additionally, `proBatch` enables to assess diagnostics at
the feature level, e.g. peptides or spike-ins.

# 2 Installation

To install this package, start `R` and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

if (!requireNamespace("remotes", quietly = TRUE))
    install.packages("remotes")

## to install from Bioconductor
BiocManager::install("MsQuality")

## to install from GitHub
BiocManager::install("tnaake/MsQuality")
```

This will install this package and all eventually missing dependencies.

# Questions and bugs

`MsQuality` is currently under active development. If you discover any bugs,
typos or develop ideas of improving `MsQuality` feel free to raise an issue
via [GitHub](https://github.com/tnaake/MsQuality) or send a mail to the
developer.

# 3 Create `Spectra` and `MsExperiment` objects

Load the `Spectra` package.

```
library("Spectra")
library("MsExperiment")
```

```
## Loading required package: ProtGenerics
```

```
##
## Attaching package: 'ProtGenerics'
```

```
## The following object is masked from 'package:stats':
##
##     smooth
```

```
library("MsQuality")
```

## 3.1 Create `Spectra` and `MsExperiment` objects from mzML files

There are several options available to create a `Spectra` object. One way, as
outlined in the vignette of the *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* package is
by specifying the location of mass spectrometry raw files in `mzML`, `mzXML` or
`CDF` format and using the `MsBackendMzR` backend. Here we load the example
files from the `sciex` data set of the `msdata` package and create a `Spectra`
object from the two provided `mzML` files. The example is taken from the
`Spectra` vignette.

```
## this example is taken from the Spectra vignette
fls <- dir(system.file("sciex", package = "msdata"), full.names = TRUE)
sps_sciex <- Spectra(fls, backend = MsBackendMzR())
```

The data set consists of a single sample measured in two different
injections to the same LC-MS setup. An empty instance of an
`MsExperiment` object is created and populated with information on the samples
by assigning data on the samples (`sampleData`), information on the
`mzML` files (`MsExperimentFiles`) and spectral information (`spectra`).
In a last step, using `linkSampleData`, the relationships between the samples
and the spectral information are defined.

```
## this example is taken from the Spectra vignette
lmse <- MsExperiment()
sd <- DataFrame(sample_id = c("QC1", "QC2"),
    sample_name = c("QC Pool", "QC Pool"),
    injection_idx = c(1, 3))
sampleData(lmse) <- sd
## add mzML files to the experiment
experimentFiles(lmse) <- MsExperimentFiles(mzML_files = fls)
## add the Spectra object to the experiment
spectra(lmse) <- sps_sciex
## use linkSampleData to establish and define relationships between sample
## annotations and MS data
lmse <- linkSampleData(lmse, with = "experimentFiles.mzML_file",
    sampleIndex = c(1, 2), withIndex = c(1, 2))
```

## 3.2 Create `Spectra` and `MsExperiment` objects from (feature-extracted) intensity tables

Another common approach is the creation of `Spectra` objects from a
`DataFrame`s using the `MsBackendDataFrame` backend.

We will use here the data set of Lee et al. ([2019](#ref-Lee2019)), that contains metabolite level
information measured by reverse phase liquid chromatography (RPLC) coupled
to mass spectrometry and hydrophilic interaction liquid chromatography (HILIC)
coupled to mass spectrometry
(derived from the file `STables - rev1.xlsx` in the Supplementary Information).

In a separate step (see documentation for `Lee2019_meta_vals` and
`Lee2019`), we have created a list containing `Spectra` objects for
each samples (objects `sps_l_rplc` and `sps_l_hilic`) and `MsExperiment`
objects containing the data of all samples (objects `msexp_rplc` and
`msexp_hilic`). We will load here these objects:

```
data("Lee2019", package = "MsQuality")
```

The final data set contains 541
paired samples (i.e. 541 samples derived
from RPLC and 541 samples derived
from HILIC).

We will combine the `sps_rplc` and `sps_hilic` objects in the following and
calculate on this combined document the metrics.

```
sps_comb <- c(sps_rplc, sps_hilic)
```

The most important function to assess the data quality and to calculate the
metrics is the `calculateMetrics` function. The function takes
a `Spectra` or `MsExperiment` object as input, a character vector of metrics
to be calculated, and, optionally a list of parameters passed to the
quality metrics functions.

# 4 Calculating the quality metrics on `Spectra` and `MsExperiment` objects

Currently, the following metrics are included:

```
qualityMetrics(sps_comb)
```

```
##  [1] "chromatographyDuration"             "ticQuantileRtFraction"
##  [3] "rtOverMsQuarters"                   "ticQuartileToQuartileLogRatio"
##  [5] "numberSpectra"                      "numberEmptyScans"
##  [7] "medianPrecursorMz"                  "rtIqr"
##  [9] "rtIqrRate"                          "areaUnderTic"
## [11] "areaUnderTicRtQuantiles"            "extentIdentifiedPrecursorIntensity"
## [13] "medianTicRtIqr"                     "medianTicOfRtRange"
## [15] "mzAcquisitionRange"                 "rtAcquisitionRange"
## [17] "precursorIntensityRange"            "precursorIntensityQuartiles"
## [19] "precursorIntensityMean"             "precursorIntensitySd"
## [21] "msSignal10xChange"                  "ratioCharge1over2"
## [23] "ratioCharge3over2"                  "ratioCharge4over2"
## [25] "meanCharge"                         "medianCharge"
```

## 4.1 List of included metrics

The following list gives a brief explanation on the included metrics. Further
information may be found at the
[HUPO-PSI mzQC project page](https://github.com/HUPO-PSI/mzQC) or in the
respective help file for the quality metric (accessible by e.g. entering
`?chromatographyDuration` to the R console).
We also give here explanation on how the metric is calculated in `MsQuality`.
Currently, all quality metrics can be calculated for both `Spectra` and
`MsExperiment` objects.

* *chromatographyDuration*, **chromatography duration** (MS:4000053),
  “The retention time duration of the chromatography in seconds.” [PSI:MS];
  Longer duration may indicate a better chromatographic separation of compounds
  which depends, however, also on the sampling/scan rate of the MS instrument.

  The metric is calculated as follows:

  1. the retention time associated to the `Spectra` object is obtained,
  2. the maximum and the minimum of the retention time is obtained,
  3. the difference between the maximum and the minimum is calculated and returned.
* *rtOverMsQuarters*, **MS1 quarter RT fraction** (MS:4000055),
  “The interval used for acquisition of the first, second, third, and fourth
  quarter of all MS1 events divided by retention time duration.” [PSI:MS],
  `msLevel = 1L`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation. For MS1 scans, the values are expected to be in
  a similar range across samples of the same type.

  The metric is calculated as follows:

  1. the retention time duration of the whole `Spectra` object is determined
     (taking into account all the MS levels),
  2. the `Spectra` object is filtered according to the MS level and
     subsequently ordered according to the retention time,
  3. the MS events are split into four (approximately) equal parts,
  4. the relative retention time is calculated (using the retention time
     duration from (1) and taking into account the minimum retention time),
  5. the relative retention time values associated to the MS event parts
     are returned.
* *rtOverMsQuarters*, **MS2 quarter RT fraction** (MS:4000056),
  “The interval used for acquisition of the first, second, third, and fourth
  quarter of all MS2 events divided by retention time duration.” [PSI:MS],
  `msLevel = 2L`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation. For MS2 scans, the comparability of the values
  depends on the acquisition mode and settings to select ions for fragmentation.

  The metric is calculated as follows:

  1. the retention time duration of the whole `Spectra` object is determined
     (taking into account all the MS levels),
  2. the `Spectra` object is filtered according to the MS level and
     subsequently ordered according to the retention time,
  3. the MS events are split into four (approximately) equal parts,
  4. the relative retention time is calculated (using the retention time
     duration from (1) and taking into account the minimum retention time),
  5. the relative retention time values associated to the MS event parts
     are returned.
* *ticQuartileToQuartileLogRatio*, **MS1 TIC-change quartile ratios**
  (MS:4000057), "“The log ratios of successive TIC-change quartiles. The TIC
  changes are the list of MS1 total ion current (TIC) value changes from
  one to the next scan, produced when each MS1 TIC is subtracted from the
  preceding MS1 TIC. The metric’s value triplet represents the log ratio of the
  TIC-change Q2 to Q1, Q3 to Q2, TIC-change-max to Q3” [PSI:MS],
  `mode = "TIC_change"`, `relativeTo = "previous"`, `msLevel = 1L`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation.This metric evaluates the stability (similarity)
  of MS1 TIC values from scan to scan along the LC run. High log ratios
  representing very large intensity differences between pairs of scans might
  be due to electrospray instability or presence of a chemical contaminant.

  The metric is calculated as follows:

  1. the TIC (`ionCount`) of the `Spectra` object is calculated
     per scan event (with spectra ordered by retention time),
  2. the differences between TIC values are calculated between subsequent
     scan events,
  3. the ratios between the 25%, 50%, 75%, and 100% quantile to the
     25% quantile of the values of (2) are calculated,
  4. the `log` values of the ratios are returned.
* *ticQuartileToQuartileLogRatio*, **MS1 TIC quartile ratios** (MS:4000058),
  “The log ratios of successive TIC quartiles. The metric’s value triplet
  represents the log ratios of TIC-Q2 to TIC-Q1, TIC-Q3 to TIC-Q2,
  TIC-max to TIC-Q3.” [PSI:MS], `mode = "TIC"`,
  `relativeTo = "previous"`, `msLevel = 1L`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation. The ratios provide information on the distribution
  of the TIC values for one LC-MS run. Within an experiment, with the same
  LC setup, values should be comparable between samples.

  The metric is calculated as follows:

  1. the TIC (`ionCount`) of the `Spectra` object is calculated
     per scan event (with spectra ordered by retention time),
  2. the TIC values between subsequent scan events are taken
     as they are,
  3. the ratios between the 25%, 50%, 75%, and 100% quantile to the
     25% quantile of the values of (2) are calculated.
  4. The `log` values of the ratios are returned.
* *numberSpectra*, **number of MS1 spectra** MS:4000059),
  “The number of MS1 events in the run.” [PSI:MS], `msLevel = 1L`;
  An unusual low number may indicate incomplete sampling/scan rate of the MS
  instrument, low sample volume and/or failed injection of a sample.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the number of the spectra are obtained (`length` of `Spectra`) and
     returned.
* *numberSpectra*, **number of MS2 spectra** (MS:4000060),
  “The number of MS2 events in the run.” [PSI:MS], `msLevel = 2L`;
  An unusual low number may indicate incomplete sampling/scan rate of the MS
  instrument, low sample volume and/or failed injection of a sample.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the number of the spectra are obtained (`length` of `Spectra`) and
     returned.
* *mzAcquisitionRange*, **m/z acquisition range** (MS:4000069),
  “Upper and lower limit of m/z precursor values at which MSn spectra are
  recorded.” [PSI:MS];
  The metric informs about the dynamic range of the acquisition. Based on the
  used MS instrument configuration, the values should be similar. Variations
  between measurements may arise when employing acquisition in DDA mode.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the m/z values of the peaks within the `Spectra` object are obtained,
  3. the minimum and maximum m/z values are obtained and returned.
* *rtAcquisitionRange*, **retention time acquisition range** (MS:4000070),
  “Upper and lower limit of retention time at which spectra are recorded.”
  [PSI:MS];
  An unusual low range may indicate incomplete sampling and/or a premature or
  failed LC run.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the retention time values of the features within the `Spectra`
     object are obtained,
  3. the minimum and maximum retention time values are obtained and
     returned.
* *msSignal10xChange*, **MS1 signal jump (10x) count** (MS:4000097),
  “The number of times where MS1 TIC increased more than 10-fold between adjacent
  MS1 scans. An unusual high count of signal jumps or falls can indicate
  ESI stability issues.” [PSI:MS], `change = "jump"`, `msLevel = 1L`;
  An unusual high count of signal jumps or falls may indicate ESI stability
  issues.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the intensity values of the features are obtained via the ion count,
  4. the signal jumps/declines of the intensity values with the two
     subsequent intensity values is calculated,
  5. the signal jumps by a factor of ten or more are counted and returned.
* *msSignal10xChange*, **MS1 signal fall (10x) count** (MS:4000098),
  “The number of times where MS1 TIC decreased more than 10-fold between adjacent
  MS1 scans. An unusual high count of signal jumps or falls can indicate
  ESI stability issues.” [PSI:MS], `change = "fall"`, `msLevel = 1L`;
  An unusual high count of signal jumps or falls may indicate ESI stability
  issues.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the intensity values of the features are obtained via the ion count,
  4. the signal jumps/declines of the intensity values with the two
     subsequent intensity values is calculated,
  5. the signal declines by a factor of ten or more are counted and returned.
* *numberEmptyScans*, **number of empty MS1 scans** (MS:4000099),
  “Number of MS1 scans where the scans’ peaks intensity sums to 0 (i.e. no
  peaks or only 0-intensity peaks).” [PSI:MS], `msLevel = 1L`;
  An unusual high number may indicate incomplete sampling/scan rate of the MS
  instrument, low sample volume and/or failed injection of a sample.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensities per entry are obtained,
  3. the number of intensity entries that are `NULL`, `NA`, or
     that have a sum of `0` are obtained and returned.
* *numberEmptyScans*, **number of empty MS2 scans** (MS:4000100),
  “Number of MS2 scans where the scans’ peaks intensity sums to 0 (i.e. no
  peaks or only 0-intensity peaks).” [PSI:MS], `msLevel = 2L`;
  An unusual high number may indicate incomplete sampling/scan rate of the MS
  instrument, low sample volume and/or failed injection of a sample.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensities per entry are obtained,
  3. the number of intensity entries that are `NULL`, `NA`, or
     that have a sum of `0` are obtained and returned.
* *numberEmptyScans*, **number of empty MS3 scans** (MS:4000101),
  “Number of MS3 scans where the scans’ peaks intensity sums to 0 (i.e. no
  peaks or only 0-intensity peaks).” [PSI:MS], `msLevel = 3L`;
  An unusual high number may indicate incomplete sampling/scan rate of the MS
  instrument, low sample volume and/or failed injection of a sample.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensities per entry are obtained,
  3. the number of intensity entries that are `NULL`, `NA`, or
     that have a sum of `0` are obtained and returned.
* *precursorIntensityQuartiles*,
  **MS2 precursor intensity distribution Q1, Q2, Q3** (MS:4000116),
  “From the distribution of MS2 precursor intensities, the quartiles
  Q1, Q2, Q3.” [PSI:MS], `identificationLevel = "all"`;
  The intensity distribution of the precursors informs about the dynamic range
  of the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are obtained,
  3. the 25%, 50%, and 75% quantile of the precursor intensity values are
     obtained (`NA` values are removed) and returned.
* *precursorIntensityMean*, **MS2 precursor intensity distribution mean**
  (MS:4000117), “From the distribution of MS2 precursor intensities, the mean.”
  [PSI:MS], `identificationLevel = "all"`;
  The intensity distribution of the precursors informs about the dynamic range
  of the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the mean of the precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *precursorIntensitySd*, **MS2 precursor intensity distribution sigma**
  (MS:4000118), “From the distribution of MS2 precursor intensities, the sigma
  value.” [PSI:MS], `identificationLevel = "all"`;
  The intensity distribution of the precursors informs about the dynamic range of
  the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the standard deviation of precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *medianPrecursorMz*,
  **MS2 precursor median m/z of identified quantification data points**
  (MS:4000152),
  “Median m/z value for MS2 precursors of all quantification data points after
  user-defined acceptance criteria are applied. These data points may be for
  example XIC profiles, isotopic pattern areas, or reporter ions
  (see MS:1001805). The used type should be noted in the metadata or
  analysis methods section of the recording file for the respective run. In
  case of multiple acceptance criteria (FDR) available in proteomics, PSM-level
  FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`, `msLevel = 1L`;
  The m/z distribution informs about the dynamic range of the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor m/z values are obtained,
  3. the median value is returned (`NA`s are removed).
* *rtIqr*,
  **interquartile RT period for identified quantification data points**
  (MS:4000153), “The interquartile retention time period, in seconds, for all
  quantification data points after user-defined acceptance criteria are applied
  over the complete run. These data points may be for example XIC profiles,
  isotopic pattern areas, or reporter ions (see MS:1001805). The used type
  should be noted in the metadata or analysis methods section of the recording
  file for the respective run. In case of multiple acceptance criteria (FDR)
  available in proteomics, PSM-level FDR should be used for better
  comparability.”
  [PSI:MS], `identificationLevel = "identified"`;
  Longer duration may indicate a better chromatographic separation of compounds
  which depends, however, also on the sampling/scan rate of the MS instrument.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the retention time values are obtained,
  3. the interquartile range is obtained from the values and returned
     (`NA` values are removed).
* *rtIqrRate*,
  **rate of the interquartile RT period for identified quantification data points**
  (MS:4000154), “The rate of identified quantification data points for the
  interquartile retention time period, in identified quantification data points
  per second. These data points may be for example XIC profiles, isotopic
  pattern areas, or reporter ions (see MS:1001805). The used type should
  be noted in the metadata or analysis methods section of the recording
  file for the respective run. In case of multiple acceptance criteria (FDR)
  available in proteomics, PSM-level FDR should be used for better
  comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  Higher rates may indicate a more efficient sampling and identification.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the retention time values are obtained,
  3. the 25% and 75% quantiles are obtained from the retention time values
     (`NA` values are removed),
  4. the number of eluted features between this 25% and 75% quantile is
     calculated,
  5. the number of features is divided by the interquartile range of the
     retention time and returned.
* *areaUnderTic*, **area under TIC** (MS:4000155),
  “The area under the total ion chromatogram.” [PSI:MS];
  The metric informs about the dynamic range of the acquisition. Differences
  between samples of an experiment may indicate differences in the dynamic
  range and/or in the sample content.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the sum of the ion counts are obtained and returned.
* *areaUnderTicRtQuantiles*, **area under TIC RT quantiles** (MS:4000156),
  “The area under the total ion chromatogram of the retention time quantiles.
  Number of quantiles are given by the n-tuple.” [PSI:MS];
  The metric informs about the dynamic range of the acquisition. Differences
  between samples of an experiment may indicate differences in the dynamic
  range and/or in the sample content.
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation. Differences between samples of an experiment may
  indicate differences in chromatographic performance, differences in the
  dynamic range and/or in the sample content.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the `Spectra` object is ordered according to the retention time,
  3. the 0%, 25%, 50%, 75%, and 100% quantiles of the retention time
     values are obtained,
  4. the ion count of the intervals between the 0%/25%, 25%/50%,
     50%/75%, and 75%/100% are obtained,
  5. the ion counts of the intervals are summed (TIC) and the values returned.
* *extentIdentifiedPrecursorIntensity*,
  **extent of identified MS2 precursor intensity** (MS:4000157),
  “Ratio of 95th over 5th percentile of MS2 precursor intensity for all
  quantification data points after user-defined acceptance criteria are
  applied. The used type of identification should be noted in the metadata or
  analysis methods section of the recording file for the respective run.
  In case of multiple acceptance criteria (FDR) available in proteomics,
  PSM-level FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensities of the precursor ions are obtained,
  3. the 5% and 95% quantile of these intensities are obtained
     (1NA1 values are removed),
  4. the ratio between the 95% and the 5% intensity quantile is calculated
     and returned.
* *medianTicRtIqr*, **median of TIC values in the RT range in which the middle
  half of quantification data points are identified** (MS:4000158),
  “Median of TIC values in the RT range in which half of quantification data
  points are identified (RT values of Q1 to Q3 of identifications). These
  data points may be for example XIC profiles, isotopic pattern areas, or
  reporter ions (see MS:1001805). The used type should be noted in the metadata
  or analysis methods section of the recording file for the respective run.
  In case of multiple acceptance criteria (FDR) available in proteomics,
  PSM-level FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the `Spectra` object is ordered according to the retention time,
  3. the features between the 1st and 3rd quartile are obtained
     (half of the features that are present in the `Spectra` object),
  4. the ion count of the features within the 1st and 3rd quartile is
     obtained,
  5. the median value of the ion count is calculated (`NA` values are
     removed) and the median value is returned.
* *medianTicOfRtRange*, **median of TIC values in the shortest RT range in
  which half of the quantification data points are identified** (MS:4000159),
  “Median of TIC values in the shortest RT range in which half of the
  quantification data points are identified. These data points may be for
  example XIC profiles, isotopic pattern areas, or reporter ions
  (see MS:1001805). The used type should be noted in the metadata or analysis
  methods section of the recording file for the respective run. In case of
  multiple acceptance criteria (FDR) available in proteomics, PSM-level FDR
  should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the `Spectra` object is ordered according to the retention time,
  3. the number of features in the `Spectra` object is obtained and
     the number for half of the features is calculated,
  4. iterate through the features (always by taking the neighbouring
     half of features) and calculate the retention time range of the
     set of features,
  5. retrieve the set of features with the minimum retention time
     range,
  6. calculate from the set of (5) the median TIC (`NA` values are removed)
     and return it.
* *precursorIntensityRange*, **MS2 precursor intensity range** (MS:4000160),
  “Minimum and maximum MS2 precursor intensity recorded.” [PSI:MS];
  The metric informs about the dynamic range of the acquisition.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the minimum and maximum precursor intensity values are obtained and
     returned.
* *precursorIntensityQuartiles*,
  **identified MS2 precursor intensity distribution Q1, Q2, Q3** (MS:4000161),
  “From the distribution of identified MS2 precursor intensities, the quartiles
  Q1, Q2, Q3. The used type of identification should be noted in the metadata
  or analysis methods section of the recording file for the respective run.
  In case of multiple acceptance criteria (FDR) available in proteomics,
  PSM-level FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition in relation to
  identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are obtained,
  3. the 25%, 50%, and 75% quantile of the precursor intensity values are
     obtained (`NA` values are removed) and returned.
* *precursorIntensityQuartiles*,
  **unidentified MS2 precursor intensity distribution Q1, Q2, Q3** (MS:4000162),
  “From the distribution of unidentified MS2 precursor intensities, the
  quartiles Q1, Q2, Q3. The used type of identification should be noted in the
  metadata or analysis methods section of the recording file for the respective
  run. In case of multiple acceptance criteria (FDR) available in proteomics,
  PSM-level FDR should be used for better comparability.”
  [PSI:MS], `identificationLevel = "unidentified"`;
  The metric informs about the dynamic range of the acquisition in relation to
  identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the 25%, 50%, and 75% quantile of the precursor intensity values are
     obtained (`NA` values are removed) and returned.
* *precursorIntensityMean*,
  **identified MS2 precursor intensity distribution mean** (MS:4000163),
  “From the distribution of identified MS2 precursor intensities, the mean.
  The intensity distribution of the identified precursors informs about the
  dynamic range of the acquisition in relation to identifiability. The used
  type of identification should be noted in the metadata or analysis methods
  section of the recording file for the respective run. In case of multiple
  acceptance criteria (FDR) available in proteomics, PSM-level FDR should be
  used for better comparability.”
  [PSI:MS], `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition in relation to
  identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the mean of the precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *precursorIntensityMean*,
  **unidentified MS2 precursor intensity distribution mean** (MS:4000164),
  “From the distribution of unidentified MS2 precursor intensities, the mean.
  The used type of identification should be noted in the metadata or analysis
  methods section of the recording file for the respective run. In case of
  multiple acceptance criteria (FDR) available in proteomics, PSM-level FDR
  should be used for better comparability.” [PSI:MS],
  `identificationLevel = "unidentified"`;
  The metric informs about the dynamic range of the acquisition in relation
  to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the mean of the precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *precursorIntensitySd*,
  **identified MS2 precursor intensity distribution sigma** (MS:4000165),
  “From the distribution of identified MS2 precursor intensities, the sigma
  value. The used type of identification should be noted in the metadata or
  analysis methods section of the recording file for the respective run. In
  case of multiple acceptance criteria (FDR) available in proteomics, PSM-level
  FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  The metric informs about the dynamic range of the acquisition in relation to
  identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the standard deviation of precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *precursorIntensitySD*,
  **unidentified MS2 precursor intensity distribution sigma** (MS:4000166),
  “From the distribution of unidentified MS2 precursor intensities, the sigma
  value. The used type of identification should be noted in the metadata or
  analysis methods section of the recording file for the respective run. In
  case of multiple acceptance criteria (FDR) available in proteomics, PSM-level
  FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "unidentified"`;
  The metric informs about the dynamic range of the acquisition in relation to
  identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the intensity of the precursor ions within the `Spectra` object are
     obtained,
  3. the standard deviation of precursor intensity values is obtained
     (`NA` values are removed) and returned.
* *ratioCharge1over2*,
  **ratio of 1+ over 2+ of all MS2 known precursor charges** (MS:4000167),
  “The ratio of 1+ over 2+ MS2 precursor charge count of all spectra.” [PSI:MS],
  `identificationLevel = "all"`;
  High ratios of 1+/2+ MS2 precursor charge count may indicate inefficient
  ionization.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 1+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *ratioCharge1over2*,
  **ratio of 1+ over 2+ of identified MS2 known precursor charges** (MS:4000168),
  "“The ratio of 1+ over 2+ MS2 precursor charge count of identified spectra.
  The used type of identification should be noted in the metadata or analysis
  methods section of the recording file for the respective run. In case of
  multiple acceptance criteria (FDR) available in proteomics, PSM-level FDR
  should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  High ratios of 1+/2+ MS2 precursor charge count may indicate inefficient
  ionization in relation to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 1+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *ratioCharge3over2*,
  **ratio of 3+ over 2+ of all MS2 known precursor charges** (MS:4000169),
  “The ratio of 3+ over 2+ MS2 precursor charge count of all spectra.” [PSI:MS],
  `identificationLevel = "all"`;
  Higher ratios of 3+/2+ MS2 precursor charge count may indicate e.g.
  preference for longer peptides.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 3+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *ratioCharge3over2*,
  **ratio of 3+ over 2+ of identified MS2 known precursor charges** (MS:4000170),
  “The ratio of 3+ over 2+ MS2 precursor charge count of identified spectra.
  The used type of identification should be noted in the metadata or analysis
  methods section of the recording file for the respective run. In case of
  multiple acceptance criteria (FDR) available in proteomics, PSM-level
  FDR should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  Higher ratios of 3+/2+ MS2 precursor charge count may indicate e.g.
  preference for longer peptides in relation to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 3+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *ratioCharge4over2*,
  **ratio of 4+ over 2+ of all MS2 known precursor charges** (MS:4000171),
  “The ratio of 4+ over 2+ MS2 precursor charge count of all spectra.”
  [PSI:MS], `identificationLevel = "all"`;
  Higher ratios of 3+/2+ MS2 precursor charge count may indicate e.g.
  preference for longer peptides.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 4+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *ratioCharge4over2*,
  **ratio of 4+ over 2+ of identified MS2 known precursor charges** (MS:4000172),
  “The ratio of 4+ over 2+ MS2 precursor charge count of identified spectra.
  The used type of identification should be noted in the metadata or analysis
  methods section of the recording file for the respective run. In case of
  multiple acceptance criteria (FDR) available in proteomics, PSM-level FDR
  should be used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  Higher ratios of 3+/2+ MS2 precursor charge count may indicate e.g.
  preference for longer peptides in relation to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the number of precursors with charge 4+ is divided by the number of
     precursors with charge 2+ and the ratio is returned.
* *meanCharge*, **mean MS2 precursor charge in all spectra** (MS:4000173),
  “Mean MS2 precursor charge in all spectra” [PSI:MS],
  `identificationLevel = "all"`;
  Higher charges may indicate inefficient ionization or e.g. preference for
  longer peptides.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the mean of the precursor charge values is calculated and returned.
* *meanCharge*, **mean MS2 precursor charge in identified spectra** (MS:4000174),
  “Mean MS2 precursor charge in identified spectra. The used type of
  identification should be noted in the metadata or analysis methods section
  of the recording file for the respective run. In case of multiple acceptance
  criteria (FDR) available in proteomics, PSM-level FDR should be used for
  better comparability.” [PSI:MS], `identificationLevel = "identified"`;
  Higher charges may indicate inefficient ionization or e.g. preference for
  longer peptides in relation to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the mean of the precursor charge values is calculated and returned.
* *medianCharge*, **median MS2 precursor charge in all spectra** (MS:4000175),
  “Median MS2 precursor charge in all spectra” [PSI:MS],
  `identificationLevel = "all"`;
  Higher charges may indicate inefficient ionization and/or e.g. preference
  for longer peptides.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the median of the precursor charge values is calculated and returned.
* *medianCharge*, **median MS2 precursor charge in identified spectra**
  (MS:4000176), “Median MS2 precursor charge in identified spectra. The used
  type of identification should be noted in the metadata or analysis methods
  section of the recording file for the respective run. In case of multiple
  acceptance criteria (FDR) available in proteomics, PSM-level FDR should be
  used for better comparability.” [PSI:MS],
  `identificationLevel = "identified"`;
  Higher charges may indicate inefficient ionization and/or e.g. preference for
  longer peptides in relation to identifiability.

  The metric is calculated as follows:

  1. the `Spectra` object is filtered according to the MS level,
  2. the precursor charge is obtained,
  3. the median of the precursor charge values is calculated and returned.
* *ticQuantileRtFraction*, **TIC quantile RT fraction** (MS:4000183),
  “The interval when the respective quantile of the TIC accumulates divided by
  retention time duration. The number of values in the tuple implies the
  quantile mode.” [PSI:MS];
  The metric informs about the dynamic range of the acquisition along the
  chromatographic separation. The metric provides information on the sample
  (compound) flow along the chromatographic run, potentially revealing poor
  chromatographic performance, such as the absence of a signal for a
  significant portion of the run.

  The metric is calculated as follows:

  1. the `Spectra` object is ordered according to the retention time,
  2. the cumulative sum of the ion count is calculated (TIC),
  3. the quantiles are calculated according to the `probs` argument,
     e.g. when `probs` is set to `c(0, 0.25, 0.5, 0.75, 1)` the
     0%, 25%, 50%, 75%, and 100% quantile is calculated,
  4. the retention time/relative retention time (retention time divided by
     the total run time taking into account the minimum retention time) is
     calculated,
  5. the (relative) duration of the LC run after which the cumulative
     TIC exceeds (for the first time) the respective quantile of the
     cumulative TIC is calculated and returned.

## 4.2 Obtain the metrics in `data.frame`-format

The most important function to assess the data quality and to calculate the
metrics is the `calculateMetrics` function. The function takes
a `Spectra` or `MsExperiment` object as input, a character vector of metrics
to be calculated, a Boolean value to the `filterEmptySpectra` argument,
and, optionally a list of parameters passed to the quality metrics functions.

The `filterEmptySpectra` argument specifies if zero-intensity, `Inf`-intensity
or zero-length entries should be removed (`filterEmptySpectra = TRUE`).
By default, the entries are taken as they are (`filterEmptySpectra = FALSE`).
The argument can be set to `TRUE` to compute metrics that are close to the
implementation of the `QuaMeter` software. Prior to calculating the metrics,
the implementation of `QuaMeter` skips all spectra with `defaultArrayLength=0`
(in .mzML files) at any MS level.

When passing a `Spectra`/`MsExperiment` object to the function, a `data.frame`
returned by `calculateMetrics` with the metrics specified by the argument
`metrics`. By default, `qualityMetrics(object)` is taken to specify
the calculation of quality metrics. `calculateMetrics` also accepts a list
of parameters passed to the individual quality metrics functions. For
each quality metrics functions, the relevant parameters are selected based on
the accepted arguments.

Additional arguments can be given to the quality metrics functions.
For example, the function `ticQuartileToQuartileLogRatio` function has the
arguments `relativeTo`, `mode`, and `msLevel`. `relativeTo` specifies to which
quantile the log TIC quantile is relatively related to (either to the 1st
quantile or the respective previous one). `mode` (either `"TIC_change"` or
`"TIC"`) specifies if the quantiles are taken from the changes between TICs
of scan events or the TICs directly. One `Spectra`/`MsExperiment` object may
also contain more than one `msLevel`, e.g. if it also contains information on
MS\(^2\) or MS\(^3\) features. If the user adds the arguments
`relativeTo = "Q1", mode = "TIC", msLevel = c(1L, 2L))`,
`ticQuartileToQuartileLogRatio` is run with the parameter combinations
`relativeTo = "Q1", mode = "TIC", msLevel = c(1L, 2L)`.

The results based on these parameter combinations are returned and the
used parameters are returned as attributes to the returned vector.

Here, we would like to calculate the metrics of **all** included quality
metrics functions (`qualityMetrics(object)`) and additionally pass the
parameter `relativeTo = "Q1"` and `relativeTo = "previous"`. For computational
reasons, we will restrict the calculation of the metrics to the first
sample and to RPLC samples.

```
## subset the Spectra objects
sps_comb_subset <- sps_comb[grep("Sample.1_", sps_comb$dataOrigin), ]

## for RPLC and HILIC
metrics_sps_Q1 <- calculateMetrics(object = sps_comb_subset,
    metrics = qualityMetrics(sps_comb_subset), filterEmptySpectra = FALSE,
    relativeTo = "Q1", msLevel = 1L)
metrics_sps_Q1
```

```
##                chromatographyDuration ticQuantileRtFraction.0%
## Sample.1_RPLC                  18.214                        0
## Sample.1_HILIC                 16.000                        0
##                ticQuantileRtFraction.25% ticQuantileRtFraction.50%
## Sample.1_RPLC                 0.08098166                0.08098166
## Sample.1_HILIC                0.34375000                0.34375000
##                ticQuantileRtFraction.75% ticQuantileRtFraction.100%
## Sample.1_RPLC                  0.1495004                          1
## Sample.1_HILIC                 0.5375000                          1
##                rtOverMsQuarters.Quarter1 rtOverMsQuarters.Quarter2
## Sample.1_RPLC                 0.02893379                0.08806413
## Sample.1_HILIC                0.15625000                0.47500000
##                rtOverMsQuarters.Quarter3 rtOverMsQuarters.Quarter4
## Sample.1_RPLC                  0.3102009                         1
## Sample.1_HILIC                 0.6216875                         1
##                ticQuartileToQuartileLogRatio.Q2/Q1
## Sample.1_RPLC                                  NaN
## Sample.1_HILIC                                -Inf
##                ticQuartileToQuartileLogRatio.Q3/Q1
## Sample.1_RPLC                                  NaN
## Sample.1_HILIC                                 NaN
##                ticQuartileToQuartileLogRatio.Q4/Q1 numberSpectra
## Sample.1_RPLC                                  NaN           190
## Sample.1_HILIC                                 NaN           165
##                numberEmptyScans medianPrecursorMz   rtIqr rtIqrRate
## Sample.1_RPLC                 0            198.05 5.10125  18.42686
## Sample.1_HILIC                0            179.10 7.44700  11.14543
##                areaUnderTic areaUnderTicRtQuantiles.25%
## Sample.1_RPLC     655624525                  25612593.2
## Sample.1_HILIC    149945016                    927493.9
##                areaUnderTicRtQuantiles.50% areaUnderTicRtQuantiles.75%
## Sample.1_RPLC                    389734297                   233673968
## Sample.1_HILIC                   100961764                    40996727
##                areaUnderTicRtQuantiles.100% extentIdentifiedPrecursorIntensity
## Sample.1_RPLC                       5692460                          36467.884
## Sample.1_HILIC                      5460065                           8713.906
##                medianTicRtIqr medianTicOfRtRange mzAcquisitionRange.min
## Sample.1_RPLC        7496.006          13858.935                   60.1
## Sample.1_HILIC       2195.400           2086.417                   73.0
##                mzAcquisitionRange.max rtAcquisitionRange.min
## Sample.1_RPLC                  1377.6                  0.986
## Sample.1_HILIC                  784.1                  1.100
##                rtAcquisitionRange.max precursorIntensityRange.min
## Sample.1_RPLC                    19.2                    100.6492
## Sample.1_HILIC                   17.1                    100.0895
##                precursorIntensityRange.max precursorIntensityQuartiles.Q1
## Sample.1_RPLC                    349282909                      1667.3911
## Sample.1_HILIC                    92021751                       300.5038
##                precursorIntensityQuartiles.Q2 precursorIntensityQuartiles.Q3
## Sample.1_RPLC                        6746.195                       75003.90
## Sample.1_HILIC                       2304.383                       33382.25
##                precursorIntensityMean precursorIntensitySd msSignal10xChange
## Sample.1_RPLC               3450655.4             26563228                56
## Sample.1_HILIC               908757.7              7729451                47
##                ratioCharge1over2 ratioCharge3over2 ratioCharge4over2 meanCharge
## Sample.1_RPLC                NaN               NaN               NaN        NaN
## Sample.1_HILIC               NaN               NaN               NaN        NaN
##                medianCharge
## Sample.1_RPLC            NA
## Sample.1_HILIC           NA
## attr(,"chromatographyDuration")
## [1] "MS:4000053"
## attr(,"names1")
## [1] "Q1"
## attr(,"names2")
## [1] "Q2"
## attr(,"names3")
## [1] "Q3"
## attr(,"names4")
## [1] "100%"
## attr(,"names5")
## [1] "100%"
## attr(,"ticQuantileRtFraction")
## [1] "MS:4000183"
## attr(,"rtOverMsQuarters")
## [1] "MS:4000055"
## attr(,"numberSpectra")
## [1] "MS:4000059"
## attr(,"numberEmptyScans")
## [1] "MS:4000099"
## attr(,"areaUnderTic")
## [1] "MS:4000155"
## attr(,"areaUnderTicRtQuantiles")
## [1] "MS:4000156"
## attr(,"mzAcquisitionRange")
## [1] "MS:4000069"
## attr(,"rtAcquisitionRange")
## [1] "MS:4000070"
## attr(,"precursorIntensityRange")
## [1] "MS:4000160"
## attr(,"precursorIntensityQuartiles")
## [1] "MS:4000116"
## attr(,"precursorIntensityMean")
## [1] "MS:4000117"
## attr(,"precursorIntensitySd")
## [1] "MS:4000118"
## attr(,"msSignal10xChange")
## [1] "MS:4000097"
## attr(,"ratioCharge1over2")
## [1] "MS:4000167"
## attr(,"ratioCharge3over2")
## [1] "MS:4000169"
## attr(,"ratioCharge4over2")
## [1] "MS:4000171"
## attr(,"meanCharge")
## [1] "MS:4000173"
## attr(,"medianCharge")
## [1] "MS:4000175"
## attr(,"relativeTo")
## [1] "Q1"
## attr(,"msLevel")
## [1] 1
```

```
metrics_sps_previous <- calculateMetrics(object = sps_comb_subset,
    metrics = qualityMetrics(sps_comb_subset), filterEmptySpectra = FALSE,
    relativeTo = "previous", msLevel = 1L)
metrics_sps_previous
```

```
##                chromatographyDuration ticQuantileRtFraction.0%
## Sample.1_RPLC                  18.214                        0
## Sample.1_HILIC                 16.000                        0
##                ticQuantileRtFraction.25% ticQuantileRtFraction.50%
## Sample.1_RPLC                 0.08098166                0.08098166
## Sample.1_HILIC                0.34375000                0.34375000
##                ticQuantileRtFraction.75% ticQuantileRtFraction.100%
## Sample.1_RPLC                  0.1495004                          1
## Sample.1_HILIC                 0.5375000                          1
##                rtOverMsQuarters.Quarter1 rtOverMsQuarters.Quarter2
## Sample.1_RPLC                 0.02893379                0.08806413
## Sample.1_HILIC                0.15625000                0.47500000
##                rtOverMsQuarters.Quarter3 rtOverMsQuarters.Quarter4
## Sample.1_RPLC                  0.3102009                         1
## Sample.1_HILIC                 0.6216875                         1
##                ticQuartileToQuartileLogRatio.Q2/Q1
## Sample.1_RPLC                                  NaN
## Sample.1_HILIC                                -Inf
##                ticQuartileToQuartileLogRatio.Q3/Q2
## Sample.1_RPLC                             5.831233
## Sample.1_HILIC                                 Inf
##                ticQuartileToQuartileLogRatio.Q4/Q3 numberSpectra
## Sample.1_RPLC                             8.915513           190
## Sample.1_HILIC                            8.982638           165
##                numberEmptyScans medianPrecursorMz   rtIqr rtIqrRate
## Sample.1_RPLC                 0            198.05 5.10125  18.42686
## Sample.1_HILIC                0            179.10 7.44700  11.14543
##                areaUnderTic areaUnderTicRtQuantiles.25%
## Sample.1_RPLC     655624525                  25612593.2
## Sample.1_HILIC    149945016                    927493.9
##                areaUnderTicRtQuantiles.50% areaUnderTicRtQuantiles.75%
## Sample.1_RPLC                    389734297                   233673968
## Sample.1_HILIC                   100961764                    40996727
##                areaUnderTicRtQuantiles.100% extentIdentifiedPrecursorIntensity
## Sample.1_RPLC                       5692460                          36467.884
## Sample.1_HILIC                      5460065                           8713.906
##                medianTicRtIqr medianTicOfRtRange mzAcquisitionRange.min
## Sample.1_RPLC        7496.006          13858.935                   60.1
## Sample.1_HILIC       2195.400           2086.417                   73.0
##                mzAcquisitionRange.max rtAcquisitionRange.min
## Sample.1_RPLC                  1377.6                  0.986
## Sample.1_HILIC                  784.1                  1.100
##                rtAcquisitionRange.max precursorIntensityRange.min
## Sample.1_RPLC                    19.2                    100.6492
## Sample.1_HILIC                   17.1                    100.0895
##                precursorIntensityRange.max precursorIntensityQuartiles.Q1
## Sample.1_RPLC                    349282909                      1667.3911
## Sample.1_HILIC                    92021751                       300.5038
##                precursorIntensityQuartiles.Q2 precursorIntensityQuartiles.Q3
## Sample.1_RPLC                        6746.195                       75003.90
## Sample.1_HILIC                       2304.383                       33382.25
##                precursorIntensityMean precursorIntensitySd msSignal10xChange
## Sample.1_RPLC               3450655.4             26563228                56
## Sample.1_HILIC               908757.7              7729451                47
##                ratioCharge1over2 ratioCharge3over2 ratioCharge4over2 meanCharge
## Sample.1_RPLC                NaN               NaN               NaN        NaN
## Sample.1_HILIC               NaN               NaN               NaN        NaN
##                medianCharge
## Sample.1_RPLC            NA
## Sample.1_HILIC           NA
## attr(,"chromatographyDuration")
## [1] "MS:4000053"
## attr(,"names1")
## [1] "Q1"
## attr(,"names2")
## [1] "Q2"
## attr(,"names3")
## [1] "Q3"
## attr(,"names4")
## [1] "100%"
## attr(,"names5")
## [1] "100%"
## attr(,"ticQuantileRtFraction")
## [1] "MS:4000183"
## attr(,"rtOverMsQuarters")
## [1] "MS:4000055"
## attr(,"ticQuartileToQuartileLogRatio")
## [1] "MS:4000057"
## attr(,"numberSpectra")
## [1] "MS:4000059"
## attr(,"numberEmptyScans")
## [1] "MS:4000099"
## attr(,"areaUnderTic")
## [1] "MS:4000155"
## attr(,"areaUnderTicRtQuantiles")
## [1] "MS:4000156"
## attr(,"mzAcquisitionRange")
## [1] "MS:4000069"
## attr(,"rtAcquisitionRange")
## [1] "MS:4000070"
## attr(,"precursorIntensityRange")
## [1] "MS:4000160"
## attr(,"precursorIntensityQuartiles")
## [1] "MS:4000116"
## attr(,"precursorIntensityMean")
## [1] "MS:4000117"
## attr(,"precursorIntensitySd")
## [1] "MS:4000118"
## attr(,"msSignal10xChange")
## [1] "MS:4000097"
## attr(,"ratioCharge1over2")
## [1] "MS:4000167"
## attr(,"ratioCharge3over2")
## [1] "MS:4000169"
## attr(,"ratioCharge4over2")
## [1] "MS:4000171"
## attr(,"meanCharge")
## [1] "MS:4000173"
## attr(,"medianCharge")
## [1] "MS:4000175"
## attr(,"relativeTo")
## [1] "previous"
## attr(,"msLevel")
## [1] 1
```

Alternatively, an `MsExperiment` object might be passed to
`calculateMetrics`. The function will iterate over the samples (referring
to rows in `sampleData(msexp))`) and calculate the quality metrics on the
corresponding `Spectra`s.

## 4.3 Obtain the metrics in `mzQC`-format

By default, a `data.frame` object containing the metric values as entries
are returned by the the function `calculateMetrics`. Alternatively, the
function also allows the user to export the metrics in a format defined by
the `rmzqc` package by setting the argument `format` to `"mzQC"` (default:
`format = "data.frame"`). In that case, only the metrics that comply to the
`mzQC` specification will be written to the returned object.
The object can be exported and validated using the functionality of the `rmzqc`
package (see the documentation of `rmzqc` for further information).

## 4.4 Remove empty spectra prior to the calculation

There are in total 541 samples
respectively in the objects `msexp_rplc` and `msexp_hilic`. To improve
the visualization and interpretability, we will only calculate the metrics
from the first 20 of these samples.

In this example here, we will remove zero-length and zero-intensity entries
prior to calculating the metrics. To do this, we set the `filterEmptySpectra`
argument to `TRUE` within the `calculateMetrics` function.

```
## subset the MsExperiment objects
msexp_rplc_subset <- msexp_rplc[1:20]
msexp_hilic_subset <- msexp_hilic[1:20]

## define metrics
metrics_sps <- c("chromatographyDuration", "ticQuantileRtFraction", "rtOverMsQuarters",
    "ticQuartileToQuartileLogRatio", "numberSpectra", "medianPrecursorMz",
    "rtIqr", "rtIqrRate", "areaUnderTic")

## for RPLC-derived MsExperiment
metrics_rplc_msexp <- calculateMetrics(object = msexp_rplc_subset,
    metrics = qualityMetrics(msexp_rplc_subset), filterEmptySpectra = TRUE,
    relativeTo = "Q1", msLevel = 1L)

## for HILIC-derived MsExperiment
metrics_hilic_msexp <- calculateMetrics(object = msexp_hilic_subset,
    metrics = qualityMetrics(msexp_hilic_subset), filterEmptySpectra = TRUE,
    relativeTo = "Q1", msLevel = 1L)
```

When passing an `MsExperiment` object to `calculateMetrics` a `data.frame`
object is returned with the samples (derived from the rownames of
`sampleData(msexp)`) in the rows and the metrics in columns.

We will show here the objects `metrics_rplc_msexp` and `metrics_hilic_msexp`

```
## [1] "metrics_rplc_msexp"
```

```
## [1] "metrics_hilic_msexp"
```

# 5 Visualizing the results

The quality metrics can be most easily compared when graphically visualized.

The `MsQuality` package offers the possibility to graphically display the
metrics using the `plotMetric` and `shinyMsQuality` functions. The
`plotMetric` function will create one plot based on a single metric.
`shinyMsQuality`, on the other hand, opens a shiny application that allows
to browse through all the metrics stored in the object.

As a way of example, we will plot here the number of features. A high number
of missing features might indicate low data quality, however, also different
sample types might exhibit contrasting number of detected features.
As a general rule, only samples of the same type should be compared to
adjust for sample type-specific effects.

```
metrics_msexp <- rbind(metrics_rplc_msexp, metrics_hilic_msexp)
plotMetric(qc = metrics_msexp, metric = "numberSpectra")
```

Similarly, we are able to display the area under the TIC for the retention
time quantiles. This plot gives information on the perceived signal (TIC) for
the differnt retention time quantiles and could indicate drifts or
interruptions of sensitivity during the run.

```
plotMetric(qc = metrics_msexp, metric = "ticQuartileToQuartileLogRatio")
```

Alternatively, to browse through all metrics that were calculated in an
interactive way, we can use the `shinyMsQuality` function.

```
shinyMsQuality(qc = metrics_msexp)
```

# Appendix

## Session information

All software and respective versions to build this vignette are listed here:

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
##  [1] MsExperiment_1.12.0 ProtGenerics_1.42.0 Spectra_1.20.0
##  [4] BiocParallel_1.44.0 S4Vectors_0.48.0    BiocGenerics_0.56.0
##  [7] generics_0.1.4      MsQuality_1.10.0    knitr_1.50
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   testthat_3.2.3
##  [3] rlang_1.1.6                 magrittr_2.0.4
##  [5] shinydashboard_0.7.3        clue_0.3-66
##  [7] otel_0.2.0                  matrixStats_1.5.0
##  [9] compiler_4.5.1              vctrs_0.6.5
## [11] reshape2_1.4.4              stringr_1.5.2
## [13] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
## [15] fastmap_1.2.0               XVector_0.50.0
## [17] labeling_0.4.3              promises_1.4.0
## [19] rmarkdown_2.30              purrr_1.1.0
## [21] xfun_0.53                   MultiAssayExperiment_1.36.0
## [23] cachem_1.1.0                jsonlite_2.0.0
## [25] later_1.4.4                 DelayedArray_0.36.0
## [27] parallel_4.5.1              cluster_2.1.8.1
## [29] R6_2.6.1                    bslib_0.9.0
## [31] stringi_1.8.7               RColorBrewer_1.1-3
## [33] brio_1.1.5                  GenomicRanges_1.62.0
## [35] jquerylib_0.1.4             Rcpp_1.1.0
## [37] Seqinfo_1.0.0               bookdown_0.45
## [39] SummarizedExperiment_1.40.0 IRanges_2.44.0
## [41] BiocBaseUtils_1.12.0        httpuv_1.6.16
## [43] Matrix_1.7-4                igraph_2.2.1
## [45] tidyselect_1.2.1            dichromat_2.0-0.1
## [47] abind_1.4-8                 yaml_2.3.10
## [49] codetools_0.2-20            curl_7.0.0
## [51] lattice_0.22-7              tibble_3.3.0
## [53] plyr_1.8.9                  Biobase_2.70.0
## [55] shiny_1.11.1                withr_3.0.2
## [57] S7_0.2.0                    evaluate_1.0.5
## [59] ontologyIndex_2.12          pillar_1.11.1
## [61] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [63] plotly_4.11.0               ggplot2_4.0.0
## [65] scales_1.4.0                R6P_0.4.0
## [67] xtable_1.8-4                glue_1.8.0
## [69] lazyeval_0.2.2              tools_4.5.1
## [71] data.table_1.17.8           QFeatures_1.20.0
## [73] fs_1.6.6                    grid_4.5.1
## [75] jsonvalidate_1.5.0          tidyr_1.3.1
## [77] crosstalk_1.2.2             MsCoreUtils_1.22.0
## [79] msdata_0.49.0               cli_3.6.5
## [81] S4Arrays_1.10.0             viridisLite_0.4.2
## [83] dplyr_1.1.4                 AnnotationFilter_1.34.0
## [85] gtable_0.3.6                sass_0.4.10
## [87] digest_0.6.37               SparseArray_1.10.0
## [89] htmlwidgets_1.6.4           farver_2.1.2
## [91] htmltools_0.5.8.1           lifecycle_1.0.4
## [93] httr_1.4.7                  mime_0.13
## [95] rmzqc_0.7.0                 MASS_7.3-65
```

## References

Lee, H.-J., D. M. Kremer, P. Sajjakulnukit, L. Zhang, and C. A. Lyssiotis. 2019. “A Large-Scale Analysis of Targeted Metabolomics Data from Heterogeneous Biological Samples Provides Insights into Metabolite Dynamics.” *Metabolomics*, 103. <https://doi.org/10.1007/s11306-019-1564-8>.