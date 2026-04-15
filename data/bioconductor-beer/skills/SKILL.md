---
name: bioconductor-beer
description: This tool analyzes Phage immuno-precipitation sequencing (PhIP-seq) data to identify enriched antibody responses. Use when user asks to identify enriched peptides using edgeR or Bayesian models, perform beads-only analysis for false positive estimation, calculate Bayes factors, or visualize PhIP-seq enrichment results.
homepage: https://bioconductor.org/packages/release/bioc/html/beer.html
---

# bioconductor-beer

name: bioconductor-beer
description: Analysis of Phage immuno-precipitation sequencing (PhIP-seq) data to identify enriched antibody responses. Use when Claude needs to: (1) Identify enriched peptides using edgeR or Bayesian (BEER) models, (2) Perform beads-only round-robin analysis for false positive estimation, (3) Calculate Bayes factors or expected read counts for PhIP-seq data, or (4) Visualize enrichment results.

# bioconductor-beer

## Overview

The `beer` package provides tools for identifying enriched antibody responses in PhIP-seq experiments. It implements two primary approaches:
1. **edgeR**: A fast, frequentist approach based on differential expression pipelines, effective for high fold-change enrichments.
2. **BEER (Bayesian Estimation Enrichment in R)**: A Bayesian hierarchical model that provides higher sensitivity for peptides in the lower fold-change range, though it requires more computational time.

The package utilizes the `PhIPData` object (extending `SummarizedExperiment`) to store counts, metadata, and analysis results.

## Installation and Setup

The package requires the JAGS (Just Another Gibbs Sampler) library for MCMC modeling.

```r
# Install JAGS on system (e.g., brew install jags)
# Then install R dependencies
BiocManager::install("beer")
library(beer)
```

## Core Workflow

### 1. Identify Enrichments with edgeR

Use `runEdgeR()` to establish a baseline of enriched peptides. This function compares serum samples against all beads-only samples.

```r
# Run edgeR and store results in specific assays
edgeR_out <- runEdgeR(sim_data, 
                      assay.names = c(logfc = "edgeR_logfc", 
                                      prob = "edgeR_logpval"))

# Identify hits using BH-adjusted p-values < 0.05
assay(edgeR_out, "edgeR_hits") <- apply(
  assay(edgeR_out, "edgeR_logpval"), 2, 
  function(sample) {
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })
```

### 2. Identify Enrichments with BEER

Use `brew()` to run the Bayesian model. It estimates posterior probabilities of enrichment and fold-changes.

```r
# Define where to store MCMC summarized output
assay_locations <- c(
  phi = "beer_fc_marg",   # Marginal fold-change
  phi_Z = "beer_fc_cond", # Conditional fold-change
  Z = "beer_prob",        # Posterior probability
  c = "sampleInfo",       # Attenuation constant
  pi = "sampleInfo"       # Proportion of enriched peptides
)

# Run the Bayesian model
beer_out <- brew(edgeR_out, assay.names = assay_locations)
```

### 3. Define BEER Hits

BEER hits include peptides with high posterior probability (> 0.5) and "super-enriched" peptides (those with extremely high fold-changes that were excluded from MCMC to save time).

```r
# Identify super-enriched (SE) peptides (missing prob but were run)
was_run <- matrix(rep(beer_out$group != "beads", each = nrow(beer_out)), 
                  nrow = nrow(beer_out))
are_se <- was_run & is.na(assay(beer_out, "beer_prob"))

# Combine criteria for final hits
assay(beer_out, "beer_hits") <- assay(beer_out, "beer_prob") > 0.5 | are_se
```

## Advanced Procedures

### Beads-only Round Robin

To estimate false positive rates, run beads-only samples against each other.

```r
# Integrated into brew or runEdgeR
beer_beadsRR <- brew(sim_data, beadsRR = TRUE)

# Or run separately
beads_only_results <- beadsRR(sim_data, method = "beer")
```

### Parallelization

Use `BiocParallel` to speed up `brew()` or `runEdgeR()`.

```r
library(BiocParallel)
beer_out <- brew(sim_data, BPPARAM = MulticoreParam(workers = 4))
```

### Plotting Helpers

Use helper functions to prepare data for visualization.

*   **`getExpected()`**: Calculates expected read counts/proportions based on beads-only averages.
*   **`getBF()`**: Calculates Bayes factors for peptide enrichment.

```r
# Add expected counts and Bayes factors to the object
beer_out <- getExpected(beer_out)
beer_out <- getBF(beer_out)

# Convert to DataFrame for ggplot2
df <- as(beer_out, "DataFrame")
```

## Reference documentation

- [Estimating Enrichment in PhIP-Seq Experiments with BEER](./references/beer.Rmd)
- [Estimating Enrichment in PhIP-Seq Experiments with BEER](./references/beer.md)