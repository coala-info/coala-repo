---
name: scenicplus
description: SCENIC+ is a Python framework that decodes cellular regulatory logic by linking chromatin accessibility with gene expression to identify enhancer-driven gene regulatory networks. Use when user asks to infer eRegulons, link transcription factors to target genes and enhancers, or simulate the effects of transcription factor perturbations on gene expression.
homepage: https://github.com/aertslab/scenicplus
---


# scenicplus

## Overview
SCENIC+ is a comprehensive Python-based framework designed to decode the regulatory logic of cells by linking chromatin accessibility with gene expression at the single-cell level. It moves beyond traditional GRN inference by identifying "eRegulons," which consist of a transcription factor (TF), its target genes, and the specific genomic regions (enhancers) that govern their expression. This tool is essential for researchers looking to understand how cell-type-specific gene expression programs are established and maintained through distal regulatory elements.

## Installation and Environment Setup

To ensure stability, follow these environment constraints:
- **Python Version**: Use Python 3.11 (specifically 3.11.8 or lower).
- **Environment Manager**: Always use a fresh Conda environment to manage complex dependencies like `pycisTopic` and `pycisTarget`.

```bash
conda create --name scenicplus python=3.11 -y
conda activate scenicplus
git clone https://github.com/aertslab/scenicplus
cd scenicplus
pip install .
```

## Core Workflow Patterns

### 1. Data Integration and Object Initialization
SCENIC+ typically works with `MuData` objects or its own `SCENICPLUS` object. When working with existing multi-omic datasets:
- Ensure your scRNA-seq and scATAC-seq data are properly aligned and cell-matched.
- Use the conversion functions if moving from `MuData` to the native `scenicplus_obj`.

### 2. eRegulon Inference
The core of the analysis involves linking TFs to regions and regions to genes:
- **TF-to-Region**: Performed using `pycisTarget` to find enriched motifs in accessible regions.
- **Region-to-Gene**: Based on correlation between accessibility and expression, often within a defined genomic window (e.g., 500kb).
- **TF-to-Gene**: The final eRegulon is formed by intersecting these two links.

### 3. Visualization and Interpretation
Use the built-in plotting functions to evaluate the strength and specificity of the inferred networks:
- **Heatmaps and Dotplots**: Use `heatmap_dotplot` to visualize TF activity across cell types.
- **Perturbation Simulation**: Use the updated perturbation module to simulate the effect of TF knockdown or overexpression on the global GRN state.

## Expert Tips and Best Practices

- **Memory Management**: eRegulon enrichment steps can be extremely memory-intensive. If running on a cluster, ensure high-memory nodes are available for the `calc_scores` and enrichment phases.
- **Reproducibility**: Always set a seed for stochastic steps, particularly for GSEA (Gene Set Enrichment Analysis) and topic modeling, to ensure consistent results across runs.
- **Handling Empty eRegulons**: After running `build_grn`, check for empty eRegulons. Some TFs may not pass the statistical thresholds for region or gene linkage; implement checks to handle these cases before downstream visualization.
- **Non-Model Organisms**: While optimized for Human and Mouse, SCENIC+ can be used for other species by providing custom `cisTarget` databases and genome annotations.
- **Metadata Alignment**: Ensure that metadata for each region is present in the imputed objects to avoid `ValueError` during index alignment.

## Troubleshooting Common Issues

- **Shape Mismatches**: If you encounter `ValueError: Shape of passed values is...`, verify that your cell filtering in the scRNA-seq and scATAC-seq assays is identical.
- **Missing Fragments**: Ensure fragment files are indexed (`.tbi`) and the paths provided to the tool are absolute to avoid "file does not exist" errors during region-based analysis.
- **Package Deprecations**: If you see `pkg_resources` warnings, they are typically related to `pycistopic` dependencies and can usually be ignored unless they cause a crash.

## Reference documentation
- [scenicplus Overview](./references/anaconda_org_channels_bioconda_packages_scenicplus_overview.md)
- [SCENIC+ GitHub Repository](./references/github_com_aertslab_scenicplus.md)
- [SCENIC+ Discussions and Q&A](./references/github_com_aertslab_scenicplus_discussions.md)