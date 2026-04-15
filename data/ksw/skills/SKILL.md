---
name: ksw
description: ksw is a high-performance sequence alignment utility that performs interactive local, global, glocal, or extension alignments using the parasail and ksw2 libraries. Use when user asks to align sequence pairs via standard input, perform high-throughput alignments within scripts, or execute alignments with custom scoring matrices and gap penalties.
homepage: https://github.com/nh13/ksw
metadata:
  docker_image: "quay.io/biocontainers/ksw:0.2.3--h43eeafb_0"
---

# ksw

## Overview

ksw is a high-performance, lightweight sequence alignment utility that wraps the `parasail` and `ksw2` libraries. Its defining feature is its "interactive" execution model: the tool remains open, reading query and target sequence pairs from standard input and writing results to standard output until the input stream is closed. This design makes it exceptionally efficient for integration into scripts (Python, Scala, Bash) that require thousands or millions of individual alignments, as it eliminates the process-startup latency for each pair.

## Installation

The easiest way to install ksw is via Bioconda:

```bash
conda install bioconda::ksw
```

Alternatively, build from source to ensure ARM/NEON support:

```bash
git clone --recursive git@github.com:nh13/ksw.git
cd ksw
make
make install
```

## Alignment Modes and Libraries

Use the `-M` flag to select the alignment mode and `-l` to select the underlying library.

| Mode | Description | Library Support | Flag |
| :--- | :--- | :--- | :--- |
| **Local** | Sub-sequence of query to sub-sequence of target | parasail | `-M 0` |
| **Glocal** | Full query to sub-sequence of target | parasail | `-M 1` |
| **Extension** | Prefix of query to prefix of target | ksw2 | `-M 2` |
| **Global** | Full query to full target | parasail or ksw2 | `-M 3` |

## Common CLI Patterns

### Basic Interactive Usage
The tool expects alternating lines of query and target sequences.

```bash
# Single alignment via printf
printf "ACGT\nACTG\n" | ksw

# Multiple alignments
printf "ACGT\nACTG\nCCGG\nCCGC\n" | ksw
```

### Custom Scoring and Penalties
Fine-tune the alignment by specifying match, mismatch, and gap penalties. Note that when a gap is opened, both the open (`-O`) and extension (`-E`) penalties are applied.

```bash
# Global alignment using ksw2 with custom penalties
ksw -M 3 -l ksw2 -s 2 -i 4 -O 4 -E 2
```

### Using a Substitution Matrix
For protein alignments or specific scoring schemes, provide a matrix file.

```bash
ksw -m path/to/matrix.txt
```

### Output with Headers
To make the output more readable or easier to parse, include a header line.

```bash
ksw -H
```

## Expert Tips

*   **Interactive Wrapping**: When calling ksw from a language like Python, use `subprocess.Popen` with `stdin=PIPE` and `stdout=PIPE`. Keep the process handle open and write sequence pairs followed by newlines to `stdin`, then read the result from `stdout`.
*   **Library Selection**: Use `ksw2` for Global or Extension modes when performance is critical, as it is highly optimized. Use `parasail` for Local or Glocal modes.
*   **Long Reads**: Recent versions of ksw (0.2.3+) support arbitrarily long query and target sequences, making it suitable for long-read technologies like Oxford Nanopore or PacBio.
*   **Gap Penalty Logic**: Remember that the total penalty for a gap of length `L` is `O + (L * E)`. Ensure your `-O` and `-E` values reflect this combined cost.

## Reference documentation
- [ksw GitHub Repository](./references/github_com_nh13_ksw.md)
- [Bioconda ksw Package](./references/anaconda_org_channels_bioconda_packages_ksw_overview.md)
- [ksw Release Tags and Changes](./references/github_com_nh13_ksw_tags.md)