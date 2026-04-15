---
name: seqan
description: SeqAn is a high-performance C++ library for biological sequence analysis that provides optimized data structures and algorithms for genomic data. Use when user asks to implement efficient sequence alignments, manage large-scale genomic I/O, perform rapid pattern matching with string indices, or develop custom bioinformatics tools requiring low-level performance.
homepage: http://www.seqan.de/
metadata:
  docker_image: "quay.io/biocontainers/seqan:2.5.2--h168b838_0"
---

# seqan

## Overview
SeqAn is a high-performance C++ library specifically engineered for biological sequence analysis. It is designed to bridge the gap between generic programming and high-efficiency bioinformatics, providing optimized data structures and algorithms that leverage modern hardware features like SIMD vectorization and multi-core processing. Use this skill to implement efficient sequence alignments, manage large-scale genomic I/O, or develop custom tools that require low-level performance with high-level extensibility.

## Library Integration and Setup
SeqAn is primarily a header-only C++ template library. The most reliable way to manage the environment is via Bioconda.

### Installation
```bash
conda install -c bioconda seqan
```

### C++ Compilation
When compiling applications using SeqAn, ensure you include the library path and enable modern C++ standards (C++14 or higher is generally required for version 2.x and 3.x).
- **Include Path**: Add the `include` directory of your SeqAn installation to your compiler's search path.
- **Optimization**: Always use high optimization flags (e.g., `-O3`, `-march=native`) to allow the template metaprogramming and SIMD vectorization to function effectively.

## Core Functional Modules
Focus on these primary modules when building sequence analysis workflows:

### 1. Sequence I/O
SeqAn provides high-speed I/O for common bioinformatics formats (FASTA, FASTQ, SAM, BAM, VCF).
- Use `SeqFileIn` and `SeqFileOut` for sequence files.
- Use `FormattedFileIn` and `FormattedFileOut` for record-based formats like SAM or VCF.
- **Tip**: Always use the library's built-in stream buffers for maximum throughput when handling "Big Data" sequencing sets.

### 2. Alignment Algorithms
The library supports various alignment strategies:
- **Pairwise Alignment**: Global (Needleman-Wunsch), Local (Smith-Waterman), and semi-global alignments.
- **Multiple Sequence Alignment (MSA)**: Specialized structures for aligning more than two sequences.
- **Scoring Schemes**: Utilize predefined scoring matrices (BLOSUM, PAM) or define custom simple scores (match, mismatch, gap extension).

### 3. String Indices and Searching
For rapid pattern matching and mapping:
- **FM-Index / Suffix Trees**: Use these for exact and approximate string matching in large genomes.
- **Pangenomics**: Utilize succinct data structures for searching across multiple related genomes simultaneously.

## Best Practices
- **Generic Programming**: Leverage SeqAn's "Metafunctions" to write code that works across different alphabet types (e.g., `Dna`, `Dna5`, `AminoAcid`).
- **Memory Management**: Use SeqAn's specialized `String` types (e.g., `AllocString`, `MMapString`) to handle sequences that exceed available RAM by using memory-mapped files.
- **Parallelism**: Where possible, use the built-in multi-threading support for alignment and I/O tasks to reduce wall-clock time.

## Reference documentation
- [SeqAn Project Overview](./references/www_seqan_de_index.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_seqan_overview.md)