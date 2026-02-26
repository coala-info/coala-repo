---
name: mrsfast
description: mrsfast is a genomic aligner designed to map short-read sequences to a reference genome while focusing exclusively on substitutions. Use when user asks to index a reference genome, perform single-end or paired-end mapping, detect structural variations, or conduct copy number analysis.
homepage: https://github.com/sfu-compbio/mrsfast
---


# mrsfast

## Overview

mrsfast (micro-read substitution-only Fast Alignment Search Tool) is a specialized genomic aligner designed for short-read sequences. Unlike general-purpose aligners that account for insertions and deletions (indels), mrsfast focuses exclusively on substitutions. It is fundamentally an "all-mapper," capable of reporting every possible location a read matches in the genome, which is critical for tasks like structural variation detection and copy number analysis. It supports single-end and paired-end mapping, memory-aware execution, and multi-threading.

## Installation

The most efficient way to install mrsfast is via Bioconda:

```bash
conda install -c bioconda mrsfast
```

Alternatively, it can be built from source by running `make` in the repository directory, which produces the `mrsfast` and `snp_indexer` binaries.

## Core Workflows

### 1. Indexing the Reference Genome
Before mapping, you must create an index of the FASTA reference file. This generates a `.index` file.

```bash
mrsfast --index <reference.fa> [--ws <window_size>]
```

*   **Window Size (`--ws`)**: Default is 12. Increasing this to 14 can improve mapping speed but will significantly increase memory usage during the mapping phase.

### 2. Single-End Mapping
Perform a basic search for all valid alignments.

```bash
mrsfast --search <reference.fa> --seq <reads.fq> -o <output.sam>
```

*   **Error Threshold (`-e`)**: Sets the maximum Hamming distance. Default is 6% of read length. Set to `0` for exact matches only.
*   **Best Mapping (`--best`)**: Instead of all-mapping, report only one of the best locations (smallest Hamming distance) at random.

### 3. Paired-End Mapping
mrsfast supports both interleaved files and separate mate files.

```bash
# Separate files
mrsfast --search <reference.fa> --pe --seq1 <mates1.fq> --seq2 <mates2.fq> --min <min_dist> --max <max_dist>

# Interleaved file
mrsfast --search <reference.fa> --pe --seq <interleaved.fq>
```

*   **Template Length (`--min`/`--max`)**: Defines the allowed distance between the outer edges of mapping mates. If omitted, mrsfast estimates these based on observed distribution.

## Performance and Resource Management

### Multi-threading
Use the `--threads` flag to speed up mapping.
*   `--threads <N>`: Use N specific cores.
*   `--threads 0`: Automatically use all available cores in the system.

### Memory Constraints
If working with massive datasets on limited hardware, use the `--mem` flag.
*   `--mem <GB>`: Limits the memory usage. mrsfast will automatically partition the reads and perform the mapping in multiple iterations to stay within this limit.

### Read Trimming
You can trim reads at the command line without preprocessing files:
*   `--crop <N>`: Use only the first N base pairs.
*   `--tail-crop <N>`: Crop from the tail of the reads.

## Expert Tips

*   **SAM File Size**: By default, mrsfast outputs all reads, including those that do not map. Use `--disable-nohits` to exclude unmapped reads and significantly reduce the size of your output SAM files.
*   **Mapping Limits**: Use `-n <N>` to limit the number of reported mappings per read. Reads exceeding this count will not be printed. Note: This is incompatible with `--best` or `--discordant-vh` modes.
*   **Architecture**: Ensure you are running on a 64-bit architecture, as 32-bit systems are not supported.

## Reference documentation

- [mrsfast GitHub Repository](./references/github_com_sfu-compbio_mrsfast.md)
- [mrsfast Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mrsfast_overview.md)