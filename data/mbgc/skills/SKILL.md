---
name: mbgc
description: MBGC (Multiple Bacteria Genome Compressor) is a high-performance utility specifically optimized for the storage and retrieval of bacterial genome collections.
homepage: https://github.com/kowallus/mbgc
---

# mbgc

## Overview
MBGC (Multiple Bacteria Genome Compressor) is a high-performance utility specifically optimized for the storage and retrieval of bacterial genome collections. It leverages the high similarity between genomes of the same or related species to achieve extreme compression ratios—often reducing gigabytes of data to a few megabytes—while maintaining processing speeds exceeding 6 GB/s. The tool supports both lossless and lossy compression, handles gzipped inputs, and allows for partial decompression based on filename patterns.

## Core CLI Patterns

### Compression
Compress a collection of genomes listed in a text file (one path per line):
`mbgc c fasta_list.txt archive.mbgc`

Compress a single FASTA file:
`mbgc c -i input.fasta archive.mbgc`

**Compression Modes (`-m`):**
*   `0` (Speed): Fastest processing, lower ratio.
*   `1` (Default): Balanced performance.
*   `2` (Repo): Optimized for public repositories.
*   `3` (Max): Best ratio, memory-frugal, ideal for long-term storage.

### Decompression
Extract all files to a specific directory:
`mbgc d archive.mbgc ./output_folder`

Extract files as gzipped FASTA (level 1-12):
`mbgc d -z 3 archive.mbgc ./output_folder`

**Partial Decompression:**
Extract only files matching a specific pattern:
`mbgc d -e "E_coli" archive.mbgc ./output`

Extract files matching a list of patterns provided in a file:
`mbgc d -E patterns.txt archive.mbgc ./output`

### Archive Management
**List Contents:**
View filenames and headers stored in the archive:
`mbgc i archive.mbgc`

**Append Data:**
Add new FASTA files to an existing archive (skips duplicates):
`mbgc a new_files.txt archive.mbgc`

**Repack:**
Change the compression mode of an existing archive (e.g., to Max mode):
`mbgc r -m 3 archive.mbgc`

## Expert Tips and Best Practices

*   **Lossy vs. Lossless:** By default (v2.1+), MBGC is lossless. If your FASTA files have irregular line lengths or non-standard formatting that prevents lossless compression, use the `-L` flag to enable lossy mode.
*   **Streaming with Pipes:** Use `-` to handle standard input or output.
    *   Compress from a pipe: `cat genomes.fasta | mbgc c -i - archive.mbgc`
    *   Decompress to stdout: `mbgc d archive.mbgc -`
*   **Formatting Control:** Use `-l 0` during decompression to output sequences as a single continuous line (removing line breaks), which is often useful for downstream grep or sequence analysis tools.
*   **Thread Management:** MBGC is multi-threaded. Use `-t <number>` to limit the CPU cores used, especially in shared HPC environments or when running multiple instances.
*   **Overwriting:** MBGC does not overwrite existing files by default. Use the `-f` flag to force overwriting during decompression or archive creation.

## Reference documentation
- [MBGC GitHub Repository](./references/github_com_kowallus_mbgc.md)
- [MBGC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mbgc_overview.md)