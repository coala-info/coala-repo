# PoDCall: Positive Droplet Caller for DNA Methylation ddPCR

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Gaussian Mixture Models](#gaussian-mixture-models)
  + [1.2 Input Data](#input-data)
* [2 Installation](#installation)
* [3 Example / Usage](#example-usage)
  + [3.1 Optional arguments](#optional-arguments)
    - [3.1.1 sampleSheetFile](#samplesheetfile)
    - [3.1.2 B](#b)
    - [3.1.3 Q](#q)
    - [3.1.4 refwell](#refwell)
    - [3.1.5 nrChannels](#nrchannels)
    - [3.1.6 targetChannel](#targetchannel)
    - [3.1.7 controlChannel](#controlchannel)
    - [3.1.8 software](#software)
    - [3.1.9 resultsToFile](#resultstofile)
    - [3.1.10 plots](#plots)
    - [3.1.11 resPath](#respath)
  + [3.2 Threshold table columns](#threshold-table-columns)
    - [3.2.1 sample\_id](#sample_id)
    - [3.2.2 thr\_target](#thr_target)
    - [3.2.3 thr\_ctrl](#thr_ctrl)
    - [3.2.4 pos\_dr\_target](#pos_dr_target)
    - [3.2.5 pos\_dr\_ctrl](#pos_dr_ctrl)
    - [3.2.6 tot\_droplets](#tot_droplets)
    - [3.2.7 c\_target](#c_target)
    - [3.2.8 c\_ctrl](#c_ctrl)
    - [3.2.9 c\_norm\_4Plex](#c_norm_4plex)
    - [3.2.10 c\_norm\_sg](#c_norm_sg)
    - [3.2.11 q](#q-1)
    - [3.2.12 target\_assay](#target_assay)
    - [3.2.13 ctrl\_assay](#ctrl_assay)
    - [3.2.14 ref\_well](#ref_well)
* [4 PoDCall functions](#podcall-functions)
  + [4.1 `importAmplitudeData()`](#importamplitudedata)
  + [4.2 `importSampleSheet()`](#importsamplesheet)
  + [4.3 `podcallThresholds()`](#podcallthresholds)
  + [4.4 `podcallChannelPlot()`](#podcallchannelplot)
  + [4.5 `podcallScatterplot()`](#podcallscatterplot)
  + [4.6 `podcallHistogram()`](#podcallhistogram)
  + [4.7 `podcallMultiplot()`](#podcallmultiplot)
* [5 PoDCall shiny application](#podcall-shiny-application)
* [6 PodCall example data](#podcall-example-data)
  + [6.1 Cell Line Amplitude Data](#cell-line-amplitude-data)
  + [6.2 Calculated Threshold Table](#calculated-threshold-table)
* [7 Session info](#session-info)

# 1 Introduction

PoDCall (Positive Droplet Caller) is a package that aims to provide a robust
calling of positive droplets in DNA methylation droplet digital PCR (ddPCR)
experiments performed on the Bio-Rad platform.
PoDCall provides functions that reads files exported from QuantaSoft or
QX Manager containing amplitudes from a run of ddPCR (one 96 well plate), sets
thresholds for both channels of each individual well and calculates
concentrations and normalized concentration for each well.The resulting
threshold table can optionally be written to file automatically by the main
workflow function. PoDCall also offers functionality for plotting, both
individual wells and multiple well plots. Plots for individual wells can be made
and saved as .pdf-files as part of the main workflow function, or by calling the
various plotting functions individually.

## 1.1 Gaussian Mixture Models

DdPCR experiments generate a mixture of droplets, positive droplets which
contain the target that will be amplified, and negative droplets that does not
contain the target and show no amplification. PoDCall relies on fitting Gaussian
mixture models to set thresholds for each individual well
that will be used to classify the droplets as either positive or negative.
For more details on the concepts of PoDCall, see the application note.

## 1.2 Input Data

The input data is .csv-files exported from ‘QuantaSoft’ or ‘QX Manager, and each
file contains the amplitude values of droplets from one well of a 96 well plate.
The first two columns of the files should have headers ’Ch1 Amplitude’ and
‘Ch2 Amplitude’. To read in data, use the function importAmplitudeData, which
will read all amplitude files in the directory given as argument. Each file will
be stored as a named data frame in a list, where the name will be the well ID.
For this reason, all raw data files in the directory given as argument should
be from the same 96 well plate to avoid well coordinate duplicates.

# 2 Installation

PoDCall requires some packages to be installed, and if any required packages are
not yet installed, the installation of PoDCall should take care of it (you will
be prompted to install the packages that are missing).

The released version of PoDCall be installed from
[BIOCONDUCTOR](http://bioconductor.org/), from GitHub or from a source file
using:

```
## Install from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PoDCall")

## Install PoDCall from GitHub
install.packages("devtools")
devtools::install_github("HansPetterBrodal/PoDCall")

## Install PoDCall from source file
install.packages("remotes")
remotes::install_local("path/to/PoDCall_x.y.z.tar.gz")
```

After installing PoDCall and the required packages, PoDCall can be loaded with:

```
library(PoDCall)
```

# 3 Example / Usage

One step of setting thresholds includes a random sampling of droplets to greatly
reduce running time. To ensure reproducible results it is recommended to set a
seed using `set.seed()`.
To run the full PoDCall workflow, call the function `podcallDdpcr()`:

```
## Run PoDCall
thresholdTable <- podcallDdpcr(dataDirectory="path/to/data/",
                                software="QuantaSoft")
```

Where “path/to/data/” is the path of the directory that contains amplitude files
from a well plate, in which the files have names that end with
"\_wellID\_amplitude.csv“.”software" is the software that was used to export the
data (amplitude) files and the sample sheet. Must be either “QuantaSoft” or
“QX Manager”. Since the different software versions format amplitude files and
sample sheet differently, it is important to set the correct value as argument
to ensure that data and sample sheet is read correctly.

## 3.1 Optional arguments

The following arguments have default values, but can be given other values if
desired. For example to write results to file, which is disabled by default.

### 3.1.1 sampleSheetFile

Path to sample sheet file. Must be a .csv file and must include the following
columns: Well, Sample, TargetType and Target. The entries in the column
TargetType must be either ‘Ch1Unknown’ or ‘Ch2Unknown’, and is used
to extract rows with information from either channel 1 or channel 2. An example
file has been included in the package, which can be found using
`system.file("extdata", "Sample_names.csv", package="PoDCall")`

### 3.1.2 B

The number of permutations used by the likelihood ratio test (LRT)
which decides the number of components in the model fitted from the data.
Default value `B=200`.

### 3.1.3 Q

A parameter used for calling outliers. Q is multiplied with the interquartile
range of the distribution of amplitude values to determine if droplets of
extreme amplitude values are to be considered outliers. The default value is
`Q=9`, which has been determined through cell line experiments and testing.
A higher Q will generally result in a higher or more strict threshold. Q
provides an option to adjust how thresholds are set in a systematic and
reproducible way. It is recommended to try a few different values and visually
inspect the results.

### 3.1.4 refwell

The well used as reference when calculating the shift in baseline
between wells. By default `refwell=1`, but can be changed in cases where the
first well is not suited to be used.

### 3.1.5 nrChannels

If there is no control channel used, set nrChannels=1 to indicate only target
channel used. Default value is 2.

### 3.1.6 targetChannel

When a multiplexed set up is used (more than a single target channel), what
channel to be analysed is the target channel. Default targetChannel=1.

### 3.1.7 controlChannel

The channel used for control assay. Default controlChannel=2.

### 3.1.8 software

The Bio-Rad software the data was exported from. Must be either “QuantaSoft” or
“QX Manager”, the latter being default. This is due to unequal number of lines
that needs to be skipped in the raw amplitude data files.

### 3.1.9 resultsToFile

The user can choose to let PoDCall save the results table as a .csv-file by
setting `resultsToFile=TRUE` (default: `resultsToFile = FALSE`). When
resultsToFile is set to TRUE, a results directory will be created where the
result file will be saved. The results directory will have the same name as the
data directory with "\_results" added: "path/to/data\_results/

### 3.1.10 plots

The user can choose to make plots that are written to file by setting
`plots=TRUE` (default: `plots=FALSE`). Plots will be saved to the results
directory created when `resultsToFile=TRUE`. The results directory will also be
created if only `plots=TRUE`.

### 3.1.11 resPath

Optional argument to specify a directory for writing results file(s) to other
than the results directory created by default. Requires `resultsToFile=TRUE`.

## 3.2 Threshold table columns

The table that is returned when running `podcall_ddpcr()` contains columns with
more or less self-explanatory column names, and well ID (well coordinates) as
rownames:

### 3.2.1 sample\_id

If a sample sheet file is provided, this will have the sample ID from the sample
sheet. Otherwise empty

### 3.2.2 thr\_target

the threshold set for selected target channel

### 3.2.3 thr\_ctrl

The threshold set for control channel

### 3.2.4 pos\_dr\_target

The number of positive droplets in selected target channel

### 3.2.5 pos\_dr\_ctrl

The number of positive droplets in control channel

### 3.2.6 tot\_droplets

Number of droplets.

### 3.2.7 c\_target

Concentration of target, calculated by the formula
\(-\log\dfrac{\dfrac{\text{neg\_drop\_tar}}{\text{tot\_droplets}}}{0.000851}\)
where neg\_drop\_tar is number of negative droplets in channel 1 (target).

### 3.2.8 c\_ctrl

Concentration of control, calculated by the formula
\(-\log\dfrac{\dfrac{\text{neg\_drop\_ctrl}}{\text{tot\_droplets}}}{0.000851}\)
where neg\_drop\_ctrl is number of negative droplets in channel 2 (control).

### 3.2.9 c\_norm\_4Plex

Normalized concentration with 4Plex as control, calculated by the formula
\(\dfrac{\text{c\_target}}{\text{c\_ctrl}}\cdot400\)

### 3.2.10 c\_norm\_sg

Normalized concentration with single gene as control, calculated by the formula
\(\dfrac{\text{c\_target}}{\text{c\_ctrl}}\cdot100\)

### 3.2.11 q

The value used for Q

### 3.2.12 target\_assay

The assay used for target channel, provided via sample sheet.

### 3.2.13 ctrl\_assay

The assay used for control channel, provided via sample sheet.

### 3.2.14 ref\_well

The well used as reference well for setting threshold.

# 4 PoDCall functions

`podcallDdpcr()` is the main wrapper function that returns a table with the
results of PoDCall to the user. This function uses a set of functions that read
the amplitude data from file, set thresholds and make plots. All functions
involved can be used individually should the user only want to use some of the
functionality of PoDCall. Also see help files for more details about the
functions and their arguments.

## 4.1 `importAmplitudeData()`

Reads .csv-files with amplitude data outputted from QuantaSoft or QX Manager and
store the data in a list, one data frame per well. Each element in the list will
be named using it’s well ID (coordinate) of the 96 well plate that the sample
belong to.

```
## Path to example data files included in PoDCall
path <- system.file("extdata", "Amplitudes/", package="PoDCall")

## Read in data files
dataList <- importAmplitudeData(dataDirectory=path, skipLines=0)
str(dataList)
#> List of 5
#>  $ A04:'data.frame': 18739 obs. of  2 variables:
#>   ..$ Ch1: num [1:18739] 940 971 971 976 985 ...
#>   ..$ Ch2: num [1:18739] 11795 7868 8377 10007 9523 ...
#>  $ B04:'data.frame': 16933 obs. of  2 variables:
#>   ..$ Ch1: num [1:16933] 980 995 1002 1007 1014 ...
#>   ..$ Ch2: num [1:16933] 9524 7999 7686 7799 9510 ...
#>  $ D04:'data.frame': 11713 obs. of  2 variables:
#>   ..$ Ch1: num [1:11713] 1042 1070 1094 1112 1112 ...
#>   ..$ Ch2: num [1:11713] 7826 9934 7698 7605 7743 ...
#>  $ D05:'data.frame': 12642 obs. of  2 variables:
#>   ..$ Ch1: num [1:12642] 1045 1057 1063 1068 1079 ...
#>   ..$ Ch2: num [1:12642] 9722 7752 9103 7716 7738 ...
#>  $ H05:'data.frame': 19638 obs. of  2 variables:
#>   ..$ Ch1: num [1:19638] 1043 1094 1098 1104 1119 ...
#>   ..$ Ch2: num [1:19638] 7231 7063 7161 6863 7416 ...
```

## 4.2 `importSampleSheet()`

Reads a .csv-file outputted from QuantaSoft or QX Manager to get information
about the samples: Sample name/id, Assay for target and control.

```
## Path to example files included in PoDCall
path <- system.file("extdata", "Sample_names.csv", package="PoDCall")

## Select wells to get information for
well_id <- c("A04", "B04", "D04")

## Read in sample sheet information for selected wells
sampleSheet <- importSampleSheet(sampleSheet=path, well_id=well_id,
                                software="QuantaSoft")
print(sampleSheet)
#>   well_id sample_id target_assay ctrl_assay
#> 1     A04    SW1463          VIM   new4Plex
#> 2     B04     SW403          VIM   new4Plex
#> 3     D04     SW480          VIM   new4Plex
```

## 4.3 `podcallThresholds()`

Takes a list of data frames, one for each well, as argument and sets
individual thresholds for each channel of each well. It returns a table with
thresholds, number of positive droplets, concentrations etc. The number of
permutations for likelihood ratio test is by default set to `B=400` as a
compromise between run time and stability of the results. The parameter for
calling outliers is by default set to `Q=9`. Higher Q means more conservative
(higher) thresholds, lower Q will result in over all lower thresholds.

```
## Path to example data files included in PoDCall
path <- system.file("extdata", "Amplitudes/", package="PoDCall")

## Read in data files
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)

## Calculate thresholds, metrics, concentrations
thresholdTable <- podcallThresholds(plateData=ampData)
print(thresholdTable)
```

## 4.4 `podcallChannelPlot()`

Takes the threshold and amplitude values corresponding to a channel of a well as
arguments, calls functions that makes scatter plot and histogram and draws a
plot with both.

```
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
data("thrTable")
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallChannelPlot(channelData=ampData[[well_id]][,ch],
                    thr=thresholdTable[well_id, "thr_target"],
                    channel=ch,
                    plotId=plotTitle)
```

![](data:image/png;base64...)

## 4.5 `podcallScatterplot()`

Takes the threshold and amplitude values corresponding
to a channel of a well as argument and returns a scatter plot.

```
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallScatterplot(channelData=ampData[[well_id]][,ch],
                    thr=thresholdTable[well_id, "thr_target"],
                    channel=ch,
                    plotId=plotTitle)
```

![](data:image/png;base64...)

## 4.6 `podcallHistogram()`

Takes the threshold and amplitude values corresponding to
a channel of a well as argument, and returns a histogram.

```
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallHistogram(channelData=ampData[[well_id]][,ch],
                thr=thresholdTable[well_id, "thr_target"],
                channel=ch,
                plotId=plotTitle)
```

![](data:image/png;base64...)

## 4.7 `podcallMultiplot()`

takes a list of data frames with amplitude data, one per well, and their
respective thresholds as arguments and returns faceted scatter plots suitable
for comparing wells.

```
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Channel to plot
ch <- "target"

## Create comparison plot
podcallMultiplot(plateData=ampData,
                thresholds=thresholdTable[names(ampData),],
                channel=ch, colCh=1)
```

![](data:image/png;base64...)

# 5 PoDCall shiny application

PoDCall does also include an application powered by shiny that launches in a
web browser. The application provides a user friendly and interactive interface
to the functionality of PoDCall. To start the app:

```
podcallShiny()
```

# 6 PodCall example data

There are some amplitude files and a sample sheet included in the package that
are intended to be used to run examples and to try out the functionality of
PoDCall. The data files are from a real experiment performed with cell line
samples. There is also a threshold table computed from the example data
included. PoDCall takes a few minutes to run due to bootstrapping, and this
table is used in examples for functions where threshold is an argument.

## 6.1 Cell Line Amplitude Data

The cell line amplitude data files can be found in the “extdata” subdirectory
of the package directory and can be found using `system.file()`:

```
## Path to files
path <- system.file("extdata", "Amplitudes/", package="PoDCall")

## List files
list.files(path)
#> [1] "VIM_4Plex_A04_Amplitude.csv" "VIM_4Plex_B04_Amplitude.csv"
#> [3] "VIM_4Plex_D04_Amplitude.csv" "VIM_4Plex_D05_Amplitude.csv"
#> [5] "VIM_4Plex_H05_Amplitude.csv"
```

The control assay used for the samples in the example data files is an assay
developed in-house called 4Plex
[H. Pharo et al](http://dx.doi.org/10.1186/s13148-018-0456-5).

## 6.2 Calculated Threshold Table

The already calculated threshold table is instantly available when PoDCall is
loaded, and is available as an object called `thrTable`. See `?thrTable` for
help file with documentation on the table.

```
## The threshold table
thrTable
#>       sample_id target_ch thr_target thr_ctrl pos_dr_target pos_dr_ctrl
#> A04      SW1463       Ch1       2761     9128          2479       12905
#> B04       SW403       Ch1       2739     8632           660        7471
#> D04       SW480       Ch1       2863     8489            44        8348
#> D05 IVDZ_bisulf       Ch1       2818     8473          1675        6584
#> H05         NTC       Ch1       2823     7910             0           0
#>     tot_droplets c_target c_ctrl c_norm_4Plex c_norm_sg q target_assay
#> A04        18739  166.700 1371.0        48.64     12.16 9          VIM
#> B04        16933   46.720  683.9        27.33     6.831 9          VIM
#> D04        11713    4.423 1466.0        1.207    0.3017 9          VIM
#> D05        12642  167.000  864.4        77.28     19.32 9          VIM
#> H05        19638    0.000    0.0       No DNA    No DNA 9          VIM
#>     ctrl_assay ref_well
#> A04   new4Plex      A04
#> B04   new4Plex      A04
#> D04   new4Plex      A04
#> D05   new4Plex      A04
#> H05   new4Plex      A04
```

# 7 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled

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
#> [1] PoDCall_1.18.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10          generics_0.1.4       hms_1.1.4
#>  [4] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
#>  [7] grid_4.5.1           RColorBrewer_1.1-3   bookdown_0.45
#> [10] fastmap_1.2.0        jsonlite_2.0.0       tinytex_0.57
#> [13] mclust_6.1.1         promises_1.4.0       gridExtra_2.3
#> [16] BiocManager_1.30.26  purrr_1.1.0          scales_1.4.0
#> [19] jquerylib_0.1.4      rlist_0.4.6.2        cli_3.6.5
#> [22] shiny_1.11.1         crayon_1.5.3         rlang_1.1.6
#> [25] bit64_4.6.0-1        LaplacesDemon_16.1.6 withr_3.0.2
#> [28] cachem_1.1.0         yaml_2.3.10          otel_0.2.0
#> [31] tools_4.5.1          parallel_4.5.1       tzdb_0.5.0
#> [34] dplyr_1.1.4          ggplot2_4.0.0        httpuv_1.6.16
#> [37] DT_0.34.0            mime_0.13            vctrs_0.6.5
#> [40] R6_2.6.1             magick_2.9.0         lifecycle_1.0.4
#> [43] bit_4.6.0            htmlwidgets_1.6.4    vroom_1.6.6
#> [46] shinyjs_2.1.0        archive_1.1.12       pkgconfig_2.0.3
#> [49] later_1.4.4          bslib_0.9.0          pillar_1.11.1
#> [52] gtable_0.3.6         glue_1.8.0           data.table_1.17.8
#> [55] Rcpp_1.1.0           xfun_0.53            tibble_3.3.0
#> [58] tidyselect_1.2.1     knitr_1.50           dichromat_2.0-0.1
#> [61] xtable_1.8-4         farver_2.1.2         htmltools_0.5.8.1
#> [64] labeling_0.4.3       rmarkdown_2.30       readr_2.1.5
#> [67] compiler_4.5.1       S7_0.2.0             diptest_0.77-2
```