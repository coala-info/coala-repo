---
name: pirs-profiles
description: pIRS (profile-based Illumina pair-end Reads Simulator) is a specialized tool for generating synthetic genomic data that mimics the characteristics of the Illumina sequencing platform.
homepage: https://github.com/galaxy001/pirs
---

# pirs-profiles

## Overview
pIRS (profile-based Illumina pair-end Reads Simulator) is a specialized tool for generating synthetic genomic data that mimics the characteristics of the Illumina sequencing platform. This skill provides guidance on using the two primary subcommands: `pirs diploid` for introducing heterozygosity (SNPs, Indels, and Structural Variations) into a reference genome, and `pirs simulate` for generating the actual paired-end reads based on empirical quality and coverage profiles.

## Core Workflows

### 1. Generating a Diploid Genome
Use `pirs diploid` to create a second version of a reference genome with simulated mutations. This is necessary if you want to simulate sequencing from a diploid organism.

```bash
pirs diploid [options] <reference.fa>
```

**Key Parameters:**
- `-s, --snp-rate`: Heterozygous SNP rate (default: 0.001).
- `-d, --indel-rate`: Heterozygous indel rate (default: 0.0001).
- `-v, --sv-rate`: Large-scale structural variation rate (default: 0.000001).
- `-R`: Transition-to-transversion ratio (default: 2.0).
- `-o`: Output prefix for the generated FASTA and log files.

### 2. Simulating Illumina Reads
Use `pirs simulate` to generate FASTQ files. You can provide one reference (haploid) or two (diploid).

```bash
pirs simulate [options] <ref1.fa> [ref2.fa]
```

**Common Options:**
- `-l`: Read length.
- `-x`: Average coverage depth (e.g., 30 for 30x).
- `-m`: Mean insert size.
- `-v`: Standard deviation of insert size.
- `-o`: Output prefix for the .fastq files.

### 3. Profile Generation (Advanced)
For high-fidelity simulations, pIRS uses profiles to model errors and GC bias. If you have existing alignment data (BAM/SAM), you can generate custom profiles:
- **GC-Depth Profile**: Use `gc_coverage_bias` on depth files.
- **Base-Calling Profile**: Use `error_matrix_calculator` on SAM/BAM files to generate `*.matrix` files.
- **InDel Profile**: Use `indelstat_sam_bam` on samples with no known polymorphism.

## Expert Tips and Best Practices
- **Diploid Simulation**: When simulating a diploid organism, always run `pirs diploid` first to get the second "allele" sequence, then pass both the original reference and the diploid output to `pirs simulate`.
- **Memory Management**: For large genomes, ensure you have sufficient RAM, as pIRS loads the reference sequences into memory.
- **Randomness**: Use the `-S` (seed) option if you need to generate reproducible datasets for testing pipelines.
- **Input Formats**: pIRS supports gzipped FASTA files as input, which helps save disk space when working with large reference genomes.
- **Output Handling**: By default, pIRS generates several log files. Use the `-n` or `--no-logs` flag in `pirs diploid` if you only need the sequence output.

## Reference documentation
- [pIRS GitHub README](./references/github_com_galaxy001_pirs.md)
- [Bioconda pIRS Overview](./references/anaconda_org_channels_bioconda_packages_pirs_overview.md)