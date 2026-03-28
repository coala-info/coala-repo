---
name: hapsolo
description: HapSolo is an optimization tool designed to refine diploid genome assemblies by identifying and removing redundant haplotigs. Use when user asks to remove assembly redundancies, maximize single-copy orthologs, or optimize diploid genome assemblies using BUSCO scores.
homepage: https://github.com/esolares/HapSolo
---


# hapsolo

## Overview
HapSolo is an optimization tool designed to refine diploid genome assemblies by identifying and removing redundant haplotigs. In diploid organisms, assemblers often fail to collapse allelic regions, leading to an assembly size larger than the expected haploid genome and a high percentage of "duplicated" BUSCO genes. HapSolo uses a hill-climbing (gradient descent) or random walk approach to select a subset of contigs that maximizes the presence of single-copy orthologs while minimizing duplicates and fragments.

## Installation and Environment
The tool is compatible with Python 2.7 (faster) and Python 3. It requires the `pandas` library.

**Singularity (Recommended):**
```bash
singularity pull library://esolares/default/hapsolo_busco3:0.01
# Run commands by prefixing: singularity exec instance://hapsolo <command>
```

**Conda Setup:**
```bash
conda create --name HapSolo python=2.7
conda activate HapSolo
conda install -c anaconda pandas
```

## Workflow and CLI Usage

### 1. Preprocessing the FASTA
Before running the main optimization, clean the headers and split the assembly into individual contigs. This step is required for the subsequent BUSCO analysis.

```bash
preprocessfasta.py -i assembly.fasta -m 10000000
```
*   `-i`: Input FASTA file.
*   `-m`: Max contig size in Mb (default 10Mb).
*   **Output**: Creates a `contigs/` directory with individual files.

### 2. Generating Required Inputs
HapSolo requires two primary inputs alongside the FASTA:
1.  **Self-Alignment File**: A PSL (BLAT) or PAF (Minimap2) file representing the assembly aligned against itself.
2.  **BUSCO Results**: A directory containing the BUSCO output for every individual contig generated in the preprocessing step.

### 3. Running HapSolo Optimization
Execute the optimization script to generate a reduced assembly candidate.

```bash
hapsolo.py -i cleaned_assembly.fasta --psl alignment.psl -b ./busco_results_dir/ [OPTIONS]
```

**Key Arguments:**
*   `-i`: The preprocessed assembly FASTA.
*   `-p` or `--psl`: Path to the BLAT PSL file.
*   `-a` or `--paf`: Path to the Minimap2 PAF file (experimental).
*   `-b`: Directory containing the per-contig BUSCO results.

**Optimization Parameters:**
*   `-n`: Number of iterations per gradient descent (default: 1000).
*   `-t`: Number of threads (multiplies total iterations).
*   `-B`: Number of best candidate assemblies to return (default: 1).
*   `--mode`: Run mode (0: Random walking, 1: No optimization, 2: Optimized walking).

**Scoring Weights (Thetas):**
Adjust these to prioritize different BUSCO metrics in the cost function:
*   `-S` (Single): Default 1.0
*   `-D` (Duplicate): Default 1.0
*   `-M` (Missing): Default 1.0
*   `-F` (Fragmented): Default 0.0

## Expert Tips
*   **Header Consistency**: Ensure that the FASTA headers in your alignment file and BUSCO results exactly match the headers in the preprocessed FASTA. `preprocessfasta.py` removes special characters to prevent tool crashes.
*   **Performance**: While Python 3 is supported, Python 2.7 is significantly faster for the heavy iterations performed during the optimization phase.
*   **Memory Management**: For very large assemblies, ensure your system has enough RAM to load the alignment file into a pandas DataFrame.
*   **Instance Management**: If using Singularity, remember to stop the instance when finished: `singularity instance stop hapsolo`.



## Subcommands

| Command | Description |
|---------|-------------|
| hapsolo.py | Process alignments and BUSCO"s for selecting reduced assembly candidates |
| preprocessfasta.py | Preprocess FASTA file and outputs a clean FASTA and seperates contigs based on unique headers. Removes special chars |

## Reference documentation
- [HapSolo GitHub README](./references/github_com_esolares_HapSolo_blob_main_README.md)
- [HapSolo Main Script Documentation](./references/github_com_esolares_HapSolo_blob_main_hapsolo.py.md)
- [Preprocess Fasta Documentation](./references/github_com_esolares_HapSolo_blob_main_preprocessfasta.py.md)