Code

* Show All Code
* Hide All Code

# Using **SIGHTS** R-package

#### Elika Garg, Carl Murie and Robert Nadon

#### 2025-10-30

Abstract

Identifying rare biological events in high-throughput screens requires using the best available normalization and statistical inference procedures. It is not always clear, however, which algorithms are best suited for a particular screen. The Statistics and dIagnostics Graphs for High Throughput Screening (**SIGHTS**) R package is designed for statistical analysis and visualization of HTS assays. It provides graphical diagnostic tools to guide researchers in choosing the most appropriate normalization algorithm and statistical test for identifying active constructs.

---

# 1 Introduction

The `sights` package provides numerous normalization methods that correct the three types of bias that affect High-Throughput Screening (HTS) measurements: overall plate bias, within-plate spatial bias, and across-plate bias. Commonly-used normalization methods such as Z-scores (or methods such as percent inhibition/activation which use within-plate controls to normalize) correct only overall plate bias. Methods included in this package attempt to correct all three sources of bias and typically give better results.

Two statistical tests are also provided: the standard one-sample t-test and the recommended one-sample Random Variance Model (RVM) t-test, which has greater statistical power for the typically small number of replicates in HTS. Correction for the multiple statistical testing of the large number of constructs in HTS data is provided by False Discovery Rate (FDR) correction. The FDR can be described as the proportion of false positives among the statistical tests called significant.

Included graphical and statistical methods provide the means for evaluating data analysis choices for HTS assays on a screen-by-screen basis. These graphs can be used to check fundamental assumptions of both raw and normalized data at every step of the analysis process.

> Citing Methods

Please cite the `sights` package and specific methods as appropriate.

References for the methods can be found in this vignette, on their specific help pages, and in the manual. They can also be accessed by `help(sights_method_name)` in R. For example:

```
# Help page of SPAWN with its references
help(normSPAWN)
```

The package citation can be accessed in R by:

```
citation("sights")
>> To cite package 'sights' in publications use:
>>
>>   Garg E, Murie C, Nadon R (2016). _sights: Statistics and dIagnostic
>>   Graphs for HTS_. R package version 1.36.0.
>>
>> A BibTeX entry for LaTeX users is
>>
>>   @Manual{,
>>     title = {sights: Statistics and dIagnostic Graphs for HTS},
>>     author = {Elika Garg and Carl Murie and Robert Nadon},
>>     year = {2016},
>>     note = {R package version 1.36.0},
>>   }
```

# 2 Getting Started

## 2.1 Installation and loading

1. Please install the package directly from Bioconductor and load it. Note that SIGHTS requires a minimum R version of 3.3.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("sights")
library("sights")
```

2. This should also install and load the packages that SIGHTS imports: ggplot2 (Wickham, 2009), reshape2 (Wickham, 2007), qvalue (Storey, 2015), MASS (Venables and Ripley, 2002), and lattice (Sarkar, 2008).
   Otherwise, you can install/update these packages manually.

```
# Installing packages
BiocManager::install(c("ggplot2", "reshape2", "lattice", "MASS", "qvalue"))

# Updating packages
BiocManager::install("BiocUpgrade")
BiocManager::install()
```

## 2.2 Importing and exporting data

All SIGHTS normalization functions require that the data be arranged such that each plate is a column and each row is a well. The arrangement within each plate should be by-row first, then by-column. For more details and example, see `help("ex_dataMatrix")`. This required arrangement can be done in Microsoft Excel before importing the data into R, although advanced users may prefer to do so in R as needed.

1. The datasets within SIGHTS can be loaded by:

```
data("ex_dataMatrix")
help("ex_dataMatrix")
## Required data arrangement (by-row first) is explained.
data("inglese")
```

2. Your own data can be imported by giving the path of your file:

* If it is a .csv or .txt file, run

```
read.csv("~/yourfile.csv", header = TRUE, sep = ",")
## '~' is the folder location of your file 'yourfile.csv'.

## Use header=TRUE if you have column headers (recommended); otherwise, use
## header=FALSE.

