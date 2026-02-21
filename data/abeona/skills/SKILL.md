---
name: abeona
description: "Could not get help from Singularity for: abeona"
homepage: https://github.com/winni2k/abeona
---

# abeona

## Overview

Abeona is a transcriptome assembler designed to reconstruct transcripts from RNA-seq reads by navigating De Bruijn graphs. It operates through a multi-stage pipeline: building a graph from reads, pruning artifacts like tips and low-coverage unitigs, partitioning the graph into manageable subgraphs, generating candidate transcript paths, and finally using kallisto to filter these candidates based on abundance estimates. It is an efficient choice for researchers needing a graph-based assembly that leverages the speed of pseudo-alignment for transcript validation.

## Installation and Setup

The recommended way to install abeona is via Conda:

```bash
conda install -c bioconda -c conda-forge abeona
```

## Command Line Usage

The primary entry point is the `abeona assemble` command.

### Basic Assembly (Single-end)
To assemble transcripts from a single FASTA/FASTQ file:
```bash
abeona assemble -k 31 -m 8 --fastx-single reads.fq -o output_dir
```

### Paired-end Assembly
For paired-end data, specify the forward and reverse reads:
```bash
abeona assemble -k 31 -m 16 --fastx-forward R1.fq --fastx-reverse R2.fq -o output_dir
```

### Key Parameters
- `-k, --kmer-size`: The k-mer size for De Bruijn graph construction.
- `-m, --memory`: Maximum memory (in GB) to use for the assembly process.
- `-o, --out-dir`: Directory where results and intermediate files are stored.
- `--min-tip-length`: Minimum length for a unitig to not be considered a tip (default varies by k-mer size).
- `--kallisto-fragment-length`: Estimated average fragment length (required for single-end reads).
- `--kallisto-sd`: Estimated standard deviation of fragment length (required for single-end reads).

## Expert Tips and Best Practices

### Memory Management
Abeona uses Nextflow internally to manage processes. Ensure the `-m` flag reflects the available system memory, as graph construction (mccortex) and path traversal can be memory-intensive for complex transcriptomes.

### Pruning Strategies
In version 0.45.0 and later, abeona uses mccortex for pruning by default. 
- Use `--prune-tips-iteratively` for a more aggressive cleaning of the graph, which can help in reducing the number of false-positive candidate transcripts in high-complexity regions.
- If you need to disable mccortex pruning, use the `--no-prune-tips-with-mccortex` flag.

### Handling Subgraph Complexity
If the assembly is hanging on specific subgraphs, you can limit complexity using:
- `--max-junctions`: Skips subgraphs with more than the specified number of junctions to prevent exponential path explosion.
- `--no-links`: Disables the use of read-links during path traversal, which can speed up the process at the cost of some assembly continuity.

### Output Files
The final assembled transcripts are stored in the output directory as `transcripts.fa`. Intermediate files are cleaned up by default to save space. To inspect the Nextflow work directory or intermediate graph files, use the `--no-cleanup` flag.

## Reference documentation
- [abeona GitHub Repository](./references/github_com_winni2k_abeona.md)
- [bioconda abeona Overview](./references/anaconda_org_channels_bioconda_packages_abeona_overview.md)