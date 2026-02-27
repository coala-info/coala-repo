---
name: bioconductor-pvac
description: This tool filters non-informative probesets from Affymetrix GeneChip microarray data using a PCA-based consistency measure. Use when user asks to filter genes in AffyBatch objects, reduce hypotheses for multiple testing correction, or calculate PVAC scores to identify informative probesets.
homepage: https://bioconductor.org/packages/release/bioc/html/pvac.html
---


# bioconductor-pvac

name: bioconductor-pvac
description: Filter genes in Affymetrix GeneChip data using the Proportion of Variation Accounted for by the first principal component (PVAC). Use this skill when analyzing probe-level microarray data (AffyBatch objects) to reduce the number of hypotheses for multiple testing correction by removing non-informative probesets based on low probe-concordance.

## Overview

The `pvac` package provides a PCA-based filtering method for Affymetrix GeneChips. It operates on the principle that since all probes in a probeset target the same transcript cluster, their measurements should be correlated. The degree of concordance is measured by the PVAC score (the proportion of variation accounted for by the first principal component). Probesets with low PVAC scores are considered non-informative or "absent" and are filtered out to increase statistical power for downstream differential expression analysis.

## Typical Workflow

### 1. Data Preparation
Load the necessary libraries and read CEL files into an `AffyBatch` object. It is recommended to have at least 6 samples for effective PCA-based filtering.

```r
library(affy)
library(pvac)

# Read CEL files from a directory
abatch <- ReadAffy(celfile.path="/path/to/celfiles")

# Standard summarization (e.g., RMA) to create an ExpressionSet
myeset <- rma(abatch)
```

### 2. Perform PVAC Filtering
Use the `pvacFilter` function on the `AffyBatch` object. This function calculates PVAC scores and determines a data-driven threshold.

```r
# Perform filtering
ft <- pvacFilter(abatch)

# The output 'ft' contains:
# ft$aset: Indices of probesets that passed the filter
# ft$pvac: PVAC scores for all probesets
# ft$cutoff: The calculated threshold value
# ft$nullset: Indices of probesets used to derive the threshold (MAS5 "Absent" calls)

# Apply the filter to your ExpressionSet
myeset.filtered <- myeset[ft$aset, ]
```

### 3. Visualizing the Threshold
You can visualize the distribution of PVAC scores and the chosen cutoff to verify the filtering logic.

```r
# Plot density of null set (gray) vs all probesets (black)
plot(density(ft$pvac[ft$nullset]), xlab="PVAC score", main="PVAC Filtering Threshold", col="gray", xlim=c(0,1))
lines(density(ft$pvac), col="black")
abline(v=ft$cutoff, lty=2, col="red")
```

## Key Functions and Parameters

- `pvacFilter(abatch, pct = 0.99)`
    - `abatch`: An `AffyBatch` object containing probe-level data.
    - `pct`: The percentile of PVAC scores in the "null set" (probesets called Absent by MAS5) used to set the cutoff. Default is 0.99.
    - **Note**: The maximum allowable threshold is capped at 0.5 (50% variation).

## Usage Tips

- **Sample Size**: Ensure you have at least 6 samples. PCA on very small cohorts is unstable.
- **Outliers**: Remove outlier samples before running `pvacFilter`, as they can skew the principal component calculation.
- **MAS5 Dependency**: The package automatically uses the `mas5calls` function from the `affy` package to identify a "null set" of probesets for threshold derivation.
- **Progress Bar**: Install the `pbapply` package to see a progress bar during the computation of PVAC scores.
- **Downstream Analysis**: After filtering, you can proceed with standard differential expression tools like `limma` or `genefilter` on the reduced `ExpressionSet`.

## Reference documentation

- [Gene filtering by PCA for Affymetrix GeneChips](./references/pvac.md)