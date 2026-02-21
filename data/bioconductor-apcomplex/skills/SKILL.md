---
name: bioconductor-apcomplex
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/apComplex.html
---

# bioconductor-apcomplex

name: bioconductor-apcomplex
description: Protein complex membership estimation using affinity-purification/mass-spectrometry (AP-MS) data. Use this skill when analyzing AP-MS data to identify protein complexes, handle false positives/negatives in bait-hit matrices, and generate bipartite protein-complex membership graphs (PCMG).

## Overview

The `apComplex` package provides a statistical framework to estimate protein complex membership from AP-MS data. It treats AP-MS data as a directed graph where baits point to hits. The algorithm identifies "BH-complete subgraphs" (maximal cliques adapted for bait/hit status) and uses a likelihood-based objective function to merge these initial estimates, accounting for technological sensitivity and specificity.

## Core Workflow

### 1. Data Preparation
Input data should be an adjacency matrix where rows are baits and columns are hits. An entry of 1 indicates a detected interaction; 0 indicates no interaction.

```R
library(apComplex)
data(apEX) # Example dataset
# Rows = Baits, Cols = Hits
# Diagonal should be 1 (protein is comember with itself)
```

### 2. Estimating Complexes
There are two ways to run the estimation: a two-step manual process or a single wrapper function.

**Single-step approach:**
Use `findComplexes` to perform both initial subgraph detection and complex merging.
```R
# sensitivity and specificity typically range from 0.5 to 0.9
res <- findComplexes(apEX, sensitivity = 0.7, specificity = 0.75)
```

**Two-step approach:**
1. **Find initial subgraphs**: `bhmaxSubgraph` identifies maximal BH-complete subgraphs (no missing edges allowed initially).
2. **Merge complexes**: `mergeComplexes` joins subgraphs if it increases the objective function (allows for missing edges based on sensitivity).

```R
PCMG0 <- bhmaxSubgraph(apEX)
PCMG1 <- mergeComplexes(PCMG0, apEX, sensitivity = 0.7, specificity = 0.75)
```

### 3. Interpreting Results
The output is a list of complexes. Use `sortComplexes` to categorize them by reliability:

*   **MBME (Multi-bait-multi-edge)**: Most reliable; contains multiple baits and multiple edges.
*   **SBMH (Single-bait-multi-hit)**: One bait and several hit-only proteins; useful for proposing new bait experiments.
*   **UnRBB (Unreciprocated bait-bait)**: Two baits connected by one edge; often represents false positives or single false negatives.

```R
sorted <- sortComplexes(res, adjMat = apEX)
# Access MBME complexes
sorted$MBME
```

## Advanced Features

### Incorporating External Data
You can weight the complex estimation using external similarity data (e.g., gene expression correlation or functional similarity).
```R
# simMat: matrix of similarity scores
# Beta: weight parameter for the similarity measure
res_sim <- findComplexes(apEX, sensitivity = 0.7, specificity = 0.75, 
                         simMat = mySimMat, Beta = 0.5)
```

### Public Datasets
The package includes processed AP-MS data from landmark studies:
*   `data(TAP)` / `data(TAPgraph)`: Gavin et al. (2002) dataset.
*   `data(HMSPCI)` / `data(HMSPCIgraph)`: Ho et al. (2002) dataset.
*   `data(MBMEcTAP)`: Pre-calculated MBME complexes for the TAP data.

## Reference documentation

- [Protein complex membership estimation using apComplex](./references/apComplex.md)