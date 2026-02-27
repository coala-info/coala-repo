---
name: bioconductor-mpra
description: The bioconductor-mpra package provides tools for the statistical analysis of Massively Parallel Reporter Assay data using the mpralm linear modeling framework. Use when user asks to perform differential activity analysis, compare allelic variants, or model mean-variance relationships in MPRA datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/mpra.html
---


# bioconductor-mpra

## Overview

The `mpra` package implements the `mpralm` framework for the statistical analysis of Massively Parallel Reporter Assay data. It leverages precision weights (similar to the `voom` framework in RNA-seq) to account for the relationship between count variability and element copy number. The package supports differential activity analysis for independent groups (e.g., different cell types) and correlated groups (e.g., allelic comparisons within the same sample).

## Core Workflow

### 1. Creating an MPRASet Object
Data must be encapsulated in an `MPRASet` object. You need DNA and RNA count matrices ($K$ rows $\times$ $S$ samples).

```r
library(mpra)

# DNA and RNA: matrices of integer counts
# eid: character vector identifying the Putative Regulatory Element (PRE)
# eseq: (optional) character vector of PRE sequences
mpraset <- MPRASet(DNA = dna_matrix, 
                   RNA = rna_matrix, 
                   eid = element_ids, 
                   eseq = NULL, 
                   barcode = NULL)
```

### 2. Differential Activity Analysis (mpralm)
The `mpralm` function is the primary tool for fitting linear models to MPRA data.

**Key Parameters:**
- `aggregate`: `"mean"` (average estimator) or `"sum"` (aggregate estimator) to combine barcode-level data.
- `model_type`: `"indep_groups"` for unpaired samples or `"corr_groups"` for paired/allelic data.
- `normalize`: `TRUE` performs total count normalization (10M reads).
- `plot`: `TRUE` displays the mean-variance relationship.

#### Scenario A: Tissue/Condition Comparison (Independent)
Used when comparing PRE activity across different cell lines or conditions.

```r
design <- data.frame(Intercept = 1, 
                     Condition = grepl("Treatment", colnames(mpraset)))
fit <- mpralm(object = mpraset, 
              design = design, 
              aggregate = "mean", 
              model_type = "indep_groups", 
              plot = TRUE)

library(limma)
results <- topTable(fit, coef = 2, number = Inf)
```

#### Scenario B: Allelic Comparison (Correlated)
Used when comparing two alleles of a SNP within the same transfection sample. Requires a `block` vector to identify paired samples.

```r
# Example: 5 samples, each with Allele A and Allele B columns
design <- data.frame(Intercept = 1, 
                     is_AlleleB = grepl("allele_B", colnames(mpraset)))
block_vector <- rep(1:5, 2) 

fit_allele <- mpralm(object = mpraset, 
                     design = design, 
                     block = block_vector, 
                     model_type = "corr_groups", 
                     aggregate = "none") # Often counts are pre-aggregated for alleles
```

### 3. Endomorphic Returns
To keep results within the `MPRASet` object (storing statistics in `rowData`), use `endomorphic = TRUE`.

```r
mpraset_results <- mpralm(object = mpraset, 
                          design = design, 
                          endomorphic = TRUE, 
                          coef = 2)
# Access results
rowData(mpraset_results)
```

## Tips and Best Practices
- **Normalization**: Always set `normalize = TRUE` unless your data is already pre-normalized.
- **Aggregation**: Use `aggregate = "mean"` if you want to account for barcode-level variability; use `"sum"` if you prefer to treat the total pool of barcodes as a single measurement.
- **Limma Integration**: The object returned by `mpralm` (unless endomorphic) is an `MArrayLM` object, compatible with all standard `limma` functions like `topTable` and `decideTests`.
- **Log Ratios**: `mpra` calculates activity as $log_2(RNA / DNA)$.

## Reference documentation
- [The mpra User's Guide](./references/mpra.Rmd)
- [The mpra User's Guide (Markdown)](./references/mpra.md)