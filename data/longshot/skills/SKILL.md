---
name: longshot
description: Longshot is a variant caller and phaser optimized for identifying single nucleotide variants in long-read sequencing data. Use when user asks to call SNVs from long reads, phase variants into haplotypes, or generate haplotype-tagged BAM files.
homepage: https://github.com/pjedge/longshot
metadata:
  docker_image: "quay.io/biocontainers/longshot:1.0.0--hd4f2111_2"
---

# longshot

## Overview
Longshot is a specialized variant caller optimized for the unique error profiles of long-read sequencing technologies. Unlike standard callers designed for short-read data, Longshot utilizes a pair Hidden Markov Model (HMM) to account for the high indel and substitution rates in Pacific Biosciences (PacBio) and Oxford Nanopore Technologies (ONT) data. It produces phased VCF files and can optionally output haplotype-tagged BAM files, making it a critical tool for diploid genome analysis, haplotype assembly, and investigating allele-specific phenomena.

## Core Usage Patterns

### Basic SNV Calling
To call SNVs from an aligned long-read dataset, provide the indexed BAM and the reference genome:
```bash
longshot --bam input.bam --ref reference.fasta --out output.vcf
```

### Genotyping and Phasing an Existing VCF
If you already have a set of potential variants (e.g., from a different caller or a database) and want to genotype and phase them using long reads:
```bash
longshot --bam input.bam --ref reference.fasta --potential_variants input.vcf.gz --out phased_output.vcf
```
*Note: The input VCF must be gzipped and tabix indexed.*

### Generating Haplotype-Tagged BAMs
To facilitate downstream visualization or allele-specific analysis, use the `-O` flag to produce a BAM file where reads are assigned to haplotypes (HP:i:1 or HP:i:2):
```bash
longshot --bam input.bam --ref reference.fasta --out output.vcf --out_bam tagged_reads.bam
```

## Expert Tips and Best Practices

### Handling High Coverage
By default, Longshot has a maximum coverage limit (`-C`) of 8000. For regions with extremely high depth or when using the `--auto_max_cov` flag, be aware that execution time will increase. Use `-A` to automatically set the max coverage threshold based on the mean coverage of the region (mean + 5*sqrt(mean)).

### Improving Accuracy in Difficult Regions
If you encounter regions where standard alignment fails or produces low-quality calls:
- **Stable Alignment**: Use `-S` (or `--stable_alignment`) to use log-space pair HMM. This is significantly slower but prevents numerical underflow in long or highly divergent alignments.
- **Quality Thresholds**: Adjust `-q` (min mapping quality, default 20) and `-a` (min allele quality, default 7.0) to filter out unreliable evidence.

### Targeted Analysis
For large genomes, always restrict analysis to specific chromosomes or coordinates to save time and memory:
```bash
longshot --region chr1:1000000-2000000 --bam input.bam --ref reference.fasta --out region_output.vcf
```

### Indel Handling
While Longshot is primarily an SNV caller, it can genotype indels if they are provided via the `--potential_variants` VCF. It will not call new indels de novo from the pileup.

## Reference documentation
- [Longshot GitHub Repository](./references/github_com_pjedge_longshot.md)
- [Bioconda Longshot Package](./references/anaconda_org_channels_bioconda_packages_longshot_overview.md)