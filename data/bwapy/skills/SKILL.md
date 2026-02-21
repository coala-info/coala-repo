---
name: bwapy
description: `bwapy` is a Python wrapper for the `bwa mem` aligner, enabling high-performance sequence mapping within a Pythonic environment.
homepage: https://github.com/nanoporetech/bwapy
---

# bwapy

## Overview
`bwapy` is a Python wrapper for the `bwa mem` aligner, enabling high-performance sequence mapping within a Pythonic environment. It allows developers to pass DNA sequences as strings and receive structured alignment data as named tuples. This skill is particularly useful for bioinformatics pipelines that require real-time sequence analysis, custom filtering, or the integration of BWA alignment logic directly into larger Python applications.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install bioconda::bwapy
```

## Core Usage Patterns

### Initializing the Aligner
To use `bwapy`, you must provide the path to a pre-existing BWA index. The path should be the prefix used during the `bwa index` command.

```python
from bwapy import BwaAligner

# Path to the BWA index fileset
index_path = 'path/to/reference_index'
aligner = BwaAligner(index_path)
```

### Aligning Sequences
The `align_seq` method processes a DNA sequence string and returns a list of `Alignment` objects.

```python
seq = "ACGATCGCGATCGA"
alignments = aligner.align_seq(seq)

for aln in alignments:
    print(f"Target: {aln.rname}, Position: {aln.pos}, CIGAR: {aln.cigar}")
```

### Configuring BWA MEM Options
Standard `bwa mem` command-line flags can be passed during initialization using the `options` parameter. This is essential for tuning the aligner for specific sequencing technologies.

```python
# Example: Configuring for Oxford Nanopore 2D reads
options = "-x ont2d -A 1 -B 0"
aligner = BwaAligner(index_path, options=options)
```

## Expert Tips and Best Practices

1. **Index Requirement**: `bwapy` does not include indexing functionality. You must generate the index beforehand using the standard BWA CLI tool: `bwa index <reference.fa>`.
2. **Alignment Metadata**: The returned `Alignment` named tuple provides several high-utility fields:
   - `rname`: The name of the reference sequence.
   - `orient`: The strand orientation (`+` or `-`).
   - `pos`: The 0-based starting position of the alignment.
   - `mapq`: The mapping quality score.
   - `cigar`: The CIGAR string representing the alignment.
   - `NM`: The edit distance.
3. **Memory Considerations**: The `BwaAligner` object loads the entire index into memory. Ensure your system has enough RAM to accommodate the index of your target genome (e.g., ~3GB for a human genome index).
4. **Single-Sequence Focus**: This wrapper is optimized for aligning individual sequences. Features specifically related to paired-end reads are largely disabled or unsupported in the `align_seq` interface.
5. **Maintenance Note**: This package is no longer actively maintained by Oxford Nanopore Technologies but remains a standard choice for Python-native BWA bindings.

## Reference documentation
- [bwapy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bwapy_overview.md)
- [GitHub - nanoporetech/bwapy: Python bindings to bwa mem](./references/github_com_nanoporetech_bwapy.md)