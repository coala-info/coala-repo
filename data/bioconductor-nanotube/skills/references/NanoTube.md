# Analyzing NanoString nCounter Data with the NanoTube

#### Caleb A Class

# Abstract

This library provides tools for the processing, normalization, analysis, and visualization of NanoString nCounter gene expression data. Standard NanoString-suggested analysis steps are supported, and functions are also provided for interoperability with other published NanoString analysis methods, as well as a pre-ranked gene set analysis method. This vignette provides a simple workflow for nCounter data analysis, as well as more detailed descriptions of NanoTube functions and options.

# A basic workflow

`processNanostringData` allows you to read in nCounter expression data (from RCC files or in tabular form) and conduct basic normalization and quality control checks in one step. We use example data from GEO data series GSE117751 (Lundy et al. 2018). For this example, RCC files are provided in “GSE117751\_RAW”, while the sample characteristics table is “GSE117751\_sample\_data.csv”.

```
library(NanoTube)

example_data <- system.file("extdata", "GSE117751_RAW", package = "NanoTube")
sample_info <- system.file("extdata",
                           "GSE117751_sample_data.csv",
                           package = "NanoTube")
```

A variety of data processing and normalization options are provided in `processNanostringData`. A set of default options recommended by nCounter can be run automatically, or they can be specified and customized. More details are provided in the “Processing Data” section. This function also merges the expression data with the sample characteristics table (if provided), and outputs as an Biobase ExpressionSet.

```
dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis")
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

There are three groups of samples being compared in this data set.

```
table(dat$groups)
```

```
##
## Autoimmune retinopathy                   None   Retinitis pigmentosa
##                     14                     14                     14
```

You can then run differential expression analysis using Limma. Functions are also provided to allow for analysis using NanoStringDiff (See ‘Differential expression analysis - Using NanoStringDiff’). For this example, we will compare the two disease states vs. the control group (“None”) by setting `base.group` to “None”.

```
limmaResults <- runLimmaAnalysis(dat, base.group = "None")
```

DE results can be viewed or exported to a text fileusing `makeDiffExprFile`. For example, we can convert the differential expression statistics to a table for easier Viewing.

```
limmaStats <- makeDiffExprFile(limmaResults, filename = NULL, returns = "stats")
limmaStats <- as.data.frame(limmaStats)

# Rounding for clarity
limmaTab <- head(limmaStats[order(limmaStats$`p-val (Autoimmune.retinopathy)`,
                      decreasing = FALSE), 1:4])
limmaTab[,1] <- format(limmaTab[,1], digits = 2, nsmall = 1)
limmaTab[,3] <- format(limmaTab[,3], digits = 1, scientific = TRUE)
limmaTab[,4] <- format(limmaTab[,4], digits = 1, nsmall = 1)

# Order by lowest to highest p-value for 'Autoimmune Retinopathy' vs. 'None'
knitr::kable(head(limmaTab),
      row.names = TRUE, format = "html", align = "c")
```

|  | Log2FC (Autoimmune.retinopathy) | t (Autoimmune.retinopathy) | p-val (Autoimmune.retinopathy) | q-val (Autoimmune.retinopathy) |
| --- | --- | --- | --- | --- |
| IKBKB | 0.42 | 4.9 | 1e-05 | 0.006 |
| MIF | -0.54 | -4.4 | 8e-05 | 0.017 |
| IL8 | -1.20 | -4.2 | 1e-04 | 0.017 |
| CR1 | 0.70 | 4.1 | 2e-04 | 0.020 |
| ITGAM | 0.65 | 3.9 | 3e-04 | 0.026 |
| CD3E | -0.48 | -3.9 | 4e-04 | 0.029 |

A volcano plot can also be drawn using deVolcano.

```
deVolcano(limmaResults, plotContrast = "Autoimmune.retinopathy")
```

![](data:image/png;base64...)

DE results can also be used as input for pre-ranked gene set analysis in the `fgsea` package, using `limmaToFGSEA` or `nsdiffToFGSEA`. Gene sets can be provided in .gmt, .tab, or .rds (list object) format, or a list can be input directly. Plenty of additional options for GSEA analysis are available, including leading edge analysis, gene set clustering, and reporting options (see ‘Gene set analysis’).

```
data("ExamplePathways")

fgseaResults <- limmaToFGSEA(limmaResults, gene.sets = ExamplePathways)

# FGSEA was run separately for Autoimmune Retinopathy vs. None and
# Retinitis Pigmentosa vs. None
names(fgseaResults)
```

```
## [1] "Autoimmune.retinopathy" "Retinitis.pigmentosa"
```

```
fgseaTab <- head(fgseaResults$Autoimmune.retinopathy[
             order(fgseaResults$Autoimmune.retinopathy$pval,
                   decreasing = FALSE),])
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab,
      row.names = FALSE, format = "html", align = "c")
