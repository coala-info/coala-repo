---
name: tribal
description: TRIBAL is a phylogenetic tool that infers B cell clonal lineages by simultaneously accounting for DNA sequence mutations and antibody isotype transitions. Use when user asks to preprocess single-cell BCR sequencing data, fit B cell lineage trees, or perform lineage tree inference for multiple clonotypes.
homepage: https://github.com/elkebir-group/TRIBAL
metadata:
  docker_image: "quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1"
---

# tribal

## Overview
TRIBAL (Tree Inference of B cell Clonal Lineages) is a phylogenetic tool designed to handle the unique complexities of B cell evolution. Unlike standard phylogenetic methods, it simultaneously accounts for DNA sequence mutations and the biological transitions between different antibody isotypes. Use this skill to guide the preparation of single-cell BCR data, execute the preprocessing pipeline, and perform lineage tree inference for multiple clonotypes.

## Input Requirements
TRIBAL requires two primary CSV files. Ensure your data is pre-clustered into clonotypes (descendants of the same naive B cell) before starting.

### 1. Sequencing Data (`data.csv`)
Required columns:
- `cellid`: Unique identifier or barcode for each B cell.
- `clonotype`: The ID of the cluster the cell belongs to.
- `heavy_chain_isotype`: The constant region isotype (e.g., IGHM, IGHG1).
- `heavy_chain_seq`: The variable region sequence.
- `heavy_chain_allele`: The V-gene allele.
- `light_chain_seq` / `light_chain_allele`: Optional, but recommended for higher resolution.

### 2. Germline Roots (`roots.csv`)
Required columns:
- `clonotype`: Matches the ID in the sequencing data.
- `heavy_chain_root`: The inferred germline (naive) sequence for that clonotype.
- `light_chain_root`: Optional germline sequence for the light chain.

## CLI Usage and Best Practices

### Installation and Verification
Install via bioconda for the most stable environment:
```bash
conda create -n tribal -c bioconda tribal
conda activate tribal
tribal --help
```

### Preprocessing Workflow
Before running the main inference, you must preprocess the data to generate multiple sequence alignments (MSA) and initial parsimony forests.
- Ensure `dnapars` is installed and in your PATH.
- If using the light chain, ensure the `use_light_chain` flag is set to `True` in your configuration or command arguments.
- TRIBAL uses `mafft` for alignments; ensure your sequences are cleaned of non-nucleotide characters.

### Execution Tips
- **Clonotype Grouping**: TRIBAL processes data by clonotype. If you have a very large dataset, ensure your clonotype definitions are robust (tools like Dandelion are recommended for this).
- **Isotype Transitions**: The tool outputs an isotype transition probability matrix. Review this matrix to ensure the biological transitions (e.g., M -> G) align with expected B cell biology for your specific sample.
- **Output Interpretation**: The output is a forest of trees. Each node represents a BCR sequence and an isotype state. Use the `LineageTree` class within the Python API if you need to perform custom programmatic analysis on the resulting topologies.



## Subcommands

| Command | Description |
|---------|-------------|
| tribal fit | Fit B cell lineage trees |
| tribal_preprocess | Preprocesses sequencing data for tribal analysis. |

## Reference documentation
- [TRIBAL GitHub README](./references/github_com_elkebir-group_TRIBAL_blob_main_README.md)
- [Input Data Examples](./references/github_com_elkebir-group_TRIBAL_blob_main_example_data.csv.md)
- [Germline Root Requirements](./references/github_com_elkebir-group_TRIBAL_blob_main_example_roots.csv.md)