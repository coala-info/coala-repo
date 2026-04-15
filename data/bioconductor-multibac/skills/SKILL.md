---
name: bioconductor-multibac
description: Bioconductor-multibac corrects batch effects and removes systematic noise from single-omic and multi-omic datasets using ARSyNbac and MultiBaC methods. Use when user asks to remove batch effects from high-throughput biological data, integrate multi-omic datasets sharing a common omic type, or filter structured noise from genomic experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/MultiBaC.html
---

# bioconductor-multibac

name: bioconductor-multibac
description: Batch effect correction for single-omic and multi-omic datasets using ARSyNbac and MultiBaC. Use this skill when you need to remove systematic noise or batch effects from high-throughput biological data, especially when combining datasets from different labs or technologies that share at least one common omic type.

# bioconductor-multibac

## Overview

MultiBaC is a Bioconductor package designed to correct batch effects in both single-omic and multi-omic scenarios. It provides two primary methods:
1. **ARSyNbac**: An adaptation of the ARSyN method that uses ANOVA-Simultaneous Components Analysis (ASCA) to remove structured noise and batch effects from a single omic type.
2. **MultiBaC**: A strategy for multi-omic data integration that corrects batch effects across different omic types (e.g., RNA-seq, Proteomics, Metabolomics) by leveraging a common omic type present across all batches.

## Typical Workflow

### 1. Data Preparation
MultiBaC uses the `mbac` object, which is a list of `MultiAssayExperiment` objects (one per batch).

```r
library(MultiBaC)

# Create the mbac object
# inputOmics: list of matrices (features in rows, samples in columns)
# batchFactor: vector identifying the batch for each input matrix
# experimentalDesign: list of factors/data.frames describing conditions per batch
# omicNames: names for each input matrix (common omics must have the same name)
my_mbac <- createMbac(
  inputOmics = list(batch1_rna, batch1_gro, batch2_rna, batch2_metab),
  batchFactor = c("B1", "B1", "B2", "B2"),
  experimentalDesign = list(
    "B1" = c("Control", "Control", "Treat", "Treat"),
    "B2" = c("Control", "Treat")
  ),
  omicNames = c("RNA", "GRO", "RNA", "METAB")
)
```

### 2. Single Omic Correction (ARSyNbac)
Use this when you have one omic type across multiple batches or want to reduce unknown noise.

```r
# batchEstimation: TRUE if batch source is known
# filterNoise: TRUE to remove unknown structured noise from residuals
corrected_single <- ARSyNbac(
  my_mbac, 
  batchEstimation = TRUE, 
  filterNoise = TRUE,
  Variability = 0.90 # Threshold for explained batch variability
)
```

### 3. Multi-Omic Correction (MultiBaC)
Use this when batches contain different omics but share at least one common omic (e.g., all batches have RNA-seq).

```r
# MultiBaC wrapper function
final_mbac <- MultiBaC(
  my_mbac,
  test.comp = NULL,    # Max PLS components
  Interaction = FALSE, # Model interaction between batch and condition
  Variability = 0.90   # Variability threshold for ARSyN step
)

# Access corrected data
corrected_data_list <- final_mbac$CorrectedData
```

### 4. Visualization and Validation
MultiBaC provides specialized plotting methods to evaluate correction performance.

```r
# PCA plots to see batch separation before and after
plot(final_mbac, typeP = "pca.org") # Original data
plot(final_mbac, typeP = "pca.cor") # Corrected data
plot(final_mbac, typeP = "pca.both") # Side-by-side comparison

# Diagnostic plots
plot(final_mbac, typeP = "inner") # PLS inner correlation (linearity check)
plot(final_mbac, typeP = "batch") # Magnitude of estimated batch effects
```

## Key Functions

- `createMbac()`: Initializes the data structure. Requires common omic variables to have matching row names.
- `ARSyNbac()`: Performs correction on a single omic. Useful for "noise reduction" mode when batch factors are unknown.
- `MultiBaC()`: The main wrapper for multi-omic correction. It fits PLS models to predict missing omics across batches before applying ARSyN-based correction.
- `genModelList()`, `genMissingOmics()`, `batchCorrection()`: Intermediate functions for running the MultiBaC workflow step-by-step.

## Tips for Success

- **Common Omic**: MultiBaC requires at least one common omic type across all batches to act as a bridge.
- **Feature Identifiers**: Ensure that the common omic uses the same ID system (e.g., Gene Symbols or Entrez IDs) across all matrices.
- **Experimental Design**: Within a single batch, all omic types must have the same samples in the same order.
- **Interaction Term**: Setting `Interaction = TRUE` in `MultiBaC` or `ARSyNbac` can provide a better fit if the batch effect varies significantly between experimental conditions, but use it cautiously to avoid over-correcting biological signals.

## Reference documentation
- [MultiBaC user’s guide](./references/MultiBaC.md)