```

| pathway | pval | padj | log2err | ES | NES | size | leadingEdge |
| --- | --- | --- | --- | --- | --- | --- | --- |
| EGF/EGFR Signaling Pathway | 0.008 | 0.2 | 0.4 | 0.6 | 1.8 | 15 | STAT3, R…. |
| IL-1 signaling pathway | 0.026 | 0.3 | 0.4 | 0.5 | 1.6 | 19 | IL1B, IL…. |
| Gastric Cancer Network 1 | 0.062 | 0.4 | 0.3 | 1.0 | 1.3 | 1 | NOTCH1 |
| White fat cell differentiation | 0.076 | 0.4 | 0.3 | 0.7 | 1.5 | 6 | STAT5A, …. |
| Kit receptor signaling pathway | 0.106 | 0.4 | 0.2 | 0.5 | 1.4 | 15 | STAT3, R…. |
| Angiopoietin Like Protein 8 Regulatory Pathway | 0.125 | 0.4 | 0.2 | 0.6 | 1.4 | 8 | RAF1, MA…. |

# Processing Data

## From RCC files

One Reporter Code Count (RCC) file is generated by the nCounter instrument for each sample, containing the counts for each gene and control in the codeset. It also includes some basic quality control (QC) metrics that can by imported by NanoTube. Two functions are provided in this package: `read_rcc`, which reads in a single RCC file, and `read_merge_rcc` which reads in a vector of RCC file names and combines the data.

`processNanostringData` includes the reading of these data files contained in `nsFiles`, merging with a sample meta-data table `sampleTab`, and other steps described below. Ideally, your sampleTab will have a column which contains the names of each respective RCC file so the expression data and meta-data can be matched properly: this is supplied to `processNanostringData` using the `idCol` option, which should be the name of the column with the RCC filenames. If this is not provided, the function will merge your meta-data table in its original order with the RCC files in alphabetical order, and a warning will be returned advising you to check that the merge was completed correctly (see examples).

`processNanostringData` also conducts optional quality control and normalization steps. These are described in the ‘Quality Control’ and ‘Normalization’ sections. Normalization can be skipped in this function using `normalization = "none"`. The housekeeping normalization step can be skipped (retaining positive control normalization) using `skip.housekeeping = TRUE`.

```
# Without supplying idCol, a warning is returned.
# The CSV file contains samples in the proper order, so this is technically ok.
dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             skip.housekeeping = FALSE,
                             output.format = "ExpressionSet")
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
```

```
## Warning in read_sampleData(dat, file.name = sampleTab, idCol = idCol, groupCol = groupCol, :
## idCol not provided. Assuming the first column of 'GSE117751_sample_data.csv' contains sample ID's.
```

```
## Warning in read_sampleData(dat, file.name = sampleTab, idCol = idCol, groupCol = groupCol, :
## Sample names in the two files don't match. NanoTube is
## assuming that samples are in the same order. Please confirm
## with your data.
```

```
##
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

```
# With idCol
dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             skip.housekeeping = FALSE,
                             output.format = "ExpressionSet")
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

## From Other files

Expression data can also be imported from a table in a .txt or .csv file, possibly produced by the RCC Collector tool.

```
csv_data <- system.file("extdata",
                        "GSE117751_expression_matrix.csv",
                        package = "NanoTube")

dat2 <- processNanostringData(nsFile = csv_data,
                             sampleTab = sample_info,
                             idCol = "GEO_Accession",
                             groupCol = "Sample_Diagnosis",
                             normalization = "none")
```

```
##
## Loading count data......
## Averaging technical replicates.....
```

## Normalization

This package provides four options for data normalization: a standard set of steps recommended by NanoString for nCounter data, which normalizes the data to different sets of control genes (NanoString Technologies 2011); the RUV-III (Remove Unwanted Variance III) method, which normalizes the data using technical replicates (Gagnon-Bartsch 2019); the RUVg method, which normalizes the data using specified control genes (Bhattacharya et al. 2020); or no normalization.

### nSolver Normalization

To normalize using standard nSolver steps, set `normalization` to “nSolver”. The three normalization steps under this method are:

1. Positive control normalization: The geometric mean of positive control probes is used to calculate a scaling factor for each sample.
2. Background assessment: Negative control probes are used to assess whether endogenous genes are truly expressed above the level of backgrounds. Two options are provided for this
   * `bgType = "threshold"` - The background threshold will be defined independently for each sample, using `threshold = bgThreshold * sd(NegativeControls) + mean(NegativeControls)`, where `bgThreshold` is set by the user. For each gene, the proportion of samples with expression above the threshold is calculated, and only genes with a proportion greater than `bgProportion` (set by user) will be retained for analysis. For example, if `bgThreshold` is 2 and `bgProportion` is 0.5 (defaults), a gene will be retained for analysis if its expression is 2 standard deviations above the mean of negative control probes in at least half of the samples.
   * `bgType = "t.test"` - Expression of each gene is compared with all of the negative control probes (across samples) using a one-sided, two-sample t test. Genes will be retained for analysis if the endogenous gene expression is greater, with p < `bgPVal`.
   * `bgSubtract` - By setting this to TRUE, the calculated background level (`mean + bgThreshold * sd`) will be subtracted from the expression values for each gene in each sample. After subtraction, genes with negative values will be set to zero.
3. Housekeeping normalization: The geometric mean of housekeeping gene expression is used to calculate a scaling factor for each sample. Housekeeping genes (symbols or accessions) can be input using the `housekeeping` option. If not provided, genes marked as “Housekeeping” in the RCC files will be used. Alternatively, this can be skipped using `skip.housekeeping = TRUE`.

```
# Set housekeeping genes manually (optional)
hk.genes <- c("TUBB", "TBP", "POLR2A", "GUSB", "SDHA")

dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             housekeeping = hk.genes, skip.housekeeping = FALSE)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

```
# Automatically detect housekeeping genes

dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

### RUV-III Normalization

The RUV-III method normalizes data based on technical replicates. Replicate IDs must be included in the sample information table (‘sampleTab’ in `processNanostringData`), and the column containing these IDs is specified using the ‘replicateCol’ option. Additionally, the number of dimensions of unwanted data can be specified using the ‘n.unwanted’ option. If NULL (the default), the maximum possible number of factors will be identified and used. More information can be found in (Gagnon-Bartsch 2019).

Note that RUVIII returns log-transformed counts, in contrast to nSolver and RUVg normalization. This difference is accounted for in subsequent NanoTube analysis steps, but it should be considered by the user when using the normalized data for other purposes.

```
# This sample data table contains fake replicate identifiers (for use in example).
sample_info_reps <- system.file("extdata",
                           "GSE117751_sample_data_replicates.csv",
                           package = "NanoTube")

datRUVIII <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info_reps,
                             idCol = "RCC_Name",
                             replicateCol = "Replicate_ID",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVIII",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Conducting RUVIII normalization......
```

RUV-III can also be used without technical replicates, by generating PRPS (pseudo-replicates of pseudo-samples). This is described in (Molania et al. 2022), and it was demonstrated to provide superior normalization vs. other RNA-Seq normalization methods for TCGA RNA-Seq data sets. Software and vignettes for accomplishing this normalization can be found at <https://github.com/RMolania/TCGA_PanCancer_UnwantedVariation>.

### RUVg Normalization

The RUVg method normalizes data based on housekeeping genes. These can be manually specified using the ‘housekeeping’ option in `processNanostringData`, or they can be automatically interpreted based on the CodeClass column of the RCC files. By default, RUVg will remove one dimension of unwanted data, but this can be adjusted using the ‘n.unwanted’ option. Additionally, the ‘RUVg.drop’ option can be used to drop some number of singular values. This defaults to zero, but it can be adjusted if the first singular value(s) identify the effect of interest. See (Bhattacharya et al. 2020) for more details.

```
hk.genes <- c("TUBB", "TBP", "POLR2A", "GUSB", "SDHA")

datRUVg <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVg",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1, RUVg.drop = 0,
                             housekeeping = hk.genes)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Conducting RUVg normalization......
```

```
# Housekeeping genes are automatically identified
datRUVg <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVg",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1, RUVg.drop = 0)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Conducting RUVg normalization......
```

## Assessing Normalization Performance

### RLE Plots

Relative Log Expression (RLE) plots have been demonstrated as effective visualizations to assess whether NanoString data normalization has been successful (Gandolfo and Speed 2018). This method centers the log-expression of each gene to the median log-expression of that gene. The RUV implementation `ruv_rle` can be used to generate this plot, regardless of what normalization method was used (Gagnon-Bartsch 2019).

Note that for this function, you need to log-transform and transpose the expression data matrix. You’ll probably want to set the y-axis limits as well, using ‘ylim’.

```
# Here's how to do it with the NanoString ExpressionSet. If your data set is in
# list form, you would use dat$exprs instead of exprs(dat).

ruv::ruv_rle(t(log2(exprs(dat))), ylim = c(-2, 2))
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the ruv package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### Principal components analysis

PCA can be conducted after processing and normalization. We provide a standard plot using `ggplot2` or an interactive plot using `plotly` (use the `interactive.plot` option).

```
dat <- processNanostringData(example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test",
                             bgPVal = 0.01)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

```
library(plotly)
nanostringPCA(dat, interactive.plot = TRUE)$plt
```

We default to plotting the first two principal components, but you can also choose others.

```
nanostringPCA(dat, pc1=3, pc2=4, interactive.plot = FALSE)$plt
```

![](data:image/png;base64...)

# Quality Control

NanoTube provides the quality control metrics recommended for NanoString nCounter data. The raw NanoString data can be loaded for QC using the `output.format = "list"` option of `processNanostringData`.

```
dat <- processNanostringData(example_data,
                             idCol = "RCC_Name",
                             output.format = "list",
                             includeQC = TRUE)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

Basic QC and cartridge data are loaded in from the RCC files if `includeQC` is set to TRUE.

```
head(dat$qc)[,1:5]
```

```
##                                   FovCount FovCounted ScannerID   StagePosition
## GSM3308226_20160715_5609WV-C.RCC  "280"    "280"      "1504C0267" "2"
## GSM3308227_20170504_6090AA-A2.RCC "280"    "280"      "1504C0267" "4"
## GSM3308228_20170504_6121PF-A2.RCC "280"    "280"      "1504C0267" "4"
## GSM3308229_20170504_5993KP-A2.RCC "280"    "280"      "1504C0267" "4"
## GSM3308230_20170504_6536VE-A2.RCC "280"    "280"      "1504C0267" "4"
## GSM3308231_20170504_6568NC-A2.RCC "280"    "278"      "1504C0267" "4"
##                                   BindingDensity
## GSM3308226_20160715_5609WV-C.RCC  "0.66"
## GSM3308227_20170504_6090AA-A2.RCC "0.93"
## GSM3308228_20170504_6121PF-A2.RCC "0.97"
## GSM3308229_20170504_5993KP-A2.RCC "0.77"
## GSM3308230_20170504_6536VE-A2.RCC "0.62"
## GSM3308231_20170504_6568NC-A2.RCC "0.62"
```

