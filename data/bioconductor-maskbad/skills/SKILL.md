---
name: bioconductor-maskbad
description: This tool identifies and masks Affymetrix probes with binding affinity differences between sample groups to reduce bias in differential expression analysis. Use when user asks to identify BAD probes, mask probes in AffyBatch objects, or account for sequence divergence in cross-species and cross-strain Affymetrix array studies.
homepage: https://bioconductor.org/packages/release/bioc/html/maskBAD.html
---

# bioconductor-maskbad

name: bioconductor-maskbad
description: Identify and remove Affymetrix probes with Binding Affinity Differences (BAD) between sample groups. Use this skill when analyzing Affymetrix 3' IVT or whole transcript (exon/gene) arrays where SNPs, transcript isoforms, or cross-hybridization might bias differential expression analysis, particularly in cross-species or cross-strain comparisons.

# bioconductor-maskbad

## Overview

The `maskBAD` package detects probes that exhibit different binding affinities between two groups of samples. These "BAD" probes can introduce false positives or mask real differences in gene expression. The package provides a workflow to score probes based on pairwise correlations within probe sets, evaluate cutoffs using external sequence data or statistical tests, and generate "masked" AffyBatch objects for downstream analysis with `rma` or `gcrma`.

## Core Workflow

### 1. Identification of BAD Probes

The primary function `mask()` scores probes based on their signal correlation relative to other probes in the same set across two groups.

```R
library(maskBAD)
# ind: numeric vector defining groups (e.g., 1 for Group A, 2 for Group B)
# useExpr: if TRUE, uses mas5calls to filter for expressed genes (3' IVT only)
exmask <- mask(myAffyBatch, ind = rep(1:2, each = 10), useExpr = TRUE)

# Access quality scores
head(exmask$probes)
```

### 2. Choosing a Cutoff

A cutoff must be selected to determine which probes to discard.

*   **Quantile-based:** If sequence divergence is known (e.g., 1%), use that percentage as a guide.
*   **Manual Inspection:** Use `plotProbe()` to visualize signal intensity of a specific probe against its probe set.
*   **External Validation:** If you have sequence data (SNP locations), use `overlapExprExtMasks()` to compare the expression-based mask against known sequence differences.

```R
# Plotting a specific probe to inspect binding behavior
plotProbe(affy = myAffyBatch, 
          probeset = "1000_at", 
          probeXY = "399_559", 
          ind = rep(1:2, each = 10), 
          exmask = exmask$probes)
```

### 3. Masking and Expression Estimation

Once a cutoff is chosen, create a new AffyBatch and a modified CDF environment.

```R
# Create masked AffyBatch
cutoff_val <- 0.029
masked_data <- prepareMaskedAffybatch(affy = myAffyBatch, 
                                      exmask = exmask$probes, 
                                      cutoff = cutoff_val)

# Extract the new AffyBatch and CDF
new_affybatch <- masked_data[[1]]
new_cdf <- masked_data[[2]]

# IMPORTANT: The new CDF must be in the global environment for rma/gcrma
assign(cdfName(new_affybatch), new_cdf)

# Estimate expression using RMA
eset <- rma(new_affybatch)
```

## Working with GCRMA

If using `gcrma`, you must also mask the probe affinities.

```R
library(gcrma)
# Compute affinities using standard CDF
affinities <- compute.affinities("hgu95av2")

# Mask the affinities
masked_affinities <- prepareMaskedAffybatch(affy = affinities, 
                                            exmask = exmask$probes, 
                                            cdfName = "MaskedAffinitiesCdf")

# Calculate expression
eset_gcrma <- gcrma(new_affybatch, masked_affinities)
```

## Special Cases: Exon and Gene Arrays

For Exon or Gene arrays, the workflow changes slightly:
*   Set `useExpr = FALSE` in `mask()` because these arrays lack MM probes required for `mas5calls`.
*   Use the `exprlist` parameter to process a subset of probe sets to reduce computation time on large arrays.

## Reference documentation

- [maskBAD Vignette](./references/maskBAD.md)