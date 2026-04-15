---
name: r-cssam
description: This tool performs cell-type specific significance analysis of microarrays to deconvolve differential expression from mixed tissue samples. Use when user asks to identify cell-type specific gene expression signatures, deconvolve bulk expression data using cell proportions, or perform differential expression analysis on specific cell types within a mixture.
homepage: https://cran.r-project.org/web/packages/cssam/index.html
---

# r-cssam

name: r-cssam
description: Perform Cell-type Specific Significance Analysis of Microarrays (csSAM) to deconvolve differential expression from mixed tissue samples. Use when analyzing gene expression data where cell-type proportions are known or estimated, allowing for the identification of cell-type specific signatures without physical cell sorting.

# r-cssam

## Overview
The `csSAM` package implements a statistical method for analyzing differential gene expression in specific cell types from mixed tissue samples (e.g., whole blood). It deconvolves the bulk expression data using known or estimated cell-type proportions and applies a Significance Analysis of Microarrays (SAM) approach to identify cell-type specific changes between experimental groups.

## Installation
```R
# Note: csSAM is currently archived on CRAN. 
# It may require installation from the CRAN archive or GitHub.
install.packages("csSAM")
```

## Main Functions

### Deconvolution and Analysis
- `csSamWrapper()`: The primary high-level function that performs the entire pipeline, including deconvolution, SAM statistics, and FDR estimation.
- `csSAM()`: Performs the core linear deconvolution to estimate cell-type specific expression for each group.
- `fdrCsSAM()`: Calculates the False Discovery Rate (FDR) by permuting group labels.
- `fdrPlot()`: Generates plots to visualize the FDR across different cell types and thresholds.

### Data Requirements
- `G`: A numeric matrix of gene expression data (genes in rows, samples in columns).
- `cc`: A numeric matrix of cell-type proportions (samples in rows, cell types in columns). Proportions for each sample should sum to 1.
- `groupID`: A numeric or character vector indicating the group membership (e.g., control vs. treatment) for each sample.

## Standard Workflow

1. **Prepare Data**: Ensure your expression matrix `G` and cell-proportion matrix `cc` are aligned by sample.
2. **Run Wrapper**: Execute the full analysis in one step.
   ```R
   results <- csSamWrapper(G, cc, groupID, nperms = 100, alternative = "two.sided")
   ```
3. **Analyze FDR**: Examine the FDR for each cell type to determine significance.
   ```R
   fdrPlot(results$fdr.obj)
   ```
4. **Extract Results**: Identify genes that meet your FDR threshold for a specific cell type.

## Tips for Usage
- **Cell Proportions**: The accuracy of the deconvolution is highly dependent on the quality of the cell-type proportions (`cc`). These can be obtained via flow cytometry or computational deconvolution tools.
- **Permutations**: For publication-quality results, increase `nperms` (e.g., 500 or 1000), though this increases computation time.
- **Group Comparison**: The package is designed for two-group comparisons. Ensure `groupID` contains exactly two unique values for differential analysis.

## Reference documentation
- [home_page.md](./references/home_page.md)