---
name: bioconductor-healthycontrolspresencechecker
description: This tool audits NCBI GEO datasets to determine if they contain healthy control samples based on metadata keyword searches. Use when user asks to check for healthy controls in a GEO dataset, verify dataset suitability for case-control studies, or scan GSE accession codes for specific keywords.
homepage: https://bioconductor.org/packages/release/data/experiment/html/healthyControlsPresenceChecker.html
---


# bioconductor-healthycontrolspresencechecker

## Overview

The `healthyControlsPresenceChecker` package provides a streamlined way to audit NCBI GEO datasets for the presence of healthy controls. It automates the tedious process of manually searching through sample annotations for keywords like "healthy" or "control," returning a boolean result that indicates whether the dataset is suitable for case-control studies.

## Installation

To use this package, ensure `BiocManager` is installed:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("healthyControlsPresenceChecker")
library(healthyControlsPresenceChecker)
```

## Main Functionality

The core of the package is the `healthyControlsCheck()` function.

### Checking a GEO Dataset

To verify a dataset, provide the GSE accession code. The function scans the metadata and annotations associated with the series matrix files.

```r
# Basic usage (returns TRUE or FALSE)
has_controls <- healthyControlsCheck("GSE47407", verbose = TRUE)

# Interpretation
if (has_controls) {
  message("Dataset contains healthy controls; suitable for comparative analysis.")
} else {
  message("No healthy controls detected based on keyword scanning.")
}
```

### Parameters
- `geoAccessionCode`: A string representing the GEO series ID (e.g., "GSE12345").
- `verbose`: A boolean. When `TRUE`, the function prints the processing steps, the URL accessed, the files found, and specific keyword match results for "healthy" and "control".

## Workflow Integration

1.  **Identification**: Identify a GEO dataset of interest for a specific disease.
2.  **Verification**: Run `healthyControlsCheck()` to ensure the dataset includes a baseline (healthy) group.
3.  **Downstream Analysis**: If the result is `TRUE`, proceed with data acquisition using packages like `GEOquery` or `geneExpressionFromGEO` for differential expression analysis.

## Tips for Interpretation
- The package specifically looks for the keywords **"healthy"** and **"control"** within the dataset annotations.
- If `verbose = TRUE`, you can see exactly which keyword was missing, which helps in understanding why a dataset might have been flagged as `FALSE`.
- This tool is particularly useful for high-throughput screening of multiple GSE IDs when building a meta-analysis cohort.

## Reference documentation

- [healthyControlsPresenceChecker Vignette](./references/healthyControlsPresenceChecker.md)
- [healthyControlsPresenceChecker R Markdown](./references/healthyControlsPresenceChecker.Rmd)