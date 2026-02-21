# MSstatsTMTPTM : A package for post translational modification (PTM) significance analysis in shotgun mass spectrometry-based proteomic experiments with tandem mass tag (TMT) labeling

#### Devon Kohler (kohler.d@northeastern.edu)

#### 2021-02-16

```
library(MSstatsTMTPTM)
library(MSstatsTMT)
```

This vignette summarizes the functionalities and options of MSstastTMTPTM and provides a workflow example.

* A set of tools for detecting differentially abundant post translational modifications (PTMs) and proteins in shotgun mass spectrometry-based proteomic experiments with tandem mass tag (TMT) labeling.
* The types of experiment that MSstatsTMTPTM supports for metabolic labeling or iTRAQ experiments. LC-MS, SRM, DIA(SWATH) with label-free or labeled synthetic peptides can be analyzed with other R package, MSstatsPTM and MSstats.

MSstatsTMTPTM includes the following two functions for data visualization and statistical testing:

1. Data visualization of PTM and global protein levels: `dataProcessPlotsTMTPMT`
2. Group comparison on PTM/protein quantification data: `groupComparisonTMTPTM`

## Installation

To install this package, start R (version “4.0”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstatsTMTPTM")
```

## 1. dataProcessPlotsTMTPTM()

To illustrate the quantitative data and quality control of MS runs, dataProcessPlotsTMT takes the quantitative data from MSstatsTMT converter functions as input and generate two types of figures in pdf files as output : 1. Profile plot (specify “ProfilePlot” in option type), to identify the potential sources of variation for each protein; 2. Quality control plot (specify “QCPlot” in option type), to evaluate the systematic bias between MS runs.

### Arguments

* `data.ptm` name of the data with PTM sites in protein name, which can be the output of MSstatsTMT converter functions.
* `data.protein` name of the data with peptide level, which can be the output of MSstatsTMT converter functions.
* `data.ptm.summarization` name of the data with ptm sites in protein-level name , which can be the output of the MSstatsTMT function.
* `data.protein.summarization` name of the data with protein-level, which can be the output of the MSstatsTMT function.
* `type` choice of visualization. “ProfilePlot” represents profile plot of log intensities across MS runs. “QCPlot” represents box plots of log intensities across channels and MS runs.
* `ylimUp` upper limit for y-axis in the log scale. FALSE(Default) for Profile Plot and QC Plot uses the upper limit as rounded off maximum of log2(intensities) after normalization + 3..
* `ylimDown` lower limit for y-axis in the log scale. FALSE(Default) for Profile Plot and QC Plot uses 0..
* `x.axis.size` size of x-axis labeling for “Run” and "channel in Profile Plot and QC Plot.
* `y.axis.size` size of y-axis labels. Default is 10.
* `text.size` size of labels represented each condition at the top of Profile plot and QC plot. Default is 4.
* `text.angle` angle of labels represented each condition at the top of Profile plot and QC plot. Default is 0.
* `legend.size` size of legend above Profile plot. Default is 7.
* `dot.size.profile` size of dots in Profile plot. Default is 2.
* `ncol.guide` number of columns for legends at the top of plot. Default is 5.
* `width` width of the saved pdf file. Default is 10.
* `height` height of the saved pdf file. Default is 10.
* `which.Protein` Protein list to draw plots. List can be names of Proteins or order numbers of Proteins. Default is “all”, which generates all plots for each protein. For QC plot, “allonly” will generate one QC plot with all proteins.
* `originalPlot` TRUE(default) draws original profile plots, without normalization.
* `summaryPlot` TRUE(default) draws profile plots with protein summarization for each channel and MS run.
* `address` the name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of “ProfilePlot.pdf” or “QCplot.pdf”. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

### Example

The raw dataset for both the PTM and Protein datasets are required for the plotting function. This can be the output of the MSstatsTMT converter functions: `PDtoMSstatsTMTFormat`, `SpectroMinetoMSstatsTMTFormat`, and `OpenMStoMSstatsTMTFormat`. Both the PTM and protein datasets must include the following columns: `ProteinName`, `PeptideSequence`, `Charge`, `PSM`, `Mixture`, `TechRepMixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, and `Intensity`.

```
# read in raw data files
# raw.ptm <- read.csv(file="raw.ptm.csv", header=TRUE)
# raw.protein <- read.csv(file="raw.protein.csv", header=TRUE)
head(raw.ptm)
#>       ProteinName PeptideSequence Charge           PSM Mixture TechRepMixture
#> 1 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 2 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 3 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 4 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 5 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 6 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#>   Run Channel   Condition  BioReplicate Intensity
#> 1 1_1    128N Condition_2 Condition_2_1   48030.0
#> 2 1_1    129C Condition_4 Condition_4_2  100224.4
#> 3 1_1    131C Condition_3 Condition_3_2   66804.6
#> 4 1_1    130N Condition_1 Condition_1_2   46779.8
#> 5 1_1    128C Condition_6 Condition_6_1   77497.9
#> 6 1_1    126C Condition_4 Condition_4_1   81559.7
head(raw.protein)
#>   ProteinName PeptideSequence Charge             PSM Mixture TechRepMixture Run
#> 1  Protein_12    Peptide_9121      3  Peptide_9121_3       1              1 1_1
#> 2  Protein_12   Peptide_27963      5 Peptide_27963_5       1              1 1_1
#> 3  Protein_12   Peptide_28482      4 Peptide_28482_4       1              1 1_1
#> 4  Protein_12   Peptide_10940      2 Peptide_10940_2       2              1 2_1
#> 5  Protein_12    Peptide_4900      2  Peptide_4900_2       2              1 2_1
#> 6  Protein_12    Peptide_4900      3  Peptide_4900_3       2              1 2_1
#>   Channel   Condition  BioReplicate  Intensity
#> 1    126C Condition_4 Condition_4_1 10996116.9
#> 2    127C Condition_5 Condition_5_1    56965.1
#> 3    131N Condition_2 Condition_2_2   286121.7
#> 4    131N Condition_2 Condition_2_4   534806.0
#> 5    126C Condition_4 Condition_4_3  1134908.7
#> 6    126C Condition_4 Condition_4_3  1605773.2
```

```
# Run MSstatsTMT proteinSummarization function
quant.msstats.ptm <- proteinSummarization(raw.ptm,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)

quant.msstats.protein <- proteinSummarization(raw.protein,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)
```

```
head(quant.msstats.ptm)
#>   Run          Protein Abundance Channel  BioReplicate   Condition
#> 1 1_1 Protein_1076_Y67  13.65475    130N Condition_1_2 Condition_1
#> 2 1_1 Protein_1076_Y67  13.57146    127N Condition_1_1 Condition_1
#> 3 1_1 Protein_1076_Y67  13.56900    128N Condition_2_1 Condition_2
#> 4 1_1 Protein_1076_Y67  13.70567    131N Condition_2_2 Condition_2
#> 5 1_1 Protein_1076_Y67  13.24717    131C Condition_3_2 Condition_3
#> 6 1_1 Protein_1076_Y67  13.11874    129N Condition_3_1 Condition_3
#>   TechRepMixture Mixture
#> 1              1       1
#> 2              1       1
#> 3              1       1
#> 4              1       1
#> 5              1       1
#> 6              1       1
head(quant.msstats.protein)
#>   Run      Protein Abundance Channel  BioReplicate   Condition TechRepMixture
#> 1 1_1 Protein_1076  18.75131    127N Condition_1_1 Condition_1              1
#> 2 1_1 Protein_1076  18.80198    130N Condition_1_2 Condition_1              1
#> 3 1_1 Protein_1076  18.92222    131N Condition_2_2 Condition_2              1
#> 4 1_1 Protein_1076  19.02252    128N Condition_2_1 Condition_2              1
#> 5 1_1 Protein_1076  18.28685    131C Condition_3_2 Condition_3              1
#> 6 1_1 Protein_1076  18.40555    129N Condition_3_1 Condition_3              1
#>   Mixture
#> 1       1
#> 2       1
#> 3       1
#> 4       1
#> 5       1
#> 6       1

# Profile Plot
dataProcessPlotsTMTPTM(data.ptm=raw.ptm,
                    data.protein=raw.protein,
                    data.ptm.summarization=quant.msstats.ptm,
                    data.protein.summarization=quant.msstats.protein,
                    type='ProfilePlot'
                    )
#> Warning: Removed 275 rows containing missing values (geom_point).
#> Warning: Removed 275 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_12_S703 ( 1  of  89 )
#> Drew the Profile plot for  Protein_15_S140 ( 2  of  89 )
#> Drew the Profile plot for  Protein_15_Y137 ( 3  of  89 )
#> Warning: Removed 484 rows containing missing values (geom_point).
#> Warning: Removed 484 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_125_Y343 ( 4  of  89 )
#> Warning: Removed 1045 rows containing missing values (geom_point).
#> Warning: Removed 1045 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_150_S729 ( 5  of  89 )
#> Drew the Profile plot for  Protein_152_S455 ( 6  of  89 )
#> Warning: Removed 121 rows containing missing values (geom_point).
#> Warning: Removed 121 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_191_S679 ( 7  of  89 )
#> Warning: Removed 341 rows containing missing values (geom_point).
#> Warning: Removed 341 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_261_S637 ( 8  of  89 )
#> Warning: Removed 341 rows containing missing values (geom_point).

#> Warning: Removed 341 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_261_S180 ( 9  of  89 )
#> Warning: Removed 341 rows containing missing values (geom_point).

#> Warning: Removed 341 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_261_S182 ( 10  of  89 )
#> Drew the Profile plot for  Protein_320_S198 ( 11  of  89 )
#> Warning: Removed 748 rows containing missing values (geom_point).
#> Warning: Removed 748 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_324_S122 ( 12  of  89 )
#> Warning: Removed 396 rows containing missing values (geom_point).
#> Warning: Removed 396 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_541_S504 ( 13  of  89 )
#> Warning: Removed 121 rows containing missing values (geom_point).
#> Warning: Removed 121 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_843_S295 ( 14  of  89 )
#> Warning: Removed 33 rows containing missing values (geom_point).
#> Warning: Removed 33 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_971_S326 ( 15  of  89 )
#> Drew the Profile plot for  Protein_1076_Y67 ( 16  of  89 )
#> Warning: Removed 132 rows containing missing values (geom_point).
#> Warning: Removed 132 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1145_T915 ( 17  of  89 )
#> Drew the Profile plot for  Protein_1146_S328 ( 18  of  89 )
#> Warning: Removed 154 rows containing missing values (geom_point).
#> Warning: Removed 154 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1160_S188 ( 19  of  89 )
#> Drew the Profile plot for  Protein_1220_Y321 ( 20  of  89 )
#> Warning: Removed 99 rows containing missing values (geom_point).
#> Warning: Removed 99 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1235_S416 ( 21  of  89 )
#> Drew the Profile plot for  Protein_1326_Y182 ( 22  of  89 )
#> Drew the Profile plot for  Protein_1380_Y106 ( 23  of  89 )
#> Drew the Profile plot for  Protein_1547_Y608 ( 24  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1548_Y849 ( 25  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).

#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1548_Y580 ( 26  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).

#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1548_T850 ( 27  of  89 )
#> Warning: Removed 66 rows containing missing values (geom_point).
#> Warning: Removed 66 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1551_S994 ( 28  of  89 )
#> Warning: Removed 99 rows containing missing values (geom_point).
#> Warning: Removed 99 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1584_S71 ( 29  of  89 )
#> Drew the Profile plot for  Protein_1587_Y168 ( 30  of  89 )
#> Warning: Removed 297 rows containing missing values (geom_point).
#> Warning: Removed 297 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1612_S296 ( 31  of  89 )
#> Warning: Removed 231 rows containing missing values (geom_point).
#> Warning: Removed 231 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1616_S203 ( 32  of  89 )
#> Drew the Profile plot for  Protein_1686_T133 ( 33  of  89 )
#> Drew the Profile plot for  Protein_1721_S24 ( 34  of  89 )
#> Warning: Removed 297 rows containing missing values (geom_point).
#> Warning: Removed 297 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1739_S237 ( 35  of  89 )
#> Drew the Profile plot for  Protein_1852_Y342 ( 36  of  89 )
#> Warning: Removed 330 rows containing missing values (geom_point).
#> Warning: Removed 330 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1863_S2029 ( 37  of  89 )
#> Warning: Removed 330 rows containing missing values (geom_point).

#> Warning: Removed 330 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1863_S2030 ( 38  of  89 )
#> Warning: Removed 22 rows containing missing values (geom_point).
#> Warning: Removed 22 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1864_Y207 ( 39  of  89 )
#> Warning: Removed 22 rows containing missing values (geom_point).

#> Warning: Removed 22 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1864_Y50 ( 40  of  89 )
#> Warning: Removed 22 rows containing missing values (geom_point).

#> Warning: Removed 22 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1864_Y409 ( 41  of  89 )
#> Warning: Removed 286 rows containing missing values (geom_point).
#> Warning: Removed 286 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1865_Y153 ( 42  of  89 )
#> Warning: Removed 110 rows containing missing values (geom_point).
#> Warning: Removed 110 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1929_Y323 ( 43  of  89 )
#> Warning: Removed 154 rows containing missing values (geom_point).
#> Warning: Removed 154 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_1945_Y628 ( 44  of  89 )
#> Drew the Profile plot for  Protein_2084_Y44 ( 45  of  89 )
#> Drew the Profile plot for  Protein_2108_Y281 ( 46  of  89 )
#> Drew the Profile plot for  Protein_2207_S674 ( 47  of  89 )
#> Warning: Removed 2956 rows containing missing values (geom_point).
#> Warning: Removed 2956 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2212_S2980 ( 48  of  89 )
#> Drew the Profile plot for  Protein_2215_S568 ( 49  of  89 )
#> Warning: Removed 55 rows containing missing values (geom_point).
#> Warning: Removed 55 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2234_S459 ( 50  of  89 )
#> Warning: Removed 77 rows containing missing values (geom_point).
#> Warning: Removed 77 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2273_Y148 ( 51  of  89 )
#> Warning: Removed 121 rows containing missing values (geom_point).
#> Warning: Removed 121 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2284_Y519 ( 52  of  89 )
#> Warning: Removed 121 rows containing missing values (geom_point).

#> Warning: Removed 121 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2284_Y520 ( 53  of  89 )
#> Drew the Profile plot for  Protein_2297_Y276 ( 54  of  89 )
#> Drew the Profile plot for  Protein_2297_T279 ( 55  of  89 )
#> Warning: Removed 209 rows containing missing values (geom_point).
#> Warning: Removed 209 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2302_Y393 ( 56  of  89 )
#> Warning: Removed 286 rows containing missing values (geom_point).
#> Warning: Removed 286 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2304_S603 ( 57  of  89 )
#> Drew the Profile plot for  Protein_2311_S274 ( 58  of  89 )
#> Warning: Removed 220 rows containing missing values (geom_point).
#> Warning: Removed 220 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2315_S105 ( 59  of  89 )
#> Warning: Removed 352 rows containing missing values (geom_point).
#> Warning: Removed 352 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2353_S394 ( 60  of  89 )
#> Warning: Removed 352 rows containing missing values (geom_point).

#> Warning: Removed 352 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2353_S392 ( 61  of  89 )
#> Warning: Removed 88 rows containing missing values (geom_point).
#> Warning: Removed 88 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2361_S54 ( 62  of  89 )
#> Warning: Removed 88 rows containing missing values (geom_point).

#> Warning: Removed 88 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2361_T53 ( 63  of  89 )
#> Warning: Removed 99 rows containing missing values (geom_point).
#> Warning: Removed 99 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2382_S183 ( 64  of  89 )
#> Drew the Profile plot for  Protein_2391_Y40 ( 65  of  89 )
#> Drew the Profile plot for  Protein_2395_Y306 ( 66  of  89 )
#> Warning: Removed 418 rows containing missing values (geom_point).
#> Warning: Removed 418 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2461_Y250 ( 67  of  89 )
#> Warning: Removed 33 rows containing missing values (geom_point).
#> Warning: Removed 33 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2462_Y332 ( 68  of  89 )
#> Warning: Removed 319 rows containing missing values (geom_point).
#> Warning: Removed 319 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2560_T311 ( 69  of  89 )
#> Warning: Removed 165 rows containing missing values (geom_point).
#> Warning: Removed 165 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2607_S563 ( 70  of  89 )
#> Warning: Removed 44 rows containing missing values (geom_point).
#> Warning: Removed 44 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2697_Y698 ( 71  of  89 )
#> Warning: Removed 1111 rows containing missing values (geom_point).
#> Warning: Removed 1111 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2701_S1106 ( 72  of  89 )
#> Warning: Removed 55 rows containing missing values (geom_point).
#> Warning: Removed 55 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2874_Y59 ( 73  of  89 )
#> Warning: Removed 220 rows containing missing values (geom_point).
#> Warning: Removed 220 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2992_Y118 ( 74  of  89 )
#> Warning: Removed 132 rows containing missing values (geom_point).
#> Warning: Removed 132 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_3027_S111 ( 75  of  89 )
#> Warning: Removed 154 rows containing missing values (geom_point).
#> Warning: Removed 154 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_3273_S518 ( 76  of  89 )
#> Drew the Profile plot for  Protein_3486_Y505 ( 77  of  89 )
#> Warning: Removed 330 rows containing missing values (geom_point).
#> Warning: Removed 330 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_3659_S1625 ( 78  of  89 )
#> Warning: Removed 88 rows containing missing values (geom_point).
#> Warning: Removed 88 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4093_S435 ( 79  of  89 )
#> Warning: Removed 1011 rows containing missing values (geom_point).
#> Warning: Removed 1011 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4277_T269 ( 80  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4307_S212 ( 81  of  89 )
#> Warning: Removed 209 rows containing missing values (geom_point).
#> Warning: Removed 209 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4338_S523 ( 82  of  89 )
#> Drew the Profile plot for  Protein_4475_Y98 ( 83  of  89 )
#> Warning: Removed 1276 rows containing missing values (geom_point).
#> Warning: Removed 1276 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4494_S1128 ( 84  of  89 )
#> Warning: Removed 1177 rows containing missing values (geom_point).
#> Warning: Removed 1177 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4668_T682 ( 85  of  89 )
#> Warning: Removed 99 rows containing missing values (geom_point).
#> Warning: Removed 99 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2072_Y89 ( 86  of  89 )
#> Warning: Removed 44 rows containing missing values (geom_point).
#> Warning: Removed 44 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_2264_Y64 ( 87  of  89 )
#> Warning: Removed 132 rows containing missing values (geom_point).
#> Warning: Removed 132 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4671_S237 ( 88  of  89 )
#> Warning: Removed 132 rows containing missing values (geom_point).

#> Warning: Removed 132 row(s) containing missing values (geom_path).
#> Drew the Profile plot for  Protein_4671_Y236 ( 89  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_12_S703 ( 1  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_15_S140 ( 2  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_15_Y137 ( 3  of  89 )
#> Drew the Profile plot with summarization for  Protein_125_Y343 ( 4  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_150_S729 ( 5  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_152_S455 ( 6  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_191_S679 ( 7  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_261_S637 ( 8  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_261_S180 ( 9  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_261_S182 ( 10  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_320_S198 ( 11  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_324_S122 ( 12  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_541_S504 ( 13  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_843_S295 ( 14  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_971_S326 ( 15  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1076_Y67 ( 16  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1145_T915 ( 17  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1146_S328 ( 18  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1160_S188 ( 19  of  89 )
#> Drew the Profile plot with summarization for  Protein_1220_Y321 ( 20  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1235_S416 ( 21  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1326_Y182 ( 22  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1380_Y106 ( 23  of  89 )
#> Drew the Profile plot with summarization for  Protein_1547_Y608 ( 24  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1548_Y849 ( 25  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1548_Y580 ( 26  of  89 )
#> Drew the Profile plot with summarization for  Protein_1548_T850 ( 27  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1551_S994 ( 28  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1584_S71 ( 29  of  89 )
#> Drew the Profile plot with summarization for  Protein_1587_Y168 ( 30  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1612_S296 ( 31  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1616_S203 ( 32  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1686_T133 ( 33  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1721_S24 ( 34  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1739_S237 ( 35  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1852_Y342 ( 36  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1863_S2029 ( 37  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1863_S2030 ( 38  of  89 )
#> Drew the Profile plot with summarization for  Protein_1864_Y207 ( 39  of  89 )
#> Drew the Profile plot with summarization for  Protein_1864_Y50 ( 40  of  89 )
#> Drew the Profile plot with summarization for  Protein_1864_Y409 ( 41  of  89 )
#> Drew the Profile plot with summarization for  Protein_1865_Y153 ( 42  of  89 )
#> Drew the Profile plot with summarization for  Protein_1929_Y323 ( 43  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_1945_Y628 ( 44  of  89 )
#> Drew the Profile plot with summarization for  Protein_2084_Y44 ( 45  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2108_Y281 ( 46  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).

#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2207_S674 ( 47  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2212_S2980 ( 48  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2215_S568 ( 49  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2234_S459 ( 50  of  89 )
#> Drew the Profile plot with summarization for  Protein_2273_Y148 ( 51  of  89 )
#> Drew the Profile plot with summarization for  Protein_2284_Y519 ( 52  of  89 )
#> Drew the Profile plot with summarization for  Protein_2284_Y520 ( 53  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2297_Y276 ( 54  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2297_T279 ( 55  of  89 )
#> Drew the Profile plot with summarization for  Protein_2302_Y393 ( 56  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2304_S603 ( 57  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2311_S274 ( 58  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2315_S105 ( 59  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2353_S394 ( 60  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2353_S392 ( 61  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2361_S54 ( 62  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2361_T53 ( 63  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2382_S183 ( 64  of  89 )
#> Drew the Profile plot with summarization for  Protein_2391_Y40 ( 65  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2395_Y306 ( 66  of  89 )
#> Drew the Profile plot with summarization for  Protein_2461_Y250 ( 67  of  89 )
#> Drew the Profile plot with summarization for  Protein_2462_Y332 ( 68  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2560_T311 ( 69  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2607_S563 ( 70  of  89 )
#> Drew the Profile plot with summarization for  Protein_2697_Y698 ( 71  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2701_S1106 ( 72  of  89 )
#> Drew the Profile plot with summarization for  Protein_2874_Y59 ( 73  of  89 )
#> Drew the Profile plot with summarization for  Protein_2992_Y118 ( 74  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_3027_S111 ( 75  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_3273_S518 ( 76  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_3486_Y505 ( 77  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_3659_S1625 ( 78  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4093_S435 ( 79  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4277_T269 ( 80  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4307_S212 ( 81  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4338_S523 ( 82  of  89 )
#> Drew the Profile plot with summarization for  Protein_4475_Y98 ( 83  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4494_S1128 ( 84  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4668_T682 ( 85  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2072_Y89 ( 86  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_2264_Y64 ( 87  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4671_S237 ( 88  of  89 )
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Warning: Removed 11 row(s) containing missing values (geom_path).
#> Warning: Removed 11 rows containing missing values (geom_point).
#> Drew the Profile plot with summarization for  Protein_4671_Y236 ( 89  of  89 )

# Quality Control Plot
# dataProcessPlotsTMTPTM(data.ptm=ptm.input.pd,
#                     data.protein=protein.input.pd,
#                     data.ptm.summarization=quant.msstats.ptm,
#                     data.protein.summarization=quant.msstats.protein,
#                     type='QCPlot')
```

### 3. groupComparisonTMTPTM()

Tests for significant changes in PTM abundance adjusted for global protein abundance across conditions based on a family of linear mixed-effects models in TMT experiment. Experimental design of case-control study (patients are not repeatedly measured) is automatically determined based on proper statistical model.

### Arguments

* `data.ptm` : Name of the output of proteinSummarization function with PTM data. It should have columns named `Protein`, `TechRepMixture`, `Mixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, `Abundance`.
* `data.protein` : Name of the output of proteinSummarization function with Protein data. It should have columns named `Protein`, `TechRepMixture`,
  `Mixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, `Abundance`.
* `contrast.matrix` : Comparison between conditions of interests. 1) default is `pairwise`, which compare all possible pairs between two conditions.

