---
name: bioconductor-chronos
description: CHRONOS is an R package that analyzes time-series transcriptomic data to identify and score dynamic linear sub-pathways integrated with miRNA regulation. Use when user asks to analyze time-varying biological mechanisms, extract sub-pathways from KEGG maps, or integrate miRNA-mRNA interactions into pathway analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/CHRONOS.html
---


# bioconductor-chronos

## Overview

CHRONOS (time-vaRying enriCHment integrOmics Subpathway aNalysis tOol) is an R package designed to analyze time-series transcriptomic data. It identifies linear sub-pathways from KEGG pathway maps and integrates miRNA regulation to provide a time-varying view of perturbed biological mechanisms. It is particularly effective for microarray experiments where researchers need to move beyond static pathway analysis to understand dynamic regulatory changes.

## Package Setup

Before execution, CHRONOS requires a cache directory to store downloaded KEGG data and interactions.

```r
library(CHRONOS)

# Set cache directory based on OS
if (.Platform$OS.type == 'unix') {
  options('CHRONOS_CACHE' = file.path(path.expand("~"), '.CHRONOS'))
} else if (.Platform$OS.type == 'windows') {
  options('CHRONOS_CACHE' = file.path(gsub("\\\\", "/", Sys.getenv("USERPROFILE")), "AppData/.CHRONOS"))
}
```

## Data Preparation

CHRONOS requires mRNA and (optionally) miRNA expression matrices.
- **Dimensions**: (N, E) where N is the number of genes/miRNAs and E is the number of time points.
- **Format**: Data should be normalized and represented as log2-fold changes relative to a control/initial state.
- **Replicates**: Multiple biological replicates must be summarized into a single value per time point.

```r
# Example of loading internal data
load(system.file('extdata', 'Examples//data.RData', package='CHRONOS'))

# mRNAexpr should have Entrez IDs as row names and time points as columns
head(mRNAexpr)
```

## Workflow Execution

The primary interface is the `CHRONOSrun` function, which automates the pipeline from KEGG downloading to sub-pathway scoring.

### Default Run Parameters
- `mRNAexp`: Matrix of mRNA expression.
- `mRNAlabel`: Type of gene identifier (e.g., 'entrezgene').
- `miRNAexp`: Matrix of miRNA expression (optional).
- `pathType`: Vector of KEGG pathway IDs to analyze.
- `org`: Organism code (e.g., 'hsa' for Homo sapiens).
- `subType`: Type of sub-pathways to extract ('Metabolic', 'Non-Metabolic', or 'All').
- `thresholds`: Scoring cutoffs for sub-pathways and miRNA interactions.

```r
out <- CHRONOSrun(
  mRNAexp = mRNAexpr,
  mRNAlabel = 'entrezgene',
  miRNAexp = miRNAexpr,
  pathType = c('04915', '04917', '04930', '05031'),
  org = 'hsa',
  subType = 'All',
  thresholds = c('subScore' = 0.4, 'mirScore' = 0.4),
  miRNAinteractions = miRNAinteractions,
  export = '.txt'
)
```

## Key Functions

- `CHRONOSrun()`: The master function for the entire pipeline.
- `importData()`: Used internally or manually to format expression matrices.
- `pathwayDownload()`: Fetches KGML files from KEGG.
- `subpathwayExtraction()`: Processes pathway graphs into linear sub-components.
- `scoreSubpathways()`: Evaluates the significance of extracted paths based on expression changes over time.

## Tips for Success

1. **Identifier Consistency**: Ensure mRNA row names match the `mRNAlabel` parameter (usually Entrez Gene IDs).
2. **miRNA Availability**: If miRNA data is unavailable, CHRONOS can still run and extract sub-pathways based solely on mRNA dynamics.
3. **KEGG Access**: The package requires an active internet connection during the initial run to download pathway maps for the specified organism.
4. **Memory Management**: For large-scale analyses involving many pathways, ensure the `CHRONOS_CACHE` has sufficient disk space.

## Reference documentation

- [CHRONOS](./references/CHRONOS.md)