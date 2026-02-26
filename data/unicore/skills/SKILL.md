---
name: unicore
description: Unicore is a phylogenetic tool that reconstructs evolutionary relationships by identifying structural core genes. Use when user asks to build a phylogenetic tree, identify core genes, create a structural protein database, cluster protein sequences, or generate structure-aware alignments.
homepage: https://github.com/steineggerlab/unicore
---


# unicore

## Overview

Unicore is a specialized phylogenetic tool that reconstructs evolutionary relationships by identifying "structural core genes." It moves beyond traditional sequence-based methods by using the ProstT5 protein language model to predict structural features (3Di structural alphabets) and Foldseek for efficient clustering. This approach is particularly robust for divergent species where primary sequences have drifted significantly but protein structures remain conserved. The tool provides both an automated end-to-end workflow and modular components for fine-grained control over database creation, clustering, and tree inference.

## Installation and Setup

Install via Bioconda:
```bash
conda install -c bioconda unicore
```

Before running the workflow, you must download the ProstT5 weights required for structural prediction:
```bash
foldseek databases ProstT5 weights_dir tmp_dir
```

## Core Workflows

### The Automated Pipeline
The `easy-core` module handles the entire process from raw proteomes to a final Newick tree.

```bash
unicore easy-core <INPUT_DIR> <OUTPUT_DIR> <WEIGHTS_PATH> <TMP_DIR>
```
*   **Input**: A directory containing proteome files in `.fasta` format.
*   **Output**: Includes the final tree (`tree/iqtree.treefile`), clusters, and identified core genes.

### GPU Acceleration
Structural prediction with ProstT5 is computationally intensive. Use the `--gpu` flag to significantly speed up the `easy-core` or `createdb` modules.

```bash
unicore easy-core --gpu data/ results/ weights/ tmp/
```
To specify specific GPUs, use the environment variable:
```bash
CUDA_VISIBLE_DEVICES=0,1 unicore easy-core --gpu data/ results/ weights/ tmp/
```

## Modular Usage and Best Practices

### 1. Database Creation (`createdb`)
Converts amino acid sequences into 3Di structural alphabets.
```bash
unicore createdb <DATA_DIR> <DB_PATH> <WEIGHTS_PATH>
```

### 2. Clustering (`cluster`)
Groups sequences into families. By default, it uses 80% bidirectional coverage.
*   **Customizing Sensitivity**: Use `--cluster-options` to pass specific parameters to the underlying Foldseek engine.
```bash
unicore cluster <DB_PATH> <OUT_DIR> <TMP_DIR> --cluster-options "-c 0.9 --min-seq-id 0.3"
```

### 3. Core Gene Identification (`profile`)
Defines which clusters are "core" based on their prevalence across the input taxa.
*   **Thresholding**: Use `-t` to set the percentage of species a gene must be present in to be considered "core" (default is 80%).
```bash
unicore profile -t 90 <DB_PATH> <CLUSTER_TSV> <RESULT_DIR>
```

### 4. Tree Inference (`tree`)
Generates alignments and builds the phylogeny.
*   **Alignment**: Uses `foldmason` for structure-aware alignment.
*   **Inference**: Uses `iqtree` by default.
*   **Alignment Only**: If you want the core gene alignments but wish to use a different tree builder manually, use the `--no-inference` flag.
```bash
unicore tree --no-inference <DB_PATH> <PROFILE_RESULT> <TREE_DIR>
```

## Expert Tips

*   **Memory Management**: For very large datasets, ensure the `<TMP_DIR>` is located on a fast disk (SSD) with ample space, as Foldseek generates significant intermediate data.
*   **Input Formatting**: Ensure proteome files are named clearly, as these filenames are used as the leaf labels in the resulting Newick tree.
*   **Low Core Gene Warnings**: If a species has a low core gene recovery rate, it may be due to poor assembly quality or extreme divergence. Check the `profile/` output to identify if specific taxa are outliers before finalizing the tree.

## Reference documentation
- [Unicore GitHub Repository](./references/github_com_steineggerlab_unicore.md)
- [Unicore Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_unicore_overview.md)