---
name: ropebwt2
description: Ropebwt2 is a specialized tool designed for the incremental construction of FM-indexes for DNA sequences.
homepage: https://github.com/lh3/ropebwt2
---

# ropebwt2

## Overview
Ropebwt2 is a specialized tool designed for the incremental construction of FM-indexes for DNA sequences. Unlike static indexers, it uses a B+ tree-based "rope" data structure to allow for efficient insertion of new sequences into an existing index. It supports advanced sorting modes like Reverse Lexicographical Order (RLO) and Reverse-Complement Lexicographical Order (RCLO), which improve index compressibility and simplify sequence mapping. This skill provides the necessary command-line patterns to build, update, and optimize these genomic indexes.

## Core CLI Patterns

### Basic Index Construction
To build a standard BWT from a FASTA file:
```bash
ropebwt2 -o output.bwt input.fasta
```

### Building with Sorting (RLO/RCLO)
Sorting sequences during construction improves compression for short reads and enables specific mapping features.
*   **Reverse Lexicographical Order (RLO):**
    ```bash
    ropebwt2 -bso output.fmr input.fasta
    ```
*   **Reverse-Complement Lexicographical Order (RCLO):**
    ```bash
    ropebwt2 -br -o output.fmr input.fasta
    ```

### Incremental Updates
To add new sequences to an existing FM-index:
```bash
ropebwt2 -bi existing_index.fmr new_sequences.fasta > updated_index.fmr
```

### High-Performance Processing
For large datasets, use multithreading and adjust the memory buffer. The `-m` flag specifies the number of symbols processed in one batch.
```bash
# Process 4GB of symbols at a time with multithreading
ropebwt2 -brm4g input.fasta > output.fmr
```

## Expert Tips and Best Practices

*   **Memory Estimation:** Peak memory usage is approximately `B + m * (1 + 48/l)`, where `B` is the final BWT size, `m` is the `-m` parameter value, and `l` is the average read length.
*   **Batching:** When working with short reads, processing multiple sequences together (batching) is significantly faster than single-sequence insertion due to reduced cache misses and better multithreading utilization.
*   **Binary Format:** Use the `-b` flag to output in the ropebwt2 binary format (`.fmr`). This is required if you intend to perform incremental updates later using the `-i` flag.
*   **RCLO Benefit:** When using RCLO (`-r`), the reverse complement of the $k$-th sequence in the FM-index is the $k$-th smallest sequence. This eliminates the need for an external array to map sequence ranks to input indices, saving significant memory.
*   **Long vs. Short Reads:** While ropebwt2 is highly optimized for long strings and incremental builds, the legacy BCR implementation in the original `ropebwt` may still be faster for static construction of short-read indexes for assembly.

## Reference documentation
- [lh3/ropebwt2 GitHub Repository](./references/github_com_lh3_ropebwt2.md)