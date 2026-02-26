---
name: peregrine-2021
description: Peregrine-2021 is a high-speed genome assembler designed for efficient assembly of long-read sequencing data like PacBio HiFi reads. Use when user asks to assemble a genome from long reads, perform fast human genome assembly, or use the SHIMMER approach for sequence mapping.
homepage: https://github.com/cschin/peregrine-2021
---


# peregrine-2021

## Overview
Peregrine-2021 is a specialized genome assembler designed for long-read sequencing data that possesses high accuracy (such as PacBio HiFi reads). Written in Rust, it focuses on extreme speed and efficiency, capable of assembling a human genome in just a few hours on standard high-performance compute nodes. It utilizes a "SHIMMER" (Sparse HIgh-Map-MEr) approach to minimize computational overhead while maintaining high contig N50 values.

## Installation and Requirements
The tool is primarily distributed via Bioconda.
- **Installation**: `conda install bioconda::peregrine-2021`
- **Memory**: Recommended RAM is approximately 1.5x the size of the input read dataset (e.g., 150GB RAM for 100GB of sequences).
- **Storage**: High-performance SSD or network filesystems are preferred for the working directory.

## Core Workflow

### 1. Prepare Input List
Peregrine-2021 does not take raw sequence files directly as arguments. You must create a text file (e.g., `reads.lst`) containing the absolute paths to your sequence files.
- Supported formats: `.fasta`, `.fasta.gz`, `.fastq`, `.fastq.gz`.
- Note: Use standard gzip; `bgzip` is not supported.

```bash
# Example reads.lst content
/path/to/reads_part1.fastq.gz
/path/to/reads_part2.fastq.gz
```

### 2. Basic Execution
The primary binary is `pg_asm`. The basic syntax is:
`pg_asm <input_reads_list> <output_directory> <n_threads> <n_chunks>`

```bash
pg_asm reads.lst asm_out 20 32
```

### 3. Assembly Modes
- **Standard Mode**: Includes a round of read-level error correction. Best for maximum accuracy.
- **Fast Mode (`--fast`)**: Eliminates the error correction stage. Use this for "perfect" reads (like high-quality HiFi) to significantly reduce wall-clock time.

## Parameter Tuning and Best Practices

### Optimizing Sensitivity
If the default assembly is too fragmented, increase sensitivity by reducing the reduction factor and window size:
- **Reduction Factor (`-r`)**: Default is 6. Try `-r 4` for higher sensitivity.
- **Window Size (`-w`)**: Default is 80. Try `-w 64` for human assemblies.

### Key CLI Options
- `-k <int>`: Kmer size (default: 56).
- `-b <int>`: Number of best overlaps for the initial graph (default: 6).
- `-t <float>`: Alignment tolerance (default: 0.01).
- `--keep`: Retain intermediate files in the output directory for debugging or manual inspection.
- `--no_resolve`: Disable the final step of resolving repeats and duplications.

### Performance Benchmarks
- **Human CHM13 (30x coverage)**:
  - Fast Mode: ~2.75 hours wall clock time (20 cores).
  - Standard Mode: ~5.75 hours wall clock time (20 cores).

## Troubleshooting
- **Memory Issues**: If running on a system with limited RAM (e.g., 32GB), you must manually adjust the `<n_chunks>` parameter to a higher value to reduce the memory footprint per process.
- **Thread Limits**: Ensure the number of threads specified matches your hardware; older versions had issues exceeding 99 threads, though this is addressed in version 0.4.11+.

## Reference documentation
- [Main Repository and Usage Guide](./references/github_com_cschin_peregrine-2021.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_peregrine-2021_overview.md)