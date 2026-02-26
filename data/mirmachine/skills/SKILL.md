---
name: mirmachine
description: MirMachine identifies miRNA homologs in genomic FASTA files using covariance models. Use when user asks to identify miRNA homologs, search for specific miRNA families, or list available taxonomic nodes and families.
homepage: https://github.com/sinanugur/MirMachine
---


# mirmachine

## Overview

MirMachine is a command-line tool designed to identify miRNA homologs within genomic FASTA files. It utilizes specialized covariance models to scan sequences and predict miRNA locations, providing structured output in GFF and FASTA formats. This skill enables the execution of homology searches, taxonomic node exploration, and result filtering for high-confidence miRNA annotations.

## Installation and Setup

The recommended way to install MirMachine is via Conda or Mamba to ensure all dependencies (like Infernal) are correctly managed.

```bash
conda install mirmachine -c bioconda -c conda-forge
```

## Common CLI Patterns

### 1. Exploration and Discovery
Before running a search, identify the available taxonomic nodes and miRNA families supported by the current version.

*   **List all available taxonomic nodes:**
    `MirMachine.py --print-all-nodes`
*   **List all supported miRNA families:**
    `MirMachine.py --print-all-families`
*   **Visualize the taxonomic tree:**
    `MirMachine.py --print-ascii-tree`

### 2. Standard Homology Search
To run a search, you must provide a taxonomic node, a species name for the output, and the path to the genome FASTA.

```bash
MirMachine.py --node <node_name> --species <species_name> --genome <path_to_fasta> --cpu <threads>
```

**Example:**
```bash
MirMachine.py -n Caenorhabditis -s Caenorhabditis_elegans --genome genomes/ce11.fa --cpu 20 --model proto
```

### 3. Targeted Family Search
If you are only interested in a specific miRNA family (e.g., Let-7), use the `--family` flag.

```bash
MirMachine.py --species <species_name> --genome <path_to_fasta> --family Let-7
```

### 4. Job Management
*   **Dry Run:** Use `--dry` to validate the command and check for required files without executing the search.
*   **Rescue Stalled Jobs:** If a run was interrupted, use `--unlock` to clear the working state.
*   **Cleanup:** Use `--remove` to delete output files from a previous run (does not affect input files).

## Expert Tips and Best Practices

*   **Output Selection:** MirMachine generates several files in `results/predictions/`. Always prioritize the files in `filtered_gff/` for downstream analysis, as these contain high-confidence predictions after bitscore filtering.
*   **Model Selection:** The `--model` argument defaults to `combined`. Use `proto` or `deutero` if your research specifically targets protostomes or deuterostomes to potentially refine the search space.
*   **E-value Tuning:** The default inclusion E-value is `0.2`. If you are getting too many low-quality hits, decrease this value (e.g., `0.01`). To increase sensitivity at the cost of specificity, increase it.
*   **Taxonomic Precision:** Use the most specific node possible for your genome to reduce computation time and false positives. Use `--single-node-only` if you want to restrict the search strictly to the provided node without traversing the tree.

## Reference documentation
- [MirMachine GitHub Repository](./references/github_com_sinanugur_MirMachine.md)
- [MirMachine Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mirmachine_overview.md)