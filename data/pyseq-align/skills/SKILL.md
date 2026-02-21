---
name: pyseq-align
description: The `pyseq-align` library is a Cython-based Python interface for the `seq-align` C library.
homepage: https://github.com/Lioscro/pyseq-align
---

# pyseq-align

## Overview

The `pyseq-align` library is a Cython-based Python interface for the `seq-align` C library. It is designed for speed and efficiency in pairwise sequence alignment. This skill enables the implementation of global alignments (Needleman-Wunsch) to compare sequences of similar length from end-to-end, and local alignments (Smith-Waterman) to identify highly similar regions or motifs within larger, divergent sequences.

## Installation

The package can be installed via pip or conda:

```bash
# Via pip
pip install pyseq-align

# Via Bioconda
conda install bioconda::pyseq-align
```

## Core Alignment Patterns

### Global Alignment (Needleman-Wunsch)
Use `NeedlemanWunsch` for end-to-end alignment. The `.align()` method returns a **single** `Alignment` object.

```python
from pyseq_align import NeedlemanWunsch

nw = NeedlemanWunsch()
# Align two sequences
alignment = nw.align('ACGT', 'ACGTC')

# Access results
print(f"Score: {alignment.score}")
print(f"Seq A: {alignment.result_a}") # Includes gaps, e.g., 'ACGT-'
print(f"Seq B: {alignment.result_b}") # Includes gaps, e.g., 'ACGTC'
```

### Local Alignment (Smith-Waterman)
Use `SmithWaterman` to find the best local matches. Note that the `.align()` method returns a **list** of `Alignment` objects, as there may be multiple high-scoring local alignments.

```python
from pyseq_align import SmithWaterman

sw = SmithWaterman()
alignments = sw.align('ACGT', 'ACGTC')

# Iterate through the list of local alignments
for al in alignments:
    print(f"Score: {al.score}")
    print(f"Match A: {al.result_a} at index {al.pos_a}")
    print(f"Match B: {al.result_b} at index {al.pos_b}")
```

## Tool-Specific Best Practices

- **Return Type Awareness**: Always remember that `NeedlemanWunsch.align()` returns a single object, while `SmithWaterman.align()` returns a list. Failing to iterate over the Smith-Waterman results is a common source of errors.
- **Attribute Access**:
    - `result_a` / `result_b`: The aligned sequence strings including gap characters (`-`).
    - `pos_a` / `pos_b`: The starting position of the alignment in the original sequences (particularly critical for local alignments).
    - `score`: The numerical alignment score.
- **Performance**: Since this is a wrapper for a C library, it is significantly faster than `Bio.pairwise2` or other pure-Python alternatives. It is suitable for processing large batches of pairwise alignments in loops.
- **Sequence Input**: The library expects string inputs. Ensure sequences are cleaned of whitespace or non-biological characters before passing them to the aligner.

## Reference documentation
- [pyseq-align GitHub Repository](./references/github_com_Lioscro_pyseq-align.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pyseq-align_overview.md)