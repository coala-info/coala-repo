---
name: bioconductor-bearscc
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BEARscc.html
---

# bioconductor-bearscc

name: bioconductor-bearscc
description: Use when analyzing single-cell RNA-seq data to evaluate the robustness of cell clusters against technical noise. This skill helps model technical variation using ERCC spike-ins, generate simulated technical replicates, and calculate consensus metrics (stability, promiscuity, and score) to determine if clusters are biologically meaningful or artifacts of experimental noise.

# bioconductor-bearscc

## Overview

BEARscc (Bayesian ERCC Assessment of single-cell cluster robustness) is a noise perturbation algorithm that determines the extent to which single-cell RNA-seq cluster assignments are robust to technical variation. It uses spike-in controls (like ERCCs) to build a statistical model of expression-dependent variance and drop-out effects. By generating simulated technical replicates and re-clustering them, BEARscc provides quantitative metrics to identify stable clusters and cells that may be inconsistently assigned due to experimental noise.

## Workflow and Core Functions

### 1. Data Preparation
BEARscc requires a `SingleCellExperiment` object containing:
- An assay named `"observed_expression"` (counts or normalized counts).
- Metadata containing `"spikeConcentrations"` (a data frame of spike-in IDs and their actual concentrations).
- Spike-in rows identified via `isSpike()`.

```r
library(BEARscc)
# Create SCE object
sce <- SingleCellExperiment(list(counts=as.matrix(data.counts.df)))
metadata(sce)$spikeConcentrations <- ERCC.meta.df
assay(sce, "observed_expression") <- counts(sce)
isSpike(sce, "ERCC_spikes") <- grepl("^ERCC-", rownames(sce))
```

### 2. Building the Noise Model
Estimate technical variance and drop-out parameters based on the spike-ins.
- `alpha_resolution`: Use 0.001 to 0.01 for production; higher values (0.1+) are for testing.
- `write.noise.model`: Set to `TRUE` to save parameters for HPC use.

```r
sce <- estimate_noiseparameters(sce, alpha_resolution = 0.01)
```

### 3. Simulating Technical Replicates
Generate perturbed counts matrices based on the noise model.
- `n`: Number of replicates (50–100 recommended for stable consensus).

```r
sce <- simulate_replicates(sce, n = 50)
# Replicates are stored in metadata(sce)$simulated_replicates
```

### 4. Forming a Noise Consensus
After generating replicates, you must cluster each one using your preferred algorithm (e.g., SC3, Seurat, or hierarchical clustering). Collect the cluster labels into a data frame where each column is a replicate.

```r
# Example: Re-clustering a list of replicates
cluster_list <- lapply(metadata(sce)$simulated_replicates, function(replicate_counts) {
    # Apply your clustering algorithm here
    # return(cluster_labels)
})
clusters.df <- do.call("cbind", cluster_list)

# Compute the consensus matrix
noise_consensus <- compute_consensus(clusters.df)
```

### 5. Evaluating Robustness Metrics
Calculate metrics to interpret the consensus matrix.
- **Stability**: Propensity for a cluster to contain the same cells across replicates.
- **Promiscuity**: Tendency for cells in a cluster to associate with other clusters.
- **Score**: Stability minus Promiscuity (higher is better).

```r
# Cluster the consensus matrix to find optimal k
vector <- seq(2, 10, by=1)
bearscc_clusters <- cluster_consensus(noise_consensus, vector)

# Report metrics
cluster_scores <- report_cluster_metrics(bearscc_clusters, noise_consensus)
cell_scores <- report_cell_metrics(bearscc_clusters, noise_consensus)
```

## High Performance Computing (HPC)
For large datasets, use `HPC_simulate_replicates()` to generate replicates in parallel across a cluster. This requires exporting the noise model parameters using `write.noise.model=TRUE` in the estimation step.

## Reference documentation
- [BEARscc](./references/BEARscc.md)