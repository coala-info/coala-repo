---
name: moni
description: MONI is a pangenomics indexer that finds maximal exact matches and computes matching statistics across multiple reference genomes. Use when user asks to build a pangenome index, find maximal exact matches, compute matching statistics, or perform sequence extensions.
homepage: https://github.com/maxrossi91/moni
---


# moni

## Overview
MONI (Multi) is a high-performance pangenomics indexer designed to find Maximal Exact Matches (MEMs) and compute matching statistics. It leverages prefix-free parsing to construct a Burrows-Wheeler Transform (BWT) of multiple reference genomes efficiently. This tool is essential for researchers working with large-scale genomic data where traditional single-reference alignment is insufficient. Use this skill to navigate the indexing process, execute queries, and perform sequence extensions.

## CLI Usage Patterns

### 1. Building the Index
The `build` command creates the necessary BWT and threshold files from your reference genomes.
- **Standard Build**: `moni build -r reference.fa -o my_index -f`
- **Optimized Build**: Use `-t` to specify helper threads for faster processing.
- **Parameters**:
  - `-w`: Sliding window size (default: 10).
  - `-p`: Hash modulus (default: 100).
  - `-g`: Grammar type (`plain` or `shaped`).

### 2. Finding Maximal Exact Matches (MEMs)
The `mems` command identifies exact matches between query reads and the indexed pangenome.
- **Basic Query**: `moni mems -i my_index -p reads.fastq -o results`
- **SAM Output**: Use `-s` to generate a SAM formatted file for downstream compatibility.
- **Extended Output**: Use `-e` to include occurrence positions in the reference.

### 3. Computing Matching Statistics (MS)
The `ms` command calculates the length and position of the longest prefix of every suffix of the query that occurs in the reference.
- **Command**: `moni ms -i my_index -p reads.fastq -o ms_output`

### 4. MEM Extension
The `extend` command performs sequence extension using the `ksw2` library.
- **Command**: `moni extend -i my_index -p reads.fastq -o extended_results`
- **Scoring**: Customize match (`-A`), mismatch (`-B`), and gap penalties (`-O`, `-E`) for specific alignment needs.

## Expert Tips & Best Practices
- **Input Handling**: Always include the `-f` flag when building from FASTA files to ensure proper parsing.
- **Resource Management**: For large pangenomes, ensure sufficient disk space for temporary files. Use the `-k` flag only if you need to inspect intermediate construction files.
- **Output Interpretation**:
  - `.lengths` and `.pointers` files from `ms` store matching statistics in a fasta-like format.
  - `.mems` files report pairs of positions and lengths.
- **Grammar Selection**: The `--grammar shaped` option can be used for different index compression profiles, though `plain` is the default.
- **Installation**: If the tool is not present, it can be installed via Conda using `conda install bioconda::moni`.

## Reference documentation
- [MONI GitHub Repository](./references/github_com_maxrossi91_moni.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_moni_overview.md)