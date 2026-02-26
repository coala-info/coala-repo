---
name: damasker
description: "Damasker identifies and soft-masks repetitive genomic sequences within Dazzler databases to prevent assembly errors. Use when user asks to identify interspersed repeats, mask tandem repeats, or generate HPC scripts for parallel repeat masking."
homepage: https://github.com/thegenemyers/DAMASKER
---


# damasker

## Overview

Damasker is a specialized suite designed to identify and soft-mask repetitive genomic sequences. It is part of the Dazzler assembly ecosystem and works directly with Dazzler databases (.db or .dam) and local alignment files (.las). By masking tandem and interspersed repeats, it prevents repetitive regions from confounding the "scrubbing" and overlapping phases of genome assembly.

## Core Workflows

### 1. Interspersed Repeat Masking
Use `REPmask` to identify regions covered by a specific number of overlaps from other reads.

```bash
REPmask [-v] [-n<track_name>] -c<coverage_threshold> <subject:db> <overlaps:las> ...
```

*   **Key Parameter**: `-c` is required. It defines the minimum coverage depth to trigger masking.
*   **Output**: Creates an interval track (default suffix `.rep`).
*   **Note**: The `<subject:db>` must refer to the entire database, while `<overlaps:las>` can refer to specific block files.

### 2. Tandem Repeat Masking
Tandem masking is a two-step process involving self-comparison followed by mask generation.

**Step A: Run `datander`**
A specialized version of `daligner` that compares every read only against itself.
```bash
datander [-v] [-k<kmer>] [-h<hit_threshold>] [-e<error_rate>] <path:db|dam> ...
```
*   Produces `TAN.[block].las` files containing self-alignments.

**Step B: Run `TANmask`**
Processes the self-alignments to define tandem repeat boundaries.
```bash
TANmask [-v] [-l<min_length>] [-n<track_name>] <subject:db> <overlaps:las> ...
```
*   **Key Parameter**: `-l` (default 500) defines the minimum length for a region to be considered a tandem repeat.
*   **Output**: Creates an interval track (default suffix `.tan`).

### 3. Scaling with HPC Scripts
For large, multi-block databases, use `HPC.REPmask` to generate a shell script for parallel execution.

```bash
HPC.REPmask [options] -g<blocks_per_group> -c<coverage> <reads:db|dam> [<first_block>[-<last_block>]]
```
*   **Logic**: It automates the `daligner` -> `LAmerge` -> `REPmask` pipeline.
*   **Usage**: Redirect the output to a `.sh` file and execute it (e.g., `HPC.REPmask ... > mask_repeats.sh`).

## Expert Tips and CLI Patterns

### File Sequence Shorthand (@)
Damasker supports a specific syntax for handling multiple `.las` files:
*   `name.@`: Interpreted as `name.1.las`, `name.2.las`, etc.
*   `name.@5`: Starts the sequence at 5.
*   `name.@1-10`: Processes files 1 through 10 inclusive.

### Soft-Masking Philosophy
Damasker performs **soft-masking**. This means the underlying sequence data is preserved, but the repeat intervals are recorded in "tracks." Downstream Dazzler tools (like `daligner` or `DASCRUBBER`) can then be instructed to ignore these masked regions during initial overlap discovery.

### Temporary File Management
When running `datander` or `HPC.REPmask`, use the `-P` option to specify a directory for temporary files (e.g., `/tmp` or a fast SSD mount) to avoid I/O bottlenecks on network storage.

## Reference documentation
- [DAMASKER README](./references/github_com_thegenemyers_DAMASKER.md)
- [Bioconda Damasker Overview](./references/anaconda_org_channels_bioconda_packages_damasker_overview.md)