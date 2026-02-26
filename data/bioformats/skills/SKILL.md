---
name: bioformats
description: The bioformats library provides Python classes for extracting and manipulating data from various biological file formats. Use when user asks to parse bioinformatics files, integrate genomic data into a pipeline, or perform exploratory analysis on biological records.
homepage: https://github.com/gtamazian/bioformats
---


# bioformats

## Overview
The `bioformats` library is a Python-based toolkit designed to simplify the handling of bioinformatics data. It provides a collection of classes that abstract the complexities of various biological file formats, allowing for efficient data extraction and manipulation within Python scripts. Use this skill when you need to integrate bioinformatics file parsing into a data science pipeline or when performing exploratory analysis on genomic data.

## Usage Guidelines

### Installation
Ensure the package is available in your environment:
```bash
conda install -c bioconda bioformats
```

### Core Functionality
The library is structured around Python classes representing specific bioinformatics formats. While the specific API depends on the format being handled, the general workflow involves:

1.  **Importing the relevant format class**: Identify the specific class within the `bioformats` package that corresponds to your data (e.g., FASTA, FASTQ, SAM/BAM, or VCF).
2.  **Initialization**: Instantiate the class by passing the path to your data file.
3.  **Iteration and Access**: Use standard Pythonic patterns (like iterators) to process records one by one to maintain memory efficiency.

### Best Practices
- **Memory Management**: When dealing with large genomic files (like FASTQ or BAM), always use the provided iterators rather than loading the entire file into memory.
- **Error Handling**: Wrap file parsing logic in try-except blocks to handle malformed records or unexpected EOF markers common in large-scale sequencing data.
- **Integration**: Use `bioformats` as a lightweight alternative to heavier libraries when you only need basic parsing and object-oriented access to biological records.

## Reference documentation
- [bioformats Overview](./references/anaconda_org_channels_bioconda_packages_bioformats_overview.md)