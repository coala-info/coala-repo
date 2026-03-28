---
name: colord
description: colord is a genomic data utility designed to compress and decompress long-read sequencing data from Oxford Nanopore and PacBio platforms. Use when user asks to compress ONT or PacBio reads, manage quality score preservation, perform reference-based compression, or decompress colord archives.
homepage: https://github.com/refresh-bio/colord
---

# colord

## Overview

CoLoRd (Compressing Long Reads) is a specialized genomic data utility designed to handle the high volume of data produced by modern long-read sequencing platforms. It provides tailored compression algorithms for ONT and PacBio reads, allowing users to balance between file size and data fidelity. Key capabilities include multi-threaded execution, various quality score compression modes (from original preservation to complete discard), and a reference-based mode that uses a genome to further shrink the archive size.

## Common CLI Patterns

### Compression by Platform
Select the specific command based on the sequencing technology used:

*   **Oxford Nanopore (ONT):**
    `colord compress-ont input.fastq archive.colord`
*   **PacBio HiFi:**
    `colord compress-pbhifi input.fastq archive.colord`
*   **PacBio CLR/Raw:**
    `colord compress-pbraw input.fastq archive.colord`

### Quality Score Management
Quality scores often occupy the bulk of a FASTQ file. Use the `-q` flag to control this:

*   **Lossless (Original):** Use `-q org` to keep all quality scores exactly as they are.
    `colord compress-pbhifi -q org input.fastq archive.lossless`
*   **Discard Quality:** Use `-q none` to strip quality scores (replaces with Q0), which yields the smallest file size.
    `colord compress-pbraw -q none input.fastq archive.no_qual`
*   **Binned Quality:** Use `2-avg`, `4-avg`, or `5-avg` to bin quality scores into representatives.
    `colord compress-ont -q 4-avg input.fastq archive.binned`

### Reference-Based Compression
To achieve the highest possible compression ratio, provide a reference genome (`-G`). You can optionally embed the reference in the archive (`-s`) so it isn't required for decompression later.

`colord compress-ont -G reference.fna -s input.fastq archive.refbased`

### Decompression and Inspection
*   **View Archive Info:** Check compression stats and parameters used.
    `colord info archive.colord`
*   **Decompress:** Restore the data to FASTQ format.
    `colord decompress archive.colord output.fastq`

## Expert Tips and Best Practices

*   **Thread Optimization:** The default is 12 threads. For high-performance servers, scale this using `-t` (e.g., `-t 48`) to significantly speed up the graph-building phase.
*   **Compression Priority:** Use the `-p` flag to set the strategy:
    *   `memory`: Minimizes RAM usage (default).
    *   `ratio`: Maximizes compression at the cost of time/memory.
    *   `balanced`: A middle ground.
*   **Memory Management on macOS:** Before running large jobs on macOS, increase the file descriptor limit to avoid "too many open files" errors: `ulimit -n 2048`.
*   **K-mer Adjustment:** While `colord` auto-adjusts k-mer length, you can manually override it with `-k` (range 15-28) if you have specific knowledge of your read lengths or error rates.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/colord decompress | decompression mode |
| /usr/local/bin/colord info | print archive informations |
| colord compress-ont | compress ONT data |
| colord compress-pbhifi | compress PacBio HiFi data |
| colord compress-pbraw | compress PacBio Raw data |

## Reference documentation
- [CoLoRd README](./references/github_com_refresh-bio_colord_blob_master_README.md)