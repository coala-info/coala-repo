---
name: sctriangulate
description: sctriangulate reconciles conflicting single-cell cluster assignments from different algorithms or modalities to determine the most stable identity for each cell. Use when user asks to resolve cluster ambiguities, integrate multimodal annotations, or identify the optimal clustering resolution for specific cell populations.
homepage: https://github.com/frankligy/scTriangulate
---


# sctriangulate

## Overview
sctriangulate is a specialized tool for "decision-level" integration of single-cell data. Instead of re-clustering raw data, it evaluates existing, often conflicting, cluster assignments—derived from different resolutions, algorithms, or modalities—and uses cooperative game theory to determine the most stable identity for each cell. This is particularly useful for resolving ambiguities in cell type annotation and discovering rare populations that might be obscured in a single clustering run.

## Data Preparation
Before running sctriangulate, ensure your `AnnData` object meets these criteria:
- **Normalization**: `adata.X` must be properly normalized (e.g., log CPTT for RNA, CLR for ADT).
- **Annotations**: At least two columns in `adata.obs` must contain the conflicting labels you wish to reconcile.
- **Visualization**: `adata.obsm['X_umap']` must be present for automatic report generation.
- **Raw Data**: Delete `adata.raw` if it exists (`del adata.raw`), as it can interfere with marker gene calculations during the ranking process.

## Python Workflow
The most efficient way to run the tool is using the `lazy_run` method, which automates metric calculation (reassign score, TFIDF, and SCCAF) and reconciliation.

```python
import scanpy as sc
from sctriangulate import ScTriangulate, sctriangulate_setting

# Set backend for headless environments or servers
sctriangulate_setting(backend='Agg')

# Load data
adata = sc.read('input.h5ad')

# Initialize and run
sctri = ScTriangulate(
    dir='./output', 
    adata=adata, 
    query=['leiden_res_0.5', 'leiden_res_1.2', 'seurat_labels']
)
sctri.lazy_run()
```

## Docker CLI Usage
For containerized execution, mount your local directory and specify the input paths and query columns:

```bash
docker run -v $PWD:/usr/src/app/run -t frankligy123/sctriangulate:0.12.0.1 \
    --adata_path ./run/input.h5ad \
    --dir_path ./run/output \
    --query cluster_col1 cluster_col2 cluster_col3
```

## Expert Tips and Best Practices
- **Resolution Mixing**: A common power-user pattern is to run Leiden clustering at multiple resolutions (e.g., 0.5, 1.0, 2.0, and 5.0) and use sctriangulate to pick the optimal resolution for each specific branch of the lineage.
- **Reference Atlas Integration**: Use this tool to reconcile your unsupervised clusters with supervised labels transferred from a reference atlas (like Azimuth or cellHarmony).
- **Multimodal Consensus**: In CITE-Seq or Multiome analysis, generate independent clusters for each modality (RNA vs. ADT or RNA vs. ATAC) and pass them to the `query` argument to find a unified solution that respects both data types.
- **Memory Management**: For very large datasets, ensure you have sufficient RAM for the parallelized metric calculations, as sctriangulate evaluates stability for every cluster in every input source.

## Reference documentation
- [scTriangulate GitHub Repository](./references/github_com_frankligy_scTriangulate.md)
- [scTriangulate Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sctriangulate_overview.md)