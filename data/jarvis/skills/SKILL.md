---
name: jarvis
description: JARVIS is a specialized tool designed for the reference-free lossless compression and decompression of DNA sequences. Use when user asks to compress genomic sequences, decompress .jc files, or estimate sequence entropy.
homepage: https://github.com/cobilab/jarvis
metadata:
  docker_image: "quay.io/biocontainers/jarvis:1.1--h7b50bb2_6"
---

# jarvis

## Overview
JARVIS (Genomic Assembler with Reference-free Variation Information Storage) is a specialized tool designed for the lossless compression of DNA sequences. It operates without the need for a reference genome, instead utilizing a competitive prediction architecture that combines weighted stochastic repeat models and weighted context models. This approach allows it to achieve high compression gains, particularly on complex genomic data, by balancing compressibility against available RAM and processing time.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda jarvis
```

## Core CLI Usage

### Basic Compression
To compress a genomic sequence file, use the `-l` flag to specify a compression level (1-12).
```bash
JARVIS -v -l 3 input_sequence.seq
```
*   **-v**: Enables verbose mode to track progress.
*   **-l [NUMBER]**: Sets the compression level. Default is 1. Higher levels provide better compression but require significantly more RAM and time.

### Decompression
To restore the original sequence from a `.jc` file:
```bash
JARVIS -v -d input_sequence.seq.jc
```
*   **-d**: Triggers decompression mode.

### Managing Compression Levels
View the pre-configured compression levels to understand the resource trade-offs:
```bash
JARVIS -s
```

## Advanced Model Configuration
For expert users, JARVIS allows manual tuning of its underlying models instead of using preset levels.

### Context Models (-cm)
Used to define the parameters for regular and substitutional tolerant context models.
Template: `-cm [NB_C]:[NB_D]:[NB_I]:[NB_G]/[NB_S]:[NB_E]:[NB_I]:[NB_A]`
*   **NB_C**: Order size (1-20). Higher values improve compression but increase RAM usage.
*   **NB_S**: Maximum editions for substitutional tolerance. Use values >= 14 to handle high-substitution genomic regions effectively.
*   **NB_I**: Set to 1 to enable inverted repeat sub-programs (increases time, not RAM).

### Repeat Models (-rm)
Used to define parameters for the stochastic repeat model class.
Template: `-rm [NB_R]:[NB_C]:[NB_A]:[NB_B]:[NB_L]:[NB_G]:[NB_I]`
*   **NB_R**: Maximum number of repeat models. Increase this for highly repetitive sequences to improve compression at the cost of RAM.

## Best Practices
*   **Resource Planning**: JARVIS is more resource-intensive than its predecessors (GeCo/GeCo2). Always monitor RAM usage when using levels above 5.
*   **File Overwriting**: Use the `-F` or `--force` flag if you need to overwrite existing output files.
*   **Entropy Measurement**: JARVIS provides an upper bound of the sequence entropy during the compression process, which can be used for comparative genomic analysis.

## Reference documentation
- [JARVIS GitHub Repository](./references/github_com_cobilab_jarvis.md)
- [Bioconda JARVIS Overview](./references/anaconda_org_channels_bioconda_packages_jarvis_overview.md)