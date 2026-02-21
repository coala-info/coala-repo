---
name: bwise
description: BWISE (de Bruijn assembly Workflow using Integral information of Short paired-End reads) is a specialized assembler designed to maximize the utility of paired-end information.
homepage: https://github.com/Malfoy/BWISE
---

# bwise

## Overview
BWISE (de Bruijn assembly Workflow using Integral information of Short paired-End reads) is a specialized assembler designed to maximize the utility of paired-end information. Unlike standard assemblers that often use pairing only for scaffolding, BWISE integrates this data into the graph construction and cleaning phases. It is particularly effective for high-coverage Illumina datasets with long read lengths and specific fragment sizes (recommended 500-600 bp).

## Installation and Setup
BWISE can be installed via Bioconda or compiled from source.

**Conda Installation:**
```bash
conda install bioconda::bwise
```

**Source Installation:**
```bash
git clone https://github.com/Malfoy/BWISE --depth 1
cd BWISE
./install_git.sh
```
*Note: Compilation requires GCC >= 4.9, Git, Make, and CMake 3.*

## Core Usage Patterns

### Basic Assembly
The primary entry point is the `Bwise.py` script.
```bash
python3 Bwise.py -x interleaved_reads.fa -o output_directory
```

### Handling Multiple Libraries
BWISE accepts only one paired-end input file. If you have multiple libraries (e.g., libA and libB), you must interleave and concatenate them first.

1. **Interleave each library:**
   ```bash
   python src/two_fastq_to_interleaved_fasta.py libA_1.fq libA_2.fq > interleavedlibA.fa
   python src/two_fastq_to_interleaved_fasta.py libB_1.fq libB_2.fq > interleavedlibB.fa
   ```
2. **Concatenate:**
   ```bash
   cat interleavedlibA.fa interleavedlibB.fa > combined_paired.fa
   ```

### Parameter Optimization
*   **K-mer Selection (`-k`, `-K`):** For 250bp reads, set `-K` slightly below the read length (e.g., 241). Default is 63.
*   **Solidity Thresholds:**
    *   `-s` (K-mer solidity): Discard k-mers appearing fewer than X times (default 2).
    *   `-p` (Super-read solidity): Discard super-reads appearing fewer than X times (default 3).
*   **Coverage Filtering:**
    *   `-S` (Unitig coverage): Minimal coverage for initial cleaning (default 5).
    *   `-P` (Read mapping): Filter unitigs with fewer than X reads mapped (default 3).
*   **Performance:** Use `-t` to specify the number of CPU cores.

## Expert Tips
*   **Input Format:** BWISE supports `.fa`, `.fa.gz`, `.fq`, and `.fq.gz`.
*   **Single Reads:** Use the `-u` flag to include single-end/unpaired libraries. Multiple single-end files should be concatenated into one.
*   **Mapping Effort:** The `-e` flag controls the number of anchors tested for mapping. Leave at "max" unless processing time is prohibitive.
*   **Anchor Size:** The default anchor size (`-a`) is 31. Adjust this only if dealing with extremely repetitive regions or very short reads.

## Reference documentation
- [BWISE GitHub Repository](./references/github_com_Malfoy_BWISE.md)
- [Bioconda BWISE Package](./references/anaconda_org_channels_bioconda_packages_bwise_overview.md)