## N.B. Be sure to use a forward slash ('/') to separate folder names.
```

* If it is a Microsoft Excel file, you can import it directly by installing another package:

```
install.packages("xlsx")
## This installs the xlsx package which enables import/export of Excel files.
library("xlsx")
read.xlsx("~/yourfile.xlsx", sheetIndex = 1)  # or
read.xlsx("~/yourfile.xlsx", sheetName = "one")
## sheetIndex is the sheet number where your data is stored in 'yourfile.xlsx';
## sheetName is the name of that sheet.
```

3. Similarly any object saved in R (e.g. normalized results) can be exported as .csv or .xlsx files:

```
write.csv(object_name, "~/yourresults.csv")
## As a .csv file
write.xlsx(object_name, "~/yourresults.xlsx")
## As a Microsoft Excel file (requires the 'xlsx' package)
```

## 2.3 Information about data

1. There are two datasets provided within SIGHTS:

* CMBA data (Murie *et al.*, 2015), see `help("ex_dataMatrix")`
* Inglese *et. al.* data (Inglese *et al.*, 2006), see `help("inglese")`

2. Some basic information about data (including your own data after importing) can be accessed by various functions. For example, information about the Inglese *et al.* data set can be obtained as follows:

```
View(inglese)
## View the entire dataset
edit(inglese)
## Edit the dataset
head(inglese)
## View the top few rows of the dataset
str(inglese)
## Get information on the structure of the dataset
summary(inglese)
## Get a summary of variables in the dataset
names(inglese)
## Get the variable names of the dataset
```

## 2.4 Information about methods

1. There are several methods provided within SIGHTS:

* Normalization:
  + Z, Robust Z (see Malo *et al.* (2006)),
  + Loess (Baryshnikova *et al.*, 2010),
  + Median Filter (Bushway *et al.*, 2011),
  + R (Wu *et al.*, 2008), and
  + SPAWN (Murie *et al.*, 2015).
* Statistical testing:
  + one-sample t-test,
  + one-sample RVM t-test (Malo *et al.*, 2006; Wright and Simon, 2003), and
  + FDR correction (Storey, 2002).
* Plotting:
  + 3d plot,
  + heatmap,
  + auto-correlation plot,
  + scatter plot,
  + boxplot,
  + inverse-gamma fit plot, and
  + histograms.

See `help("normSights")`, `help("statSights")`, `help("plotSights")`, and the help pages of individual methods for more information.

2. Information about the package functions can be accessed by:

```
ls("package:sights")
## Lists all the functions and datasets available in the package
lsf.str("package:sights")
## Lists all the functions and their usage
args(plotSights)
## View the usage of a specific function
example(topic = plotSights, package = "sights")
## View examples of a specific function
```

## 2.5 Quick reference

1. Normalization - All normalization functions are accessible either via `normSights()` or their individual function names (e.g. `normSPAWN()`).
2. Statistical tests - All statistical testing functions are accessible either via `statSights()` or their individual function names (e.g. `statRVM()`).
3. Plots - All plotting functions are accessible either via `plotSights()` or their individual function names (e.g. `plotAutoco()`).

The results of these functions can be saved as objects and called by their assigned names. For example:

```
library(sights)
data("inglese")
# Normalize
spawn_results <- normSPAWN(dataMatrix = inglese, plateRows = 32, plateCols = 40,
    dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE, biasMatrix = NULL,
    biasCols = 1:18)
## Or
spawn_results <- normSights(normMethod = "SPAWN", dataMatrix = inglese, plateRows = 32,
    plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE,
    biasMatrix = NULL, biasCols = 1:18)
## Access
summary(spawn_results)
# Apply statistical test
rvm_results <- statRVM(normMatrix = spawn_results, repIndex = rep(1:3, each = 3),
    normRows = NULL, normCols = 1:9, testSide = "two.sided")
## Or
rvm_results <- statSights(statMethod = "RVM", normMatrix = spawn_results, repIndex = c(1,
    1, 1, 2, 2, 2, 3, 3, 3), normRows = NULL, normCols = 1:9, ctrlMethod = NULL,
    testSide = "two.sided")
## Access
head(rvm_results)
# Plot
autoco_results <- plotAutoco(plotMatrix = spawn_results, plateRows = 32, plateCols = 40,
    plotRows = NULL, plotCols = 1:9, plotName = "SPAWN_Inglese", plotSep = TRUE)
## Or
autoco_results <- plotSights(plotMethod = "Autoco", plotMatrix = spawn_results, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = c(1, 2, 3, 4, 5, 6, 7, 8, 9), plotName = "SPAWN_Inglese",
    plotSep = TRUE)
