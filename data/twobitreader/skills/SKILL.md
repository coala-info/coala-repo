---
name: twobitreader
description: twobitreader efficiently retrieves DNA sequences from .2bit genomic files. Use when user asks to retrieve DNA sequences from .2bit files, extract sequences for genomic regions defined in BED files, convert genomic regions to FASTA, or access specific sequences from a .2bit genome file.
homepage: https://github.com/benjschiller/twobitreader
---


# twobitreader

## Overview
twobitreader is a high-performance Python-based utility for interacting with .2bit genomic sequence files. It allows researchers to efficiently retrieve DNA sequences for specific coordinates without decompressing entire genome assemblies. Use this skill when you need to convert genomic regions defined in BED files into FASTA sequences or when performing programmatic sequence analysis in Python.

## Installation
The package can be installed via pip or conda:
- **Conda**: `conda install bioconda::twobitreader`
- **Pip**: `pip install twobitreader`

## Command Line Usage
The primary CLI pattern involves piping a BED file into the module to extract sequences.

### Basic Sequence Extraction
To extract sequences for regions defined in a BED file:
```bash
python -m twobitreader genome.2bit < regions.bed
```
The tool reads chromosome names and coordinates from the BED file and outputs the corresponding sequences to standard output.

## Python API Usage
For more complex workflows, use the `TwoBitFile` class for random access.

### Loading a Genome
```python
import twobitreader

# Open the .2bit file
genome = twobitreader.TwoBitFile('hg38.2bit')

# List available chromosomes/contigs
print(genome.keys())
```

### Accessing Specific Sequences
The object supports slicing, which is highly efficient for large genomes:
```python
# Extract a specific region (0-indexed, half-open interval)
# Example: chr1 from base 100 to 200
sequence = genome['chr1'][100:200]

# Get the full length of a chromosome
chrom_len = len(genome['chr1'])
```

## Best Practices and Tips
- **Memory Efficiency**: `twobitreader` uses memory mapping, making it suitable for environments with limited RAM even when working with large mammalian genomes.
- **Coordinate Systems**: Always remember that .2bit files and the `twobitreader` Python API use **0-indexed** coordinates. Ensure your input coordinates match this convention to avoid "off-by-one" errors.
- **Handling Masking**: The .2bit format supports both "N" (unknown bases) and soft-masking (lowercase bases). `twobitreader` preserves these masks during extraction.
- **Batch Processing**: When using the CLI, it is significantly faster to provide a single BED file with multiple regions than to call the script repeatedly for individual regions.

## Reference documentation
- [twobitreader GitHub Repository](./references/github_com_benjschiller_twobitreader.md)
- [Bioconda twobitreader Overview](./references/anaconda_org_channels_bioconda_packages_twobitreader_overview.md)