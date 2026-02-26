---
name: phist
description: PHIST predicts bacterial hosts for viral sequences by quantifying shared k-mers and calculating statistical significance. Use when user asks to link viruses to hosts, predict phage-host interactions, or identify shared genomic regions between phages and bacteria.
homepage: https://github.com/refresh-bio/PHIST
---


# phist

## Overview

PHIST (Phage-Host Interaction Search Tool) is a specialized bioinformatics tool designed to link viruses to their most likely bacterial hosts. It operates by quantifying the number of k-mers shared between viral and bacterial genomic sequences. Unlike traditional alignment-based methods, PHIST uses a fast k-mer counting approach to provide p-values and adjusted p-values for predicted interactions, making it suitable for large-scale metagenomic datasets.

## Installation and Setup

The most reliable way to use PHIST is via Bioconda:

```bash
conda install bioconda::phist
```

If building from source, ensure you perform a recursive clone to include the `kmer-db` submodule:
```bash
git clone --recurse-submodules https://github.com/refresh-bio/PHIST
cd PHIST
make
```

## Command Line Usage

The primary interface is the `phist.py` script. It requires a virus input (file or directory), a directory of candidate host genomes, and an output directory.

### Basic Syntax
```bash
phist.py [options] <virus_path> <host_dir> <out_dir>
```

### Common Input Patterns
- **Single Multi-FASTA Virus File**: Use this when all phage sequences are in one file.
  ```bash
  phist.py virus_sequences.fna ./host_genomes/ ./results/
  ```
- **Directory of Virus Files**: Use this when each phage genome is in its own FASTA file.
  ```bash
  phist.py ./phage_dir/ ./host_genomes/ ./results/
  ```
- **Compressed Inputs**: PHIST natively supports `.gz` files for both viruses and hosts.

### Key Options
- `-k <int>`: Set k-mer length (default: 25, maximum: 30).
- `-t <int>`: Set number of threads (default: number of CPU cores).
- `--keep_temp`: Retain temporary kmer-db files for debugging or intermediate analysis.

## Interpreting Results

PHIST generates two primary CSV files in the specified output directory:

1.  **`predictions.csv`**: The main results file. It lists each phage, its most likely host(s), the number of common k-mers, and statistical significance (p-value and adjusted p-value).
2.  **`common_kmers.csv`**: A sparse matrix representing the raw k-mer counts between all phages (columns) and hosts (rows).

## Expert Tips and Utilities

### Refining Matches with Matcher
After identifying a potential host, use the `matcher` utility to find the exact genomic coordinates of the shared sequences. This is useful for identifying specific shared regions like prophages or CRISPR spacers.

```bash
./utils/matcher -k 25 <virus.fna> <host.fna> <output.csv>
```
The output includes coordinates for both the viral and bacterial genomes. A reversed interval in the host coordinates indicates a match on the reverse complement strand.

### Performance Optimization
For large datasets, ensure the `host_dir` contains only one genome per FASTA file. PHIST is optimized for this structure. If you have a large number of candidate hosts, utilize the `-t` flag to maximize thread usage, as k-mer counting is highly parallelizable.

## Reference documentation
- [PHIST GitHub Repository](./references/github_com_refresh-bio_PHIST.md)
- [Bioconda PHIST Package](./references/anaconda_org_channels_bioconda_packages_phist_overview.md)