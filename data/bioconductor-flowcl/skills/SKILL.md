---
name: bioconductor-flowcl
description: bioconductor-flowcl performs semantic labeling of flow cytometric cell populations by matching marker phenotypes to the Cell Ontology. Use when user asks to identify cell type labels from surface markers, automate the annotation of cell populations, or visualize the relationship between markers and cell types in an ontology tree.
homepage: https://bioconductor.org/packages/3.16/bioc/html/flowCL.html
---


# bioconductor-flowcl

name: bioconductor-flowcl
description: Semantic labelling of flow cytometric cell populations using the Cell Ontology (CL). Use this skill when you need to identify the most appropriate Cell Ontology terms for a set of cell surface markers (phenotypes) or when you need to visualize the relationship between markers and cell types in a hierarchical tree structure.

# bioconductor-flowcl

## Overview

The `flowCL` package provides a programmatic interface to the Cell Ontology (CL) for flow cytometry data. It automates the process of matching a list of cell markers (e.g., CD3+, CD4+, CD8-) to the most specific and accurate cell type labels defined in the ontology. This ensures standardized nomenclature and helps in the automated annotation of cell populations identified through gating or clustering.

## Core Workflow

### 1. Installation and Loading
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("flowCL")
library(flowCL)
```

### 2. Semantic Labelling
The primary function is `flowCL()`. It takes a vector of phenotypes and returns the best matching cell types.

```R
# Define phenotypes using marker names followed by + or -
# Example: CD3+ CD4+ CD8-
results <- flowCL(markerlist = c("CD3+ CD4+ CD8-", "CD19+"))
```

### 3. Analyzing Results
The output of `flowCL` is a list containing:
- `Table`: A summary table with the best matches, scores, and ontology IDs.
- `Tree`: A visual representation (if `visualize = TRUE`) of the ontology hierarchy.

```R
# View the top hits
print(results$Table)

# Access specific information for the first phenotype
results[[1]]$Table
```

## Key Functions and Parameters

- `flowCL(markerlist, listout = FALSE, verbose = FALSE, visualize = FALSE)`
    - `markerlist`: A character vector of phenotypes (e.g., `"CD3+CD4-"`).
    - `listout`: If `TRUE`, returns a list of all possible matches; if `FALSE`, returns only the best match.
    - `visualize`: If `TRUE`, generates a PDF showing the position of the cell type within the Cell Ontology tree.
- `test_flowCL()`: Runs a pre-defined test case to ensure the package and its connection to the ontology data are working correctly.

## Tips for Success

- **Marker Formatting**: Ensure there are no spaces between the marker name and the +/- sign (e.g., use `CD3+` not `CD3 +`). Multiple markers for a single population should be separated by a space within the string (e.g., `"CD3+ CD4+"`).
- **Marker Synonyms**: `flowCL` handles many common synonyms for markers, but using official CD nomenclature (Cluster of Differentiation) generally yields the most reliable results.
- **Scoring**: The package uses a scoring system based on the number of matching markers and the depth in the ontology. A higher score indicates a more specific match.
- **Internet Connection**: `flowCL` requires access to the ontology data. Ensure the R environment has appropriate network access if the data is being pulled from remote repositories.

## Reference documentation

- [flowCL](./references/flowCL.md)