## Access
autoco_results
autoco_results[[1]]
```

# 3 Navigating through SIGHTS

We recommend the following workflow:

* Visualize the raw data to identify bias, if any:

| Types of bias | Expectation, in absence of bias | Identification, in presence of bias |
| --- | --- | --- |
| Plate bias | Replicate plates have similar overall distributions. | Boxplots show different medians and/or variability among replicate plates. |
| Within-plate spatial bias | Data within a plate is not affected by well position. | Heatmaps and 3-D plots show row and/or column effects. Auto-correlation plots show non-zero correlations at various lags; typical patterns include cyclical and/or decreasing correlation values. |
| Across-plate bias | Assuming few true ‘hits’ within the screen, the majority of data points should be uncorrelated across replicate plates. Only the hits should be correlated. | Scatter plots of replicate plates show strong correlation. |

* Try different normalization methods and visualize the results, comparing them to raw data
* Normalize the raw data using the method that best minimizes bias
* Conduct statistical tests on the normalized data and visualize the p-value distribution
* Apply FDR correction

  We will use the Inglese *et. al.* dataset (Inglese *et al.*, 2006) to demonstrate application of SIGHTS and interpretation of results.

```
library("sights")
data("inglese")
```

* Each column represents one plate of 1536-well plates
* 1st 4 columns and last 4 columns have controls - these have been removed as they are not necessary for the normalization methods
* As required, data are arranged by row so that the well index goes from (A01, A02, A03, …)
* There are 14 concentrations with three replicates each

  We will analyze data from two of the concentrations separately:

1. Lowest Concentration (Three Replicate Plates: Exp1R1-Exp1R3)
   For these lowest concentration plates, the concentration is so low that even active molecules (as determined by a titration series) do not show activity. We use these data to show what normalized null data should look like.
2. 9th Concentration (Three Replicate Plates: Exp9R1-Exp9R3)
   For these higher concentration plates, some compounds show activity levels. We use these data to illustrate what data for a typical experiment might look like.

## 3.1 Choose Normalization Method

SIGHTS has three graphical methods for visually detecting spatial bias within plates: standard “Heatmap” and “3d” plots, and autocorrelation plots (“Autoco”) (Murie *et al.*, 2015).

### 3.1.1 Replicates of Lowest Concentration (Exp1R1-Exp1R3)

1. Raw Data
   The following plots will show that the raw data are affected by the three types of bias described above:

* overall plate bias
* within-plate spatial bias
* across-plate bias

```
sights::plotSights(plotMethod = "Box", plotMatrix = inglese, plotCols = 3:5, plotName = "Raw Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Boxplots: There is overall plate bias, since the median values of the three replicate plates differ.](data:image/png;base64...)

Boxplots: There is overall plate bias, since the median values of the three replicate plates differ.

```
sights::plotSights(plotMethod = "Heatmap", plotMatrix = inglese, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 3, plotName = "Raw Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "3d", plotMatrix = inglese, plateRows = 32, plateCols = 40,
    plotRows = NULL, plotCols = 3, plotName = "Raw Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Autoco", plotMatrix = inglese, plateRows = 32, plateCols = 40,
    plotRows = NULL, plotCols = 3:5, plotSep = FALSE, plotName = "Raw Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...) Heatmap, 3d plot, and auto-correlation plots show that there is non-trivial within-plate spatial bias, strongly indicated by the high auto-correlations and the cyclical patterns in the auto-correlation plots.

```
sights::plotSights(plotMethod = "Scatter", plotMatrix = inglese, repIndex = c(1,
    1), plotRows = NULL, plotCols = 3:4, plotName = "Raw Exp1", alpha = 0.2)
>> Number of samples = 1
>> Number of plots = 1
>> Number of plates = 2
>> Number of plate wells = 1280
>> `geom_smooth()` using formula = 'y ~ x'
```

![Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates. When screens have few true hits, replicate plates should be uncorrelated except within the hit range. Depending on the screen, hits could be represented by high or low scores or, as in this screen, by both. The blue line is the loess robust fit; the dashed line is the identity line.](data:image/png;base64...)

Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates. When screens have few true hits, replicate plates should be uncorrelated except within the hit range. Depending on the screen, hits could be represented by high or low scores or, as in this screen, by both. The blue line is the loess robust fit; the dashed line is the identity line.

---

> The preferred normalization method is usually the one that minimizes all three types of bias: plate bias, within-plate spatial bias, and across-plate bias.

> Some of the available methods within `sights` are demonstrated below for illustration purposes. Normally, you may wish to examine numerous methods to see which one is preferred for your dataset.

---

2. Z-score normalization
   Z-scores correct for plate bias but do not correct the other two types of bias:

```
Z.norm.inglese.01 <- sights::normSights(normMethod = "Z", dataMatrix = inglese, dataRows = NULL,
    dataCols = 3:5)
>> Completed Z score normalization
>> Number of plates = 3
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Box", plotMatrix = Z.norm.inglese.01, plotCols = 1:3,
    plotName = "Z Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Boxplots: Z-score normalization has corrected overall plate bias, as the medians of the three replicate plates are approximately equal.](data:image/png;base64...)

Boxplots: Z-score normalization has corrected overall plate bias, as the medians of the three replicate plates are approximately equal.

```
sights::plotSights(plotMethod = "Heatmap", plotMatrix = Z.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "Z Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "3d", plotMatrix = Z.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "Z Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Autoco", plotMatrix = Z.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "Z Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...) Heatmap, 3d plot, and auto-correlation plots show that within-plate spatial bias is unchanged from the raw data, because Z-scores are simply a linear transformation of the raw data.

```
sights::plotSights(plotMethod = "Scatter", plotMatrix = Z.norm.inglese.01, repIndex = c(1,
    1), plotRows = NULL, plotCols = 1:2, plotName = "Z Exp1", alpha = 0.2)
>> Number of samples = 1
>> Number of plots = 1
>> Number of plates = 2
>> Number of plate wells = 1280
>> `geom_smooth()` using formula = 'y ~ x'
```

![Scatter plot: Similarly, the correlational pattern between replicates (across-plate bias) remains.  Note, though, that the blue loess line now substantially overlaps the identity line because Z-score normalization corrects for overall plate bias.](data:image/png;base64...)

Scatter plot: Similarly, the correlational pattern between replicates (across-plate bias) remains. Note, though, that the blue loess line now substantially overlaps the identity line because Z-score normalization corrects for overall plate bias.

---

3. SPAWN normalization
   SPAWN scores correct all three types of bias in these data. (Murie *et al.*, 2015).
   In this example, well correction is used and the “Bias Template” (Murie *et al.*, 2013, 2015) is estimated from the 6 lowest concentration plates (3 replicates per concentration for a total of 18 plates).

```
SPAWN.norm.inglese.01 <- sights::normSights(normMethod = "SPAWN", dataMatrix = inglese,
    plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2,
    wellCorrection = TRUE, biasCols = 1:18)
>> Completed Spatial Polish normalization, trim 0.2 with well correction
>> Number of plates in bias template = 18
>> Number of plates = 42
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.01, plotCols = 1:3,
    plotName = "SPAWN Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal.](data:image/png;base64...)

Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal.

```
sights::plotSights(plotMethod = "Heatmap", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "3d", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp1")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "SPAWN Exp1")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...) Heatmap, 3d plot, and auto-correlation plots show that SPAWN has removed within-plate spatial bias, as indicated by the near zero correlations at each lag.

```
sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.01, repIndex = c(1,
    1), plotRows = NULL, plotCols = 1:2, plotName = "SPAWN Exp1", alpha = 0.2)
