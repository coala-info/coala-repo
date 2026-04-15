---
name: bioconductor-omicplotr
description: This package provides tools for the exploratory analysis and visualization of omic datasets using a compositional data framework. Use when user asks to filter sparse features, perform center-log ratio transformations, generate PCA biplots, or visualize differential abundance using ALDEx2.
homepage: https://bioconductor.org/packages/release/bioc/html/omicplotR.html
---

# bioconductor-omicplotr

## Overview

The `omicplotR` package is designed for the exploratory analysis of omic datasets (RNA-Seq, 16S rRNA, etc.) treated as compositional data. It bridges the gap between raw count tables and visual insights by integrating the `ALDEx2` framework. While primarily known for its Shiny interface, the package provides a structured workflow for filtering sparse features, transforming data using center-log ratio (CLR), and visualizing differences between experimental groups.

## Core Workflow

### 1. Data Preparation
Input data must be a count table where rows are features (OTUs/genes) and columns are samples.
- **Data Table:** First column must be feature IDs. An optional "taxonomy" column can be included (must contain at least 4 levels separated by `;` or `:`).
- **Metadata:** First column must contain sample IDs matching the count table.

```r
library(omicplotR)

# Load example data
data(otu_table)
data(metadata)

# To launch the interactive GUI
# omicplotr.run()
```

### 2. Filtering and Transformation
Compositional analysis requires handling zeros and filtering sparse data to ensure robust PCA and differential abundance results.
- **Minimum count per OTU:** Removes rows where the maximum count across samples is below a threshold (e.g., 10).
- **Proportional abundance:** Removes features that never reach a specific frequency threshold.
- **CLR Transformation:** `omicplotR` uses the center-log ratio to move data from the simplex to real Euclidean space, making it suitable for PCA.

### 3. Visualizing Compositions
The package focuses on three primary visualization types:
- **PCA Biplots:** Used to visualize the relationship between samples (points) and features (vectors). Use `Adjust scale = 0` for sample relationships and `1` for feature relationships.
- **Relative Abundance Plots:** Combined dendrograms and stacked barplots to show taxonomic distribution across samples.
- **Effect Plots (ALDEx2):** Visualizes differential abundance by plotting the "Effect Size" (difference between groups vs. dispersion within groups).

### 4. Differential Abundance with ALDEx2
When comparing two groups (e.g., Treatment vs. Control):
1. Define groups based on metadata columns.
2. Calculate the `ALDEx2` table (estimates Dirichlet distributions to handle uncertainty in counts).
3. Generate **Bland-Altman (MA) plots** or **Effect plots**.
4. Points with an effect size > 1 or < -1 are generally considered biologically relevant.

## Usage Tips
- **Unique Identifiers:** Ensure all sample and feature names are unique and contain no special characters that might break R column naming conventions.
- **Taxonomy Formatting:** If using the taxonomy feature, ensure the column is named exactly `taxonomy`.
- **Large Datasets:** Calculating ALDEx2 effect plots for thousands of features can be computationally intensive; apply filters to remove low-count features before running.
- **Quitting:** In an interactive session, use the "Quit" button in the "More" tab or `Ctrl+C` / `Esc` in the R console to stop the Shiny server.

## Reference documentation
- [omicplotR: A tool for visualizing omic datasets as compositions](./references/omicplotR.md)