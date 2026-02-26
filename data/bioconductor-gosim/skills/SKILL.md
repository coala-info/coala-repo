---
name: bioconductor-gosim
description: This tool calculates functional similarities between Gene Ontology terms and gene products using various information-theoretic measures and diffusion kernels. Use when user asks to compute semantic similarities between GO terms, evaluate functional similarity between genes, perform GO enrichment analysis, or cluster genes based on biological functional distance.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GOSim.html
---


# bioconductor-gosim

name: bioconductor-gosim
description: Use this skill to calculate functional similarities between GO terms and gene products using the GOSim R package. It supports various information-theoretic measures (Resnik, Lin, Jiang-Conrath), diffusion kernels, and functional gene clustering based on Gene Ontology annotations. Use this skill when you need to perform GO enrichment analysis, compute pairwise term similarities, or evaluate gene clusters using biological functional distance.

## Overview
The `GOSim` package provides tools for computing semantic similarities between Gene Ontology (GO) terms and functional similarities between gene products. It implements several information-theoretic concepts and diffusion kernel techniques. It also integrates with `topGO` for enrichment analysis and provides methods for embedding genes into feature spaces for clustering and visualization.

## Core Workflows

### 1. Setup and Data Inspection
Load the library and inspect GO annotations for a set of Entrez gene IDs.
```R
library(GOSim)
genes <- c("207", "208", "596", "901", "780")
# Get GO info (defaults to Biological Process)
info <- getGOInfo(genes)
```

### 2. Computing GO Term Similarities
Calculate pairwise similarities between specific GO terms using different methods.
```R
terms <- c("GO:0007166", "GO:0007267", "GO:0007584")

# Resnik method (Information Content based)
sim_resnik <- getTermSim(terms, method = "Resnik")

# Lin or Jiang-Conrath (default)
sim_lin <- getTermSim(terms, method = "Lin")

# Relevance (Schlicker et al.)
sim_rel <- getTermSim(terms, method = "relevance")
```

### 3. Computing Functional Gene Similarities
Calculate how similar genes are based on their full set of GO annotations.
```R
# Optimal Assignment (OA) - recommended for functional grouping
sim_oa <- getGeneSim(genes, similarity = "OA", similarityTerm = "Lin")

# Maximum pairwise similarity
sim_max <- getGeneSim(genes, similarity = "max", similarityTerm = "Resnik")

# Hausdorff distance based similarity
sim_haus <- getGeneSim(genes, similarity = "hausdorff")
```

### 4. Feature Space Embedding and Clustering
Transform genes into a feature space for PCA or clustering.
```R
# Select prototype genes for basis
proto <- selectPrototypes(n = 250)

# Get feature vectors via prototypes
PHI <- getGeneFeaturesPrototypes(genes, prototypes = proto)

# Calculate similarity matrix for clustering
sim_matrix <- getGeneSimPrototypes(genes, prototypes = proto, similarityTerm = "Resnik")
dist_matrix <- as.dist(1 - sim_matrix$similarity)
hc <- hclust(dist_matrix, "average")
plot(hc)
```

### 5. GO Enrichment Analysis
Perform enrichment analysis on a subset of genes using `topGO` integration.
```R
# Requires a background list of all genes
all_genes <- keys(org.Hs.eg.db) 
target_genes <- c("8614", "9518", "780", "2852")

enrichment <- GOenrichment(target_genes, all_genes)
# Access results
enrichment$GOTerms
enrichment$p.values
```

## Key Parameters and Methods
- **Ontology Selection**: By default, GOSim uses "BP" (Biological Process). Use `setOntology("MF")` or `setOntology("CC")` to switch.
- **Information Content (IC)**: IC data is precomputed for human. Load via `data("ICsBPhumanall")`. For other organisms, use `calcICs`.
- **Similarity Methods**: 
    - `Resnik`, `Lin`, `JiangConrath`: Standard IC-based measures.
    - `CoutoResnik`, `CoutoLin`: Extensions using disjunctive common ancestors.
    - `relevance`: Schlicker's adaptation of Lin's measure.
- **Gene Similarity Types**: `OA` (Optimal Assignment), `max` (Maximum), `avg` (Average), `funSimMax` (Average of best matching), `hausdorff`.

## Tips for Success
- **Gene IDs**: Ensure you are using Entrez Gene IDs (character strings) as primary identifiers.
- **Evidence Levels**: You can filter GO terms by evidence codes using `setEvidenceLevel`.
- **Normalization**: Gene similarities can be normalized using `cosine`, `Tanimoto`, or `Lin` logic within the `getGeneSim` functions.
- **Memory**: For large gene sets, calculating the full similarity matrix is computationally expensive ($O(N^2)$). Consider using prototype-based embedding for high-throughput data.

## Reference documentation
- [GOSim](./references/GOSim.md)