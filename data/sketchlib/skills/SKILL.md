---
name: sketchlib
description: sketchlib is a high-performance genomic sketching tool designed for rapid sequence distance estimation.
homepage: https://github.com/bacpop/sketchlib.rust
---

# sketchlib

## Overview
sketchlib is a high-performance genomic sketching tool designed for rapid sequence distance estimation. It serves as a Rust-based reimplementation and extension of pp-sketchlib, optimized for handling large sample sizes and subset comparisons. By utilizing k-mer hashing algorithms (ntHash and BinDash), it compresses genomic data into compact "sketches" (.skm files), enabling massive-scale comparisons and population structure visualization without the computational overhead of traditional alignment.

## Installation and Setup
For optimal performance, especially on specific architectures, use one of the following methods:

*   **Conda (Recommended):** `conda install -c bioconda sketchlib`
*   **Cargo:** `cargo install sketchlib`
*   **Performance Optimization:** If building from source, use `RUSTFLAGS="-C target-cpu=native" cargo install --path .` to optimize the binary for your specific CPU.
*   **macOS (M1-M4):** If using a pre-built binary, you may need to remove the quarantine attribute: `xattr -d "com.apple.quarantine" ./sketchlib`.

## Core CLI Usage Patterns

### Managing Sketch Libraries
The tool uses a stable `.skm` file format for storing sketches.

*   **Inspect Library Metadata:** Use the `info` subcommand to view details about a sketch library, such as k-mer sizes and sketching parameters.
    ```bash
    sketchlib info library.skm
    ```
*   **Querying Inverted Indexes:** For libraries supporting it, you can perform bitmap-based queries to find specific matches across the dataset.

### Comparing Sequences
The primary workflow involves comparing two datasets or a dataset against itself to estimate distances or ANI.

*   **Basic Comparison:**
    ```bash
    sketchlib compare dataset1.skm dataset2.skm
    ```
*   **Filtering Results:** Use thresholds to limit output to relevant hits.
    ```bash
    sketchlib compare query.skm reference.skm --ani-threshold 0.95
    ```
*   **K-Nearest Neighbors:** Use the `knn` option to report only the top matches for each query.

### Specialized Commands
*   **all-bins:** Use this command when working with binned genomic data to process or compare all bins within a directory or library.
*   **3di Encoding:** sketchlib supports 3di encoding for protein structure sketching, useful for structural bioinformatics workflows.

## Expert Tips and Best Practices
*   **Sample Subsetting:** Unlike older versions, this Rust implementation is specifically optimized for comparing subsets of samples within a larger library.
*   **File Stability:** As of v0.2.0, the `.skm` file format is stable. Libraries created with this version or later do not need to be rebuilt for future updates.
*   **Parallelization:** The tool is designed for high concurrency. Ensure your environment allows for multi-threading to take full advantage of the Rust implementation's speed.
*   **Memory Mapping:** sketchlib often uses memory mapping for large `.skm` files; ensure your system has sufficient virtual memory address space when working with millions of sketches.

## Reference documentation
- [github_com_bacpop_sketchlib.rust.md](./references/github_com_bacpop_sketchlib.rust.md)
- [anaconda_org_channels_bioconda_packages_sketchlib_overview.md](./references/anaconda_org_channels_bioconda_packages_sketchlib_overview.md)
- [github_com_bacpop_sketchlib.rust_issues.md](./references/github_com_bacpop_sketchlib.rust_issues.md)