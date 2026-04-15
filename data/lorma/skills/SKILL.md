---
name: lorma
description: LoRMA improves the accuracy of long-read sequencing data using iterative LoRDEC steps and a self-correction algorithm based on multiple alignments. Use when user asks to correct long-read sequences, run the lorma.sh wrapper script, or configure k-mer sizes for read error correction.
homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/
metadata:
  docker_image: "quay.io/biocontainers/lorma:0.4--2"
---

# lorma

## Overview
LoRMA is a specialized tool designed to improve the accuracy of long-read sequencing data. It employs a hybrid approach: first, it uses LoRDEC iteratively with increasing k-mer sizes to perform initial corrections, and then it applies a unique self-correction algorithm based on multiple alignments and de Bruijn graphs. This skill helps you navigate the installation requirements, the primary `lorma.sh` wrapper script, and the underlying `LoRMA` executable parameters.

## Installation and Setup
LoRMA requires a Linux X86_64 environment, GCC (4.5+), and CMake. It depends on the GATB library (included) and LoRDEC (version 0.6+ recommended).

1.  **Compile**:
    ```bash
    mkdir build; cd build; cmake ..; make
    ```
2.  **Configure**: You must edit the `LORDECDIR` variable within the `lorma.sh` script to point to your local LoRDEC installation directory before running the pipeline.

## Recommended Workflow: lorma.sh
The `lorma.sh` script is the standard entry point. It automates the multi-step process of running LoRDEC, trimming/splitting reads, and finally executing the LoRMA correction.

### Basic Usage
```bash
lorma.sh [parameters] <input.fasta>
```

### Key Parameters
- `-start <int>`: Initial k-mer size for the first LoRDEC step (default: 19).
- `-end <int>`: Maximum k-mer size for LoRDEC iterations (default: 61).
- `-step <int>`: The increment value for k between LoRDEC steps (default: 21).
- `-k <int>`: The k-mer size used specifically for the final LoRMA self-correction phase (default: 19).
- `-threads <int>`: Number of threads. **Caution**: LoRMA has high memory consumption per thread.
- `-s`: Use this flag to save intermediate sequence data from LoRDEC steps for debugging or manual inspection.

## Advanced LoRMA Executable Usage
While `lorma.sh` is preferred, the `LoRMA` binary can be called directly for the final correction phase if you have already pre-processed your reads.

```bash
LoRMA -reads <input.fasta> -output <corrected.fasta> -discarded <low_quality.fasta> [options]
```

### Expert Tips
- **Memory Management**: If the process crashes or the system becomes unresponsive, reduce the `-threads` count. The multiple alignment phase is memory-intensive.
- **Friend Selection**: The `-friends` parameter (default: 7) controls the number of reads used in multiple alignments. Increasing this may improve accuracy but significantly increases computational cost.
- **LoRDEC Mode**: For optimal results, ensure LoRDEC is running in "strict mode" (available in LoRDEC 0.6 and later).



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/lorma_lorma.sh | Processes FASTA files with LoRDEC steps. |
| lorma_LoRMA | LoRMA options |

## Reference documentation
- [LoRMA README](./references/www_cs_helsinki_fi_u_lmsalmel_LoRMA_README.txt.md)
- [LoRMA Overview](./references/www_cs_helsinki_fi_u_lmsalmel_LoRMA.md)