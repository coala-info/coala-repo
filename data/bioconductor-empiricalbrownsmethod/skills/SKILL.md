---
name: bioconductor-empiricalbrownsmethod
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EmpiricalBrownsMethod.html
---

# bioconductor-empiricalbrownsmethod

## Overview
The `EmpiricalBrownsMethod` package provides an empirical adaptation of Brown’s Method to combine p-values from non-independent tests. While Fisher’s Method assumes independence, this package uses the empirical cumulative distribution function derived from the provided data matrix to account for dependencies, offering a more accurate and conservative null distribution for biological datasets.

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("EmpiricalBrownsMethod")
library(EmpiricalBrownsMethod)
```

## Main Functions

### empiricalBrownsMethod
This is the primary function used to combine p-values when the underlying data used to generate those p-values is available.
- **data_matrix**: A matrix where rows are variables (e.g., genes) and columns are samples. This is used to calculate the correlation structure.
- **p_values**: A vector of p-values to be combined.
- **extra_info**: Boolean. If `TRUE`, returns a list containing the combined p-value, the variance of the chi-squared distribution, and the calculated degrees of freedom.

### kostsMethod
An implementation of Kost's Method, which is an analytical approximation of Brown's Method. Use this when you have the covariance matrix but not the raw data, or as a comparison.

## Typical Workflow

1.  **Identify a Set of P-values**: Collect p-values from multiple tests that you wish to aggregate (e.g., correlation tests for all genes within a specific biological pathway).
2.  **Prepare the Reference Data**: Subset your original expression or omics data matrix to include only the rows (genes/features) corresponding to the p-values being combined.
3.  **Execute Combination**:
    ```R
    # Example: Combining p-values for a specific pathway
    # glypDat: Expression matrix for genes in the pathway
    # glypPvals: Vector of p-values for those same genes
    
    combined_result <- empiricalBrownsMethod(
        data_matrix = glypDat, 
        p_values = glypPvals, 
        extra_info = TRUE
    )
    
    # Access the combined p-value
    print(combined_result$P_patch)
    ```

## Usage Tips
- **Data Alignment**: Ensure that the order of features in the `data_matrix` matches the order of the `p_values` vector.
- **Sample Size**: The empirical method relies on the correlation structure in the `data_matrix`. Ensure you have a sufficient number of samples (columns) to provide a stable estimate of dependency.
- **Independence**: If the p-values are truly independent, this method will converge toward the results of Fisher's Method, but it is specifically optimized for the dependent case common in systems biology.

## Reference documentation
- [Empirical Browns Method Vignette](./references/ebmVignette.md)