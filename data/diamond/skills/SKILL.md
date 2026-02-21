---
name: diamond
description: Build a DIAMOND database from a FASTA file
homepage: https://github.com/bbuchfink/diamond
---

# diamond

## Overview
DIAMOND is a high-performance sequence aligner designed for protein and translated DNA searches. It serves as a significantly faster alternative to BLAST (100x to 10,000x speedup) while maintaining comparable sensitivity. It is optimized for "big data" scenarios, such as aligning millions of reads against the NCBI Non-Redundant (NR) database, and includes specialized algorithms for protein clustering and frameshift-aware alignments.

## Core CLI Patterns

### 1. Database Preparation
Before searching, you must format a FASTA reference file into a DIAMOND-compatible database (.dmnd).
```bash
diamond makedb --in reference.fasta -d reference
```

### 2. Sequence Alignment
DIAMOND supports two primary search modes corresponding to BLASTP and BLASTX.

**Protein vs. Protein (blastp):**
```bash
diamond blastp -d reference -q queries.fasta -o matches.tsv
```

**Translated DNA vs. Protein (blastx):**
```bash
diamond blastx -d reference -q reads.fasta -o matches.tsv
```

### 3. Protein Clustering
DIAMOND provides two clustering modes for handling datasets up to tens of billions of proteins.

**Linear Clustering (Fastest):**
```bash
diamond linclust -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
```

**Sensitive Clustering (All-vs-all):**
```bash
diamond cluster -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
```

## Expert Tips and Best Practices

### Sensitivity Tuning
DIAMOND uses a range of sensitivity settings. Choosing the right one is critical for balancing speed and accuracy:
- `--fast` or `--faster`: Best for high-identity matches.
- `--mid-sensitive`: Good balance for general use.
- `--sensitive`: Default for many workflows; comparable to BLAST.
- `--very-sensitive` or `--ultra-sensitive`: Recommended for finding distant homologs or sensitive environmental DNA (eDNA) searches.

### Memory and Resource Management
- **Block Size (`-b`)**: This is the most important parameter for memory usage. It defines the number of query letters (in billions) processed in one block. If the program crashes due to memory limits, decrease this value (e.g., `-b 0.5`).
- **Temporary Space**: DIAMOND uses significant disk space for temporary files. Ensure your `TMPDIR` has sufficient capacity or specify a path using `--tmpdir`.

### Handling Masking
By default, DIAMOND applies repeat masking to both query and reference sequences. 
- To disable masking for specific biological contexts where low-complexity regions are informative, use `--masking 0`.

### Frameshift Alignment
For long-read sequencing data (like Oxford Nanopore or PacBio) that may contain indels causing frameshifts, use the frameshift alignment mode:
- Add `--range-culling` and `--top 1` to improve performance in these scenarios.

### Output Formats
DIAMOND can emulate various BLAST output formats using the `-f` flag:
- `0`: BLAST pairwise
- `5`: BLAST XML
- `6`: BLAST tabular (Default)
- `100`: DIAMOND archive (DAA) - Recommended for large runs as it can be later converted to other formats using the `view` command.

## Reference documentation
- [DIAMOND Wiki - Home](./references/bbuchfink_diamond_wiki.md)
- [DIAMOND GitHub Repository Overview](./references/github_com_bbuchfink_diamond.md)
- [Bioconda Diamond Package](./references/anaconda_org_channels_bioconda_packages_diamond_overview.md)