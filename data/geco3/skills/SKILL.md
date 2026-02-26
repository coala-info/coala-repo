---
name: geco3
description: GeCo3 is a DNA sequence compression tool that uses neural networks to mix prediction models for high compression ratios. Use when user asks to compress DNA sequences, decompress .co files, or perform referential compression using a template sequence.
homepage: https://github.com/cobilab/geco3
---


# geco3

## Overview
GeCo3 is a specialized tool designed for DNA sequence compression. It leverages neural networks to mix different prediction models ("experts"), achieving high compression ratios. It supports standalone compression of a single sequence or referential compression where one sequence is used as a template to compress another. The tool consists of two primary binaries: `GeCo3` for compression and `GeDe3` for decompression.

## Installation
The most reliable way to install GeCo3 is via Bioconda:
```bash
conda install -c bioconda geco3
```

## Command Line Usage

### Reference-free Compression
Use this mode when you want to compress a DNA sequence without using an external reference file.

```bash
# Compress a file using level 1, learning rate 0.06, and 8 hidden nodes
GeCo3 -l 1 -lr 0.06 -hs 8 <input_file>

# Decompress the resulting .co file
GeDe3 <input_file>.co
```

### Referential Compression
Use this mode when you have a similar reference sequence (e.g., a different individual of the same species) to achieve significantly higher compression ratios.

```bash
# Compress target_file using reference_file
GeCo3 -rm 20:500:1:35:0.95/3:100:0.95 -rm 13:200:1:1:0.95/0:0:0 -rm 10:10:0:0:0.95/0:0:0 -lr 0.03 -hs 64 -r <reference_file> <target_file>

# Decompress using the same reference
GeDe3 -r <reference_file> <target_file>.co
```

## Expert Tips and Best Practices

### Environment Consistency
**Critical**: GeCo3 is highly sensitive to floating-point accuracy. Due to the use of micro-architecture dependent instructions (like Fused Multiply-Add), a file compressed on one machine or with one compiler version may fail to decompress on another.
- Always decompress using the exact same binary and environment used for compression.
- If moving data between systems, ensure the `GeDe3` binary is compiled with the same flags and on a similar CPU architecture.

### Parameter Tuning
- **Learning Rate (`-lr`)**: Adjusts how quickly the neural network adapts to the sequence patterns.
- **Hidden Nodes (`-hs`)**: Increasing the number of hidden nodes can improve compression ratios for complex sequences but increases memory usage and processing time.
- **Levels (`-l`)**: Use the `-l` flag for quick access to predefined complexity levels.

### Documentation Access
For a full list of parameters and model configurations, invoke the help command for either binary:
```bash
GeCo3 -h
GeDe3 -h
```

## Reference documentation
- [github_com_cobilab_geco3.md](./references/github_com_cobilab_geco3.md)
- [anaconda_org_channels_bioconda_packages_geco3_overview.md](./references/anaconda_org_channels_bioconda_packages_geco3_overview.md)