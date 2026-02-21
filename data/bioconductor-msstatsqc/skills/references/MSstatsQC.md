# MSstatsQC: longitudinal system suitability monitoring and quality control for proteomic experiments

#### Eralp DOGU eralp.dogu@gmail.com

#### Sara TAHERI srtaheri66@gmail.com

#### Olga VITEK o.vitek@neu.edu

#### 2025-10-30

# Introduction

Liquid chromatography coupled with mass spectrometry (LC-MS) is a powerful tool for detection and quantification of peptides in complex matrices. An important objective of targeted LC-MS is to obtain peptide quantifications that are (1) suitable for the purpose of the investigation, and (2) reproducible across laboratories and runs. The first objective is achieved by system suitability tests (SST), which verify that mass spectrometric instrumentation performs as specified. The second objective is achieved by quality control (QC), which provides in-process quality assurance of the sample profile. A common aspect of SST and QC is the longitudinal nature of their data. Although SST and QC receive a lot of attention in the proteomic community, the currently used statistical methods are fairly limited. `MSstatsQC` improves upon the existing statistical methodology for SST and QC. It translates the modern methods of longitudinal statistical process control, such as simultaneous and time weighted control charts and change point analysis to the context of LC-MS experiments The methods are implemented in an open-source R-based software package (www.msstats.org/msstatsqc), and are available for use stand-alone, or for integration with automated pipelines. Example datatsets include SRM based system suitability dataset from CPTAC Study 9.1 at Site 54, DDA and SRM based QC datasets from the QCloud system and a dataset for DIA type quantification for iRT peptides from QuiC system. Although the first example here focus on targeted proteomics, the statistical methods more generally apply. Version 2.0 includes data processing extensions for missing value handling. DDA and DIA examples can be found at the end of this document.

This vignette summarizes various aspects of all functionalities in `MSstatsQC` package.

# Installation

