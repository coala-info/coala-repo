---
name: pywfa
description: pywfa is a Python wrapper for the WFA2-lib that provides an efficient implementation of the Wavefront Alignment algorithm for rapid sequence comparison. Use when user asks to perform pairwise sequence alignment, calculate alignment scores using affine gap penalties, or generate CIGAR strings for genomic data.
homepage: https://github.com/kcleal/pywfa
---


# pywfa

## Overview

pywfa is a Python wrapper for the WFA2-lib, providing an efficient implementation of the Wavefront Alignment algorithm. It is designed for rapid sequence comparison, offering significantly better performance than standard Smith-Waterman or Needleman-Wunsch implementations for genomic data. The tool allows for fine-grained control over alignment parameters, including affine and two-piece affine gap penalties, various alignment spans (end-to-end vs. ends-free), and heuristic methods for ultra-fast processing of long sequences.

## Basic Alignment Workflow

The primary interface is the `WavefrontAligner` class. You can initialize it with a pattern and then align multiple text strings against it.

```python
from pywfa import WavefrontAligner

pattern = "TCTTTACTCGCGCGTTGGAGAAATACAATAGT"
text = "TCTATACTGCGCGTTTGGAGAAATAAAATAGT"

# Initialize and align
aligner = WavefrontAligner(pattern)
score = aligner.wavefront_align(text)

# Check success (0 is success, -1 indicates heuristic cutoff)
if aligner.status == 0:
    print(f"Score: {aligner.score}")
    print(f"CIGAR: {aligner.cigarstring}")
```

## Configuration and Performance Tuning

To optimize for speed or specific biological contexts, use the following initialization parameters:

- **Distance Metrics**: 
  - `distance="affine"` (default): Standard gap-affine.
  - `distance="affine2p"`: Two-piece affine gap model (useful for long indels).
- **Alignment Scope**:
  - `scope="full"` (default): Computes score and CIGAR string.
  - `scope="score"`: Computes only the score (much faster and uses less memory).
- **Alignment Span**:
  - `span="ends-free"` (default): Allows gaps at the start/end without penalty (semi-global).
  - `span="end-to-end"`: Forces alignment across the entire length (global).
- **Heuristics**:
  - Use `heuristic="adaptive"` or `heuristic="X-drop"` for very long sequences to limit the search space. Always check `aligner.status` when using these.

## Working with Results

The aligner provides results in multiple formats:

- **CIGAR Tuples**: `aligner.cigartuples` returns a list of `(operation, length)` pairs.
- **CIGAR Codes**:
  - `0`: M (Match/Mismatch)
  - `1`: I (Insertion)
  - `2`: D (Deletion)
  - `4`: S (Soft-clip)
  - `7`: = (Match)
  - `8`: X (Mismatch)
- **Pretty Printing**: Use `aligner.cigar_print_pretty()` to view the alignment alignment in a human-readable format or `aligner.pretty` to get it as a string.

## Expert Tips

- **Reusing the Aligner**: You can call the aligner object directly with new sequences: `result = aligner(new_text, new_pattern)`.
- **CIGAR Clipping**: To make CIGAR strings compatible with tools like BWA or SAMtools, use `clip_cigar=True` during the call. This converts leading/trailing insertions into soft-clips (`4S`).
- **Local-like Alignment**: Use `min_aligned_bases_left` and `min_aligned_bases_right` parameters to trim short, low-quality matches at the ends of the alignment, approximating a local alignment behavior.
- **Memory Management**: For large-scale alignments, prefer `scope="score"` if the actual alignment path (CIGAR) is not required for your analysis.

## Reference documentation
- [pywfa GitHub Repository](./references/github_com_kcleal_pywfa.md)
- [pywfa Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pywfa_overview.md)