---
name: bioconductor-scbn
description: SCBN performs scale-based normalization for cross-species RNA-seq data analysis by accounting for variations in gene lengths and library sizes. Use when user asks to normalize cross-species RNA-seq data, calculate scaling factors using housekeeping genes, or perform differential expression testing between species.
homepage: https://bioconductor.org/packages/release/bioc/html/SCBN.html
---

# bioconductor-scbn

## Overview

The `SCBN` (Scale Based Normalization) package is designed specifically for cross-species RNA-seq analysis. Unlike intra-species analysis, cross-species comparisons must account for variations in gene lengths between orthologs and the presence of unmapped genes unique to each species. SCBN utilizes a hypothesis-testing framework to find an optimal scaling factor by minimizing the deviation between empirical and nominal type I errors, typically using a set of known housekeeping genes as a reference.

## Workflow and Usage

### 1. Data Preparation
The input data must include gene lengths and read counts for orthologous genes across two species.

```r
library(SCBN)

# Example data structure (sim_data):
# Column 1: geneLength (Species A)
# Column 2: counts (Species A)
# Column 3: geneLength (Species B)
# Column 4: counts (Species B)
data(sim_data)
```

### 2. Calculating the Scaling Factor
The `SCBN()` function identifies the optimal scaling factor. You must provide a set of indices (`hkind`) representing housekeeping genes or genes assumed to be non-differentially expressed.

```r
# orth_gene: matrix/dataframe with 4 columns (length1, count1, length2, count2)
# hkind: indices of housekeeping genes (e.g., 1:1000)
# a: nominal type I error level (default 0.05)

factors <- SCBN(orth_gene = sim_data, hkind = 1:1000, a = 0.05)

# Access the SCBN optimal scaling factor
scbn_factor <- factors$scbn_val
```

### 3. Differential Expression Testing
Once the scaling factor is obtained, use `sageTestNew()` to calculate p-values for each orthologous gene pair. This function adjusts the standard SAGE test logic to incorporate different gene lengths and the calculated scaling factor.

```r
# Extract components for the test
x <- sim_data[, 2]       # Counts Species A
y <- sim_data[, 4]       # Counts Species B
len_x <- sim_data[, 1]   # Lengths Species A
len_y <- sim_data[, 3]   # Lengths Species B
n1 <- sum(x)             # Total library size A
n2 <- sum(y)             # Total library size B

# Calculate p-values
p_values <- sageTestNew(x, y, len_x, len_y, n1, n2, scbn_factor)

# Identify significant genes (e.g., p < 0.001)
sig_genes <- which(p_values < 1e-3)
```

### 4. Generating Simulation Data
If testing workflows, you can generate synthetic cross-species datasets using `generateDataset()`.

```r
data(orthgenes)
# Clean data (remove NAs)
orthgenes_clean <- orthgenes[complete.cases(orthgenes[, 6:9]), ]

sim_data <- generateDataset(
    commonTags = 5000, 
    uniqueTags = c(100, 300),
    unmapped = c(400, 200),
    group = c(1, 2),
    libLimits = c(0.9, 1.1) * 1e6,
    empiricalDist = orthgenes_clean[, 6],
    genelength = orthgenes_clean[, 2],
    pDifferential = 0.05
)
```

## Tips and Best Practices
- **Housekeeping Genes:** The accuracy of the scaling factor depends heavily on the choice of `hkind`. Ensure these indices point to genes with stable expression across the species being compared.
- **Data Format:** Ensure the input matrix follows the specific 4-column format (Length1, Count1, Length2, Count2) required by the `SCBN` function.
- **Interpretation:** The `SCBN()` output also provides `median_val` (a median-based scaling method). The `scbn_val` is generally preferred as it is the optimized result of the package's specific algorithm.

## Reference documentation
- [SCBN Tutorial](./references/SCBN.md)