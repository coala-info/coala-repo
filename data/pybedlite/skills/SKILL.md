---
name: pybedlite
description: pybedlite provides a streamlined, object-oriented approach to handling genomic intervals.
homepage: https://pypi.org/project/pybedlite/
---

# pybedlite

## Overview
pybedlite provides a streamlined, object-oriented approach to handling genomic intervals. Unlike heavier libraries, it focuses on providing a "lite" set of Python classes that map directly to BED format specifications. It is ideal for bioinformatics workflows where you need to iterate over genomic regions, check for overlaps, or modify interval coordinates programmatically without the overhead of a full suite of genomic tools.

## Core Usage Patterns

### Basic Interval Handling
The library revolves around the `BedRecord` and `BedFile` classes. Use these to interact with standard 3-6 column BED files.

```python
from pybedlite import BedFile

# Reading a BED file
with BedFile("regions.bed") as bed:
    for record in bed:
        # Access standard fields
        chrom = record.chrom
        start = record.start
        end = record.end
        name = record.name
        score = record.score
        strand = record.strand
```

### Filtering and Manipulation
pybedlite is designed for fast, in-memory filtering of records.

```python
# Example: Filter for high-score regions on a specific chromosome
high_quality_regions = [
    rec for rec in BedFile("input.bed") 
    if rec.chrom == "chr1" and rec.score > 500
]

# Modifying coordinates (e.g., adding a 10bp buffer)
for rec in high_quality_regions:
    rec.start = max(0, rec.start - 10)
    rec.end += 10
```

### Writing BED Files
To export data, use the `BedWriter` class to ensure the output adheres to the tab-delimited BED standard.

```python
from pybedlite import BedWriter

with BedWriter("output.bed") as writer:
    for rec in high_quality_regions:
        writer.write(rec)
```

## Best Practices
- **Context Managers**: Always use `with` statements when opening `BedFile` or `BedWriter` to ensure file handles are closed correctly, especially when processing large genomic datasets.
- **Zero-Based Indexing**: Remember that pybedlite follows the BED convention (0-based, half-open intervals). The `start` is inclusive, and the `end` is exclusive.
- **Memory Management**: For extremely large BED files, avoid loading all records into a list. Iterate over the `BedFile` object directly to process records one at a time.
- **Validation**: Use pybedlite to validate BED format integrity before passing data to more complex downstream tools like Bedtools or Samtools.

## Reference documentation
- [pybedlite Overview](./references/anaconda_org_channels_bioconda_packages_pybedlite_overview.md)
- [PyPI Project Details](./references/pypi_org_project_pybedlite.md)