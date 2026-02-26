---
name: nanocaller
description: "NanoCaller identifies genomic variants in long-read sequencing data using deep convolutional neural networks and haplotype information. Use when user asks to call variants from long-read datasets, generate phased VCF files, or perform technology-specific variant calling for ONT and PacBio data."
homepage: https://github.com/WGLab/NanoCaller
---


# nanocaller

## Overview
NanoCaller is a variant calling tool that utilizes deep convolutional neural networks (CNN) and long-range haplotype information to identify genomic variants in long-read datasets. It is specifically designed to handle the unique error profiles of long-read technologies and excels in complex genomic regions where traditional callers may struggle. Use this skill to execute variant calling workflows, select technology-specific models, and generate phased VCF files.

## Installation
The recommended way to install NanoCaller is via Bioconda:
```bash
conda create -n nanocaller_env -c bioconda nanocaller
conda activate nanocaller_env
```

## Common CLI Patterns

### Basic Whole Genome Calling
Run variant calling on all chromosomes using default settings and multiple CPUs:
```bash
NanoCaller --bam input.bam --ref reference.fasta --cpu 16
```

### Targeted Calling by Region
Limit analysis to specific contigs or coordinates to save time:
```bash
NanoCaller --bam input.bam --ref reference.fasta --regions chr21 chr22:20000000-21000000 --cpu 8
```

### Phased Variant Calling
Call SNPs and use them to phase the BAM file and subsequent indel calls:
```bash
NanoCaller --bam input.bam --ref reference.fasta --cpu 12 --phase
```

### Haploid Calling
Use for haploid organisms or specific chromosomes (chrY and chrM are assumed haploid by default):
```bash
# Call the entire genome as haploid
NanoCaller --bam input.bam --ref reference.fasta --haploid_genome --cpu 8

# Specify chrX as haploid (e.g., for male samples)
NanoCaller --bam input.bam --ref reference.fasta --haploid_X --cpu 8
```

## Model Selection
NanoCaller requires specific models based on the sequencing technology and basecaller used. Use `--snp_model` and `--indel_model` to specify them.

| Technology | Recommended SNP Model | Recommended Indel Model |
|:---|:---|:---|
| ONT (R9.4.1) | `ONT-HG002` | `ONT-HG002` |
| ONT (Bonito) | `ONT-HG002_bonito` | `ONT-HG002` |
| PacBio HiFi/CCS | `CCS-HG002` | `CCS-HG002` |
| PacBio CLR | `CLR-HG002` | `NanoCaller3` |

Example command with specific models:
```bash
NanoCaller --bam input.bam --ref reference.fasta --snp_model ONT-HG002 --indel_model ONT-HG002 --cpu 16
```

## Expert Tips and Best Practices
- **Input Formats**: As of v3.5.0, NanoCaller supports CRAM files as input. Ensure `whatshap >= 2.0` is installed for CRAM phasing support.
- **High Coverage Samples**: For samples with very high coverage, use the option to disable region-based coverage normalization if you encounter unexpected filtered regions (v3.6.2+).
- **Memory Management**: NanoCaller parallelizes by chromosome/region. If running on a machine with limited RAM, reduce the `--cpu` count to prevent OOM (Out of Memory) errors during the CNN inference stage.
- **Phasing Quality**: Use `--phase_qual_score` to filter out low-quality SNP calls from the phasing process. These SNPs will remain in the VCF but won't be used to phase reads, improving the reliability of the final phased BAM.
- **Large Contigs**: NanoCaller v3.6.0+ generates CSI indices for VCF files instead of TBI to better accommodate very large contigs or non-standard reference genomes.

## Reference documentation
- [NanoCaller GitHub Repository](./references/github_com_WGLab_NanoCaller.md)
- [NanoCaller Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanocaller_overview.md)