---
name: bioconductor-epinem
description: This tool infers signaling pathway structures and logical epistatic relationships from knock-out screens containing single and double perturbations. Use when user asks to reconstruct signaling hierarchies, identify logical gates between genes, or analyze binary effect matrices from high-throughput perturbation screens.
homepage: https://bioconductor.org/packages/release/bioc/html/epiNEM.html
---

# bioconductor-epinem

name: bioconductor-epinem
description: Infer signaling pathway structures and logical epistatic relationships (OR, AND, NOT, XOR) from knock-out screens containing both single and double perturbations. Use this skill to analyze binary effect matrices where rows are effect reporters and columns are perturbations.

## Overview

The `epiNEM` package extends classic Nested Effects Models (NEM) by incorporating double knock-out data. It identifies how two upstream genes interact to regulate downstream effect reporters using logical gates. This is particularly useful for identifying modulators of genetic interactions and reconstructing signaling hierarchies from high-throughput screens (e.g., RNAi, CRISPR, or yeast deletion libraries).

## Core Workflow

### 1. Data Preparation
Input data must be a binary matrix (0 = no effect, 1 = effect).
- **Rows**: Effect reporters (e.g., genes, proteins, or phenotypic markers).
- **Columns**: Perturbations. Single knock-outs should be named by the gene (e.g., "A"), and double knock-outs should be dot-separated (e.g., "A.B").

```r
# Example: 100 reporters, 4 perturbations
data <- matrix(sample(c(0,1), 100*4, replace = TRUE), 100, 4)
colnames(data) <- c("A", "B", "A.B", "C")
rownames(data) <- paste0("E", 1:100)
```

### 2. Pathway Inference
Use `epiNEM` for small-scale pathway reconstruction (up to 4-5 signaling genes).

```r
library(epiNEM)

# Exhaustive search is recommended for 4 or fewer genes
res <- epiNEM(data, method = "exhaustive")

# For 5 or more genes, use greedy search
# res <- epiNEM(data, method = "greedy")

# Visualize the inferred network
plot(res)
```

### 3. Systematic Screening
Use `epiScreen` to identify the most likely modulators for specific gene pairs in large-scale datasets.

```r
# data contains many single and double knock-outs
res_screen <- epiScreen(data)

# Plot global distribution of inferred logics
plot(res_screen)

# Plot detailed results for a specific double knock-out (by index)
plot(res_screen, global = FALSE, ind = 1)
```

## Logic Gate Interpretation

Use `epiAnno()` to visualize the expected effect patterns for each logical gate:
- **OR**: No specific relationship; both genes contribute independently.
- **AND**: Functional overlap; both genes are required for the effect.
- **NOT**: Masking or inhibition; one gene masks the effect of the other.
- **XOR**: Mutual prevention; the effect is only present if exactly one gene is perturbed.

```r
# View the logic gate legend
epiAnno()
```

## Tips for Success

- **Binarization**: epiNEM requires binary input. Typically, differential expression results (e.g., from `edgeR` or `limma`) are thresholded based on p-value (e.g., < 0.05) and fold-change (e.g., |logFC| > 0.5).
- **Column Naming**: Ensure double knock-outs are named exactly as `Gene1.Gene2`. The order does not matter, but the dot separator is required for `epiScreen`.
- **Visualization**: The `plot()` function for `epiNEM` results shows signaling genes in red, logical gates in green, and the number of attached effect reporters in grey.
- **Large Networks**: If the search space is too large, prioritize genes using prior knowledge or focus on specific triples using `epiScreen`.

## Reference documentation

- [Epistatic Nested Effects Models: Inferring mixed epistasis from indirect measurements of knock-out screens](./references/epiNEM.md)
- [epiNEM Vignette Source](./references/epiNEM.Rmd)