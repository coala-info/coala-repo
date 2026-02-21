---
name: daligner
description: The `daligner` tool is the core "overlap" module of the Dazzler suite.
homepage: https://github.com/thegenemyers/DALIGNER
---

# daligner

## Overview

The `daligner` tool is the core "overlap" module of the Dazzler suite. It is specifically designed to handle the high error rates (up to 15%) associated with long-read sequencing technologies. Instead of recording full alignments, it produces parsimonious `.las` files containing "trace points" every ~100bp, allowing for efficient reconstruction of alignments. This skill provides guidance on executing the primary aligner, managing memory via k-mer suppression, and utilizing the utility programs for sorting and merging alignment data.

## Core Workflow

### 1. Initial Alignment
The `daligner` command compares a subject database block against one or more target blocks.

```bash
daligner [-vaAI] [-k<int>] [-w<int>] [-h<int>] [-t<int>] [-M<int>] [-e<double>] [-l<int>] [-s<int>] [-T<int>] <subject:db|dam> <target:db|dam> ...
```

*   **Basic Overlap**: `daligner -v -T8 DB.1 DB.1` (Compares block 1 against itself using 8 threads).
*   **Asymmetric Comparison**: Use `-A` to report only $X \to Y$ overlaps (useful for parallelizing large all-to-all jobs).
*   **Sensitivity Tuning**:
    *   `-k`: K-mer size (default 16, max 32).
    *   `-e`: Average correlation rate (default 0.70). Increase for higher stringency.
    *   `-l`: Minimum alignment length (default 1000bp).
    *   `-s`: Trace point spacing (default 100bp).

### 2. Memory Management & K-mer Suppression
High-frequency k-mers (e.g., homopolymer runs) can cause memory overflows.
*   **Automatic**: Use `-M<int>` to specify a memory limit in Gb. `daligner` will automatically calculate a suppression threshold `t`.
*   **Manual**: Use `-t<int>` to ignore any k-mer appearing more than `t` times.
*   **Masking**: Use `-m<track>` to ignore regions defined by a specific track (e.g., a "dust" track for low-complexity DNA).

### 3. Processing Results (.las files)
After running `daligner`, you must organize the resulting alignment files.

*   **Sorting**: `LAsort [-v] <align:las> ...`
    *   Orders alignments by read index. Required before merging.
*   **Merging**: `LAmerge [-v] <dest:las> <src1:las> <src2:las> ...`
    *   Combines multiple sorted `.las` files into a single coherent file.
*   **Viewing**: `LAshow [-v] <db:db> <align:las> [reads:range]`
    *   Converts the sparse trace-point encoding into a human-readable alignment display.

## Expert Tips

*   **Block Naming Convention**: Use the `@` symbol to process sequences of blocks. For example, `daligner DB @1-10` compares the subject against blocks 1 through 10.
*   **Identity Overlaps**: By default, `daligner` ignores a read's alignment to itself. Use `-I` if you specifically need to find internal repeats within reads.
*   **Disk Space**: `.las` files can become very large. Ensure the directory specified by `-P` (default `/tmp`) has sufficient space for temporary files during the alignment process.
*   **Integration**: `daligner` expects reads to be encoded in a Dazzler database (`.db` or `.dam`). Ensure you have run `DBinit` and `DBsplit` before attempting alignment.

## Reference documentation
- [Daligner README](./references/github_com_thegenemyers_DALIGNER.md)
- [Bioconda Daligner Overview](./references/anaconda_org_channels_bioconda_packages_daligner_overview.md)