---
name: bioconductor-padog
description: PADOG performs gene set analysis by down-weighting genes that appear in multiple pathways to improve the ranking of relevant biological processes. Use when user asks to perform gene set enrichment analysis, account for overlapping genes in pathways, or benchmark new gene set analysis methods against gold-standard datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/PADOG.html
---


# bioconductor-padog

## Overview

PADOG is a gene set analysis (GSA) method that addresses the issue of "overlapping genes"—genes that appear in multiple pathways. Standard GSA methods often over-emphasize pathways containing many common genes. PADOG down-weights these genes, favoring those unique to fewer pathways, which improves the sensitivity and ranking of relevant biological processes. It uses sample permutations to maintain gene-gene correlation structures and provides a robust benchmarking framework using 24 gold-standard datasets from the `KEGGdzPathwaysGEO` package.

## Core Workflow

### 1. Data Preparation
PADOG requires an expression matrix and experimental design information. It is designed to work with `ExpressionSet` objects or standard R matrices.

```R
library(PADOG)
# Example using a dataset from KEGGdzPathwaysGEO
library(KEGGdzPathwaysGEO)
data("GSE9348")
exp_data <- exprs(GSE9348)
group_labels <- pData(GSE9348)$Group
annotation_db <- paste0(annotation(GSE9348), ".db")
```

### 2. Running PADOG
The `padog` function is the primary interface. It calculates a gene set score as the mean of absolute values of weighted moderated gene t-scores.

```R
results <- padog(
  esetm = exp_data,          # Expression matrix
  group = group_labels,      # Factor with 2 levels (e.g., "Control", "Disease")
  paired = FALSE,            # Set TRUE for paired samples
  block = NULL,              # Blocking variable for paired/block designs
  gslist = "KEGGRESTpathway",# Gene set list (default uses KEGG via KEGGREST)
  organism = "hsa",          # Species code (e.g., 'hsa' for human)
  annotation = annotation_db,# Annotation package (e.g., "hgu133plus2.db")
  NI = 1000,                 # Number of permutations (use 1000+ for publication)
  parallel = TRUE,           # Use parallel processing if doParallel is installed
  plots = TRUE               # Generate diagnostic plots
)
```

### 3. Interpreting Results
The output is a dataframe ranked by the `Ppadog` column.
- **Ppadog**: The p-value calculated using PADOG weights.
- **PmeanAbsT**: The p-value calculated without weights (standard absolute t-score mean).
- **Size**: Number of genes in the pathway.
- **Comparison**: If `Ppadog` < `PmeanAbsT`, the weighting scheme successfully improved the significance of the pathway by accounting for gene overlaps.

## Benchmarking New Methods
PADOG provides a framework to compare a user-defined GSA method against PADOG and GSA (Efron and Tibshirani) using 24 curated datasets where a "target" pathway is known to be relevant.

### Defining a Benchmark Function
Your custom function must accept `set`, `mygslist`, and `minsize` and return a dataframe with columns: `ID`, `P`, `Rank`, `Dataset`, and `Method`.

```R
# Example: A random p-value method for benchmarking
my_method <- function(set, mygslist, minsize) {
  # 1. Load data and filter probes
  # 2. Calculate p-values for gene sets
  # 3. Return results for targetGeneSets only
}

# Run comparison
comparison <- compPADOG(
  datasets = c("GSE9348", "GSE8671"), 
  existingMethods = c("PADOG", "GSA"),
  mymethods = list(myCustomMethod = my_method),
  NI = 1000,
  parallel = TRUE
)
```

## Tips and Best Practices
- **Parallelization**: Always set `parallel = TRUE` and ensure `doParallel` is loaded for `NI > 50`, as permutations are computationally expensive.
- **Gene Identifiers**: PADOG typically expects Entrez IDs. Ensure your annotation package matches the expression data.
- **Target Gene Sets**: When benchmarking, the `targetgs` argument allows you to highlight a specific pathway (e.g., "Colorectal Cancer" for a colorectal dataset) to see how its rank improves with PADOG.
- **Minimum Size**: Use `Nmin` (default 3) to exclude very small gene sets that may produce unstable p-values.

## Reference documentation
- [PADOG](./references/PADOG.md)