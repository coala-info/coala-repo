---
name: crussmap
description: crussmap performs genomic coordinate liftover between different assembly versions using UCSC chain files. Use when user asks to lift over genomic coordinates, convert BED files between assemblies, or inspect chain file contents.
homepage: https://github.com/wjwei-handsome/crussmap
metadata:
  docker_image: "quay.io/biocontainers/crussmap:1.0.1--h5c46d4b_0"
---

# crussmap

## Overview

`crussmap` is a Rust-based reimplementation of the `CrossMap` tool, optimized for speed and memory efficiency. It allows researchers to "lift over" genomic coordinates between different assembly versions (e.g., hg19 to hg38) using standard UCSC chain files. By utilizing a fast interval tree library and efficient parsers, it provides a significant performance boost over the original Python implementation, making it ideal for processing very large BED files.

## Command Line Usage

### Coordinate Conversion (BED)

The primary function of `crussmap` is converting BED files.

**Basic conversion to stdout:**
```bash
crussmap bed --bed input.bed --input assembly_map.chain
```

**Conversion with file output:**
Use the `--output` and `--unmap` flags to save results and capture coordinates that could not be mapped to the new assembly.
```bash
crussmap bed --bed input.bed --input assembly_map.chain --output mapped.bed --unmap failed.bed
```

### Chain File Inspection

Before performing a liftover, you can inspect the contents of a chain file to understand the block pair representations.

**View as TSV (Default):**
```bash
crussmap view --input data/test.chain --output chain_view.txt
```

**View as CSV:**
```bash
crussmap view --input data/test.chain --output chain_view.csv --csv
```

## Expert Tips and Best Practices

- **Performance Benchmarking**: `crussmap` is significantly faster than the Python version. In testing environments, it can process ~10,000 BED records against a ~250,000-line chain file in approximately 250 milliseconds.
- **Handling Unmapped Regions**: Always provide an `--unmap` file path. Genomic regions that fall into gaps in the target assembly or are deleted in the new version will be written here, which is critical for maintaining data integrity in downstream analysis.
- **Chain File Source**: Ensure you are using standard UCSC `.chain` files. `crussmap` uses a specialized `nom`-based parser designed specifically for this format.
- **Installation**: If the binary is not present in the environment, it can be installed via Cargo: `cargo install crussmap`.



## Subcommands

| Command | Description |
|---------|-------------|
| crussmap_bed | Converts BED file. Regions mapped to multiple locations to the new assembly will be split |
| crussmap_view | View chain file in tsv/csv format |

## Reference documentation
- [github_com_JianYang-Lab_crussmap.md](./references/github_com_JianYang-Lab_crussmap.md)
- [github_com_JianYang-Lab_crussmap_blob_main_README.md](./references/github_com_JianYang-Lab_crussmap_blob_main_README.md)