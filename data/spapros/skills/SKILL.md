---
name: spapros
description: Spapros is a Python-based pipeline for selecting optimal gene sets for spatial transcriptomics experiments by balancing cell type identification and transcriptional diversity. Use when user asks to select informative gene subsets, evaluate gene panel performance, or filter genes based on technical probe design constraints.
homepage: https://github.com/theislab/spapros
---

# spapros

## Overview
Spapros is a Python-based pipeline designed to solve the "gene selection problem" in spatial transcriptomics. Since spatial technologies often limit the number of genes that can be simultaneously profiled, Spapros helps researchers select the most informative subset of genes. It optimizes for two primary goals: identifying specific cell types and capturing broader transcriptional diversity. The tool also integrates with probe design filters to ensure the selected genes are technically compatible with specific spatial platforms like MERFISH, SeqFISH, or HybISS.

## Usage Guidelines

### Core Selection Strategies
The selection logic depends on your specific research goals. Configure the selection parameters based on these common scenarios:

*   **Cell Type Identification Only**: If the goal is purely to identify cell type proportions or niche compositions, set `n_pca_genes=0`. This focuses the algorithm on classification performance (SpaprosCTo).
*   **Capturing General Variation**: Use default settings to balance cell type markers with genes that represent overall transcriptional variance.
*   **Large Gene Panels (>150 genes)**: For high-capacity experiments, run the selection pipeline sequentially multiple times to build the set, rather than attempting a single massive selection.
*   **Incorporating Prior Knowledge**: 
    *   Use the `preselected_genes` argument to force-include specific genes of interest (e.g., known disease signatures).
    *   Use the `marker_list` argument if you have a curated list of markers that must be represented.

### Handling Complex Datasets
*   **High Cell Type Diversity**: If the reference scRNA-seq data contains more than 100 cell type clusters, split the data into coarse groups (e.g., immune vs. non-immune) and run selections separately to manage memory and compute time.
*   **Subtle Signatures**: If interested in a specific disease state not well-represented in the general clustering, manually define "diseased" clusters or add DE genes as pre-selections.
*   **Resource Management**: Selection is computationally intensive. It is recommended to run Spapros on a compute cluster (standard benchmarks suggest 12 CPUs and 64GB RAM for typical datasets).

### Evaluation and Comparison
Spapros provides an evaluation scheme to compare different gene panels (e.g., comparing a Spapros-selected set against a literature-based set).
*   Use the evaluation module to check how well a panel captures cell type identity and expression variation.
*   Check for "marker correlation" to ensure the panel isn't redundant.

### Technical Probe Filtering
Before finalizing a gene set, use the probe design component (integrated with `oligo-designer-toolsuite`) to filter out genes that:
*   Lack sufficient unique probe sequences.
*   Violate GC-content or melting temperature (Tm) requirements.
*   Have overlapping binding locations that prevent optimal probe density.



## Subcommands

| Command | Description |
|---------|-------------|
| spapros evaluation | Create a selection of probesets for an h5ad file. |
| spapros selection | Create a selection of probesets for an h5ad file. |

## Reference documentation
- [spapros GitHub Repository](./references/github_com_theislab_spapros.md)
- [spapros Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spapros_overview.md)