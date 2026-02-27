---
name: bioconductor-qpcrnorm
description: This package provides specialized algorithms for normalizing high-throughput qPCR data using data-driven methods like Rank-Invariant and Quantile normalization. Use when user asks to normalize qPCR data, import qPCR text files into qpcrBatch objects, or compare normalization performance using coefficient of variation and variance-mean plots.
homepage: https://bioconductor.org/packages/release/bioc/html/qpcrNorm.html
---


# bioconductor-qpcrnorm

## Overview

The `qpcrNorm` package provides specialized algorithms for normalizing high-throughput qPCR data. While traditional qPCR often relies on the delta-delta Ct method using a single reference gene, this package offers data-driven methods (Rank-Invariant and Quantile) that are better suited for larger datasets (50 to thousands of genes). It utilizes the `qpcrBatch` S4 class, which is analogous to `AffyBatch` or `ExpressionSet` objects used in other Bioconductor workflows.

## Core Workflow

### 1. Data Import and Object Creation
Data can be loaded from text files into a `qpcrBatch` object. This object stores expression values (`exprs`), gene names, and plate indices.

```r
library(qpcrNorm)

# Load from text files
# readQpcr: for single files
# readQpcrBatch: for multiple files/plates
raw_data <- readQpcrBatch(filenames = c("file1.txt", "file2.txt"))

# Example data
data(qpcrBatch.object)
```

### 2. Preprocessing and Quality Control
Before normalization, replicate Ct values can be filtered and averaged. The `ctQc` function implements a specific QC filter based on replicate similarity.

```r
# Apply QC filter and average replicates
# Note: This is often done prior to creating the qpcrBatch object 
# or during the read process.
```

### 3. Normalization Methods
There are three primary normalization strategies available. You can call specific functions or use the generic `normalize` wrapper.

**Quantile Normalization**
Assumes samples should have expression measures with approximately the same distribution.
```r
norm_quant <- normalize(qpcrBatch.object, "quantile")
# Or: norm_quant <- normQpcrQuantile(qpcrBatch.object)
```

**Rank-Invariant Set Normalization**
Identifies genes whose rank remains stable across samples to create a scaling factor.
```r
# Normalize using the first sample as the baseline
norm_ri <- normQpcrRankInvariant(qpcrBatch.object, baseline = 1)

# View genes selected for the rank-invariant set
norm_ri@normGenes
```

**Housekeeping Gene Normalization**
Scales measurements to a specific housekeeping gene profile (different from standard delta-delta Ct).
```r
norm_hk <- normalize(qpcrBatch.object, "housekeepinggenes", c("Gpx4"))
# Or: norm_hk <- normQpcrHouseKeepingGenes(qpcrBatch.object, c("Gpx4"))
```

### 4. Assessing Performance
Use diagnostic tools to compare the variance and distribution of data before and after normalization.

**Coefficient of Variation (CV)**
```r
# Calculate average CV for the dataset
cv_raw <- calcCV(qpcrBatch.object)
cv_norm <- calcCV(norm_quant)
```

**Variance-Mean Plots**
Compare two normalization methods directly. If the lowess curve (red) is below y=0, the first method reduced variance more effectively than the second.
```r
plotVarMean(norm_quant, norm_hk, normTag1="Quantile", normTag2="HK-Gene")
```

**Distribution Plots**
Standard R plotting functions like `boxplot` or `hist` can be used on the `exprs()` slot of the objects to visualize the effects of normalization.

## Tips and Best Practices
- **Plate Indices:** Ensure `plateIndex` is correctly set in the `qpcrBatch` object, as it is critical for the quantile normalization algorithm to account for inter-plate variability.
- **Baseline Selection:** For Rank-Invariant normalization, choosing a representative baseline (like a Time 0 or a median-like sample) is important for stability.
- **Ct Values:** Remember that Ct values are inversely proportional to expression. High Ct = Low expression.

## Reference documentation
- [qpcrNorm](./references/qpcrNorm.md)