2. Otherwise, users can specify the comparisons of interest. Based on the levels of conditions, specify 1 or -1 to the conditions of interests and 0 otherwise. The levels of conditions are sorted alphabetically.

* `moderated` : If moderated = TRUE, then moderated t statistic will be calculated; otherwise, ordinary t statistic will be used.
* `adj.method` : adjusted method for multiple comparison. ’BH` is default.

### Example

```
# test for all the possible pairs of conditions
model.results.pairwise <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein)
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |=====                                                                 |   8%
  |
  |======                                                                |   9%
  |
  |=======                                                               |  10%
  |
  |========                                                              |  11%
  |
  |=========                                                             |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  16%
  |
  |============                                                          |  17%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  24%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |===================                                                   |  28%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  31%
  |
  |=======================                                               |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  43%
  |
  |===============================                                       |  44%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |=================================                                     |  48%
  |
  |==================================                                    |  49%
  |
  |===================================                                   |  50%
  |
  |====================================                                  |  51%
  |
  |=====================================                                 |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  57%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |===============================================                       |  68%
  |
  |================================================                      |  69%
  |
  |=================================================                     |  70%
  |
  |==================================================                    |  71%
  |
  |===================================================                   |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  76%
  |
  |======================================================                |  77%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  83%
  |
  |===========================================================           |  84%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  90%
  |
  |================================================================      |  91%
  |
  |=================================================================     |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |=====                                                                 |   8%
  |
  |======                                                                |   9%
  |
  |=======                                                               |  10%
  |
  |========                                                              |  11%
  |
  |=========                                                             |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  16%
  |
  |============                                                          |  17%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  24%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |===================                                                   |  28%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  31%
  |
  |=======================                                               |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  43%
  |
  |===============================                                       |  44%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |=================================                                     |  48%
  |
  |==================================                                    |  49%
  |
  |===================================                                   |  50%
  |
  |====================================                                  |  51%
  |
  |=====================================                                 |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  57%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |===============================================                       |  68%
  |
  |================================================                      |  69%
  |
  |=================================================                     |  70%
  |
  |==================================================                    |  71%
  |
  |===================================================                   |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  76%
  |
  |======================================================                |  77%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  83%
  |
  |===========================================================           |  84%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  90%
  |
  |================================================================      |  91%
  |
  |=================================================================     |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   4%
  |
  |===                                                                   |   5%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   8%
  |
  |=======                                                               |   9%
  |
  |=======                                                               |  11%
  |
  |========                                                              |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  15%
  |
  |============                                                          |  16%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  24%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |====================                                                  |  28%
  |
  |=====================                                                 |  29%
  |
  |=====================                                                 |  31%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  35%
  |
  |==========================                                            |  36%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  44%
  |
  |===============================                                       |  45%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |==================================                                    |  48%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  55%
  |
  |========================================                              |  56%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  64%
  |
  |=============================================                         |  65%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  69%
  |
  |=================================================                     |  71%
  |
  |==================================================                    |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  75%
  |
  |======================================================                |  76%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |==============================================================        |  88%
  |
  |===============================================================       |  89%
  |
  |===============================================================       |  91%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  95%
  |
  |====================================================================  |  96%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   4%
  |
  |===                                                                   |   5%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   8%
  |
  |=======                                                               |   9%
  |
  |=======                                                               |  11%
  |
  |========                                                              |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  15%
  |
  |============                                                          |  16%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  24%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |====================                                                  |  28%
  |
  |=====================                                                 |  29%
  |
  |=====================                                                 |  31%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  35%
  |
  |==========================                                            |  36%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  44%
  |
  |===============================                                       |  45%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |==================================                                    |  48%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  55%
  |
  |========================================                              |  56%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  64%
  |
  |=============================================                         |  65%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  69%
  |
  |=================================================                     |  71%
  |
  |==================================================                    |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  75%
  |
  |======================================================                |  76%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |==============================================================        |  88%
  |
  |===============================================================       |  89%
  |
  |===============================================================       |  91%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  95%
  |
  |====================================================================  |  96%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
