---
name: bioconductor-topgo
description: This tool performs Gene Ontology enrichment analysis while accounting for the hierarchical structure of the GO graph. Use when user asks to analyze gene sets for overrepresented biological processes, perform GO enrichment using the elim or weight01 algorithms, or visualize significant GO terms within their graph topology.
homepage: https://bioconductor.org/packages/release/bioc/html/topGO.html
---


# bioconductor-topgo

name: bioconductor-topgo
description: Perform Gene Ontology (GO) enrichment analysis using the topGO Bioconductor package. Use this skill when you need to analyze gene sets for overrepresented biological processes, molecular functions, or cellular components, especially when accounting for the GO graph topology using algorithms like 'elim' or 'weight01'.

## Overview

The `topGO` package provides a framework for GO enrichment analysis that accounts for the hierarchical structure of the Gene Ontology. Unlike standard enrichment tests that treat GO terms as independent, `topGO` offers algorithms (like `elim` and `weight`) that decorrelate the GO graph to reduce redundancy and identify more specific biological drivers.

## Typical Workflow

### 1. Data Preparation
You must define three components:
- **Gene Universe**: A named vector (numeric or factor) of all genes in the study.
- **Interesting Genes**: A selection function or a logical vector identifying significant genes.
- **Annotations**: Mapping between genes and GO terms.

```r
library(topGO)

# Example: Using p-values to define interesting genes
# geneList is a named numeric vector of p-values
topDiffGenes <- function(allScore) {
  return(allScore < 0.01)
}

# Create the topGOdata object
sampleGOdata <- new("topGOdata",
                    description = "My Analysis",
                    ontology = "BP", # BP, MF, or CC
                    allGenes = geneList,
                    geneSel = topDiffGenes,
                    nodeSize = 10, # Prune terms with < 10 genes
                    annot = annFUN.db,
                    affyLib = "hgu95av2.db")
```

### 2. Running Enrichment Tests
Use `runTest` to apply different algorithms and statistics.

| Algorithm | Description |
|-----------|-------------|
| `classic` | Standard enrichment (terms treated independently). |
| `elim` | Iteratively removes genes mapped to significant child terms from parent terms. |
| `weight01` | Default. A mixture of `elim` and `weight` algorithms. |
| `parentchild` | Considers the inheritance of annotations. |

```r
# Fisher's exact test with classic algorithm
resultFisher <- runTest(sampleGOdata, algorithm = "classic", statistic = "fisher")

# Kolmogorov-Smirnov test with elim algorithm (requires gene scores)
resultKS.elim <- runTest(sampleGOdata, algorithm = "elim", statistic = "ks")
```

### 3. Analyzing and Visualizing Results
Use `GenTable` to compare results and `showSigOfNodes` to visualize the GO hierarchy.

```r
# Generate a summary table
allRes <- GenTable(sampleGOdata, 
                   classicFisher = resultFisher,
                   elimKS = resultKS.elim,
                   orderBy = "elimKS", 
                   ranksOf = "classicFisher", 
                   topNodes = 10)

# Visualize the GO graph for the top 5 terms
showSigOfNodes(sampleGOdata, score(resultKS.elim), firstSigNodes = 5, useInfo = 'all')

# List genes annotated to a specific GO term
genesInTerm(sampleGOdata, "GO:0006629")
```

## Key Functions

- `new("topGOdata", ...)`: Constructor for the main data container.
- `annFUN.db`, `annFUN.org`, `annFUN.gene2GO`: Annotation functions for different data sources.
- `runTest()`: Executes the enrichment analysis.
- `GenTable()`: Formats results from multiple tests into a single data frame.
- `score()`: Extracts p-values/scores from a result object.
- `printGraph()` / `showSigOfNodes()`: Visualizes the induced GO subgraph.

## Tips for Success
- **Ontology Selection**: You must run BP (Biological Process), MF (Molecular Function), and CC (Cellular Component) separately by creating different `topGOdata` objects.
- **Node Size**: Use `nodeSize = 5` or `10` to prune very small GO terms that often produce unstable p-values.
- **Multiple Testing**: `topGO` returns raw p-values. While standard FDR corrections (like Benjamini-Hochberg) can be applied, they may be overly conservative for `elim` and `weight` algorithms because the tests are not independent.
- **Custom Annotations**: If not using a Bioconductor `.db` package, use `readMappings()` to load a gene-to-GO map file.

## Reference documentation
- [topGO User's Guide](./references/topGO_manual.md)