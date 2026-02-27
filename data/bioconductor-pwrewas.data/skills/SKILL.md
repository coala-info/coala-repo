---
name: bioconductor-pwrewas.data
description: This package provides reference datasets of CpG-specific means and variances for power estimation in epigenome-wide association studies. Use when user asks to access reference data for pwrEWAS, simulate DNA methylation data, or retrieve tissue-specific methylation parameters.
homepage: https://bioconductor.org/packages/3.10/data/experiment/html/pwrEWAS.data.html
---


# bioconductor-pwrewas.data

## Overview
The `pwrEWAS.data` package is a data-only experiment package that provides the necessary reference datasets for the `pwrEWAS` tool. It contains estimated CpG-specific means and variances derived from various public datasets (GEO accessions). These reference values are essential for simulating DNA methylation data to estimate power as a function of sample size and effect size in two-group comparisons.

## Data Access and Usage
The package primarily serves as a repository for the `pwrEWAS` package to call internally, but the data can be accessed directly in R for custom simulations or inspections.

### Loading the Package
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pwrEWAS.data")
library(pwrEWAS.data)
```

### Available Tissue Types
The package includes reference data for the following tissue types:
*   **Blood**: Adults (GSE42861), Children (GSE83334), Newborns (GSE82273)
*   **Cord-blood**: Whole blood (GSE69176), PBMC (GSE110128)
*   **Other Tissues**: Saliva (GSE92767), Lymphoma (GSE42372), Placenta (GSE62733), Liver (GSE61258), Colon (GSE77718), Sperm (GSE114753), Adult PBMC (GSE67170)

### Accessing Reference Data
The data is stored as internal objects. While typically handled by `pwrEWAS()`, you can explore the data structure:
```r
# Example: Loading the blood reference data (if exported/available via data())
data(package = "pwrEWAS.data") 
```

## Integration with pwrEWAS
When using the main `pwrEWAS` package, you specify the tissue type which corresponds to the datasets provided by this package:

```r
# Typical workflow in pwrEWAS using this data
results <- pwrEWAS(minSampleNum = 10, 
                   maxSampleNum = 50, 
                   targetDelta = 0.1, 
                   tissueType = "Blood adult") # This string maps to pwrEWAS.data
```

## Reference documentation
- [pwrEWAS.data Reference Data](./references/pwrEWAS.data.md)