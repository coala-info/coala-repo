---
name: minipileup
description: minipileup is a lightweight tool for rapid variant calling and allele counting directly from BAM files. Use when user asks to call variants, count alleles across multiple samples, or generate a multi-sample VCF from alignment data.
homepage: https://github.com/lh3/minipileup
---


# minipileup

## Overview

`minipileup` is a lightweight C-based tool designed for rapid variant calling and allele counting directly from BAM files. It is particularly effective for applications where traditional callers are over-engineered, such as investigating specific alignment data or counting alleles in non-standard genomic contexts. It operates by filtering reads, counting alleles at each position across multiple samples, and outputting a multi-sample VCF.

## Core Workflow

The standard workflow requires a reference FASTA (indexed) and one or more BAM files.

1.  **Index the Reference**: The reference FASTA must be indexed using `samtools faidx`. Note that bgzip'd FASTA files are not supported.
2.  **Run minipileup**: Execute the caller to generate a VCF.

```bash
# Step 1: Index reference
samtools faidx ref.fa

# Step 2: Call variants
minipileup -yf ref.fa -p 0.2 aln1.bam aln2.bam > output.vcf
```

## Command Line Options

### Filtering and Quality Control
*   `-q <int>`: Minimum mapping quality (default is 20 when using `-y`).
*   `-Q <int>`: Minimum base quality.
*   `-l <int>`: Minimum alignment length.
*   `-S <int>`: Minimum soft-clipped alignment length.
*   `-T <int>`: Ignore bases within a specific distance from the ends of reads.

### Allele Counting and Thresholds
*   `-s <int>`: Minimum number of reads to support an allele.
*   `-a <int>`: Minimum number of reads to support an allele on each strand (useful for filtering strand bias).
*   `-p <float>`: Minimum minor allele fraction. In heterozygous genotypes, the minor allele must exceed this threshold.

### Output Configuration
*   `-f <file>`: Reference FASTA file (required for VCF output).
*   `-y`: Output in VCF format (recommended for most variant calling tasks).
*   `-C`: Output strand information.
*   `-b <file>`: Specify regions via a BED file to limit the analysis.

## Best Practices

*   **Speed vs. Accuracy**: `minipileup` does not perform local realignment or reassembly. While faster than GATK, it may be less accurate in regions with complex indels. Use it for rapid screening or allele counting rather than clinical-grade discovery.
*   **Multi-Sample Analysis**: You can pass multiple BAM files in a single command to generate a unified multi-sample VCF, which is more efficient than merging individual VCFs later.
*   **Allele Counting**: If your primary goal is counting alleles rather than calling variants, `minipileup` is significantly faster and more convenient than parsing the output of `samtools mpileup`.

## Reference documentation
- [minipileup GitHub README](./references/github_com_lh3_minipileup.md)
- [minipileup Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_minipileup_overview.md)