>> Number of samples = 1
>> Number of plots = 1
>> Number of plates = 2
>> Number of plate wells = 1280
>> `geom_smooth()` using formula = 'y ~ x'
```

![Scatter plot: SPAWN has removed across-plate bias, as indicated by the near zero correlations between replicate plates.](data:image/png;base64...)

Scatter plot: SPAWN has removed across-plate bias, as indicated by the near zero correlations between replicate plates.

---

### 3.1.2 Replicates of 9th Concentration (Exp9R1-Exp9R3)

1. Raw Data
   The raw data for the 9th concentration are also affected by the three types of bias described above:

* plate bias
* within-plate spatial bias
* across-plate bias

```
sights::plotSights(plotMethod = "Box", plotMatrix = inglese, plotCols = 27:29, plotName = "Raw Exp9")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Boxplots: There is overall plate bias, since the median values of the three replicate plates differ.](data:image/png;base64...)

Boxplots: There is overall plate bias, since the median values of the three replicate plates differ.

```
sights::plotSights(plotMethod = "Heatmap", plotMatrix = inglese, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 27, plotName = "Raw Exp9")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "3d", plotMatrix = inglese, plateRows = 32, plateCols = 40,
    plotRows = NULL, plotCols = 27, plotName = "Raw Exp9")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Autoco", plotMatrix = inglese, plateRows = 32, plateCols = 40,
    plotRows = NULL, plotCols = 27:29, plotSep = FALSE, plotName = "Raw Exp9")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...) Heatmap, 3d plot, and auto-correlation plots show that there is non-trivial within-plate spatial bias, strongly indicated by the high auto-correlations and the cyclical patterns in the auto-correlation plots.

```
sights::plotSights(plotMethod = "Scatter", plotMatrix = inglese, repIndex = c(1,
    1), plotRows = NULL, plotCols = 27:28, plotName = "Raw Exp9", alpha = 0.2)
>> Number of samples = 1
>> Number of plots = 1
>> Number of plates = 2
>> Number of plate wells = 1280
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
```

![Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates.](data:image/png;base64...)

Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates.

---

3. Z-score normalization
   Because Z-score normalization does not correct spatial bias, it is not recommended for these data. We demonstrate SPAWN, one of the recommended normalization methods, which has been shown to perform the best among the available methods for these data. See Murie *et al.* (2015) for the comparisons and for additional analyses which examined the various normalization methods separately for active and inactive molecules.
4. SPAWN normalization
   SPAWN scores correct all three types of bias in these data.

```
SPAWN.norm.inglese.09 <- sights::normSights(normMethod = "SPAWN", dataMatrix = inglese,
    plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2,
    wellCorrection = TRUE, biasCols = 1:18)[, 25:27]