Positive QC statistics can be calculated and presented as a table. This includes the positive scaling factors and R-squared values for the expected vs. observed positive control counts. NanoString recommends positive scaling factors between 0.3 and 3, and R-squared values greater than 0.95. Samples with values outside these recommendations should be investigated further.

```
posQC <- positiveQC(dat)

knitr::kable(head(posQC$tab),
      row.names = FALSE, format = "html", align = "c", digits = 2)
```

| Sample | Scale.Factor | R.squared |
| --- | --- | --- |
| GSM3308226\_20160715\_5609WV-C.RCC | 0.63 | 0.99 |
| GSM3308227\_20170504\_6090AA-A2.RCC | 0.94 | 0.98 |
| GSM3308228\_20170504\_6121PF-A2.RCC | 1.11 | 0.98 |
| GSM3308229\_20170504\_5993KP-A2.RCC | 1.11 | 0.98 |
| GSM3308230\_20170504\_6536VE-A2.RCC | 1.07 | 0.99 |
| GSM3308231\_20170504\_6568NC-A2.RCC | 1.14 | 0.98 |

Positive control genes can be plotted for all samples (default), or a specified subset of samples (specified by column index, or sample names).

```
posQC2 <- positiveQC(dat, samples = 1:6)

posQC2$plt
```

![](data:image/png;base64...)

Standard negative control statistics can be obtained using the `negativeQC` function.

```
negQC <- negativeQC(dat, interactive.plot = FALSE)

knitr::kable(head(negQC$tab),
      row.names = TRUE, format = "html", align = "c")
```

|  | Mean (Neg) | Max (Neg) | sd (Neg) | Background cutoff | Genes below BG (%) |
| --- | --- | --- | --- | --- | --- |
| GSM3308226\_20160715\_5609WV-C.RCC | 6.13 | 14.23 | 5.63 | 17.39 | 120 (20.7%) |
| GSM3308227\_20170504\_6090AA-A2.RCC | 11.20 | 18.14 | 5.62 | 22.43 | 136 (23.5%) |
| GSM3308228\_20170504\_6121PF-A2.RCC | 13.52 | 30.65 | 8.75 | 31.02 | 154 (26.6%) |
| GSM3308229\_20170504\_5993KP-A2.RCC | 10.48 | 20.73 | 6.02 | 22.51 | 148 (25.6%) |
| GSM3308230\_20170504\_6536VE-A2.RCC | 10.17 | 15.91 | 3.52 | 17.21 | 146 (25.2%) |
| GSM3308231\_20170504\_6568NC-A2.RCC | 10.20 | 23.68 | 7.52 | 25.23 | 170 (29.4%) |

Negative control genes can also be plotted for each sample.

```
negQC$plt
```

![](data:image/png;base64...)

Housekeeping normalization scale factors can also be obtained from the processed data. Manufacturer recommends additional caution for samples with scale factors outside the range of 0.1-10.

```
signif(head(dat$hk.scalefactors), digits = 2)
```

```
##  GSM3308226_20160715_5609WV-C.RCC GSM3308227_20170504_6090AA-A2.RCC
##                              1.30                              1.00
## GSM3308228_20170504_6121PF-A2.RCC GSM3308229_20170504_5993KP-A2.RCC
##                              0.97                              0.71
## GSM3308230_20170504_6536VE-A2.RCC GSM3308231_20170504_6568NC-A2.RCC
##                              0.62                              0.53
```

# Data Analysis

## Differential expression analysis

### Using Limma

After normalization, the data are likely to resemble a normal distribution, particularly with reasonable filtering of genes with expression below background levels. It is a good idea to check this before using limma (Ritchie et al. 2015). See `limma` vignette for full details and additional analysis options.

Assuming this information was provided in the `processNanostringData` step, your ExpressionSet will already contain the sample groups.

```
dat <- processNanostringData(example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test",
                             bgPVal = 0.01)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

```
table(dat$groups)
```

```
##
## Autoimmune retinopathy                   None   Retinitis pigmentosa
##                     14                     14                     14
```

`runLimmaAnalysis` allows you to conduct group-vs-group comparisons by defining the `base.group`. In this example, setting `base.group` to “None” will cause Limma to build a linear model fitting the expression data, where the intercept is the average log2 expression of “None”, and the two other coefficients will correspond to the log2(FC) of Autoimmune retinopathy vs. None and Retinitis pigmentosa vs. None. This function will return standard Limma analysis results.

```
limmaResults <- runLimmaAnalysis(dat, base.group = "None")

head(signif(limmaResults$coefficients, digits = 2))
```

```
##          Intercept Autoimmune.retinopathy Retinitis.pigmentosa
## HLA-DQB1       7.4                  -0.91              -1.6000
## KIT            3.8                   0.14              -0.0098
## LAG3           6.3                  -0.37              -0.0640
## SOCS3          7.2                   0.16               0.0900
## TCF7          10.0                  -0.11               0.0520
## IKBKB          7.8                   0.42               0.1100
```

You can also directly define a design matrix, instead. For example, if this data were collected in two batches, you could include a batch term in the analysis.

```
# Generate fake batch labels
batch <- rep(c(0, 1), times = ncol(dat) / 2)

