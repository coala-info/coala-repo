---
name: pydustmasker
description: pydustmasker is a high-performance Python library designed to detect and mask low-complexity DNA sequences.
homepage: https://github.com/apcamargo/pydustmasker
---

# pydustmasker

## Overview
pydustmasker is a high-performance Python library designed to detect and mask low-complexity DNA sequences. It provides implementations of two primary algorithms: **SDUST**, which is the standard for identifying short symmetric repeats, and **Longdust**, optimized for finding low-complexity regions in longer sequences. This tool is essential in bioinformatics workflows to prevent non-specific alignments caused by repetitive or biased nucleotide compositions.

## Core Usage Patterns

### Basic Masking
To mask a sequence, instantiate a masker object with your nucleotide string.

```python
import pydustmasker

seq = "CGTATATATATAGTATGCGTACTGGGGGGGCT"

# Use DustMasker for SDUST algorithm
masker = pydustmasker.DustMasker(seq)

# Soft-masking (default): converts LCRs to lowercase
soft_masked = masker.mask() 
# Result: 'CGTATATATATAGTATGCGTACTgggggggCT'

# Hard-masking: replaces LCRs with 'N'
hard_masked = masker.mask(hard = True)
# Result: 'CGTATATATATAGTATGCGTACTNNNNNNNCT'
```

### Accessing Region Metadata
You can retrieve specific details about the detected regions without generating a new string.

- `len(masker)`: Returns the count of low-complexity regions.
- `masker.n_masked_bases`: Returns the total number of bases identified as low-complexity.
- `masker.intervals`: Returns a tuple of `(start, end)` coordinates.
- **Iteration**: The masker object itself is iterable, yielding `(start, end)` pairs.

```python
for start, end in masker:
    print(f"LCR found at {start}-{end}: {seq[start:end]}")
```

### Algorithm Selection and Tuning
- **DustMasker**: Best for general purpose masking and compatibility with legacy BLAST-style DUST requirements.
- **LongdustMasker**: Preferred for long-read data or when looking for extended low-complexity regions.
- **Sensitivity**: Both classes accept a `score_threshold` parameter. 
    - **Lower threshold**: More aggressive masking (detects more regions).
    - **Higher threshold**: More conservative masking (only detects highly repetitive regions).

```python
# Increase sensitivity
sensitive_masker = pydustmasker.DustMasker(seq, score_threshold=10)
```

## Expert Tips and Best Practices

### Parallel Processing
pydustmasker is efficient but processing large FASTA files (e.g., whole genomes) should be done in parallel. Use `multiprocessing` to distribute sequences across CPU cores.

```python
import multiprocessing.pool
import pydustmasker
from Bio import SeqIO

def process_seq(record):
    # Convert BioPython record to string for pydustmasker
    masker = pydustmasker.DustMasker(str(record.seq))
    return record.id, masker.mask()

if __name__ == "__main__":
    with multiprocessing.pool.Pool() as pool:
        results = pool.map(process_seq, SeqIO.parse("input.fasta", "fasta"))
```

### Memory Management
When dealing with very large sequences, avoid creating multiple copies of the sequence string. pydustmasker is designed to be memory-efficient, but the `mask()` method creates a new string. If you only need coordinates for downstream filtering, use the `intervals` property to save memory.

### Handling Ambiguous Bases
The algorithms are designed for nucleotide sequences (A, C, G, T). While the library handles 'N' bases (often treating them as 'A' to prevent out-of-range errors in specific versions), it is best practice to ensure your input strings are cleaned of non-IUPAC characters before masking.

## Reference documentation
- [pydustmasker GitHub Repository](./references/github_com_apcamargo_pydustmasker.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pydustmasker_overview.md)