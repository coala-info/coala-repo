---
name: bioconductor-mgsa
description: The bioconductor-mgsa package performs model-based gene set analysis using a Bayesian approach to estimate the posterior probability of gene set enrichment while accounting for overlaps. Use when user asks to perform gene set enrichment analysis, handle overlapping gene sets using MCMC, or infer false positive and false negative rates in genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/mgsa.html
---


# bioconductor-mgsa

## Overview

The `mgsa` package implements Model-based Gene Set Analysis, a Bayesian approach to gene set enrichment. Unlike classical methods (like Fisher's Exact Test) that analyze each gene set in isolation, MGSA models all gene sets simultaneously. This approach naturally handles overlapping gene sets and reduces the long, redundant lists of enriched terms often produced by standard methods. It estimates the posterior probability of a gene set being "active" while simultaneously inferring false positive (alpha) and false negative (beta) rates.

## Core Workflow

### 1. Data Preparation
MGSA requires two main inputs:
- **Observations**: A character vector of "hit" genes (e.g., differentially expressed genes).
- **Gene Sets**: An `MgsaSets` object or a named list where each element is a vector of genes belonging to a set.

```R
library(mgsa)

# Example: Custom list of gene sets
my_sets <- list(
  pathway_A = c("GENE1", "GENE2", "GENE3"),
  pathway_B = c("GENE2", "GENE4", "GENE5")
)

# Example: Observations (the 'hits')
my_hits <- c("GENE1", "GENE2")
```

### 2. Running the Analysis
The primary function is `mgsa()`. It uses Markov Chain Monte Carlo (MCMC) to estimate posterior probabilities.

```R
# Run MGSA on a list
fit <- mgsa(observations = my_hits, sets = my_sets)

# For repeated runs with the same gene sets, pre-index them for speed:
mgsa_sets_obj <- new("MgsaSets", sets = my_sets)
fit <- mgsa(my_hits, mgsa_sets_obj)
```

### 3. Working with Gene Ontology (GO)
The package provides specialized support for GO using GAF files. This requires `GO.db` and `RSQLite`.

```R
# Read a Gene Association File (GAF)
go_sets <- readGAF("path/to/file.gaf")

# Run analysis
fit_go <- mgsa(my_hits, go_sets)
```

### 4. Interpreting Results
The result is an `MgsaMcmcResults` object.

- **Print**: Shows the top gene sets by posterior probability.
- **Plot**: Visualizes the posterior probabilities and the distribution of parameters (alpha, beta, p).
- **Extract**: Use `setsResults()` to get a data frame of all results.

```R
# View top hits
print(fit)

# Plot results
plot(fit)

# Extract to data frame and filter for high-confidence sets
res <- setsResults(fit)
high_conf <- subset(res, estimate > 0.5)
```

## Parameters and Tuning
MGSA automatically infers the following parameters, but they can be influenced by the model:
- **alpha ($\alpha$)**: False positive rate (inactive gene observed as a hit).
- **beta ($\beta$)**: False negative rate (active gene not observed as a hit).
- **p**: Prior probability of a set being active (controls sparsity).

## Tips for Success
- **Population Size**: MGSA considers the "universe" of genes. If using an `MgsaSets` object, the population is defined by all unique items in the sets. Ensure your observations are a subset of this population.
- **Reproducibility**: Since MGSA uses MCMC, use `set.seed()` before calling `mgsa()` to ensure consistent results across sessions.
- **Redundancy**: If you see many related GO terms with high scores, MGSA is already working to minimize this, but extremely high overlap may still result in multiple hits; focus on the terms with the highest `estimate`.

## Reference documentation
- [The mgsa package](./references/mgsa.md)