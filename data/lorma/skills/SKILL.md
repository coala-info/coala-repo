---
name: lorma
description: LoRMA (Long Read Multiple Alignment) is a specialized tool designed to improve the accuracy of long-read sequencing data.
homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/
---

# lorma

## Overview
LoRMA (Long Read Multiple Alignment) is a specialized tool designed to improve the accuracy of long-read sequencing data. It employs a hybrid approach that combines iterative de Bruijn graph-based correction (via LoRDEC) with multiple sequence alignment to produce high-quality corrected reads. This skill provides the necessary command-line patterns and parameter configurations to execute the correction pipeline effectively.

## Installation and Setup
LoRMA is available via Bioconda or source compilation.
- **Conda**: `conda install bioconda::lorma`
- **Source**: Requires GCC 4.5+ and CMake. Build using `mkdir build; cd build; cmake ..; make`.
- **Dependency**: Ensure LoRDEC (version 0.6+ for strict mode) is installed and the `LORDECDIR` variable in `lorma.sh` is updated to point to the LoRDEC installation path.

## Usage Patterns

### Standard Pipeline (Recommended)
The `lorma.sh` script is the primary entry point. It automates the iterative LoRDEC steps, trimming, splitting, and the final LoRMA alignment phase.

```bash
lorma.sh [parameters] reads.fasta
```

### Key Parameters for lorma.sh
- `-start`: Initial k-mer size for LoRDEC (default: 19).
- `-end`: Maximum k-mer size for LoRDEC (default: 61).
- `-step`: Increment value for k between LoRDEC iterations (default: 21).
- `-k`: K-mer size specifically for the final LoRMA phase (default: 19).
- `-threads`: Number of threads for the LoRMA phase (default: 6).
- `-n`: Skip the LoRDEC iterations if reads are already pre-corrected.
- `-s`: Save intermediate sequence data from LoRDEC steps.

### Direct LoRMA Execution
Use the binary directly only if you have already processed reads and wish to run the alignment-based correction specifically.

```bash
LoRMA -reads input.fasta -output corrected.fasta -discarded rejected.fasta [options]
```

### Optimization and Best Practices
- **Memory Management**: LoRMA consumes significant memory per thread. Monitor system resources closely when increasing the `-threads` or `-nb-cores` parameters.
- **LoRDEC Integration**: For optimal results, ensure LoRDEC is run in "strict mode."
- **Friend Selection**: The `-friends` parameter (default: 7) controls the number of reads used in multiple alignments. Increasing this can improve accuracy but significantly increases computational cost.

## Reference documentation
- [LoRMA README](./references/www_cs_helsinki_fi_u_lmsalmel_LoRMA_README.txt.md)
- [LoRMA Homepage](./references/www_cs_helsinki_fi_u_lmsalmel_LoRMA.md)