---
name: bioconductor-gosemsim
description: GOSemSim calculates semantic similarity between Gene Ontology terms, gene products, and gene clusters. Use when user asks to calculate functional similarity between genes, compare GO terms using semantic algorithms, or measure the similarity between gene clusters across different species and ontologies.
homepage: https://bioconductor.org/packages/release/bioc/html/GOSemSim.html
---

# bioconductor-gosemsim

name: bioconductor-gosemsim
description: Semantic similarity analysis of Gene Ontology (GO) terms and gene products. Use when calculating functional similarity between genes, clusters of genes, or GO terms using various algorithms (Resnik, Wang, Lin, etc.) across different species and ontologies (BP, MF, CC).

## Overview
GOSemSim is an R package designed to estimate semantic similarity between Gene Ontology (GO) terms, sets of GO terms, gene products, and gene clusters. It supports multiple information content (IC)-based methods and a graph-based method (Wang). This is essential for functional analysis, gene clustering, and evaluating the functional consistency of gene sets.

## Core Workflow

1. **Prepare Semantic Data**: Use the `godata` function to pre-calculate information content for a specific organism and ontology. This step is required before running similarity functions.
2. **Calculate Similarity**: Use specific functions depending on the input type (GO IDs, Gene IDs, or Clusters).
3. **Interpret Results**: Scores typically range from 0 to 1, where higher values indicate higher functional similarity.

## Key Functions

### Data Preparation
```r
library(GOSemSim)
# Load OrgDb for the species (e.g., org.Hs.eg.db for human)
hsGO <- godata('org.Hs.eg.db', ont="BP", computeIC=TRUE)
```

### GO Term Similarity
- `goSim(ID1, ID2, semData, measure)`: Similarity between two GO terms.
- `mgoSim(IDs1, IDs2, semData, measure, combine)`: Similarity between two sets of GO terms.

### Gene Product Similarity
- `geneSim(gene1, gene2, semData, measure, combine)`: Similarity between two genes (using Entrez IDs).
- `mgeneSim(genes, semData, measure, combine)`: Similarity matrix for a list of genes.

### Cluster Similarity
- `clusterSim(cluster1, cluster2, semData, measure, combine)`: Similarity between two gene clusters.
- `mclusterSim(clusters, semData, measure, combine)`: Similarity matrix for multiple gene clusters.

## Parameters and Methods

### Supported Measures
- **IC-based**: "Resnik", "Lin", "Rel", "Jiang".
- **Graph-based**: "Wang" (default, often preferred for its robustness).

### Combination Strategies
When comparing genes (which may have multiple GO annotations), use the `combine` parameter:
- `"max"`: Maximum similarity.
- `"avg"`: Average similarity.
- `"rcmax"`: Row-column maximum.
- `"BMA"`: Best-Match Average (highly recommended for gene/cluster comparisons).

## Tips for Success
- **Species Support**: Ensure the correct `OrgDb` package is installed and loaded for your organism of interest.
- **Ontology Selection**: Choose between "BP" (Biological Process), "MF" (Molecular Function), or "CC" (Cellular Component). Comparisons across different ontologies are not supported.
- **Performance**: For large-scale comparisons, always pre-calculate the `semData` object using `godata()` to avoid redundant computations.
- **Input IDs**: Most functions expect Entrez Gene IDs. If using Gene Symbols or Ensembl IDs, convert them first using `clusterProfiler::bitr` or `AnnotationDbi::select`.

## Reference documentation
- [GOSemSim](./references/GOSemSim.md)