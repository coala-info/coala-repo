---
name: peaksql
description: PeakSQL creates a persistent SQL-based database to bridge genomic data formats with machine learning frameworks for efficient data loading. Use when user asks to initialize a genomic database, load data for machine learning training, or link reference genomes with experimental signals.
homepage: https://vanheeringen-lab.github.io/peaksql/index.html
metadata:
  docker_image: "quay.io/biocontainers/peaksql:0.0.4--py_0"
---

# peaksql

## Overview
PeakSQL provides a specialized infrastructure for bridging the gap between raw genomic data formats (BED, BigWig, Fasta) and machine learning frameworks. It allows for the creation of a persistent SQL-based database that indexes genomic regions and their associated signals, enabling fast, on-the-fly data loading during model training without the need to pre-process massive tensors.

## Core Workflows

### Database Initialization
To begin, you must create a PeakSQL database that links your reference genome with your regions of interest (peaks).
- Use the `DataBase` class to initialize a new `.sqlite` file.
- Provide the path to the reference genome (FASTA).
- Add experimental data using BED files (for regions) and BigWig files (for signal intensity).

### Data Loading for Training
Once the database is built, use the `DataSet` loaders to feed data into machine learning models (e.g., PyTorch or TensorFlow).
- **Stride and Window Size**: Define the `width` of the genomic window to be extracted.
- **Validation Split**: Use built-in methods to reserve specific chromosomes for validation/testing to avoid data leakage.

## Best Practices
- **Memory Efficiency**: PeakSQL is designed to avoid loading the entire genome into RAM. Always point to the indexed FASTA and BigWig files rather than trying to pre-load arrays.
- **Chromosome Filtering**: When training, explicitly exclude non-standard contigs (e.g., "chrUn", "random") to ensure consistent input shapes.
- **Assembly Consistency**: Ensure that the BED files and BigWig files use the exact same coordinate system and chromosome naming convention as the reference FASTA.

## Reference documentation
- [PeakSQL API Overview](./references/vanheeringen-lab_github_io_peaksql_index.html.md)
- [Installation and BioConda Metadata](./references/anaconda_org_channels_bioconda_packages_peaksql_overview.md)