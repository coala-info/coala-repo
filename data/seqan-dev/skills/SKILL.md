---
name: seqan-dev
description: This tool provides specialized knowledge for developing high-performance biological sequence analysis applications using the SeqAn C++ library. Use when user asks to implement efficient genomic algorithms, perform SIMD-accelerated sequence alignments, manage high-throughput sequencing I/O, or build tools within the Bioconda ecosystem.
homepage: http://www.seqan.de/
---


# seqan-dev

## Overview
This skill provides specialized knowledge for working with SeqAn, a high-performance C++ library designed for biological sequence analysis. It focuses on leveraging SeqAn's generic design to implement efficient algorithms for genomic data, including pairwise/multiple alignments and SIMD-accelerated processing. Use this skill to navigate SeqAn's modular architecture, handle high-throughput sequencing I/O, and deploy SeqAn-based tools within the Bioconda ecosystem.

## Installation and Setup
The preferred method for obtaining the SeqAn library and its official applications is through Bioconda.

- **Conda Install**: `conda install bioconda::seqan`
- **Version Note**: The current stable release is 2.5.2. Ensure your environment is configured for the `bioconda` and `conda-forge` channels.
- **Development Requirements**: As a C++ template library, SeqAn requires a modern C++ compiler (GCC or Clang) and CMake for build configuration.

## Core Development Patterns
SeqAn uses a unique generic programming design. Follow these patterns for efficient implementation:

- **Data Structures**: Use SeqAn's unified interface for string indices (e.g., FM-index, Suffix Arrays) to perform rapid pattern matching.
- **Alignment**: Utilize the alignment module for both global and local pairwise alignments. For high-performance needs, ensure SIMD vectorization is enabled in your compiler flags to take advantage of SeqAn's hardware acceleration.
- **I/O Modules**: For large-scale genomic data (FASTA/FASTQ/SAM/BAM), use the dedicated I/O modules which are optimized for speed and memory efficiency.
- **Parallelization**: Leverage SeqAn's built-in support for multi-core processing when implementing compute-intensive algorithms like multiple sequence alignment or filter-based searches.

## Expert Tips
- **Generic Design**: Remember that SeqAn relies heavily on templates. While this guarantees high performance, it can lead to long compilation times; use precompiled headers or modularize your code to mitigate this.
- **Memory Management**: When working with pangenomic data or large indices, utilize SeqAn's succinct data structures to minimize the memory footprint.
- **Integration**: SeqAn is designed to be extensible. You can integrate it with other C++ libraries, but ensure that your build system correctly links the SeqAn headers as it is primarily a header-only library with some compiled components in version 2.x.

## Reference documentation
- [SeqAn Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqan_overview.md)
- [SeqAn Project Homepage](./references/www_seqan_de_index.md)