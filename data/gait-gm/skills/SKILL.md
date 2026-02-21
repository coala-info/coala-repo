---
name: gait-gm
description: gait-gm (Gene Analysis Integration Tool - Genomes to Metabolomes) is a bioinformatics suite designed to identify and model the relationships between gene expression levels and metabolite concentrations.
homepage: https://github.com/secimTools/gait-gm
---

# gait-gm

## Overview
gait-gm (Gene Analysis Integration Tool - Genomes to Metabolomes) is a bioinformatics suite designed to identify and model the relationships between gene expression levels and metabolite concentrations. It is particularly useful for researchers looking to bridge the gap between transcriptomics and metabolomics to uncover functional biological insights. The tool provides a set of Python-based scripts to perform Sparse Partial Least Squares (sPLS) regression, all-by-all correlation analysis, and automated KEGG pathway annotation.

## Installation and Setup
The tool can be installed via Conda or Pip. It requires `SECIMTools` as a prerequisite.

```bash
# Installation via Conda
conda install -c bioconda gait-gm

# Installation via Pip
pip install gait-gm
```

## Core CLI Tools and Workflows

### 1. Integrative Modeling with sPLS
The primary method for modeling metabolites as a function of gene expression is Sparse Partial Least Squares (sPLS). This is handled by the `sPLS.py` script.

- **Usage**: Use `sPLS.py` when you have a high-dimensional dataset (many genes) and want to find a subset of genes that best predict metabolite levels.
- **Expert Tip**: If you encounter segmentation faults during R-based execution of sPLS (via `mixOmics`), ensure the environment variable `RGL_USE_NULL=TRUE` is set to avoid issues with graphical device initialization.

### 2. Correlation Analysis
For a broader view of how two datasets relate without predictive modeling, use the correlation module.

- **Script**: `all_by_all_correlation`
- **Function**: Calculates the correlation matrix between every feature in dataset A (e.g., genes) and every feature in dataset B (e.g., metabolites).
- **Output**: Typically generates a correlation table and associated p-values.

### 3. KEGG Annotation and Pathway Mapping
Once associations are identified, use the annotation scripts to provide biological context.

- **`add_kegg_pathway_info`**: Maps identified metabolites or genes to KEGG pathways. Ensure you specify the output directory and filename clearly in the arguments.
- **`add_kegg_anno_info`**: Adds detailed KEGG annotation metadata to your results.
- **`add_pval_flags`**: A utility script to flag results based on p-value significance thresholds (e.g., marking results with `*` for p < 0.05).

## Best Practices
- **Data Preparation**: Ensure your gene expression and metabolite data use consistent sample identifiers. gait-gm relies on matching samples across both datasets.
- **Testing**: The package includes acceptance tests in `tests/galaxy`. While these are designed for a Galaxy environment, the underlying shell scripts provide excellent examples of how to structure CLI calls for the Python scripts.
- **Performance**: Be aware that some comprehensive tests and large-scale sPLS runs can take several hours to complete depending on the size of the input matrices.

## Reference documentation
- [GAIT-GM Overview](./references/anaconda_org_channels_bioconda_packages_gait-gm_overview.md)
- [GAIT-GM GitHub Repository](./references/github_com_secimTools_gait-gm.md)
- [GAIT-GM Commit History](./references/github_com_secimTools_gait-gm_commits_main.md)