>> Completed Spatial Polish normalization, trim 0.2 with well correction
>> Number of plates in bias template = 18
>> Number of plates = 42
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.09, plotCols = 1:3,
    plotName = "SPAWN Exp9")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal.](data:image/png;base64...)

Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal.

```
sights::plotSights(plotMethod = "Heatmap", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp9")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "3d", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp9")
>> Number of plots = 1
>> Number of plates = 1
>> Number of plate wells = 1280
sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32,
    plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "SPAWN Exp9")
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...) Heatmap, 3d plot, and auto-correlation plots show that SPAWN has removed within-plate spatial bias, as indicated by the near zero correlations at each lag.

```
sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,
    1), plotRows = NULL, plotCols = 1:2, plotName = "SPAWN Exp9", alpha = 0.2)
>> Number of samples = 1
>> Number of plots = 1
>> Number of plates = 2
>> Number of plate wells = 1280
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
```

![Scatter plot: The circular pattern for the majority of data points near zero indicates that across-plate bias has been greatly reduced. This is also shown by the approximately horizontal blue loess line within that range. Data points outside of that range are potential hits.](data:image/png;base64...)

Scatter plot: The circular pattern for the majority of data points near zero indicates that across-plate bias has been greatly reduced. This is also shown by the approximately horizontal blue loess line within that range. Data points outside of that range are potential hits.

---

## 3.2 Statistical Testing

Both the standard one-sample t-test and the Random Variance Model (RVM) one-sample t-test (Wright and Simon, 2003; Malo *et al.*, 2006) are available. Because the standard t-test tends to perform poorly with few replicates, the RVM test is generally recommended (Murie *et al.*, 2009, 2015).
False Discovery Rate (FDR) methods correct for multiple testing. The method available in SIGHTS is Storey’s q-value method (Storey, 2002). Please see the qvalue package (Storey, 2015) [documentation](https://bioconductor.org/packages/release/bioc/vignettes/qvalue/inst/doc/qvalue.pdf) for more information on FDR correction.

1. One-sample t-test
   Without FDR:

```
SPAWN.norm.inglese.09.t <- sights::statSights(statMethod = "T", normMatrix = SPAWN.norm.inglese.09,
    repIndex = c(1, 1, 1), normRows = NULL, ctrlMethod = NULL, testSide = "two.sided")
>> Completed t-test [get p-value columns: seq(1)*5 ]
>> Number of samples = 1
>> Number of plates = 3
>> Number of plate wells = 1280
summary(SPAWN.norm.inglese.09.t)
>>  1:T-statistic       1:Mean_Difference  1:Standard_Error 1:Degrees_Of_Freedom
>>  Min.   :-80.87473   Min.   :-9.24966   Min.   :0.0139   Min.   :2
>>  1st Qu.: -1.13851   1st Qu.:-0.26124   1st Qu.:0.1538   1st Qu.:2
>>  Median :  0.04075   Median : 0.01166   Median :0.2398   Median :2
>>  Mean   : -0.09339   Mean   :-0.01694   Mean   :0.2759   Mean   :2
>>  3rd Qu.:  1.12822   3rd Qu.: 0.28124   3rd Qu.:0.3496   3rd Qu.:2
>>  Max.   : 43.58220   Max.   :14.16781   Max.   :4.0677   Max.   :2
>>    1:P-value
>>  Min.   :0.0001529
>>  1st Qu.:0.1631297
>>  Median :0.3736520
>>  Mean   :0.4172724
>>  3rd Qu.:0.6499402
>>  Max.   :0.9981513
## The 5th column in the result matrix has the p-values, and thus, it will be
## selected for histogram below.
sights::plotSights(plotMethod = "Hist", plotMatrix = SPAWN.norm.inglese.09.t, plotRows = NULL,
    plotCols = 5, plotAll = FALSE, plotSep = TRUE, colNames = "Exp9", plotName = "t-test")
