---
name: hyplas
description: HyPlAs is a hybrid sequencing pipeline designed to reconstruct and assemble plasmid sequences from combined short-read and long-read datasets. Use when user asks to assemble plasmids from hybrid data, classify short-read contigs as plasmidic, or recover plasmid-specific long reads for refined assembly.
homepage: https://github.com/cchauve/hyplas
metadata:
  docker_image: "quay.io/biocontainers/hyplas:1.0.2--py311h2de2dd3_0"
---

# hyplas

## Overview

HyPlAs (Hybrid Long-Short Plasmid Assembler) is a specialized pipeline designed to reconstruct plasmids from hybrid sequencing datasets. Unlike general-purpose hybrid assemblers, HyPlAs focuses on plasmidic content by first classifying short-read contigs as plasmidic or chromosomal. It then uses these results to filter and select relevant long reads, which are used to refine the assembly graph. This targeted approach is particularly effective for resolving complex plasmid structures in single genome sequencing data.

## Installation and Setup

HyPlAs is available via Bioconda. It requires an external database for the Platon classification tool.

```bash
# Install via Conda
conda install bioconda::hyplas

# Download and extract the required Platon database
wget https://zenodo.org/record/4066768/files/db.tar.gz
tar -xzf db.tar.gz
```

## Usage Patterns

### Standard Hybrid Assembly
The core command requires short reads, a gzipped long-read file, and the path to the Platon database.

```bash
hyplas -l long_reads.qc.fastq.gz -s short_1.qc.fastq short_2.qc.fastq -p 2 -o output_dir --platon-db /path/to/db -t 16
```

### Key Arguments
- `-l`: Long reads file. **Note**: This file must be gzipped (`.gz`).
- `-s`: Short read files (space-separated).
- `-p`: Number of long-read recovery rounds. The recommended value is `2`.
- `--platon-db`: Path to the directory containing the extracted Platon database.
- `-o`: Output directory.
- `-t`: Number of threads.

## Best Practices

### 1. Read Preprocessing
HyPlAs performs best when reads are cleaned before assembly.
- **Short Reads**: Use `fastp` to trim adapters and filter low-quality bases.
- **Long Reads**: Use `chopper` (or `NanoPlot`/`Filtlong`) to filter by quality (e.g., Q9+) and length (e.g., >500bp).

### 2. Iterative Recovery
The `-p` parameter controls how many rounds the tool spends searching for overlapping long reads to augment the plasmidic set. Increasing this beyond 2 may recover more plasmid fragments but increases computation time and the risk of chromosomal contamination.

### 3. Output Interpretation
The primary results are found in the root of the output directory:
- `plasmids.final.it{n}.fasta`: The final assembled plasmid sequences for each iteration.
- `plasmid_long_reads/plasmid.fastq.gz`: The subset of long reads identified as plasmidic.
- `unicycler_sr/`: The initial short-read-only assembly graph.

## Troubleshooting
- **Gzip Requirement**: If the long-read input is not gzipped, the tool will fail. Always pipe `chopper` output to `gzip` or compress existing FASTQ files before running.
- **Single Isolates**: HyPlAs is optimized for single bacterial isolates. It is not recommended for metagenomic samples where plasmid-to-chromosome ratios and species diversity can confuse the classification logic.

## Reference documentation
- [HyPlAs GitHub Repository](./references/github_com_cchauve_HyPlAs.md)
- [Bioconda HyPlAs Overview](./references/anaconda_org_channels_bioconda_packages_hyplas_overview.md)