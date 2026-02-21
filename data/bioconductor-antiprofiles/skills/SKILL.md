---
name: bioconductor-antiprofiles
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/antiProfiles.html
---

# bioconductor-antiprofiles

## Overview

The `antiProfiles` package implements a method for developing cancer genomic signatures by modeling increased gene expression variability (heterogeneity) in cancer. Unlike traditional methods that look for mean differences, anti-profiles identify genes that are tightly regulated in normal tissues but become hyper-variable in tumors. This approach is particularly useful for creating robust signatures that can accurately distinguish tumor samples from healthy controls across different datasets.

## Core Workflow

### 1. Data Preparation
The package typically works with `ExpressionSet` objects. Ensure your data is normalized and contains both normal and cancer samples.

```r
library(antiProfiles)
library(antiProfilesData)

# Example using built-in colon data
data(apColonData)

# Filter samples if necessary (e.g., removing adenomas)
apColonData <- apColonData[, apColonData$SubType != "adenoma"]
```

### 2. Computing Variance Statistics
Use `apStats` to calculate the ratio of cancer variance to normal variance. This function identifies candidate differentially variable genes.

```r
# Define training samples (e.g., from a specific experiment)
trainIdx <- pData(apColonData)$ExperimentID == "GSE4183"

# Compute statistics
# minL: minimum number of samples per group
colonStats <- apStats(exprs(apColonData)[, trainIdx], 
                      pData(apColonData)$Status[trainIdx], 
                      minL = 5)

# View results
head(getProbeStats(colonStats))
```

### 3. Building the Anti-Profile
Select the most hyper-variable probesets to construct the signature.

```r
# sigsize: number of probesets to include in the signature
# tissueSpec: if TRUE, filters for tissue-specific expression
ap <- buildAntiProfile(colonStats, tissueSpec = FALSE, sigsize = 100)
print(ap)
```

### 4. Scoring Samples
The anti-profile score counts how many genes in a sample fall outside the "normal" expression range (defined as the normal median ± 5 * normal MAD).

```r
# Calculate scores for test samples
testExprs <- exprs(apColonData)[, !trainIdx]
scores <- apCount(ap, testExprs)

# Visualize results
plot(scores, col = as.factor(pData(apColonData)$Status[!trainIdx]), pch = 19)
```

## Key Functions

- `apStats(data, cl, minL)`: Calculates variance ratios and medians for normal vs. cancer groups.
- `buildAntiProfile(stats, tissueSpec, sigsize)`: Constructs the anti-profile object using the top hyper-variable genes.
- `apCount(ap, data)`: Generates the anti-profile score for new samples based on the deviation from the normal profile.
- `getProbeStats(object)`: Accessor function to retrieve the underlying statistics from an `AntiProfileStats` object.

## Tips for Success

- **Training/Testing Split**: Always build the anti-profile on a training set of normal and cancer samples and validate the scoring on an independent test set.
- **Signature Size**: While 100 genes is a common starting point (`sigsize = 100`), the optimal size may vary depending on the cancer type and data quality.
- **Interpretation**: A high anti-profile score indicates that a sample's gene expression pattern deviates significantly from the tightly regulated "normal" state, suggesting a cancerous profile.

## Reference documentation

- [Introduction to antiProfiles](./references/antiProfiles.md)