---
name: longcallr
description: Longcallr identifies variants and phases haplotypes from long-read RNA-seq alignments. Use when user asks to call variants, phase haplotypes, perform allele-specific expression analysis, or analyze allele-specific junctions in long-read transcriptomics data.
homepage: https://github.com/huangnengCSU/longcallR
---


# longcallr

## Overview

longcallr is a specialized Rust-based tool designed to handle the specific challenges of long-read transcriptomics, such as high error rates and splicing complexity. It enables researchers to identify variants and phase haplotypes directly from RNA-seq alignments. Beyond variant calling, the tool includes a suite of scripts for downstream allele-specific expression and junction analysis, making it a comprehensive solution for studying monoallelic or biased gene expression in single-molecule sequencing data.

## Installation and Setup

The most efficient way to install longcallr is via Bioconda:

```bash
mamba install longcallr
# or
conda install bioconda::longcallr
```

Ensure your reference FASTA file is indexed (using `samtools faidx`) before running the tool.

## Recommended Alignment Parameters

For optimal SNP calling, reads should be aligned using `minimap2` with specific flags based on the sequencing protocol. The `-uf` option is critical for single-stranded protocols to force a single transcript strand.

| Protocol | Recommended minimap2 Command |
| :--- | :--- |
| **PacBio MAS-Seq** | `minimap2 -ax splice:hq -uf ref.fa query.fa > aln.sam` |
| **PacBio Iso-Seq** | `minimap2 -ax splice:hq ref.fa query.fa > aln.sam` |
| **Nanopore dRNA** | `minimap2 -ax splice -uf -k14 ref.fa reads.fa > aln.sam` |
| **Nanopore cDNA** | `minimap2 -ax splice ref.fa reads.fa > aln.sam` |

## Core SNP Calling and Phasing

The primary command `longcallR` requires a BAM file, a reference genome, and a preset corresponding to the sequencing technology.

```bash
longcallR -b input.bam -f ref.fa -o output_prefix -p <preset> -t <threads>
```

### Available Presets (`-p`)
- `ont-cdna`: Nanopore cDNA reads.
- `ont-drna`: Nanopore direct RNA reads (disables strand bias filtering).
- `hifi-isoseq`: PacBio Iso-Seq reads.
- `hifi-masseq`: PacBio MAS-Seq reads (disables strand bias filtering).

## Allele-Specific Analysis

After phasing, use the resulting phased BAM file to perform allele-specific analysis.

### Allele-Specific Expression (ASE)
Quantifies expression levels for different alleles.
```bash
longcallR-ase -b phased.bam -a annotation.gtf -o output_prefix -t 8 --gene_types protein_coding
```

### Allele-Specific Junction (ASJ)
Identifies differential splicing between haplotypes.
```bash
longcallR-asj -b phased.bam -a annotation.gtf -f ref.fa -o output_prefix -t 8
```

### Visualization
To visualize allele-specific junctions in IGV, convert the TSV output to BED format:
```bash
asj_to_bed.py output.asj.tsv [p_value_threshold] > output.asj.bed
```

## Expert Tips
- **Strand Bias**: For direct RNA (dRNA) and MAS-Seq, always use the specific presets (`ont-drna` or `hifi-masseq`) because these protocols naturally exhibit strand bias that would otherwise be filtered out by the standard cDNA logic.
- **Resource Allocation**: SNP calling is computationally intensive; use the `-t` flag to allocate at least 8-16 threads for standard human datasets.
- **Input Quality**: Ensure your BAM file is sorted and indexed. If using Nanopore data, ensure the basecaller used (e.g., Dorado or Guppy) is appropriate for the chemistry to minimize false positive SNP calls.

## Reference documentation
- [longcallR GitHub Repository](./references/github_com_huangnengCSU_longcallR.md)
- [Bioconda longcallr Overview](./references/anaconda_org_channels_bioconda_packages_longcallr_overview.md)