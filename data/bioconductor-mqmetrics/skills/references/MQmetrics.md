# MQmetrics

#### Alvaro Sanchez-Villalba

# Overview

The package MQmetrics (MaxQuant metrics) provides a workflow to analyze the quality and reproducibility of your proteomics mass spectrometry analysis from MaxQuant. Input data are extracted from several [MaxQuant](https://pubmed.ncbi.nlm.nih.gov/27809316/) output tables, and produces a pdf report. It includes several visualization tools to check numerous parameters regarding the quality of the runs. It also includes two functions to visualize the [iRT peptides from Biognosys](https://biognosys.com/product/irt-kit/) in case they were spiked in the samples.

# Workflow

## Install the package

You can install MQmetrics from Biocodunctor with:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

BiocManager::install("MQmetrics")
```

You can install the development version from [GitHub](https://github.com/svalvaro/) with:

```
# install.packages("devtools")
devtools::install_github("svalvaro/MQmetrics")
```

# Data Input

After your MaxQuant run has finished, a folder named **combined** has been created. This folder should have at least two other folders within:

../combined/txt/ Containing all the tables.txt ../combined/proc/ Containing #runningTimes.txt

You just need the path to the **combined** folder and you will be able to start using MQmetrics.

```
MQPathCombined <- '/home/alvaro/Documents/MaxQuant/example5/combined/'
```

## Generate a report

First you need to load the library.

```
library(MQmetrics)
```

Then you just need to use the **generateReport()** function. This function has parameters to control each of the function that it aggregates. You can read more about those parameters by using:

```
?generateReport
```

Though, the most important parameters are the following:

```
generateReport(MQPathCombined = , # directory to the combined folder
output_dir = , # directory to store the resulting pdf
long_names = , # If your samples have long names set it to TRUE
sep_names = , # Indicate the separator of those long names
UniprotID = , # Introduce the UniprotID of a protein of interest
intensity_type = ,) # Intensity or LFQ

# The only mandatory parameter is MQPathCombined, the rest are optional.
```

Is as simple as this to use MQmetrics:

```
# If you're using a Unix-like OS use forward slashes.
MQPathCombined <- '/home/alvaro/Documents/MaxQuant/example5/'

# If you're using Windows use backslashes:
MQPathCombined <- "D:\Documents\MaxQuant_results\example5\combined\ "

#Use the generateReport function.
generateReport(MQPathCombined)
```

## Visualization plots

If you are only interested in a few plots from the **generateReport()** function, you can do it. You only need to have access to each file independently.

### Load the data

MQmetrics requires 8 tables from the MaxQuant analysis and the #runningTimes file. If you want to learn more about the information of each of these tables, you can do so in the [MaxQuant Summer School videos](https://www.youtube.com/watch?v=wEIWRFKlzJ0).

```
# To create the vignettes and examples I use data that is in the package itself:
MQPathCombined <- system.file('extdata/combined/', package = 'MQmetrics')

# make_MQCombined will read the tables needed for creating the outputs.
MQCombined <- make_MQCombined(MQPathCombined, remove_contaminants = TRUE)
```

### MaxQuant Analysis Parameters

```
MaxQuantAnalysisInfo(MQCombined)
[1] "The MaxQuant output directory is: /tmp/RtmpL2BF5S/Rinst963573033bef8/MQmetrics/extdata/combined/"
[1] "The experiment started the day: 16/04/2021 at the time: 18:07:23."
[1] "The whole experiment lasted: 02:15 (hours:minutes)."
[1] "The MaxQuant version used was: 1.6.17.0"
[1] "The user was: thomas.stehrer"
[1] "The machine name was: FGU045PC004"
[1] "The PSM FDR was: 0.01"
[1] "The protein FDR was: 0.01"
[1] "The match between runs was: "
[1] "The fasta file used was: C:\\MaxQuant_Databases\\iRT_peptides_Biognosys_irtfusion.fasta;C:\\MaxQuant_Databases\\UP000005640_9606.fasta"
[1] "The iBAQ presence is: False"
[1] "The PTM selected is/are: Oxidation (M);Acetyl (Protein N-term)"
```

### Visualizations.

The function **PlotProteinsIdentified()**, will take as input the proteinGroups.txt table and show the number of proteins and NAs in each sample. It can differentiate two types of intensities: ‘Intensity’ or ‘LFQ’.

```
PlotProteinsIdentified(MQCombined,
long_names = TRUE,
sep_names = '_',
intensity_type = 'LFQ',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotPeptidesIdentified()**, will take as input the summary table and show the number of peptides sequences identified in each sample.

```
PlotPeptidesIdentified(MQCombined,
long_names = TRUE,
sep_names = '_',
palette = 'Set3')
```

![](data:image/png;base64...)

The function **PlotIdentificationRatio()**, will take as input the summary and proteinGroups tables and plot the number of protein found vs the ratio of peptides/proteins found in each Experiment.

```
PlotProteinPeptideRatio(MQCombined,
intensity_type = 'LFQ',
long_names = TRUE,
sep_names =  '_')
```

![](data:image/png;base64...)

The function **PlotMsMs()**, will take as input the summary.txt table and show the number of MS/MS Submitted and identified in each sample.

```
PlotMsMs(MQCombined,
long_names = TRUE,
sep_names = '_',
position_dodge_width = 1,
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotPeaks()**, will take as input the summary.txt table and show the number peaks detected and sequenced in each sample.

```
PlotPeaks(MQCombined,
long_names = TRUE,
sep_names = '_',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotIsotopePattern()**,will take as input the summary.txt table and show the number isotope patterns detected and sequenced in each sample.

```
PlotIsotopePattern(MQCombined,
long_names = TRUE,
sep_names = '_',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotCharge()**, will take as input the evidence.txt table and show the charge-state of the precursor ion in each sample.

```
PlotCharge(MQCombined,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotProteaseSpecificity()**, will take as input the summary.txt table and show the number peaks detected and sequenced in each sample.

```
PlotProteaseSpecificity(MQCombined,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotHydrophobicity()**, takes as input the peptides.txt table and returns the distribution of GRAVY score.

```
PlotHydrophobicity(MQCombined,
show_median =  TRUE,
binwidth = 0.1,
size_median = 1.5,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotAndromedaScore()**, takes as input the peptides.txt table and returns the distribution of MaxQuant’s Andromeda Score.

```
PlotAndromedaScore(MQCombined,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotIdentificationType()**, takes as input the peptides.txt and proteinGroups.txt tables and returns the number of peptides and proteins identified by Matching Between Runs or by MS/MS.

```
PlotIdentificationType(MQCombined,
long_names = TRUE,
sep_names = '_',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotIntensity()**, takes as input the proteinGroups.txt table and returns a violin plot for those intensities. If the ‘LFQ’ intensities are in the proteinGroups.txt table, it will by default split the violion into "LFQ’ and ‘Intensity’. The parameter split\_violin\_intensity, can be set to FALSE and then select wether you would like to visualize the ‘Intensity’ or ‘LFQ’ intensity individually. If split\_violin\_intensity is set TRUE, but no LFQ intensities are not present, it will automatically show the normal Intensities.

```
PlotIntensity(MQCombined,
split_violin_intensity = TRUE,
intensity_type = 'LFQ',
log_base = 2,
long_names = TRUE,
sep_names = '_',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotPCA()** takes as input the proteinGroups.txt table and creates a Principal Componente Analysis plot of each Experiment.

```
PlotPCA(MQCombined,
intensity_type = 'LFQ',
palette = 'Set2')
```

![](data:image/png;base64...)

The function **PlotCombinedDynamicRange()** takes as input the proteinGroups.txt table and returns the dynamic range of all experiments combined. If the parameter show\_shade is used, a square will appear showing the percent\_proteins selected and the orders of abundance.

```
PlotCombinedDynamicRange(MQCombined,
show_shade = TRUE,
percent_proteins = 0.90)
```

![](data:image/png;base64...)

The function **PlotAllDynamicRange()** takes as input the proteinGroups.txt table and returns the dynamic range of all experiments separated. If the parameter show\_shade is used, a square will appear showing the percent\_proteins selected and the orders of abundance.

```
PlotAllDynamicRange(MQCombined,
show_shade = TRUE,
percent_proteins = 0.90)
```

![](data:image/png;base64...)

The function **PlotProteinOverlap()** takes as input the proteinGroups.txt table and returns a plot that shows the number of proteins identified in the samples.

```
PlotProteinOverlap(MQCombined)
```

![](data:image/png;base64...)

The function **PlotProteinCoverage()** takes as input the peptides.txt and proteinGroups.txt tables and a protein Uniprot ID. It shows, if present, the coverage of that protein in each of the samples.

```
PlotProteinCoverage(MQCombined,
UniprotID = "P55072",
log_base = 2,
segment_width = 1,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotiRT()** takes as input the evidence.txt table and returns, if found the iRT peptides from Biognosys. Their retention time and intensity.

```
PlotiRT(MQCombined,
show_calibrated_rt = FALSE,
tolerance = 0.001)
```

![](data:image/png;base64...)

The function **PlotiRTScore()** takes as input the evidence.txt table and returns, if found, a linear regression of the retention times of the iRT peptides of Biognosys.

```
PlotiRTScore(MQCombined,
tolerance = 0.001)
```

![](data:image/png;base64...)

The function **PlotTotalIonCurrent()** takes as input the msmsScans.txt, and returns a plot showing the TIC values vs the retention time of each sample. It can show as well the maximum value of each sample.

```
PlotTotalIonCurrent(MQCombined,
show_max_value = TRUE,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotAcquisitionCycle** takes as input the msScans.txt table and returns the cycle time and MS/MS count vs the retention time of each sample.

```
PlotAcquisitionCycle(MQCombined,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

The function **PlotPTM()**, takes as input the modificationSpecificPeptides.txt table and returns the main modifications found at the peptide level. The parameters can be adjusted to select the minimun number of peptides modified per group, and whether or not you would like to visualize the Unmodified peptides.

```
PlotPTM(MQCombined,
peptides_modified = 1,
plot_unmodified_peptides = FALSE,
palette = 'Set2',
plots_per_page = 6)
```

![](data:image/png;base64...)

### Helper Functions

This package provides two extra functions to helps to analyze the proteomics data from MaxQuant:

The function **make\_MQCombined()** takes as input the path to the *combined* folder resulting from MaxQuant analysis. It will read the tables needed and by default remove the potential contaminants, Reverse, and proteins identified only by site.

The function **ReportTables()** takes as input the path to the **combined** folder, and returns tables with information needed to create some of the most important plots in this package.

```
ReportTables(MQCombined,
log_base = 2,
intensity_type = 'Intensity')
#> $proteins
#>         Experiment Proteins Identified Missing values Potential contaminants
#> 1 Combined Samples                4751           <NA>                    100
#> 2      QC02_210326                4456            295                     91
#> 3      QC02_210331                4358            393                     92
#> 4      QC02_210402                4380            371                     94
#> 5      QC02_210406                4478            273                     92
#> 6      QC02_210410                4404            347                     94
#> 7      QC02_210411                4553            198                     93
#>   Reverse Only identified by site Peptide Sequences Identified
#> 1      66                      70                        47126
#> 2      43                      33                        29292
#> 3      38                      24                        30920
#> 4      42                      36                        27603
#> 5      49                      35                        30341
#> 6      47                      30                        31110
#> 7      47                      37                        32170
#>   Peptides/Proteins
#> 1               9.9
#> 2               6.6
#> 3               7.1
#> 4               6.3
#> 5               6.8
#> 6               7.1
#> 7               7.1
#>
#> $intensities
#>    Experiment  mean    sd median   min   max    n
#> 1 QC02_210326 27.42 29.61  24.43 17.95 34.67 4456
#> 2 QC02_210331 27.67 29.84  24.65 18.15 34.79 4358
#> 3 QC02_210402 27.26 29.45  24.25 16.69 34.44 4380
#> 4 QC02_210406 28.49 30.68  25.50 17.83 35.71 4478
#> 5 QC02_210410 28.28 30.54  25.20 18.24 35.48 4404
#> 6 QC02_210411 28.42 30.65  25.36 16.75 35.68 4553
#>
#> $charge
#>    Experiment   1    2    3   4   5   6
#> 1 QC02_210326 0.0 61.7 35.1 2.9 0.2 0.0
#> 2 QC02_210331 0.2 62.2 34.3 3.0 0.2 0.1
#> 3 QC02_210402 0.0 63.2 34.1 2.7 0.0 0.0
#> 4 QC02_210406 0.2 63.0 34.2 2.5 0.0 0.0
#> 5 QC02_210410 0.0 61.2 35.1 3.6 0.0 0.0
#> 6 QC02_210411 0.1 59.1 37.9 2.9 0.0 0.0
#>
#> $GRAVY
#> # A tibble: 6 x 5
#>   Experiment  Mean  Max   Min   Median
#>   <chr>       <chr> <chr> <chr> <chr>
#> 1 QC02_210326 -0.22 2.24  -2.69 -0.18
#> 2 QC02_210331 -0.25 2.24  -2.69 -0.22
#> 3 QC02_210402 -0.23 2.24  -2.69 -0.2
#> 4 QC02_210406 -0.2  2.24  -2.69 -0.17
#> 5 QC02_210410 -0.24 2.24  -2.69 -0.23
#> 6 QC02_210411 -0.21 2.24  -2.69 -0.18
#>
#> $cleavages
#> # A tibble: 6 x 4
#> # Groups:   Experiment [6]
#>   Experiment       `0`   `1`   `2`
#>   <chr>          <dbl> <dbl> <dbl>
#> 1 " QC02_210326"  2300   304    14
#> 2 " QC02_210331"  2153   282    10
#> 3 " QC02_210402"  2151   265     8
#> 4 " QC02_210406"  2355   309    15
#> 5 " QC02_210410"  2203   324    12
#> 6 " QC02_210411"  2489   330    17
#>
#> $overlap
#> # A tibble: 6 x 2
#>   samples  Freq
#>     <dbl> <int>
#> 1       1    47
#> 2       2    55
#> 3       3    97
#> 4       4   141
#> 5       5   308
#> 6       6  3890
```

### Session Info

```
sessionInfo()
#> R version 4.1.0 (2021-05-18)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.2 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] MQmetrics_1.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.0         tidyr_1.1.3        jsonlite_1.7.2     splines_4.1.0
#>  [5] carData_3.0-4      bslib_0.2.5.1      assertthat_0.2.1   highr_0.9
#>  [9] cellranger_1.1.0   yaml_2.2.1         pillar_1.6.1       backports_1.2.1
#> [13] lattice_0.20-44    glue_1.4.2         chron_2.3-56       digest_0.6.27
#> [17] RColorBrewer_1.1-2 ggsignif_0.6.1     polyclip_1.10-0    colorspace_2.0-1
#> [21] Matrix_1.3-3       cowplot_1.1.1      htmltools_0.5.1.1  plyr_1.8.6
#> [25] pkgconfig_2.0.3    broom_0.7.6        haven_2.4.1        purrr_0.3.4
#> [29] scales_1.1.1       tweenr_1.0.2       openxlsx_4.2.3     rio_0.5.26
#> [33] ggforce_0.3.3      tibble_3.1.2       mgcv_1.8-35        generics_0.1.0
#> [37] farver_2.1.0       car_3.0-10         ggplot2_3.3.3      ellipsis_0.3.2
#> [41] ggpubr_0.4.0       cli_2.5.0          magrittr_2.0.1     crayon_1.4.1
#> [45] readxl_1.3.1       evaluate_0.14      ps_1.6.0           fansi_0.4.2
#> [49] nlme_3.1-152       MASS_7.3-54        rstatix_0.7.0      forcats_0.5.1
#> [53] foreign_0.8-81     tools_4.1.0        data.table_1.14.0  hms_1.1.0
#> [57] lifecycle_1.0.0    stringr_1.4.0      munsell_0.5.0      zip_2.1.1
#> [61] compiler_4.1.0     jquerylib_0.1.4    rlang_0.4.11       grid_4.1.0
#> [65] ggridges_0.5.3     rstudioapi_0.13    labeling_0.4.2     rmarkdown_2.8
#> [69] gtable_0.3.0       abind_1.4-5        DBI_1.1.1          curl_4.3.1
#> [73] polynom_1.4-0      reshape2_1.4.4     R6_2.5.0           gridExtra_2.3
#> [77] knitr_1.33         dplyr_1.0.6        utf8_1.2.1         readr_1.4.0
#> [81] stringi_1.6.2      Rcpp_1.0.6         vctrs_0.3.8        tidyselect_1.1.1
#> [85] xfun_0.23
```