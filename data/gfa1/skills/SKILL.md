---
name: gfa1
description: The gfa1 toolkit is a C library and command-line utility designed to parse, validate, and simplify Graphical Fragment Assembly version 1 files. Use when user asks to clean assembly graphs, perform unitigging, trim tips, pop bubbles, or convert GFA1 files with flexible overlap definitions.
homepage: https://github.com/lh3/gfa1
---


# gfa1

## Overview

The gfa1 toolkit is a specialized C library and command-line utility (`gfaview`) designed for the manipulation of Graphical Fragment Assembly (GFA) version 1 files. It is particularly effective for processing raw assembly graphs produced by long-read assemblers like miniasm. The tool excels at "cleaning" graphs by discarding segments with unknown lengths, identifying duplicated links, and filling in missing information that can be logically inferred. It supports a specific GFA1 dialect that allows for flexible overlap definitions, such as specifying different overlap lengths for the two segments involved in a link.

## Command Line Usage

The primary executable for this toolkit is `gfaview`.

### Basic Validation and Cleaning
To parse an input graph, check its integrity, and output a correctly formatted GFA1 file:
```bash
gfaview input.gfa > cleaned.gfa
```

### Graph Transformation Pipeline
For long-read assemblies, `gfaview` can apply a series of transformations ported from miniasm to simplify the graph. A common "all-in-one" transformation string is:
```bash
gfaview -rtbom input.gfa > transformed.gfa
```

**Key Transformation Flags:**
*   `-r`: Perform unitigging (merging linear paths into single nodes).
*   `-t`: Trim tips (remove short, dead-end branches).
*   `-b`: Pop bubbles (resolve redundant paths in the graph).
*   `-o`: Purge short overlaps.
*   `-m`: Apply miniasm-style heuristics for graph simplification.

### Handling Compressed Input
The tool can process gzipped GFA files directly:
```bash
gfaview -rtbom assembly.gfa.gz > simplified.gfa
```

## Expert Tips and Best Practices

### Understanding the GFA1 Dialect
This tool supports an extended overlap field in `L` (Link) lines. While standard GFA1 often uses CIGAR strings, this dialect allows:
*   **Single Length**: `50` (shorthand for `50M` or `50:50`).
*   **Dual Lengths**: `50:51` (indicates a 50bp suffix of the first segment overlaps with a 51bp prefix of the second).
This is particularly useful for long-read overlaps where exact CIGAR strings are often unavailable.

### Integrity Checks
`gfaview` automatically performs several non-obvious cleanup tasks:
*   **Segment Inference**: If a segment is used in an `L` line but lacks a corresponding `S` line, `gfaview` will attempt to infer the segment length.
*   **Deduplication**: It identifies and removes duplicated links where starting/ending vertices and overlap lengths are identical.
*   **Formatting**: It ensures the output follows a strict, easily-parsable GFA1 format, making it an ideal pre-processor for other bioinformatic tools.

### Successor Tooling
Note that this specific repository is archived. For newer projects or features not covered by this toolkit, the developer recommends transitioning to `gfatools`.

## Reference documentation
- [gfa1 toolkit overview](./references/anaconda_org_channels_bioconda_packages_gfa1_overview.md)
- [lh3/gfa1 GitHub Repository](./references/github_com_lh3_gfa1.md)