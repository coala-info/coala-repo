---
name: pybedtools-bin
description: pybedtools-bin provides a Pythonic interface to the BEDTools suite for performing genomic interval arithmetic. Use when user asks to intersect genomic intervals, subtract features, find the closest genomic features, or perform genome arithmetic using Python.
homepage: https://github.com/daler/pybedtools
---


# pybedtools-bin

## Overview
pybedtools-bin provides a Pythonic interface to the BEDTools suite, enabling sophisticated genomic analysis without the overhead of complex shell scripts. It transforms genomic files into "BedTool" objects, allowing you to chain operations like intersections and subtractions as method calls. This skill is essential for bioinformatics tasks requiring high-performance interval algebra combined with Python's logic and data handling capabilities.

## Core Usage Patterns

### Initializing BedTool Objects
Create objects from files (including gzipped), streams, or strings.
```python
from pybedtools import BedTool

# From a file
a = BedTool('peaks.bed')

# From a gzipped file
b = BedTool('genes.gff.gz')

# From a string (useful for testing)
c = BedTool('chr1 10 100', from_string=True)
```

### Common Genome Arithmetic
Most BEDTools commands are available as methods on the BedTool object.
```python
# Intersect two files
intersection = a.intersect(b)

# Subtract features (remove 'b' from 'a')
intergenic = a.subtract(b)

# Find the closest feature with distance
nearby = a.closest(b, d=True)
```

### Memory Management and Streaming
For large datasets, use the `stream=True` parameter to process features one at a time rather than loading the entire result into memory.
```python
# Stream results to handle massive files
for feature in a.intersect(b, stream=True):
    print(feature.chrom, feature.start, feature.stop)
```

### Feature Manipulation
Iterate through results to access specific attributes or perform custom filtering.
```python
# Accessing data by index or attribute
for gene in nearby:
    distance = int(gene[-1]) # Last column is often distance in 'closest'
    if distance < 5000:
        print(gene.name)
```

## Expert Tips and Best Practices

- **Chaining Operations**: You can chain multiple BEDTools commands together: `a.subtract(b).intersect(c).sort()`.
- **Temporary Files**: pybedtools automatically manages temporary files. If you need to keep a result, use the `.saveas('filename.bed')` method.
- **Format Support**: The tool seamlessly handles BED, GFF, VCF, and BAM. When working with BAM files, pybedtools often uses `samtools` or `pysam` under the hood; ensure these are available in your environment.
- **Tagging and Metadata**: When using GFF/GTF files, you can access attributes in the 9th column directly if they are formatted as key-value pairs (e.g., `feature.attrs['gene_id']`).
- **Performance**: While pybedtools is a wrapper, the underlying execution is as fast as the C++ BEDTools binaries. The main bottleneck in Python is usually the iteration over millions of features; use `stream=True` and built-in methods whenever possible to keep the heavy lifting in the compiled binaries.

## Reference documentation
- [pybedtools GitHub Repository](./references/github_com_daler_pybedtools.md)
- [pybedtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybedtools_overview.md)