---
name: art_modern-openmpi
description: art_modern-openmpi is a high-performance read simulator that uses MPI support to generate synthetic sequencing data across distributed computing environments. Use when user asks to simulate Illumina sequencing reads, perform large-scale whole genome or transcriptome simulations, or generate synthetic FASTQ files using specific error profiles.
homepage: https://github.com/YU-Zhejian/art_modern
---


# art_modern-openmpi

## Overview

art_modern is a high-performance re-implementation of the widely used ART read simulator. It offers significantly improved execution speed and expanded functionality while maintaining compatibility with legacy ART error profiles. This specific version, art_modern-openmpi, is compiled with Message Passing Interface (MPI) support, enabling large-scale read simulation across distributed computing nodes or high-core-count environments. It supports various sequencing modes including Whole Genome Sequencing (WGS) and Transcriptome (RNA-Seq) simulation.

## Core CLI Usage

### Basic WGS Simulation
To simulate single-end (SE) reads with a specific coverage:
```bash
art_modern \
  --mode wgs \
  --lc se \
  --i-file reference.fasta \
  --o-fastq output.fastq \
  --i-fcov 10
```

### Paired-End (PE) Simulation
Paired-end simulation requires defining the fragment length distribution:
```bash
art_modern \
  --mode wgs \
  --lc pe \
  --i-file reference.fasta \
  --o-fastq output.fastq \
  --i-fcov 20 \
  --pe_frag_dist_mean 300 \
  --pe_frag_dist_std_dev 50
```

### Using Built-in Profiles
Specify a sequencer model and read length using the built-in quality profiles:
```bash
art_modern --mode wgs --lc se --i-file ref.fa --o-fastq out.fq --builtin_qual_file HiSeq2500_150bp --read_len 150
```

## MPI and Parallelization

### Single-Node Parallelization
Use the `--parallel` flag to utilize all available threads on a single machine:
```bash
art_modern --mode wgs --parallel [other_args]
```

### Multi-Node MPI Execution
When using the OpenMPI-enabled version on a cluster, invoke the tool via `mpirun`:
```bash
mpirun -np <num_processes> art_modern --mode wgs [other_args]
```

## Expert Tips and Best Practices

- **Output Handling**: For paired-end simulations, art_modern may generate a single interleaved FASTQ. Most downstream pipelines require these to be split into two files (R1 and R2) and potentially sorted.
- **Profile Accuracy**: Be aware that the original ART profile builder had a known bug where quality scores were offset by 1. art_modern includes a modernized profile creator that fixes this issue and supports FASTQ, SAM, and BAM inputs.
- **Performance**: For maximum performance, avoid using the fully static builds if MPI or NCBI SRA support is required, as static builds typically lack these features.
- **RNA-Seq**: When simulating transcriptomes, it is recommended to use a high-level simulator (like YASIM) to generate expression counts first, then provide the quantified cDNA molecules to art_modern.

## Reference documentation
- [art_modern GitHub Repository](./references/github_com_YU-Zhejian_art_modern.md)
- [art_modern-openmpi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_art_modern-openmpi_overview.md)
- [Known Bugs and Security](./references/github_com_YU-Zhejian_art_modern_security.md)