To install this package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MSstatsQC")
```

# Input

In order to analyze QC/SST data in `MSstatsQC`, input data must be a .csv file in a “long” format with related columns. This is a common data format that can be generated from spectral processing tools such as Skyline and Panorama AutoQC..

The recommended format includes `Acquired Time`, `Peptide name`, `Annotations` and data for any QC metrics such as `Retention Time`, `Total Peak Area` and `Mass Accuracy` etc. Each input file should include `Acquired Time`, `Peptide name` and `Annotations`. After the `Annotations` column user can parse any metric of interest with a proper column name.

1. `AcquiredTime`: This column shows the acquired time of the QC/SST sample in the format of MM/DD/YYYY HH:MM:SS AM/PM.
2. `Precursor`: This column shows information about Precursor id. Statistical analysis will be conducted for each unique label in this column.
3. `Annotations`: Annotations are free-text information given by the analyst about each run. They can be information related to any special cause or any observations related to a particular run. Annotations are carried in the plots provided by `MSstatsQC` interactively.

(d)-(f) `RetentionTime`, `TotalPeakArea`, `FWHM`, `MassAccuracy`, and `PeakAssymetry`, and other metrics: These columns define a *feature* of a peak for a specific peptide.

The example dataset is shown below. Each row corresponds to a single time point. Additionally, other inputs such as predefined limits or guide sets are discussed in further steps.

### Example

```
#A typical multi peptide and multi metric system suitability dataset
#This dataset was generated during CPTAC Study 9.1 at Site 54
library(MSstatsQC)
data <- MSstatsQC::S9Site54
```

# `MSnbaseToMSstatsQC` functions

`MSnbaseToMSstatsQC` function converts `MSnbase` output to `MSstatQC` format using `QCmetrics` objects.

### Arguments

* `msfile`: Mass spectrometry raw file that contains quality control measurements.

### Example

```
MSnbaseToMSstatsQC(msfile)
```

# Data processing

Data is processed with `DataProcess()` function to ensure data sanity and efficiently use core and summary `MSstatsQC` funtions. `MSstatsQC` uses a data validation method where slight variations in column names are compansated and converted to the standard `MSstatsQC` format. For example, our data validation function converts column names like `Best.RT`, `best retention time`, `retention time`, `rt` and `best ret` into `BestRetentionTime`. This conversion also deals with case-sensitive typing.

### Arguments

* `data` : comma-separated (.csv), metric file. It should contain a “Precursor” column and the metrics columns. It should also include “Annotations” for each observation.

### Example

```
data<-DataProcess(data)
```

```
## [1] "Your data is ready to go!"
```

# `MSstatsQC` core functions: control charts

The fuction `XmRChart()` is used to generate individual (X) and moving range (mR), and the function `CUSUMChart()` is used to construct cumulative sum for mean (CUSUMm) and cumulative sum for variability (CUSUMv) control charts for each metric. As a follow up change point estimation procedure `ChangePointEstimator` can be used.

Metrics (e.g. retention time and peak area) and peptides are chosen within all core functions with ‘metric’ and ‘peptide’ arguments. `MSstatsQC` can handle any metrics of interest. User needs to create data columns just after `Annotations` to import metrics into `MSstatsQC` successfully.

Predefined limits are commonly used in system sutiability monitoring and quality control studies. If the mean and variability of a metric is well known, they can be defined using ‘selectMean’ and ‘selectSD’ arguments in core plot functions (e.g. XmRplots function). For example, if mean of retention time is 28.5 minutes, standard deviation is 1 minutes and X chart is used for peptide LVNELTEFAK, we use XmRplot function as follows.

The true values of mean and variability of a metric is typically unknown, and their estimates are obtained from a guide set of high quality runs. Generally, a data gathering and parameter estimation step is required. Within that phase, control limits are obtained to test the hypothesis of statistical control. These thresholds are selected to ensure a specified type I error probability (e.g. 0.0027). Constructing control charts and real time evaluation are considered after achieving this phase. Guide sets are defined with ‘L’ and ‘U’ arguments. For example, if retention time of a peptide is monitored and first 20 observations of the dataset are used as a guide set, a plot is constructed as follows.

# `MSstatsQC` core functions: `XmRChart()`

### Arguments

* `data`: comma-separated (.csv), metric file. It should contain a “Precursor” column and the metrics columns. It should also include “Annotations” for each observation.
* `peptide`: the name of precursor of interest.
* `L`: lower bound of the guide set.
* `U`: upper bound of the guide set.
* `metric`: the name of metric of interest.
* `normalization`: TRUE if data is standardized.
* `ytitle`: the y-axis title of the plot. The x-axis title is by default “Time : name of peptide”
* `type`: the type of the control chart. Two values can be assigned, “mean” or “dispersion”. Default is “mean”
* `selectMean`: the mean of a metric. It is used when mean is known. It is NULL when mean is not known. The default is NULL.
* `selectSD`: the standard deviation of a metric. It is used when standard deviation is known. It is NULL when mean is not known. The default is NULL.

### Example

```
#An X chart when a guide set (1-20 runs) is used to monitor the mean of retention time
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = FALSE, ytitle = "X Chart : retention time", type = "mean", selectMean = NULL ,selectSD = NULL )
```

```
#An X chart when a guide set (1-20 runs) is used to monitor the mean of total peak area
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = FALSE, ytitle = "X Chart : peak area", type = "mean", selectMean = NULL ,selectSD = NULL )
```

```
#An mR chart when a guide set (1-20 runs) is used to monitor the variability of total peak area
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea", normalization = TRUE, ytitle = "mR Chart : peak area", type = "variability", selectMean = NULL, selectSD = NULL )
```

```
#An mR chart when a guide set (1-20 runs) is used to monitor the variability of retention time
XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = TRUE, ytitle = "mR Chart : retention time", type = "variability", selectMean = NULL, selectSD = NULL )
```

```
#Mean and standard deviation of LVNELTEFAK is known
XmRChart( data, "LVNELTEFAK", metric = "BestRetentionTime", selectMean = 28.5, selectSD = 0.5 )
```

```
#Mean and standard deviation of LVNELTEFAK is known
XmRChart( data, "LVNELTEFAK", metric = "BestRetentionTime", selectMean = 28.5, selectSD = 0.5 )
```

# `MSstatsQC` core functions: `CUSUMChart()`

### Arguments

* `data`: comma-separated (.csv), metric file. It should contain a “Precursor” column and the metrics columns. It should also include “Annotations” for each observation.
* `peptide`: the name of precursor of interest.
* `L`: lower bound of the guide set.
* `U`: upper bound of the guide set.
* `metric`: the name of metric of interest.
* `normalization`: TRUE if data is standardized.
* `ytitle`: the y-axis title of the plot. The x-axis title is by default “Time : name of peptide”
* `type`: the type of the control chart. Two values can be assigned, “mean” or “dispersion”. Default is “mean”
* `referenceValue`: the value that is used to tune the control chart for a proper shift size. Recommended setting is 0.5 for standardized data.
* `decisionInterval`: the threshold to detect an out-of-control observation. Recommended setting is 5 for standardized data.
* `selectMean`: the mean of a metric. It is used when mean is known. It is NULL when mean is not known. The default is NULL.
* `selectSD`: the standard deviation of a metric. It is used when standard deviation is known. It is NULL when mean is not known. The default is NULL.

### Example

# `MSstatsQC` core functions: `ChangePointEstimator()`

Follow-up change point analysis is helpful to identify the time of a change for each peptide and metric. `ChangePointEstimator()` function is used for the analysis. This function is one of the core functions and uses the same arguments. We recommend using this function after control charts generate an out-of-control observation. For example, retention time of TAAYVNAIEK increases over time as CUSUMm statistics increases steadily after the 20th time point. User can follow-up with `ChangePointEstimator()` function to find the exact time of retention time drift.

### Arguments

* `data`: comma-separated (.csv), metric file. It should contain a “Precursor” column and the metrics columns. It should also include “Annotations” for each observation.
* `peptide`: the name of precursor of interest.
* `L`: lower bound of the guide set.
* `U`: upper bound of the guide set.
* `metric`: the name of metric of interest.
* `normalization`: TRUE if data is standardized.
* `ytitle`: the y-axis title of the plot. The x-axis title is by default “Time : name of peptide”
* `type`: the type of the control chart. Two values can be assigned, “mean” or “dispersion”. Default is “mean”
* `selectMean`: the mean of a metric. It is used when mean is known. It is NULL when mean is not known. The default is NULL.
* `selectSD`: the standard deviation of a metric. It is used when standard deviation is known. It is NULL when mean is not known. The default is NULL.

### Example

```
# Retention time >> first 20 observations are used as a guide set
XmRChart(data, "TAAYVNAIEK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)
```

```
ChangePointEstimator(data, "TAAYVNAIEK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)
```

We don’t recommend using this function when all the observations are within control limits. In the case of retention time monitoring of LVNELTEFAK, there is no need to further analyse change point.

The time of a variability change can be analyzed with the same fucntion. For example, retention time of YSTDVSVDEVK experiences a drift in the mean of retention time and variability of retention time increases simultaneously. In this case, `ChangePointEstimator()` can be used to identify exact times of both changes.

### Example

```
# Retention time >> first 20 observations are used as a guide set
XmRChart(data, "YSTDVSVDEVK", metric = "BestRetentionTime", type="mean", L = 1, U = 20)
```

```
ChangePointEstimator(data, "YSTDVSVDEVK", metric = "BestRetentionTime", type="variability", L = 1, U = 20)
```

# `MSstatsQC` summary functions: river and radar plots

`RiverPlot()` and `RadarPlot()` functions are the summary functions used in `MSstatsQC`. They are used to aggregate results over all analytes for X and mR charts or CUSUMm and CUSUMv charts. `method` argument is used to define the method where the results for multiple peptides are aggregated. For example, if user would like to aggregate information gathered from the X charts of retention time for all analytes, upper panel of `RiverPlot()` show for the increases and decreases in retention time. Next, `RadarPlot()` are used to find out which peptides are affected by the problem.

If the mean and standard deviation is known, summary functions uses `listMean` and `listSD` arguments. For example, if user monitors retention time and peak assymetry and mean and standard deviations of these metrics are known, arguments will require entering a vector for means and another vector for standard deviations.

### Example

```
# Retention time >> first 20 observations are used as a guide set
RiverPlot(data = S9Site54, L = 1, U = 20, method = "XmR")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RiverPlot(data = S9Site54, L = 1, U = 20, method = "CUSUM")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RadarPlot(data = S9Site54, L = 1, U = 20, method = "XmR")
```

![](data:image/png;base64...)

```
RadarPlot(data = S9Site54, L = 1, U = 20, method = "CUSUM")
```

![](data:image/png;base64...)

# `MSstatsQC` summary functions: decision map

`DecisionMap()` functions another summary function used in `MSstatsQC`. It is used to compare aggregated results over all analytes for a certain method such as XmR charts with the user defined criteria. Firstly, user defines the performance criteria and run `DecisionMap()` function to visualize overall performance. This function uses all the arguments of summary plots listed previously. Additionally, the following arguments are used

### Arguments

* `method`: the name of the method prefered. It is either “CUSUM” or “XmR”` interest.
* `peptideThresholdRed`: a threshold that marks percentage of out-of-control peptides. if the percentage is above this threshold, the color is red meaning fail. Default is 0.7.
* `peptideThresholdYellow`: a threshold that marks percentage of out-of-control peptides. if the percentage within this threshold and `peptideThresholdRed`, the color is yellow meaning warning. Default is 0.5.

### Example

```
# A decision map for Site 54 can be generated using the following script
# Retention time >> first 20 observations are used as a guide set
DecisionMap(data,method="XmR",peptideThresholdRed = 0.25,peptideThresholdYellow = 0.10,
                         L = 1, U = 20,type = "mean",title = "Decision map",listMean = NULL,listSD = NULL)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the MSstatsQC package.
##   Please report the issue at
##   <https://groups.google.com/forum/#!forum/msstatsqc>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Use of `data$time` is discouraged.
## ℹ Use `time` instead.
```

```
## Warning: Use of `data$metric` is discouraged.
## ℹ Use `metric` instead.
```

```
## Warning: Use of `data$bin` is discouraged.
## ℹ Use `bin` instead.
## Use of `data$bin` is discouraged.
## ℹ Use `bin` instead.
```

![](data:image/png;base64...)

# Use case: longitudinal profiling of DDA with missing values

We analyzed the QCloudDDA dataset. The dataset had many missing values and MSstatsQC 2.0 processed these missing values and generated control charts and summary plots for longitudinal performance assessment.

```
mydata<-DataProcess(MSstatsQC::QCloudDDA)
```

```
## [1] "Your data is ready to go!"
```

```
#Creating a missing data map
MissingDataMap(mydata)
```

![](data:image/png;base64...)

```
XmRChart(mydata, "EACFAVEGPK", metric = "missing", type="mean", L = 1, U = 15)
```

```
mydata<-RemoveMissing(mydata)
RiverPlot(mydata[,-9], L=1, U=15, method="XmR")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RadarPlot(mydata[,-9], L=1, U=15, method="XmR")
```

![](data:image/png;base64...)

```
mydata<-DataProcess(MSstatsQC::QCloudDDA)
```

```
## [1] "Your data is ready to go!"
```

```
#Creating a missing data map
MissingDataMap(mydata)
```

![](data:image/png;base64...)

```
#Creating an X chart for missing counts
XmRChart(mydata, "EACFAVEGPK", metric = "missing", type="mean", L = 1, U = 15)
```

```
#Removing missing values and analyzing the data
mydata<-RemoveMissing(mydata)
RiverPlot(mydata[,-9], L=1, U=15, method="XmR")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RadarPlot(mydata[,-9], L=1, U=15, method="XmR")
```

![](data:image/png;base64...) # Use case: longitudinal profiling of QC with iRT peptides

We analyzed the QuiCDIA dataset which included longitudinal profiles of 11 iRT peptides. The data comprised two DIA experiments acquired in duplicate with 11 days in between the two measurement sequences.

```
#Checking missing values and analyzing the data
MissingDataMap(MSstatsQC::QuiCDIA)
```

```
## [1] "No missing values!"
```

```
RiverPlot(data = QuiCDIA, L = 1, U = 20, method = "XmR")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RadarPlot(data = QuiCDIA, L = 1, U = 20, method = "XmR")
```

![](data:image/png;base64...)

# Use case: longitudinal profiling of QC from an SRM experiment

Following the implementation in Dogu et al. (2017), we analyzed the QCloudSRM dataset. This dataset was previously evaluated by the experts as well-performing for all peptides and metrics, except for the outlying peptide TCVADESHAGCEK.

```
#Checking missing values and analyzing the data
MissingDataMap(MSstatsQC::QCloudSRM)
```

```
## [1] "No missing values!"
```

```
RiverPlot(data = QCloudSRM, L = 1, U = 20, method = "CUSUM")
```

```
## Warning: Use of `dat$QCno` is discouraged.
## ℹ Use `QCno` instead.
```

```
## Warning: Use of `dat$pr.y` is discouraged.
## ℹ Use `pr.y` instead.
```

```
## Warning: Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
## Use of `dat$group` is discouraged.
## ℹ Use `group` instead.
```

```
## Warning: Use of `tho.hat.df$tho.hat` is discouraged.
## ℹ Use `tho.hat` instead.
```

```
## Warning: Use of `tho.hat.df$y` is discouraged.
## ℹ Use `y` instead.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
RadarPlot(data = QCloudSRM, L = 1, U = 20, method = "CUSUM")
```

![](data:image/png;base64...)

# Output

Plots created by the core plot functions are generate by `plotly` which is an R package for interactive plot generation. These interactive plots created by `MSstatsQC`, can be saved as an html file using the save widget function. If the user wants to save a static png file, then `export` function can be used. The outputs of other MSstatsQC functions are generated by `ggplot2` package and saving those outputs would require using `ggsave` function.

### Example

```
#Saving plots generated by plotly
p<-XmRChart( data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "BestRetentionTime", normalization = FALSE,
                      ytitle = "X Chart : retention time", type = "mean", selectMean = NULL, selectSD = NULL )
htmlwidgets::saveWidget(p, "Aplot.html")
export(p, file = "Aplot.png")

#Saving plots generated by ggplot2
p<-RiverPlot(data, L=1, U=20)
ggsave(filename="Summary.pdf", plot=p)
#or
ggsave(filename="Summary.png", plot=p)
```

## Output

Plots created by the core plot functions are generated by [plotly](https://plot.ly/r/) which is an R package for interactive plot generation. Each output generated by ‘plotly’ can be saved using the “plotly” toolset.

## Project website

Please use [MSstats.org/MSstatsQC](https://www.MSstats.org/MSstatsQC) and [github repository](https://github.com/eralpdogu/MSstatsQCgui) for further details about this tool.

## Question and issues

Please use [Google group](https://groups.google.com/forum/#!forum/msstatsqc) if you want to file bug reports or feature requests.

# Citation

Please cite MSstatsQC:

* Dogu, E., Mohammad-Taheri, S., Abbatiello, S. E., Bereman, M. S., MacLean, B., Schilling, B., & Vitek, O. (2017). MSstatsQC: Longitudinal system suitability monitoring and quality control for targeted proteomic experiments. Molecular & Cellular Proteomics, 16(7), 1335-1347.
* Dogu, E., Mohammad-Taheri, S., Olivella, R., Marty, F., Lienert, I., Reiter, L., Sabidó, E., Vitek, O. (2018). MSstatsQC 2.0: R/Bioconductor package for statistical quality control of mass spectrometry-based proteomic experiments. Submitted to JPR.

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MSstatsQC_2.28.0
##
## loaded via a namespace (and not attached):
##   [1] rlang_1.1.6                 magrittr_2.0.4
##   [3] clue_0.3-66                 otel_0.2.0
##   [5] matrixStats_1.5.0           compiler_4.5.1
##   [7] mgcv_1.9-3                  vctrs_0.6.5
##   [9] reshape2_1.4.4              stringr_1.5.2
##  [11] ProtGenerics_1.42.0         crayon_1.5.3
##  [13] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
##  [15] fastmap_1.2.0               XVector_0.50.0
##  [17] labeling_0.4.3              pander_0.6.6
##  [19] promises_1.4.0              rmarkdown_2.30
##  [21] preprocessCore_1.72.0       purrr_1.1.0
##  [23] xfun_0.53                   MultiAssayExperiment_1.36.0
##  [25] cachem_1.1.0                jsonlite_2.0.0
##  [27] later_1.4.4                 DelayedArray_0.36.0
##  [29] BiocParallel_1.44.0         parallel_4.5.1
##  [31] cluster_2.1.8.1             R6_2.6.1
##  [33] bslib_0.9.0                 stringi_1.8.7
##  [35] RColorBrewer_1.1-3          limma_3.66.0
##  [37] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [39] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [41] SummarizedExperiment_1.40.0 iterators_1.0.14
##  [43] knitr_1.50                  qcmetrics_1.48.0
##  [45] IRanges_2.44.0              BiocBaseUtils_1.12.0
##  [47] splines_4.5.1               httpuv_1.6.16
##  [49] Matrix_1.7-4                igraph_2.2.1
##  [51] tidyselect_1.2.1            dichromat_2.0-0.1
##  [53] abind_1.4-8                 yaml_2.3.10
##  [55] doParallel_1.0.17           codetools_0.2-20
##  [57] affy_1.88.0                 miniUI_0.1.2
##  [59] lattice_0.22-7              tibble_3.3.0
##  [61] plyr_1.8.9                  withr_3.0.2
##  [63] Biobase_2.70.0              shiny_1.11.1
##  [65] S7_0.2.0                    evaluate_1.0.5
##  [67] Spectra_1.20.0              pillar_1.11.1
##  [69] affyio_1.80.0               BiocManager_1.30.26
##  [71] MatrixGenerics_1.22.0       foreach_1.5.2
##  [73] stats4_4.5.1                plotly_4.11.0
##  [75] MSnbase_2.36.0              MALDIquant_1.22.3
##  [77] ncdf4_1.24                  generics_0.1.4
##  [79] S4Vectors_0.48.0            ggplot2_4.0.0
##  [81] scales_1.4.0                xtable_1.8-4
##  [83] glue_1.8.0                  lazyeval_0.2.2
##  [85] tools_4.5.1                 data.table_1.17.8
##  [87] mzID_1.48.0                 QFeatures_1.20.0
##  [89] vsn_3.78.0                  mzR_2.44.0
##  [91] fs_1.6.6                    XML_3.99-0.19
##  [93] grid_4.5.1                  impute_1.84.0
##  [95] tidyr_1.3.1                 crosstalk_1.2.2
##  [97] MsCoreUtils_1.22.0          nlme_3.1-168
##  [99] PSMatch_1.14.0              cli_3.6.5
## [101] viridisLite_0.4.2           S4Arrays_1.10.0
## [103] dplyr_1.1.4                 AnnotationFilter_1.34.0
## [105] pcaMethods_2.2.0            gtable_0.3.6
## [107] sass_0.4.10                 digest_0.6.37
## [109] BiocGenerics_0.56.0         SparseArray_1.10.0
## [111] htmlwidgets_1.6.4           farver_2.1.2
## [113] htmltools_0.5.8.1           lifecycle_1.0.4
## [115] httr_1.4.7                  mime_0.13
## [117] statmod_1.5.1               ggExtra_0.11.0
## [119] MASS_7.3-65
```