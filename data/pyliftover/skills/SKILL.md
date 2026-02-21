---
name: pyliftover
description: `pyliftover` is a pure-Python implementation of the UCSC `liftOver` tool.
homepage: https://github.com/konstantint/pyliftover
---

# pyliftover

---

## Overview

`pyliftover` is a pure-Python implementation of the UCSC `liftOver` tool. It allows for the conversion of genomic point coordinates between different assemblies by utilizing coordinate conversion mappings (chain files). While the original UCSC tool is a standalone binary, `pyliftover` provides a library-native way to perform these conversions within Python scripts, making it highly suitable for data processing pipelines and Jupyter notebooks.

## Installation

Install the package via pip or conda:

```bash
# Via pip
pip install pyliftover

# Via bioconda
conda install bioconda::pyliftover
```

## Core Usage Patterns

### Basic Coordinate Conversion
The most common workflow involves initializing a `LiftOver` object with the source and target assembly names. The library will automatically attempt to download the required chain file from UCSC if it is not found locally.

```python
from pyliftover import LiftOver

# Initialize for hg17 to hg18 conversion
lo = LiftOver('hg17', 'hg18')

# Convert a specific coordinate
# Arguments: chromosome, 0-based position
results = lo.convert_coordinate('chr1', 1000000)

# results is a list of tuples: (target_chromosome, target_position, strand, conversion_chain_score)
# Example output: [('chr1', 1003221, '+', 543210)]
```

### Using Local Chain Files
To avoid network dependency or to use custom/non-UCSC assemblies, provide the path to a local `.over.chain.gz` file.

```python
lo = LiftOver('/path/to/hg19ToHg38.over.chain.gz')
results = lo.convert_coordinate('chrX', 5000000)
```

### Handling Strands
You can specify the strand for the source coordinate to get the corresponding position in the target assembly.

```python
# Convert coordinate on the negative strand
results = lo.convert_coordinate('chr1', 1000000, '-')
```

## Expert Tips and Best Practices

### 1. Coordinate System Awareness (0-based)
`pyliftover` uses **0-based coordinates**. 
- If you are pulling coordinates from the UCSC Genome Browser (which is 1-based), you must subtract 1 from the position before passing it to `convert_coordinate`.
- Example: `chr1:10` in the browser is `9` in `pyliftover`.

### 2. Interpreting Results
The `convert_coordinate` method returns a list, which handles three scenarios:
- **None**: The source chromosome name was not recognized in the chain file.
- **Empty List `[]`**: The locus was deleted in the target assembly.
- **Single Element List**: The locus matched uniquely (most common).
- **Multiple Element List**: The locus matched multiple locations in the target assembly (rare for intra-species conversions but possible).

### 3. Performance and Caching
The library caches downloaded chain files in the current working directory or a temporary directory. For production environments or high-throughput clusters, it is best practice to pre-download the required `.over.chain.gz` files and reference them by absolute path to prevent race conditions or network timeouts during parallel execution.

### 4. Limitations
- **Point Coordinates Only**: `pyliftover` is designed for single-point conversion. It does not natively support BED file ranges or block conversions. To lift over a range, you must lift over the start and end points separately and verify they are still on the same chromosome and strand in the target.
- **Memory**: Since it is pure Python, it may be slower than the C-binary for millions of coordinates. For massive datasets, consider batching or using the `LiftOver` object as a persistent instance rather than re-initializing.

## Reference documentation
- [pyliftover Overview](./references/anaconda_org_channels_bioconda_packages_pyliftover_overview.md)
- [pyliftover GitHub Repository](./references/github_com_konstantint_pyliftover.md)