---
name: baktfold
description: Baktfold is a specialized annotation tool designed to provide functional insights into proteins that traditional sequence-based tools (like Bakta or Prokka) often fail to characterize.
homepage: https://github.com/gbouras13/baktfold
---

# baktfold

## Overview
Baktfold is a specialized annotation tool designed to provide functional insights into proteins that traditional sequence-based tools (like Bakta or Prokka) often fail to characterize. It works by converting protein amino acid sequences into a 3Di token alphabet using the ProstT5 language model, then performing sensitive structural searches using Foldseek. This approach allows for the identification of remote homologs that are structurally similar but sequence-divergent.

Use this skill when:
- You have "hypothetical protein" outputs from Bakta that require further characterization.
- You need to annotate protein sequences (.faa) using structural homology rather than just sequence identity.
- You are working with novel bacterial genomes or MAGs where standard databases are insufficient.

## Installation and Database Setup
Baktfold requires a specific database and the Foldseek dependency.

```bash
# Recommended installation via Conda
conda create -n baktfoldENV -c conda-forge -c bioconda baktfold

# Install GPU-compatible version (highly recommended for ProstT5 performance)
conda create -n baktfoldENV -c conda-forge -c bioconda baktfold pytorch=*=cuda*

# Download and format the required databases
baktfold install -d baktfold_db -t 8
```

## Common CLI Patterns

### 1. Annotating Bakta Outputs (Recommended)
The most common workflow is to use a Bakta `.json` file as input. Baktfold will extract hypothetical proteins, annotate them, and merge the results back into Bakta-compliant formats.

```bash
# Standard run (CPU or non-NVIDIA GPU)
baktfold run -i bakta_output/assembly.json -o baktfold_results -d baktfold_db -t 8

# Accelerated run (NVIDIA GPU)
baktfold run -i bakta_output/assembly.json -o baktfold_results -d baktfold_db -t 8 --foldseek-gpu
```

### 2. Annotating Protein FASTA Files
If you have a collection of protein sequences not associated with a Bakta run, use the `proteins` command.

```bash
baktfold proteins -i hypotheticals.faa -o protein_annotations -d baktfold_db -t 8
```

### 3. Modular Execution
For large datasets or specific hardware constraints (e.g., running prediction on a GPU node and comparison on a CPU node), you can split the workflow:

```bash
# Step 1: Predict 3Di tokens from sequences
baktfold predict -i assembly.json -o prediction_out -d baktfold_db

# Step 2: Compare predicted structures against databases
baktfold compare -i prediction_out/3di_sequences.fasta -o final_out -d baktfold_db
```

## Expert Tips and Best Practices
- **GPU Acceleration**: The ProstT5 step is significantly faster on a GPU. If running on a cluster, ensure `pytorch` is configured with CUDA support.
- **Custom Databases**: You can search against your own structural databases using the `--custom-db` flag.
- **Memory Management**: For large MAG datasets, use `baktfold autotune` to determine the optimal batch size for your specific hardware.
- **Input Formats**: While Baktfold primarily targets Bakta JSON, it also supports Bakta Genbank formats. Always prefer the JSON input for the most metadata-rich output.

## Reference documentation
- [Baktfold GitHub Repository](./references/github_com_gbouras13_baktfold.md)
- [Bioconda Baktfold Package](./references/anaconda_org_channels_bioconda_packages_baktfold_overview.md)