---
name: bioconductor-diffgeneanalysis
description: This tool performs differential gene expression analysis on microarray data using the associative T-test method. Use when user asks to normalize microarray intensities, adjust for multiplicative bias, or classify genes into expression groups based on background levels.
homepage: https://bioconductor.org/packages/release/bioc/html/diffGeneAnalysis.html
---


# bioconductor-diffgeneanalysis

name: bioconductor-diffgeneanalysis
description: Differential gene expression analysis using the associative T-test method. Use this skill when performing microarray data analysis (cDNA or Affymetrix) that requires background-based normalization, bias adjustment, and classification of genes into expression groups (A1-A4) using the diffGeneAnalysis R package.

# bioconductor-diffgeneanalysis

## Overview

The `diffGeneAnalysis` package (DGAP) provides a specialized pipeline for microarray data analysis. Its core strength lies in the **associative T-test** method, which improves upon standard T-tests by using a reference group as an internal standard. The workflow typically follows a three-step process: Gaussian-based normalization using background fluorescence, multiplicative bias adjustment, and associative analysis to categorize genes based on their expression patterns relative to background and experimental conditions.

## Core Workflow

The package requires data to be formatted as a matrix or data frame where the first column is the Gene ID, followed by control chips, then experimental chips.

### 1. Data Loading and Preparation
Data should be in a `.csv` format. Ensure control columns precede experimental columns.

```r
library(diffGeneAnalysis)
# Example using internal data
data(rawdata)

# To load your own data:
# rawdata <- read.csv("path/to/data.csv", header=TRUE)
```

### 2. Normalization
The `normalize` function uses background intensity to determine a Gaussian distribution of lowly expressed genes.

```r
# Usage: normalize(data, total_columns, control_columns, experimental_columns, min_prob, max_prob)
# Example: 7 total columns (1 ID + 3 Control + 3 Exp), 3 control, 4 experimental
normalized <- normalize(rawdata, 7, 3, 4, 0.15, 0.60)
```
*Note: This function is interactive. It will prompt you to select the best Gaussian fit from a series of histograms for each chip.*

### 3. Bias Adjustment
Adjusts for dye bias and hybridization efficacy using a multiplicative scalar.

```r
# Usage: biasAdjust(normalized_data, total_columns)
bAdjusted <- biasAdjust(normalized, 7)
```

### 4. Associative Analysis
The final step performs the associative T-test and assigns genes to groups.

```r
# Usage: refGroup(adjusted_data, total_cols, control_cols, exp_cols, p_value_threshold)
results <- refGroup(bAdjusted, 7, 3, 4, 0.05)
```
*Note: You will be prompted for E (fold over background) and R (ratio of experimental/control) values. Higher values increase stringency.*

## Interpreting Results

The output is a matrix where the final column (Column 11) indicates the gene group:

| Group | Description |
|-------|-------------|
| **A1** | Expressed above background in both; over-expressed in **Experimental**. |
| **A2** | Expressed above background in both; over-expressed in **Control**. |
| **A3** | Expressed above background **only** in Experimental. |
| **A4** | Expressed above background **only** in Control. |
| **0**  | No significant difference or below background. |

Other important columns:
- **Col 8**: Standard Student T-test p-value.
- **Col 9**: Associative T-test p-value (primary metric for this package).
- **Col 10**: Ratio of mean expression (Control/Experimental).

## Exporting Data
To save results for external analysis:
```r
write.table(results, file = "results.csv", sep = ",", col.names = NA)
```

## Reference documentation

- [Differential Gene Analysis Package Documentation (DGAP)](./references/diffGeneAnalysis.md)