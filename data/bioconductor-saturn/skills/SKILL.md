---
name: bioconductor-saturn
description: satuRn is a Bioconductor package for differential transcript usage analysis in bulk and single-cell transcriptomics data. Use when user asks to perform differential transcript usage analysis, fit quasi-binomial models to transcript counts, or test for differential usage of exons and equivalence classes.
homepage: https://bioconductor.org/packages/release/bioc/html/satuRn.html
---


# bioconductor-saturn

## Overview

`satuRn` is a Bioconductor package designed for differential transcript usage (DTU) analysis. It models transcript usage profiles using a quasi-binomial generalized linear model (GLM), which provides a scalable and flexible framework for both bulk and single-cell transcriptomics. The package is feature-agnostic; it can perform differential usage analysis on transcripts, exons, or equivalence classes (TCCs), provided the input is structured as a `SummarizedExperiment`.

## Core Workflow

### 1. Data Preparation
`satuRn` requires a `SummarizedExperiment` (or `SingleCellExperiment`) where:
- **Assays**: Contains a count matrix (e.g., transcript-level counts).
- **rowData**: Must contain columns `isoform_id` (the feature name) and `gene_id` (the grouping variable).
- **colData**: Contains experimental design metadata.

**Important**: You must filter out "lonely" features (genes with only one expressed isoform/exon) as they cannot exhibit differential usage.

```r
library(satuRn)
library(SummarizedExperiment)

# Example filtering and setup
# Ensure rowData has 'isoform_id' and 'gene_id'
# Remove transcripts that are the only isoform expressed for a gene
txInfo <- subset(txInfo, duplicated(gene_id) | duplicated(gene_id, fromLast = TRUE))

sumExp <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    colData = metadata,
    rowData = txInfo
)
```

### 2. Fitting Models (`fitDTU`)
The `fitDTU` function models the usage of each feature. It uses a formula interface similar to `lm` or `glm`.

```r
sumExp <- satuRn::fitDTU(
    object = sumExp,
    formula = ~ 0 + group_variable,
    parallel = FALSE, # Set TRUE for large datasets
    verbose = TRUE
)
```

### 3. Testing for Differential Usage (`testDTU`)
Define contrasts using a contrast matrix (often created via `limma::makeContrasts`). `satuRn` provides both raw and empirical p-values. **Always prefer the empirical p-values** (`empirical_pval`) for downstream inference.

```r
# Create contrast matrix
L <- limma::makeContrasts(
    Contrast1 = GroupA - GroupB,
    levels = design_matrix
)

# Perform test
sumExp <- satuRn::testDTU(
    object = sumExp,
    contrasts = L,
    diagplot1 = TRUE, # Check empirical null distribution
    diagplot2 = TRUE  # Check adjusted test statistics
)

# Access results
results <- rowData(sumExp)[["fitDTUResult_Contrast1"]]
```

### 4. Visualization (`plotDTU`)
Visualize the usage profiles of top-ranked features or specific genes of interest.

```r
plots <- satuRn::plotDTU(
    object = sumExp,
    contrast = "Contrast1",
    groups = list(cells_in_groupA, cells_in_groupB),
    coefficients = list(c(1, 0), c(0, 1)), # Match design matrix columns
    summaryStat = "model",
    top.n = 3
)
# Display plots
for (p in plots) print(p)
```

## Advanced Usage

### Equivalence Class-Level Analysis
For 10X Genomics data where transcript-level quantification is difficult, use equivalence classes (TCCs).
- Use `fishpond::alevinEC` to import Alevin data.
- Ensure `multigene = FALSE` to keep equivalence classes unique to a single gene.
- The workflow remains identical to DTU once the `SummarizedExperiment` is created.

### Exon-Level Analysis
For differential exon usage (DEU):
- Import data using `DEXSeq` wrappers or similar tools.
- Map `groupID` to `gene_id` and `featureID` to `isoform_id`.
- Proceed with `fitDTU` and `testDTU`.

### Gene-Level FDR Control
To control FDR at the gene level (rather than transcript level), post-process `satuRn` results with the `stageR` package. This involves a screening stage (gene-level) and a confirmation stage (transcript-level).

## Reference documentation

- [Main vignette: transcript-level analyses](./references/Vignette.md)
- [Vignette for equivalence class-level analyses](./references/Vignette_eqclass.Rmd)
- [Vignette for exon-level analyses](./references/Vignette_exon.Rmd)