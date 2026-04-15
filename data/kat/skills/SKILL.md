---
name: kat
description: KAT analyzes the k-mer content of sequencing reads and genomic assemblies to perform quality control and assembly validation. Use when user asks to estimate genome size, validate an assembly by comparing k-mer spectra, analyze GC content, or filter sequences based on k-mer frequency.
homepage: https://github.com/TGAC/KAT
metadata:
  docker_image: "quay.io/biocontainers/kat:2.4.2--py39he0b6574_5"
---

# kat

## Overview

KAT (The K-mer Analysis Toolkit) is a specialized suite of tools designed to analyze the k-mer content of raw sequencing reads and genomic assemblies. It is primarily used for quality control, genome size estimation, and assembly validation. By comparing the k-mer spectra of reads against an assembly, KAT can identify issues such as collapsed repeats, missing genomic content, or over-represented sequences. It works directly with FASTA/FASTQ files or pre-computed Jellyfish hashes.

## Core Workflows and CLI Patterns

### 1. Generating K-mer Histograms
Use the `hist` tool to create a frequency distribution of k-mers. This is the first step in estimating genome size and heterozygosity.
```bash
kat hist -o <output_prefix> <input.fastq>
```
*   **Tip**: The output includes metadata that makes the resulting files ready for the `kat plot spectra-hist` command.

### 2. Comparing Datasets (Assembly Validation)
The `comp` tool is the most powerful feature for assembly QC. It creates a 2D matrix of shared k-mers between two files (typically raw reads and a draft assembly).
```bash
kat comp -o <output_prefix> <reads.jf> <assembly.fa>
```
*   **Spectra-CN Plotting**: After running `comp`, use `kat plot spectra-cn` to visualize the "copy number" spectra. This helps identify if k-mers present in the reads are missing from the assembly (0x peak) or if they appear the correct number of times.

### 3. GC Content Analysis
Use `gcp` to analyze the relationship between GC content and k-mer frequency. This is useful for detecting contamination or separating organelle DNA from nuclear DNA.
```bash
kat gcp -o <output_prefix> <input.fastq>
```

### 4. Sequence Coverage Estimation
The `sect` tool estimates the coverage of each sequence in a file using k-mers from another source.
```bash
kat sect -o <output_prefix> <reads.jf> <sequences.fa>
```

### 5. Filtering Reads and Hashes
KAT provides tools to clean data based on k-mer properties:
*   **kmer**: Filter a hash to keep only k-mers within specific coverage or GC ranges.
*   **seq**: Filter a FASTA/FASTQ file based on whether sequences contain k-mers present in a specific hash.

## Visualization Tools
KAT includes several plotting sub-commands that require a functional Python environment (with matplotlib and scipy).
*   `kat plot density`: For 2D comparison matrices.
*   `kat plot spectra-cn`: For assembly copy number analysis.
*   `kat plot spectra-hist`: For comparing multiple k-mer histograms.
*   `kat plot profile`: For k-mer coverage along a specific sequence (using `sect` output).

## Expert Tips
*   **Jellyfish Integration**: KAT uses Jellyfish under the hood. If you have extremely large datasets, you can pre-compute Jellyfish hashes (`.jf` files) to speed up multiple KAT runs.
*   **Gzipped Inputs**: KAT supports gzipped files via process substitution (e.g., `<(zcat reads.fastq.gz)`), though recent versions may handle compressed input more natively depending on the build.
*   **Memory Management**: K-mer counting is memory-intensive. Ensure your system has enough RAM to hold the k-mer hash, or use the `-m` flag (if available in the specific sub-tool) to limit memory usage.
*   **Interpreting Spectra-CN**: A large peak at 0x in a `spectra-cn` plot indicates significant portions of the sequencing reads are not represented in your assembly.



## Subcommands

| Command | Description |
|---------|-------------|
| kat cold | COntig Length and Duplication analysis tool |
| kat comp | Compares jellyfish K-mer count hashes. |
| kat filter | Filtering tools |
| kat gcp | Compares GC content and K-mer coverage from the input. |
| kat plot | Create K-mer Plots |
| kat sect | Estimates coverage levels across sequences in the provided input sequence file. |
| kat_hist | Create an histogram of k-mer occurrences from the input. |

## Reference documentation
- [KAT - The K-mer Analysis Toolkit](./references/github_com_EarlhamInst_KAT_blob_master_README.md)
- [KAT Changelog and Version History](./references/github_com_EarlhamInst_KAT_blob_master_NEWS.md)