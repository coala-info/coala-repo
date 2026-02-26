---
name: sccellfie
description: The sccellfie tool analyzes cellular metabolism at single-cell resolution by mapping transcriptomic data onto genome-scale metabolic models to calculate reaction and task activity scores. Use when user asks to calculate metabolic activity scores, identify active metabolic pathways in cell clusters, or run a metabolic phenotyping pipeline on single-cell or spatial transcriptomic data.
homepage: https://github.com/earmingol/scCellFie
---


# sccellfie

## Overview
The `sccellfie` skill enables the analysis of cellular metabolism at single-cell resolution. By mapping transcriptomic data onto genome-scale metabolic models, the tool calculates activity scores for specific biochemical reactions and broader metabolic tasks. It is optimized for speed and memory efficiency, making it suitable for atlas-scale datasets (e.g., 100k+ cells). Use this skill to move beyond gene-level descriptions to functional metabolic phenotypes, identifying which pathways (like glycolysis or lipid metabolism) are active in specific cell clusters or spatial domains.

## Installation and Setup
Install `sccellfie` via bioconda or pip:

```bash
# Using Conda
conda install bioconda::sccellfie

# Using Pip
pip install sccellfie
```

## Core Workflow Patterns

### Running the Standard Pipeline
The most efficient way to process data is using the `run_sccellfie_pipeline` function. It handles the mapping of genes to reactions and tasks in one step.

```python
import sccellfie
import scanpy as sc

# Load your AnnData object
adata = sc.read("your_data.h5ad")

# Execute the pipeline
results = sccellfie.run_sccellfie_pipeline(
    adata, 
    organism='human', # or 'mouse'
    n_counts_col='n_counts', 
    smooth_cells=True, # Recommended for scRNA-seq to mitigate dropouts
    alpha=0.33,        # Smoothing parameter
    chunk_size=5000    # Adjust based on available RAM
)
```

### Accessing Results
The pipeline returns a dictionary containing specialized AnnData objects. Understanding where data is stored is critical for downstream analysis:

*   **`results['adata'].reactions`**: An AnnData object where `.X` contains reaction activity scores.
*   **`results['adata'].metabolic_tasks`**: An AnnData object where `.X` contains metabolic task scores.
*   **`results['adata'].layers['gene_scores']`**: Contains the intermediate gene-level scores used for inference.

### Downstream Analysis with Scanpy
Because the outputs are AnnData objects, you can use standard Scanpy functions for visualization and clustering:

```python
# Visualize metabolic task activity on a UMAP
task_adata = results['adata'].metabolic_tasks
sc.pl.umap(task_adata, color=['Glycolysis', 'TCA cycle'])

# Find marker metabolic tasks for cell clusters
sc.tl.rank_genes_groups(task_adata, groupby='cell_type', method='wilcoxon')
sc.pl.rank_genes_groups(task_adata)
```

## Expert Tips and Best Practices

*   **Data Smoothing**: Always set `smooth_cells=True` for single-cell transcriptomics. This uses a neighbor-based approach to reduce noise and account for the sparsity of metabolic gene expression.
*   **Memory Management**: For very large datasets (>100k cells), use the `chunk_size` parameter to process the data in batches, preventing out-of-memory errors.
*   **Organism Specificity**: Ensure the `organism` parameter matches your data ('human' or 'mouse'), as `sccellfie` uses specific metabolic models and GPR (Gene-Protein-Reaction) rules for each.
*   **Spatial Data**: When working with spatial transcriptomics, the pipeline treats each spot as a "cell." Ensure your `neighbors_key` in the pipeline matches the spatial neighbors calculated by Scanpy/Squidpy.
*   **Reporting**: Use `sccellfie.reports.generate_report_from_adata` to aggregate results by group (e.g., cell type or tissue) for use in the scCellFie Metabolic Task Visualizer.

## Reference documentation
- [scCellFie GitHub Repository](./references/github_com_earmingol_scCellFie.md)
- [scCellFie Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sccellfie_overview.md)