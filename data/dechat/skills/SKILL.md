---
name: dechat
description: DeChat performs error correction for Nanopore R10 reads using a combination of de Bruijn graphs and variant-aware multiple sequence alignment. Use when user asks to perform self-correction of ONT reads, conduct hybrid correction using NGS or HiFi data, or remove sequencing errors while preserving biological variants.
homepage: https://github.com/LuoGroup2023/DeChat
---


# dechat

## Overview
DeChat is a specialized error correction tool designed for Nanopore R10 reads, which typically feature error rates below 2%. Unlike traditional correctors that may over-smooth data, DeChat combines de Bruijn graphs (dBG) with variant-aware multiple sequence alignment (MSA). This dual-stage approach ensures that sequencing errors are removed while critical biological variants in repeats and haplotypes are preserved. It supports self-correction using the original ONT reads or hybrid correction using high-accuracy short reads (NGS) or PacBio HiFi reads.

## Installation
The most efficient way to deploy DeChat is via Bioconda:
```bash
conda install -c bioconda dechat
```

## Command Line Usage
The basic syntax requires an input file, an output prefix, and the number of threads.

### Basic Self-Correction
To correct Nanopore reads using the reads themselves:
```bash
dechat -i reads.fq.gz -o output_prefix -t 16
```

### Hybrid Correction (HiFi or NGS)
To leverage higher accuracy reads (HiFi or NGS) to build the de Bruijn graph for correcting ONT reads, use the `-d` flag:
```bash
dechat -i ont_reads.fq.gz -d hifi_reads.fq.gz -o hybrid_output -t 16
```

### Key Parameters and Tuning
- **-k [INT]**: K-mer length (default: 21). Must be less than 64. Adjusting k-mer size can help in highly repetitive genomes.
- **-r1 [INT]**: Maximal abundance threshold for a k-mer in the dBG (default: 2).
- **-r [INT]**: Number of correction rounds in the alignment stage (default: 3).
- **-e [FLOAT]**: Maximum allowed error rate for filtering overlaps (default: 0.04).

## Best Practices and Tips
- **Input Formats**: DeChat accepts both FASTA and FASTQ formats, and they can be gzipped (.gz) to save space.
- **Output Files**: DeChat produces two main outputs. `recorrected.fa` is the result of the first stage (dBG), while the final corrected file is named `<output_prefix>.ec.fa`.
- **Resource Allocation**: Use the `-t` flag to specify threads. Note that some users have reported high CPU utilization even with lower thread counts; ensure the environment has sufficient overhead.
- **Memory Management**: For large datasets, ensure the system has enough RAM to handle the de Bruijn graph construction, especially when using high-coverage NGS data for hybrid correction.

## Reference documentation
- [DeChat GitHub Repository](./references/github_com_LuoGroup2023_DeChat.md)
- [Bioconda DeChat Overview](./references/anaconda_org_channels_bioconda_packages_dechat_overview.md)