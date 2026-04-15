---
name: drug2cell
description: drug2cell evaluates drug-target activity and gene group enrichment in single-cell transcriptomics data. Use when user asks to calculate per-cell drug activity scores, perform drug enrichment analysis on cell clusters, or map custom gene sets onto single-cell manifolds.
homepage: https://github.com/teichlab/drug2cell/
metadata:
  docker_image: "quay.io/biocontainers/drug2cell:0.1.2--pyhdfd78af_0"
---

# drug2cell

## Overview

The `drug2cell` library is a specialized utility for Scanpy that facilitates the evaluation of gene group activities, with a primary focus on drug-target interactions. It allows researchers to transform high-dimensional single-cell data into a drug-centric feature space. By leveraging pre-parsed ChEMBL database targets or custom gene sets, the tool provides three main analytical workflows: per-cell scoring to see drug activity across a manifold, and cluster-based enrichment (GSEA) or overrepresentation (hypergeometric) tests to identify drugs relevant to specific cell populations.

## Installation and Setup

Install the package via pip or conda:

```python
# Via pip
pip install drug2cell

# Via bioconda
conda install bioconda::drug2cell
```

Standard import convention:
```python
import drug2cell as d2c
import scanpy as sc
```

## Core Workflows

### 1. Per-cell Activity Scoring
Use `d2c.score()` to calculate activity scores for every cell in your dataset. This is useful for visualizing drug target expression on UMAPs.

- **Input**: An `AnnData` object.
- **Output**: Results are stored in `adata.uns['drug2cell']`.
- **Note**: The function copies `.obs` and `.obsm` to the new object, allowing for immediate downstream plotting (e.g., `sc.pl.umap`).

```python
# Calculate scores using default ChEMBL targets
d2c.score(adata)

# Access the new feature space object
drug_adata = adata.uns['drug2cell']
sc.pl.umap(drug_adata, color=['Drug_Name_Here'])
```

### 2. Enrichment and Overrepresentation
These functions identify which drugs are significantly associated with the marker genes of a cluster.

**Prerequisite**: You must run `sc.tl.rank_genes_groups(adata, 'cluster_column')` before using these functions.

- **GSEA**: `d2c.gsea(adata)` performs Gene Set Enrichment Analysis.
- **Hypergeometric**: `d2c.hypergeometric(adata)` performs a standard overrepresentation test.

Both functions return a dictionary of DataFrames (one per cluster) containing p-values and enrichment scores.

### 3. Using Custom Gene Groups
You are not limited to the built-in ChEMBL targets. You can provide any gene sets (e.g., pathways, custom signatures) using a dictionary.

```python
custom_targets = {
    "Pathway_A": ["GENE1", "GENE2", "GENE3"],
    "Pathway_B": ["GENE4", "GENE5"]
}

d2c.score(adata, targets=custom_targets)
```

## Expert Tips and Best Practices

- **Data Normalization**: Ensure your `AnnData` object is normalized and log-transformed (standard Scanpy workflow) before running `d2c.score()`.
- **Target Filtering**: While `drug2cell` provides ChEMBL human targets by default, you can filter the ChEMBL database differently using helper functions in `d2c.chembl` if you require specific drug phases or confidence scores.
- **Memory Management**: Since `d2c.score()` creates a new object in `.uns`, be mindful of memory usage when working with very large datasets (100k+ cells). You can extract the `uns['drug2cell']` object and delete the original if only the drug space is needed.
- **Gene Symbols**: Ensure the gene symbols in your `adata.var_names` match the nomenclature used in your target dictionary (usually HGNC symbols for the default ChEMBL set).

## Reference documentation
- [Drug2cell GitHub Repository](./references/github_com_Teichlab_drug2cell.md)
- [Bioconda drug2cell Overview](./references/anaconda_org_channels_bioconda_packages_drug2cell_overview.md)