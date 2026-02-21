# Description and usage of MobilityTransformR

Liesa Salzer1\*

1Analytical BioGeoChemistry, Helmholtz Zentrum München

\*liesa.salzer@helmholtz-munich.de

#### 1 November 2022

#### Package

MobilityTransformR 1.2.0

# 1 Introduction

Capillary elecrophoresis coupled to mass spectrometry (CE-MS) in fields as
proteomics or metabolomics is less common than for example liquid
chromatography-mass spectrometry (LC-MS). A reason might be less reproducible
migration times (MT) compared to retention times (RT) because of fluctuations
in the Electroosmotic flow (EOF).

However, the effective mobility \(µ\_{eff}\) of a compound remains stable in the
same electrophoretic system. The use of an effective mobility scale instead
of a migration time scale circumvents the drawback of MT shifts and will
result in highly reproducible peaks, which has already been shown in 2001
[1].

Effective mobility transformation for CE-MS data is not as straightforward as
in CE-UV and until now and to our knowledge there is no implementation in R
that performs effective mobility transformation of CE-MS(/MS) data.

As a model for the `MobilityTransformR` package, we have taken
the recently developed open-source ROMANCE software [2], which
transforms the MT scale of CE-MS data into an \(µ\_{eff}\) scale. However,
the outputs are two separate files, each for positive and negative
mobilities.
We developed the `MobilityTransformR` package to perform mobility
transformation of CE-MS/MS data in the R environment. Also, different
to ROMANCE, the output will be a single file containing both, the positive
and negative effective mobilities.

