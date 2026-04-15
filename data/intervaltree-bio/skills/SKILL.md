---
name: intervaltree-bio
description: The intervaltree-bio library provides a high-level interface for managing and querying genomic intervals partitioned by chromosome. Use when user asks to load genomic features from UCSC tables, manage chromosome-specific interval trees, or perform efficient range-based searches on genomic data.
homepage: https://github.com/konstantint/intervaltree-bio
metadata:
  docker_image: "biocontainers/intervaltree-bio:v1.0.1-3-deb-py3_cv1"
---

# intervaltree-bio

## Overview

The `intervaltree-bio` library provides a high-level interface for handling genomic data that is typically partitioned by chromosome. While a standard interval tree manages a single coordinate system, `GenomeIntervalTree` acts as a container that automatically manages separate trees for each chromosome. This skill facilitates the rapid loading of genomic features directly from public databases or local files and enables efficient range-based searches.

## Installation and Setup

Install the package via pip. It automatically handles the dependency on the core `intervaltree` library.

```bash
pip install intervaltree-bio
```

## Core Usage Patterns

### Initializing and Loading Data
The most powerful feature is the ability to pull data directly from UCSC. By default, `from_table()` fetches the `knownGene` table.

```python
from intervaltree_bio import GenomeIntervalTree

# Load default knownGene table from UCSC
gtree = GenomeIntervalTree.from_table()

# Load a specific table or from a custom URL/file
# Note: Consult the method docstring for specific schema requirements
refgene = GenomeIntervalTree.from_table(table='refGene')
```

### Querying Intervals
Queries are performed by accessing the specific chromosome (often as a byte string) and using the `search` method.

```python
# Search for features on chr1 between positions 100,000 and 138,529
# Returns a set of Interval objects: Interval(start, end, data)
result = gtree[b'chr1'].search(100000, 138529)

for interval in result:
    print(f"Start: {interval.begin}, End: {interval.end}, Data: {interval.data}")
```

### Working with Local Files
You can populate a tree using local genomic files, such as BED files, which are standard for genomic intervals.

```python
# Loading from a local BED file
gtree = GenomeIntervalTree()
with open('features.bed', 'r') as f:
    # Implementation depends on specific file parsing, 
    # but generally involves adding intervals to specific chromosome trees
    pass
```

## Expert Tips and Best Practices

- **Chromosome Naming**: Be consistent with chromosome naming conventions (e.g., "chr1" vs "1"). The library often uses byte strings (`b'chr1'`) for keys when loading from UCSC tables; ensure your query keys match the type used during initialization.
- **Memory Management**: For very large genomes or dense annotations, `GenomeIntervalTree` can consume significant RAM. If you only need specific chromosomes, filter the data during the loading phase if possible.
- **Data Payload**: The `data` attribute of the returned `Interval` objects contains the metadata from the source table (e.g., gene IDs or strand information). Use this to link spatial overlaps back to functional genomic data.
- **Pickling**: The library supports pickling, allowing you to save a pre-built `GenomeIntervalTree` to disk to avoid re-downloading or re-parsing large UCSC tables in subsequent runs.

## Reference documentation
- [Intervaltree-Bio Main Repository](./references/github_com_konstantint_intervaltree-bio.md)