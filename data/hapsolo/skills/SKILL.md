---
name: hapsolo
description: HapSolo identifies and removes redundant alternative haplotypes from diploid genome assemblies using a hill-climbing optimization algorithm to maximize completeness. Use when user asks to remove secondary haplotigs, streamline diploid assemblies, or optimize assembly completeness based on BUSCO scores.
homepage: https://github.com/esolares/HapSolo
---


# hapsolo

## Overview

HapSolo is a tool designed to streamline diploid genome assemblies by identifying and removing redundant alternative haplotypes. It employs a hill-climbing optimization algorithm to select a subset of contigs that maximizes assembly completeness (based on BUSCO scores) while minimizing unnecessary duplication. Use this tool after initial assembly but before Hi-C scaffolding to ensure the scaffolding process is not confounded by secondary haplotigs.

## Installation and Environment

HapSolo is sensitive to its environment, particularly regarding BUSCO versions.

- **Recommended Method**: Use the Singularity image to avoid dependency conflicts between BUSCO and Augustus.
  ```bash
  singularity pull --arch amd64 library://esolares/default/hapsolo_busco3:0.01
  ```
- **Conda Installation**:
  ```bash
  conda install bioconda::hapsolo
  ```
- **Python Version**: While Python 3 is supported, Python 2.7 is recommended by the developers for faster execution. Ensure the `pandas` package is installed.
- **Critical Dependency**: Use **BUSCO v3**. Newer versions of BUSCO may lead to misclassification of orthologs within the HapSolo workflow.

## Core Workflow

### 1. Preprocessing the FASTA
Before running the optimization, clean the assembly and split it into individual contigs. This step removes special characters from headers that cause failures in BUSCO or MUMmer.

```bash
preprocessfasta.py -i CONTIGASSEMBLY.fasta -m 10000000
```
- `-i`: Input FASTA file.
- `-m`: Max contig size in Mb (default is 10Mb).

### 2. Generating Required Inputs
HapSolo requires two primary data sources to evaluate contigs:
- **BUSCO Results**: Run BUSCO v3 on the contigs. The tool expects a directory containing individual BUSCO outputs for each contig.
- **Alignment File**: Generate a Blat alignment file in PSL format (can be gzipped).

### 3. Running HapSolo
Execute the main optimization script using the preprocessed assembly, the PSL alignment, and the BUSCO results directory.

```bash
# Example execution via Singularity
singularity exec instance://hapsolo hapsolo.py [arguments]
```

## Expert Tips and Best Practices

- **Header Consistency**: Always use `preprocessfasta.py`. It ensures that the FASTA headers match across your alignment files and BUSCO results, preventing "mismatching contig sets" errors.
- **Augustus Config**: If using Singularity, you must mount the Augustus 3.2.2 config directory to the instance. Set your `HOSTDIR` to your current working directory and mount it to a `MOUNTDIR` (e.g., `/data`) within the container.
- **Memory Management**: For large assemblies, ensure your environment has sufficient RAM for the Pandas-based processing of alignment strings.
- **Troubleshooting**: If you encounter an error stating "HapSolo has two separate set of contigs," it usually indicates a mismatch between the IDs in your BUSCO directory and the IDs in your PSL file. Re-run the preprocessing and ensure all downstream tools use the exact same cleaned FASTA.

## Reference documentation

- [HapSolo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hapsolo_overview.md)
- [HapSolo GitHub Repository](./references/github_com_esolares_HapSolo.md)