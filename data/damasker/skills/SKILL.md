---
name: damasker
description: Damasker identifies and masks interspersed and tandem repetitive regions within genomic read databases to improve assembly accuracy. Use when user asks to mask repeats, identify tandem repeats with datander, or generate HPC scripts for repeat-masking workflows.
homepage: https://github.com/thegenemyers/DAMASKER
---


# damasker

## Overview

Damasker is the repeat-masking component of the Dazzler assembly suite. It identifies repetitive regions by analyzing the "pile-up" of alignments. If a region of a read aligns to many other reads (interspersed repeats) or to itself (tandem repeats), it is flagged in an interval track. This "soft-masking" allows downstream tools to ignore these regions during initial overlap discovery while preserving the underlying sequence data for later resolution of complex genomic structures.

## Core Workflows

### 1. Masking Interspersed Repeats (REPmask)
Use `REPmask` after running `daligner` to identify regions covered by an excessive number of alignments.

*   **Basic Command**: `REPmask -c<threshold> <subject.db> <overlaps.las>`
*   **Key Parameter**: `-c` sets the coverage depth. A region covered by more than `<int>` alignments is masked.
*   **Naming Tracks**: Use `-n<name>` to override the default `.rep` track name.
*   **Batch Processing**: Use the `@` symbol to process multiple `.las` files (e.g., `overlaps.@.las`).

### 2. Masking Tandem Repeats (datander & TANmask)
Tandem repeats are found by comparing a read against itself.

*   **Step A (Find self-alignments)**: `datander <subject.db>`
    *   This produces `TAN.<block>.las` files.
    *   Options like `-k` (k-mer size) and `-h` (hit threshold) match `daligner` defaults.
*   **Step B (Generate mask)**: `TANmask -l<min_len> <subject.db> TAN.<block>.las`
    *   **Key Parameter**: `-l` defines the minimum length (default 500bp) for a tandem repeat to be masked.
    *   **Output**: Generates a `.tan` track by default.

### 3. HPC Automation
For large datasets, use the `HPC` prefix tools to generate shell scripts for cluster environments (LSF/SLURM).

*   **HPC.REPmask**: Generates a script to run `daligner`, `LAmerge`, and `REPmask` in a coordinated block-processing workflow.
    *   `HPC.REPmask -g<block_span> -c<threshold> <reads.db>`
*   **HPC.TANmask**: Generates a script for the `datander` and `TANmask` workflow.

## Expert Tips and CLI Patterns

*   **The @ Notation**: Damasker supports sophisticated file sequencing.
    *   `overlaps.@.las`: Files 1, 2, 3... until none are found.
    *   `overlaps.@5.las`: Start at file 5.
    *   `overlaps.@1-10.las`: Process files 1 through 10 inclusive.
*   **Soft-Masking Strategy**: Always mask tandem repeats (`.tan`) before or alongside interspersed repeats (`.rep`). Tandem repeats can create false "piles" that confuse interspersed repeat detection.
*   **Database Integrity**: The `<subject:db>` argument must always refer to the entire database, even if the `<overlaps:las>` file only contains alignments for a specific block.
*   **Memory Management**: When using `datander` or `HPC` scripts, use the `-M` option to specify memory limits in GB to prevent job crashes on memory-constrained nodes.



## Subcommands

| Command | Description |
|---------|-------------|
| HPC.REPmask | HPC.REPmask is a script that runs daligner and REPmask. |
| REPmask | Repeat masking tool |
| TANmask | Report tandem repeats |
| datander | Searches for k-mers in overlapping bands and identifies alignments based on specified criteria. |

## Reference documentation

- [Damasker README](./references/github_com_thegenemyers_DAMASKER_blob_master_README.md)
- [HPC REPmask Implementation](./references/github_com_thegenemyers_DAMASKER_blob_master_HPC.REPmask.c.md)
- [HPC TANmask Implementation](./references/github_com_thegenemyers_DAMASKER_blob_master_HPC.TANmask.c.md)