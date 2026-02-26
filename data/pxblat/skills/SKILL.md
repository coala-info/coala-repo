---
name: pxblat
description: "pxblat provides a high-performance Python interface for executing BLAT alignments on genomic sequences with high identity. Use when user asks to align DNA or protein sequences to a reference, perform near-perfect sequence alignments, or run BLAT programmatically within a Python environment."
homepage: https://pypi.org/project/pxblat/
---


# pxblat

## Overview
pxblat provides a high-performance, ergonomic interface for BLAT, optimized for speed and ease of use within the Python ecosystem. It is particularly effective for "near-perfect" alignments where sequences share 95% or greater identity. This skill facilitates the execution of alignments, handling of genomic data formats, and programmatic access to BLAT's alignment engine without the overhead of traditional shell-wrapping.

## Usage Patterns

### Command Line Interface
The basic syntax for pxblat follows the standard BLAT logic but with improved argument handling:

```bash
# Basic DNA alignment
pxblat reference.2bit query.fasta output.psl

# Protein to DNA alignment (translated)
pxblat reference.2bit query.fasta output.psl -t=dnax -q=prot
```

### Python API Integration
For programmatic workflows, use the `pxblat` module to run alignments directly on sequences or files:

```python
import pxblat

# Aligning a query file against a reference
pxblat.align("reference.2bit", "query.fa", "results.psl", minIdentity=90)
```

## Best Practices
- **Reference Formats**: Use `.2bit` files for the reference genome whenever possible to reduce memory footprint and initialization time.
- **Sensitivity Tuning**: Adjust the `-minIdentity` (default is often 90) and `-tileSize` parameters based on the divergence of your sequences. Smaller tile sizes increase sensitivity but decrease speed.
- **Output Handling**: pxblat defaults to PSL format. Use downstream tools or Python parsers to convert PSL to BED or SAM if required for genomic pipelines.
- **Memory Management**: When processing large batches of queries, pxblat is more efficient than spawning multiple standalone BLAT processes as it manages the binding overhead more effectively.

## Reference documentation
- [pxblat Project Overview](./references/pypi_org_project_pxblat.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pxblat_overview.md)