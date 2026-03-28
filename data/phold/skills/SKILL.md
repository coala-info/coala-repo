---
name: phold
description: phold uses protein language models and structural alignment to annotate phage genomes and characterize hypothetical proteins. Use when user asks to annotate phage proteins using structural homology, predict 3Di tokens from amino acid sequences, or identify functional "dark matter" in metagenomic data.
homepage: https://github.com/gbouras13/phold
---


# phold

## Overview
`phold` is a specialized bioinformatics tool designed to bridge the gap in phage genome annotation where sequence-based homology (like BLAST or HMMs) fails. It leverages the ProstT5 protein language model to convert amino acid sequences into 3Di structural tokens, which are then searched against a massive database of over 1.3 million phage protein structures using Foldseek. This structural approach is significantly more sensitive for characterizing "dark matter" in metagenomic phage data.

## Core Workflows

### 1. Database Management
Before running annotations, the structural database must be installed.
- **Standard Install**: `phold install`
- **Extended Database**: `phold install --extended_db` (Includes ~3.1M structures, useful for viral discovery but slower for functional annotation).

### 2. Primary Annotation (The 'Run' Command)
The `run` command is the standard end-to-end pipeline.
- **From Pharokka Output**: `phold run -i pharokka.gbk -o output_dir -t 8`
- **Annotate Hypotheticals Only**: `phold run -i input.gbk --hyps -o output_dir` (Saves time by only processing proteins previously labeled as hypothetical).
- **GPU Acceleration**: Use `--foldseek_gpu` to speed up the Foldseek prefilter on NVIDIA hardware.

### 3. Structural Prediction & Comparison
If you already have structures or only need specific parts of the pipeline:
- **Predict 3Di only**: `phold predict -i proteins.faa -o output_dir`
- **Compare structures**: `phold compare -i input.gbk --structure_dir ./my_pdbs/ -o output_dir`
- **Proteins-only prediction**: `phold proteins-predict -i proteins.faa -o output_dir`

### 4. Optimization & Performance
- **Batch Size**: Use `phold autotune` to detect the optimal `--batch_size` for your specific CPU/GPU hardware.
- **Sensitivity**: Use `--ultra_sensitive` to disable Foldseek prefiltering (recommended for single genomes or small datasets).
- **Masking**: By default, `phold` masks residues with a ProstT5 confidence score below 25. Adjust this with `--mask_threshold`.

## Expert Tips
- **Integrated Pipeline**: For maximum annotation rates, combine `pharokka` (sequence-based), `phold` (structure-based), and `phynteny` (synteny-based).
- **Input Validation**: Ensure FASTA/GenBank headers do not contain colons (":"), as `phold` uses this character as an internal delimiter.
- **Confidence Heuristics**: Pay attention to the high, medium, and low confidence labels in the output; prioritize "low" hits for manual curation.
- **Restarting Jobs**: For large comparative runs that get interrupted, use the `--restart` parameter.



## Subcommands

| Command | Description |
|---------|-------------|
| phold autotune | Determines optimal batch size for 3Di prediction with your hardware |
| phold compare | Runs Foldseek vs phold db |
| phold_createdb | Creates foldseek DB from AA FASTA and 3Di FASTA input files |
| phold_install | Installs ProstT5 model and phold database |
| phold_plot | Creates Phold Circular Genome Plots |
| phold_proteins-compare | Runs Foldseek vs phold db on proteins input |
| phold_proteins-predict | Runs ProstT5 on a multiFASTA input - GPU recommended |
| phold_run | phold predict then comapare all in one - GPU recommended |
| predict | Uses ProstT5 to predict 3Di tokens - GPU recommended |
| remote | Uses Foldseek API to run ProstT5 then Foldseek locally |

## Reference documentation
- [phold GitHub README](./references/github_com_gbouras13_phold_blob_main_README.md)
- [phold Version History and CLI Changes](./references/github_com_gbouras13_phold_blob_main_HISTORY.md)
- [phold Contributing and Setup](./references/github_com_gbouras13_phold_blob_main_CONTRIBUTING.md)