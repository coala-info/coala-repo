---
name: colord
description: "colord is a compression utility designed to transform long-read sequencing data into compact archives. Use when user asks to compress Oxford Nanopore or PacBio reads, decompress archives, manage quality score preservation, or perform reference-based compression."
homepage: https://github.com/refresh-bio/colord
---


# colord

## Overview
colord is a specialized compression utility tailored for long-read sequencing data. It transforms large FASTQ/FASTA files into compact archives by leveraging domain-specific algorithms for Oxford Nanopore (ONT) and PacBio platforms. The tool allows users to balance the trade-off between compression ratio, memory consumption, and the preservation of quality scores, supporting both reference-free and reference-based workflows.

## Core CLI Patterns

### Compression by Platform
Select the specific mode based on the sequencing technology to ensure the correct internal heuristics are applied:

*   **Oxford Nanopore (ONT):**
    `colord compress-ont input.fastq archive_name`
*   **PacBio HiFi:**
    `colord compress-pbhifi input.fastq archive_name`
*   **PacBio CLR/Subreads:**
    `colord compress-pbraw input.fastq archive_name`

### Decompression and Inspection
*   **Decompress:** `colord decompress archive_name output.fastq`
*   **View Metadata:** `colord info archive_name` (Displays compression settings and archive statistics)

## Optimization and Best Practices

### Compression Priority (-p)
Adjust the resource-to-ratio trade-off using the `-p` flag:
*   `memory` (Default): Lowest RAM usage, fastest execution.
*   `balanced`: Moderate resources for better compression.
*   `ratio`: Maximum compression, requires significant RAM and compute time.

### Quality Score Management (-q)
Quality scores often occupy the bulk of long-read files. Use `-q` to control their footprint:
*   **Lossless:** `-q org` (Preserves original quality scores exactly).
*   **Discard:** `-q none` (Replaces all scores with Q0; smallest file size).
*   **Lossy (Binned):** Use `4-avg` (default for ONT) or `5-avg` (default for HiFi) to bin quality scores into representative averages, significantly reducing size while maintaining utility for most downstream analyses.

### Reference-Based Compression
If a high-quality reference genome is available, use it to drastically improve compression ratios:
*   **Basic Reference:** `colord compress-ont -G reference.fna input.fastq archive_name`
*   **Portable Archive:** Add `-s` to store the reference inside the archive, ensuring it can be decompressed without providing the reference file again:
    `colord compress-ont -G reference.fna -s input.fastq archive_name`

## Expert Tips
*   **Thread Scaling:** Use `-t` to specify CPU cores (default is 12). For `ratio` priority, higher thread counts are recommended.
*   **macOS File Limits:** Before running on macOS, increase the file descriptor limit to avoid "too many open files" errors: `ulimit -n 2048`.
*   **Input Formats:** colord natively handles both plain text and gzipped (`.gz`) FASTQ/FASTA files.
*   **Memory Constraints:** If the process is killed on a shared cluster, revert to `-p memory` and reduce the thread count.

## Reference documentation
- [GitHub Repository and Usage Guide](./references/github_com_refresh-bio_colord.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_colord_overview.md)