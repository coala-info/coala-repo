---
name: bioconductor-rgsea
description: This tool performs non-parametric classification and similarity analysis between transcriptomic datasets using bootstrap aggregating and gene set enrichment algorithms. Use when user asks to classify samples, measure similarities between transcriptome datasets, or perform random gene set enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/RGSEA.html
---

# bioconductor-rgsea

name: bioconductor-rgsea
description: Random Gene Set Enrichment Analysis (RGSEA) for classifying samples and measuring similarities between transcriptomic datasets. Use this skill when you need to perform non-parametric classification or similarity analysis between a query dataset and a reference dataset using bootstrap aggregating and GSEA-like algorithms.

# bioconductor-rgsea

## Overview

RGSEA is a robust, non-parametric algorithm designed to classify samples or measure similarities between transcriptome datasets. It combines bootstrap aggregating (bagging) with Gene Set Enrichment Analysis (GSEA). Because it does not require parameter fitting, it is highly resistant to overfitting and is effective for comparing data across different studies or platforms.

The package provides two main approaches for feature selection during the random sampling process:
1. **Fixed number selection** (`RGSEAfix`): Selects a specific number of top and bottom features.
2. **Standard deviation selection** (`RGSEAsd`): Selects features based on their deviation from the mean.

## Typical Workflow

### 1. Data Preparation
RGSEA requires two matrices: a **query** matrix (samples to be classified) and a **reference** matrix (samples with known classes).

```R
library(RGSEA)

# Load example data
data(e1) # Query data (e.g., 2 samples)
data(e2) # Reference data (e.g., 4 samples)

# Define classes
query_names <- colnames(e1)
ref_names <- colnames(e2)
```

### 2. Running the Analysis
Use `RGSEAfix` if you want to select a fixed number of features per iteration.

```R
# random: number of features to sample per iteration
# featurenum: number of top/bottom features to select from the sample
# iteration: number of bootstrap iterations
result_fix <- RGSEAfix(query = e1, 
                       reference = e2, 
                       queryclasses = query_names, 
                       refclasses = ref_names, 
                       random = 20000, 
                       featurenum = 1000, 
                       iteration = 100)

# Access the count matrix
result_fix[[1]]
```

Use `RGSEAsd` if you prefer selecting features based on standard deviation.

```R
# sd: number of standard deviations from the mean for feature selection
result_sd <- RGSEAsd(query = e1, 
                     reference = e2, 
                     queryclasses = query_names, 
                     refclasses = ref_names, 
                     random = 5000, 
                     sd = 2, 
                     iteration = 100)
```

### 3. Predicting Probabilities
To convert the raw iteration counts into relative probabilities for classification:

```R
# Predict probabilities based on the count matrix
probabilities <- RGSEApredict(result_fix[[1]], ref_names)
print(probabilities)
```

## Key Functions

- `RGSEAfix()`: Core algorithm using a fixed number of features for enrichment.
- `RGSEAsd()`: Core algorithm using a standard deviation threshold for enrichment.
- `RGSEApredict()`: Calculates the relative probability of a query sample belonging to a specific reference class.

## Tips for Success

- **Iteration Count**: Higher iterations (e.g., 100+) generally lead to more stable results but increase computation time.
- **Feature Selection**: For `RGSEAfix`, the `random` parameter should be significantly larger than `featurenum`.
- **Similarity Analysis**: When comparing a single query against multiple references (like drug treatments), the reference class with the highest count in the output matrix indicates the highest similarity.
- **Data Scaling**: Ensure that query and reference datasets are normalized appropriately (e.g., log-transformed expression values) before running RGSEA.

## Reference documentation

- [RGSEA](./references/RGSEA.md)