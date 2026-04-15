---
name: bioconductor-msstats
description: MSstats performs statistical analysis of quantitative proteomics data through preprocessing and differential abundance testing using linear mixed-effects models. Use when user asks to normalize proteomics data, perform protein-level summarization, test for differential protein abundance, or visualize results with volcano plots and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstats.html
---

# bioconductor-msstats

## Overview
The `MSstats` package provides a robust framework for the statistical analysis of quantitative proteomics data. It handles data preprocessing (normalization, imputation, and summarization) and performs differential abundance testing using linear mixed-effects models. It is compatible with outputs from various processing tools like Skyline, MaxQuant, Spectronaut, and Proteome Discoverer.

## Core Workflow

### 1. Data Import and Conversion
Convert tool-specific output into the MSstats standard format using the appropriate converter from `MSstats` or `MSstatsConvert`.

```r
library(MSstats)
library(MSstatsConvert)

# Example: Converting Spectronaut output
raw_data <- read.csv("spectronaut_report.csv")
annot <- read.csv("annotation.csv")

input_data <- SpectronauttoMSstatsFormat(
  raw_data, 
  annotation = annot,
  useUniquePeptide = TRUE,
  fewMeasurements = "remove"
)
```

Common converters include: `SkylinetoMSstatsFormat`, `MaxQtoMSstatsFormat`, `PDtoMSstatsFormat`, `SpectronauttoMSstatsFormat`, and `ProgenesistoMSstatsFormat`.

### 2. Data Preprocessing
The `dataProcess` function performs log transformation, normalization, and protein-level summarization.

```r
processed_data <- dataProcess(
  input_data,
  logTrans = 2,
  normalization = "equalizeMedians", # Options: "quantile", "globalStandards", FALSE
  summaryMethod = "TMP",            # Tukey's Median Polish (robust)
  MBimpute = TRUE                   # Impute missing values
)

# Visualize preprocessing results
dataProcessPlots(processed_data, type = "QCPlot")
dataProcessPlots(processed_data, type = "ProfilePlot")
```

### 3. Differential Abundance Analysis
Define a contrast matrix to compare specific conditions.

```r
# Check condition levels
levels(processed_data$ProcessedData$GROUP_ORIGINAL)

# Create contrast matrix (e.g., Condition2 vs Condition1)
comparison <- matrix(c(-1, 1, 0), nrow = 1)
row.names(comparison) <- "Cond2-Cond1"

test_results <- groupComparison(contrast.matrix = comparison, data = processed_data)

# View results
head(test_results$ComparisonResult)
```

### 4. Visualization of Results
Generate volcano plots, heatmaps, or comparison plots for the testing results.

```r
groupComparisonPlots(data = test_results$ComparisonResult, type = "VolcanoPlot")
groupComparisonPlots(data = test_results$ComparisonResult, type = "Heatmap")
```

## MSstats+ (Peak Quality-Weighted Analysis)
For DIA data, `MSstats+` incorporates spectral peak quality metrics (e.g., Shape Quality Score) into the analysis.

1. **Converter**: Set `calculateAnomalyScores = TRUE` in the converter.
2. **Summarization**: Use `summaryMethod = "linear"` in `dataProcess`.
3. **Testing**: `groupComparison` automatically uses the calculated variances for weighted inference.

## Sample Size Calculation
Calculate the number of biological replicates needed for future experiments based on current variance estimates.

```r
designSampleSize(
  data = test_results$fittedmodel, 
  desiredFC = c(1.25, 1.75), 
  FDR = 0.05, 
  power = 0.8,
  numSample = TRUE
)
```

## Tips for Success
- **Annotation**: Ensure your annotation file correctly maps `Run` to `Condition` and `BioReplicate`.
- **Normalization**: Use `QCPlot` to verify if normalization successfully removed systematic bias between runs.
- **Missing Values**: MSstats distinguishes between "Missing at Random" and "Censored" (below limit of detection). Use `censoredInt = "NA"` or `"0"` appropriately based on your processing tool.
- **Large Data**: For very large datasets, consider using the `MSstatsBig` extension.

## Reference documentation
- [MSstats: Protein/Peptide significance analysis](./references/MSstats.md)
- [MSstats+: Peak quality-weighted differential analysis](./references/MSstatsPlus.md)
- [MSstats: End to End Workflow](./references/MSstatsWorkflow.md)