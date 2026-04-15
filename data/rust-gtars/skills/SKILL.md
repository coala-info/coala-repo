---
name: rust-gtars
description: rust-gtars is a high-performance suite of tools designed for efficient genomic interval processing and analysis. Use when user asks to find genomic overlaps, generate smoothed signal profiles, tokenize genomic regions, calculate distances between features, or split genomic fragments.
homepage: https://github.com/databio/gtars
metadata:
  docker_image: "quay.io/biocontainers/rust-gtars:0.6.0--h885253a_0"
---

# rust-gtars

## Overview
`rust-gtars` is a performance-critical suite of tools designed for efficient genomic interval processing. While it serves as the computational engine for the `geniml` Python library, it provides a robust standalone Command Line Interface (CLI) and a set of Rust crates. It is particularly useful for bioinformaticians who need to handle large-scale genomic datasets where traditional Python-based tools may encounter performance bottlenecks.

## Installation and Setup
The tool can be installed via Conda or compiled from source using Cargo.

- **Conda (Bioconda):**
  ```bash
  conda install bioconda::rust-gtars
  ```
- **Cargo (Source):**
  To include specific high-performance modules like `uniwig` or `tokenizers`, use feature flags:
  ```bash
  cargo install --path gtars-cli --features "uniwig tokenizers"
  ```

## CLI Usage Patterns
The `gtars` CLI uses a subcommand-based architecture. You can discover available modules by running `gtars --help`.

### Common Subcommands
- **`overlaprs`**: Used for finding and analyzing overlaps between genomic interval sets.
- **`uniwig`**: Generates smoothed signal profiles (wiggle files) from genomic data.
- **`tokenizers`**: Transforms genomic regions into discrete tokens, typically for use in genomic language models or machine learning.
- **`genomicdist`**: Calculates distances between features, such as the distance from a region to the nearest Transcription Start Site (TSS).
- **`fragsplit`**: Handles the splitting of genomic fragments into smaller components.
- **`bbcache`**: Manages local caches for BedBase-related data.

### Command Discovery
Because `rust-gtars` is under active development, always verify the specific arguments for a subcommand using the help flag:
```bash
gtars <subcommand> --help
```

## Expert Tips and Best Practices
- **Feature Gating**: If you are compiling from source and a specific command (like `uniwig`) is missing, ensure you enabled the corresponding feature during the `cargo install` process.
- **Library Integration**: For Rust developers, `gtars` is modular. You can include only the specific crate you need (e.g., `gtars-overlaprs`) in your `Cargo.toml` to keep binary sizes small.
- **Python Bindings**: If performance is needed within a Python script, prefer using the `gtars` Python package (`pip install gtars`) which provides direct bindings to these Rust implementations rather than calling the CLI via subprocess.
- **Memory Efficiency**: `rust-gtars` is designed for low-memory overhead. When processing massive BED files, it is often significantly faster and more memory-efficient than `bedtools` for the specific operations it implements.

## Reference documentation
- [github_com_databio_gtars.md](./references/github_com_databio_gtars.md)
- [anaconda_org_channels_bioconda_packages_rust-gtars_overview.md](./references/anaconda_org_channels_bioconda_packages_rust-gtars_overview.md)