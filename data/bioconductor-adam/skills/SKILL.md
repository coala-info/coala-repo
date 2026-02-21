---
name: bioconductor-adam
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ADAM.html
---

# bioconductor-adam

name: bioconductor-adam
description: Activity and Diversity Analysis Module (ADAM) for GSEA-like functional enrichment. Use when analyzing gene expression data to identify Groups of Functionally Associated Genes (GFAGs) based on gene activity and diversity metrics. Supports KEGG, GO, and custom annotations across multiple species.

# bioconductor-adam

## Overview

The `ADAM` package implements a functional enrichment analysis that groups genes into Groups of Functionally Associated Genes (GFAGs). Unlike standard GSEA, ADAM calculates p-values based on two specific metrics: **gene activity** and **gene diversity**. It is designed for comparative studies (control vs. experiment) and supports bootstrap resampling, Wilcoxon rank-sum tests, and Fisher's exact tests to determine the significance of functional groups.

## Core Workflow

### 1. Data Preparation

ADAM requires an expression matrix where the first column contains gene identifiers and subsequent columns contain expression values (e.g., RNA-seq counts or normalized values).

```r
library(ADAM)
data("ExpressionAedes")

# Define comparisons as "control,experiment" strings
Comparison <- c("control1,experiment1", "control2,experiment2")
```

### 2. Functional Annotation

If the species is not supported by a standard Bioconductor annotation package, provide a three-column data frame (gene, function ID, function description).

```r
# Example using custom KEGG pathways
data("KeggPathwaysAedes")
# Columns: gene, pathwayID, pathwayDescription
```

### 3. Full Analysis (GFAGAnalysis)

The `GFAGAnalysis` function performs the complete pipeline, including bootstrap-based p-value calculation and optional statistical tests.

```r
Result <- GFAGAnalysis(
  ComparisonID = Comparison,
  ExpressionData = ExpressionAedes,
  MinGene = 3,                # Minimum genes per GFAG
  MaxGene = 20,               # Maximum genes per GFAG
  SeedNumber = 123,           # For reproducibility
  BootstrapNumber = 1000,     # Resampling steps
  PCorrection = 0.05,         # Significance cutoff
  PCorrectionMethod = "fdr",  # e.g., "fdr", "bonferroni"
  DBSpecies = KeggPathwaysAedes,
  AnalysisDomain = "own",     # "own", "GO", or "KEGG"
  GeneIdentifier = "geneStableID",
  WilcoxonTest = TRUE,
  FisherTest = TRUE
)
```

### 4. Partial Analysis (ADAnalysis)

Use `ADAnalysis` to calculate activity (N) and diversity (H) metrics without performing statistical significance testing. This is faster for exploratory data analysis.

```r
Result_Simple <- ADAnalysis(
  ComparisonID = Comparison,
  ExpressionData = ExpressionAedes,
  MinGene = 3,
  MaxGene = 100,
  DBSpecies = KeggPathwaysAedes,
  AnalysisDomain = "own",
  GeneIdentifier = "geneStableID"
)
```

## Interpreting Results

Both functions return a list with two elements:
1.  **Gene-Function Mapping**: A data frame showing which genes were assigned to which GroupID.
2.  **Analysis Results**: A list of data frames (one per comparison) containing:
    *   `H_`: Diversity for control and experiment.
    *   `N_`: Activity for control and experiment.
    *   `h` / `n`: Relative diversity and activity.
    *   `pValue_h` / `pValue_n`: Bootstrap p-values.
    *   `qValue_h` / `qValue_n`: Corrected p-values.
    *   `Significance`: Label indicating if the group passed the cutoff.

## Tips for Success

*   **Bootstrap Steps**: For publication-quality results, use at least 1000 bootstrap steps.
*   **Filtering**: Use `MinGene` and `MaxGene` to exclude overly specific or overly broad functional groups that might skew the statistical power.
*   **Annotation Packages**: If `AnalysisDomain` is set to "GO" or "KEGG", ensure the relevant species annotation package (e.g., `org.Hs.eg.db`) is installed.

## Reference documentation

- [ADAM: Activity and Diversity Analysis Module](./references/ADAM.md)