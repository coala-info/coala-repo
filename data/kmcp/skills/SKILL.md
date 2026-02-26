---
name: kmcp
description: KMCP is a high-performance metagenomic analysis tool that performs taxonomic profiling, sequence searching, and genome similarity estimation using k-mer-based pseudo-mapping. Use when user asks to perform metagenomic profiling, search reads against reference databases, estimate genome similarity via sketching, or detect pathogens in low-depth samples.
homepage: https://github.com/shenwei356/kmcp
---


# kmcp

## Overview

KMCP is a high-performance tool for metagenomic analysis that utilizes "pseudo-mapping" to align reads against reference genomes. By dividing reference genomes into equal-sized chunks and combining k-mer similarity with genome coverage information, KMCP significantly reduces the false positive rates common in other k-mer-based taxonomic profilers. It is particularly robust for detecting pathogens in low-depth clinical samples and supports both prokaryotic and viral populations. Beyond profiling, it serves as a faster alternative to COBS for large-scale sequence searching and a faster alternative to Mash/Sourmash for genome similarity estimation using k-mer sketches.

## Installation and Setup

Install KMCP via bioconda:
```bash
conda install -c bioconda kmcp
```
The tool is a statically linked binary with no external dependencies. It automatically detects and utilizes SIMD extensions (AVX512, AVX2, SSE2) for optimized performance.

## Core Workflows and CLI Patterns

### 1. Metagenomic Profiling
The standard workflow involves searching reads against a database and then generating a profile.

*   **Search**: Compare query k-mers against genome chunks.
*   **Profile**: Generate taxonomic abundance reports.
```bash
# Basic profiling workflow
kmcp search -d db_dir/ query.fq.gz -o search_results.tsv.gz
kmcp profile search_results.tsv.gz -taxid-map taxid.map -nodes nodes.dmp -o profile.txt
```

### 2. Large-Scale Sequence Searching
KMCP reimplements the Compact Bit-Sliced Signature index (COBS) for faster searching.
*   Use for searching short reads or whole genomes against massive datasets.
*   Searching results against multiple databases can be merged using `kmcp merge`.

### 3. Genome Similarity Estimation (Sketching)
KMCP is 5x-7x faster than Mash or Sourmash for sketching-based comparisons.
*   Supported sketches: Minimizer, FracMinHash (Scaled MinHash), and Closed Syncmers.

## Expert Tips and Best Practices

*   **Taxonomy Management**: KMCP uses NCBI-style taxdump files. For non-NCBI datasets (like GTDB or ICTV), use `taxonkit create-taxdump` to generate the required files. You can merge GTDB and NCBI taxonomies for comprehensive profiling.
*   **Handling Contamination**: When detecting specific pathogens or contaminated sequences, utilize the "pseudo-mapping" feature to track approximate positions (at chunk resolution) to verify if hits are clustered or randomly distributed.
*   **Memory and Scalability**: If working with limited RAM, build and search against multiple small databases instead of one massive one. Use `kmcp merge` to combine the results before profiling.
*   **Profiling Modes**: KMCP has six preset modes for different scenarios. Choose the mode that matches your data type (e.g., clinical vs. environmental) to balance sensitivity and specificity.
*   **Strain-Level Analysis**: If taxonomy data is unavailable, you can still perform profiling by setting `--level strain` in the `kmcp profile` command.
*   **Database Optimization**: Masking prophage regions and removing plasmid sequences from reference genomes before indexing can improve the accuracy of bacterial profiling.

## Reference documentation
- [KMCP GitHub Repository](./references/github_com_shenwei356_kmcp.md)
- [KMCP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kmcp_overview.md)