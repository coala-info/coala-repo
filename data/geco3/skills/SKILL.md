---
name: geco3
description: GeCo3 is a specialized tool designed for high-ratio DNA sequence compression using a neural network architecture. Use when user asks to compress genomic sequences, perform referential compression using a template genome, or decompress files created by GeCo3.
homepage: https://github.com/cobilab/geco3
metadata:
  docker_image: "quay.io/biocontainers/geco3:1.0--h7b50bb2_5"
---

# geco3

## Overview
GeCo3 is a specialized tool designed for high-ratio DNA sequence compression. It employs a neural network to manage a "mixing of experts" architecture, allowing it to adapt to the specific statistical properties of genomic data. It supports standalone compression of a single file or referential compression, where a target genome is compressed using a related reference genome to achieve significantly higher compression ratios.

## Installation and Setup
GeCo3 is available via Bioconda or can be built from source.

**Conda Installation:**
```bash
conda install -y -c bioconda geco3
```

**Source Build:**
```bash
cd src && make
```
*Note: GeCo3 uses micro-architecture dependent vector instructions. For successful decompression, the `GeDe3` binary must be compiled in the same environment as the `GeCo3` binary used for compression.*

## Command Line Usage

### Reference-Free Compression
Use this mode when you do not have a related genome to use as a template.

```bash
# Basic compression (Level 1, Learning Rate 0.06, 8 Hidden Nodes)
./GeCo3 -l 1 -lr 0.06 -hs 8 input_dna_file

# Decompression
./GeDe3 input_dna_file.co
```

### Referential Compression
Use this mode to compress a target genome (e.g., a specific human individual) using a reference genome (e.g., the human reference assembly).

```bash
# Compression using a reference file
./GeCo3 -rm 20:500:1:35:0.95/3:100:0.95 -lr 0.03 -hs 64 -r reference_file target_file

# Decompression (Reference file must be present)
./GeDe3 -r reference_file target_file.co
```

### Key Parameters
- `-l [int]`: Compression level.
- `-lr [float]`: Learning rate for the neural network mixer.
- `-hs [int]`: Number of hidden nodes in the neural network.
- `-r [file]`: Path to the reference DNA file.
- `-rm [string]`: Referential model parameters (formatted as `length:threshold:etc`).
- `-h`: Display help and full parameter descriptions.

## Expert Tips
- **Environment Consistency**: Always ensure that the decompression environment matches the compression environment. Differences in floating-point accuracy (e.g., FMA instructions) between different CPUs or compiler versions can lead to decompression failures.
- **Parameter Tuning**: For referential compression, the `-rm` string is highly configurable. If compression ratios are suboptimal, adjust the model parameters based on the evolutionary distance between the reference and the target.
- **Memory Management**: Increasing hidden nodes (`-hs`) improves compression but increases memory usage and processing time.



## Subcommands

| Command | Description |
|---------|-------------|
| ./GeCo3 | efficient compression and analysis of genomic sequences. |
| ./GeDe3 | Decompress genomic sequences for compressed by GeCo3. |

## Reference documentation
- [GeCo3 GitHub Repository](./references/github_com_cobilab_geco3.md)
- [GeCo3 README](./references/github_com_cobilab_geco3_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_geco3_overview.md)