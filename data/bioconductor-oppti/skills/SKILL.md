---
name: bioconductor-oppti
description: The oppti package identifies dysregulated protein and phosphosite markers by calculating outlier scores based on deviations from a consensus co-expression network. Use when user asks to identify outlier proteins, find dysregulated phosphosites, or estimate normal expression states in proteomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/oppti.html
---


# bioconductor-oppti

## Overview

The `oppti` (Outlier Protein and Phosphosite Target Identifier) package is designed for the discovery of dysregulated markers in proteomics datasets. It works by inferring a consensus co-expression network to estimate "normal" expression states for each marker and then calculating outlier scores based on the deviation of observed disease expressions from these estimates. Positive scores indicate up-regulation (protruding expression), while negative scores indicate down-regulation relative to the predicted normal state.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("oppti")
library(oppti)
```

## Core Workflow

### 1. Data Preparation
Input data should be a dataframe (for a single cohort) or a list of dataframes (for multiple cohorts/pan-cancer analysis). Rows should be markers (proteins/phosphosites) and columns should be samples.

```r
# Example: Single cohort dataframe
# rownames: marker1, marker2...
# colnames: sample1, sample2...
data <- as.data.frame(matrix(abs(rnorm(100*30)), 100, 30))
```

### 2. Running Outlier Analysis
The primary function is `oppti()`. It performs the network inference, state estimation, and statistical testing.

```r
# Basic execution
result <- oppti(data)

# For multiple cohorts
result_multi <- oppti(list(cohort1_df, cohort2_df))
```

### 3. Interpreting Results
The function returns a list containing three main components:

1.  **Outlier Scores** (`result[[1]]`): A matrix (or list of matrices) containing the calculated outlier scores.
2.  **Estimated Normal States** (`result[[2]]`): The predicted "normal" values for each marker/sample.
3.  **Statistical Significance** (`result[[3]]`): P-values from Kolmogorov-Smirnov tests comparing observed and estimated states for each marker.

```r
outlier_scores <- result[[1]]
normal_states <- result[[2]]
p_values <- result[[3]]
```

### 4. Visualization and Filtering
You can generate plots and restrict analysis to specific markers of interest using the following parameters:

*   `draw.sc.plots = TRUE`: Generates scatter plots of observed vs. estimated expressions.
*   `draw.ou.plots = TRUE`: Displays summary results of outlying events across cohorts.
*   `panel.markers`: A character vector to restrict analysis to a specific subset of markers.
*   `draw.ou.markers`: A character vector to highlight specific markers in summary plots.

```r
# Example with visualization
result <- oppti(data, 
                draw.sc.plots = TRUE, 
                panel.markers = c('marker1', 'marker2', 'marker3'))
```

## Tips
*   **Sign of Scores**: Always check the sign of the outlier score. A high positive score suggests a potential therapeutic target (over-expression), while a negative score suggests loss of expression.
*   **Pan-Cancer Analysis**: When providing a list of cohorts, `oppti` handles non-overlapping markers automatically, allowing for integrated analysis of diverse datasets.
*   **Significance**: Use the p-values in `result[[3]]` to prioritize markers that show statistically significant deviations across the cohort rather than just isolated samples.

## Reference documentation
- [Outlier Protein and Phosphosite Target Identifier](./references/analysis.md)
- [Outlier Protein and Phosphosite Target Identifier (Rmd)](./references/analysis.Rmd)