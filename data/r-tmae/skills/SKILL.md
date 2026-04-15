---
name: r-tmae
description: The r-tmae package identifies allelic imbalance in allele-specific expression data by applying negative binomial statistical tests to allele counts. Use when user asks to test for allelic imbalance, annotate variants with gnomAD population frequencies, or visualize allelic fold changes and counts.
homepage: https://cran.r-project.org/web/packages/tmae/index.html
---

# r-tmae

## Overview
The `tmae` package provides a specialized framework for analyzing allele-specific expression (ASE) data. It focuses on identifying allelic imbalance by applying negative binomial tests to allele counts (REF vs ALT). It also facilitates the integration of population genetics data (gnomAD) and provides visualization tools to interpret the relationship between total counts and allelic fold changes.

## Installation
```R
# Install from CRAN
install.packages("tmae")

# Or install the development version from GitHub
# remotes::install_github("mumichae/tMAE")
```

## Main Functions and Workflows

### Statistical Testing
The core of the package is performing a negative binomial test to determine if the ratio of ALT/REF counts deviates significantly from the expected 0.5.
- `testAllelicImbalance()`: Performs the negative binomial test on allelic counts.
- Input typically requires a data frame or object containing `countRef` and `countAlt` columns.

### Data Enrichment
To filter for rare variants or prioritize findings, the package integrates with gnomAD.
- `addGnomadMAF()`: Appends minor allele frequency (MAF) data from gnomAD to the allelic count table. This helps distinguish between common polymorphisms and potentially pathogenic rare variants.

### Visualization
The package provides two primary plotting methods to evaluate ASE:
- **MA-plot**: Use `plotMAE_MA()` to visualize the log2 Fold Change (ALT/REF) against the total counts (REF + ALT). This helps identify bias across different expression levels.
- **Allelic Counts Plot**: Use `plotMAE_Counts()` to plot ALT counts vs REF counts directly, typically with diagonal lines representing expected ratios.

### Typical Workflow
1. **Prepare Data**: Load your table of allelic counts per variant/gene.
2. **Annotate**: Add population frequencies using `addGnomadMAF()`.
3. **Test**: Run the negative binomial test to calculate p-values and adjusted p-values for imbalance.
4. **Visualize**: Generate an MA-plot to inspect the distribution of significant ASE events.

## Tips
- Ensure your input data has clear columns for reference and alternative allele counts.
- When using gnomAD functions, ensure you have the necessary internet connection or local database access as required by the package's backend.
- Use the MA-plot to check for systematic biases; a symmetric distribution around 0 on the y-axis (log2FC) usually indicates high-quality data.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)