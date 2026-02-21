---
name: pyscenic
description: pySCENIC is a high-performance Python implementation of the Single-Cell Regulatory Network Inference and Clustering (SCENIC) pipeline.
homepage: https://github.com/aertslab/pySCENIC
---

# pyscenic

## Overview

pySCENIC is a high-performance Python implementation of the Single-Cell Regulatory Network Inference and Clustering (SCENIC) pipeline. It enables the discovery of gene regulatory programs by identifying transcription factors (TFs) and their target genes. The workflow consists of three primary phases: inferring potential TF-target modules based on co-expression, pruning these modules to retain only direct targets with supporting cis-regulatory motifs, and scoring the activity of these "regulons" in individual cells to facilitate clustering and cell-type identification.

## Core Workflow and CLI Patterns

### 1. Gene Regulatory Network (GRN) Inference
The first step identifies co-expression modules between TFs and potential targets.

```bash
# Basic GRN inference using GRNBoost2 (faster than GENIE3)
pyscenic grn [EXPRESSION_MTX] [TF_LIST] -o adjacencies.tsv --method grnboost2

# For large datasets, use the --sparse flag if the input is a sparse matrix
pyscenic grn [EXPRESSION_MTX] [TF_LIST] -o adjacencies.tsv --sparse
```

### 2. Calculate Correlation (Optional)
Adding correlation information helps distinguish between activating and repressive regulations.

```bash
pyscenic add_cor adjacencies.tsv [EXPRESSION_MTX] --output adjacencies_with_cor.tsv
```

### 3. Regulon Pruning (cisTarget)
Refine modules by removing indirect targets that lack motif enrichment for the specific TF. This step requires cisTarget databases (Feather v2 format).

```bash
pyscenic ctx adjacencies.tsv [RANKING_DB_1] [RANKING_DB_2] \
    --annotations_fname [MOTIF_ANNOTATIONS] \
    --expression_mtx_fname [EXPRESSION_MTX] \
    --mode "dask_multiprocessing" \
    --output regulons.csv
```

### 4. Cellular Scoring (AUCell)
Quantify the activity of the discovered regulons in each cell.

```bash
pyscenic aucell [EXPRESSION_MTX] regulons.csv -o auc_matrix.loom
```

## Best Practices and Expert Tips

- **Database Compatibility**: Ensure you use Feather v2 databases (`*.genes_vs_motifs.rankings.feather`). Older formats are deprecated in versions 0.12.0+.
- **Input Formats**: While CSV/TSV are supported, Loom and AnnData (.h5ad) are preferred for large-scale single-cell data to manage memory efficiently.
- **Parallelization**: 
    - By default, pySCENIC uses custom multiprocessing. 
    - For multi-node clusters, leverage the Dask framework.
    - In the `ctx` step, use `--mode "dask_multiprocessing"` for optimal performance on a single machine with multiple cores.
- **Memory Management**: If encountering memory errors during the GRN step, ensure the input expression matrix is processed as a sparse matrix and use the `--sparse` flag.
- **TF Lists**: Use a curated list of transcription factors specific to the species (e.g., Human, Mouse, or Fruit Fly) being analyzed.

## Reference documentation

- [pySCENIC GitHub Repository](./references/github_com_aertslab_pySCENIC.md)
- [pySCENIC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyscenic_overview.md)