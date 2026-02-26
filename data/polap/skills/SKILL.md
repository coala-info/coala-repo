---
name: polap
description: Polap is a bioinformatics pipeline designed to assemble plant mitochondrial genomes from long-read sequencing data. Use when user asks to assemble plant mitochondrial genomes, fetch SRA data for organelle assembly, or polish long-read assemblies with short-read data.
homepage: https://github.com/goshng/polap
---


# polap

## Overview
Polap (Plant Organelle Long-read Assembly Pipeline) is a specialized bioinformatics tool designed to reconstruct plant mitochondrial genomes. It streamlines the process of isolating organelle-specific sequences from whole-genome datasets by combining the Flye long-read assembler with gene annotation-guided contig selection. This approach ensures that the resulting assembly is focused on the mitochondrial genome rather than nuclear or plastid contaminants.

## Installation and Environment Setup
Polap is primarily distributed via Bioconda and requires a Linux environment.

- **Conda Installation**:
  ```bash
  conda create -n polap polap=0.3.7.3
  conda activate polap
  ```
- **Polishing Environment**: Polishing requires a secondary environment. After activating the main `polap` environment, run:
  ```bash
  # For v0.3.x
  base_dir=$(dirname "$(command -v polap)")
  conda env create -f $base_dir/polap-conda-environment-fmlrc.yaml
  ```

## Core CLI Usage

### 1. Data Preparation
Polap expects specific filenames for its automated assembly workflows. If you have your own data, rename them as follows:
- `s1.fq`: Illumina paired-end read 1
- `s2.fq`: Illumina paired-end read 2
- `l.fq`: Long-read FASTQ (Nanopore/PacBio)

### 2. Fetching Public Data
You can download SRA data directly using the built-in utility:
```bash
polap x-ncbi-fetch-sra --sra SRR30757341
```

### 3. Assembly Workflow
The primary command for assembly uses the pre-named files in the current directory:
```bash
polap assemble --polap-reads
```
- **Test Run**: To verify the pipeline with a small dataset: `polap assemble --test`
- **Output**: The main assembly graph is typically produced as `2-oga.gfa`.

### 4. Polishing Workflow
Polishing improves the accuracy of the long-read assembly using short-read data.
```bash
# Step 1: Prepare the polishing environment and indices
polap prepare-polishing

# Step 2: Execute the polishing
polap polish
```

## Expert Tips and Best Practices
- **OS Compatibility**: Polap is strictly compatible with Linux. Do not attempt to run it on macOS or Windows (even via WSL may have issues with specific dependencies).
- **Version Consistency**: The developer currently recommends version `0.3.7.3` for the most stable performance in mitochondrial assembly.
- **Graph Inspection**: Use Bandage to visualize the `2-oga.gfa` file. This allows you to manually inspect the connectivity of the mitochondrial genome and identify potential circularity.
- **Memory Requirements**: While mitochondrial assembly is less resource-intensive than whole-genome assembly, ensure you have at least 16GB-32GB of RAM for standard plant datasets to accommodate the Flye assembler and FMLRC polishing steps.

## Reference documentation
- [Polap GitHub Repository](./references/github_com_goshng_polap.md)
- [Bioconda Polap Overview](./references/anaconda_org_channels_bioconda_packages_polap_overview.md)