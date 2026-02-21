---
name: vapor
description: VAPOR (Viral Assessment of Proximal Organic Reads) is a specialized tool for the classification of viral samples, particularly Influenza, using short-read sequencing data.
homepage: https://github.com/connor-lab/vapor
---

# vapor

## Overview
VAPOR (Viral Assessment of Proximal Organic Reads) is a specialized tool for the classification of viral samples, particularly Influenza, using short-read sequencing data. It functions by comparing a set of reads against a database of full-length sequences to retrieve the reference that most closely matches the sample strain. This process is critical for accurate downstream analysis, such as variant calling or assembly, which requires a high-quality starting reference.

## Basic Usage
The primary command is `vapor.py`. It requires a reference database in FASTA format and raw reads in FASTQ format (can be gzipped).

```bash
vapor.py -fa database.fa -fq reads_R1.fastq.gz reads_R2.fastq.gz
```

### Output Fields
The tool produces tab-delimited output with the following fields:
1. **Fraction**: Approximate fraction of query bases found in reads.
2. **Total Score**: Cumulative match score.
3. **Query Length**: Length of the reference sequence.
4. **Mean Score**: Average score across the sequence.
5. **Reads**: Number of reads surviving the culling process.
6. **Description**: The FASTA header of the matching reference.

## Expert CLI Patterns

### Handling Large Databases
When working with massive reference sets (e.g., >50,000 sequences), use the memory-optimization flag:
* `--low_mem`: Prevents storing reference k-mer arrays in memory. It is slightly slower but significantly reduces RAM usage.

### Performance Tuning
* **Sub-sampling**: For extremely high-depth datasets, use `-s <number>` (e.g., `-s 1000000`) to limit the number of reads processed. Note that sub-sampling may miss low-frequency regions if depth is skewed.
* **K-mer Proportion**: Use `-m <float>` to set the minimum proportion of k-mers required for a query to be considered. Increasing this (e.g., `-m 0.2`) speeds up the search when you expect a close match in the database.
* **Culling Coverage**: Use `-c <int>` to set the minimum k-mer coverage. In high-depth samples, increasing this (e.g., `-c 10` or higher) helps filter out sequencing errors and minor quasispecies variants.

### Non-Influenza Viruses
While optimized for Influenza, VAPOR can be used for other viruses like HIV by adjusting parameters to account for higher diversity:
* Decrease `-f` (top seed fraction) to `0.1` to extend fewer sequences.
* Increase `-c` if depth is high to reduce noise.
* Ensure `-m` is set appropriately based on expected divergence (use `0.0` for highly novel samples).

## Common Arguments
* `-k <int>`: K-mer length (default: 21).
* `-t <float>`: Pre-filtering score threshold (default: 0.2).
* `--return_seqs`: Returns a FASTA of sequences instead of just the hit statistics.
* `--return_best_n <int>`: Returns the top N highest-scoring queries.
* `-q`: Quiet mode (suppresses stderr).

## Reference documentation
- [VAPOR Main Documentation](./references/github_com_connor-lab_vapor.md)
- [Bioconda VAPOR Overview](./references/anaconda_org_channels_bioconda_packages_vapor_overview.md)