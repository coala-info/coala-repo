---
name: liftover
description: Liftover maps genomic point coordinates from one reference assembly to another using a high-performance C++ backend. Use when user asks to convert coordinates between assemblies, fetch UCSC chain files, or perform cross-assembly genomic data normalization.
homepage: https://github.com/jeremymcrae/liftover
---


# liftover

## Overview

`liftover` is a high-performance Python utility, accelerated with C++, designed to map genomic point coordinates from one reference assembly to another. It provides a dictionary-style interface for coordinate conversion and is significantly faster and more memory-efficient than traditional pure-python implementations like `pyliftover`. Use this skill to automate the retrieval of UCSC chain files or to process local chain files for genomic data normalization and cross-assembly analysis.

## Installation

Install the package via pip or conda:

```bash
pip install liftover
# OR
conda install bioconda::liftover
```

## Basic Usage

The most common workflow involves using `get_lifter` to automatically fetch and cache chain files from UCSC.

```python
from liftover import get_lifter

# Initialize the converter (e.g., hg19 to hg38)
# Set one_based=True if your input coordinates are 1-based (like VCF or GFF)
converter = get_lifter('hg19', 'hg38', one_based=True)

chrom = '1'
pos = 103786442

# Dictionary-style access (returns a list of possible mappings)
results = converter[chrom][pos]

# Explicit method calls
results = converter.convert_coordinate(chrom, pos)
results = converter.query(chrom, pos)
```

## Working with Local Chain Files

If working in an offline environment or using custom assemblies, use the `ChainFile` class to load local `.chain.gz` files.

```python
from liftover import ChainFile

# Load a specific local chain file
converter = ChainFile('/path/to/hg18ToHg38.over.chain.gz', one_based=True)

# Query coordinates as usual
results = converter['chr1'][123456]
```

## Best Practices and Expert Tips

- **Coordinate Systems**: Always verify if your data is 0-based (BED format) or 1-based (VCF, GFF, most human-readable formats). Use the `one_based` parameter during initialization to match your input data.
- **Handling Multiple Mappings**: The converter returns a list of tuples `(target_chrom, target_pos, target_strand, conversion_score)`. Even if a point maps uniquely, it is returned as a list. Always handle the case where the list might be empty (no mapping) or contain multiple entries (complex regions).
- **Performance**: For bulk processing, initialize the `lifter` object once and reuse it. The C++ backend handles the heavy lifting, making it suitable for iterating over millions of rows in a dataframe or VCF.
- **Missing Contigs**: Recent versions of the library handle missing chromosomes or contigs gracefully without raising errors, returning an empty result instead.
- **Custom Mirrors**: If the UCSC servers are down or slow, specify an alternative mirror using the `chain_server` argument in `get_lifter`.

## Reference documentation
- [liftover GitHub Repository](./references/github_com_jeremymcrae_liftover.md)
- [Bioconda liftover Overview](./references/anaconda_org_channels_bioconda_packages_liftover_overview.md)