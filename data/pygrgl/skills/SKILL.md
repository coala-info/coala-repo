---
name: pygrgl
description: pygrgl manages large-scale genomic data using graph-based representations for efficient storage and high-performance access. Use when user asks to convert VCF files into indexed graph structures, build representations from reference genomes, or query genotypes from massive cohorts.
homepage: https://aprilweilab.github.io/
metadata:
  docker_image: "quay.io/biocontainers/pygrgl:2.6--py310h275bdba_0"
---

# pygrgl

## Overview
The `pygrgl` library is a specialized tool designed for the high-performance management of large-scale genomic data. It utilizes graph-based representations to store genotypes, allowing researchers to handle datasets that would otherwise exceed memory limits of traditional formats. This skill provides the necessary patterns for installing and utilizing the library's core functionality for efficient genetic data representation.

## Installation and Environment
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.

```bash
# Install pygrgl via conda
conda install -c bioconda pygrgl
```

## Core CLI Patterns
While specific subcommands depend on the version, the general workflow for `pygrgl` involves converting standard genomic formats (like VCF) into the optimized graph representation.

### Data Indexing and Storage
Use `pygrgl` to transform flat genetic files into indexed graph structures. This is essential for:
- Reducing disk footprint of massive cohorts.
- Enabling fast random access to specific genomic regions.
- Facilitating memory-mapped operations on genotype matrices.

### Common Operations
- **Graph Construction**: Building the representation from reference genomes and variant calls.
- **Querying**: Extracting specific genotypes or subgraphs based on sample IDs or genomic coordinates.
- **Integration**: Using the Python API to interface with downstream analysis pipelines in NumPy or SciPy.

## Expert Tips
- **Memory Mapping**: `pygrgl` is designed for efficiency; when working with "huge" datasets, ensure your filesystem supports memory mapping for optimal performance.
- **Bioconda Compatibility**: Always check for the latest version (e.g., 2.6) to ensure compatibility with modern Linux and macOS (x86_64) environments.
- **Graph vs. Matrix**: Use the graph representation when dealing with high-density variation where traditional bit-packed matrices become sparse or inefficient.

## Reference documentation
- [pygrgl Overview](./references/anaconda_org_channels_bioconda_packages_pygrgl_overview.md)
- [Wei Lab Homepage](./references/aprilweilab_github_io_index.md)