---
name: bolt-lmm-example
description: The bolt tool is a high-performance structural variant caller optimized for short-read genomic data.
homepage: https://github.com/sakkayaphab/bolt
---

# bolt-lmm-example

## Overview
The bolt tool is a high-performance structural variant caller optimized for short-read genomic data. It is designed to detect various types of SVs by analyzing alignment files (BAM) in relation to a reference FASTA file. This skill should be used when you need to integrate SV calling into a bioinformatics pipeline, whether running natively on Linux/macOS or via containerized environments like Docker. It focuses on the core `call` functionality and efficient resource allocation through multi-threading.

## Installation and Setup

### Conda (Recommended)
The simplest way to install bolt and its dependencies (like Intel TBB) is via bioconda:
```bash
conda install -c intel tbb
conda install -c bioconda bolt
```

### Docker
For reproducible environments, use the official Docker image. Ensure you mount your local data directories to the container:
```bash
docker run -v /path/to/data:/opt/mount --name bolt sakkayaphab/bolt:latest \
  /project/build/bolt call \
  -b /opt/mount/sample.bam \
  -r /opt/mount/ref.fa \
  -t 16 \
  -o /opt/mount/output_folder
```

## Command Line Usage

The primary command for variant discovery is `bolt call`.

### Core Arguments
- `-b`: Path to the input alignment file (BAM format).
- `-r`: Path to the reference genome file (FASTA format).
- `-t`: Number of threads to utilize for parallel processing.
- `-o`: Path to the output directory where results will be stored.

### Standard Execution Pattern
To run a standard analysis on a local machine:
```bash
bolt call -b input.bam -r reference.fasta -t 8 -o ./sv_results
```

## Best Practices and Expert Tips

- **Thread Optimization**: Bolt scales well with threads. For large human genomes, using 16-32 threads is recommended if hardware permits to significantly reduce processing time.
- **Input Preparation**: Ensure your BAM files are coordinate-sorted and indexed (`.bai` files present in the same directory) before running bolt to avoid potential access errors.
- **Memory Management**: Since bolt utilizes Intel TBB for task scheduling, ensure your environment has sufficient RAM allocated, especially when increasing the thread count (`-t`).
- **Output Handling**: Bolt creates a directory for its output. Ensure the parent directory is writable and that you provide a unique folder name for different samples to prevent overwriting data.
- **Library Dependencies**: If building from source, bolt requires GCC >= 5.4 and HTSlib >= 1.9. If you encounter linking errors, verify that `LD_LIBRARY_PATH` includes the paths to these libraries.

## Reference documentation
- [bolt - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bolt_overview.md)
- [sakkayaphab/bolt: bolt is a general-purpose SV caller](./references/github_com_sakkayaphab_bolt.md)