---
name: gneiss
description: Gneiss is a toolset for analyzing compositional data by transforming feature abundances into log-ratio balances. Use when user asks to analyze microbiome abundance tables, perform log-ratio transformations, or apply statistical models like OLS and LME to compositional datasets.
homepage: https://biocore.github.io/gneiss/
metadata:
  docker_image: "quay.io/biocontainers/gneiss:0.4.6--py_0"
---

# gneiss

## Overview
Gneiss is a specialized toolset for the analysis of compositional data, such as microbiome abundance tables. Instead of analyzing raw proportions—which are inherently constrained and can lead to spurious correlations—gneiss transforms data into "balances" using log-ratio techniques. This allows researchers to apply standard statistical models (like OLS regression) to identify niche differentiation and microbial shifts across environmental gradients or clinical groups.

## Core Concepts
- **Balances**: Log ratios between groups of features (e.g., taxa) defined by a bifurcating tree.
- **Compositionality**: The property where components of a whole (proportions) are not independent; gneiss resolves this by moving into log-ratio space.
- **Balance Trees**: Hierarchical structures used to partition features for ratio calculations.

## Usage Patterns

### Installation
The preferred method is via Conda:
```bash
conda install -c bioconda gneiss
```

### Python API Workflow
Gneiss is primarily used as a Python library. The typical workflow involves:

1. **Data Preparation**: Ensure your feature table (counts/proportions) and metadata are aligned.
2. **Tree Construction**: Use `gneiss.cluster.table_clustering` to create a hierarchy based on correlation or use a predefined phylogenetic tree.
3. **Balance Calculation**:
   ```python
   from gneiss.balances import balance_basis
   # Transform proportions into balances based on the tree
   ```
4. **Statistical Modeling**:
   - **OLS Regression**: Use `gneiss.regression.ols` for cross-sectional studies.
   - **Linear Mixed Effects (LME)**: Use `gneiss.regression.lme` for longitudinal or nested data.
5. **Visualization**:
   - Use `gneiss.plot.heatmap` to visualize balances against the tree.
   - Use `gneiss.plot.dendrogram` to inspect the hierarchy.

## Best Practices
- **Tree Selection**: The interpretation of a balance depends entirely on the tree. Use `table_clustering` if you want to find co-occurring groups, or a phylogenetic tree if you want to test evolutionary hypotheses.
- **Zero Handling**: Log ratios cannot handle zeros. Ensure you apply a pseudo-count (e.g., 1) or use a zero-imputation strategy before transformation.
- **Metadata Alignment**: Always verify that your metadata indices match your feature table indices before running regression models to avoid alignment errors.
- **Interpretation**: A positive balance indicates the numerator group is more abundant than the denominator group, while a negative balance indicates the opposite.

## Reference documentation
- [Gneiss Overview](./references/anaconda_org_channels_bioconda_packages_gneiss_overview.md)
- [Gneiss Documentation Index](./references/biocore_github_io_gneiss_docs_v0.4.0_index.html.md)