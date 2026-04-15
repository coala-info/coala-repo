---
name: bioconductor-ddct
description: This tool analyzes quantitative real-time PCR data using the 2^-ddCt method to determine relative gene expression levels. Use when user asks to import SDS files, normalize Ct values with housekeeping genes, calculate relative quantification against reference samples, or visualize fold changes with error bars.
homepage: https://bioconductor.org/packages/release/bioc/html/ddCt.html
---

# bioconductor-ddct

name: bioconductor-ddct
description: Analysis of quantitative real-time PCR (qRT-PCR) data using the 2^-ddCt method. Use this skill when performing end-to-end RT-PCR data analysis in R, including data importing (SDS files), normalization with housekeeping genes, relative quantification against reference samples, and visualization of fold changes.

# bioconductor-ddct

## Overview
The `ddCt` package implements the $2^{-\Delta\Delta C_T}$ algorithm for analyzing relative gene expression from quantitative real-time PCR (qRT-PCR) experiments. It automates the pipeline of importing raw $C_T$ values, normalizing against housekeeping genes ($\Delta C_T$), calculating relative expression against a reference/calibrator sample ($\Delta\Delta C_T$), and calculating error estimates (SD or MAD).

## Core Workflow

### 1. Data Import
The package primarily handles tab-delimited text files exported from PCR software (e.g., SDS or SDM software). Use `SDMFrame` to load one or multiple files.

```r
library(ddCt)

# Load raw Ct data
files <- c("Experiment1.txt", "Experiment2.txt")
ctData <- SDMFrame(files)

# Optional: Load sample annotation
# The first column must be named 'Sample'
sampleInfo <- read.AnnotatedDataFrame("SampleAnno.txt", header=TRUE, row.names=NULL)
```

### 2. Relative Quantification
The `ddCtExpression` function performs the core calculations. You must specify the housekeeping gene(s) and the reference (calibration) sample(s).

```r
result <- ddCtExpression(ctData,
                         calibrationSample = "ControlSample",
                         housekeepingGene = "GAPDH",
                         sampleInformation = sampleInfo,
                         type = "mean") # or "median" for robust summarization
```

### 3. Accessing Results
The result object contains various calculated values accessible via specific methods:
- `Ct(result)`: Merged $C_T$ values.
- `dCt(result)`: Normalized values ($\Delta C_T$).
- `ddCt(result)`: Relative values ($\Delta\Delta C_T$).
- `exprs(result)`: Final relative expression levels ($2^{-\Delta\Delta C_T}$).
- `CtErr(result)`: Error estimates for the values.

### 4. Visualization and Export
The package provides built-in lattice-based plotting and text export.

```r
# Create a barchart with error bars
errBarchart(result)

# Export all calculated values to a tab-delimited file
elistWrite(result, file="analysis_results.txt")
```

## High-Level Pipeline (ddCtExec)
For a more automated, script-like approach, use `ddCtExec` with a parameter list. This is useful for reproducible pipelines.

```r
params <- list(
  inputFile = "Experiment1.txt",
  referenceGene = c("Gene1", "Gene2"),
  referenceSample = "Sample1",
  mode = "median",
  plotMode = c("level", "Ct")
)

# Executes import, analysis, and report generation
ddCtExec(params)
```

## Key Parameters and Tips
- **Housekeeping Genes**: If multiple genes are provided, the mean $C_T$ is used for normalization.
- **Reference Samples**: If multiple samples are provided, the mean $\Delta C_T$ is used as the reference line.
- **Efficiencies**: You can provide specific amplification efficiencies per gene using the `efficiencies` parameter in `ddCtExec` or specialized algorithm classes. Note that if efficiencies are used, $\Delta C_T$ and $\Delta\Delta C_T$ values are not calculated (only raw $C_T$ and final levels).
- **Thresholding**: Use `threshold = 40` (default) to treat high $C_T$ values as "undetermined".
- **Summarization**: Use `mode = "median"` instead of "mean" if you have many technical replicates or potential outliers.

## Reference documentation
- [The analysis of rtPCR data](./references/RT-PCR-Script-ddCt.md)
- [Analyse RT–PCR data with ddCt](./references/rtPCR-usage.md)
- [ddCt method for qRT–PCR data analysis](./references/rtPCR.md)