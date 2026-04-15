---
name: lightassembler
description: LightAssembler is a memory-efficient genome assembly tool that generates contigs from sequencing reads using a dual Bloom filter architecture. Use when user asks to assemble contigs, perform genome assembly in resource-constrained environments, or filter sequencing errors during the assembly process.
homepage: https://github.com/SaraEl-Metwally/LightAssembler
metadata:
  docker_image: "quay.io/biocontainers/lightassembler:1.0--h077b44d_8"
---

# lightassembler

## Overview
LightAssembler is a specialized tool designed for resource-constrained environments. It utilizes a dual cache-oblivious Bloom filter architecture to sample k-mers and filter out likely sequencing errors. This makes it an ideal choice for researchers who need to generate contigs without access to high-performance computing clusters. It performs graph traversal and simplification to produce a set of assembled contigs while maintaining a very small memory footprint.

## Installation and Setup
The tool can be installed via Bioconda or compiled from source for specific k-mer sizes.

- **Conda**: `conda install bioconda::lightassembler`
- **Source**: 
  - For k <= 31: `make`
  - For k > 31: `make k=49` (replace 49 with your desired k-mer length)

## Command Line Usage
The basic syntax for running an assembly is:
`./LightAssembler -k [kmer] -g [gap] -e [error_rate] -G [genome_size] -t [threads] -o [prefix] [input_files]`

### Core Parameters
- `-k`: K-mer size (default: 31).
- `-g`: Gap size. If omitted, the tool extrapolates this based on coverage and error rate.
- `-e`: Error rate (default: 0.01).
- `-G`: Estimated genome size (required for accurate statistics).
- `-t`: Number of threads for parallel processing.
- `-o`: Prefix for the output files (e.g., `my_assembly`).
- `--verbose`: Highly recommended to see Bloom filter false positive rates and assembly statistics.

### Input and Output
- **Inputs**: Supports multiple FASTA or FASTQ files. Can read `.gz` compressed files directly.
- **Outputs**: The primary output is `[prefix].contigs.fasta`.

## Expert Tips and Best Practices
- **Memory Optimization**: If you encounter high false positive rates in the Bloom filters (visible with `--verbose`), consider increasing the k-mer size or ensuring the estimated genome size `-G` is accurate.
- **Gap Size Selection**: While the tool can extrapolate `-g`, manual tuning can improve contiguity. Common defaults based on coverage:
  - 25X: `-g 3`
  - 35X: `-g 4`
  - 75X: `-g 8`
  - 140X: `-g 15`
- **Hardware Limitations**: Note that this version has a maximum read length limit of 1024 bp and supports a maximum of 100 input files.
- **K-mer Length**: If you need to use a k-mer size larger than 31, you must recompile the tool using the `make k=VALUE` command, as the binary is optimized for specific bit-widths.

## Reference documentation
- [LightAssembler GitHub Repository](./references/github_com_SaraEl-Metwally_LightAssembler.md)
- [Bioconda LightAssembler Overview](./references/anaconda_org_channels_bioconda_packages_lightassembler_overview.md)