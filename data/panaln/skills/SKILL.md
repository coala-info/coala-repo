---
name: panaln
description: Panaln maps sequencing reads to a pangenome index created from a reference genome and variant data to improve alignment accuracy. Use when user asks to generate a pangenome from FASTA and VCF files, construct a pangenome index, or align FASTQ reads to a pangenome.
homepage: https://github.com/Lilu-guo/Panaln
metadata:
  docker_image: "quay.io/biocontainers/panaln:2.09--h5ca1c30_0"
---

# panaln

## Overview
Panaln is a bioinformatics tool designed to improve read mapping accuracy by utilizing a pangenome index rather than a single linear reference. By integrating known genomic variations from VCF files into the index, Panaln allows for better alignment of reads that contain non-reference alleles. The tool operates through a three-stage pipeline: combining reference and variant data, constructing a Burrows-Wheeler Transform (BWT) based index, and performing the final alignment.

## Installation and Setup
Before using the tool, it must be compiled in a specific order to link the required FM-index and Wavefront Alignment (WFA) libraries.

```bash
# 1. Compile FM library
cd panaln/FM/
make

# 2. Compile semiWFA library
cd ../semiWFA/
make

# 3. Compile Panaln
cd ../
make
```

## Core Workflow

### 1. Generate Pangenome (.pan)
Combine a standard reference FASTA with a VCF file to create the pangenome representation.
```bash
./panaln combine -s <ref.fasta> -v <input.vcf> -b <basename> [options]
```
*   **-s**: Absolute path to the reference genome (Required).
*   **-v**: Absolute path to the VCF file containing variants (Required).
*   **-b**: Basename for the generated output files (Required).
*   **-c**: Context size (Optional, default: 150). Adjust this based on your expected read lengths.

### 2. Construct Index
Build the index from the generated `.pan` file. This step is required before alignment can occur.
```bash
./panaln index -p <input.pan>
```
*   **-p**: Absolute path to the `.pan` file generated in the previous step.

### 3. Read Alignment
Map sequencing reads to the pangenome index to produce a SAM file.
```bash
./panaln align -x <index_basename> -f <input.fastq> -s <output.sam>
```
*   **-x**: Absolute path to the index basename (the path used in the index step).
*   **-f**: Absolute path to the input FASTQ file (Required).
*   **-s**: Absolute path for the output SAM file (Required).

## Expert Tips and Best Practices
*   **Absolute Paths**: Panaln requires absolute paths for all file specifications. Using relative paths often leads to file-not-found errors during the indexing or alignment phases.
*   **Memory Management**: Pangenome indexing is memory-intensive. Ensure your environment has sufficient RAM, especially when working with large reference genomes like HG38.
*   **Context Size**: The `-c` parameter in the `combine` step defines the flanking sequence length around variants. If you are working with long-read data (e.g., PacBio CCS), consider increasing the context size beyond the default 150.
*   **Library Dependencies**: If alignment fails immediately, verify that `fm.a` was correctly copied into the root directory during the `make` process, as the Makefile depends on this for the final executable.



## Subcommands

| Command | Description |
|---------|-------------|
| panaln align | Align fastq sequences using panaln |
| panaln combine | Generate Pangenome by combining FASTA and VCF files |
| panaln index | Index a pan-genome file |

## Reference documentation
- [Panaln README](./references/github_com_Lilu-guo_Panaln_blob_master_README.md)
- [Panaln Repository Overview](./references/github_com_Lilu-guo_Panaln.md)