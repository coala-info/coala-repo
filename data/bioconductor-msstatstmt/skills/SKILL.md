---
name: bioconductor-msstatstmt
description: thoughtfulThis tool performs statistical analysis and differential abundance testing for TMT-labeled mass spectrometry proteomic data. Use when user asks to convert data from processing tools, perform protein summarization with normalization, or execute group comparisons for differential abundance.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsTMT.html
---


# bioconductor-msstatstmt

name: bioconductor-msstatstmt
description: Statistical analysis of TMT (Tandem Mass Tag) proteomic data using MSstatsTMT. Use this skill to convert data from various processing tools (MaxQuant, Proteome Discoverer, SpectroMine, OpenMS, FragPipe/Philosopher), perform protein summarization with normalization, and execute group comparisons for differential abundance testing.

## Overview

MSstatsTMT is an R package designed for the statistical analysis of TMT-labeled mass spectrometry proteomics experiments. It handles the complexities of TMT data, including multiple mixtures, technical replicates, and reference channels. The workflow typically involves three main stages: data conversion, protein-level summarization (including normalization), and statistical testing for differential abundance.

## Typical Workflow

### 1. Data Conversion
MSstatsTMT requires a specific long-format data frame. Use the converter corresponding to your upstream processing software. All converters require an **annotation** data frame with columns: `Run`, `Fraction`, `TechRepMixture`, `Channel`, `Condition`, `BioReplicate`, and `Mixture`.

```r
library(MSstatsTMT)

# Proteome Discoverer
input.pd <- PDtoMSstatsTMTFormat(raw_psm_df, annotation_df)

# MaxQuant
input.mq <- MaxQtoMSstatsTMTFormat(evidence_df, proteinGroups_df, annotation_df)

# SpectroMine
input.mine <- SpectroMinetoMSstatsTMTFormat(raw_mine_df, annotation_df)

# OpenMS
input.om <- OpenMStoMSstatsTMTFormat(raw_om_df)

# FragPipe / Philosopher
input.phil <- PhilosophertoMSstatsTMTFormat(path = "path/to/csv_folder", annotation = annotation_df)
```

### 2. Protein Summarization and Normalization
The `proteinSummarization` function performs log-transformation, global median normalization (between channels), and protein-level summarization.

```r
# Standard summarization using the MSstats method (includes missing value imputation)
quant.data <- proteinSummarization(
  input.pd,
  method = "msstats",        # Options: "msstats", "MedianPolish", "Median", "LogSum"
  global_norm = TRUE,        # Equalize medians across channels/runs
  reference_norm = TRUE,     # Normalize between runs using 'Norm' condition channels
  remove_norm_channel = TRUE # Remove reference channels after normalization
)

# Access summarized data
head(quant.data$ProteinLevelData)
```

### 3. Visualization
Evaluate data quality and normalization effects before proceeding to statistical testing.

```r
# Quality Control Plot (systematic bias)
dataProcessPlotsTMT(data = quant.data, type = 'QCPlot', address = FALSE)

# Profile Plot (peptide-level trends for specific proteins)
dataProcessPlotsTMT(data = quant.data, type = 'ProfilePlot', which.Protein = "P04406", address = FALSE)
```

### 4. Group Comparison
Test for differential abundance between conditions using linear mixed-effects models.

```r
# Pairwise comparison (all possible combinations)
test.results <- groupComparisonTMT(quant.data, moderated = TRUE)

# Custom contrast matrix
# Example: Comparing Condition 'A' vs 'B' where levels are A, B, C
comparison <- matrix(c(1, -1, 0), nrow = 1)
row.names(comparison) <- "A-vs-B"
colnames(comparison) <- c("A", "B", "C")

test.results.custom <- groupComparisonTMT(quant.data, contrast.matrix = comparison)

# View results
head(test.results$ComparisonResult)
```

## Key Considerations
- **Annotation**: The `Condition` column must use the string `"Norm"` for channels intended to be used as reference standards for across-run normalization.
- **Missing Values**: The `msstats` method handles missing values via Accelerated Failure Time (AFT) models. Other methods like `Median` do not perform imputation.
- **Moderated T-test**: Setting `moderated = TRUE` in `groupComparisonTMT` uses an empirical Bayes approach to shrink variance, which is recommended for experiments with small sample sizes.

## Reference documentation
- [MSstatsTMT: Protein significance analysis for TMT labeling](./references/MSstatsTMT.md)