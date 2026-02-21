---
name: bioconductor-deqms
description: The package can be applied to analyze both label-free and labelled proteomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/DEqMS.html
---

# bioconductor-deqms

## Overview

DEqMS (Differential Expression of Quantitative Mass Spectrometry) is an R package that improves upon the `limma` framework for proteomics applications. While `limma` assumes a common prior variance for all features, DEqMS estimates prior variance based on the number of PSMs (Peptide Spectrum Matches) or peptides quantified for each protein. This adjustment accounts for the fact that proteins with more measurements generally have more reliable variance estimates, leading to higher statistical power and better false discovery rate control in proteomics experiments.

## Core Workflow

The DEqMS workflow typically follows a standard `limma` pipeline with an additional step to incorporate peptide/PSM counts.

### 1. Data Preparation
Input data should be a log2-transformed expression matrix (proteins in rows, samples in columns).

```r
library(DEqMS)

# Example: log2 transform and median normalization
dat.log = log2(dat)
dat.log = na.omit(dat.log)
dat.log = equalMedianNormalization(dat.log)
```

### 2. Linear Modeling (Limma)
Define the experimental design and contrasts, then fit the linear model.

```r
design = model.matrix(~0 + condition_factor)
colnames(design) = levels(condition_factor)

fit1 = lmFit(dat.log, design)
contrast = makeContrasts(GroupA - GroupB, levels = design)
fit2 = contrasts.fit(fit1, contrasts = contrast)
fit3 = eBayes(fit2)
```

### 3. DEqMS Variance Adjustment
Assign the peptide/PSM count to the fit object and run `spectraCounteBayes`.

```r
# count_vector must match the rownames of fit3
fit3$count = count_vector 
fit4 = spectraCounteBayes(fit3)
```

### 4. Extracting Results
Use `outputResult` to get the final statistics, including the adjusted p-values (`sca.P.Value`).

```r
results = outputResult(fit4, coef_col = 1)
# Key columns:
# sca.t: Spectra Count Adjusted t-statistic
# sca.P.Value: DEqMS p-value
# sca.adj.pval: BH adjusted p-value
```

## Specialized Summarization Functions

If starting from a PSM-level table, DEqMS provides functions to aggregate data to the protein level:

- `medianSweeping`: Summarizes PSM intensities to protein log2 ratios by subtracting spectrum medians.
- `medianSummary`, `medpolishSummary`, `farmsSummary`: Alternative summarization methods.

```r
# Example using medianSweeping
protein_matrix = medianSweeping(dat.psm.log, group_col = "ProteinID_column_index")
```

## Visualization

DEqMS provides specific plotting functions to evaluate the relationship between variance and peptide counts:

- `VarianceBoxplot(fit, n=20)`: Shows the distribution of variance across different PSM counts.
- `VarianceScatterplot(fit)`: Visualizes the fit of the DEqMS model (prior variance vs. PSM count).
- `peptideProfilePlot(dat, col, gene)`: Plots individual PSM/peptide profiles for a specific protein.

## Tips for Success

1. **Count Selection**: For `fit$count`, use the minimum number of PSMs/peptides used for quantification across the samples being compared.
2. **Log Transformation**: Ensure data is log2 transformed before fitting the linear model.
3. **Filtering**: It is recommended to filter out proteins with too many missing values (e.g., requiring at least 2 valid values per group) before running DEqMS.
4. **Pseudo-counts**: If some proteins have 0 peptides in certain samples, add a small pseudo-count (e.g., +1) to the count table to avoid errors in the variance modeling.

## Reference documentation

- [DEqMS R Markdown vignettes](./references/DEqMS-package-vignette.md)
- [DEqMS R Markdown vignettes (Source)](./references/DEqMS-package-vignette.Rmd)