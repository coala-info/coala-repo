---
name: jarvis3
description: JARVIS3 is a high-efficiency encoder specifically optimized for genomic data.
homepage: https://github.com/cobilab/jarvis3
---

# jarvis3

## Overview
JARVIS3 is a high-efficiency encoder specifically optimized for genomic data. It transforms biological sequences into a compressed format using a combination of context models and neural networks. Beyond simple storage reduction, the tool can be used to establish an upper bound for sequence complexity by estimating the information content of a given sample.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::jarvis3
```

## Core Workflows

### Compressing Sequences
To compress a genomic sequence, provide the input file as the final argument. The default compression level is 7.
```bash
JARVIS3 -v -l 7 sequence.fasta
```
*   **Output**: Creates a `.jc` file by default.
*   **Levels**: Range from 1 (fastest) to 40 (highest compression). Use higher levels for archival storage where RAM and time are less constrained.

### Decompressing Sequences
Use the `-d` flag to restore the original sequence from a `.jc` file.
```bash
JARVIS3 -d -v sequence.fasta.jc -o restored_sequence.fasta
```

### Estimating Information Content
To measure sequence complexity without full compression, use the estimate mode.
```bash
JARVIS3 -e sequence.fastq
```
*   **Output**: Creates a `.iae` file containing information content metrics.
*   **Note**: For FASTA/FASTQ inputs, the tool specifically targets the "ACGT" genomic characters.

## Command Line Options

| Flag | Description |
| :--- | :--- |
| `-l [1-40]` | Sets the compression level. Default is 7. |
| `-s` | Shows the pre-computed parameters for each compression level. |
| `-o [FILE]` | Specifies a custom output filename. |
| `-v` | Enables verbose mode for detailed execution logs. |
| `-p` | Displays a progress bar during processing. |
| `-f` | Force mode; overwrites existing output files. |
| `-x` | Provides an explanation of the underlying context and repeat models. |

## Expert Tips
*   **Level Selection**: Use `JARVIS3 -s` to see the model parameters (Context Models `-cm` and Repeat Models `-rm`) associated with each level. This helps in understanding the trade-off between computational resources and compression gains.
*   **Neural Network Control**: Levels 14 through 23 typically turn off the Neural Network (`-lr 0`) to focus on specific context models, which can be faster for certain sequence types.
*   **Memory Management**: Higher levels (30+) significantly increase RAM usage due to larger hidden sizes in the neural network and more complex context models. Ensure the environment has sufficient memory before initiating high-level compression.

## Reference documentation
- [JARVIS3 GitHub Repository](./references/github_com_cobilab_jarvis3.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_jarvis3_overview.md)