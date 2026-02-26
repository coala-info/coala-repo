---
name: libgenome
description: libgenome is a C++ library designed for high-performance genomic sequence manipulation, file format parsing, and annotation data handling. Use when user asks to parse FASTA or GenBank files, manipulate large-scale annotation data, or develop custom tools for comparative genomics.
homepage: http://darlinglab.org/mauve/
---


# libgenome

## Overview
This skill provides guidance for utilizing the libGenome library to streamline genomic data processing. It is specifically designed for developers and bioinformaticians who need to handle complex sequence operations, such as parsing diverse file formats (FASTA, GenBank, etc.) or manipulating large-scale annotation data. libGenome serves as the foundational engine for the Mauve genome alignment software, making it essential for tasks requiring high-performance sequence analysis and comparative genomics.

## Implementation Patterns
As a C++ development library, libGenome is primarily used by linking against it in bioinformatics software projects.

### Environment Setup
Install the library via bioconda to ensure all dependencies and headers are correctly configured:
```bash
conda install -c bioconda libgenome
```

### Core Capabilities
- **Format Conversion**: Seamlessly move between sequence formats while preserving metadata.
- **Annotation Handling**: Programmatically access and modify feature tables and sequence descriptors.
- **Sequence Manipulation**: Perform efficient slicing, dicing, and concatenation of large genomic sequences.

### Integration with Mauve
Since libGenome is the core library for the Mauve aligner, use it when you need to:
- Pre-process sequences before running `progressiveMauve`.
- Parse or extract specific regions from Mauve-generated alignment files.
- Develop custom tools that require the same sequence-handling logic used in large-scale comparative genomics.

## Best Practices
- **Memory Management**: When working with large eukaryotic genomes, leverage libGenome's efficient data structures to minimize memory overhead.
- **Header Inclusion**: Ensure your C++ project includes the appropriate libGenome headers (e.g., `#include <libgenome/gnSequence.h>`) to access the object-oriented sequence API.
- **Linking**: When compiling, ensure you link against the library using the `-lgenome` flag.

## Reference documentation
- [libgenome Overview](./references/anaconda_org_channels_bioconda_packages_libgenome_overview.md)