---
name: scssim
description: scssim simulates single-cell genomic data by injecting variations into a reference genome and mimicking the amplification and sequencing process. Use when user asks to simulate genomic variations, learn sequencing profiles from real-world data, or generate synthetic single-cell reads.
homepage: https://github.com/qasimyu/scssim
---


# scssim

## Overview

`scssim` (Single-Cell Genome Sequencing Simulator) is a bioinformatics tool designed to emulate the complexities of single-cell genomic data. It allows researchers to create synthetic datasets by first injecting defined variations into a reference genome and then simulating the amplification and sequencing process. The tool is particularly useful for benchmarking single-cell variant callers and evaluating the impact of sequencing platform-specific biases (like GC-content bias and Phred quality distributions) on single-cell analysis workflows.

## Core Workflow

The tool operates in three distinct stages: genome variation injection, profile learning (optional), and read generation.

### 1. Simulating Genomic Variations (simuvars)
Use this module to create a modified version of a reference genome containing single nucleotide polymorphisms (SNPs), small insertions/deletions (indels), and copy number variations (CNVs).

```bash
scssim simuvars -r <reference.fa> -s <snps.txt> -v <vars.txt> -o <output_simu.fa>
```

**Key Parameters:**
- `-r`: Reference genome in FASTA format (can be gzipped).
- `-s`: File defining known SNPs.
- `-v`: File defining specific variations (indels, CNVs) to insert.
- `-o`: Path for the resulting simulated single-cell genome.

### 2. Learning Sequencing Profiles (learn)
This optional step allows you to extract error models and quality profiles from real-world Illumina data to make the simulation more realistic.

```bash
scssim learn -b <sample.bam> -v <sample.vcf> -r <reference.fa> -o <sample.profile>
```

**Expert Tips:**
- Ensure the BAM file is indexed.
- The tool measures four specific profiles: indel error distributions, base substitution probabilities, Phred quality distributions, and GC-content bias.
- If you do not have a custom dataset, use the pre-built models provided in the `testData/models` directory (e.g., `Illumina_HiSeq2500.profile`).

### 3. Generating Reads (genreads)
This module mimics the single-cell genome amplification and read generation procedures.

```bash
scssim genreads -i <simu.fa> -m <profile.profile> -r <error_rate> -t <threads> -o <output_prefix>
```

**Key Parameters:**
- `-i`: The simulated genome produced by `simuvars`.
- `-m`: The sequencing profile (either learned or pre-built).
- `-r`: Mutation/error rate (e.g., `2e-10`).
- `-t`: Number of threads for parallel processing.

## Best Practices

- **Reference Compatibility**: Always use the same reference genome for the `learn` step that you intend to use as the base for `simuvars` to ensure coordinate consistency.
- **Resource Management**: Read generation is computationally intensive. Use the `-t` flag to leverage multiple CPU cores on HPC environments.
- **Input Validation**: Ensure your variation files (`-s` and `-v`) follow the specific tab-delimited formats expected by the tool to avoid parsing errors.
- **Amplification Bias**: Remember that `scssim` is specifically designed for single-cell data; it accounts for the uneven coverage and amplification artifacts that distinguish single-cell sequencing from bulk sequencing.

## Reference documentation
- [SCSsim GitHub Repository](./references/github_com_qasimyu_scssim.md)
- [Bioconda scssim Package Overview](./references/anaconda_org_channels_bioconda_packages_scssim_overview.md)