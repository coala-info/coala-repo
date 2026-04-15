---
name: bioconductor-genefu
description: The genefu package provides standardized implementations of molecular subtyping algorithms and prognostic gene signatures for breast cancer research. Use when user asks to classify breast cancer samples into molecular subtypes, compute clinical risk scores like PAM50 or OncotypeDX, and evaluate the prognostic value of gene signatures.
homepage: https://bioconductor.org/packages/release/bioc/html/genefu.html
---

# bioconductor-genefu

## Overview

The `genefu` package is a comprehensive toolkit for breast cancer research. It provides standardized implementations of major molecular subtyping algorithms and prognostic gene signatures. It is designed to work with gene expression matrices (samples as rows, genes as columns) and requires gene annotation (specifically Entrez Gene IDs) for mapping probes across different platforms like Affymetrix and Agilent.

## Core Workflows

### 1. Molecular Subtyping
The primary function for classification is `molecular.subtyping()`. It supports several models including "pam50", "scmod2", "scmgene", "ssp2006", and "ssp2003".

```r
# Data should be a matrix with samples as ROWS and genes as COLUMNS
# Annot should be a data frame with a column 'EntrezGene.ID'
subtypes <- molecular.subtyping(
  sbt.model = "pam50", 
  data = expression_matrix, 
  annot = annotation_df, 
  do.mapping = TRUE
)

# Access predictions
table(subtypes$subtype)
```

### 2. Computing Prognostic Scores
`genefu` implements numerous clinical signatures. Most follow a similar functional pattern or use the generic `sig.score()` function.

*   **GGI (Gene Expression Grading Index):** `ggi(data, annot, do.mapping = TRUE)`
*   **GENIUS:** `genius(data, annot, do.mapping = TRUE)`
*   **EndoPredict:** `endoPredict(data, annot, do.mapping = TRUE)`
*   **OncotypeDx:** `oncotypedx(data, annot, do.mapping = TRUE)`
*   **NPI (Nottingham Prognostic Index):** `npi(size, grade, node)` (Requires clinical data)
*   **ROR-S (Risk of Recurrence):** `rorS(data, annot, do.mapping = TRUE)`

### 3. Comparing Models
To evaluate which signature is more prognostic, use the `survcomp` integration.

```r
# Calculate Concordance Index (C-index)
library(survcomp)
cindex <- concordance.index(
  x = risk_scores, 
  surv.time = survival_time, 
  surv.event = survival_event
)

# Compare two meta-estimates of C-indices
comp <- cindex.comp.meta(list.cindex1, list.cindex2)
```

## Implementation Tips

*   **Data Orientation:** Unlike many R genomic packages, `genefu` functions often expect samples as **rows** and genes/probes as **columns**. Always check dimensions before calling `molecular.subtyping`.
*   **Gene Mapping:** If your data uses Gene Symbols or custom Probe IDs, ensure your `annot` data frame contains an `EntrezGene.ID` column. Set `do.mapping = TRUE` to allow the package to handle the translation to the signature's internal requirements.
*   **Robust Models:** Use the `.robust` versions of data objects (e.g., `data(scmod2.robust)`) when available, as these are often calibrated for better cross-platform performance.
*   **Duplicate Handling:** When merging multiple breast cancer datasets (e.g., from the `breastCancerVDX` or `breastCancerMAINZ` packages), use the patient IDs to check for and remove duplicates to avoid biasing survival analyses.

## Reference documentation

- [genefu: A Package for Breast Cancer Gene Expression Analysis](./references/genefu.md)