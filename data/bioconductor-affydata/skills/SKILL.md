---
name: bioconductor-affydata
description: This package provides the Dilution example dataset for demonstrating and testing Affymetrix microarray data processing workflows. Use when user asks to load the Dilution AffyBatch object, perform probe-level normalization, or visualize microarray data using boxplots and MVA plots.
homepage: https://bioconductor.org/packages/release/data/experiment/html/affydata.html
---

# bioconductor-affydata

name: bioconductor-affydata
description: Provides access to the 'Dilution' example dataset for the affy package. Use this skill when you need to demonstrate or test Affymetrix microarray data processing workflows, including loading AffyBatch objects, performing normalization, and visualizing probe-level data (boxplots, MVA plots).

# bioconductor-affydata

## Overview

The `affydata` package is a data-only package providing a subset of the "Dilution" experiment conducted by Gene Logic. It is primarily used as a standard example dataset for the `affy` package to demonstrate probe-level analysis of Affymetrix GeneChip data. The dataset consists of four arrays (two sets of technical replicates) hybridized with different concentrations of RNA and scanned using different scanners.

## Typical Workflow

### 1. Loading the Data
The primary object in this package is `Dilution`, which is an `AffyBatch` object.

```r
library(affydata)
data(Dilution)

# View summary of the AffyBatch object
print(Dilution)
```

### 2. Inspecting Metadata
You can access sample information (phenotype data) to understand the experimental design, such as RNA concentration (`liver`) and scanner effects.

```r
# View sample names and variable labels
phenoData(Dilution)

# View the actual metadata table
pData(Dilution)
```

### 3. Visualizing Raw Data
Use boxplots to identify the need for normalization (e.g., observing scanner effects or intensity differences between replicates).

```r
# Boxplot of log-intensities
boxplot(Dilution, col=c(2,2,3,3))
```

### 4. Normalization
The package demonstrates how to normalize data to remove systematic biases. You can check available methods and apply them using the `normalize` function.

```r
# List available normalization methods
normalize.methods(Dilution)

# Example: Normalize concentration groups separately and combine
norm_1_2 <- normalize(Dilution[, 1:2])
norm_3_4 <- normalize(Dilution[, 3:4])
normalized.Dilution <- Biobase::combine(norm_1_2, norm_3_4)

# Verify normalization with a boxplot
boxplot(normalized.Dilution, col=c(2,2,3,3), main="Normalized Arrays")
```

### 5. MVA Plots (MA-plots)
MVA plots (log-ratio vs. average log-intensity) are used to compare replicates. In a good replicate pair, the cloud of points should be centered around zero.

```r
# Select a subset of genes for faster plotting
gn <- sample(geneNames(Dilution), 100)

# Extract PM (Perfect Match) probes for specific samples
pms <- pm(Dilution[, 3:4], gn)

# Generate pairwise MVA plots
mva.pairs(pms)
```

## Tips
- **Object Class**: The `Dilution` object is an `AffyBatch`. Most functions used on it (like `pm()`, `geneNames()`, and `normalize()`) are actually defined in the `affy` package.
- **Subsetting**: You can subset the `AffyBatch` using standard R syntax: `Dilution[, 1:2]` selects the first two arrays.
- **Scanner Effects**: The Dilution dataset is specifically known for having a strong scanner effect, making it an excellent case study for normalization techniques.

## Reference documentation
- [affydata](./references/affydata.md)