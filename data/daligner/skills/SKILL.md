---
name: daligner
description: daligner identifies local alignments and overlaps between long-read sequencing datasets with high error rates. Use when user asks to find overlaps between reads, perform self-comparison of database blocks, or generate local alignment files for long-read assembly pipelines.
homepage: https://github.com/thegenemyers/DALIGNER
---


# daligner

## Overview

daligner (the Dazzler Overlap Module) is a specialized tool for identifying local alignments in long-read sequencing datasets characterized by high error rates (up to 15%). It operates by comparing blocks of reads within a Dazzler database (.db or .dam). Instead of storing full alignments, it records "trace points" at regular intervals, allowing for efficient reconstruction of alignments while minimizing disk space. It is a core component of many long-read assembly pipelines, such as FALCON.

## Core Command Patterns

### Basic Alignment
To compare a subject block against one or more target blocks:
`daligner [options] <subject:db> <target:db> ...`

### Self-Comparison
When comparing a block against itself (e.g., for finding overlaps within a single dataset), use the `-A` (asymmetric) flag to avoid redundant computations:
`daligner -v -A raw_reads.1 raw_reads.1`

### Block Range Syntax
daligner supports a special `@` syntax to handle multiple database blocks efficiently:
- `db.@` : Matches all blocks (1, 2, 3...).
- `db.@5` : Starts the sequence at block 5.
- `db.@1-10` : Processes blocks 1 through 10 inclusive.

## Key Parameters and Optimization

### Filtration and Sensitivity
- `-k<int>`: K-mer size (default 16). Maximum is 32.
- `-w<int>`: Diagonal band width (default 64).
- `-h<int>`: Hit threshold; requires k-mer hits to cover at least this many bases (default 50).
- `-e<double>`: Average correlation rate (default 0.70 or 70%). Increase for higher stringency; decrease for noisier data.
- `-l<int>`: Minimum alignment length (default 1000bp).

### Memory and Performance
- `-M<int>`: Memory limit in Gb. daligner will automatically adjust k-mer suppression (`-t`) to fit within this limit. This is the recommended way to handle over-represented k-mers (e.g., homopolymer runs).
- `-t<int>`: Explicitly suppress k-mers occurring more than `t` times.
- `-T<int>`: Number of threads (default 4).

### Output Control
- `-s<int>`: Trace point spacing (default 100bp). Smaller values increase alignment reconstruction precision but result in larger `.las` files.
- `-I`: Include identity overlaps (overlaps between different parts of the same read).
- `-a`: Pass-through flag to `LAsort` to produce sorted output immediately.

## Processing Output (.las files)

daligner produces `.las` (local alignment) files. These must typically be sorted and merged before downstream use.

### Sorting and Merging
1. **LAsort**: Sorts alignment records.
   `LAsort -v raw_reads.1.raw_reads.1.las`
2. **LAmerge**: Merges multiple sorted `.las` files.
   `LAmerge total.las block1.las block2.las ...`

### Viewing Alignments
Use **LAshow** to convert the binary `.las` format into human-readable text:
`LAshow raw_reads.db overlaps.las | less`

**Output Format Guide:**
- `a_read b_read`: Indices of the overlapping reads.
- `flag`: `n` for normal, `c` for reverse-complement.
- `[start..end]`: The interval of the alignment. Angle brackets `< >` indicate the alignment reaches the start or end of the read.
- `diffs`: Number of differing bases.
- `trace pts`: Number of trace points used for the record.

## Expert Tips
- **K-mer Suppression**: If daligner is crashing due to memory exhaustion, check for highly repetitive sequences. Use the `-M` flag to let the tool self-limit, or run `DBdust` beforehand to mask low-complexity regions.
- **Asymmetric Comparisons**: Always use `-A` when comparing a block to itself or when running a grid of comparisons (X vs Y) to ensure you only compute the upper triangle of the comparison matrix.
- **Disk I/O**: daligner is I/O intensive. If running on a cluster, try to use local `/tmp` space for intermediate files via the `-P` option.



## Subcommands

| Command | Description |
|---------|-------------|
| DBinit | Initialize a new database for the DAZZ_DB / daligner suite. |
| LAshow | Display local alignments produced by daligner in a human-readable format. |

## Reference documentation
- [DALIGNER README](./references/github_com_thegenemyers_DALIGNER.md)
- [DAshow Wiki](./references/github_com_thegenemyers_DALIGNER_wiki_DAshow.md)
- [daligner Executable Wiki](./references/github_com_thegenemyers_DALIGNER_wiki_daligner-executable.md)