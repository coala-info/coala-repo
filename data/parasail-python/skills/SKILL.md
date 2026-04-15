---
name: parasail-python
description: parasail-python performs efficient pairwise sequence alignment of DNA, RNA, or protein sequences using SIMD-accelerated C implementations. Use when user asks to perform local, global, or semi-global alignments, calculate alignment scores, or generate CIGAR strings for biological sequences.
homepage: https://github.com/jeffdaily/parasail-python
metadata:
  docker_image: "quay.io/biocontainers/parasail-python:1.3.4--py310h6cc9453_1"
---

# parasail-python

## Overview

The `parasail-python` skill enables efficient biological sequence alignment by leveraging SIMD (Single Instruction, Multiple Data) C implementations. You should use this skill when you need to perform pairwise alignments of DNA, RNA, or protein sequences where performance is critical. It supports a wide variety of alignment modes, including standard local and global algorithms, as well as specialized semi-global variants that do not penalize gaps at the beginning or end of sequences.

## Function Naming Convention

Parasail uses a structured naming convention to navigate its hundreds of available functions. Understanding this pattern is essential for selecting the right implementation:

`parasail.{algorithm}_{vectorization}_{bits}`

*   **Algorithms**: 
    *   `sw`: Smith-Waterman (local alignment)
    *   `nw`: Needleman-Wunsch (global alignment)
    *   `sg`: Semi-global alignment (various suffixes like `_qb`, `_qe` control gap penalties)
*   **Vectorization Modes**:
    *   `striped`: Generally the fastest and most robust mode.
    *   `scan`: Alternative vectorized approach.
    *   `stats`: Suffix added (e.g., `sw_stats_striped_16`) to return alignment statistics (matches, length) in addition to the score.
    *   `trace`: Suffix added (e.g., `sw_trace_striped_16`) to enable traceback/CIGAR string generation.
*   **Bit Width**: `8`, `16`, `32`, or `64`. Use the smallest bit width that can contain your maximum possible score for maximum speed.

## Core Usage Patterns

### Basic Alignment
To get a simple alignment score, provide the query string, database string, gap open penalty, gap extend penalty, and a substitution matrix.

```python
import parasail

# Perform a local alignment using Smith-Waterman
# Penalties are positive integers; open=11, extend=1
result = parasail.sw_striped_16("ACGTACGT", "ACGTTTGT", 11, 1, parasail.blosum62)
print(f"Score: {result.score}")
```

### Working with Tracebacks (CIGAR)
To retrieve the actual alignment structure, use a function with the `_trace` suffix.

```python
# Use a trace-capable function
result = parasail.nw_trace_striped_16("ACGT", "ACT", 10, 1, parasail.blosum62)

# Access the CIGAR string
cigar_string = result.cigar.decode
print(f"CIGAR: {cigar_string}")
```

### Substitution Matrices
Parasail includes many built-in matrices. Common ones include:
*   `parasail.blosum62`, `parasail.blosum50`, `parasail.blosum80`
*   `parasail.pam100`, `parasail.pam250`
*   `parasail.dnafull` (for DNA sequences)

## Expert Tips and Best Practices

### Memory Management Warning
**Critical**: Always assign the `Result` object to a variable before accessing its attributes (like `.cigar` or `.score`). 
*   **Bad**: `print(parasail.sw_trace("A", "A", 1, 1, mat).cigar.decode)` — This can cause a segmentation fault because the Result object is deallocated before the CIGAR string is fully processed.
*   **Good**: 
    ```python
    res = parasail.sw_trace("A", "A", 1, 1, mat)
    print(res.cigar.decode)
    ```

### Semi-Global Alignment Selection
Semi-global alignment (`sg`) is useful when you expect one sequence to be contained within another or when sequences overlap.
*   `sg_qb_de`: Do not penalize gaps at the **b**eginning of the **q**uery or the **e**nd of the **d**atabase.
*   `sg_qe_db`: Do not penalize gaps at the **e**nd of the **q**uery or the **b**eginning of the **d**atabase.
*   `sg`: No penalties for gaps at the start or end of either sequence.

### Performance Tuning
If you are processing thousands of short sequences, use the `8`-bit versions (e.g., `sw_striped_8`). If the score overflows, the library will typically return the maximum value for that bit width, signaling you should move to `16` or `32` bits.

## Reference documentation
- [github_com_jeffdaily_parasail-python.md](./references/github_com_jeffdaily_parasail-python.md)
- [anaconda_org_channels_bioconda_packages_parasail-python_overview.md](./references/anaconda_org_channels_bioconda_packages_parasail-python_overview.md)