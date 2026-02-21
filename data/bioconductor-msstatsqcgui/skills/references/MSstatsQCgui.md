# MSstatsQCgui: A shiny app for longitudinal quality monitoring for proteomic experiments

#### Eralp DOGU eralp.dogu@gmail.com

#### Sara TAHERI srtaheri66@gmail.com

#### Olga VITEK o.vitek@neu.edu

#### 2025-10-30

# Introduction

`MSstatsQCgui` translates the modern methods of longitudinal statistical process control, such as simultaneous and time weighted control charts and change point analysis to the context of LC-MS experiments. Details can be found via [MSstatsQC](www.msstats.org/msstatsqc) website and project [github repository](https://github.com/eralpdogu/MSstatsQCgui), and are available for use stand-alone, or for integration with automated pipelines.

This vignette summarizes functionalities in `MSstatsQCgui` package.

The GUI was created using [Shiny](https://shiny.rstudio.com/), a Web Application Framework for R, and uses several packages to provide advanced features that can enhance Shiny apps, such as [shinyjs](https://github.com/daattali/shinyjs). A running version of the GUI is found in [MSstatsQCgui](https://eralpdogu.shinyapps.io/msstatsqc/)

## Installation

To install the package from the [Bioconductor repository](http://bioconductor.org/packages/MSstatsQCGUI/) please use the following code.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MSstatsQCgui")
```

To install the development version of the package via GitHub:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
deps <- c("devtools")
BiocManager::install("devtools", dependencies = TRUE)
devtools::install_github("eralpdogu/MSstatsQCgui")
```

## Quick start

The following commands should be used to start the graphical user interface.

```
library(MSstatsQCgui)
RunMSstatsQC()
```

## Input

In order to analyze quality control data in `MSstatsQCgui`, input data must be a .csv file in a “long” format with related columns. This is a common data format that can be generated from spectral processing tools such as Skyline and Panorama AutoQC.

The recommended format includes `Acquired Time`, `Peptide name`, `Annotations` and data for any QC metrics such as `Retention Time`, `Total Peak Area` and `Mass Accuracy` etc. Each input file should include `Acquired Time`, `Peptide name` and `Annotations`. After the `Annotations` column user can parse any metric of interest with a proper column name. `MSstatsQCgui` can analyze 20 metrics simultaneously.

1. `AcquiredTime`: This column shows the acquired time of the QC/SST sample in the format of MM/DD/YYYY HH:MM:SS AM/PM. European date parser is also accepted.
2. `Precursor`: This column shows information about Precursor id. Statistical analysis will be done separately for each unique label in this column.
3. `Annotations`: Annotations are free-text information given by the analyst about each run. They can be informative explanations of any special cause or any observations related to a particular run. Annotations are carried in the plots provided by `MSstatsQC` interactively.

(d)-(f) `RetentionTime`, `TotalPeakArea`, `FWHM`, `MassAccuracy`, and `PeakAssymetry`, and other metrics: These columns define a *feature* of a peak for a specific peptide.

Example dataset was generated during CPTAC Study 9.1 at Site 54. Although the example focus on targeted proteomics, the statistical methods more generally apply. Each row corresponds to a single time point.

## Data import

`Data import` tab is used to import data. User can also run the app with sample data and clear the outputs with the clear button.

* `Run with sample data` : Click to run MSstatsQC with sample data from CPTAC Study 9.1.
* `Clear data and plots` : Click to clear all data and plots.

See [Input Example](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/1.input_example.png)

## Data process

`Data import` tab automatically checks data and validate it for further use.

## Options

`Options` tab is used to set metrics and peptides of interest. Guide set and known mean and standard deviation are also set within “Options” tab. User should select a proper and representative guide set using `Options` tab. The lower bound of guide set indicates the index of the first time point to be included in the guide set. For example, if you choose “1” as a lower bound, it means that first time point will be the first element of the guide set. Similarly, upper bound of guide set shows the index for the last observation. It is possible to use different guide sets for different metrics and peptides.

See [MSstatsQC Option Tab](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/2.options_example.png)

## Control charts and change point analysis

`Control charts` tab is used to construct X and mR and CUSUMm and CUSUMv control charts.

See [XmR Chart Tab](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/3.XmRChartTAA.png)

See [CUSUMm and CUSUMv Charts Tab](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/4.CUSUMforTAA.png)

See [Change Point Estimation Tab](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/5.CPforTAA.png)

## Summary functions: river and radar plots

Summary plots are available in the `Metric summary` tab under `Detailed performance: plot summaries`.

See [Plot Summaries Output](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/6.RiverRadar.png)

See [Input Example for Desicision Map](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/7.DecisionInput.png)

See [Decision Map Output](https://github.com/eralpdogu/MSstatsQC/blob/master/vignettes/8.Decisionmaps.png)

## Output

Plots created by the core plot functions are generated by [plotly](https://plot.ly/r/) which is an R package for interactive plot generation. Each output generated by ‘plotly’ can be saved using the “plotly” toolset.

## Project website

Please use [MSstats.org/MSstatsQC](https://www.MSstats.org/MSstatsQC) and [github repository](https://github.com/eralpdogu/MSstatsQCgui) for further details about this tool.

## Question and issues

Please use [Google group](https://groups.google.com/forum/#!forum/msstatsqc) if you want to file bug reports or feature requests.

## Citation

Please cite MSstatsQCGUI:

* Dogu E, Mohammed-Taheri S, Vitek O. “MSstatsQCgui: A Graphical User Interface to analyze quality control data for proteomic experiments.”Work in progress.

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
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
##  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
## [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
## [17] yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```