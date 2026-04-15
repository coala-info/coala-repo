---
name: mantis
description: Mantis builds, compresses, and queries large-scale sequence-search indices and colored de Bruijn graphs from biological datasets. Use when user asks to build a sequence index from Squeakr files, compress color information using MST, or query k-mers and transcripts across thousands of experiments.
homepage: https://github.com/splatlab/mantis
metadata:
  docker_image: "quay.io/biocontainers/mantis:0.2--h4a1dfb3_4"
---

# mantis

think---
name: mantis
description: Large-scale sequence-search index and colored de Bruijn graph representation. Use when needing to build, compress, or query exact sequence indices from thousands of raw-read experiments (Squeakr CQF files).
---

## Overview

Mantis is a high-performance, space-efficient tool designed for indexing and searching large collections of biological sequences. Unlike Bloom filter-based methods, Mantis uses counting quotient filters (CQF) to provide exact results with no false positives or negatives. It is particularly effective for researchers working with thousands of RNA-seq or genomic datasets who need to perform rapid k-mer queries or topological analyses on a colored de Bruijn graph.

## Core Workflows

### 1. Building the Index
The `build` command converts a collection of Squeakr CQF files into a unified Mantis index.

```bash
mantis build -s <log-slots> -i <input_list> -o <output_dir>
```

*   **Input List**: A text file containing paths to the input Squeakr CQF files.
*   **Log-Slots (`-s`)**: Sets the initial size of the output CQF. Mantis resizes automatically, but choosing a good starting value prevents performance hits:
    *   `28`: Small bacterial genomes.
    *   `30`: Large set of medium-sized read files.
    *   `33`: Large set of big read files.
*   **Optimization**: Use the `-e` flag to write the equivalence class abundance distribution for diagnostic purposes.

### 2. MST Compression (Highly Recommended)
After building, use the `mst` command to significantly reduce the memory footprint of the color information using Minimum Spanning Trees.

```bash
mantis mst -p <index_prefix> -t <threads> [-k | -d]
```

*   **Memory Management**: Use `-d` (delete-RRR) to remove the intermediate RRR representation and save disk space, or `-k` (keep-RRR) if you need to maintain both formats.
*   **Performance**: This step makes subsequent queries much more memory-efficient without sacrificing speed.

### 3. Querying Sequences
Search for k-mers or transcripts within the indexed experiments.

```bash
mantis query [-j] [-k <kmer_size>] -p <index_prefix> -o <output_file> <query_fasta>
```

*   **Output Formats**: Use `-j` to get results in JSON format for easier downstream parsing.
*   **Legacy Support**: If you did not run the `mst` step, use `-1` to query using the original color classes.

## Expert Tips & Best Practices

*   **Pre-processing with Squeakr**: Always run `squeakr` with the `--no-counts` argument before building a Mantis index. This reduces intermediate storage requirements by over 10x by only including k-mers that pass the abundance threshold.
*   **System Limits**: The `build` process opens all input Squeakr files simultaneously. Ensure your system's "open file handles" limit (`ulimit -n`) is set higher than the number of input files.
*   **Memory Usage**: Mantis uses `mmap` and `madvise` to manage memory. While it clears used pages to keep Resident Set Size (RSS) in check, ensure the host system has sufficient RAM to map the primary index files.
*   **Hardware Acceleration**: If running on Intel Haswell or newer CPUs, ensure the binary is compiled with Haswell instructions (default) to utilize optimized machine-word selection. For older hardware, compile with `-DNH=1`.



## Subcommands

| Command | Description |
|---------|-------------|
| mantis | Mantis is a k-mer based de Bruijn graph construction and querying tool. |
| mantis | Query the de Bruijn graph index. |
| mantis | Mantis is a k-mer based de Bruijn graph construction and querying tool. |
| mantis | Mantis is a k-mer based sequence analysis tool. |
| mantis | Validates the MST structure of the de Bruijn graph. |
| mantis build | Build a CQF (Compressed Quotient Filter) from input filters. |

## Reference documentation

- [Mantis GitHub README](./references/github_com_splatlab_mantis_blob_master_README.md)
- [Mantis Overview](./references/github_com_splatlab_mantis.md)