# Reorder groups ("None" first)
group <- factor(dat$groups,
                levels = c("None", "Autoimmune retinopathy",
                           "Retinitis pigmentosa"))

# Design matrix including sample group and batch
design <- model.matrix(~group + batch)

# Analyze data
limmaResults2 <- runLimmaAnalysis(dat, design = design)

# We can see there is no batch effect in this data, due to the somewhat uniform
# distribution of p-values. This is good, since the batches are fake.
hist(limmaResults2$p.value[,"batch"], main = "p-values of Batch terms")
```

![](data:image/png;base64...)

Alternatively, a design matrix can be provided as ‘sampleData’ in the `processNanostringData` step. This one contains columns for the Intercept, the two diagnoses, and patient Age.

```
sample_info_design <- system.file("extdata",
                           "GSE117751_design_matrix.csv",
                           package = "NanoTube")

datDes <- processNanostringData(example_data,
                             sampleTab = sample_info_design,
                             idCol = "RCC_Name",
                             normalization = "nSolver",
                             bgType = "t.test",
                             bgPVal = 0.01)
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
## Calculating positive scale factors......
## Checking endogenous genes against background threshold......
## Conducting housekeeping normalization......
```

```
head(pData(datDes))
```

```
##                                                            RCC_Name Intercept
## GSM3308226_20160715_5609WV-C.RCC   GSM3308226_20160715_5609WV-C.RCC         1
## GSM3308227_20170504_6090AA-A2.RCC GSM3308227_20170504_6090AA-A2.RCC         1
## GSM3308228_20170504_6121PF-A2.RCC GSM3308228_20170504_6121PF-A2.RCC         1
## GSM3308229_20170504_5993KP-A2.RCC GSM3308229_20170504_5993KP-A2.RCC         1
## GSM3308230_20170504_6536VE-A2.RCC GSM3308230_20170504_6536VE-A2.RCC         1
## GSM3308231_20170504_6568NC-A2.RCC GSM3308231_20170504_6568NC-A2.RCC         1
##                                   Autoimmune_retinopathy Retinitis_Pigmentosa
## GSM3308226_20160715_5609WV-C.RCC                       1                    0
## GSM3308227_20170504_6090AA-A2.RCC                      1                    0
## GSM3308228_20170504_6121PF-A2.RCC                      1                    0
## GSM3308229_20170504_5993KP-A2.RCC                      1                    0
## GSM3308230_20170504_6536VE-A2.RCC                      1                    0
## GSM3308231_20170504_6568NC-A2.RCC                      1                    0
##                                   Age normalization
## GSM3308226_20160715_5609WV-C.RCC   61       nSolver
## GSM3308227_20170504_6090AA-A2.RCC  71       nSolver
## GSM3308228_20170504_6121PF-A2.RCC  71       nSolver
## GSM3308229_20170504_5993KP-A2.RCC  66       nSolver
## GSM3308230_20170504_6536VE-A2.RCC  71       nSolver
## GSM3308231_20170504_6568NC-A2.RCC  59       nSolver
```

We can then use this pData object as our design matrix in limma analysis. Note that `processNanostringData` adds an additional column at the beginning and the end, so these should be removed for limma analysis. Based on this analysis, many genes appear to be correlated with patient age.

```
# Analyze data
limmaResults3 <- runLimmaAnalysis(datDes,
                                  design = pData(datDes)[,2:(ncol(pData(datDes))-1)])

hist(limmaResults3$p.value[,"Age"], main = "p-values for Age term")
```

![](data:image/png;base64...)

Results of Limma analyses can be visualized using simple volcano plots.

```
deVolcano(limmaResults, y.var = "p.value")
```

```
##
## 'plotContrast' not provided, setting it to Autoimmune.retinopathy
```

![](data:image/png;base64...)

You can add additional ggplot layers as well.

```
deVolcano(limmaResults, plotContrast = "Autoimmune.retinopathy",
          y.var = "p.value") +
  geom_hline(yintercept = 2, linetype = "dashed", colour = "darkred") +
  geom_vline(xintercept = 0.5, linetype = "dashed", colour = "darkred") +
  geom_vline(xintercept = -0.5, linetype = "dashed", colour = "darkred")
```

![](data:image/png;base64...)

They can also be converted to a simple table or exported to a text file.

```
limmaStats <- makeDiffExprFile(limmaResults, filename = NULL, returns = "stats")
limmaStats <- as.data.frame(limmaStats)

# Order by lowest to highest p-value for 'Autoimmune Retinopathy' vs. 'None'
knitr::kable(head(limmaStats[order(limmaStats$`p-val (Autoimmune.retinopathy)`,
                                   decreasing = FALSE),]),
      row.names = TRUE, format = "html", align = "c")
