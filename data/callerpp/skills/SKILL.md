---
name: callerpp
description: `callerpp` is a specialized consensus caller that utilizes the `spoa` (Simd Partial Order Alignment) library to perform partial order alignment.
homepage: https://github.com/nh13/callerpp
---

# callerpp

## Overview
`callerpp` is a specialized consensus caller that utilizes the `spoa` (Simd Partial Order Alignment) library to perform partial order alignment. Unlike linear alignment methods, POA can more accurately represent complex variations and is highly efficient at resolving consensus in the presence of frequent insertions and deletions (indels). It is a lightweight, high-performance C++ tool suitable for bioinformatics pipelines requiring fast and accurate sequence summarization.

## Installation and Setup
The tool is available via Bioconda, which is the recommended installation method for most users:

```bash
conda install bioconda::callerpp
```

If building from source, ensure that `spoa` (version >= 4.1.0) is installed on your system before running `make`.

## Command Line Usage
The primary interface for `callerpp` is the command line. You can view all available options by running:

```bash
callerpp -h
```

### Common CLI Patterns
*   **Check Version**: To verify your installation and check the current version:
    ```bash
    callerpp --version
    ```
*   **Basic Consensus Calling**: While specific flags depend on the version, the tool typically accepts input sequences to generate a single consensus output.
    ```bash
    callerpp --input <input_file>
    ```

## Expert Tips and Best Practices
*   **Algorithm Selection**: Use `callerpp` specifically when your input sequences have high indel rates (common in Oxford Nanopore or PacBio data). Partial Order Alignment is mathematically superior to simple majority-rule consensus for these data types because it handles gaps and structural variations more robustly.
*   **Performance**: Because it is based on `spoa`, the tool is optimized for SIMD (Single Instruction, Multiple Data) instructions. Ensure you are running it on hardware that supports modern instruction sets (like SSE4.1 or AVX2) for maximum throughput.
*   **Troubleshooting**: If you encounter segmentation faults or input errors, ensure your input file format is valid and that the `--input` flag is correctly specified, as early versions had known issues with input parsing that were resolved in later releases (v0.1.4+).

## Reference documentation
- [callerpp - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_callerpp_overview.md)
- [nh13/callerpp: A simple consensus caller based on partial order alignment with spoa](./references/github_com_nh13_callerpp.md)