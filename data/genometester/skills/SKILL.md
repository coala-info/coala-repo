---
name: genometester
description: GenomeTester4 is a toolkit for the rapid manipulation and analysis of k-mer lists to perform alignment-free comparative genomics. Use when user asks to count k-mer frequencies, perform set operations like union or intersection on k-mer lists, query specific sequences in a k-mer database, or identify unique genomic sequences.
homepage: https://github.com/bioinfo-ut/GenomeTester4
---


# genometester

## Overview

GenomeTester4 is a specialized toolkit designed for the rapid manipulation and analysis of k-mer lists. Unlike alignment-based methods, it operates on the frequency and distribution of short DNA sequences (k-mers) to perform comparative genomics. The tool is primarily used to identify shared or unique genomic sequences across multiple datasets by applying set theory operations. It serves as the foundation for sub-projects like FastGT (for common SNV calling) and KATK (for rare and de novo variant detection).

## Core Binaries and Usage

The toolkit consists of several specialized binaries. Ensure these are compiled from the `src` directory before use.

### 1. gmer_counter
Used to generate k-mer frequency lists from raw sequencing reads or reference genomes.
- **Purpose**: Initial processing of FASTA/FASTQ files into binary k-mer databases.
- **Best Practice**: Use the `--verbose` flag to monitor processing statistics during long-running counting tasks.

### 2. glistcompare
The primary tool for performing set operations between two or more k-mer lists.
- **Union**: Combines k-mer lists, summing or merging frequencies.
- **Intersection**: Identifies k-mers present in all provided lists.
- **Complement**: Finds k-mers present in one list but absent in others.
- **Optimization**: Use the `--stream` option to process files without loading the entire dataset into memory, which is critical for large mammalian genomes.
- **Advanced Logic**: Use the `--is-union` or arbitrary number rules to define complex membership requirements (e.g., k-mer must appear in at least N out of M samples).

### 3. glistquery
Used to retrieve information about specific k-mers from generated lists or indices.
- **Search**: Query specific sequences to find their frequency in a database.
- **Filtering**: Use `-min <count>` to filter results by frequency. Setting `-min 0` allows for the inclusion of k-mers not present in the database (zero-count output).
- **Index Support**: For large-scale queries, ensure an index is created to speed up lookups.
- **Sequence Analysis**: Supports reverse complement searches and GC content counting.

### 4. gassembler
A utility used within the KATK workflow for local assembly of k-mers, specifically for resolving rare or de novo variants.

## Common Workflow Patterns

### Alignment-Free Comparison
1. **Count**: Run `gmer_counter` on Sample A and Sample B.
2. **Compare**: Use `glistcompare` to find the intersection (shared k-mers) or the complement (unique k-mers in Sample A).
3. **Query**: Use `glistquery` to extract the frequencies of specific k-mers of interest for downstream statistical analysis.

### Genotype Calling (FastGT/KATK)
- For common SNVs, utilize `gmer_caller` in conjunction with pre-defined k-mer lists.
- For rare variants, use `katk2vcf.pl` to convert KATK results into standard VCF format for integration with other bioinformatics pipelines.

## Expert Tips
- **Memory Management**: K-mer databases can be extremely large. Always prefer streaming modes (`--stream`) when working with high-coverage whole-genome sequencing (WGS) data.
- **N-Base Handling**: Be aware that recent updates have improved how the tool handles 'N' bases in sequences; ensure you are using the latest version to avoid index discrepancies.
- **File Formats**: GenomeTester4 uses proprietary binary formats for k-mer lists to ensure speed. Use `glistquery` whenever you need to convert these binary results into human-readable text formats.

## Reference documentation
- [GenomeTester4 Main Repository](./references/github_com_bioinfo-ut_GenomeTester4.md)
- [GenomeTester4 Development History and Updates](./references/github_com_bioinfo-ut_GenomeTester4_commits_master.md)