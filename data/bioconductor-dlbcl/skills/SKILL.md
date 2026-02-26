---
name: bioconductor-dlbcl
description: This package provides diffuse large B-cell lymphoma expression data and a human protein-protein interaction network for biological network analysis. Use when user asks to access example lymphoma datasets, load the HPRD interactome, or provide sample data for the BioNet package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DLBCL.html
---


# bioconductor-dlbcl

name: bioconductor-dlbcl
description: Provides access to diffuse large B-cell lymphoma (DLBCL) expression data and protein-protein interaction networks. Use this skill when a user needs example datasets for biological network analysis, specifically for the BioNet package, or requires the HPRD interactome and lymphoma microarray data for benchmarking and functional module identification.

## Overview
The `DLBCL` package is a Bioconductor experiment data package. It serves as a companion to the `BioNet` package, providing the necessary data structures to demonstrate functional analysis of biological networks. It includes gene expression profiles from DLBCL patients, associated survival p-values, and a human protein-protein interaction (PPI) network.

## Data Loading and Usage
The package contains three primary datasets that can be loaded using the `data()` function.

### 1. Expression Data (exprLym)
This is an `ExpressionSet` object containing microarray data from diffuse large B-cell lymphoma samples.
```r
library(DLBCL)
data(exprLym)

# View expression matrix
exprs(exprLym)[1:10, ]

# View phenoData
pData(exprLym)
```

### 2. Supplemental Data (dataLym)
This dataset contains additional statistical information related to the genes in the expression set, such as p-values for differential expression and survival analysis.
```r
data(dataLym)

# Inspect the structure (contains p-values and scores)
str(dataLym)

# Access specific components (e.g., p-values)
dataLym$p.values
```

### 3. Interactome (interactome)
A `graph` object representing the human protein-protein interaction network extracted from the Human Protein Reference Database (HPRD) release 6.
```r
data(interactome)

# View graph summary
interactome

# Check nodes and edges
nodes(interactome)[1:10]
edgeCount(interactome)
```

## Typical Workflow: BioNet Integration
The primary use case for this package is to provide inputs for the `BioNet` workflow:
1. **Map Scores**: Use `dataLym` p-values to calculate scores for nodes.
2. **Integrate with Network**: Map these scores onto the `interactome` graph.
3. **Module Identification**: Use `BioNet` functions to find high-scoring subnetworks (functional modules) within the interactome based on the DLBCL expression data.

## Tips
- Ensure `Biobase` and `graph` packages are installed, as `DLBCL` depends on them for its data structures.
- The `interactome` object is a `graphNEL` object; use the `graph` package to manipulate or visualize it.
- This package is for demonstration and methodology testing; for the most recent DLBCL studies, consider searching for newer GEO or TCGA datasets.

## Reference documentation
- [DLBCL Reference Manual](./references/reference_manual.md)