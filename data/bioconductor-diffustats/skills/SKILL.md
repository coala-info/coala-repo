---
name: bioconductor-diffustats
description: This tool computes and compares diffusion-based scores on biological networks to propagate labels from seed nodes to their neighbors. Use when user asks to prioritize genes, predict functional annotations, smooth molecular data over protein-protein interaction networks, or benchmark different network diffusion algorithms.
homepage: https://bioconductor.org/packages/release/bioc/html/diffuStats.html
---

# bioconductor-diffustats

name: bioconductor-diffustats
description: Use the diffuStats R package to compute and compare diffusion-based scores on biological networks. This skill is applicable for label propagation tasks, gene prioritization, functional annotation prediction, and benchmarking different network diffusion algorithms (raw, normalized, or parametric). Use this skill when you need to smooth molecular data (like gene expression or GWAS hits) over a protein-protein interaction (PPI) or other biological network to identify relevant modules or prioritize candidates.

# bioconductor-diffustats

## Overview

The `diffuStats` package implements a variety of diffusion-based scoring methods for network analysis. It operates on the "guilt-by-association" principle, where labels (e.g., "disease-associated") are propagated from seed nodes to their neighbors. The package is particularly powerful because it includes both classical scores and statistically normalized versions (z-scores and permutation-based p-values) that account for network topology biases like hub effects.

## Core Workflow

### 1. Data Preparation
Diffusion requires an `igraph` object and a named vector of scores.
- **Graph**: An undirected graph (usually a PPI network).
- **Scores**: A named numeric vector where names match vertex names in the graph.
  - `1`: Positive examples (seeds).
  - `0` or `-1`: Negative examples or background.
  - `NA`: Unlabelled nodes (treated as background in most methods).

### 2. Computing Diffusion Scores
The primary function is `diffuse`.

```r
library(diffuStats)
library(igraph)

# Basic diffusion (raw)
results <- diffuse(
  graph = my_graph,
  scores = my_input_vector,
  method = "raw"
)

# Normalized diffusion (z-score, parametric - recommended for speed)
results_z <- diffuse(
  graph = my_graph,
  scores = my_input_vector,
  method = "z"
)
```

### 3. Available Scoring Methods
| Method | Description |
| :--- | :--- |
| `raw` | Standard diffusion (K * y). Good for basic smoothing. |
| `ml` | Label propagation (positives = 1, negatives = -1). |
| `gm` | GeneMANIA-style bias on unlabelled nodes. |
| `z` | **Recommended.** Parametric z-score normalization. Fast and removes hub bias. |
| `mc` | Monte Carlo permutation-based p-values (1 - p). Computationally intensive. |
| `ber_s` | Relative change before/after smoothing. |
| `ber_p` | Combined raw score and permutation p-value. |

### 4. Benchmarking and Performance
If you have "gold standard" labels, use `perf` to compare methods.

```r
# Compare multiple methods at once
comparison <- perf(
  graph = my_graph,
  scores = input_matrix,      # Matrix with multiple input sets
  validation = gold_standard, # Matrix with true labels
  grid_param = expand.grid(method = c("raw", "z", "ml"))
)
```

## Advanced Usage Tips

- **Kernel Precomputation**: For large networks (>10k nodes), precompute the kernel to save time if running multiple diffusions.
  ```r
  K <- regularisedLaplacianKernel(my_graph)
  res <- diffuse(K = K, scores = my_scores, method = "z")
  ```
- **Quantitative Inputs**: Methods like `raw`, `z`, and `ber_s` accept continuous values (e.g., fold-changes), not just binary 0/1.
- **Visualisation**: Use `scores2colours` and `scores2shapes` to prepare `igraph` plot attributes.
  ```r
  plot(my_graph, 
       vertex.color = scores2colours(results),
       vertex.shape = scores2shapes(my_input_vector))
  ```

## Reference documentation

- [diffuStats: an R package to compute diffusion-based scores on biological networks](./references/diffuStats.md)
- [Diffusion using diffuStats in a nutshell](./references/intro.md)