>> Number of samples = 1
>> Number of plots = 1
>> Number of plate wells = 1280
>> [[1]]
```

![P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives.](data:image/png;base64...)

P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives.

---

With FDR: When corrected for multiple testing, “q-values” are generated. Often, in screening contexts, q-values of 0.20 or smaller might be appropriate for follow-up.

```
SPAWN.norm.inglese.09.t.fdr <- sights::statFDR(SPAWN.norm.inglese.09.t, ctrlMethod = "smoother")
>> Completed FDR with smoother estimation [get q-value columns: seq(1)*6 ]
>> Number of samples = 1
summary(SPAWN.norm.inglese.09.t.fdr)
>>  1:T-statistic       1:Mean_Difference  1:Standard_Error 1:Degrees_Of_Freedom
>>  Min.   :-80.87473   Min.   :-9.24966   Min.   :0.0139   Min.   :2
>>  1st Qu.: -1.13851   1st Qu.:-0.26124   1st Qu.:0.1538   1st Qu.:2
>>  Median :  0.04075   Median : 0.01166   Median :0.2398   Median :2
>>  Mean   : -0.09339   Mean   :-0.01694   Mean   :0.2759   Mean   :2
>>  3rd Qu.:  1.12822   3rd Qu.: 0.28124   3rd Qu.:0.3496   3rd Qu.:2
>>  Max.   : 43.58220   Max.   :14.16781   Max.   :4.0677   Max.   :2
>>    1:P-value           1:q-value
>>  Min.   :0.0001529   Min.   :0.1168
>>  1st Qu.:0.1631297   1st Qu.:0.4118
>>  Median :0.3736520   Median :0.4855
>>  Mean   :0.4172724   Mean   :0.4833
>>  3rd Qu.:0.6499402   3rd Qu.:0.5623
>>  Max.   :0.9981513   Max.   :0.6490
```

2. RVM test
   Assumption checking:

```
SPAWN.norm.inglese.09.rvm <- sights::statSights(statMethod = "RVM", normMatrix = SPAWN.norm.inglese.09,
    repIndex = c(1, 1, 1), normRows = NULL, ctrlMethod = NULL, testSide = "two.sided")
>> Warning in stats::nlm(g, strt, yunq = c(sig, n)): Inf replaced by maximum
>> positive value
>> Warning in stats::nlm(g, strt, yunq = c(sig, n)): Inf replaced by maximum
>> positive value
>> alpha= 3.018078 beta= 1.548906
>> Completed RVM test [get p-value columns: seq(1)*5 ]
>> Number of samples = 1
>> Number of plates = 3
>> Number of plate wells = 1280
summary(SPAWN.norm.inglese.09.rvm)
>>  1:RVM T-statistic   1:Mean_Difference  1:Standard_Error 1:DegreesOfFreedom
>>  Min.   :-27.83710   Min.   :-9.24966   Min.   :0.2315   Min.   :8.036
>>  1st Qu.: -0.97809   1st Qu.:-0.26124   1st Qu.:0.2438   1st Qu.:8.036
>>  Median :  0.04405   Median : 0.01166   Median :0.2605   Median :8.036
>>  Mean   : -0.08084   Mean   :-0.01694   Mean   :0.2785   Mean   :8.036
>>  3rd Qu.:  1.03195   3rd Qu.: 0.28124   3rd Qu.:0.2898   3rd Qu.:8.036
>>  Max.   : 42.74152   Max.   :14.16781   Max.   :2.0424   Max.   :8.036
>>    1:P-value
>>  Min.   :0.0000
>>  1st Qu.:0.1252
>>  Median :0.3476
>>  Mean   :0.3997
>>  3rd Qu.:0.6561
>>  Max.   :0.9978
sights::plotSights(plotMethod = "IGFit", plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,
    1, 1))
>> Warning in stats::nlm(g, strt, yunq = c(sig, n)): Inf replaced by maximum
>> positive value
>> Warning in stats::nlm(g, strt, yunq = c(sig, n)): Inf replaced by maximum
>> positive value
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
```

![Inverse Gamma fit plot: The fit of the variance distribution is reasonably close to theoretical expectation and so the RVM test is appropriate for these data.](data:image/png;base64...)

Inverse Gamma fit plot: The fit of the variance distribution is reasonably close to theoretical expectation and so the RVM test is appropriate for these data.

---

Without FDR:

```
sights::plotSights(plotMethod = "Hist", plotMatrix = SPAWN.norm.inglese.09.rvm, plotRows = NULL,
    plotCols = 5, colNames = "Exp9", plotName = "RVM test")
