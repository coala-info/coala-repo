---
name: bioconductor-metab
description: Bioconductor-metab processes and refines GC-MS metabolomics data previously analyzed by AMDIS. Use when user asks to merge AMDIS reports, recalculate metabolite abundances using specific ion fragments from raw CDF files, normalize metabolomics data, or perform statistical tests on GC-MS datasets.
homepage: https://bioconductor.org/packages/3.6/bioc/html/Metab.html
---

# bioconductor-metab

name: bioconductor-metab
description: Processing and refining metabolomics data from AMDIS (Automated Mass Spectral Deconvolution and Identification System). Use when needing to merge AMDIS reports, recalculate metabolite abundances using specific ion fragments from raw CDF files, normalize data by internal standards or biomass, and perform statistical tests (ANOVA/t-test) on GC-MS metabolomics datasets.

# bioconductor-metab

## Overview

The `Metab` package processes metabolomics data previously analyzed by AMDIS. It solves common AMDIS limitations by:
1. Selecting the most probable metabolite for each retention time (RT).
2. Merging individual sample reports into a single, analysis-ready spreadsheet.
3. Recalculating metabolite abundances using fixed ion mass fragments across all samples to ensure consistency.
4. Providing built-in functions for normalization and basic statistical testing.

## Core Workflows

### 1. Building an Ion Library
If you intend to recalculate abundances using specific mass fragments, you must first build an ion library from an AMDIS `.msl` file.

```r
library(Metab)
# Load an MSL file
data(exampleMSLfile) 
# Build the library
myLib <- buildLib(exampleMSLfile, save = FALSE)
```

### 2. Processing AMDIS Reports with Raw Data (CDF)
Use `MetReport` when you have both the AMDIS batch report and the original GC-MS files in CDF format. This allows for the most accurate quantification.

```r
# For a single file
results <- MetReport(inputData = "sample1.CDF",
                     singleFile = TRUE,
                     AmdisReport = "AMDIS_Batch_Report.txt",
                     ionLib = myLib,
                     abundance = "recalculate",
                     TimeWindow = 0.5,
                     save = FALSE)

# For a batch of files organized in folders by condition
# dataFolder should contain subfolders (e.g., /Control, /Treatment)
results_batch <- MetReport(dataFolder = "./data",
                           AmdisReport = "AMDIS_Batch_Report.txt",
                           ionLib = "myIonLib.csv",
                           abundance = "recalculate",
                           TimeWindow = 2.5,
                           save = TRUE,
                           output = "processed_metabolites")
```

### 3. Processing AMDIS Reports Only
If raw CDF files are unavailable, use `MetReportNames` to extract "Area" or "Base.Peak" directly from the AMDIS report.

```r
test <- MetReportNames(samples = c("Sample1_Name", "Sample2_Name"),
                       AmdisReport = exampleAMDISReport,
                       TimeWindow = 0.5,
                       base.peak = FALSE) # FALSE returns Area
```

## Data Normalization

Metab provides three primary ways to clean and normalize the resulting data frame.

### Remove False Positives
Filters metabolites based on their frequency of detection within experimental conditions.
```r
# Keep metabolites present in at least 40% of samples per condition
cleanData <- removeFalsePositives(results_batch, truePercentage = 40)
```

### Internal Standard Normalization
Divides all metabolite abundances in a sample by the abundance of a specified internal standard.
```r
normIS <- normalizeByInternalStandard(results_batch, 
                                      internalStandard = "Acetone")
```

### Biomass Normalization
Divides abundances by sample-specific biomass (e.g., cell count, OD, or weight). Requires a data frame with "Sample" and "Biomass" columns.
```r
# biomass_df: Column 1 = Sample Name, Column 2 = Numeric Value
normBio <- normalizeByBiomass(results_batch, 
                              biomass = biomass_df)
```

## Statistical Analysis

The `htest` function performs automated t-tests or ANOVA across the experimental conditions defined in the first row of the Metab data frame.

```r
# Perform t-test with Bonferroni correction
stats_results <- htest(results_batch, 
                       signif.level = 0.05, 
                       StatTest = "T")

# Perform ANOVA
anova_results <- htest(results_batch, 
                       signif.level = 0.05, 
                       StatTest = "Anova")
```

## Reference documentation

- [MetabPackage](./references/MetabPackage.md)