---
name: moni
description: MONI is a pangenomic indexing tool that efficiently finds maximal exact matches across multiple reference genomes using a compressed index. Use when user asks to build a pangenomic index, find maximal exact matches, compute matching statistics, or perform seed extension for sequence alignment.
homepage: https://github.com/maxrossi91/moni
---


# moni

---

## Overview

MONI is a pangenomic indexing tool designed to find Maximal Exact Matches (MEMs) efficiently across multiple reference genomes. It utilizes prefix-free parsing to construct a Burrows-Wheeler Transform (BWT) and suffix array samples, creating a highly compressed index that remains effective even as the number of reference sequences grows. This skill provides guidance on index construction, querying for matching statistics, and performing MEM-based sequence extensions.

## Core Workflows

### 1. Index Construction
To use MONI, you must first build an index from your reference sequences (typically in FASTA format).

```bash
# Basic index construction from a FASTA file
moni build -r references.fasta -o my_index -f

# Optimized build for large datasets using multiple threads
moni build -r references.fasta -o my_index -f -t 16 -w 10 -p 100
```

**Key Parameters:**
- `-r, --reference`: Path to the input reference file.
- `-f`: Required flag if the input is in FASTA format.
- `-w, --wsize`: Sliding window size for prefix-free parsing (default: 10).
- `-p, --mod`: Hash modulus for parsing (default: 100).
- `-t, --threads`: Number of helper threads for parallel processing.

### 2. Finding Maximal Exact Matches (MEMs)
Once the index is built, use the `mems` command to find exact matches between a query pattern and the reference set.

```bash
# Find MEMs and output in SAM format
moni mems -i my_index -p query.fasta -s -o results/

# Find MEMs with extended output showing occurrences in the reference
moni mems -i my_index -p query.fasta -e
```

**Key Parameters:**
- `-i, --index`: The base name/prefix of the index created during the build step.
- `-p, --pattern`: The input query file (reads).
- `-s, --sam-output`: Generates a SAM formatted file for downstream bioinformatics pipelines.
- `-e, --extended-output`: Includes specific reference coordinates for each MEM.

### 3. Computing Matching Statistics
Matching statistics provide the length of the longest prefix of each suffix of the query that occurs in the reference.

```bash
moni ms -i my_index -p query.fasta -t 8
```

### 4. Seed Extension (MEM Extension)
MONI supports extending MEMs using the `ksw2` library to perform local alignment.

```bash
# Extend MEMs with custom alignment penalties
moni extend -i my_index -p query.fasta -L 100 -A 2 -B 4 -O 4,13 -E 2,1
```

**Alignment Parameters:**
- `-L`: Length of the reference substring to consider for extension.
- `-A`: Match score.
- `-B`: Mismatch penalty.
- `-O`: Gap open penalties (comma-separated for affine gaps).
- `-E`: Gap extension penalties.

## Expert Tips

- **Memory Management**: If you encounter memory issues during construction, ensure you are not keeping temporary files by avoiding the `-k` flag.
- **Grammar Selection**: The `-g` flag allows switching between `plain` and `shaped` grammars. Use `plain` (default) for standard pangenomic applications.
- **Thread Scaling**: While `moni build` supports threading, the efficiency of `-t` depends on the complexity of the prefix-free parsing; for very similar genomes, high thread counts provide significant speedups.
- **Output Files**: A successful build produces three main files: `.plain.slp` (grammar), `.thrbv.ms` (RLBWT and thresholds), and `.idx` (sequence metadata). Ensure all three remain in the same directory for querying.



## Subcommands

| Command | Description |
|---------|-------------|
| moni | moni: error: argument {build,ms,mems,extend}: invalid choice: 'valid' (choose from 'build', 'ms', 'mems', 'extend') |
| moni build | Builds a reference index for the moni tool. |
| moni extend | Extend query patterns against a reference index. |
| moni mems | Find maximal exact matches (MEMs) between a query and a reference genome. |
| moni ms | Moni tool for sequence matching |

## Reference documentation
- [MONI GitHub Repository](./references/github_com_maxrossi91_moni.md)
- [MONI README](./references/github_com_maxrossi91_moni_blob_main_README.md)
- [Utility Documentation](./references/github_com_maxrossi91_moni_blob_main_utils.md)