```

|  | Log2FC (Autoimmune.retinopathy) | t (Autoimmune.retinopathy) | p-val (Autoimmune.retinopathy) | q-val (Autoimmune.retinopathy) | Log2FC (Retinitis.pigmentosa) | t (Retinitis.pigmentosa) | p-val (Retinitis.pigmentosa) | q-val (Retinitis.pigmentosa) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| IKBKB | 0.42 | 4.9 | 1.4e-05 | 0.0065 | 0.11 | 1.3 | 0.2000 | 0.73 |
| MIF | -0.54 | -4.3 | 8.5e-05 | 0.0180 | -0.24 | -1.9 | 0.0620 | 0.66 |
| IL8 | -1.20 | -4.2 | 1.2e-04 | 0.0180 | -0.59 | -2.0 | 0.0480 | 0.66 |
| CR1 | 0.70 | 4.1 | 1.8e-04 | 0.0210 | 0.43 | 2.5 | 0.0150 | 0.62 |
| PLAU | 0.92 | 4.0 | 2.6e-04 | 0.0240 | 0.63 | 2.7 | 0.0093 | 0.62 |
| ITGAM | 0.65 | 3.9 | 3.0e-04 | 0.0240 | 0.37 | 2.2 | 0.0310 | 0.62 |

### Using NanoStringDiff

NanoStringDiff models the data using a negative binomial approximation, which has been shown to be generally more accurate for gene expression count data (Wang et al. 2016). We have provided a function to convert processed, unnormalized, data to a `NanoStringSet` for use with NanoStringDiff.

```
# Remember to set normalization = "none"
datNoNorm <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "none")
```

```
##
## Reading in .RCC files......
## Checking codeset contents......
## Checked gene name consistency in .RCC files.
## 15 genes labeled as 'housekeeping'.
## Averaging technical replicates.....
```

```
nsDiffSet <- makeNanoStringSetFromEset(datNoNorm)

colnames(pData(nsDiffSet))
```

```
## [1] "Autoimmune retinopathy" "None"                   "Retinitis pigmentosa"
```

Then you can run as described in the NanoStringDiff vignette (see vignette for full details). Notably, the glm.LRT step is very slow for sample sizes above 10 (and may still be slow with fewer samples). Interested users could also consider using DESeq2 if a negative binomial method is desired, although that method would not explicitly handle the various control genes (Love, Huber, and Anders 2014).

```
### This block is not run! ###

# This step is fast
nsDiffSet <- NanoStringDiff::estNormalizationFactors(nsDiffSet)

# This step likely to take multiple hours on standard desktop computers.
result <- NanoStringDiff::glm.LRT(nsDiffSet,
                                  design.full = as.matrix(pData(nsDiffSet)),
                                  contrast = c(1, -1, 0))
                                  #Contrast: Autoimmune retinopathy vs. None
```

## Gene set analysis

Gene Set Enrichment Analysis can be conducted on the Limma results using the `fgsea` package (Sergushichev 2016). Before running it, it is useful to consider whether Gene Set Enrichment Analysis is appropriate for your specific data set, based on the number and types of genes represented in your chip, and whether any of them were actually differentially expressed.

Gene set databases can be loaded as a list object (either directly or in an .rds file), or as a .gmt (MSigDB or similar) or .tab (CPDB) file. We have included a list of pathways from WikiPathways (Martens et al. 2021).

The `min.set` option is important, as pathways containing only a few genes present in your data set will probably not provide informative enrichment statistics. We will discard all gene sets where fewer than `min.set` genes from that set are present in the analysis. You also have the option to rank genes by ‘coefficients’ (frequently, the log2FC) or the ‘t’ statistics. `skip.first` will skip the first column of the limma design if TRUE (default). Generally, this column is the Intercept of the regression, which is not useful for gene set analysis.

The `limmaToFGSEA` function will then conduct preranked analysis using `fgsea` for each column in the Limma coefficients or t-statistic matrix (possibly skipping the first). The output will be a list object containing the results for each analysis.

```
data("ExamplePathways")

fgseaResults <- limmaToFGSEA(limmaResults, gene.sets = ExamplePathways,
                            min.set = 5, rank.by = "t",
                            skip.first = TRUE)

names(fgseaResults)
```

```
## [1] "Autoimmune.retinopathy" "Retinitis.pigmentosa"
```

We can order the pathways by p-value and view the top results. As previously reported in (Lundy et al. 2018), we see that immune pathways are significantly altered in autoimmune retinopathy patients. We also identify EGFR Signaling as a potential pathway of interest.

```
fgseaTab <- head(fgseaResults$Autoimmune.retinopathy[
             order(fgseaResults$Autoimmune.retinopathy$pval,
                   decreasing = FALSE),])
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab,
      row.names = FALSE, format = "html", align = "c")
```

| pathway | pval | padj | log2err | ES | NES | size | leadingEdge |
| --- | --- | --- | --- | --- | --- | --- | --- |
| EGF/EGFR Signaling Pathway | 0.001 | 0.01 | 0.5 | 0.7 | 2.0 | 15 | STAT5A, …. |
| IL-1 signaling pathway | 0.006 | 0.03 | 0.4 | 0.6 | 1.7 | 19 | IKBKB, I…. |
| White fat cell differentiation | 0.006 | 0.03 | 0.4 | 0.8 | 1.7 | 6 | STAT5A, …. |
| Kit receptor signaling pathway | 0.020 | 0.07 | 0.4 | 0.5 | 1.6 | 16 | STAT5A, …. |
| Angiopoietin Like Protein 8 Regulatory Pathway | 0.027 | 0.07 | 0.4 | 0.7 | 1.7 | 9 | RAF1, MA…. |
| B Cell Receptor Signaling Pathway | 0.039 | 0.08 | 0.3 | 0.4 | 1.4 | 31 | IKBKB, R…. |

Another similar function, `nsdiffToFGSEA`, is provided to conduct fgsea on `NanoStringDiff` results. This one conducts analysis on a single preranked list.

After analysis, the leading edge genes can be extracted for gene sets (with some cutoff for enrichment statistics) using `fgseaToLEdge`.

```
# Leading edge for pathways with adjusted p < 0.2
leading.edge <- fgseaToLEdge(fgsea.res = fgseaResults,
                             cutoff.type = "padj", cutoff = 0.2)
