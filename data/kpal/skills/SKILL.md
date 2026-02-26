---
name: kpal
description: kPAL creates and manipulates k-mer frequency profiles from DNA sequences for alignment-free genomic analysis. Use when user asks to count k-mers, generate k-mer profiles from FASTA files, merge multiple profile files, or create a k-mer matrix for statistical comparison.
homepage: https://github.com/LUMC/kPAL
---


# kpal

## Overview

kPAL (k-mer profile analysis library) is a specialized toolkit for the creation and manipulation of k-mer frequency profiles from DNA sequences. It transforms raw FASTA data into structured profiles that represent the distribution of all possible substrings of length *k*. This is particularly useful for alignment-free sequence comparison, identifying genomic signatures, and preparing data for machine learning workflows in bioinformatics.

## Common CLI Patterns

### Counting k-mers
The primary entry point for generating profiles from sequence data.
- **Basic count**: `kpal count <k-mer_length> <input_fasta> <output_profile>`
- **Per-record profiling**: Use the `-r` or `--by-record` flag to create a separate k-mer profile for every individual record within a multi-FASTA file.
  - Example: `kpal count -r 9 input.fasta output.kpal`

### Managing Profile Files
- **Merging profiles**: Use the `cat` subcommand to consolidate profiles from several different files into a single output file.
  - Example: `kpal cat profile1.kpal profile2.kpal -o combined.kpal`
- **Matrix generation**: Use the `matrix` subcommand to compile multiple k-mer profiles into a single matrix format suitable for statistical analysis or distance calculations.

## Best Practices and Tips

- **K-mer Length Selection**: Ensure the k-mer length (*k*) is appropriate for your genome size and the specific biological question. Smaller *k* values are faster but less specific; larger *k* values increase memory requirements exponentially ($4^k$).
- **File Naming**: Avoid using forward slashes (`/`) or dots (`.`) within profile names inside the kPAL files, as these can cause internal indexing issues.
- **Batch Processing**: When working with large datasets, generate individual profiles first and then use `kpal cat` to aggregate them, rather than attempting to process massive multi-FASTA files in a single pass if memory is constrained.
- **Python API**: For complex workflows, kPAL can be used as a library. Key classes include `Profile`, which supports methods like `Profile.from_fasta()` and `Profile.from_file()`.

## Reference documentation

- [kPAL GitHub Repository](./references/github_com_LUMC_kPAL.md)
- [kPAL Commit History and Subcommands](./references/github_com_LUMC_kPAL_commits_master.md)
- [kPAL Issues and API Usage](./references/github_com_LUMC_kPAL_issues.md)