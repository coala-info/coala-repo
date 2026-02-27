---
name: bioconductor-mulcom
description: This tool identifies differentially expressed genes in multiple-group comparisons against a single control using a modified Dunnett's t-test. Use when user asks to identify differentially expressed genes, compare multiple experimental groups to a single control, or estimate False Discovery Rates through Monte Carlo simulations.
homepage: https://bioconductor.org/packages/release/bioc/html/Mulcom.html
---


# bioconductor-mulcom

## Overview

The `Mulcom` package implements a statistical test for identifying differentially expressed genes in multiple-group comparisons against a single control. It is based on a modified Dunnett's t-test. The method incorporates a "m" parameter (log2 ratio correction) and a "t" parameter (threshold for the t-statistic) to refine gene selection and estimate False Discovery Rates (FDR) through Monte Carlo simulations (permutations).

## Core Workflow

The typical analysis pipeline involves calculating scores, performing permutations, optimizing parameters, and extracting significant features.

### 1. Data Preparation
The input should be an `ExpressionSet` or `AffyBatch`. You must define a numeric index vector where `0` represents the control group and subsequent integers (`1, 2, 3...`) represent experimental groups.

```r
# Example index for 2 controls and 2 groups with 2 replicates each
groups <- c(0, 0, 1, 1, 2, 2)
```

### 2. Calculate MulCom Scores
Calculate the numerator and denominator of the test (without $m$ and $t$ applied yet).

```r
library(Mulcom)
data(benchVign) # Loads 'Affy' example
mulcom_scores <- mulScores(Affy, Affy$Groups)
```

### 3. Monte Carlo Simulation (Permutation)
To estimate FDR, run permutations. This creates a `MULCOM_P` object.

```r
# np: number of permutations
mulcom_perm <- mulPerm(Affy, Affy$Groups, np = 100, seed = 123)
```

### 4. Parameter Optimization
Find the optimal $m$ and $t$ values that maximize the number of significant genes at a specific FDR threshold (e.g., 0.05).

```r
# Define ranges for m and t
vm <- seq(0.1, 0.5, 0.1)
vt <- seq(1, 3, 0.1)

# Run optimization
mulcom_opt <- mulOpt(mulcom_perm, vm, vt)

# Identify best parameters for a specific comparison (ind)
# ind = 1 refers to the first experimental group vs control
opt_params <- mulParOpt(mulcom_perm, mulcom_opt, ind = 1, th = 0.05)
```

### 5. Identifying Significant Genes
Once $m$ and $t$ are selected, extract the results.

```r
# Identify candidates across all comparisons
mulcom_cand <- mulCAND(Affy, mulcom_perm, m = 0.2, t = 2)

# Identify differentially expressed features for a specific comparison
# ind = 1 is the first comparison
diff_genes <- mulDiff(Affy, mulcom_perm, m = 0.2, t = 2, ind = 1)
```

## Key Functions

- `mulScores(eset, index)`: Computes the base MulCom test scores.
- `mulPerm(eset, index, np, seed)`: Performs permutations for FDR estimation.
- `mulOpt(Mulcom_P, vm, vt)`: Systematically tests combinations of $m$ and $t$.
- `mulParOpt(perm, M.Opt, ind, th)`: Returns the best $m/t$ combination for a given FDR threshold.
- `mulOptPlot(M.Opt, ind, th)`: Visualizes the optimization space (FDR and gene count).
- `mulFSG(Mulcom_P, m, t)`: Calculates the number of False Significant Genes.
- `mulCalc(Mulcom_P, m, t)`: Calculates the final MulCom score for specific parameters.

## Tips
- **Group Indexing**: Ensure the group index is numeric and starts at 0 for control.
- **Memory Management**: For very large datasets, set `segm = "T"` in `mulPerm` to avoid memory segmentation faults in the C subroutines.
- **Parameter Selection**: The $m$ parameter acts as a fold-change filter. Increasing $m$ usually decreases the number of significant genes but can improve the reliability of the FDR estimate.

## Reference documentation
- [Mulcom Reference Manual](./references/reference_manual.md)