```

The nominal p-value or NES (normalized enrichment score) can also be used as a cutoff. If NES is used, you can either select all gene sets with abs(NES) > cutoff, if `nes.abs.cutoff == TRUE`. Otherwise, you can select gene sets with NES > cutoff (if cutoff > 0) or NES < cutoff (if cutoff < 0).

```
# Leading edge for pathways with abs(NES) > 1
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = 1,
                                nes.abs.cutoff = TRUE)

# Leading edge for pathways with NES > 1.5
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = 1.5,
                                nes.abs.cutoff = FALSE)

# Leading edge for pathways with NES < -0.5
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = -0.5,
                                nes.abs.cutoff = FALSE)
```

A basic leading edge heatmap can then be drawn using the `pheatmap` package.

```
pheatmap::pheatmap(t(leading.edge$Autoimmune.retinopathy),
                   legend = FALSE,
                   color = c("white", "black"))
```

![](data:image/png;base64...)

You can further cluster pathways by their leading edge genes. This is particularly useful when you have lots (tens to hundreds) of significantly enriched pathways, as you can prioritize certain ones or potentially identify overarching patterns of pathway enrichment. We recommend clustering pathways by the binary distance (also known as the Jaccard index), which for two gene sets will be the number of genes shared by the gene sets, divided by the total number of genes in either of the two gene sets.

```
# Group pathways with a binary distance below 0.5
fgsea.grouped <- groupFGSEA(fgseaResults$Autoimmune.retinopathy,
                                   leading.edge$Autoimmune.retinopathy,
                                   join.threshold = 0.5,
                                   dist.method = "binary")

fgseaTab <- head(fgsea.grouped)
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab,
      row.names = FALSE, format = "html", align = "c")
```

| pathway | p.val | p.adj | log2err | ES | NES | size | Cluster | Cluster.Max | RAF1 | MAPK1 | MAPK14 | MAP4K4 | MAPK11 | MAP4K2 | IKBKB | SYK | PTPN6 | BCL6 | IKBKG | STAT5A | STAT3 | JAK1 | STAT5B | SRC | ABL1 | PRKCD | IL1B | IL1R1 | MAPKAPK2 | TOLLIP | IRAK3 | IRAK2 | NFKBIA | NFKB1 | TRAF6 | CEBPB | IRF3 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EGF/EGFR Signaling Pathway | 0.001 | 0.01 | 0.5 | 0.7 | 2.0 | 15 | 1 | x | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Kit receptor signaling pathway | 0.020 | 0.07 | 0.4 | 0.5 | 1.6 | 16 | 1 |  | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| IL-1 signaling pathway | 0.006 | 0.03 | 0.4 | 0.6 | 1.7 | 19 | 2 | x | 0 | 1 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
| White fat cell differentiation | 0.006 | 0.03 | 0.4 | 0.8 | 1.7 | 6 | 3 | x | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
| Angiopoietin Like Protein 8 Regulatory Pathway | 0.027 | 0.07 | 0.4 | 0.7 | 1.7 | 9 | 4 | x | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| B Cell Receptor Signaling Pathway | 0.039 | 0.08 | 0.3 | 0.4 | 1.4 | 31 | 5 | x | 1 | 1 | 1 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

In this example, only “EGF/EGFR Signaling Pathway” and “Kit receptor signaling pathway” are sufficiently similar to be clustered together (“Cluster 1”), and the other four pathways are deemed unique. In the heatmap above, we see that the Kit receptor pathway contains only one leading edge gene unique from the EGF/EGFR pathway (PTPN6). Based on a lower p-value and higher NES, you would consider EGFR Signaling to be more important in this analysis, while the Kit receptor pathway is largely redundant. This is denoted by the “Cluster.Max” variable, which identifies maximum enrichment in each cluster with an “x”.

### Exporting GSEA results

`fgseaPostprocessingXLSX` allows you to output the results of gene set analyses to an Excel spreadsheet (`fgsePostprocessing` is similar, and provides .txt files). A summary sheet shows the overall GSEA results, while an additional table for each separate analysis (A vs. Control, B vs. Control, etc.) shows the differential expression statistics and expression profiles for leading edge genes. This step requires input of the FGSEA results, the leading edge results, and the Limma results. It will cluster the pathways if specified, prior to generating results tables.

```
fgseaPostprocessingXLSX(genesetResults = fgseaResults,
                        leadingEdge = leading.edge,
                        limmaResults = limmaResults,
                        join.threshold = 0.5,
                        filename = "analysis.xlsx")
