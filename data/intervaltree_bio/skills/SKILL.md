---
name: intervaltree_bio
description: The intervaltree_bio library provides a GenomeIntervalTree structure to manage and search genomic intervals across multiple chromosomes. Use when user asks to load UCSC annotation tables, search for genomic features by coordinates, or parse BED and GenePred files into an interval tree.
homepage: https://github.com/konstantint/intervaltree-bio
---


# intervaltree_bio

## Overview
The `intervaltree_bio` library is a specialized extension of the Python `intervaltree` package, tailored for bioinformatics workflows. While a standard interval tree handles a single coordinate system, genomic data is split across multiple chromosomes. This skill provides a `GenomeIntervalTree` structure that automatically manages a separate tree for each chromosome, offering a unified interface for loading and searching genomic features.

## Installation
Ensure the package and its dependencies are installed in your environment:
```bash
pip install intervaltree-bio
```

## Core Usage Patterns

### Loading UCSC Annotation Tables
The most powerful feature is the ability to pull live data from the UCSC Genome Browser.
```python
from intervaltree_bio import GenomeIntervalTree

# Load the default 'knownGene' table from UCSC
known_gene = GenomeIntervalTree.from_table()

# Load a specific table like 'refGene'
ref_gene = GenomeIntervalTree.from_table(table='refGene')
```

### Searching Intervals
Queries are performed by accessing the specific chromosome (often as a byte string or string depending on the source) and using the `search` method.
```python
# Search for features on chr1 between positions 100,000 and 138,529
# Note: UCSC data often uses byte strings for chromosome names
result = known_gene[b'chr1'].search(100000, 138529)

for interval in result:
    print(f"Start: {interval.begin}, End: {interval.end}, Data: {interval.data}")
```

### Working with Local Files
You can populate a tree from local genomic files such as BED or GenePred formats.
```python
# Loading from a BED file
with open('annotations.bed', 'r') as f:
    tree = GenomeIntervalTree.from_bed(f)

# Loading from a GenePred file
with open('genes.txt', 'r') as f:
    tree = GenomeIntervalTree.from_genepred(f)
```

## Expert Tips and Best Practices

### Chromosome Key Consistency
The library often defaults to byte strings (e.g., `b'chr1'`) when loading directly from UCSC tables. If your search returns no results but you are sure the data exists, check if your keys are `str` vs `bytes`. You can normalize the tree keys if necessary after loading.

### Memory Management
`GenomeIntervalTree` loads the entire table into RAM. For very large datasets (like whole-genome SNP sets), ensure your environment has sufficient memory. For standard gene annotations (knownGene, refGene), memory usage is typically modest.

### Custom Data Parsing
When using `from_table`, you can provide a custom `url` or `fileobj` if you have a local copy of a UCSC-formatted table but want to use the library's built-in parser.

### Interval Data
Each object returned by a search is an `Interval` object. The `data` attribute of this object contains the additional columns from the source file (e.g., gene name, strand, or score), allowing for complex filtering after the spatial search.

## Reference documentation
- [Intervaltree-Bio README](./references/github_com_konstantint_intervaltree-bio.md)
- [Project Commits (GenePred support)](./references/github_com_konstantint_intervaltree-bio_commits_master.md)