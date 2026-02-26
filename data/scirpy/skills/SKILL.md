---
name: scirpy
description: Scirpy is a toolkit for analyzing single-cell T-cell and B-cell receptor repertoire data within the scverse ecosystem. Use when user asks to load AIRR data, define clonotypes, calculate repertoire diversity, or visualize clonal expansion alongside gene expression data.
homepage: https://icbi-lab.github.io/scirpy
---


# scirpy

## Overview
Scirpy provides a specialized toolkit for single-cell adaptive immune receptor repertoire (AIRR) analysis. It bridges the gap between transcriptomics and immunology by allowing users to analyze TCR and BCR sequences directly within `AnnData` objects. It is the standard choice for workflows involving clonotype clustering, repertoire overlap analysis, and visualizing immune cell dynamics alongside gene expression clusters.

## Core Workflow & Best Practices

### 1. Data Loading and Preprocessing
Scirpy follows the `scverse` ecosystem conventions. Use `ir.io.read_*` functions to import data from common pipelines like 10x Genomics CellRanger or TraCer.

```python
import scirpy as ir
import scanpy as sc

# Load AIRR data (e.g., from 10x Genomics)
adata = ir.io.read_10x_vdj("path/to/filtered_contig_annotations.csv")

# Merge with existing Gene Expression (GEX) AnnData
# Ensure index names match between GEX and IR data
ir.pp.merge_with_ir(adata_gex, adata)
```

### 2. Defining Clonotypes
Clonotypes are defined based on CDR3 nucleotide or amino acid sequences.
- **Strict definition**: Identical V/J genes and identical CDR3 sequence.
- **Functional definition**: Use `ir.pp.ir_dist` to calculate distances and `ir.tl.define_clonotypes` to cluster similar receptors (e.g., allowing for 1 amino acid mismatch).

```python
# Calculate sequence distances
ir.pp.ir_dist(adata, metric="alignment", sequence="aa")

# Define clonotypes based on distance threshold
ir.tl.define_clonotypes(adata, thresh=1)
```

### 3. Repertoire Analysis
Once clonotypes are defined, use the `tl` (tool) and `pl` (plot) modules to characterize the repertoire:
- **Clonotype Abundance**: `ir.tl.clonotype_imbalance` to find expanded clones.
- **Diversity**: `ir.tl.alpha_diversity` to calculate Shannon entropy or Simpson index.
- **V(D)J Usage**: `ir.tl.group_abundance` to visualize V-gene distribution across clusters.

```python
# Visualize top clonotypes
ir.pl.group_abundance(adata, groupby="clonotype", target_col="cell_type")

# Calculate and plot clonal expansion
ir.tl.clonal_expansion(adata)
ir.pl.clonal_expansion(adata, groupby="seurat_clusters")
```

### 4. Integration with Scanpy
Because Scirpy stores data in `adata.obs` and `adata.uns`, you can use standard Scanpy plotting functions to visualize immune features on UMAPs.

```python
# Color UMAP by clonal expansion status
sc.pl.umap(adata, color=["clonal_expansion", "ct_gene_v_chain_1"])
```

## Expert Tips
- **Chain Handling**: Scirpy handles multi-chain cells (e.g., cells with two alpha chains). Use `ir.tl.chain_qc` to flag multi-chain or orphan-chain cells before downstream analysis.
- **Distance Metrics**: For large datasets, use `metric="identity"` in `ir.pp.ir_dist` for speed; use `alignment` or `levenshtein` only when biological sequence similarity clustering is required.
- **Data Schema**: AIRR data is stored in `adata.obsm["airr"]`. Familiarize yourself with the AIRR Rearrangement schema if manual manipulation of the receptor data is needed.

## Reference documentation
- [Scirpy Overview](./references/anaconda_org_channels_bioconda_packages_scirpy_overview.md)
- [Scirpy Documentation Home](./references/icbi-lab_github_io_scirpy.md)