---
name: edlib-aligner
description: "Performs sequence alignment using edit (Levenshtein) distance. Use when user asks to calculate edit distance between sequences, find optimal alignment paths, or determine alignment start/end locations."
homepage: https://github.com/Martinsos/edlib/
---


# edlib-aligner

Performs sequence alignment using edit (Levenshtein) distance.
  Use this skill when you need to calculate the edit distance between two sequences,
  find optimal alignment paths, or determine the start/end locations of alignments.
  This is particularly useful in bioinformatics for tasks like sequence comparison,
  variant calling, and error detection.
---
## Overview
The edlib-aligner skill provides a command-line interface for performing sequence alignment based on edit distance (Levenshtein distance). It's designed for speed and efficiency, making it suitable for comparing biological sequences or any strings where the number of edits (insertions, deletions, substitutions) is a key metric. This tool can not only calculate the edit distance but also provide the alignment path or just the alignment boundaries, offering flexibility for different analytical needs.

## Usage Instructions

The `edlib-aligner` tool is primarily used via its command-line interface. The core functionality involves providing two sequences and specifying the alignment configuration.

### Basic Alignment

The most common use case is to calculate the edit distance between two sequences.

**Command Structure:**

```bash
edlib-aligner <sequence1> <sequence2> [options]
```

**Example:**

```bash
edlib-aligner "AGCT" "AGGT"
```

This command will output the edit distance between "AGCT" and "AGGT".

### Alignment Methods

Edlib supports several alignment methods:

*   **Global Alignment (NW):** Aligns the entire length of both sequences.
*   **Prefix Alignment (SHW):** Aligns a prefix of the longer sequence to the shorter sequence.
*   **Infix Alignment (HW):** Finds the best alignment between any part of the two sequences.

You can specify the alignment method using the `--method` option.

**Example (Global Alignment):**

```bash
edlib-aligner "GATTACA" "GCATGCU" --method NW
```

**Example (Infix Alignment):**

```bash
edlib-aligner "ACGTACGT" "CGTAC" --method HW
```

### Output Options

*   **Edit Distance:** By default, the tool outputs the edit distance.
*   **Alignment Path:** To get the detailed alignment path (instructions to transform one sequence into another), use the `--path` option.
*   **Alignment Boundaries:** To find only the start and/or end locations of the alignment, use `--start` and/or `--end` options.

**Example (with Alignment Path):**

```bash
edlib-aligner "HELLO" "JELLO" --path
```

### Customizing Character Equality

You can extend the definition of character equality, which is useful for handling wildcard characters, case-insensitive alignment, or degenerate nucleotides. This is typically done by providing a custom configuration.

**Example (Case-Insensitive Alignment):**

While the direct CLI option for this is not explicitly detailed in the provided documentation, advanced usage might involve custom configuration files or specific API calls if using the library directly. For command-line usage, focus on the standard options.

### Building and Installation

Edlib can be built using Meson or CMake. For command-line usage, it's often installed via package managers like Conda.

**Conda Installation:**

```bash
conda install bioconda::edlib
```

### Expert Tips

*   **Speed:** Edlib is optimized for speed using Myers's bit-vector algorithm. For maximum performance, consider using the C/C++ library directly if complex scripting is not required.
*   **Memory Efficiency:** Edlib is designed to handle very large sequences with minimal memory consumption.
*   **Python Bindings:** If you are working within a Python environment, consider using the provided Python bindings (`bindings/python/`) for easier integration.

## Reference documentation
- [Edlib Overview](./references/github_com_Martinsos_edlib.md)
- [Edlib Installation and Building](./references/github_com_Martinsos_edlib_1.md)