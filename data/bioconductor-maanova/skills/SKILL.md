---
name: bioconductor-maanova
description: This tool performs statistical analysis of microarray experiments using fixed and mixed effects ANOVA models. Use when user asks to perform differential expression analysis on microarray data, fit ANOVA models to complex experimental designs, or calculate permutation-based p-values for microarray hypothesis testing.
homepage: https://bioconductor.org/packages/3.5/bioc/html/maanova.html
---

# bioconductor-maanova

name: bioconductor-maanova
description: Analysis of microarray experiments using ANOVA models, including fixed and mixed effects. Use this skill when performing differential expression analysis on microarray data (one-color or two-color), specifically for experimental designs involving multiple factors, technical replicates, or biological replicates requiring mixed-model variance component estimation.

# bioconductor-maanova

## Overview
The `maanova` package (MicroArray ANalysis Of VAriance) provides a comprehensive suite of tools for the statistical analysis of microarray data. It is particularly powerful for complex experimental designs where multiple factors are involved. It supports both fixed-effects and mixed-effects models, allowing for the estimation of variance components and the calculation of robust test statistics (F, Fs, and Fss) via permutation-based p-values.

## Core Workflow

### 1. Data Preparation and Loading
Data must be formatted as a single file or R matrix. A design file (or data frame) is required to map arrays to experimental factors.

```r
library(maanova)

# Read data from a tab-delimited file
# arrayType: 'oneColor' (e.g., Affymetrix) or 'twoColor' (e.g., cDNA)
data_obj <- read.madata(datafile="data.txt", designfile="design.txt", arrayType="twoColor")

# For Affymetrix data already processed via 'affy' package:
# data_obj <- read.madata(exprs(rmaData), designfile=my_design_df)
```

### 2. Quality Control and Transformation
For two-color arrays, visualize spatial patterns and intensity biases before analysis.

```r
# Visualization
gridcheck(data_obj)
riplot(data_obj)
arrayview(data_obj)

# Transformation (e.g., joint lowess)
data_transformed <- transform.madata(data_obj, method="rlowess")
```

### 3. Model Fitting
Define the ANOVA model using a formula. Specify random effects (like `Sample` or `Array`) to account for correlations in the data.

```r
# Fixed effects model
fit_fix <- fitmaanova(data_transformed, formula = ~Dye + Array + Treatment)

# Mixed effects model (treating Sample as random)
fit_mix <- fitmaanova(data_transformed, formula = ~Strain + Sample, random = ~Sample)

# Check residuals
resiplot(data_transformed, fit_mix)
```

### 4. Hypothesis Testing
Use `matest` to perform F-tests or T-tests. Permutation is recommended to derive reliable p-values, especially for mixed models.

```r
# Test for a specific term with 500 permutations
test_results <- matest(data_transformed, fit_mix, term="Strain", n.perm=500, test.method=c(1,1))

# Calculate FDR adjusted P-values
test_results <- adjPval(test_results, method="jsFDR")
```

### 5. Summarization and Visualization
Extract significant genes and visualize results using volcano plots or clustering.

```r
# Generate a summary table of results
summary_tab <- summarytable(test_results, threshold=0.05)

# Volcano plot
idx <- volcano(test_results, highlight.flag=FALSE)

# Bootstrap K-means clustering for significant genes
cluster_km <- macluster(fit_mix, term="Strain", idx.gene=idx$idx.all, 
                        method="kmean", kmean.ngroups=5, n.perm=100)
con_km <- consensus(cluster_km, 0.7)
```

## Key Functions Reference
- `read.madata()`: Imports intensity data and experimental design.
- `transform.madata()`: Performs normalization (lowess, rlowess, log2, etc.).
- `fitmaanova()`: Fits the ANOVA model (Fixed or Mixed).
- `matest()`: Performs F-tests with permutation-based p-values.
- `adjPval()`: Adjusts p-values for multiple testing (FDR).
- `volcano()`: Creates volcano plots for differential expression.
- `macluster()` / `consensus()`: Performs bootstrap clustering and builds consensus trees.

## Tips for Success
- **Design File**: Ensure the `Array` column matches the data columns exactly. For two-color arrays, `Dye` and `Sample` columns are mandatory.
- **Missing Data**: `maanova` does not tolerate missing values. Use `fill.missing()` or remove genes with missing observations before analysis.
- **Reference Samples**: In the `Sample` column of the design file, use `0` to identify reference samples; they are treated as fixed factors and excluded from statistical tests.
- **Computational Load**: Permutation tests for mixed models are computationally intensive. If running in a cluster environment, `maanova` supports parallel processing via the `snow` package.

## Reference documentation
- [maanova](./references/maanova.md)