---
name: ntedit
description: ntEdit is a high-performance genomics application designed for the rapid refinement of genome assemblies.
homepage: https://github.com/bcgsc/ntEdit
---

# ntedit

## Overview
ntEdit is a high-performance genomics application designed for the rapid refinement of genome assemblies. By utilizing Bloom filters and k-mer analysis, it identifies and corrects errors in draft sequences using high-accuracy reads (typically Illumina short reads, though it supports long reads via GoldPolish). It provides a scalable alternative to traditional polishers, capable of processing large genomes with minimal computational overhead.

## Installation and Setup
The most reliable way to install ntEdit and its dependencies (like ntStat and btllib) is via Bioconda:
```bash
conda install -c bioconda ntedit
```

## Common CLI Patterns

### Genome Polishing
The primary command for assembly correction is `run-ntedit polish`.

**Basic Polishing Command:**
```bash
run-ntedit polish --draft assembly.fa --reads read_prefix -k 48 -t 16
```
*   `--draft`: The FASTA file of the assembly to be polished.
*   `--reads`: The prefix of the sequencing reads. ntEdit will look for all files in the directory starting with this prefix (e.g., .fastq, .fasta, .gz).
*   `-k`: The k-mer size (required). Note: In versions 1.3.1+, k is automatically detected if supplied with pre-built Bloom filters.

### SNV Detection (Experimental)
To run ntEdit in SNV mode for variant mapping:
```bash
run-ntedit snv --draft reference.fa --reads read_prefix -k 48
```

## Expert Tips and Best Practices

### Parameter Tuning
*   **Edit Modes (`-m`)**: 
    *   `0` (Default): Fastest; picks the best substitution or the first valid indel.
    *   `1`: Picks the best substitution or the best indel.
    *   `2`: Best edit overall. Use this for maximum accuracy, but consider reducing `-i` and `-d` values to maintain performance.
*   **Indel Limits**: Control the search space for insertions (`-i`, range 0-5) and deletions (`-d`, range 0-10). The defaults are usually sufficient for Illumina-based polishing.
*   **Stringency**: Adjust the `-x` (missing k-mer ratio) and `-y` (edited k-mer ratio) parameters to control how aggressively the tool attempts and accepts fixes.

### Resource Management
*   **Threading**: Use the `-t` flag to specify CPU threads. ntEdit is highly parallelizable.
*   **Memory**: Because it uses Bloom filters, memory usage is significantly lower than alignment-based tools (like Pilon or Racon), making it suitable for very large plant or animal genomes on standard server hardware.

### Input Requirements
*   **Draft Filename**: The `--draft` argument requires the exact filename.
*   **Read Prefixing**: Ensure your read files are consistently named with a common prefix in the working directory, as ntEdit uses prefix matching rather than individual file paths for the `--reads` argument.

## Reference documentation
- [ntEdit GitHub Repository](./references/github_com_bcgsc_ntEdit.md)
- [Bioconda ntEdit Overview](./references/anaconda_org_channels_bioconda_packages_ntedit_overview.md)