names(model.results.pairwise)
#> [1] "PTM.Model"      "Protein.Model"  "Adjusted.Model"
head(model.results.pairwise[[1]])
#>            Protein                   Label     log2FC         SE       DF
#> 1 Protein_1076_Y67 Condition_1-Condition_2 0.04713074 0.05264970 15.00000
#> 2 Protein_1076_Y67 Condition_1-Condition_3 0.42262536 0.05712141 15.00008
#> 3 Protein_1076_Y67 Condition_1-Condition_4 0.11835636 0.05264970 15.00000
#> 4 Protein_1076_Y67 Condition_1-Condition_5 0.28875531 0.05264970 15.00000
#> 5 Protein_1076_Y67 Condition_1-Condition_6 0.14293731 0.05712141 15.00008
#> 6 Protein_1076_Y67 Condition_2-Condition_3 0.37549462 0.05712141 15.00008
#>         pvalue   adj.pvalue issue
#> 1 3.848331e-01 0.6180078006    NA
#> 2 2.223242e-06 0.0001000459    NA
#> 3 4.004178e-02 0.0493665767    NA
#> 4 6.285870e-05 0.0007071603    NA
#> 5 2.439269e-02 0.0439068501    NA
#> 6 8.829044e-06 0.0003973070    NA

# Load specific contrast matrix
#example.contrast.matrix <- read.csv(file="example.contrast.matrix.csv", header=TRUE)
example.contrast.matrix
#>         Condition_1 Condition_2 Condition_3 Condition_4 Condition_5 Condition_6
#> 1-4       1.0000000   0.0000000   0.0000000  -1.0000000   0.0000000   0.0000000
#> 2-5       0.0000000   1.0000000   0.0000000   0.0000000  -1.0000000   0.0000000
#> 3-6       0.0000000   0.0000000   1.0000000   0.0000000   0.0000000  -1.0000000
#> 1-3       1.0000000   0.0000000  -1.0000000   0.0000000   0.0000000   0.0000000
#> 2-3       0.0000000   1.0000000  -1.0000000   0.0000000   0.0000000   0.0000000
#> 4-6       0.0000000   0.0000000   0.0000000   1.0000000   0.0000000  -1.0000000
#> 5-6       0.0000000   0.0000000   0.0000000   0.0000000   1.0000000  -1.0000000
#> Partial   0.2500000   0.2500000  -0.5000000   0.2500000   0.2500000  -0.5000000
#> Third     0.3333333   0.3333333   0.3333333  -0.3333333  -0.3333333  -0.3333333

