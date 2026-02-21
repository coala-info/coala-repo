---
name: orthofinder
description: OrthoFinder is a high-accuracy phylogenetic tool designed to automate the inference of orthologous gene groups (orthogroups) from protein sequences.
homepage: https://github.com/OrthoFinder/OrthoFinder
---

# orthofinder

## Overview
OrthoFinder is a high-accuracy phylogenetic tool designed to automate the inference of orthologous gene groups (orthogroups) from protein sequences. It streamlines the complex workflow of sequence searching, clustering, gene tree inference, and species tree reconciliation. Use this skill to guide the setup, execution, and optimization of OrthoFinder runs, whether dealing with a few genomes or scaling to thousands of species.

## Core Workflows

### 1. Data Preparation
OrthoFinder requires one FASTA file per species in a single input directory. Each file should contain the complete proteome with a single representative protein sequence per gene.
- **Transcript Selection**: If your data contains multiple isoforms, use the provided utility script to select the longest variant:
  ```bash
  for f in *.fa; do python primary_transcript.py $f; done
  ```

### 2. Standard Execution
The most common entry point is running the full pipeline on a directory of proteomes.
- **Basic Run**: `orthofinder -f <input_directory>`
- **Using MSA**: For higher accuracy in tree inference (default in v3+), ensure the Multiple Sequence Alignment (MSA) method is active:
  ```bash
  orthofinder -f <input_directory> -M msa
  ```

### 3. Scaling to Large Datasets (>100 Species)
To handle massive datasets efficiently, use the "Core/Assign" workflow to avoid the N^2 complexity of all-vs-all searches.
1. **Run Core**: Select ~64 diverse species and run:
   ```bash
   orthofinder -f <core_species_dir> -M msa
   ```
2. **Assign Remaining**: Add the rest of the species to the core results:
   ```bash
   orthofinder --assign <additional_species_dir> --core <results_dir_from_step_1>
   ```

## Command Line Optimization

### Performance Tuning
- **Search Threads (`-t`)**: Controls parallel sequence searches (e.g., DIAMOND/BLAST). Set to the number of available CPU cores.
- **Analysis Threads (`-a`)**: Controls parallel tree inference. OrthoFinder defaults to `t/8` or 16; increase this if you have high memory and many cores.

### Method Selection
- **Search Program (`-s`)**: `diamond` (default, fast), `blast` (sensitive but slow), or `mmseqs`.
- **Tree Inference (`-T`)**: `fasttree` (default), `raxml`, or `iqtree`.
- **Inflation (`-I`)**: Adjust the MCL inflation parameter (default 1.2). Higher values result in smaller, more tightly clustered orthogroups.

### Workflow Control
- **Stop after search**: `-op` (useful for preparing files to run on a cluster).
- **Restart from search results**: `-b <directory_of_blast_results>`.
- **DNA Input**: Use `-d` if providing DNA sequences instead of proteins (OrthoFinder will translate them).

## Expert Tips
- **Result Directory**: Use `-n <name>` to append a specific string to the results folder, making it easier to track different parameter trials.
- **Rooted Trees**: OrthoFinder automatically infers the rooted species tree. If you have a known, high-confidence species tree, provide it using `-s <tree_file>` to improve ortholog inference.
- **Output Changes**: In version 3.1.2+, `N0.tsv` has been removed. Use `Orthogroups/Orthogroups.tsv` for the primary orthogroup assignments.

## Reference documentation
- [OrthoFinder GitHub Repository](./references/github_com_OrthoFinder_OrthoFinder.md)
- [Bioconda OrthoFinder Overview](./references/anaconda_org_channels_bioconda_packages_orthofinder_overview.md)