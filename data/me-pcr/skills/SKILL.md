---
name: me-pcr
description: The `me-pcr` tool is a multithreaded implementation of the NCBI Electronic PCR (e-PCR) algorithm.
homepage: https://web.archive.org/web/20100708193215/http://genome.chop.edu/mePCR/
---

# me-pcr

## Overview
The `me-pcr` tool is a multithreaded implementation of the NCBI Electronic PCR (e-PCR) algorithm. It allows researchers to simulate PCR reactions by searching a DNA database (in FASTA format) for matches to a set of primer pairs. It is designed for speed and efficiency, making it a suitable offline alternative to web-based tools like Primer-BLAST when dealing with large-scale genomic analysis or private sequence data.

## Command Line Usage
The tool typically requires a sequence file (FASTA) and a primer file (STS/Sequence Tagged Site format).

### Basic Syntax
```bash
me-pcr [options] stsfile fastafile [parameters]
```

### Common Parameters
- **M**: Margin (allowed variance in product size).
- **W**: Word size (for initial hashing).
- **F**: Number of allowed mismatches in the primer sequence.
- **X**: Disallow 3' mismatches in both primers (added in v1.0.5b for higher specificity).
- **T**: Number of threads to use for multithreaded execution.

### Input File Formats
- **FASTA file**: Standard genomic sequence file. Version 1.0.5c and later support multiple sequences within a single FASTA file.
- **STS file**: A tab-delimited file containing:
  1. Name of the marker
  2. Forward primer sequence
  3. Reverse primer sequence
  4. Expected product size (or range)

## Best Practices and Tips
- **Multithreading**: Always specify the `-T` parameter to leverage modern CPU architectures, as the primary advantage of `me-pcr` over original `e-PCR` is its multithreaded performance.
- **Specificity**: Use the `X` parameter if you need to ensure that the 3' ends of your primers match perfectly, which is critical for actual polymerase extension.
- **Small Sequences**: If working with FASTA files containing many small sequences (e.g., contigs or scaffolds), ensure you are using version 1.0.6 to avoid multithreading bugs specific to small sequence processing.
- **Platform Compatibility**: While originally developed for various Unix-like systems and Windows, the Bioconda version is optimized for `linux-64` and `macos-64`.
- **Alternatives**: If `me-pcr` does not meet specific sensitivity requirements, consider Jim Kent's `isPCR` as a secondary validation tool.

## Reference documentation
- [me-pcr - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_me-pcr_overview.md)
- [me-PCR Home (Wayback Machine)](./references/web_archive_org_web_20100708193215_http___genome.chop.edu_mePCR.md)