# test for specified condition comparisons only
model.results.contrast <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein,
                                       contrast.matrix = example.contrast.matrix)
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |=====                                                                 |   8%
  |
  |======                                                                |   9%
  |
  |=======                                                               |  10%
  |
  |========                                                              |  11%
  |
  |=========                                                             |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  16%
  |
  |============                                                          |  17%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  24%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |===================                                                   |  28%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  31%
  |
  |=======================                                               |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  43%
  |
  |===============================                                       |  44%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |=================================                                     |  48%
  |
  |==================================                                    |  49%
  |
  |===================================                                   |  50%
  |
  |====================================                                  |  51%
  |
  |=====================================                                 |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  57%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |===============================================                       |  68%
  |
  |================================================                      |  69%
  |
  |=================================================                     |  70%
  |
  |==================================================                    |  71%
  |
  |===================================================                   |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  76%
  |
  |======================================================                |  77%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  83%
  |
  |===========================================================           |  84%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  90%
  |
  |================================================================      |  91%
  |
  |=================================================================     |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |=====                                                                 |   8%
  |
  |======                                                                |   9%
  |
  |=======                                                               |  10%
  |
  |========                                                              |  11%
  |
  |=========                                                             |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  16%
  |
  |============                                                          |  17%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  24%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |===================                                                   |  28%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  31%
  |
  |=======================                                               |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  43%
  |
  |===============================                                       |  44%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |=================================                                     |  48%
  |
  |==================================                                    |  49%
  |
  |===================================                                   |  50%
  |
  |====================================                                  |  51%
  |
  |=====================================                                 |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  57%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |===============================================                       |  68%
  |
  |================================================                      |  69%
  |
  |=================================================                     |  70%
  |
  |==================================================                    |  71%
  |
  |===================================================                   |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  76%
  |
  |======================================================                |  77%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  83%
  |
  |===========================================================           |  84%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  90%
  |
  |================================================================      |  91%
  |
  |=================================================================     |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   4%
  |
  |===                                                                   |   5%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   8%
  |
  |=======                                                               |   9%
  |
  |=======                                                               |  11%
  |
  |========                                                              |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  15%
  |
  |============                                                          |  16%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  24%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |====================                                                  |  28%
  |
  |=====================                                                 |  29%
  |
  |=====================                                                 |  31%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  35%
  |
  |==========================                                            |  36%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  44%
  |
  |===============================                                       |  45%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |==================================                                    |  48%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  55%
  |
  |========================================                              |  56%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  64%
  |
  |=============================================                         |  65%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  69%
  |
  |=================================================                     |  71%
  |
  |==================================================                    |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  75%
  |
  |======================================================                |  76%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |==============================================================        |  88%
  |
  |===============================================================       |  89%
  |
  |===============================================================       |  91%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  95%
  |
  |====================================================================  |  96%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
