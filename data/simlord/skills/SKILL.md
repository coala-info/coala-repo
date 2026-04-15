---
name: simlord
description: SimLoRD simulates long-read sequencing data from a reference genome with realistic PacBio error profiles and read-length distributions. Use when user asks to generate synthetic long reads, simulate PacBio sequencing data, or create realistic datasets for benchmarking and tool development.
homepage: https://bitbucket.org/genomeinformatics/simlord/
metadata:
  docker_image: "quay.io/biocontainers/simlord:1.0.4--py39hbcbf7aa_5"
---

# simlord

## Overview
SimLoRD (Simulation of Long Reads from DNA) is a specialized tool designed to mimic the characteristics of third-generation sequencing. It focuses on the stochastic nature of PacBio reads, including high indel error rates and specific read-length distributions (log-normal). This skill provides the necessary command-line patterns to generate realistic synthetic datasets for benchmarking and tool development.

## Basic Usage
The primary command for generating reads requires a reference genome and an output prefix.

```bash
simlord --read-reference reference.fasta output_prefix
```

### Key Parameters
- `-n, --num-reads`: Specify the exact number of reads to generate.
- `-c, --coverage`: Generate reads until a specific fold-coverage is reached (alternative to `-n`).
- `-fl, --fixed-readlength`: Set a constant length for all generated reads.
- `-mr, --min-readlength`: Set a threshold to discard reads shorter than this value (default is 50bp).

## Advanced Error Modeling
SimLoRD allows fine-grained control over the error profile to simulate different chemistry versions or extreme sequencing conditions.

### Error Rates
The default PacBio model uses approximately 13% total error, dominated by insertions.
- `--insertion-rate`: Default 0.11
- `--deletion-rate`: Default 0.04
- `--substitution-rate`: Default 0.01

### Read Length Distribution
By default, SimLoRD uses a log-normal distribution. You can customize this using:
- `--m-dist`: The "m" parameter (log-mean) of the log-normal distribution.
- `--s-dist`: The "s" parameter (log-standard deviation) of the log-normal distribution.

## Expert Tips
- **Deterministic Results**: Use the `--seed` parameter with a specific integer to ensure that the simulated dataset is reproducible across different runs.
- **Parallelization**: SimLoRD supports multi-threading via the `-t` or `--threads` flag. Increasing threads significantly speeds up the simulation of high-coverage whole genomes.
- **SAM Output**: SimLoRD generates a FASTQ file by default, but it also produces a SAM file mapping the simulated reads back to the reference, which is invaluable for calculating true positive rates in alignment benchmarking.

## Reference documentation
- [SimLoRD Overview](./references/anaconda_org_channels_bioconda_packages_simlord_overview.md)
- [SimLoRD Bitbucket Repository](./references/bitbucket_org_genomeinformatics_simlord.md)