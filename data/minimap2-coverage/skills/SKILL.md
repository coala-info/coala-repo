---
name: minimap2-coverage
description: minimap2-coverage performs pairwise alignments of long-read sequencing data to facilitate coverage estimation and error profiling for quality control workflows. Use when user asks to estimate sequencing coverage, profile error rates in PacBio or ONT reads, or perform alignments for LongQC analysis.
homepage: https://github.com/yfukasawa/LongQC
metadata:
  docker_image: "quay.io/biocontainers/minimap2-coverage:1.2.0c--h577a1d6_4"
---

# minimap2-coverage

## Overview
minimap2-coverage is a modified version of the versatile minimap2 pairwise aligner, specifically optimized to work as a backend for the LongQC (Long-read Quality Control) tool. It is designed to handle the high error rates (~15%) associated with third-generation sequencing technologies like Pacific Biosciences (PacBio) and Oxford Nanopore Technologies (ONT). Its primary role is to perform the underlying alignments required for coverage estimation and error profiling without requiring a reference genome, making it a critical component for "Sample QC" and "Platform QC" workflows.

## Installation and Setup

### Conda Installation
The most straightforward way to acquire the pre-compiled binary for Linux systems is via Bioconda.
```bash
conda install -c bioconda minimap2-coverage
```

### Building from Source
If you are not using Conda or are on a non-Linux platform, you must build the tool from the LongQC repository.
```bash
git clone https://github.com/yfukasawa/LongQC.git
cd LongQC/minimap2-coverage
make
```

### Architecture-Specific Compilation (Expert Tips)
Standard compilation may fail or underperform on specific hardware. Use these flags during the `make` process:

*   **macOS Requirements**: You must have `argp` installed. The easiest method is via Homebrew: `brew install argp-standalone`.
*   **Apple Silicon (M1/M2/M3 Chips)**: To ensure compatibility with ARM architecture, you must specify the neon and aarch64 flags:
    ```bash
    make arm_neon=1 aarch64=1
    ```
*   **Linux/Clang**: If compiling with `clang 12` or newer, ensure you are using the latest version of the LongQC source to include necessary C-code patches for compatibility.

## Usage within LongQC
While minimap2-coverage can technically be run as a standalone aligner, it is almost exclusively used through the `longQC.py` wrapper.

### Key Parameters Influencing minimap2-coverage
When running LongQC, several flags directly control the behavior of the underlying minimap2-coverage process:

*   **Memory Management (`-i` / `--index`)**: Use this to set the index size for minimap2-coverage. If running on a machine with limited RAM, reduce this value (default is 4G).
    ```bash
    python longQC.py sampleqc -i 2G ...
    ```
*   **Parallel Database Creation (`-d` / `--db`)**: This flag allows the tool to build the minimap2 database in parallel with other tasks, significantly decreasing total runtime.
*   **CPU Allocation (`-p` / `--ncpu`)**: Defines the number of threads minimap2-coverage will use for the alignment phase.

## Troubleshooting
*   **Empty sdust.txt**: If you encounter an empty `longqc_sdust.txt` file, verify that the `minimap2-coverage` binary is in your PATH or correctly compiled in the `minimap2-coverage/` subdirectory of LongQC.
*   **Shared Library Errors (macOS)**: If you see errors regarding `argp.h`, ensure `argp-standalone` is linked correctly during the `make` process.

## Reference documentation
- [Bioconda minimap2-coverage Overview](./references/anaconda_org_channels_bioconda_packages_minimap2-coverage_overview.md)
- [LongQC GitHub Repository](./references/github_com_yfukasawa_LongQC.md)