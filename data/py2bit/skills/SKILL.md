---
name: py2bit
description: "py2bit provides efficient random access to genomic sequences and metadata stored in the 2bit file format. Use when user asks to extract genomic sequences, retrieve chromosome lengths, calculate base composition, or identify masked regions from 2bit files."
homepage: https://github.com/deeptools/py2bit
---


# py2bit

## Overview
The `py2bit` skill enables efficient, random access to genomic data stored in the 2bit format. This format is highly compressed and commonly used by UCSC Genome Browser tools. This skill allows for fetching specific chromosomal ranges, retrieving chromosome lengths, and analyzing sequence composition without loading entire genomes into memory. It is particularly useful for high-throughput analysis where speed and memory efficiency are critical.

## Usage Patterns

### Opening and Closing Files
Always ensure the file is closed after use to free system resources.
```python
import py2bit

# Open a file (default: soft-masking ignored)
tb = py2bit.open("genome.2bit")

# Open with soft-masking support (required for softMaskedBlocks)
# Note: This increases memory usage.
tb = py2bit.open("genome.2bit", storeMasked=True)

# Perform operations...

tb.close()
```

### Metadata and Chromosome Info
Retrieve the list of available contigs and their respective lengths.
```python
# Get all chromosome lengths
chrom_dict = tb.chroms() # Returns {'chr1': 150, ...}

# Get length of a specific chromosome
length = tb.chroms("chr1")

# Get general file statistics
info = tb.info()
# Returns: file size, nChroms, sequence length, hard-masked length, soft-masked length
```

### Sequence Extraction
Extract specific genomic regions using 0-based, half-open coordinates (standard Python slicing logic).
```python
# Fetch entire chromosome
seq = tb.sequence("chr1")

# Fetch specific range (e.g., first 100 bases)
# Start: 0 (0-based), End: 100 (1-based/exclusive)
sub_seq = tb.sequence("chr1", 0, 100)
```

### Base Statistics and GC Content
Calculate the frequency of specific bases within a region.
```python
# Get fractions (0.0 to 1.0)
stats = tb.bases("chr1", 0, 100)

# Get absolute counts
counts = tb.bases("chr1", 0, 100, False)

# Example: Calculate GC content
s = tb.bases("chr1")
gc_content = s['G'] + s['C']
```

### Querying Masked Regions
Identify gaps (N-bases) or repeat-masked (lowercase) regions.
```python
# Get all hard-masked (N) blocks in a chromosome
hard_blocks = tb.hardMaskedBlocks("chr1") # Returns [(start, end), ...]

# Get soft-masked blocks overlapping a specific region
# Requires storeMasked=True during open()
soft_blocks = tb.softMaskedBlocks("chr1", 500, 1500)
```

## Expert Tips
- **Coordinate System**: `py2bit` uses 0-based start and 1-based end coordinates. To get the first base, use `(0, 1)`.
- **Performance**: If you do not need to distinguish between lowercase (soft-masked) and uppercase bases, do not set `storeMasked=True`. This keeps the memory footprint significantly lower.
- **Error Handling**: Requesting a nonexistent chromosome will trigger a `RuntimeError`. Always validate chromosome names against `tb.chroms().keys()` before fetching.
- **Long Integers**: In older Python environments, chromosome lengths may be returned as `long` types (indicated by an `L` suffix), but they behave as standard integers in Python 3.

## Reference documentation
- [py2bit GitHub README](./references/github_com_deeptools_py2bit.md)
- [Bioconda py2bit Overview](./references/anaconda_org_channels_bioconda_packages_py2bit_overview.md)