---
name: unicore
description: Unicore performs high-throughput phylogenetic inference by utilizing protein structural information and 3Di alphabets to reconstruct evolutionary relationships. Use when user asks to infer phylogenetic trees from protein structures, identify structural core genes across taxa, or convert amino acid sequences into structural databases.
homepage: https://github.com/steineggerlab/unicore
metadata:
  docker_image: "quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0"
---

# unicore

## Overview
Unicore is a specialized tool for high-throughput phylogenetic inference that utilizes protein structural information rather than just primary sequences. By converting amino acid sequences into 3Di structural alphabets using ProstT5 and Foldseek, it identifies "structural core genes" shared across taxa to reconstruct evolutionary relationships. This approach is particularly effective for divergent species where sequence identity is low but structural architecture remains conserved.

## Core Workflow: easy-core
The `easy-core` module is the recommended entry point. It automates the entire pipeline from raw FASTA files to a final Newick tree.

```bash
# Basic usage
unicore easy-core <INPUT_DIR> <OUTPUT_DIR> <PROSTT5_WEIGHTS> <TMP_DIR>

# With GPU acceleration (highly recommended for ProstT5)
unicore easy-core --gpu <INPUT_DIR> <OUTPUT_DIR> <PROSTT5_WEIGHTS> <TMP_DIR>
```

### Input Requirements
- **Format**: Proteomes must be in `.fasta` format.
- **Structure**: Place all proteome files (e.g., `Species1.fasta`, `Species2.fasta`) into a single input directory.

## Modular Operations
For fine-grained control, Unicore can be run in discrete steps:

1. **createdb**: Generates the 3Di structural alphabet database.
   ```bash
   unicore createdb <INPUT_DIR> <DB_PATH> <PROSTT5_WEIGHTS>
   ```
2. **cluster**: Performs Foldseek clustering on the database.
   ```bash
   unicore cluster <DB_PATH> <CLUSTER_OUT> <TMP_DIR>
   ```
   *Tip: Use `--cluster-options "-c 0.8"` to adjust bidirectional coverage (default is 0.8).*
3. **profile**: Identifies core genes based on taxonomic presence.
   ```bash
   unicore profile <DB_PATH> <CLUSTER_OUT> -t 0.8
   ```
   *Tip: The `-t` flag sets the threshold for genes present in a percentage of species (default 0.8).*
4. **tree**: Infers the phylogenetic tree from identified core genes.
   ```bash
   unicore tree <PROFILE_DIR> <TREE_OUT>
   ```

## Expert Tips and Best Practices
- **GPU Acceleration**: ProstT5 prediction is computationally intensive. Always use the `--gpu` flag if an NVIDIA GPU (Turing or newer) is available.
- **Weight Management**: Download ProstT5 weights once before running workflows to save time:
  `foldseek databases ProstT5 weights tmp`
- **Resource Allocation**: For multi-GPU systems, use the environment variable `CUDA_VISIBLE_DEVICES=0,1` to specify which cards Unicore should utilize.
- **Output Interpretation**:
  - `tree/iqtree.treefile`: The final concatenated structural core gene tree in Newick format.
  - `tree/fasta/`: Contains subfolders for each core gene with both amino acid (`aa.fasta`) and 3Di (`3di.fasta`) representations.
- **Handling Large Datasets**: If the number of taxa is very high, consider increasing the `-t` threshold in the `profile` module to focus on a more strictly conserved set of core genes, which can speed up the `tree` inference stage.



## Subcommands

| Command | Description |
|---------|-------------|
| unicore cluster | Cluster Foldseek database |
| unicore createdb | Create Foldseek database from amino acid sequences |
| unicore easy-core | Easy core gene phylogeny workflow, from fasta files to phylogenetic tree |
| unicore gene-tree | Infer phylogenetic tree of each core structures |
| unicore profile | Create core structures from Foldseek database |
| unicore tree | Infer phylogenetic tree from core structures |
| unicore_config | Runtime environment configuration |
| unicore_search | Search Foldseek database against reference database |

## Reference documentation
- [Unicore GitHub Repository](./references/github_com_steineggerlab_unicore.md)
- [Unicore README](./references/github_com_steineggerlab_unicore_blob_main_README.md)