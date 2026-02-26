---
name: bionumpy
description: BioNumPy is a Python library that extends NumPy's array programming capabilities to biological datasets for high-performance genomic analysis. Use when user asks to process large-scale genomic files like FASTQ or BAM in chunks, perform vectorized operations on biological sequences, or manipulate genomic intervals using memory-efficient array structures.
homepage: https://github.com/bionumpy/bionumpy
---


# bionumpy

## Overview

BioNumPy is a Python library that extends NumPy's array programming capabilities to biological datasets. It provides a high-performance interface for reading common bioinformatics file formats directly into NumPy-like structures, such as `EncodedRaggedArray`. Use this skill when you need to perform large-scale genomic analysis where memory efficiency and execution speed are critical, allowing you to treat biological sequences as arrays for vectorized operations.

## Core Usage Patterns

### Reading and Processing Data
BioNumPy uses a unified `open` interface for various formats. For large files, it is best practice to iterate through the file in chunks to maintain a low memory footprint.

```python
import bionumpy as bnp
import numpy as np

# Open a FASTQ file
file = bnp.open("data.fq.gz")

# Process in chunks
for chunk in file:
    # Perform vectorized operations on the sequence array
    # Example: Count occurrences of 'G' in each read
    g_counts = np.sum(chunk.sequence == "G", axis=-1)
    print(g_counts)
```

### Working with Genomic Intervals
You can read BED files and perform operations on genomic coordinates using standard NumPy indexing and logic.

```python
# Read a BED file
intervals = bnp.open("intervals.bed").read()

# Filter intervals by length
lengths = intervals.stop - intervals.start
long_intervals = intervals[lengths > 1000]
```

### BAM File Integration
BioNumPy supports indexed BAM files for random access, which is essential for subsetting large alignments.

```python
# Open an indexed BAM file
bam_file = bnp.open_indexed("alignments.bam")

# Fetch alignments for a specific region
region_data = bam_file["chr1"][100:500]
```

## Expert Tips and Best Practices

- **Memory Mapping**: For extremely large datasets that do not fit in RAM, use memory mapping features (where supported) to achieve random access without loading the entire array.
- **Vectorization**: Avoid writing `for` loops over sequences. Instead, use BioNumPy's encoded arrays to perform operations across the entire chunk at once (e.g., `chunk.sequence == "A"`).
- **K-mer Extraction**: Use the built-in k-mer extraction functions to transform sequences into numerical representations for machine learning or statistical analysis. Note that for very small k (e.g., k=1), ensure you are using the latest version to avoid known edge-case bugs.
- **Custom Data Classes**: If working with non-standard tab-delimited formats, you can define a `bnpdataclass` to map your file columns to BioNumPy fields.

## Reference documentation
- [BioNumPy Main Repository](./references/github_com_bionumpy_bionumpy.md)
- [Installation and Versions](./references/anaconda_org_channels_bioconda_packages_bionumpy_overview.md)
- [Recent Feature Commits (Memmapping and BAM indexing)](./references/github_com_bionumpy_bionumpy_commits_main.md)