The transformation is performed using functionality from the packages
*[MetaboCoreUtils](https://bioconductor.org/packages/3.16/MetaboCoreUtils)*, *[xcms](https://bioconductor.org/packages/3.16/xcms)*,
*[MSnbase](https://bioconductor.org/packages/3.16/MSnbase)*, and *[Spectra](https://bioconductor.org/packages/3.16/Spectra)*.
The transformed data can be exported as `.mzML` file and can be further
analyzed in R or other software.

The CE-MS test data are from the *[msdata](https://bioconductor.org/packages/3.16/msdata)* package.

# 2 Setup

## 2.1 Installation

The `MobilityTransformR` package can be installed as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("MobilityTransformR")
```

To show the different functionality of `MobilityTransformR`, we
need also to load the packages `xcms` and `Spectra`.
If you have not installed them yet, type

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("xcms")
BiocManager::install("Spectra")
```

into the Console.

## 2.2 Load required libries

`MobilityTransformR` integrates functions from different
libraries.

```
# load required libraries
library(MobilityTransformR)
library(xcms)
library(Spectra)
```

## 2.3 Load test data

To showcase the functionality of the `MobilityTransformR`
package two CE-MS test sets containing a mixtures of different metabolites
at a concentration of 10 ppm and 25 ppm precisely, acquired at positive
CE polarity and positive ionization mode is used and imported from the
`msdata`package.
Paracetamol was added to the analysis as EOF marker in a final
concentration of 50 ppm to the sample. Procaine was added as
positively charged, secondary marker at a
final concentration of 10 ppm.
The markers are required for the later effective mobility transformation
process.
The test data is loaded using the `readMSData()` function from
`MSnbase`.

```
fl <- dir(system.file("CE-MS", package = "msdata"),
          full.names = TRUE)

# Load mzXML data with MSnBase
raw_data <- readMSData(files = fl, mode = "onDisk")
```

# 3 Get Marker Migration Times

In order to perform the effective mobility transformation, first the
migration times (MTs) of the markers needs to be determined. If multiple
files are used, the MT of the markers in each file must be determined since
they will vary based on EOF fluctuations.

The `getMtime()` function requires an `OnDiskMSnExp` object,`raw_data`, as
input and uses an mz-range `mz` and MT-range `mt` to generate an Extracted
Ion Electropherogram (EIE). The MT of the peak will be determined by
`findChromPeaks` from
`xcms`.
It is very important to define the `mz`-range and
`mt`-range as narrow as possible to ensure that the right peak will
be picked. The mz-tolerance defining the `mz`-range depends on the
mass accuracy of the mass spectrometer that was used to acquire the data.

## 3.1 Get MT of EOF Marker Paracetamol

In order to check the right `mz`-, and `mt`-window for the exact MT
determination, we use the`plot(chromatogram())` function to plot the
respective EIE.

Note that the plot functions are adapted from LC-MS package `MSnbase`,
which has “retention time” as default x-axis label.

```
# mz tolerance depends on MS mass accuracy
tolerance <- 0.005

# [M+H]+ of paracetamol: mz = 152.071154
mz_paracetamol <- c(152.071154 - tolerance, 152.071154 + tolerance)
mt_paracetamol <- c(600, 900)

marker_EIE <- raw_data |>
    filterMz(mz = mz_paracetamol) |>
    filterRt(rt = mt_paracetamol)

plot(chromatogram(marker_EIE),
    main = "Paracetamol EIE",
    xlab = "migration time (sec)"
)
```

![](data:image/png;base64...)

```
# adjust mz and MT windows if necessary
```

Use the adapted values to get the exact MT of Paracetamol.
If several files will be used it is important to select a `mt`-range
wide enough to get the right Paracetamol-peaks in all files, because single
migration times might change significantly due to EOF-fluctuations between
measurements.

```
# get the MT of paracetamol
paracetamol <- getMtime(raw_data,
    mz = mz_paracetamol,
    mt = mt_paracetamol
)
paracetamol
```

```
##     rtime fileIdx
## 1 840.796       1
## 2 848.640       2
```

## 3.2 MT of Secondary Marker Procaine

Effective mobilities can be already calculated using the EOF marker
Paracetamol. However, it is also possible to calculate the mobility using a
secondary marker. This might be of interest for example when the peak
shape of the main marker is not sufficient or ambiguity detection.

In order to show how we can use a secondary marker to convert the data, we
create in the next step a data.frame containing the MT and file information
from another, secondary marker called Procaine.

```
procaine <- data.frame(
    "rtime" = c(450.239, 465.711),
    "fileIdx" = c(1, 2)
)
```

# 4 Effective mobility scale transformation

`mobilityTransform` uses different functions to perform the effective
mobility transformation depending on the input type. It is possible to
convert `numeric`, `Spectra`, and `OnDiskMSnExp`.
Here, we show how each input-class can be transformed.

## 4.1 Effective mobility transformation of single migration times

Effective mobility scale transformation is performed either using a single or
two mobility markers. Functions were adapted from González-Ruiz et al.
[2] .
The standard equation to calculate effective mobility \(µ\_{eff}\) is

\[\begin{equation}
µ\_{eff} = \frac{l}{E} (\frac{1}{t\_M - (t\_R/2)} -
\frac{1}{t\_{EOF} - (t\_R/2)})
\tag{1}
\end{equation}\]

with \(t\_M\) the migration time that is transformed, \(t\_{EOF}\) the MT of the
EOF marker and optional \(t\_R\) which is the time of the electrical field ramp.

If the peak shape of the EOF marker is bad or it cannot be detected for other
reasons, the effective mobility might also be calculated using a secondary
mobility marker with known mobility:

\[\begin{equation}
µ\_{eff} = µ\_A + \frac{l}{E} (\frac{1}{t\_M - (t\_R/2)} -
\frac{1}{t\_A - (t\_R/2)})
\tag{2}
\end{equation}\]
with \(t\_A\), the MT of the secondary marker and its corresponding mobility
\(µ\_A\).

Last, the mobility might be calculated using both markers. Therefore, there
is no need to know the applied electrical field nor the exact capillary
length.

\[\begin{equation}
µ\_{eff} = µ\_A \frac{t\_M - t\_{EOF}}{t\_A - t\_{EOF}} \*
\frac{t\_A - (t\_R/2)}{t\_M - (t\_R/2)}
\tag{3}
\end{equation}\]

## 4.2 Calculation of the Secondary Marker Mobility \(µ\_A\)

First, a `data.frame` is created that stores the marker information,
that will be used to transform the data. Either one or two markers can be
used for the transformation. The `data.frame` needs at least the columns
`rtime` and `mobility`. Additional columns to store marker
information might be added as well.
Here, we start with the neutral EOF marker Paracetamol, having the effective
mobility of 0 \(\frac{mm^2}{kV\*min}\).

```
# Create a data.frame that stores marker information
marker <- paracetamol
marker$markerID <- "Paracetamol"
marker$mobility <- 0
```

Then the effective mobility of the secondary mobility marker Procaine, as
single migration time, is determined according to eq. [(1)](#eq:mobility1).
The transformation is performed using the marker information from
Paracetamol.
Moreover, if only a single marker is provided for the transformation, also
the applied voltage `U` in kV, and the total and effective capillary
length `L` in mm is needed.
Additionally the field ramping time `tR` (in min) can be included for
corrections.

```
procaineMobility <- mobilityTransform(
    x = procaine[1, 1], marker = marker[1, ],
    tR = 3 / 60, U = +30, L = 800
)
procaineMobility
```

```
## [1] 1327.35
```

Note: The unit of the mobility is \(\frac{mm^2}{kV\*min}\)

## 4.3 Effective mobility transformation of whole CE-MS runs

`mobilityTransform` can also be applied to whole CE-MS runs stored
either as `Spectra`-object or `OnDiskMSnExp`-object.
As shown as before, either a single or two markers can be used for
conversion.
Here, we add the marker information of Procaine to the marker
`data.frame`, so the transformation will be done on both markers
according to eq. [(3)](#eq:mobility3).

```
procaine$markerID <- "Procaine"
procaine$mobility <- procaineMobility
marker <- rbind(marker, procaine)
```

### 4.3.1 Effective mobility transformation of OnDiskMSnExp objects

The migration time scale of `raw_data2` is transformed, returning the
same class.

```
# Conversion of mt in OnDiskMSnExp objects
mobility_data <- mobilityTransform(x = raw_data, marker = marker)

# OnDiskMSnExp can by exported by writeMSData, Note that it is important to
# set copy = FALSE, (otherwise spectrum ordering will be wrong)
fl_mobility_data <- tempfile()
writeMSData(filterFile(mobility_data, 1),
    file = fl_mobility_data, copy = FALSE
)
```

### 4.3.2 Effective mobility transformation of Spectra objects

`Spectra`-objects can be transformed similarly in
`mobilityTransform`.
The resulting `Spectra`-objects can then also be exported as
`.mzML` for further processing in different software.

```
# load the test data as spectra object
spectra_data <- Spectra(fl[1], backend = MsBackendMzR())

spectra_mobility <- mobilityTransform(
    spectra_data,
    marker[marker$fileIdx == 1, ]
)

# Transformed data can then be exported again as .mzML file to use in xcms or
# other software
fl_mobility <- tempfile()
export(spectra_mobility, MsBackendMzR(), file = fl_mobility)
```

# 5 Inspect and Analyze the Transformed Data

The transformed data can displayed and further analyzed with e.g.
`xcms`. Note that the effective mobility can be accessed by e.g.
`spectra_mobility$rtime`, since functions where adapted from LC-MS
based `rformassspectrometry` functions.
The resulting unit of the effective mobility is \(\frac{mm^2}{kV\*min}\).

Here, we inspect them with the `plot(chromatogram())` function from
`xcms`.

As described before, the test data contain different metabolites in 10 ppm
and 25 ppm final concentration, acquired in positive ionization mode. We can
check the effective mobilities of single compounds by extracting their EIE as
for example Lysine (mz = 147.112806).

```
# Example: Extract ion electropherogram (EIE) from lysine
mz_lysine <- c(147.112806 - tolerance, 147.112806 + tolerance)
mobilityRestriction <- c(1000, 2500)

# Extract ion electropherogram of compound
lysine_EIE <- mobility_data |>
    filterMz(mz = mz_lysine) |>
    filterRt(rt = mobilityRestriction)

plot(chromatogram(lysine_EIE),
    main = expression(paste("Lysine EIE - µ"[eff], " scale")),
    xlab = expression(paste("µ"[eff], "  (", frac("mm"^2, "kV min"), ")"))
)
```

![](data:image/png;base64...)

```
# compare with extracted ion electropherogram of migration time scale
lysine_mt_EIE <- raw_data |>
    filterMz(mz = mz_lysine) |>
    filterRt(c(400, 600))

plot(chromatogram(lysine_mt_EIE),
    main = "Lysine EIE - MT scale",
    xlab = "MT (sec)"
)
```

![](data:image/png;base64...)

# 6 Session information

```
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] Spectra_1.8.0            xcms_3.20.0              BiocParallel_1.32.0
##  [4] MobilityTransformR_1.2.0 MSnbase_2.24.0           ProtGenerics_1.30.0
##  [7] S4Vectors_0.36.0         mzR_2.32.0               Rcpp_1.0.9
## [10] Biobase_2.58.0           BiocGenerics_0.44.0      BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-7                matrixStats_0.62.0
##  [3] fs_1.5.2                    doParallel_1.0.17
##  [5] RColorBrewer_1.1-3          GenomeInfoDb_1.34.0
##  [7] tools_4.2.1                 bslib_0.4.0
##  [9] utf8_1.2.2                  R6_2.5.1
## [11] affyio_1.68.0               DBI_1.1.3
## [13] colorspace_2.0-3            tidyselect_1.2.0
## [15] MassSpecWavelet_1.64.0      compiler_4.2.1
## [17] preprocessCore_1.60.0       cli_3.4.1
## [19] DelayedArray_0.24.0         bookdown_0.29
## [21] sass_0.4.2                  scales_1.2.1
## [23] DEoptimR_1.0-11             robustbase_0.95-0
## [25] affy_1.76.0                 stringr_1.4.1
## [27] digest_0.6.30               rmarkdown_2.17
## [29] XVector_0.38.0              pkgconfig_2.0.3
## [31] htmltools_0.5.3             MetaboCoreUtils_1.6.0
## [33] MatrixGenerics_1.10.0       highr_0.9
## [35] fastmap_1.1.0               limma_3.54.0
## [37] rlang_1.0.6                 impute_1.72.0
## [39] jquerylib_0.1.4             generics_0.1.3
## [41] jsonlite_1.8.3              mzID_1.36.0
## [43] dplyr_1.0.10                RCurl_1.98-1.9
## [45] magrittr_2.0.3              GenomeInfoDbData_1.2.9
## [47] Matrix_1.5-1                MALDIquant_1.21
## [49] munsell_0.5.0               fansi_1.0.3
## [51] MsCoreUtils_1.10.0          lifecycle_1.0.3
## [53] vsn_3.66.0                  stringi_1.7.8
## [55] yaml_2.3.6                  MASS_7.3-58.1
## [57] SummarizedExperiment_1.28.0 zlibbioc_1.44.0
## [59] plyr_1.8.7                  grid_4.2.1
## [61] parallel_4.2.1              lattice_0.20-45
## [63] MsFeatures_1.6.0            magick_2.7.3
## [65] knitr_1.40                  pillar_1.8.1
## [67] GenomicRanges_1.50.0        codetools_0.2-18
## [69] XML_3.99-0.12               glue_1.6.2
## [71] evaluate_0.17               pcaMethods_1.90.0
## [73] BiocManager_1.30.19         vctrs_0.5.0
## [75] foreach_1.5.2               RANN_2.6.1
## [77] gtable_0.3.1                clue_0.3-62
## [79] assertthat_0.2.1            cachem_1.0.6
## [81] ggplot2_3.3.6               xfun_0.34
## [83] ncdf4_1.19                  tibble_3.1.8
## [85] iterators_1.0.14            IRanges_2.32.0
## [87] cluster_2.1.4
```

# References

1. Schmitt-Kopplin P, Garmash AV, Kudryavtsev AV, Menzinger F, Perminova IV, Hertkorn N, Freitag D, Petrosyan VS, Kettrup A: **Quantitative and qualitative precision improvements by effective mobility-scale data transformation in capillary electrophoresis analysis**. *ELECTROPHORESIS* 2001, **22**:77–87.

2. González-Ruiz V, Gagnebin Y, Drouin N, Codesido S, Rudaz S, Schappler J: **ROMANCE: A new software tool to improve data robustness and feature identification in ce-ms metabolomics**. *ELECTROPHORESIS* 2018, **39**:1222–1232.