>> Number of samples = 1
>> Number of plots = 1
>> Number of plate wells = 1280
```

![P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives.](data:image/png;base64...)

P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives.

---

With FDR: When corrected for multiple testing, “q-values” are generated. Often, in screening contexts, q-values of 0.20 or smaller might be appropriate for follow-up.

```
SPAWN.norm.inglese.09.rvm.fdr <- sights::statFDR(SPAWN.norm.inglese.09.rvm, ctrlMethod = "smoother")
>> Completed FDR with smoother estimation [get q-value columns: seq(1)*6 ]
>> Number of samples = 1
summary(SPAWN.norm.inglese.09.rvm.fdr)
>>  1:RVM T-statistic   1:Mean_Difference  1:Standard_Error 1:DegreesOfFreedom
>>  Min.   :-27.83710   Min.   :-9.24966   Min.   :0.2315   Min.   :8.036
>>  1st Qu.: -0.97809   1st Qu.:-0.26124   1st Qu.:0.2438   1st Qu.:8.036
>>  Median :  0.04405   Median : 0.01166   Median :0.2605   Median :8.036
>>  Mean   : -0.08084   Mean   :-0.01694   Mean   :0.2785   Mean   :8.036
>>  3rd Qu.:  1.03195   3rd Qu.: 0.28124   3rd Qu.:0.2898   3rd Qu.:8.036
>>  Max.   : 42.74152   Max.   :14.16781   Max.   :2.0424   Max.   :8.036
>>    1:P-value        1:q-value
>>  Min.   :0.0000   Min.   :5.000e-08
>>  1st Qu.:0.1252   1st Qu.:3.027e-01
>>  Median :0.3476   Median :4.211e-01
>>  Mean   :0.3997   Mean   :4.018e-01
>>  3rd Qu.:0.6561   3rd Qu.:5.287e-01
>>  Max.   :0.9978   Max.   :6.048e-01
```

# 4 Advanced Plotting

## 4.1 Basic modifications

All SIGHTS plotting functions, which use the ggplot2 package (Wickham, 2009) (i.e., all except `plot3d` that uses lattice graphics), have an ellipsis argument (“…”) which passes on additional parameters to the specific ggplot *geom* being used in that function. For example, the default plot title and the bar colors of the histogram can be modified as follows:

```
sights::plotHist(plotMatrix = SPAWN.norm.inglese.09.rvm, plotCols = 5, plotAll = TRUE,
    binwidth = 0.02, fill = "pink", color = "black", plotName = "RVM test Exp9")
>> Number of samples = 1
>> Number of plots = 1
>> Number of plate wells = 1280
```

![Ellipsis: Add parameters to ggplot geom [@wickham2009ggplot2].](data:image/png;base64...)

Ellipsis: Add parameters to ggplot geom (Wickham, 2009).

---

## 4.2 Extended modifications

All SIGHTS plotting functions, which use ggplot, produce ggplot objects that can be modified.

Other packages which provide more plotting options can be installed as well: ggthemes (Arnold and Arnold, 2015), gridExtra (Auguie *et al.*, 2015).

```
install.packages("ggthemes")
## This installs the ggthemes package, which has various themes that can be
## used with ggplot objects.
library("ggthemes")
install.packages("gridExtra")
## This installs the gridExtra package, which enables arrangement of plot
## objects.
library("gridExtra")
```

Below are some examples of the plotting modifications that can be achieved using ggplot2/ggthemes/gridExtra (Wickham, 2009, @arnold2015package, @auguie2015package) functions:

1. Layers can be added that override defaults.
   However, faceting is not possible owing to dataset formatting within SIGHTS functions.

```
b <- sights::plotBox(plotMatrix = inglese, plotCols = 33:35)
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
b + ggplot2::geom_boxplot(fill = c("rosybrown", "pink", "thistle")) + ggthemes::theme_igray() +
    ggplot2::labs(x = "Sample_11 Replicates", y = "Raw Values")
```

![Layers: Add layers like ggplot2 [@wickham2009ggplot2].](data:image/png;base64...)

Layers: Add layers like ggplot2 (Wickham, 2009).

Note: When plotSep = TRUE, a list of plot objects is produced, which can be called individually and modified, as in the example below.

---

2. Outliers can be removed from plots by limiting the axes in one of 2 ways.

```
s <- sights::plotScatter(plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1, 1, 1))
>> Number of samples = 1
>> Number of plots = 3
>> Number of plates = 3
>> Number of plate wells = 1280
s[[2]] + ggplot2::labs(title = "Original Scatter Plot")
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
```

![Original plot: All points in the original data are plotted, without setting any data limits.](data:image/png;base64...)

Original plot: All points in the original data are plotted, without setting any data limits.

```
s[[2]] + ggplot2::lims(x = c(-5, 5), y = c(-5, 5)) + ggplot2::labs(title = "Constrained Scatter Plot")
>> Scale for x is already present.
>> Adding another scale for x, which will replace the existing scale.
>> Scale for y is already present.
>> Adding another scale for y, which will replace the existing scale.
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 7 rows containing non-finite outside the scale range
>> (`stat_smooth()`).
>> Warning: Removed 7 rows containing missing values or values outside the scale range
>> (`geom_point()`).
```

![Constrained limits: Data are constrained before plotting, so that points outside of the limits are not considered when drawing aspects of the plot that are estimated from the data such as the loess regression line. Note that the line differs from the original plot above.](data:image/png;base64...)

Constrained limits: Data are constrained before plotting, so that points outside of the limits are not considered when drawing aspects of the plot that are estimated from the data such as the loess regression line. Note that the line differs from the original plot above.

```
s[[2]] + ggplot2::coord_cartesian(xlim = c(-5, 5), ylim = c(-5, 5)) + ggplot2::labs(title = "Zoomed-in Scatter Plot")
>> Coordinate system already present.
>> ℹ Adding new coordinate system, which will replace the existing one.
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
```

![Zoomed-in limits: Original data are used but plot only shows the data within the specified limits. Note, however, that the line is the same within the restricted range as in the original plot above.](data:image/png;base64...)

Zoomed-in limits: Original data are used but plot only shows the data within the specified limits. Note, however, that the line is the same within the restricted range as in the original plot above.

---

3. Different plots can be arranged in the same window.

```
box <- sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.09,
    plotCols = 1:3) + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
