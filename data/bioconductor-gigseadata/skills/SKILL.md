---
name: bioconductor-gigseadata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GIGSEAdata.html
---

# bioconductor-gigseadata

## Overview

The `GIGSEAdata` package provides a collection of gene sets specifically curated for use with the `GIGSEA` (Genotype Imputed Gene Set Enrichment Analysis) method. Unlike standard gene set lists, these are stored as sparse matrices (using the `Matrix` package) to accommodate both discrete-valued (0/1) and continuous-valued (weighted) gene sets. This format is optimized for the weighted linear regression models used in GWAS-and-eQTL-imputed enrichment analysis.

## Data Collections

The package primarily adds two major categories of gene sets to the existing collections found in the core GIGSEA package:

1.  **org.Hs.eg.GO**: Discrete-valued gene sets (0 or 1) based on Gene Ontology terms. It includes parent terms and their offspring.
2.  **Fantom5.TF**: Continuous-valued gene sets based on human transcript promoter locations and MotEvo predicted TF target sites (500 PWMs across ~22,000 genes).

## Loading and Inspecting Data

To use the data, load the library and use the standard `data()` function. The datasets are typically structured as lists containing a sparse matrix (`net`) and metadata (`annot`).

```R
library(GIGSEAdata)

# Load Gene Ontology data
data(org.Hs.eg.GO)

# Inspect the structure
# 'net' is a sparse matrix (dgCMatrix) where rows are genes and columns are GO terms
dim(org.Hs.eg.GO$net)
head(rownames(org.Hs.eg.GO$net)) # Gene symbols
head(colnames(org.Hs.eg.GO$net)) # GO IDs

# 'annot' contains metadata for the columns
head(org.Hs.eg.GO$annot) # Columns: goid, ontology, term, totalGenes
```

## Usage in GIGSEA Workflows

These datasets are designed to be passed directly into the enrichment functions of the `GIGSEA` package.

*   **Discrete Sets**: Use `org.Hs.eg.GO` for standard enrichment where a gene is either in or out of a set.
*   **Continuous Sets**: Use `Fantom5.TF` when you want to account for the strength of a transcription factor's predicted binding site (PWM scores) rather than a binary classification.

## Tips

*   **Sparse Matrix Handling**: Because the matrices are `dgCMatrix` objects, use the `Matrix` package if you need to perform manual subsetting or arithmetic to maintain memory efficiency.
*   **Gene Identifiers**: The rows in these matrices use Gene Symbols (e.g., "A1BG"). Ensure your differential expression or GWAS-imputed data uses matching identifiers before running enrichment.
*   **Memory Efficiency**: These datasets are large; loading them only when needed for the enrichment step is recommended.

## Reference documentation

- [GIGSEAdata Tutorial](./references/GIGSEAdata_tutorial.md)