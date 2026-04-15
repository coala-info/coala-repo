---
name: velvet
description: Velvet is a genomic de novo assembler optimized for short-read sequencing data using de Bruijn graphs. Use when user asks to hash reads into k-mers, construct contigs from short-read datasets, or perform de novo genome assembly.
homepage: https://github.com/dzerbino/velvet
metadata:
  docker_image: "quay.io/biocontainers/velvet:1.2.10--h577a1d6_9"
---

# velvet

## Overview

Velvet is a specialized suite of tools for genomic de novo assembly, specifically optimized for short-read data. The workflow is split into two primary stages: `velveth`, which prepares the dataset by hashing reads into k-mers, and `velvetg`, which constructs, simplifies, and resolves the de Bruijn graph to produce contigs. It is highly effective for high-coverage datasets and supports multiple library types, including paired-end and long reads (Sanger/454), to assist in scaffolding and repeat resolution.

## Core Workflow

### 1. Data Preparation (velveth)
The `velveth` command creates a dataset directory containing the hashtable required for assembly.

**Syntax:**
`velveth output_directory kmer_length [-file_format] [-read_type] filename`

*   **kmer_length**: Must be an odd integer. A good starting point is often between 1/2 and 2/3 of the read length.
*   **File Formats**: `fasta` (default), `fastq`, `fasta.gz`, `fastq.gz`, `eland`, `gerald`.
*   **Read Types**:
    *   `short`: Single-end short reads (default).
    *   `shortPaired`: Paired-end short reads.
    *   `long`: Long reads (Sanger, 454, or reference sequences).
    *   `short2` / `shortPaired2`: Additional libraries with different insert sizes.

**Example:**
```bash
velveth asm_dir 31 -fastq -shortPaired reads_1.fq reads_2.fq -long sanger.fa
```

### 2. Graph Construction and Assembly (velvetg)
The `velvetg` command performs the actual assembly, error correction, and scaffolding.

**Syntax:**
`velvetg output_directory [options]`

**Key Options:**
*   `-cov_cutoff <float|auto>`: Removes low-coverage nodes (likely sequencing errors). Use `auto` for Velvet to decide.
*   `-exp_cov <float>`: The expected k-mer coverage of unique regions. Required for repeat resolution and scaffolding.
*   `-ins_length <integer>`: The average insert length of the paired-end library.
*   `-min_contig_lgth <integer>`: Minimum length of contigs exported to `contigs.fa` (default 2*k).
*   `-read_trkg <yes|no>`: Tracks the position of reads in the graph (required for AMOS output).
*   `-amos_file <yes|no>`: Generates an AMOS assembly file (`velvet_asm.afg`).

**Example:**
```bash
velvetg asm_dir -exp_cov 25 -ins_length 300 -cov_cutoff 5.0
```

## Optimization with VelvetOptimiser

For automated parameter sweeping, use the `VelvetOptimiser.pl` wrapper. It searches for the optimal k-mer length and coverage cutoff based on N50 or total base pairs.

**Common Pattern:**
```bash
VelvetOptimiser.pl -s 19 -e 31 -f '-fastq -shortPaired reads_1.fq reads_2.fq' -t 4
```
*   `-s` / `-e`: Start and end k-mer range.
*   `-f`: The file section of the `velveth` command.
*   `-t`: Number of threads (simultaneous Velvet instances).

## Expert Tips & Best Practices

*   **K-mer Selection**: If the assembly is too fragmented, try increasing the k-mer length (reduces false overlaps but requires higher coverage). If coverage is low, decrease the k-mer length.
*   **Memory Management**: Velvet is memory-intensive. Memory usage scales with the number of k-mers and the `MAXKMERLENGTH` set at compilation. For large genomes, ensure you are using a 64-bit environment with at least 12GB+ RAM.
*   **Scaffolding**: Velvet automatically performs scaffolding if `shortPaired` reads are provided and `-exp_cov` and `-ins_length` are set. Scaffolds are represented in `contigs.fa` with 'N's representing estimated gap sizes.
*   **Handling 'N's**: Velvet only supports A, C, G, T. Any 'N's in input reads are converted to 'A'. Clean your data before assembly if this is undesirable.
*   **Stats Analysis**: Always check `stats.txt` in the output directory. It provides node-by-node coverage and length data, which is essential for manually determining the `-exp_cov` and `-cov_cutoff`.



## Subcommands

| Command | Description |
|---------|-------------|
| velvetg | de Bruijn graph construction, error removal and repeat resolution |
| velveth | simple hashing program |

## Reference documentation
- [Velvet Manual](./references/github_com_dzerbino_velvet_wiki_Manual.md)
- [Velvet FAQ](./references/github_com_dzerbino_velvet_wiki_Velvet-FAQ.md)
- [VelvetOptimiser Guide](./references/github_com_dzerbino_velvet_wiki_Velvet-Optimiser-README.md)