```

You can also use `groupedGSEAtoStackedReport` to generate the gene-level report for one comparison.

```
results.AR <- groupedGSEAtoStackedReport(
    fgsea.grouped,
    leadingEdge = leading.edge$Autoimmune.retinopathy,
    de.fit = limmaResults)

# View Cluster 1 gene statistics
resultsTab <- results.AR[results.AR$Cluster == 1, 1:6]
resultsTab[,2:6] <- lapply(resultsTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(resultsTab,
      row.names = FALSE, format = "html", align = "c")
```

| Symbol | Cluster | Log2FC (Autoimmune.retinopathy) | t (Autoimmune.retinopathy) | p-val (Autoimmune.retinopathy) | q-val (Autoimmune.retinopathy) |
| --- | --- | --- | --- | --- | --- |
| ABL1 | 1 | 0.2 | 1.5 | 1e-01 | 0.36 |
| JAK1 | 1 | 0.3 | 2.9 | 5e-03 | 0.08 |
| MAPK1 | 1 | 0.2 | 2.6 | 1e-02 | 0.12 |
| MAPK14 | 1 | 0.3 | 2.2 | 3e-02 | 0.16 |
| PRKCD | 1 | 0.2 | 1.3 | 2e-01 | 0.43 |
| PTPN6 | 1 | 0.3 | 2.4 | 2e-02 | 0.13 |
| RAF1 | 1 | 0.4 | 3.3 | 2e-03 | 0.06 |
| SRC | 1 | 0.3 | 1.5 | 1e-01 | 0.35 |
| STAT3 | 1 | 0.5 | 3.4 | 1e-03 | 0.05 |
| STAT5A | 1 | 0.4 | 3.7 | 7e-04 | 0.04 |
| STAT5B | 1 | 0.3 | 2.2 | 3e-02 | 0.16 |

# References

Bhattacharya, Arjun, Alina M Hamilton, Helena Furberg, Eugene Pietzak, Mark P Purdue, Melissa A Troester, Katherine A Hoadley, and Michael I Love. 2020. “An Approach for Normalization and Quality Control for NanoString RNA Expression Data.” *Brief Bioinform* 22 (3): bbaa163. <https://doi.org/10.1093/bib/bbaa163>.

Gagnon-Bartsch, Johann. 2019. *Ruv: Detect and Remove Unwanted Variation Using Negative Controls*. [https://CRAN.R-project.org/package=ruv](https://CRAN.R-project.org/package%3Druv).

Gandolfo, Luke C., and Terence P. Speed. 2018. “RLE Plots: Visualizing Unwanted Variation in High Dimensional Data.” *PLOS ONE* 13 (2): e0191629. <https://doi.org/10.1371/journal.pone.0191629>.

Love, Michael I, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for RNA-Seq Data with DESeq2.” *Genome Biology* 15 (12). <https://doi.org/10.1186/s13059-014-0550-8>.

Lundy, Steven K., Enayat Nikoopour, Athanasios J. Karoukis, Ray Ohara, Mohammad I. Othman, Rebecca Tagett, K. Thiran Jayasundera, and John R. Heckenlively. 2018. “T Helper 1 Cellular Immunity Toward Recoverin Is Enhanced in Patients with Active Autoimmune Retinopathy.” *Frontiers in Medicine* 5: 249. <https://doi.org/10.3389/fmed.2018.00249>.

Martens, Marvin, Ammar Ammar, Anders Riutta, Andra Waagmeester, Denise N Slenter, Kristina Hanspers, Ryan A. Miller, et al. 2021. “WikiPathways: Connecting Communities.” *Nucleic Acids Research* 49 (D1): D613–D621. <https://doi.org/10.1093/nar/gkaa1024>.

Molania, Ramyar, Momeneh Foroutan, Johann A. Gagnon-Bartsch, Luke C. Gandolfo, Aryan Jain, Abhishek Sinha, Gavriel Olshansky, Alexander Dobrovic, Anthony T. Papenfuss, and Terence P. Speed. 2022. “Removing Unwanted Variation from Large-Scale RNA Sequencing Data with PRPS.” *Nat Biotechnol*, September, 1–14. <https://doi.org/10.1038/s41587-022-01440-w>.

NanoString Technologies, Inc. 2011. *nCounter Expression Data Analysis Guide*. NanoString Technologies, Inc. <https://www.genetics.pitt.edu/sites/default/files/pdfs/nCounter_Gene_Expression_Data_Analysis_Guidelines.pdf>.

Ritchie, Matthew E., Belinda Phipson, Di Wu, Yifang Hu, Charity W. Law, Wei Shi, and Gordon K. Smyth. 2015. “Limma Powers Differential Expression Analyses for RNA-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47.

Sergushichev, Alexey. 2016. “An Algorithm for Fast Preranked Gene Set Enrichment Analysis Using Cumulative Statistic Calculation.” *bioRxiv*. <https://doi.org/10.1101/060012>.

Wang, Hong, Craig Horbinski, Hao Wu, Yinxing Liu, Shaoyi Sheng, Jinpeng Liu, Heidi Weiss, Arnold J. Stromberg, and Chi Wang. 2016. “NanoStringDiff: A Novel Statistical Method for Differential Expression Analysis Based on NanoString nCounter Data.” *Nucleic Acids Research* 44 (20): e151–e151. <https://doi.org/10.1093/nar/gkw677>.