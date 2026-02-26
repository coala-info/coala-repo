---
name: bioconductor-epidish
description: EpiDISH performs epigenetic dissection of intra-sample heterogeneity to infer cell-type proportions and identify differentially methylated cell types in DNA methylation data. Use when user asks to estimate cell fractions in blood or solid tissue, perform hierarchical deconvolution, or identify differentially methylated cell types using the CellDMC algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/EpiDISH.html
---


# bioconductor-epidish

## Overview

EpiDISH is a tool for the epigenetic dissection of intra-sample heterogeneity. It allows users to infer the proportions of different cell types within a mixed DNA methylation sample (e.g., whole blood or solid tissue) using reference-based deconvolution. It supports three main algorithms: Robust Partial Correlations (RPC), Cibersort (CBS), and Constrained Projection (CP). Additionally, the package includes the **CellDMC** algorithm to identify differentially methylated cell types (DMCTs) in EWAS, allowing researchers to distinguish between changes in cell composition and actual epigenetic changes within specific cell populations.

## Core Workflows

### 1. Estimating Cell Fractions in Blood
For adult whole blood or cord blood, use the `epidish` function with a specific reference matrix.

```r
library(EpiDISH)

# Load reference and data
data(centDHSbloodDMC.m) # 7 immune cell types
data(LiuDataSub.m)      # Example beta value matrix

# Estimate fractions using RPC (recommended)
out.l <- epidish(beta.m = LiuDataSub.m, ref.m = centDHSbloodDMC.m, method = "RPC")
fractions <- out.l$estF
```

**Reference Selection:**
*   `centDHSbloodDMC.m`: 7 immune types (B, NK, CD4T, CD8T, Mono, Neutro, Eos).
*   `cent12CT.m`: 12 immune types for EPIC arrays.
*   `cent12CT450k.m`: 12 immune types for 450k arrays.
*   `centUniLIFE.m`: Universal reference for blood of any age (includes cord blood subtypes).

### 2. Estimating Fractions in Solid Tissue
For solid tissues (e.g., breast, lung), use a hierarchical approach or a generic tissue reference.

```r
data(centEpiFibIC.m) # Generic: Epithelial, Fibroblast, Immune
out.l <- epidish(beta.m = DummyBeta.m, ref.m = centEpiFibIC.m, method = "RPC")
```

### 3. Hierarchical Deconvolution (HEpiDISH)
Use `hepidish` when you need high-resolution immune cell subtypes within a solid tissue. This uses a two-step approach: first estimating broad categories (Epi, Fib, IC), then refining the IC fraction.

```r
data(centEpiFibIC.m)  # Primary reference
data(centBloodSub.m)  # Secondary reference (immune subtypes)

# h.CT.idx = 3 indicates the 3rd column in ref1 (IC) should be decomposed by ref2
frac.m <- hepidish(beta.m = DummyBeta.m, 
                   ref1.m = centEpiFibIC.m, 
                   ref2.m = centBloodSub.m, 
                   h.CT.idx = 3, 
                   method = 'RPC')
```

### 4. Identifying Differentially Methylated Cell-Types (CellDMC)
After estimating fractions, use `CellDMC` to find which cell types are associated with a phenotype.

```r
# pheno.v is a vector of phenotypes (e.g., 0 for control, 1 for case)
celldmc.o <- CellDMC(beta.m = DummyBeta.m, pheno.v = pheno.v, frac.m = frac.m)

# View predicted DMCTs (1: hypermethylated, -1: hypomethylated, 0: no change)
head(celldmc.o$dmct)

# Access coefficients/p-values
coeffs <- celldmc.o$coe
```

## Quality Control Tips
*   **Missing Probes:** Check `out.l$ref` and `out.l$dataREF`. If more than 1/3 of the reference probes are missing from your dataset (due to QC filtering), the estimated fractions may be unreliable.
*   **Method Selection:** `RPC` is generally recommended for its robustness to outliers and performance in benchmarking.
*   **Data Input:** Ensure your input matrix (`beta.m`) contains beta values (0 to 1) and that row names are Illumina probe IDs (cg numbers).

## Reference documentation
- [EpiDISH - Epigenetic Dissection of Intra-Sample-Heterogeneity](./references/EpiDISH.md)