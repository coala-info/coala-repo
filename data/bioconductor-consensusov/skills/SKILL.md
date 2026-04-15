---
name: bioconductor-consensusov
description: The consensusOV package provides a unified interface for molecular subtyping of high-grade serous ovarian cancer using multiple classification schemes and a consensus classifier. Use when user asks to classify ovarian cancer gene expression data into molecular subtypes, implement the Verhaak, Helland, Bentink, or Konecny classification methods, or generate a consensus subtype assignment.
homepage: https://bioconductor.org/packages/release/bioc/html/consensusOV.html
---

# bioconductor-consensusov

## Overview

The `consensusOV` package provides a unified interface for molecular subtyping of high-grade serous ovarian cancer (HGSOC). It implements four major published classification schemes and introduces a consensus classifier that improves robustness by consolidating these methods. It is designed for whole-transcriptome gene expression data, typically requiring Entrez Gene IDs.

## Core Workflow

### 1. Data Preparation
The package accepts either an `ExpressionSet` object or a matrix of gene expression values.
- **Matrix format**: Genes as rows, patients as columns.
- **Gene Identifiers**: Entrez IDs are required. If using the Verhaak method, ensure row names do not contain prefixes like "geneid." (use `gsub` to clean if necessary).

```r
library(consensusOV)
library(Biobase)

# Example using matrix and Entrez IDs
# expression_matrix: rows=genes, cols=samples
# entrez_ids: vector of Entrez IDs corresponding to rows
```

### 2. Subtyping with get.subtypes()
The `get.subtypes()` function is the primary wrapper. The `method` argument selects the classifier: `"consensusOV"`, `"Helland"`, `"Bentink"`, `"Verhaak"`, or `"Konecny"`.

```r
# Using an ExpressionSet
results <- get.subtypes(eset_object, method = "consensusOV")

# Using a matrix and Entrez IDs
results <- get.subtypes(expression_matrix, entrez_ids, method = "Bentink")
```

### 3. Interpreting Results
The output is a list containing two main elements:
1. **Subtype Labels**: A factor vector of the assigned subtypes (e.g., `results$consensusOV.subtypes`).
2. **Classifier Scores**: Method-specific values (e.g., `results$subtype.scores` or `results$gsva.out`).

| Method | Subtype Levels | Score Object |
| :--- | :--- | :--- |
| **consensusOV** | IMR, DIF, PRO, MES | `subtype.scores` (RF probabilities) |
| **Verhaak** | IMR, DIF, PRO, MES | `gsva.out` (ssGSEA scores) |
| **Helland** | C1, C2, C4, C5 | `subtype.scores` |
| **Konecny** | C1_immL, C2_diffL, C3_profL, C4_mescL | `spearman.cc.vals` |
| **Bentink** | Angiogenic, nonAngiogenic | `genefu` output |

### 4. Direct Function Calls
You can bypass the wrapper and call specific classifiers directly:
- `get.consensus.subtypes(data, entrez.ids)`
- `get.verhaak.subtypes(data, entrez.ids)`
- `get.helland.subtypes(data, entrez.ids)`
- `get.konecny.subtypes(data, entrez.ids)`
- `get.bentink.subtypes(data, entrez.ids)`

## Tips and Troubleshooting
- **Verhaak Alignment**: If using the Verhaak method with an `ExpressionSet`, ensure `rownames(eset)` are clean Entrez IDs.
- **Consensus Training**: The `consensusOV` method may trigger a "Loading training data" and "Training Random Forest" step upon first execution in a session.
- **Subtype Mapping**: Note that different methods use different nomenclature (e.g., Helland's C2 corresponds to Verhaak's IMR/Immunoreactive).

## Reference documentation
- [Molecular subtyping for ovarian cancer (Rmd)](./references/consensusOV.Rmd)
- [Molecular subtyping for ovarian cancer (Markdown)](./references/consensusOV.md)