#>
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   4%
  |
  |===                                                                   |   5%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   8%
  |
  |=======                                                               |   9%
  |
  |=======                                                               |  11%
  |
  |========                                                              |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  15%
  |
  |============                                                          |  16%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  20%
  |
  |===============                                                       |  21%
  |
  |================                                                      |  22%
  |
  |================                                                      |  24%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |====================                                                  |  28%
  |
  |=====================                                                 |  29%
  |
  |=====================                                                 |  31%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  35%
  |
  |==========================                                            |  36%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  44%
  |
  |===============================                                       |  45%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |==================================                                    |  48%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |=======================================                               |  55%
  |
  |========================================                              |  56%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  61%
  |
  |============================================                          |  62%
  |
  |============================================                          |  64%
  |
  |=============================================                         |  65%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  69%
  |
  |=================================================                     |  71%
  |
  |==================================================                    |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  75%
  |
  |======================================================                |  76%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |==============================================================        |  88%
  |
  |===============================================================       |  89%
  |
  |===============================================================       |  91%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |===================================================================   |  95%
  |
  |====================================================================  |  96%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%

names(model.results.contrast)
#> [1] "PTM.Model"      "Protein.Model"  "Adjusted.Model"
head(model.results.contrast[[1]])
#>            Protein Label      log2FC         SE       DF       pvalue
#> 1 Protein_1076_Y67   1-4  0.11835636 0.05264970 15.00000 4.004178e-02
#> 2 Protein_1076_Y67   2-5  0.24162457 0.05264970 15.00000 3.544345e-04
#> 3 Protein_1076_Y67   3-6 -0.27968805 0.06173696 15.00028 3.984772e-04
#> 4 Protein_1076_Y67   1-3  0.42262536 0.05712141 15.00008 2.223242e-06
#> 5 Protein_1076_Y67   2-3  0.37549462 0.05712141 15.00008 8.829044e-06
#> 6 Protein_1076_Y67   4-6  0.02458095 0.05712141 15.00008 6.730757e-01
#>     adj.pvalue issue
#> 1 0.0493665767    NA
#> 2 0.0020224378    NA
#> 3 0.0071725901    NA
#> 4 0.0001000459    NA
#> 5 0.0003973070    NA
#> 6 0.7530134974    NA
```

## Session information

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] MSstatsTMT_1.8.2    MSstatsTMTPTM_1.0.2
#>
#> loaded via a namespace (and not attached):
#>  [1] ggrepel_0.9.1         Rcpp_1.0.6            lattice_0.20-41
#>  [4] tidyr_1.1.2           snow_0.4-3            gtools_3.8.2
#>  [7] assertthat_0.2.1      digest_0.6.27         foreach_1.5.1
#> [10] R6_2.5.0              plyr_1.8.6            backports_1.2.1
#> [13] evaluate_0.14         ggplot2_3.3.3         pillar_1.4.7
#> [16] gplots_3.1.1          rlang_0.4.10          minqa_1.2.4
#> [19] data.table_1.13.6     nloptr_1.2.2.2        Matrix_1.3-2
#> [22] preprocessCore_1.52.1 rmarkdown_2.6         labeling_0.4.2
#> [25] splines_4.0.3         lme4_1.1-26           statmod_1.4.35
#> [28] stringr_1.4.0         MSstats_3.22.0        munsell_0.5.0
#> [31] broom_0.7.4           compiler_4.0.3        numDeriv_2016.8-1.1
#> [34] xfun_0.21             pkgconfig_2.0.3       lmerTest_3.1-3
#> [37] marray_1.68.0         htmltools_0.5.1.1     doSNOW_1.0.19
#> [40] tidyselect_1.1.0      gridExtra_2.3         tibble_3.0.6
#> [43] codetools_0.2-18      matrixStats_0.58.0    crayon_1.4.1
#> [46] dplyr_1.0.4           MASS_7.3-53.1         bitops_1.0-6
#> [49] grid_4.0.3            nlme_3.1-152          gtable_0.3.0
#> [52] lifecycle_1.0.0       DBI_1.1.1             magrittr_2.0.1
#> [55] scales_1.1.1          KernSmooth_2.23-18    stringi_1.5.3
#> [58] farver_2.0.3          reshape2_1.4.4        limma_3.46.0
#> [61] ellipsis_0.3.1        generics_0.1.0        vctrs_0.3.6
#> [64] boot_1.3-27           iterators_1.0.13      tools_4.0.3
#> [67] glue_1.4.2            purrr_0.3.4           parallel_4.0.3
#> [70] survival_3.2-7        yaml_2.2.1            colorspace_2.0-0
#> [73] caTools_1.18.1        minpack.lm_1.2-1      knitr_1.31
```