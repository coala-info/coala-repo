---
name: bolt
description: Bolt is a high-performance structural variant caller optimized for short-read sequencing data. Use when user asks to call structural variants, format command-line arguments for SV detection, or manage the tool's installation and dependencies.
homepage: https://github.com/sakkayaphab/bolt
---


# bolt

## Overview
`bolt` is a high-performance structural variant (SV) caller optimized for short-read sequencing data. Written primarily in C++, it leverages multi-threading to process alignment files efficiently. Use this skill to correctly format command-line calls for SV detection, ensure all necessary genomic reference files are provided, and manage the tool's specific library requirements like Intel TBB and HTSlib.

## Installation and Environment Setup

### Conda (Recommended)
The simplest way to deploy `bolt` is via the Bioconda channel. Ensure you install the Intel Threading Building Blocks (TBB) dependency:
```bash
conda install -c intel tbb
conda install -c bioconda bolt
```

### Docker
For reproducible environments, use the official Docker image. Note that the binary inside the container is typically located at `/project/build/bolt`.
```bash
docker pull sakkayaphab/bolt:latest
```

## Command Line Usage

The primary function of the tool is accessed via the `call` subcommand.

### Basic Syntax
```bash
bolt call -b <alignment.bam> -r <reference.fa> -t <threads> -o <output_folder>
```

### Parameter Details
- `-b`: Path to the input BAM alignment file. Ensure the BAM is indexed (`.bai` file present).
- `-r`: Path to the reference genome in FASTA format.
- `-t`: Number of threads to utilize. `bolt` scales well with higher thread counts due to its Intel TBB implementation.
- `-o`: The directory where output VCF or variant files will be stored.

## Best Practices and Expert Tips

### Resource Allocation
- **Threading**: Always specify the `-t` parameter based on your available CPU cores. For large human whole-genome sequencing (WGS) datasets, using 16-32 threads is recommended to minimize processing time.
- **Memory**: Ensure the system has sufficient RAM to handle the reference genome index and the alignment data structures, especially when using high thread counts.

### Docker Volume Mapping
When running via Docker, you must mount your local data directories to the container's internal paths.
```bash
docker run -v /path/to/local/data:/data --name bolt_run sakkayaphab/bolt:latest \
/project/build/bolt call -b /data/sample.bam -r /data/ref.fa -t 8 -o /data/output
```

### Input Validation
- **Reference Matching**: Ensure the reference FASTA file (`-r`) is the exact same version used to generate the BAM alignment (`-b`). Mismatched chromosome names or lengths will cause the caller to fail or produce inaccurate results.
- **Library Dependencies**: If building from source, `bolt` requires GCC >= 5.4, HTSlib >= 1.9, and CMake >= 3.9.

## Reference documentation
- [bolt - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bolt_overview.md)
- [GitHub - sakkayaphab/bolt: bolt is a general-purpose SV caller](./references/github_com_sakkayaphab_bolt.md)