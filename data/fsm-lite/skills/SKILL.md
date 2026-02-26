---
name: fsm-lite
description: fsm-lite performs frequency-based string mining to identify and count substrings across genomic sequence populations. Use when user asks to identify k-mers in a set of genomes, perform comparative genomics through string mining, or record substring occurrences across multiple samples.
homepage: https://github.com/nvalimak/fsm-lite
---


# fsm-lite

## Overview
fsm-lite is a specialized tool for frequency-based string mining, optimized for analyzing populations of genomes. It identifies all substrings (k-mers) present in a set of input sequences and records their occurrence across different samples. This is particularly useful for comparative genomics, such as identifying sequences unique to specific phenotypes or shared across a species. It utilizes succinct data structures to maintain a relatively low memory footprint while processing large sequence collections.

## Installation
The most reliable way to install fsm-lite is via Bioconda:
```bash
conda install bioconda::fsm-lite
```

## Input Preparation
fsm-lite requires a specific input list format. You must create a text file containing pairs of unique identifiers and their corresponding file paths.

**Example of creating an input list:**
```bash
# Generate a list from all FASTA files in the current directory
for f in *.fasta; do
    id=$(basename "$f" .fasta)
    echo "$id $f"
done > input.list
```
*Note: Ensure that every `<data-identifier>` in the first column is unique.*

## Command Line Usage
The basic syntax involves specifying the input list and a prefix for temporary files.

**Basic execution:**
```bash
fsm-lite -l input.list -t tmp_index > output.txt
```

**Recommended pattern for large datasets:**
Since output files can be extremely large, it is best practice to compress the output stream directly.
```bash
fsm-lite -l input.list -t tmp_prefix | gzip - > output.txt.gz
```

## Parameters and Options
- `-l <file>`: Path to the input list file (required).
- `-t <prefix>`: Prefix for temporary index files created during processing.
- `--help`: Display all available command-line options, including frequency thresholds if supported by the version.

## Expert Tips
- **Temporary Storage**: The `-t` flag creates temporary index files. Ensure the target directory has enough disk space to hold the suffix array and auxiliary structures for your dataset.
- **Single-Core Limitation**: fsm-lite is a single-core implementation. For very large populations, ensure your execution environment allows for long-running single-threaded processes.
- **Memory Management**: While the tool uses succinct data structures (SDSL), the memory requirement scales with the total size of the input sequences. Monitor RAM usage when processing multi-gigabyte genomic datasets.
- **Output Interpretation**: The output typically contains the discovered substrings followed by their frequency or presence/absence bit-vectors across the identifiers provided in your input list.

## Reference documentation
- [fsm-lite GitHub Repository](./references/github_com_nvalimak_fsm-lite.md)
- [Bioconda fsm-lite Overview](./references/anaconda_org_channels_bioconda_packages_fsm-lite_overview.md)