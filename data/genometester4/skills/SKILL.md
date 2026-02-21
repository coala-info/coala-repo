---
name: genometester4
description: GenomeTester4 is a high-performance toolkit designed for the manipulation of k-mer lists.
homepage: https://github.com/bioinfo-ut/GenomeTester4
---

# genometester4

## Overview
GenomeTester4 is a high-performance toolkit designed for the manipulation of k-mer lists. It allows researchers to treat genomic sequences as sets of k-mers and perform basic set theory operations to find commonalities or differences between genomes or sequencing runs. The toolkit is composed of several specialized binaries, including `gmer_counter` for initial k-mer frequency analysis, `glistcompare` for set operations, and `glistquery` for extracting specific k-mer data. It serves as the foundation for advanced applications like FastGT (alignment-free genotyping) and KATK (de novo variant calling).

## Core Binaries and Usage

### 1. gmer_counter
Used to count k-mers in FASTA or FASTQ files and generate binary k-mer databases.
- **Basic Counting**: `gmer_counter -db <input_file> -o <output_prefix> -k <kmer_length>`
- **Verbose Output**: Use `--verbose` to track progress during large-scale counting tasks.
- **Text to Binary**: If you have a text-based k-mer list, `gmer_counter` is used to convert it into the optimized binary format required by other tools in the suite.

### 2. glistcompare
The primary tool for set operations between two or more k-mer lists.
- **Intersection**: Find k-mers present in multiple lists.
- **Union**: Combine k-mers from multiple lists.
- **Difference/Complement**: Find k-mers unique to a specific dataset (e.g., k-mers in a mutant strain not present in the wild type).
- **Common Patterns**:
    - Use `-c <cutoff>` to filter k-mers by frequency during comparison.
    - Use `--stream` for memory-efficient processing of large lists.
    - Use `--is-union` or specific rule arguments to define how k-mer counts are handled when merging (e.g., sum of counts vs. minimum count).

### 3. glistquery
Used to retrieve information from generated k-mer databases.
- **Sequence Query**: Check if specific sequences exist in the k-mer list.
- **Reverse Complement**: Supports searching for the reverse complement of k-mers automatically.
- **Statistics**: Use to extract GC content or frequency distributions from the binary database.
- **Zero Counts**: Use `-min 0` to include k-mers with zero counts in the output if necessary for downstream statistical modeling.

## Expert Tips and Best Practices
- **Memory Management**: For large genomes, ensure you use the binary database format (.list) rather than text formats to minimize I/O overhead and memory consumption.
- **K-mer Length**: While the tool supports various lengths, ensure consistency across all files being compared with `glistcompare`.
- **FastGT & KATK Integration**: 
    - For genotype calling, use `gmer_caller` in conjunction with pre-defined k-mer databases.
    - For rare variants, use `gassembler` to assemble reads containing k-mers identified as unique or rare by `glistcompare`.
- **Handling Ns**: Recent updates have improved how the tool handles ambiguous bases (N) and GC counting; always use the latest version (4.0+) to ensure accurate index creation and sequence name parsing.

## Reference documentation
- [GenomeTester4 GitHub Repository](./references/github_com_bioinfo-ut_GenomeTester4.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genometester4_overview.md)
- [Commit History and Feature Updates](./references/github_com_bioinfo-ut_GenomeTester4_commits_master.md)