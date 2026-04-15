---
name: bioconductor-dexmadata
description: This package provides essential data objects, gene ID mapping tables, and example datasets for performing gene expression meta-analysis with the DExMA package. Use when user asks to convert gene identifiers between Entrez, Ensembl, and Symbol formats, access supported organism lists, or load synthetic datasets for testing meta-analysis workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DExMAdata.html
---

# bioconductor-dexmadata

name: bioconductor-dexmadata
description: Provides essential data objects and example datasets for the DExMA (Differential Expression Meta-Analysis) package. Use this skill when performing gene expression meta-analysis, converting gene IDs (Entrez, Ensembl, Symbol), or testing DExMA workflows with synthetic data.

# bioconductor-dexmadata

## Overview
`DExMAdata` is a data-only Bioconductor package designed to support the `DExMA` package. It contains the necessary mapping tables for gene ID conversion across different organisms and synthetic datasets for practicing meta-analysis workflows.

## Loading Data
To use the datasets, load the library and use the `data()` function:

```r
library(DExMAdata)

# Load ID mapping and synonym objects
data(IDsDExMA)
data(SynonymsDExMA)

# Load metadata about supported IDs and organisms
data(avaliableIDs)
data(avaliableOrganism)

# Load example datasets for DExMA workflows
data(DExMAExampleData)
```

## Gene ID Mapping Resources
These objects are primarily used by the `allSameID()` function in the `DExMA` package to standardize gene identifiers across different studies.

*   **IDsDExMA**: A dataframe containing equivalences between `GeneSymbol`, `Entrez`, and `Ensembl` IDs, categorized by `Organism`.
*   **SynonymsDExMA**: A dataframe mapping gene aliases/synonyms to their Official Gene Symbol for various organisms.
*   **avaliableIDs**: A character vector of supported ID types (e.g., "Entrez", "Ensembl", "GeneSymbol").
*   **avaliableOrganism**: A character vector of supported organisms (e.g., "Homo sapiens", "Mus musculus", "Rattus norvegicus", etc.).

## Example Datasets
The `DExMAExampleData` command loads several objects into the environment for testing:

*   **listMatrixEX**: A list of four expression matrices (synthetic data).
*   **listPhenodatas**: A list of four phenotype dataframes corresponding to the matrices.
*   **listExpressionSets**: The same data provided as a list of `ExpressionSet` objects.
*   **maObjectDif**: A meta-analysis object (`ObjectMA`) containing studies with different ID types.
*   **maObject**: A meta-analysis object where all studies have been standardized to Official Gene Symbols.

## Typical Workflow Integration
When using the main `DExMA` package, you will often reference these data objects to ensure your input data matches the expected formats:

```r
# Check if your organism is supported
data(avaliableOrganism)
"Homo sapiens" %in% avaliableOrganism

# Check supported ID types
data(avaliableIDs)
print(avaliableIDs)

# Use the example maObject to test DExMA meta-analysis functions
# (Requires DExMA package)
# library(DExMA)
# results <- metaAnalysis(maObject)
```

## Reference documentation
- [DExMAdata](./references/DExMAdata.md)