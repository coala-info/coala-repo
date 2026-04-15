---
name: scrublet
description: Scrublet predicts and identifies doublets in single-cell RNA-seq data by simulating synthetic doublets and calculating a doublet score for each cell. Use when user asks to identify doublets, calculate doublet scores, or remove multiplets from scRNA-seq datasets.
homepage: https://github.com/allonkleinlab/scrublet
metadata:
  docker_image: "quay.io/biocontainers/scrublet:0.2.3--pyh5e36f6f_1"
---

# scrublet

## Overview
Scrublet (Single-Cell Remover of Doublets) is a framework for predicting doublets in scRNA-seq data. It functions by simulating synthetic doublets from the user's observed data and then using a k-nearest-neighbor (kNN) classifier to assign a continuous "doublet score" to each cell. This score represents the probability that a cell is a doublet. The tool provides automated thresholding to flag cells for removal, ensuring higher data integrity for downstream clustering and trajectory analysis.

## Implementation Patterns

### Basic Python Workflow
Scrublet is primarily used as a Python library. It requires a raw (unnormalized) UMI counts matrix where rows represent cells and columns represent genes.

```python
import scrublet as scr
import scipy.io

# Load your raw counts matrix (e.g., from a MTX file or AnnData object)
# counts_matrix = ... 

# Initialize Scrublet object
scrub = scr.Scrublet(counts_matrix)

# Run the doublet prediction pipeline
# This simulates doublets and calculates scores
doublet_scores, predicted_doublets = scrub.scrub_doublets()
```

### Visualizing Results
To ensure the automated threshold is accurate, it is standard practice to visualize the doublet score distributions.

```python
# Plot histograms of observed vs. simulated doublet scores
scrub.plot_histogram()
```

## Expert Tips and Best Practices

### 1. Process Samples Separately
**Critical**: Always run Scrublet on each sample (library) individually. Scrublet assumes that doublets are formed by the random co-encapsulation of cells present in the specific sample. Running it on a merged dataset with different cell type proportions from multiple experiments will lead to inaccurate doublet simulations and poor detection performance.

### 2. Manual Threshold Adjustment
The automated thresholding logic in `scrub_doublets()` attempts to find a dip in a bimodal distribution of simulated doublet scores. 
- If the histogram does not show a clear bimodal distribution, the automated threshold may be too aggressive or too lenient.
- Use `scrub.call_doublets(threshold=0.25)` to manually set the threshold based on the histogram visualization.

### 3. Embedding Validation
After identifying doublets, project the scores onto a 2-D embedding (like UMAP or t-SNE).
- **Expected Behavior**: Predicted doublets should typically co-localize in specific areas or form small distinct clusters.
- **Warning Sign**: If predicted doublets are randomly scattered across all clusters, it may indicate that the threshold is too low or the preprocessing parameters (like the number of PCs) need adjustment.

### 4. Input Requirements
- Use **raw counts**: Do not use normalized, log-transformed, or scaled data as input to the `Scrublet` constructor.
- **Gene Filtering**: While Scrublet performs internal filtering, removing lowly expressed genes before running the tool can improve speed and reduce noise.

## Reference documentation
- [Scrublet GitHub Repository](./references/github_com_AllonKleinLab_scrublet.md)
- [Bioconda Scrublet Overview](./references/anaconda_org_channels_bioconda_packages_scrublet_overview.md)