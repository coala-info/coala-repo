---
name: swipe
description: The swipe tool performs high-performance exhaustive Smith-Waterman local alignments for protein or DNA sequences using SIMD instructions. Use when user asks to perform highly sensitive sequence alignments, search protein or nucleotide databases, or run Smith-Waterman searches with BLAST-compatible formatting.
homepage: http://dna.uio.no/swipe
metadata:
  docker_image: "quay.io/biocontainers/swipe:2.1.1--hf1d56f0_5"
---

# swipe

## Overview
The `swipe` tool provides a high-performance implementation of the Smith-Waterman local alignment algorithm. While standard tools like BLAST use heuristics to increase speed at the cost of sensitivity, `swipe` utilizes SIMD (Single Instruction, Multiple Data) instructions on modern CPUs to perform exhaustive alignments rapidly. It is specifically designed for researchers needing the most sensitive local alignment results possible for protein or DNA sequences without the prohibitive time costs usually associated with Smith-Waterman.

## Usage Guidelines

### Database Preparation
Before searching, sequence databases must be formatted. `swipe` is compatible with databases formatted using `makeblastdb` from the NCBI BLAST+ suite.
- For protein: `makeblastdb -in db.fasta -dbtype prot`
- For nucleotides: `makeblastdb -in db.fasta -dbtype nucl`

### Common Command Patterns
The basic syntax follows a structure similar to NCBI BLAST:
`swipe -query <query_file> -db <database_path> [options]`

**Protein Search (BLOSUM62):**
```bash
swipe -query query.faa -db nr -out results.txt -evalue 0.001 -matrix BLOSUM62
```

**Nucleotide Search:**
```bash
swipe -query query.fna -db nt -out results.txt -match 1 -mismatch -3
```

### Performance Optimization
- **Thread Management**: Use `-num_threads <N>` to specify the number of CPU cores. `swipe` scales linearly with available cores.
- **Memory**: Ensure the database index files (.pin, .psq, etc.) are accessible on fast storage (SSD) or cached in RAM for optimal throughput.

### Key Parameters
- `-evalue`: Set the expectation value threshold (default is 10.0).
- `-max_target_seqs`: Limit the number of aligned sequences to keep.
- `-outfmt`: Controls the output format. `swipe` supports several formats including pairwise, tabular (6), and XML (5) to maintain compatibility with BLAST post-processing scripts.
- `-matrix`: Specify the scoring matrix (e.g., BLOSUM62, PAM30, PAM70).

## Reference documentation
- [swipe Overview](./references/anaconda_org_channels_bioconda_packages_swipe_overview.md)