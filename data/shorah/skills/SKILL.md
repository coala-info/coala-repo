---
name: shorah
description: ShoRAH is a bioinformatics suite designed to characterize genetic diversity and reconstruct haplotypes from heterogeneous mixtures or viral quasi-species. Use when user asks to analyze shotgun or amplicon sequencing data, perform error correction on aligned reads, or call single nucleotide variants in complex samples.
homepage: https://github.com/cbg-ethz/shorah
---


# shorah

## Overview
ShoRAH is a specialized bioinformatics software suite designed to characterize the genetic diversity within a single sample. Unlike standard variant callers that assume diploidy or haploidy, ShoRAH is built for "quasi-species" or heterogeneous mixtures where multiple related genetic variants coexist. It processes aligned reads (BAM files) to correct sequencing errors and reconstruct the underlying haplotypes, making it particularly effective for studying viral evolution and low-frequency mutations.

## Core Workflows

### 1. Shotgun Sequencing Analysis
For standard shotgun genomic data, use the `shotgun` command. This performs window-based analysis to reconstruct local haplotypes.
- **Basic Command**: `shorah shotgun -b input_sorted.bam -f reference.fasta`
- **Key Input**: Requires a coordinate-sorted BAM file and the corresponding reference FASTA.
- **Process**: The tool automatically splits the alignment into overlapping windows, performs error correction using `diri_sampler`, and calls SNVs.

### 2. Amplicon Sequencing Analysis
For data generated via targeted PCR amplification (amplicons), use the `amplicon` command.
- **Basic Command**: `shorah amplicon -b input_sorted.bam -f reference.fasta`
- **Usage**: This mode is optimized for the specific error profiles and coverage patterns found in amplicon-based deep sequencing.

### 3. Single Nucleotide Variant (SNV) Calling
ShoRAH includes a specific tool for SNV detection that accounts for strand bias, which is a common source of false positives in NGS.
- **Tool**: `shorah snv`
- **Feature**: It uses a strand bias test (`fil`) to ensure that variants are supported by reads in both directions.

## Tool-Specific Best Practices

- **Input Preparation**: Always ensure your BAM file is sorted and indexed. ShoRAH relies on HTSlib for efficient file access.
- **Local vs. Global Reconstruction**: In ShoRAH2 (v1.99+), global haplotype reconstruction is disabled. Focus on local analysis for high-confidence variant calling. For global reconstruction, the developers recommend using the V-pipe pipeline.
- **Windowing**: The `b2w` tool is used internally to split shotgun data into overlapping windows. If manual intervention is needed, ensure windows overlap sufficiently to allow for consistent haplotype linking.
- **Error Correction**: The `diri_sampler` component uses Gibbs sampling. For very high coverage or complex regions, compilation with multiple threads (e.g., `make -j4`) during installation is recommended to handle the computational load.
- **Strand Bias**: If you encounter high false-positive rates, verify the `fil` (strand bias test) parameters to ensure variants are not artifacts of the sequencing process.

## Common CLI Components

| Tool | Function |
| :--- | :--- |
| `shorah` | Main wrapper for shotgun and amplicon workflows. |
| `b2w` | Splits shotgun BAM files into overlapping windows. |
| `diri_sampler` | Performs Gibbs sampling for error correction. |
| `shorah snv` | Detects single nucleotide variants with strand bias filtering. |
| `fil` | Standalone tool for the strand bias test. |



## Subcommands

| Command | Description |
|---------|-------------|
| shorah | Call SNVs from amplicon sequencing data |
| shotgun | Call SNVs from shotgun sequencing data. |
| snv | Call SNVs from BAM files. |

## Reference documentation
- [ShoRAH GitHub Repository](./references/github_com_cbg-ethz_shorah.md)
- [Bioconda ShoRAH Package](./references/anaconda_org_channels_bioconda_packages_shorah_overview.md)