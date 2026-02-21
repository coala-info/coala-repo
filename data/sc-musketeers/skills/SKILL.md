---
name: sc-musketeers
description: sc-musketeers is a deep learning framework designed for single-cell atlas reconstruction.
homepage: https://sc-musketeers.readthedocs.io/
---

# sc-musketeers

## Overview
sc-musketeers is a deep learning framework designed for single-cell atlas reconstruction. It utilizes a tri-partite architecture consisting of an autoencoder for noise reduction, a classifier with focal loss to handle rare cell populations, and an adversarial domain adaptation (DANN) module to mitigate batch effects. This skill provides the necessary command-line patterns to perform cell type label transfers and data integration.

## Command Line Usage
The core functionality is accessed via the `sc-musketeers transfer` command.

### 1. Annotating Unlabeled Cells
Use this pattern to predict labels for cells marked as "Unknown" or "unlabeled" within a single dataset:

`sc-musketeers transfer <atlas_path> --class_key <celltype_column> --batch_key <donor_column> --unlabeled_category <Unknown>`

### 2. Reference-to-Query Label Transfer
Use this pattern to project annotations from a labeled reference dataset onto an unlabeled query dataset while reducing batch effects:

`sc-musketeers transfer <reference_path> --query_path <query_path> --class_key <celltype_column> --batch_key <donor_column> --unlabeled_category <Unknown>`

## Best Practices and Expert Tips
- **Rare Cell Detection**: Because sc-musketeers uses focal loss, it is specifically optimized for datasets with high class imbalance. It is the preferred tool when the identification of small, rare cell populations is a priority.
- **Batch Key Selection**: The `--batch_key` is critical for the DANN module. Ensure this points to the metadata column representing the source of technical variation (e.g., "donor", "batch", "sequencing_run").
- **Spatial Mapping**: To transfer labels from scRNA-seq to spatial transcriptomics, treat the scRNA-seq data as the reference and the spatial data as the query.
- **Installation**: If the tool is missing, it can be installed via conda (`conda install bioconda::sc-musketeers`) or pip (`pip install sc-musketeers`).

## Reference documentation
- [scMusketeers Home](./references/sc-musketeers_readthedocs_io_en_latest.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sc-musketeers_overview.md)