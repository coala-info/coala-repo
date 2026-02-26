---
name: seqan3
description: SeqAn3 is a modern C++ template library designed for high-performance biological sequence analysis and bioinformatics application development. Use when user asks to install the library via Bioconda, perform sequence alignment, query large nucleotide collections with Raptor, or call structural variants using iGenVar.
homepage: https://www.seqan.de
---


# seqan3

## Overview
SeqAn3 is a modern C++ template library designed for efficient biological sequence analysis. It serves as a foundation for developing high-performance bioinformatics applications, offering specialized data structures for pangenomics, sequence alignment algorithms, and multi-threaded I/O. Use this skill to understand the SeqAn3 environment, identify the correct official applications for specific genomic tasks, and manage the library's installation.

## Installation and Setup
The primary method for installing the SeqAn3 library and its dependencies is through the Bioconda channel.

*   **Conda Installation**:
    ```bash
    conda install bioconda::seqan3
    ```
*   **Compiler Requirements**: SeqAn3 requires modern C++ support. Ensure your environment uses GCC 12 or GCC 13 (supported as of version 3.3.0). Support for older versions like GCC 10 has been deprecated.

## Official SeqAn3 Applications
SeqAn3 powers several specialized tools. Use these specific applications for the following tasks:

*   **Raptor**: Use for fast and space-efficient pre-filtering when querying very large collections of nucleotide sequences (approximate searches).
*   **Chopper**: Use to optimize the space consumption of Hierarchical Binning Directories (HBD).
*   **Needle**: Use for estimating the quantification of large nucleotide sequence collections.
*   **iGenVar**: Use for structural variant (SV), indel, and SNP calling using both short and long reads.
*   **MaRs**: Use for motif-based aligned RNA searches.

## Expert Tips and Best Practices
*   **Argument Parsing**: If developing custom tools using SeqAn3 logic, use **Sharg** (the outsourced SeqAn3 Argument Parser). It is a lightweight, dependency-free library for C++ command-line parsing.
*   **Hardware Acceleration**: SeqAn3 is built to utilize SIMD (Single Instruction, Multiple Data) vectorization and multicore processing. Ensure your target architecture supports these features to maximize performance.
*   **I/O Efficiency**: When handling large-scale sequencing data, leverage the native SeqAn3 I/O modules which are optimized for high-throughput biological formats.
*   **Licensing**: SeqAn3 uses the 3-Clause BSD License. When integrating it into third-party applications, proper attribution is the primary requirement.

## Reference documentation
- [SeqAn3 Overview](./references/anaconda_org_channels_bioconda_packages_seqan3_overview.md)
- [SeqAn Applications](./references/www_seqan_de_apps.md)
- [What is SeqAn?](./references/www_seqan_de_index.md)
- [SeqAn News and Releases](./references/www_seqan_de_news.md)