---
name: nanocall
description: NanoCaller uses deep convolutional neural networks to detect SNPs and indels in long-read sequencing data from ONT and PacBio platforms. Use when user asks to call variants, perform local realignment for indels, or generate phased VCF and BAM files from long-read alignments.
homepage: https://github.com/WGLab/NanoCaller
---


# nanocall

## Overview

NanoCaller is a computational tool that utilizes deep convolutional neural networks to detect variants in long-read sequencing data. It leverages long-range haplotype structures to improve SNP calling and performs local realignment for accurate indel prediction. The tool is highly adaptable, offering specialized models for different sequencing chemistries (ONT R9.4.1, R10.3) and platforms (PacBio HiFi/CCS and CLR).

## Installation Quick Start

The recommended way to install NanoCaller is via Bioconda:

```bash
conda create -n nanocaller_env -c bioconda nanocaller
conda activate nanocaller_env
```

## Common CLI Patterns

### Whole Genome Variant Calling
Run both SNP and indel calling on all chromosomes using multiple CPUs:
```bash
NanoCaller --bam sample.bam --ref reference.fasta --cpu 16
```

### Targeted Calling
Limit analysis to specific chromosomes or genomic coordinates:
```bash
NanoCaller --bam sample.bam --ref reference.fasta --regions chr21 chr22:20000000-21000000
```

### SNP Calling with Phasing
Call only SNPs and generate a phased BAM file (stored in `intermediate_phase_files`):
```bash
NanoCaller --bam sample.bam --ref reference.fasta --mode snps --phase
```

### Haploid Genome Handling
For haploid organisms or specific sex chromosomes in males:
```bash
# For entirely haploid genomes
NanoCaller --bam sample.bam --ref reference.fasta --haploid_genome

# For diploid genomes with a haploid X chromosome
NanoCaller --bam sample.bam --ref reference.fasta --haploid_X
```

## Model Selection

NanoCaller uses specific models optimized for different technologies. Specify them using `--snp_model` and `--indel_model`.

| Technology | Recommended SNP Model | Recommended Indel Model |
| :--- | :--- | :--- |
| **ONT (Standard)** | `ONT-HG002` | `ONT-HG002` |
| **ONT (Bonito)** | `ONT-HG002_bonito` | `ONT-HG002` |
| **PacBio HiFi/CCS** | `CCS-HG002` | `CCS-HG002` |
| **PacBio CLR** | `CLR-HG002` | `NanoCaller3` |

Example command with specific models:
```bash
NanoCaller --bam input.bam --ref ref.fa --snp_model ONT-HG002_bonito --indel_model ONT-HG002
```

## Expert Tips and Best Practices

- **High Coverage Normalization**: For samples with very high coverage, use the option to disable region-based coverage normalization if you encounter performance bottlenecks (available in v3.6.2+).
- **CRAM Support**: NanoCaller supports CRAM input. However, if you are using the `--phase` option with CRAM, ensure `WhatsHap` version 2.0 or higher is installed.
- **Phasing Quality Filter**: Use `--phase_qual_score` to filter out low-quality SNP calls from the phasing process. These SNPs will remain in the output VCF but will not be used to phase reads, improving the reliability of the final phased BAM.
- **Large Contigs**: NanoCaller generates CSI indices for VCF files by default (v3.6.0+) to accommodate genomes with very large contigs that exceed the limits of traditional TBI indices.
- **Memory Management**: When running on whole genomes, ensure sufficient memory is allocated per CPU core, as deep learning model inference and local realignment can be memory-intensive.

## Reference documentation
- [NanoCaller Main Documentation](./references/github_com_WGLab_NanoCaller.md)