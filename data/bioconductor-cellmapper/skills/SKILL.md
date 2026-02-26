---
name: bioconductor-cellmapper
description: This tool infers cell type-specific gene expression from heterogeneous microarray data by identifying genes co-expressed with known cell-type markers. Use when user asks to identify genes sharing expression profiles with specific markers, find candidate genes for rare cell types, or perform cell type-specific meta-analyses across large datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/CellMapper.html
---


# bioconductor-cellmapper

name: bioconductor-cellmapper
description: Infer cell type-specific gene expression from heterogeneous microarray data using the CellMapper R package. Use this skill to identify genes co-expressed with known cell-type markers (query genes) across large datasets, including brain-specific (Allen Brain Atlas) and multi-organ meta-analyses.

## Overview

CellMapper identifies genes that share an expression profile with a set of established cell type-specific markers ("query genes"). It is particularly effective for identifying expression in rare or difficult-to-isolate cell types, even when the cell type has not been purified. The workflow typically involves selecting a large gene expression dataset (often from the `CellMapperData` package), defining query genes (usually Entrez IDs), and running the search to obtain a ranked list of candidate genes with associated False Discovery Rates (FDR).

## Core Workflow

### 1. Installation and Setup

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install(c("CellMapper", "CellMapperData", "ExperimentHub"))

library(CellMapper)
library(ExperimentHub)
```

### 2. Accessing Reference Data

Use `ExperimentHub` to retrieve pre-processed datasets from `CellMapperData`.

```r
hub <- ExperimentHub()
# Search for available datasets
x <- query(hub, "CellMapperData")

# Common datasets:
# EH170: Allen Brain Atlas (Human Brain)
# EH171: Engreitz (Human Meta-analysis)
# EH172: Lukk (Human Meta-analysis)
# EH173: Zheng-Bradley (Mouse Meta-analysis, Human Entrez IDs)

BrainAtlas <- hub[["EH170"]]
```

### 3. Running a Search (CMsearch)

The `CMsearch` function is the primary tool for analysis. It requires a pre-processed dataset and one or more query genes.

```r
# Define query gene (e.g., GAD1 for GABAergic neurons, Entrez ID 2571)
query_genes <- "2571"

# Run search on a single dataset
results <- CMsearch(BrainAtlas, query.genes = query_genes)

# Run search across multiple datasets (pooled analysis)
meta_results <- CMsearch(list(hub[["EH171"]], hub[["EH172"]]), query.genes = query_genes)

# View top candidates
head(results)
```

### 4. Using Custom Data (CMprep)

If using your own data, it must be pre-processed. `CMprep` accepts a matrix (genes as rows, samples as columns) or an `ExpressionSet`.

```r
# Pre-process custom data (can be slow for >1000 samples)
prepped_data <- CMprep(my_expression_matrix)

# Run search using identifiers matching the input matrix
custom_results <- CMsearch(prepped_data, query.genes = "my_marker_id")
```

## Advanced Workflows

### Restricting Search to Specific Tissues

If a marker is only specific within a certain organ, subset the data before pre-processing.

```r
# Example: Subset Lukk dataset for intestinal samples
dataset <- hub[["EH177"]]
pDat <- pData(dataset)
sample_idx <- which(pDat$OrganismPart %in% c("colon", "Small intestine"))
subset_exprs <- exprs(dataset)[, sample_idx]

# Prep and search the subset
prepped_subset <- CMprep(subset_exprs)
results <- CMsearch(prepped_subset, query.genes = "1113") # CHGA
```

## Tips for Success

*   **Query Gene Selection:** Use highly specific markers. A single high-quality marker is often better than multiple markers of varying quality.
*   **Sample Size:** CellMapper performs best with large datasets (n > 500).
*   **Identifiers:** Ensure query genes use the same ID type as the dataset (usually Entrez IDs for `CellMapperData`).
*   **Parameters:** The default `alpha = 0.5` and `query.driven = TRUE` are suitable for most applications.

## Reference documentation

- [CellMapper](./references/CellMapper.md)