---
name: bioconductor-phenogeneranker
description: PhenoGeneRanker implements a Random Walk with Restart algorithm on multi-layer heterogeneous networks to prioritize genes and phenotypes. Use when user asks to rank genes or phenotypes, integrate multiplex biological networks, or calculate empirical p-values for node rankings using random stratified sampling.
homepage: https://bioconductor.org/packages/release/bioc/html/PhenoGeneRanker.html
---


# bioconductor-phenogeneranker

## Overview

PhenoGeneRanker implements a Random Walk with Restart (RWR) algorithm specifically designed for multi-layer (multiplex) heterogeneous networks. It allows researchers to prioritize genes or phenotypes by integrating various data sources (e.g., protein-protein interactions, co-expression, disease similarities) into a unified network model. A key feature is its ability to calculate empirical p-values through random stratified sampling, accounting for node connectivity degrees to ensure ranking significance.

## Workflow

### 1. Data Preparation
The package requires an input configuration file (tab-separated) that defines the network layers.

**Input Configuration File (`input_file.txt`):**
| type | file_name |
| :--- | :--- |
| gene | gene_layer1.txt |
| phenotype | ptype_layer1.txt |
| bipartite | gene_ptype.txt |

**Network Layer Files:**
Each file listed in the configuration must have three tab-separated columns: `from`, `to`, and `weight`.
- **Gene/Phenotype layers:** Internal relationships (e.g., g1 to g2).
- **Bipartite layers:** Relationships between genes and phenotypes (from = gene, to = phenotype).

### 2. Generating the Walk Matrix
The `CreateWalkMatrix` function processes the configuration and builds the transition matrix.

```r
library(PhenoGeneRanker)

# Generate the matrix
# delta: jump prob between gene layers (default 0.5)
# zeta: jump prob between phenotype layers (default 0.5)
# lambda: inter-network jump prob (default 0.5)
walkMatrix <- CreateWalkMatrix('input_file.txt', numCores = 1)

# Access metadata
n_genes <- walkMatrix[["N"]]
n_phenotypes <- walkMatrix[["M"]]
```

### 3. Running the Random Walk
Use `RandomWalkRestart` to prioritize nodes based on "seed" sets.

```r
# Define seeds
gene_seeds <- c("g1", "g5")
pheno_seeds <- c("p1")

# Run RWR with P-value generation
# S: number of random runs for p-value calculation (default 1000)
# r: restart probability (default 0.7)
# eta: restart weight (higher = favor phenotype seeds, default 0.5)
results <- RandomWalkRestart(
  walkMatrix, 
  geneSeeds = gene_seeds, 
  phenoSeeds = pheno_seeds, 
  generatePValue = TRUE, 
  S = 100, 
  numCores = parallel::detectCores()
)

# View top ranked genes
head(results)
```

### 4. Customizing Layer Weights
If certain network layers are more reliable, use `tau` (gene layers) and `phi` (phenotype layers) to weight them. The length of the vector must match the number of layers defined in the input file.

```r
# Example: Weighting the second gene layer 3x more than the first
ranks <- RandomWalkRestart(
  walkMatrix, 
  geneSeeds = c('g1'), 
  phenoSeeds = c(), 
  tau = c(0.5, 1.5), # Sum should equal number of gene layers
  phi = c(1.0, 1.0)
)
```

## Tips for Success
- **P-Value Performance:** Calculating empirical p-values is computationally intensive. Always use `numCores` to parallelize the process when `generatePValue = TRUE`.
- **Seed Selection:** Seeds should be known entities related to the biological question (e.g., known disease genes).
- **Unweighted Networks:** If your network is unweighted, set the `weight` column to `1` in your data files.
- **Bipartite Direction:** In bipartite files, the `from` column **must** be gene IDs and the `to` column **must** be phenotype IDs.

## Reference documentation
- [PhenoGeneRanker](./references/PhenoGeneRanker.md)