---
name: seqan-apps
description: SeqAn provides a high-performance C++ library and applications for biological sequence analysis and genomic data processing. Use when user asks to install the SeqAn environment, perform pairwise or multiple sequence alignments, search string indices, or handle high-performance genomic I/O.
homepage: http://www.seqan.de/
metadata:
  docker_image: "biocontainers/seqan-apps:v2.4.0dfsg-11-deb_cv1"
---

# seqan-apps

## Overview
SeqAn is a specialized C++ template library designed for high-performance bioinformatics. This skill assists in setting up the SeqAn environment and applying its core algorithmic components—such as pairwise/multiple alignments and approximate string searches—to biological datasets. It is particularly useful for developers building sequence analysis tools and researchers needing efficient I/O for large-scale genomic data.

## Installation and Setup
The most reliable way to access SeqAn and its pre-built applications is through the Bioconda channel.

- **Conda Installation**:
  ```bash
  conda install -c bioconda seqan
  ```
- **Version Selection**: The current stable version is 2.5.2. Note that while the library is "noarch," specific older versions (e.g., 2.4.0) have platform-specific builds for linux-64 and macOS-64.

## Core Capabilities
When using SeqAn-based tools or developing with the library, focus on these functional modules:

- **Sequence Alignment**: Perform pairwise or multiple sequence alignments using SIMD-vectorized kernels for maximum throughput.
- **String Indices**: Utilize unified interfaces for searching string indices (e.g., FM-index, Suffix Arrays) to perform rapid pattern matching.
- **Pangenomics**: Use succinct data structures designed for representing and querying multiple genomes simultaneously.
- **High-Performance I/O**: Leverage SeqAn’s native I/O modules to handle standard bioinformatics formats (FASTA, FASTQ, SAM/BAM) with minimal memory overhead.

## Best Practices
- **Parallelization**: Always check if the specific SeqAn application supports multi-core processing or SIMD. Enable these features to handle large sequencing runs.
- **Generic Design**: If writing C++ code, take advantage of SeqAn’s generic programming model to ensure your tool integrates seamlessly with other SeqAn data structures without performance loss.
- **Memory Management**: For pangenomic scales, prefer succinct data structures provided by the library to keep the memory footprint manageable.

## Reference documentation
- [SeqAn Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqan_overview.md)
- [SeqAn Project Homepage](./references/www_seqan_de_index.md)