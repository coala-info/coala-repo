---
name: pyscenic
description: pySCENIC is a Python implementation of the SCENIC pipeline used to infer gene regulatory networks and score their activity in single-cell RNA-seq data. Use when user asks to infer transcription factor regulons, prune co-expression modules using motif enrichment, or calculate cellular activity scores for regulatory networks.
homepage: https://github.com/aertslab/pySCENIC
---


# pyscenic

## Overview

pySCENIC is a high-performance Python implementation of the Single-Cell rEgulatory Network Inference and Clustering (SCENIC) pipeline. It is designed to identify stable gene regulatory networks (regulons) and score their activity in individual cells. Use this skill to navigate the command-line interface (CLI) for processing large-scale scRNA-seq datasets, moving from a gene expression matrix to a regulon-based cellular representation.

## Core Workflow

The pySCENIC pipeline consists of three primary stages executed via the CLI.

### 1. Gene Regulatory Network Inference (GRN)
Infers co-expression modules between transcription factors (TFs) and potential target genes.

```bash
pyscenic grn [EXPRESSION_MTX] [TF_LIST] -o adjacencies.tsv --method grnboost2
```
- **Input**: A gene expression matrix (e.g., `.loom`, `.h5ad`, or `.csv`) and a list of TFs.
- **Method**: `grnboost2` is the default and recommended lightning-fast algorithm.
- **Tip**: For very large datasets, ensure you are using the multiprocessing version which is now the default in recent versions.

### 2. Regulon Prediction (ctx)
Prunes co-expression modules by identifying enriched transcription factor motifs to retain only direct targets.

```bash
pyscenic ctx adjacencies.tsv [MOTIF_DB] \
    --annotations_fname [MOTIF_ANNOTATIONS] \
    --expression_mtx_fname [EXPRESSION_MTX] \
    --mode "expression_masking" \
    --output regulons.csv
```
- **Databases**: Requires Feather v2 format databases (`*.genes_vs_motifs.rankings.feather`).
- **Annotations**: Requires a motif-to-TF annotation file.
- **Output**: A CSV file containing the inferred regulons and their target genes.

### 3. Cellular Scoring (AUCell)
Scores the activity of the inferred regulons in each individual cell.

```bash
pyscenic aucell [EXPRESSION_MTX] regulons.csv -o auc_output.loom
```
- **Output**: A `.loom` or `.h5ad` file containing the Area Under the Curve (AUC) scores for each regulon per cell.
- **Usage**: These scores can be used for downstream clustering and visualization (e.g., t-SNE/UMAP) to identify cell states based on regulatory activity.

## Expert Tips and Best Practices

- **Database Compatibility**: Only use Feather v2 databases. Older formats are deprecated and may cause errors with modern `pyarrow` versions.
- **Memory Management**: pySCENIC uses `ravel` instead of `flatten` in the AUCell step to avoid unnecessary memory copies, which is critical when handling datasets with hundreds of thousands of cells.
- **Parallelization**: While `dask` was previously the primary engine, recent versions prefer custom multiprocessing. Use the `--num_workers` flag to scale across CPU cores.
- **Input Formats**: When using `.loom` files, ensure the gene attributes and cell attributes are correctly named (typically `Gene` and `CellID`).
- **Masking**: Use the `--mode "expression_masking"` in the `ctx` step to improve the specificity of the regulon discovery by filtering out genes not expressed in the dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| grn | Infer gene regulatory networks |
| pyscenic add_cor | Add correlation information to GRN adjacencies. |
| pyscenic_aucell | Calculate AUC for each cell and each gene signature. |
| pyscenic_ctx | Enrich motifs in modules and generate regulons. |

## Reference documentation
- [pySCENIC GitHub Repository](./references/github_com_aertslab_pySCENIC.md)
- [pySCENIC README](./references/github_com_aertslab_pySCENIC_blob_master_README.rst.md)
- [SCENIC Suite Overview](./references/scenic_aertslab_org_index.md)