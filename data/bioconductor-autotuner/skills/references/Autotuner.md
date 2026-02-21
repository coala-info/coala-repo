# Intro to AutoTuner

#### Craig McLean

#### August 1, 2019

* [Introduction](#introduction)
* [Installation](#installation)
  + [Dev Version](#dev-version)
  + [Bioconductor Release](#bioconductor-release)
* [Autotuner](#autotuner)
  + [Set Up](#set-up)
    - [Input - Raw Data](#input---raw-data)
    - [Input - Metadata](#input---metadata)
  + [Creating AutoTuner Object](#creating-autotuner-object)
  + [Part 1:](#part-1)
    - [Sliding Window Analysis](#sliding-window-analysis)
    - [Checking Peak Estimates](#checking-peak-estimates)
  + [Part 2:](#part-2)
  + [Part 3:](#part-3)
* [Session Info](#session-info)

# Introduction

AutoTuner is a parameter tuning algorithm for XCMS, MZmine2, and other metabolomics data processing softwares. Using statistical inference, AutoTuner quickly finds estimates for nine distinct parameters. This guide provides an interactive example of how to use AutoTuner.

# Installation

## Dev Version

Currently, AutoTuner is being distributed through my github acount [here]: github.com/crmclean/Autotuner

The easiest way to download that package is by using the install\_github command from the devtools package as illustrated below.

```
devtools::install_github("crmclean/Autotuner")
```

## Bioconductor Release

Hopefully the package will be available through bioconductor in the near future. Once this occurs, the package may be downloaded by running the following code.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Autotuner")
```

# Autotuner

This tutorial uses additional data from the package, mtbls2 This second package contains raw untargeted metabolomics data, and may be downloaded from bioconductor in a manner as the BioC installation for Autotuner.

```
library(Autotuner)
#>      ____________________________________________________________
#>     / __  / / / /__  __/ _   /__  __/ / / /\     / / ____/ __   /
#>    / / / / / / /  / / / / / /  / / / / / /  \   / / /___/ /_/  /
#>   / /_/ / / / /  / / / / / /  / / / / / / /\ \ / / ____/  _   \
#>  / __  / /_/ /  / / / /_/ /  / / / /_/ / /  \   /  /__/  / /  /
#> /_/ /_/_____/  /_/ /_____/  /_/ /_____/_/    \ /_____/__/ /__/   v.1.0.1
#> https://github.com/crmclean/autotuner
library(mtbls2)
```

## Set Up

### Input - Raw Data

AutoTuner is designed to work directly with raw mass spectral data that has been processed by using MSconvert. So far file types .mzML, .mzXML, .msData, and .netCDF have been tested and confirmed to work.

```
rawPaths <- c(
    system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData",
                             package = "mtbls2"),
system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData",
            package = "mtbls2"),
system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData",
            package = "mtbls2"))

if(!all(file.exists(rawPaths))) {
    stop("Not all files matched here exist.")
}
```

Here are the filetypes that will be used within this tutorial:

```
print(basename(rawPaths))
#> [1] "MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData"
#> [2] "MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData"
#> [3] "MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData"
```

Here are what the paths look like that I am entering into AutoTuner directly:

```
print(rawPaths)
#> [1] "/home/biocbuild/bbs-3.10-bioc/R/library/mtbls2/mzData/MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData"
#> [2] "/home/biocbuild/bbs-3.10-bioc/R/library/mtbls2/mzData/MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData"
#> [3] "/home/biocbuild/bbs-3.10-bioc/R/library/mtbls2/mzData/MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData"
```

### Input - Metadata

AutoTuner also requires a metadata file that has at least two columns in order to derive estimates. One column should contain string matches to all the raw data files that will be processed (see above for an example). The second should contain information on the experimental factor each sample belongs to.

```
metadata <- read.table(system.file(
    "a_mtbl2_metabolite_profiling_mass_spectrometry.txt",
    package = "mtbls2"), header = TRUE, stringsAsFactors = FALSE)

metadata <- metadata[sub("mzData/", "", metadata$Raw.Spectral.Data.File) %in%
                         basename(rawPaths),]
```

This is what the metadata file should look like. In our case, the column matching the raw data files is called “File.Name”, while the one with experimental factor information is called “Sample.Type”.

```
print(metadata)
#>           Sample.Name Protocol.REF   Parameter.Value.Post.Extraction.
#> 13 Ex2-cyp79-48h-Ag-1   Extraction 200 µL methanol/water, 30/70 (v/v)
#> 14 Ex2-cyp79-48h-Ag-2   Extraction 200 µL methanol/water, 30/70 (v/v)
#> 16 Ex2-cyp79-48h-Ag-4   Extraction 200 µL methanol/water, 30/70 (v/v)
#>    Parameter.Value.Derivatization.       Extract.Name Protocol.REF.1
#> 13                            none Ex2-cyp79-48h-Ag-1 Chromatography
#> 14                            none Ex2-cyp79-48h-Ag-2 Chromatography
#> 16                            none Ex2-cyp79-48h-Ag-4 Chromatography
#>    Parameter.Value.Chromatography.Instrument. Term.Source.REF
#> 13    ACQUITY UPLC Systems with 2D Technology              MS
#> 14    ACQUITY UPLC Systems with 2D Technology              MS
#> 16    ACQUITY UPLC Systems with 2D Technology              MS
#>    Term.Accession.Number Parameter.Value.Column.type.
#> 13               1001765                       HSS T3
#> 14               1001765                       HSS T3
#> 16               1001765                       HSS T3
#>    Parameter.Value.Chromatogram.Name. Term.Source.REF.1 Term.Accession.Number.1
#> 13                                N/A                NA                      NA
#> 14                                N/A                NA                      NA
#> 16                                N/A                NA                      NA
#>       Protocol.REF.2 Parameter.Value.instrument. Term.Source.REF.2
#> 13 Mass spectrometry                  micrOTOF-Q                MS
#> 14 Mass spectrometry                  micrOTOF-Q                MS
#> 16 Mass spectrometry                  micrOTOF-Q                MS
#>    Term.Accession.Number.2 Parameter.Value.ion.source. Term.Source.REF.3
#> 13                      NA                         ESI                MS
#> 14                      NA                         ESI                MS
#> 16                      NA                         ESI                MS
#>    Term.Accession.Number.3 Parameter.Value.analyzer. Term.Source.REF.4
#> 13                 1000073            time-of-flight                MS
#> 14                 1000073            time-of-flight                MS
#> 16                 1000073            time-of-flight                MS
#>    Term.Accession.Number.4                    MS.Assay.Name
#> 13                 1000084 Ex2-cyp79-48h-Ag-1_1-B,3_01_9828
#> 14                 1000084 Ex2-cyp79-48h-Ag-2_1-B,4_01_9830
#> 16                 1000084 Ex2-cyp79-48h-Ag-4_1-B,4_01_9834
#>                                  Raw.Spectral.Data.File     Protocol.REF.3
#> 13 mzData/MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData Data normalization
#> 14 mzData/MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData Data normalization
#> 16 mzData/MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData Data normalization
#>    Normalization.Name      Protocol.REF.4 Data.Transformation.Name
#> 13                N/A Data transformation                      N/A
#> 14                N/A Data transformation                      N/A
#> 16                N/A Data transformation                      N/A
#>    Derived.Spectral.Data.File
#> 13                         NA
#> 14                         NA
#> 16                         NA
#>                                Metabolite.Assignment.File
#> 13 a_mtbl2_metabolite_profiling_mass_spectrometry_maf.csv
#> 14 a_mtbl2_metabolite_profiling_mass_spectrometry_maf.csv
#> 16 a_mtbl2_metabolite_profiling_mass_spectrometry_maf.csv
#>    Factor.Value.genotype. Term.Source.REF.5 Term.Accession.Number.5
#> 13                  cyp79                NA                      NA
#> 14                  cyp79                NA                      NA
#> 16                  cyp79                NA                      NA
#>    Factor.Value.replicate. Term.Source.REF.6 Term.Accession.Number.6
#> 13                    Exp2                NA                      NA
#> 14                    Exp2                NA                      NA
#> 16                    Exp2                NA                      NA
```

## Creating AutoTuner Object

AutoTuner first requires that user create an AutoTuner object. All future computations will be contained within this object.

The file\_col argument corresponds to the string column of the metadata that matches raw data samples by name. The factorCol argument corresponds to the specific factor column.

```
Autotuner <- createAutotuner(rawPaths,
                             metadata,
                             file_col = "Raw.Spectral.Data.File",
                             factorCol = "Factor.Value.genotype.")
#> ~~~ Autotuner: Initializator ~~~
#> ~~~ Parsing Raw Data into R ~~~
#> ~~~ Extracting the Raw Data from Individual Samples ~~~
#> No TIC data was found.
#> Using integrated intensity data instead.
#> ~~~ Storing Everything in Autotuner Object ~~~
#> ~~~ The Autotuner Object has been Created ~~~
```

## Part 1:

**Total Ion Current Peak Identification**

The first part of AutoTuner involves the identification of peaks within the total ion current (TIC) of the samples loaded up into AutoTuner. These regions will be important later to estimate parameters from the raw data since AutoTuner assumes that they contain a greater number of real chemical measurements.

### Sliding Window Analysis

To do this, the user peforms a sliding window analysis. A sliding window analysis is a simple time series analysis algorithm used to identify peaks within a time trace. The window is essentially using a moving average. From this, the algorithm asks whether the next observation to the right of the average is a peak. More on sliding window analyses can be found [here](https://en.wikipedia.org/wiki/Moving_average).

The aim here is to identify TIC peaks. The user should prioritize finding where peaks *start* rather than caturing the entire peak bound. Downstream steps actually do a better job of estimating what the proper peak bounds should be.

The user should play with the lag, threshold, and influence parameters to perform the sliding window analysis. Here is what they represent relative to chromatography:

Lag - The number of chromatographic scan points used to test if next point is significance (ie the size number of points making up the moving average).

Threshold - A numerical constant representing how many times greater the intensity of an adjacent scan has to be from the scans in the sliding window to be considered significant.

Influence - A numerical factor used to scale the magnitude of a significant scan once it has been added to the sliding window.

```
lag <- 25
threshold<- 3.1
influence <- 0.1
signals <- lapply(getAutoIntensity(Autotuner),
                 ThresholdingAlgo, lag, threshold, influence)
```

The output of the sliding window can be displayed with the plot\_signals function:

```
plot_signals(Autotuner,
             threshold,
             ## index for which data files should be displayed
             sample_index = 1:3,
             signals = signals)
```

![](data:image/png;base64...)

```
rm(lag, influence, threshold)
```

#### Interpreting Sliding Window Results

The figure above has two components:

1. Top Plot: The chromatotgraphic trace for each sample (solid line) along with the noise associated with each sample (dashed line).
2. Bottom Plot: A signal plot used to indicate which chromatographic regions have peaks.

The user should look for combinations of the three sliding window parameters that returns many narrow peaks within the signal plot. See the example above.

Autotuner will expand each of these regions to obtain improved estimates on the bounds within the isolatePeaks function below. The return\_peaks arguement there represents the number of peaks to return from all detected TIC peaks for parameter estimation. This number is bounded by the total number of detected peaks by the sliding windown analysis above, so seeing more narrow peaks within the signal plot is recommended.

```
Autotuner <- isolatePeaks(Autotuner = Autotuner,
                          returned_peaks = 10,
                          signals = signals)
```

### Checking Peak Estimates

The peaks with expanded bounds returned from the isolatePeaks function can be rapidly checked visually using the plot\_peaks function as shown below. The bounds should capture the correct ascention and descention points of each peak. If peak bounds are not satisfactory, the user should return to the sliding window analysis, and try a different conbination of the three parameters.

Remember, this whole process is only designed to isolate regions enriched in real features rather than find true peaks. The bounds don’t need to be completely perfect. Its much more important that the bounds contain some kind of chromatographic peaks rather than less dynamic regions of the chromatographic trace.

```
for(i in 1:5) {
    plot_peaks(Autotuner = Autotuner,
           boundary = 100,
           peak = i)
}
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## Part 2:

**Parameter Extraction from Individual Extracted Ion Chromatograms**

In order to estimate parameters from the raw data, the user should run the EICparams function as below. The massThreshold is an absolute mass error that should be greater than the expected analytical capabilities of the mass analyzer. This part of the analysis might take a few minutes if the data used is large (~ 100 Mb per sample).

If returnPpmPlots is True, AutoTuner will return plots showing how the ppm threshold was estimated within the current working directory running Autotuner. This can be used to evaluate the magnitude of the massThreshold parameter.

```
## error with peak width estimation
## idea - filter things by mass. smaler masses are more likely to be
## random assosications
eicParamEsts <- EICparams(Autotuner = Autotuner,
                          massThresh = .005,
                          verbose = FALSE,
                          returnPpmPlots = FALSE,
                          useGap = TRUE)
#> Currently on sample 1
#> --- Currently on peak: 1
#> --- Currently on peak: 2
#> --- Currently on peak: 3
#> --- Currently on peak: 4
#> --- Currently on peak: 5
#> --- Currently on peak: 6
#> --- Currently on peak: 7
#> --- Currently on peak: 8
#> --- Currently on peak: 9
#> --- Currently on peak: 10
#> Currently on sample 2
#> --- Currently on peak: 1
#> --- Currently on peak: 2
#> --- Currently on peak: 3
#> --- Currently on peak: 4
#> --- Currently on peak: 5
#> --- Currently on peak: 6
#> --- Currently on peak: 7
#> --- Currently on peak: 8
#> --- Currently on peak: 9
#> --- Currently on peak: 10
#> Currently on sample 3
#> --- Currently on peak: 1
#> --- Currently on peak: 2
#> --- Currently on peak: 3
#> --- Currently on peak: 4
#> --- Currently on peak: 5
#> --- Currently on peak: 6
#> --- Currently on peak: 7
#> --- Currently on peak: 8
#> --- Currently on peak: 9
#> --- Currently on peak: 10
```

## Part 3:

**Returning Estimates**

All that remains now is to get what the dataset estimates are.

```
returnParams(eicParamEsts, Autotuner)
#> $eicParams
#>                  Parameters estimates Variability.Measure
#> ppm                     ppm    7.1810              1.6900
#> noise                 noise  300.0000              5.9810
#> preIntensity   preIntensity  572.0000             24.1300
#> preScan             preScan    2.0000              0.0000
#> snThresh           snThresh    3.0030              0.6583
#> Max Peakwidth Max Peakwidth   14.9300              2.3580
#> Min Peakwidth Min Peakwidth    0.6735              0.0000
#>                                                                Measure
#> ppm                            Standard Deviation of all PPM Estimates
#> noise                        Standard Deviation of all noise Estimates
#> preIntensity  Standard Deviation of all prefileter Intensity Estimates
#> preScan                 Standard Deviation of all scan coung Estimates
#> snThresh             Standard Deviation of all s/n threshold Estimates
#> Max Peakwidth       Distance between two highest estimated peak widths
#> Min Peakwidth        Distance between two lowest estimated peak widths
#>
#> $ticParams
#>            descriptions estimates
#> max_width     max_width   11.7840
#> min_width     min_width    6.7320
#> group_diff   group_diff    1.8216
```

There you have it! Running AutoTuner is now complete, and the estimates may be entered directly into XCMS to processes raw untargeted metabolomics data.

# Session Info

```
sessionInfo()
#> R version 3.6.2 (2019-12-12)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#> [1] MSnbase_2.12.0      ProtGenerics_1.18.0 S4Vectors_0.24.3
#> [4] mzR_2.20.0          Rcpp_1.0.3          Biobase_2.46.0
#> [7] BiocGenerics_0.32.0 mtbls2_1.16.0       Autotuner_1.0.1
#>
#> loaded via a namespace (and not attached):
#>  [1] fs_1.3.1               usethis_1.5.1          devtools_2.2.2
#>  [4] doParallel_1.0.15      RColorBrewer_1.1-2     rprojroot_1.3-2
#>  [7] tools_3.6.2            backports_1.1.5        R6_2.4.1
#> [10] affyio_1.56.0          lazyeval_0.2.2         colorspace_1.4-1
#> [13] withr_2.1.2            tidyselect_1.0.0       prettyunits_1.1.1
#> [16] processx_3.4.2         MassSpecWavelet_1.52.0 compiler_3.6.2
#> [19] preprocessCore_1.48.0  cli_2.0.1              desc_1.2.0
#> [22] entropy_1.2.1          scales_1.1.0           DEoptimR_1.0-8
#> [25] robustbase_0.93-5      affy_1.64.0            callr_3.4.2
#> [28] stringr_1.4.0          digest_0.6.25          rmarkdown_2.1
#> [31] pkgconfig_2.0.3        htmltools_0.4.0        sessioninfo_1.1.1
#> [34] limma_3.42.2           rlang_0.4.4            impute_1.60.0
#> [37] farver_2.0.3           mzID_1.24.0            BiocParallel_1.20.1
#> [40] dplyr_0.8.4            magrittr_1.5           MALDIquant_1.19.3
#> [43] Matrix_1.2-18          munsell_0.5.0          fansi_0.4.1
#> [46] lifecycle_0.1.0        vsn_3.54.0             stringi_1.4.6
#> [49] yaml_2.2.1             MASS_7.3-51.5          zlibbioc_1.32.0
#> [52] pkgbuild_1.0.6         plyr_1.8.5             grid_3.6.2
#> [55] crayon_1.3.4           lattice_0.20-40        splines_3.6.2
#> [58] multtest_2.42.0        xcms_3.8.1             knitr_1.28
#> [61] ps_1.3.2               pillar_1.4.3           codetools_0.2-16
#> [64] pkgload_1.0.2          XML_3.99-0.3           glue_1.3.1
#> [67] evaluate_0.14          pcaMethods_1.78.0      remotes_2.1.1
#> [70] BiocManager_1.30.10    vctrs_0.2.3            foreach_1.4.8
#> [73] testthat_2.3.1         gtable_0.3.0           RANN_2.6.1
#> [76] purrr_0.3.3            assertthat_0.2.1       ggplot2_3.2.1
#> [79] xfun_0.12              ncdf4_1.17             survival_3.1-8
#> [82] tibble_2.1.3           iterators_1.0.12       memoise_1.1.0
#> [85] IRanges_2.20.2         cluster_2.1.0          ellipsis_0.3.0
```