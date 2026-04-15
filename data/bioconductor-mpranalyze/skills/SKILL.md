---
name: bioconductor-mpranalyze
description: MPRAnalyze is an R package that uses a nested generalized linear model framework to perform statistical analysis of Massively Parallel Reporter Assay data. Use when user asks to quantify enhancer activity, identify differential activity between conditions, or perform comparative analysis of MPRA count data.
homepage: https://bioconductor.org/packages/release/bioc/html/MPRAnalyze.html
---

# bioconductor-mpranalyze

## Overview
MPRAnalyze is an R package designed for the statistical analysis of Massively Parallel Reporter Assays (MPRA). Unlike ratio-based methods, it uses a nested generalized linear model (GLM) framework to model DNA (copy number) and RNA (transcription) counts separately. This approach accounts for the specific architecture of MPRA experiments, including multiple barcodes per enhancer, batch effects, and different experimental designs (episomal vs. integrated).

## Core Workflow

### 1. Data Preparation
Input requires two count matrices (DNA and RNA) where rows are enhancers and columns are observations. You also need annotation data frames for both.
- **DNA Counts:** Plasmid library counts.
- **RNA Counts:** Transcribed reporter counts.
- **Controls:** A logical vector identifying negative control enhancers (e.g., scrambled sequences).

```r
library(MPRAnalyze)

# Create the MpraObject
obj <- MpraObject(dnaCounts = dna_mat, 
                  rnaCounts = rna_mat, 
                  dnaAnnot = dna_annot, 
                  rnaAnnot = rna_annot, 
                  controls = is_control_vector)
```

### 2. Normalization
Estimate library size depth factors. You must specify which factors in your annotation represent distinct libraries (e.g., batch and condition).

```r
# Estimate for both DNA and RNA simultaneously
obj <- estimateDepthFactors(obj, lib.factor = c("batch", "condition"), which.lib = "both")
```

### 3. Quantification Analysis
Used to estimate the absolute transcription rate (alpha) for each enhancer.
- **dnaDesign:** Model for plasmid copy number (e.g., `~ batch`).
- **rnaDesign:** Model for transcription rate (e.g., `~ condition`).

```r
obj <- analyzeQuantification(obj = obj, 
                             dnaDesign = ~ batch, 
                             rnaDesign = ~ condition)

# Extract alpha values
alpha <- getAlpha(obj, by.factor = "condition")

# Test for activity against negative controls
res <- testEmpirical(obj = obj, statistic = alpha$active_condition)
# Use res$pval.mad for robust p-values
```

### 4. Comparative Analysis
Used to identify enhancers with differential activity between conditions.
- **reducedDesign:** The null model (usually `~ 1`).

```r
obj <- analyzeComparative(obj = obj, 
                          dnaDesign = ~ barcode + batch + condition, 
                          rnaDesign = ~ condition, 
                          reducedDesign = ~ 1)

# Likelihood Ratio Test
res <- testLrt(obj)
# res contains statistic, pval, fdr, and logFC
```

## Advanced Features

### Scalable Mode
For large datasets with many barcodes where the standard GLM is slow, use `mode="scale"`. This requires matched DNA and RNA observations and uses DNA counts directly as offsets.
```r
obj <- analyzeComparative(obj = obj, 
                          rnaDesign = ~ condition, 
                          reducedDesign = ~ 1, 
                          mode = "scale")
```

### Allelic Comparison
When comparing two sequences that do not share barcodes (e.g., SNP alleles), create a unique interaction factor for barcodes and conditions in the annotation before running a comparative analysis.
```r
annot$barcode_allelic <- interaction(annot$barcode, annot$condition)
```

## Best Practices
- **Barcode Modeling:** Include barcodes in the `dnaDesign` for comparative analyses to increase power, but avoid them in `rnaDesign` to prevent overfitting.
- **Zero Padding:** All enhancers must have the same number of columns; pad missing observations with 0.
- **Controls:** Always include negative controls to calibrate the null distribution and correct for systemic biases.
- **Parallelization:** Use `BiocParallel` to speed up model fitting by passing a `BPPARAM` object to `MpraObject`.

## Reference documentation
- [Analyzing MPRA data with MPRAnalyze](./references/vignette.md)
- [Analyzing MPRA data with MPRAnalyze (Rmd Source)](./references/vignette.Rmd)