---
name: oxbow
description: Oxbow is a specialized data I/O library designed to bridge the gap between traditional Next-Generation Sequencing (NGS) file formats and modern high-performance analytics ecosystems like Apache Arrow.
homepage: https://github.com/abdenlab/oxbow
---

# oxbow

## Overview
Oxbow is a specialized data I/O library designed to bridge the gap between traditional Next-Generation Sequencing (NGS) file formats and modern high-performance analytics ecosystems like Apache Arrow. It provides a high-speed translation layer, written in Rust, that allows users to stream genomic data directly into in-memory or larger-than-memory data frames. This eliminates the need for slow, intermediate text-based conversions and enables direct integration with tools like Pandas, Polars, and DuckDB.

## Installation and Setup
Oxbow is primarily distributed via Bioconda. Ensure your environment is configured to use the bioconda channel.

```bash
# Install via conda
conda install bioconda::oxbow

# For Python-specific workflows
pip install py-oxbow
```

## Core Functionality and Best Practices

### Supported Formats
Oxbow provides specialized scanners for the following genomic formats:
- **Alignment Data**: BAM, CRAM
- **Variant Data**: VCF, BCF
- **Interval/Annotation Data**: BED, GFF
- **Signal/Big Data**: BigWig, BigBed

### High-Performance Patterns
- **Arrow Integration**: Always prefer reading into Arrow RecordBatches or Tables when working with large datasets to maintain the performance benefits of the underlying Rust implementation.
- **Remote Data Access**: Oxbow supports reading directly from URLs. Use this to avoid downloading massive genomic files locally when only specific regions or metadata are needed.
- **Range Scans**: Utilize byte range and virtual position range scans for efficient random access within large indexed files.
- **Projection**: When using scanners, specify only the columns (projections) you need. This significantly reduces I/O overhead and memory footprint, especially for wide formats like VCF or GFF.

### Expert Tips
- **Coordinate Systems**: Be mindful of 0-based vs. 1-based coordinate systems. Oxbow aims to handle these sanely, but always verify the coordinate convention of your input format (e.g., BED is 0-based, VCF is 1-based) against your analysis requirements.
- **Memory Management**: For "larger-than-memory" datasets, leverage Oxbow's streaming capabilities to process data in chunks rather than loading entire files into a single data frame.
- **CRAM Reference Files**: When working with CRAM files, ensure you have access to the required reference FASTA files, as CRAM is a reference-based compression format.

## Reference documentation
- [oxbow - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_oxbow_overview.md)
- [abdenlab/oxbow GitHub Repository](./references/github_com_abdenlab_oxbow.md)
- [Oxbow Issues and Feature Requests](./references/github_com_abdenlab_oxbow_issues.md)