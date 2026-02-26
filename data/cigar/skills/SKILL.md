---
name: cigar
description: The cigar library parses, modifies, and performs soft-masking on CIGAR strings representing sequence alignments. Use when user asks to parse CIGAR strings, mask bases at alignment boundaries, or modify alignment operations for SAM/BAM records.
homepage: https://github.com/brentp/cigar
---


# cigar

## Overview
The `cigar` library is a specialized Python utility for parsing and modifying CIGAR strings, which represent the relationship between a sequenced read and a reference genome. Its most significant feature is the ability to perform soft-masking (converting match/mismatch operations to 'S' operations) at the boundaries of an alignment. This is essential for workflows where specific bases must be ignored by variant callers or other analysis tools without requiring a full re-alignment or complex coordinate recalculations.

## Installation
The tool is available via pip or the Bioconda channel:
```bash
pip install cigar
# OR
conda install -c bioconda cigar
```

## Core Usage Patterns

### Parsing and Inspection
Initialize a `Cigar` object with a standard CIGAR string to access its properties.
```python
from cigar import Cigar

c = Cigar('20H20M20S')
# Get total length of the alignment operations
print(len(c)) # Output: 40 (M + S, H is typically excluded from length)

# Iterate over operations
print(list(c.items())) # Output: [(20, 'H'), (20, 'M'), (20, 'S')]

# Return the string representation
print(str(c)) # Output: '20H20M20S'
```

### Soft-Masking Operations
Soft-masking is used to "hide" bases from the ends of the alignment. The library automatically merges adjacent identical operations (e.g., turning `1S1S` into `2S`) during this process.

*   **mask_left(n)**: Masks `n` bases from the start of the CIGAR string.
*   **mask_right(n)**: Masks `n` bases from the end of the CIGAR string.

```python
c = Cigar('10M20S10M')

# Mask 10 bases from the left
# The first 10M becomes 10S, which merges with the existing 20S
print(c.mask_left(10).cigar) # Output: '30S10M'

# Mask 9 bases from the left
print(c.mask_left(9).cigar)  # Output: '9S1M20S10M'
```

## Expert Tips and Best Practices
*   **Coordinate Stability**: Use `mask_left` and `mask_right` when you need to trim reads for quality or adapter contamination post-alignment. Because these operations use soft-clipping ('S'), the `POS` (leftmost mapping position) in the SAM record remains valid for the remaining matched bases.
*   **Hard-Clipping Awareness**: The library respects 'H' (Hard-clipping) operations. Note that hard-clipped bases are not included in the sequence length and are generally preserved during masking operations unless the mask length exceeds the available sequence operations.
*   **Idempotency**: Masking operations are designed to be safe. If you attempt to mask more bases than are available in a specific segment, the library handles the transition to the next operation type (e.g., moving from 'M' to 'D' or 'I') according to SAM specifications.
*   **Validation**: Always verify the resulting string using `.cigar` after a masking operation to ensure the resulting string meets the requirements of your downstream parser.

## Reference documentation
- [Cigar GitHub Repository](./references/github_com_brentp_cigar.md)
- [Bioconda Cigar Overview](./references/anaconda_org_channels_bioconda_packages_cigar_overview.md)