# Getting Started with the peakPantheR package

#### 2020-10-11

#### Package

peakPantheR 1.24.0

**Package**: *[peakPantheR](https://bioconductor.org/packages/3.22/peakPantheR)*
**Authors**: Arnaud Wolfer

Package for *Peak Picking and ANnoTation of High resolution Experiments in R*,
implemented in `R` and `Shiny`

# 1 Overview

`peakPantheR` implements functions to detect, integrate and report pre-defined
features in MS files (*e.g. compounds, fragments, adducts, …*).

It is designed for:

* **Real time** feature detection and integration (see
  [Real Time Annotation](real-time-annotation.html))
  + process `multiple` compounds in `one` file at a time
* **Post-acquisition** feature detection, integration and reporting (see
  [Parallel Annotation](parallel-annotation.html))
  + process `multiple` compounds in `multiple` files in `parallel`, store
    results in a `single` object

`peakPantheR` can process LC/MS data files in *NetCDF*, *mzML*/*mzXML* and
*mzData* format as data import is achieved using Bioconductor’s
*[mzR](https://bioconductor.org/packages/3.22/mzR)* package.

# 2 Installation

To install `peakPantheR` from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("peakPantheR")
```

Install the development version of `peakPantheR` directly from GitHub with:

```
# Install devtools
if(!require("devtools")) install.packages("devtools")
devtools::install_github("phenomecentre/peakPantheR")
```

## 2.1 Getting Started

To get started `peakPantheR`’s [graphical user interface](peakPantheR-GUI.html)
implements all the functions to detect and integrate **multiple** compounds in
**multiple** files in **parallel** and store results in a **single** object. It
can be employed to integrate a large number of expected features across a
dataset:

```
library(peakPantheR)

peakPantheR_start_GUI(browser = TRUE)
#  To exit press ESC in the command line
```

![](data:image/png;base64...)

The GUI is to be preferred to understand the methodology, select the best
parameters on a subset of the samples before running the command line, or to
visually explore results.

If a very high number of samples and features is to be processed,
`peakpantheR`’s command line functions are more efficient, as they can
be integrated in scripts and the reporting automated.

# 3 Input Data

Both real time and parallel compound integration require a common set of
information:

* Path(s) to `netCDF` / `mzML` MS file(s)
* An expected region of interest (`RT` / `m/z` window) for each compound.

## 3.1 MS files

For demonstration purpose we can annotate a set a set of raw MS spectra (in
*NetCDF* format) provided by the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* package. Briefly, this
subset of the data from (Saghatelian et al. [2004](#ref-Saghatelian04)) invesigate the metabolic consequences
of knocking out the fatty acid amide hydrolase (FAAH) gene in mice. The dataset
consists of samples from the spinal cords of 6 knock-out and 6 wild-type mice.
Each file contains data in centroid mode acquired in positive ion mode form
200-600 m/z and 2500-4500 seconds.

Below we install the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* package and locate raw CDF files of
interest:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("faahKO")
```

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

## 3.2 Expected regions of interest

Expected regions of interest (targeted features) are specified using the
following information:

* `cpdID` (character)
* `cpdName` (character)
* `rtMin` (sec)
* `rtMax` (sec)
* `rt` (sec, optional / `NA`)
* `mzMin` (m/z)
* `mzMax` (m/z)
* `mz` (m/z, optional / `NA`)

Below we define 2 features of interest that are present in the
*[faahKO](https://bioconductor.org/packages/3.22/faahKO)* dataset and can be employed in subsequent vignettes:

```
# targetFeatTable
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390., 522.194778,
                                522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440., 496.195038,
                                496.2, 496.204962)
input_targetFeatTable[,c(1,3:8)] <- sapply(input_targetFeatTable[,c(1,3:8)],
                                            as.numeric)
```

```
#> Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
```

| cpdID | cpdName | rtMin | rt | rtMax | mzMin | mz | mzMax |
| --- | --- | --- | --- | --- | --- | --- | --- |
| NA | Cpd 1 | 3310 | 3344.888 | 3390 | 522.194778 | 522.2 | 522.205222 |
| NA | Cpd 2 | 3280 | 3385.577 | 3440 | 496.195038 | 496.2 | 496.204962 |

# 4 Preparing input for the graphical user interface

While the command line functions accept Data.Frame and vectors as input, the
graphical user interface (GUI) will read the same information from a set of
`.csv` files, or an already set-up `peakPantheRAnnotation` object in `.RData`
format.

We can now generate GUI input files for the *[faahKO](https://bioconductor.org/packages/3.22/faahKO)* example
dataset presented previously:

## 4.1 *peakPantheRAnnotation* .RData

A `peakPantheRAnnotation` (previously annotated or not) can be passed as input
in a `.RData` file. The `peakPantheRAnnotation` object must be named
*annotationObject*:

```
library(faahKO)

# Define the file paths (3 samples)
input_spectraPaths  <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko18.CDF', package = "faahKO"))

# Define the targeted features (2 features)
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
                                522.194778, 522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
                                496.195038, 496.2, 496.204962)
input_targetFeatTable[,3:8] <- sapply(input_targetFeatTable[,3:8], as.numeric)

# Define some random compound and spectra metadata
# cpdMetadata
input_cpdMetadata     <- data.frame(matrix(data=c('a','b',1,2), nrow=2, ncol=2,
                            dimnames=list(c(), c('testcol1','testcol2')),
                            byrow=FALSE), stringsAsFactors=FALSE)
# spectraMetadata
input_spectraMetadata <- data.frame(matrix(data=c('c','d','e',3,4,5), nrow=3,
                            ncol=2,
                            dimnames=list(c(),c('testcol1','testcol2')),
                            byrow=FALSE), stringsAsFactors=FALSE)

# Initialise a simple peakPantheRAnnotation object
# [3 files, 2 features, no uROI, no FIR]
initAnnotation <- peakPantheRAnnotation(spectraPaths=input_spectraPaths,
                                        targetFeatTable=input_targetFeatTable,
                                        cpdMetadata=input_cpdMetadata,
                                        spectraMetadata=input_spectraMetadata)

# Rename and save the annotation to disk
annotationObject <- initAnnotation
save(annotationObject,
        file = './example_annotation_ppR_UI.RData',
        compress=TRUE)
```

## 4.2 CSV file input

Another input option for the GUI input consists of a set of `.csv` files.

### 4.2.1 Targeted features

Targeted features are defined in a `.csv` with as rows each feature to target
(the first row must be the column name), and as columns the fit parameters to
use. At minimum the following parameters must be defined:

`cpdID`, `cpdName`, `rtMin`, `rt`, `rtMax`, `mzMin`, `mz`, `mzMax`

If `uROI` and `FIR` are to be set, the following columns must be provided:

`cpdID`, `cpdName`, `ROI_rt`, `ROI_mz`, `ROI_rtMin`, `ROI_rtMax`, `ROI_mzMin`,
`ROI_mzMax`, `uROI_rtMin`, `uROI_rtMax`, `uROI_mzMin`, `uROI_mzMax`, `uROI_rt`,
`uROI_mz`, `FIR_rtMin`, `FIR_rtMax`, `FIR_mzMin`, `FIR_mzMax`

```
# Define targeted features without uROI and FIR (2 features)
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
                                522.194778, 522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
                                496.195038, 496.2, 496.204962)
input_targetFeatTable[,3:8] <- sapply(input_targetFeatTable[,3:8], as.numeric)

# save to disk
write.csv(input_targetFeatTable,
            file = './1-fitParams_example_UI.csv',
            row.names = FALSE)
```

| cpdID | cpdName | rtMin | rt | rtMax | mzMin | mz | mzMax |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ID-1 | Cpd 1 | 3310 | 3344.888 | 3390 | 522.194778 | 522.2 | 522.205222 |
| ID-2 | Cpd 2 | 3280 | 3385.577 | 3440 | 496.195038 | 496.2 | 496.204962 |

### 4.2.2 Files to process and spectra metadata (optional)

It is possible to select the files on disk directly through the GUI, or to
select a `.csv` file containing each file path as well as spectra metadata.
Each row correspond to a different spectra (the first row must define the
column names) while columns correspond to the path on disk and metadata. At
minimum a column `filepath` must be present, with subsequent columns defining
metadata properties.

```
# Define the spectra paths and metada
input_spectraMeta <- data.frame(matrix(vector(), 3, 3,
                        dimnames=list(c(),c("filepath","testcol1","testcol2"))),
                        stringsAsFactors=FALSE)
input_spectraMeta[1,] <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                            "c", 3)
input_spectraMeta[2,] <- c(system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                            "d", 4)
input_spectraMeta[3,] <- c(system.file('cdf/KO/ko18.CDF', package = "faahKO"),
                            "e", 5)

# save to disk
write.csv(input_spectraMeta,
            file = './2-spectraMetaWPath_example_UI.csv',
            row.names = FALSE)
```

Table continues below

| filepath | testcol1 |
| --- | --- |
| /home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko15.CDF | c |
| /home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko16.CDF | d |
| /home/biocbuild/bbs-3.22-bioc/R/site-library/faahKO/cdf/KO/ko18.CDF | e |

| testcol2 |
| --- |
| 3 |
| 4 |
| 5 |

### 4.2.3 Feature meatadata (optional)

It is possible to define some feature metadata, with targeted features as
rows (same order as the fitting parameters, first row defining the column
names), and as columns the metadata.

```
# Define the feature metada
input_featMeta <- data.frame(matrix(vector(), 2, 2,
                    dimnames=list(c(),c("testcol1","testcol2"))),
                    stringsAsFactors=FALSE)
input_featMeta[1,] <- c("a", 1)
input_featMeta[2,] <- c("b", 2)

# save to disk
write.csv(input_featMeta,
            file = './3-featMeta_example_UI.csv',
            row.names = FALSE)
```

| testcol1 | testcol2 |
| --- | --- |
| a | 1 |
| b | 2 |

# 5 See Also

* [Real Time Annotation](real-time-annotation.html)
* [Parallel Annotation](parallel-annotation.html)
* [Graphical user interface use](peakPantheR-GUI.html)

# 6 Session Information

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
#>  Biobase                2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocBaseUtils          1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics           0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
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
#>  doParallel             1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2     2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  faahKO               * 1.49.1    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  generics               0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
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
#>  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
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
#>  MsCoreUtils            1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsExperiment           1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MsFeatures             1.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MSnbase                2.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  MultiAssayExperiment   1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzID                   1.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  mzR                    2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
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
#>  preprocessCore         1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress               1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  promises               1.4.0     2025-10-22 [2] CRAN (R 4.5.1)
#>  ProtGenerics           1.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  PSMatch                1.14.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  QFeatures              1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0     2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors              0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
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
#>  usethis                3.2.1     2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vsn                    3.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
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

# References

Saghatelian, A., S. A. Trauger, E. J. Want, E. G. Hawkins, G. Siuzdak, and B. F. Cravatt. 2004. “Assignment of Endogenous Substrates to Enzymes by Global Metabolite Profiling.” *Biochemistry* 43: 14332–9. <http://dx.doi.org/10.1021/bi0480335>.