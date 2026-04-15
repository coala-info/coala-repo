---
name: bioconductor-omicsprint
description: This tool verifies sample relationships and detects swaps within or across multi-omic datasets using genetic variant sharing. Use when user asks to verify sample identity, detect sample swaps, calculate allele sharing between datasets, or convert methylation data to genotypes for relationship testing.
homepage: https://bioconductor.org/packages/release/bioc/html/omicsPrint.html
---

# bioconductor-omicsprint

## Overview

The `omicsPrint` package provides a method for sample relationship verification within and across omics data types. It uses a set of genetic variants (SNPs) to calculate Identity by State (IBS) metrics—specifically the mean and variance of allele sharing—to classify pairs of samples as identical, related, or unrelated. It is particularly useful for quality control in multi-omic studies to ensure that data from different assays (e.g., RNA-seq, 450k/EPIC methylation, and Genotyping) are correctly linked to the same individuals.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix where rows are SNPs and columns are samples. Genotypes should be represented as integers (e.g., 1, 2, 3).

For DNA methylation data, use `beta2genotype` to convert beta-values to discrete genotype calls using an internal K-means algorithm.

```r
library(omicsPrint)
library(SummarizedExperiment)

# If starting with a SummarizedExperiment (se)
# Filter for CpGs known to overlap SNPs
data(hm450.manifest.pop.GoNL)
cpgs <- names(hm450.manifest.pop.GoNL[mcols(hm450.manifest.pop.GoNL)$MASK.snp5.EAS])
se_filtered <- se[intersect(rownames(se), cpgs), ]

# Convert to genotypes
genotypes <- beta2genotype(se_filtered, assayName = "exprs")
```

### 2. Calculating Allele Sharing
The `alleleSharing` function calculates the IBS mean and variance for all pairwise combinations.

**Intra-omic (within one matrix):**
```r
# x is a matrix of genotypes
res <- alleleSharing(x)
```

**Inter-omic (between two matrices):**
```r
# x and y are matrices from different omics (e.g., Methylation and SNP-array)
# Ensure rownames (SNP IDs) match between x and y
res <- alleleSharing(x, y)
```

### 3. Defining Expected Relations
To detect mismatches, you should provide a data frame of expected relationships.

```r
# Create a relations data frame
relations <- expand.grid(idx = colnames(x), idy = colnames(x))
relations$relation_type <- "unrelated"
relations$relation_type[relations$idx == relations$idy] <- "identical"

# Run with relations
res <- alleleSharing(x, relations = relations)
```

### 4. Inferring Relations and Detecting Mismatches
Use `inferRelations` to apply Linear Discriminant Analysis (LDA) to classify the pairs and identify samples that do not match their expected labels.

```r
# This returns a data frame of pairs where the predicted relation 
# differs from the reported relation.
mismatches <- inferRelations(res)

# Visualizing the classification
# Calling inferRelations() without assignment usually produces a diagnostic plot
inferRelations(res)
```

## Key Functions

- `alleleSharing(x, y, relations)`: Computes IBS mean and variance. If `y` is provided, it performs cross-platform matching.
- `beta2genotype(x, assayName)`: Converts DNA methylation beta-values to genotype calls (1, 2, 3).
- `inferRelations(data)`: Predicts relationships based on IBS stats and identifies discrepancies.
- `hm450.manifest.pop.GoNL`: Data object containing SNP-masked probes for 450k arrays across different populations.

## Tips for Success

- **SNP Overlap**: For cross-omic verification, ensure the row names of your matrices use the same identifier system (e.g., rs-numbers) so the package can find overlapping markers.
- **Pruning**: `alleleSharing` automatically prunes SNPs based on call rate, coverage, and Hardy-Weinberg equilibrium. You can adjust these thresholds (e.g., `callRate`, `maf`) in the function arguments.
- **Interpretation**: A mean IBS near 2.0 and variance near 0.0 strongly indicates "identical" samples (replicates or the same person).

## Reference documentation

- [Within omics sample relationship verification](./references/omicsPrint.md)