---
name: bioconductor-cll
description: This tool provides access to gene expression data and filtering workflows for chronic lymphocytic leukemia (CLL) patients from the Bioconductor CLL package. Use when user asks to load CLL microarray datasets, access raw AffyBatch or preprocessed ExpressionSet objects, or filter genes based on disease progression status.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CLL.html
---


# bioconductor-cll

name: bioconductor-cll
description: A specialized skill for working with the Bioconductor CLL package, which contains chronic lymphocytic leukemia (CLL) gene expression data. Use this skill when you need to load, filter, or analyze the CLL microarray dataset, specifically for comparing "progressive" vs "stable" disease states using AffyBatch or ExpressionSet objects.

# bioconductor-cll

## Overview
The `CLL` package is a Bioconductor data package providing gene expression profiles for 24 patients with chronic lymphocytic leukemia. The data is primarily used for demonstrating microarray analysis workflows, specifically comparing patients with stable disease versus those with progressive disease. The package includes raw data (`AffyBatch`), preprocessed data (`ExpressionSet`), and various pre-calculated filtering vectors.

## Loading Data
To use the data, you must first load the library and then use the `data()` function to load specific objects:

```r
library(CLL)

# Load the preprocessed ExpressionSet (22 samples)
data(sCLLex)

# Load the raw AffyBatch data (24 samples)
data(CLLbatch)

# Load phenotype information
data(disease)
```

## Key Data Objects
- `CLLbatch`: An `AffyBatch` object containing raw probe-level data for 24 samples on the `hgu95av2` platform.
- `sCLLex`: An `ExpressionSet` object containing gcrma-processed expression levels. Note: Samples `CLL1` and `CLL10` were removed during processing due to quality issues, leaving 22 samples.
- `disease`: A data frame mapping `SampleID` to `Disease` status (`progres.` or `stable`).

## Filtering Workflows
The package provides several logical vectors that can be used to subset the `sCLLex` object based on different filtering criteria:

### 1. Non-specific Filtering (IQR)
Filters genes based on variability (Interquartile Range) across samples.
```r
data(nsFilter)
sCLLex_filtered <- sCLLex[nsFilter, ]
```

### 2. Specific Filtering (t-test)
Filters genes based on a p-value threshold (< 0.005) from a row-wise t-test comparing progressive vs. stable groups.
```r
data(sFiltert)
sCLLex_specific <- sCLLex[sFiltert, ]
```

### 3. Multiple Testing Correction (Benjamini & Hochberg)
Filters genes using BH-adjusted p-values (threshold < 0.35) and IQR filtering.
```r
data(sFiltertBH)
sCLLex_bh <- sCLLex[sFiltertBH, ]
```

## Typical Analysis Workflow
1. **Access Phenotypes**: Check the distribution of disease states.
   ```r
   table(pData(sCLLex)$Disease)
   ```
2. **Differential Expression**: Since the filtering vectors are pre-provided, you can quickly identify candidate genes:
   ```r
   # Identify genes passing BH adjustment
   target_genes <- featureNames(sCLLex)[sFiltertBH]
   ```
3. **Visualization**: Create plots comparing expression between groups for a specific probe.
   ```r
   # Example for the first gene passing the filter
   boxplot(exprs(sCLLex)[sFiltertBH, ][1, ] ~ pData(sCLLex)$Disease)
   ```

## Reference documentation
- [CLL Reference Manual](./references/reference_manual.md)