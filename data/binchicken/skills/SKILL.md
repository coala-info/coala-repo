---
name: binchicken
description: Binchicken recovers low-abundance genomes from metagenomic samples through targeted coassembly of shared marker genes. Use when user asks to recover genomes from low-abundance organisms, perform targeted coassembly, run iterative recovery workflows, or target specific taxa in metagenomic datasets.
homepage: https://github.com/aroneys/binchicken
---

# binchicken

## Overview

Bin Chicken is a specialized metagenomic tool designed to recover genomes from low-abundance organisms that typically fail to assemble in single-sample analyses. It works by identifying sets of samples that share identical sequence windows of single-copy marker genes. By strategically coassembling these specific samples, the tool increases the effective coverage of "elusive" lineages to the ~10X threshold required for successful binning. It integrates with SingleM for marker gene discovery and Aviary for the actual assembly and binning workflows.

## Environment Setup

Before running analysis, ensure the required databases and subprocess environments are initialized.

- **Initialize environments**: Run `binchicken build` to create the necessary conda environments.
- **Configure databases**: Provide paths to SingleM metapackages, CheckM2, and GTDB-Tk databases.
- **Manual Database Download**: If CheckM2 auto-download fails, download the database from Zenodo and point to it using `--checkm2-db` or the `CHECKM2DB` environment variable.
- **System Limits**: If you encounter "Too many open files" errors, increase the limit using `ulimit -n 10000`.

## Core Workflows

### 1. Single-Sample Discovery and Co-binning
Use this to perform initial assembly on individual samples while using other samples for differential abundance binning.

```bash
binchicken single \
  --forward-list samples_forward.txt \
  --reverse-list samples_reverse.txt \
  --run-aviary \
  --cores 64 \
  --output binchicken_single_assembly
```

### 2. Targeted Coassembly
Use this to cluster samples based on shared novel marker genes to recover genomes not found in the single-sample run.

```bash
binchicken coassemble \
  --forward reads_1.1.fq reads_2.1.fq \
  --reverse reads_1.2.fq reads_2.2.fq \
  --genomes reference_mags.fna \
  --run-aviary \
  --output binchicken_coassembly
```

### 3. Iterative Recovery
Use this to find even more genomes by excluding marker genes already accounted for in previous rounds.

```bash
binchicken iterate \
  --coassemble-output binchicken_single_assembly \
  --run-aviary \
  --cores 64 \
  --output binchicken_iteration_1
```

## Expert Tips and Best Practices

- **Taxonomic Targeting**: To focus on a specific group (e.g., Planctomycetota), use `--taxa-of-interest "p__Planctomycetota"`. This filters the marker gene database to only consider sequences from that taxon.
- **Memory Management**: For datasets with >1000 samples, use `--kmer-precluster always` to prevent combinatorial explosions during sample clustering.
- **SRA Integration**: Use the `--sra` flag and provide SRA Run IDs (e.g., SRR...) as the forward read arguments to have Bin Chicken handle the data download and QC automatically.
- **Assembly Strategy**: The default `--assembly-strategy dynamic` attempts metaSPAdes first and falls back to MEGAHIT if resources are exceeded. Use `--assembly-strategy megahit` directly for very large or complex coassemblies to save time.
- **Unmapped Reads**: Use `--assemble-unmapped` to map reads against existing genomes and only assemble the remaining reads. This reduces assembly complexity and computational cost.
- **Cluster Submission**: When running on an HPC, use `--snakemake-profile` and `--cluster-submission` to allow Bin Chicken to submit individual assembly and recovery tasks as separate cluster jobs.



## Subcommands

| Command | Description |
|---------|-------------|
| binchen_build | Create dependency environments |
| binchicken | Evaluate binchicken results |
| binchicken | A command-line tool for binning chicken genomes. |
| binchicken coassemble | Perform co-assembly of multiple samples. |
| binchicken iterate | Iterate through binning and assembly strategies. |
| binchicken single | Perform single-sample assembly and binning |
| binchicken update | Update binchicken's databases and configurations. |

## Reference documentation
- [Bin Chicken Tools Overview](./references/aroneys_github_io_binchicken_tools.md)
- [Coassemble Command Reference](./references/aroneys_github_io_binchicken_tools_coassemble.md)
- [Iterate Command Reference](./references/aroneys_github_io_binchicken_tools_iterate.md)
- [Environment Setup Guide](./references/aroneys_github_io_binchicken_setup.md)
- [General Usage and Memory Tips](./references/aroneys_github_io_binchicken_usage.md)