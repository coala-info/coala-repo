---
name: r-acidgsea
description: R package acidgsea (documentation from project home).
homepage: https://cran.r-project.org/web/packages/acidgsea/index.html
---

# r-acidgsea

name: r-acidgsea
description: Perform parameterized gene set enrichment analysis (GSEA) on multiple differential expression contrasts using the acidgsea R package. Use this skill when conducting GSEA workflows in R, specifically for analyzing multiple contrasts simultaneously, extending fgsea functionality, and visualizing gene set enrichment.

## Overview

acidgsea is an R package designed to streamline gene set enrichment analysis (GSEA) across multiple differential expression contrasts. It serves as a high-level wrapper and extension for the fgsea (Fast Gene Set Enrichment Analysis) package, providing a structured framework for handling complex experimental designs and generating consistent results across various comparisons.

## Installation

To install the package from the Acid Genomics repository:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "AcidGSEA",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

## Usage

### Core Workflow

The typical workflow involves preparing differential expression results, defining gene sets (usually from GMT files), and running the enrichment analysis across all defined contrasts.

1. **Prepare Input Data**: Ensure you have differential expression results (e.g., from DESeq2 or EdgeR) containing log2 fold change values and gene identifiers.
2. **Load Gene Sets**: Use standard formats like GMT files or lists of gene symbols.
3. **Execute GSEA**: Use the package's parameterized functions to run analysis across multiple contrasts.

### Key Functions

* **`runGsea()`**: The primary function for executing the enrichment analysis. It typically takes ranked gene lists and gene sets as input.
* **`plotGsea()`**: Generates enrichment plots for specific pathways or gene sets.
* **`results()`**: Extracts the enrichment statistics (NES, p-values, etc.) into a tidy data frame.

### Best Practices

* **Ranking**: Ensure genes are appropriately ranked (usually by log2 fold change or a signed p-value) before passing them to the analysis functions.
* **Multiple Contrasts**: When working with multiple comparisons, acidgsea excels at maintaining consistent parameters across all runs, making the results directly comparable.
* **Gene Identifiers**: Verify that the gene identifiers in your differential expression results match the identifiers used in your gene set (GMT) files (e.g., Entrez IDs vs. Gene Symbols).

## Reference documentation

- [AcidGSEA Home Page](./references/home_page.md)