autoco <- sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.09,
    plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE) +
    ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
>> Number of plots = 1
>> Number of plates = 3
>> Number of plate wells = 1280
scatter <- sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.09,
    repIndex = c(1, 1, 1), plotRows = NULL, plotCols = 1:3)
>> Number of samples = 1
>> Number of plots = 3
>> Number of plates = 3
>> Number of plate wells = 1280
sc1 <- scatter[[1]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc2 <- scatter[[2]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc3 <- scatter[[3]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc <- gridExtra::grid.arrange(sc1, sc2, sc3, ncol = 3)
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 1 row containing missing values or values outside the scale range
>> (`geom_smooth()`).
>> `geom_smooth()` using formula = 'y ~ x'
>> Warning: Removed 2 rows containing missing values or values outside the scale range
>> (`geom_smooth()`).
ab <- gridExtra::grid.arrange(box, autoco, ncol = 2)
```

```
gridExtra::grid.arrange(ab, sc, nrow = 2, top = "SPAWN Normalized Exp9")
```

![Arrangement: Multiple plots can be custom-arranged in one window by using gridExtra package [@auguie2015package].](data:image/png;base64...)

Arrangement: Multiple plots can be custom-arranged in one window by using gridExtra package (Auguie *et al.*, 2015).

---

# References

Arnold,J.B. and Arnold,M.J.B. (2015) Package ‘ggthemes’.

Auguie,B. *et al.* (2015) Package ‘gridExtra’.

Baryshnikova,A. *et al.* (2010) Quantitative analysis of fitness and genetic interactions in yeast on a genome scale. *Nature methods*, **7**, 1017–1024.

Bushway,P.J. *et al.* (2011) Optimization and application of median filter corrections to relieve diverse spatial patterns in microtiter plate data. *Journal of biomolecular screening*, **16**, 1068–1080.

Inglese,J. *et al.* (2006) Quantitative high-throughput screening: A titration-based approach that efficiently identifies biological activities in large chemical libraries. *Proceedings of the National Academy of Sciences*, **103**, 11473–11478.

Malo,N. *et al.* (2006) Statistical practice in high-throughput screening data analysis. *Nature biotechnology*, **24**, 167–175.

Murie,C. *et al.* (2015) Improving detection of rare biological events in high-throughput screens. *Journal of biomolecular screening*, **20**, 230–241.

Murie,C. *et al.* (2013) Control-plate regression (cpr) normalization for high-throughput screens with many active features. *Journal of biomolecular screening*, 1087057113516003.

Murie,C. *et al.* (2009) Comparison of small n statistical tests of differential expression applied to microarrays. *BMC bioinformatics*, **10**, 1.

Sarkar,D. (2008) Lattice: Multivariate data visualization with r Springer, New York.

Storey,J. (2015) Qvalue: Q-value estimation for false discovery rate control.

Storey,J.D. (2002) A direct approach to false discovery rates. *Journal of the Royal Statistical Society: Series B (Statistical Methodology)*, **64**, 479–498.

Venables,W.N. and Ripley,B.D. (2002) Modern applied statistics with s Fourth. Springer, New York.

Wickham,H. (2009) Ggplot2: Elegant graphics for data analysis Springer New York.

Wickham,H. (2007) Reshaping data with the reshape package. *Journal of Statistical Software*, **21**, 1–20.

Wright,G.W. and Simon,R.M. (2003) A random variance model for detection of differential gene expression in small microarray experiments. *Bioinformatics*, **19**, 2448–2455.

Wu,Z. *et al.* (2008) Quantitative assessment of hit detection and confirmation in single and duplicate high-throughput screenings. *Journal of biomolecular screening*, **13**, 159–167.