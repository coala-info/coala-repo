---
name: bioconductor-mlp
description: The bioconductor-mlp package implements the Mean Log P-value methodology to perform gene set enrichment analysis using a permutation-based approach. Use when user asks to perform gene set enrichment analysis, calculate pathway significance from p-values, or visualize enriched gene sets using bar plots and GO graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/MLP.html
---


# bioconductor-mlp

## Overview

The `MLP` package implements the Mean Log P-value methodology for gene set enrichment analysis. Unlike methods that require a hard threshold for "differentially expressed" genes, MLP calculates a test statistic based on the mean of the $-\log_{10}(p\text{-values})$ of all genes within a set. It uses a resampling/permutation scheme to determine the significance of these gene sets, making it robust for finding affected pathways even when individual gene changes are subtle.

## Workflow and Core Functions

### 1. Prepare Input Data
The starting point is a named numeric vector of p-values (or similar statistics) where the names are **Entrez Gene identifiers**.

```R
# Example: p-values from a limma analysis
# Ensure names are Entrez IDs (e.g., "18975")
pvalues <- results[,"P.Value"]
names(pvalues) <- results[,"EntrezID"]
```

### 2. Define Gene Sets
Use `getGeneSets` to create a `geneSetMLP` object. This maps your genes to known pathways or ontologies.

```R
geneSet <- getGeneSets(
  species = "Mouse",             # 'Human', 'Mouse', 'Rat', 'Dog', 'Rhesus'
  geneSetSource = "GOBP",        # 'GOBP', 'GOMF', 'GOCC', 'KEGG', 'REACTOME'
  entrezIdentifiers = names(pvalues)
)
```

### 3. Run MLP Analysis
The `MLP` function performs the enrichment test. Setting a seed is recommended for reproducibility due to the permutation step.

```R
set.seed(111)
mlpOut <- MLP(
  geneSet = geneSet,
  geneStatistic = pvalues,
  minGenes = 5,                  # Minimum genes in a set to be tested
  maxGenes = 100,                # Maximum genes in a set to be tested
  nPermutations = 100,           # Number of permutations for significance
  smoothPValues = TRUE
)
```

### 4. Visualize Results
The package provides three primary visualization types via the `plot` method:

*   **Quantile Curves**: Shows the relationship between gene set size and the statistic.
    ```R
    plot(mlpOut, type = "quantileCurves")
    ```
*   **Bar Plot**: Displays the most significant gene sets.
    ```R
    plot(mlpOut, type = "barplot", nRow = 20)
    ```
*   **GO Graph**: Visualizes the parent-child relationships of significant GO terms (only for GO sources).
    ```R
    plot(mlpOut, type = "GOgraph", nRow = 10)
    ```

### 5. Inspect Individual Gene Contributions
To see which specific genes are driving a gene set's significance:

```R
plotGeneSetSignificance(
  geneSet = geneSet,
  geneSetIdentifier = "GO:0005602",
  geneStatistic = pvalues,
  annotationPackage = "mouse4302.db" # Annotation package for symbols
)
```

## Tips for Success
*   **Entrez IDs**: The package is strictly designed for Entrez Gene identifiers. Ensure your p-value vector names and the `entrezIdentifiers` argument in `getGeneSets` match this format.
*   **Uniform Distribution**: The MLP procedure assumes that under the null hypothesis, the gene statistics (p-values) follow a uniform distribution between 0 and 1.
*   **Custom Gene Sets**: You can provide a custom `data.frame` to `geneSetSource` with columns `PATHWAYID`, `PATHWAYNAME`, `TAXID`, and `GENEID` if you are not using standard GO/KEGG/REACTOME sets.

## Reference documentation
- [Using MLP](./references/UsingMLP.md)