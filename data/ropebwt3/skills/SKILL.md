---
name: ropebwt3
description: Ropebwt3 transforms massive genomic datasets into a run-length encoded FM-index for efficient storage and sequence querying. Use when user asks to build a pangenome index, find exact matches or SMEMs, perform local alignments with BWA-SW, or estimate haplotype diversity.
homepage: https://github.com/lh3/ropebwt3
metadata:
  docker_image: "quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0"
---

# ropebwt3

## Overview

Ropebwt3 is a specialized tool designed for the efficient storage and querying of massive, redundant genomic datasets. It transforms DNA sequences into a run-length encoded FM-index, enabling significant compression (e.g., 7.3Tb of bacterial genomes into a 30GB index). It is particularly effective for pangenome analysis where traditional aligners struggle with redundancy. The tool provides high-speed exact match finding and a revised BWA-SW algorithm for local alignments that support mismatches and gaps.

## Core Workflows and CLI Patterns

### 1. Index Construction
Building a full index is a multi-step process. It is recommended to use the `.fmr` (dynamic) format for construction and the `.fmd` (static) format for searching.

**Build the BWT:**
```bash
# General construction from multiple FASTA files
ropebwt3 build -t24 -bo index.fmr file1.fa file2.fa

# Convert dynamic FMR to static FMD for faster searching
ropebwt3 build -i index.fmr -do index.fmd
```

**Generate Sampled Suffix Array (SSA):**
Required for reporting coordinates in PAF output.
```bash
# Store one SA value per 2^8 positions
ropebwt3 ssa -o index.fmd.ssa -s8 -t32 index.fmd
```

**Prepare Sequence Lengths:**
Required for full PAF metadata.
```bash
seqtk comp input.fa | cut -f1,2 | gzip > index.fmd.len.gz
```

### 2. Finding Exact Matches (MEMs/SMEMs)
Use the `mem` command for rapid identification of exact matches. This is significantly faster than local alignment.

```bash
# Find SMEMs with a minimum length of 31
ropebwt3 mem -t4 -l31 index.fmd query.fa > matches.bed

# Output a subset of positions for the matches
ropebwt3 mem -p -l31 index.fmd query.fa > matches_with_pos.bed
```

### 3. Local Alignment (BWA-SW)
Use the `sw` command when you need to account for mismatches and gaps. Note that this is much slower than `mem`.

```bash
# Standard local alignment outputting PAF
ropebwt3 sw -t4 -N25 -k11 index.fmd query.fa > aln.paf

# End-to-end alignment mode to find similar haplotypes
ropebwt3 sw -e -t4 index.fmd query.fa > haplotypes.paf
```

### 4. Haplotype Diversity
The `hapdiv` command estimates diversity by sliding 101-mers across the query and counting matching alleles in the index.

```bash
ropebwt3 hapdiv index.fmd query.fa > diversity_stats.txt
```

## Expert Tips and Best Practices

*   **Format Selection:** Always convert your final index to `.fmd` using `ropebwt3 build -do`. The FMD format is memory-mappable and faster to load for search operations.
*   **Memory Management:** If the compiler supports OpenMP, use it for multi-threading. If memory is a bottleneck during construction, consider using the `grlBWT` workflow (fa2line -> grlbwt-cli -> grl2plain -> plain2fmd) which utilizes disk space to reduce RAM usage.
*   **Minimum Match Length:** For the `mem` command, increasing the `-l` parameter (e.g., from 19 to 31 or higher) significantly improves performance on large indices by reducing the number of short, uninformative hits.
*   **Coordinate Reporting:** If `sw` is not reporting contig names or positions correctly, ensure that the `.ssa` and `.len.gz` files are present in the same directory as the `.fmd` file and share the same base name.
*   **Sequence Retrieval:** Use the `get` command to extract specific sequences from the index by their internal index ID (e.g., `ropebwt3 get index.fmd 0`).



## Subcommands

| Command | Description |
|---------|-------------|
| ropebwt3 build | Builds a BWT index for a FASTA file. |
| ropebwt3 fa2line | Convert FASTA file to line-based format |
| ropebwt3 kount | Count k-mers in FMD-index files. |
| ropebwt3 merge | Merge multiple FMR files into a single FMR file. |
| ropebwt3 ssa | Builds a suffix array for a FM-index. |
| ropebwt3 suffix | Build suffix array and BWT for a FASTA file. |
| ropebwt3_get | Get sequences from an FMR index |
| ropebwt3_plain2fmd | Convert plain text to FM-index |
| ropebwt3_stat | Compute statistics for an FMD-index. |

## Reference documentation
- [Ropebwt3 Main README](./references/github_com_lh3_ropebwt3_blob_master_README.md)
- [Ropebwt3 Release Notes and Version History](./references/github_com_lh3_ropebwt3_blob_master_NEWS.md)