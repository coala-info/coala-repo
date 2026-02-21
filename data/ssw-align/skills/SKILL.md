---
name: ssw-align
description: The `ssw-align` skill provides a Python-based implementation of the Striped Smith-Waterman algorithm.
homepage: https://github.com/kyu999/ssw_aligner
---

# ssw-align

## Overview
The `ssw-align` skill provides a Python-based implementation of the Striped Smith-Waterman algorithm. It is significantly faster than standard Python Smith-Waterman libraries, making it suitable for large-scale sequence analysis. Use this skill to calculate optimal local alignment scores, determine alignment boundaries, generate aligned sequences, and retrieve CIGAR strings for sequence pairs.

## Implementation Guide

### Basic Alignment
To perform a local alignment, use the `local_pairwise_align_ssw` function. You must provide the query and target sequences along with scoring parameters.

```python
from ssw_aligner import local_pairwise_align_ssw

# Define sequences
query = 'TTTTTAAAAA'
target = 'GGGGTTTT'

# Execute alignment
alignment = local_pairwise_align_ssw(
    query, 
    target, 
    gap_open_penalty=11, 
    gap_extend_penalty=1, 
    match_score=2, 
    mismatch_score=-3
)
```

### Extracting Results
The alignment object contains several attributes for downstream analysis:

*   **Scores**: `alignment.optimal_alignment_score`
*   **Coordinates**: 
    *   Query: `alignment.query_begin`, `alignment.query_end`
    *   Target: `alignment.target_begin`, `alignment.target_end_optimal`
*   **Sequences**: `alignment.aligned_query_sequence`, `alignment.aligned_target_sequence`
*   **CIGAR**: `alignment.cigar` (Compact Idiosyncratic Gapped Alignment Report)

### Index Management
By default, the tool uses specific indexing. You can check or modify the base (0 or 1) to match your data source requirements:

```python
# Check current indexing
is_zero = alignment.is_zero_based()

# Force 0-based indexing (Python standard)
alignment.set_zero_based(0)

# Force 1-based indexing (Common in bioinformatics formats like SAM/GFF)
alignment.set_zero_based(1)
```

## Best Practices and Tips

*   **Scoring Parameters**: For DNA alignment, a common starting point is `match_score=2`, `mismatch_score=-3`, `gap_open_penalty=11`, and `gap_extend_penalty=1`. Adjust these based on the expected evolutionary distance between sequences.
*   **Performance**: `ssw_aligner` is optimized via Cython. Ensure `numpy` and `Cython` are installed in the environment to maintain the performance benefits over standard implementations like `swalign`.
*   **Memory Efficiency**: The tool is lightweight (approx. 108 KB zipped), making it suitable for deployment in constrained environments like Google Dataflow or serverless functions where larger libraries like `scikit-bio` might be too heavy.
*   **CIGAR Strings**: Use the `cigar` attribute when you need to represent the alignment in standard bioinformatics formats (e.g., SAM files).

## Reference documentation
- [SSW Aligner README](./references/github_com_kyu999_ssw_aligner.md)