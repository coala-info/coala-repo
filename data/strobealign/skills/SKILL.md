---
name: strobealign
description: Strobealign is a high-performance short-read mapper that uses strobemers to align sequencing reads to a reference genome with high speed and efficiency. Use when user asks to align paired-end or single-end reads, generate PAF mapping coordinates, estimate metagenomic abundance, or create persistent genomic indices.
homepage: https://github.com/ksahlin/StrobeAlign
---


# strobealign

## Overview

Strobealign is a high-performance short-read mapper that utilizes strobemers and dynamic seed sizes to achieve significantly higher speeds than traditional aligners like BWA-MEM. It is designed for efficiency, offering on-the-fly indexing and the ability to output results in standard SAM format or the faster, alignment-free PAF format. This skill provides the necessary command-line patterns to execute alignments, manage indexing, and perform metagenomic binning tasks.

## Installation

The most reliable way to install strobealign is via Bioconda:

```bash
conda create -n strobealign strobealign samtools
conda activate strobealign
```

## Common CLI Patterns

### Standard Paired-End Alignment
To align paired-end reads and produce a sorted BAM file efficiently, pipe the SAM output directly into `samtools`. This avoids large intermediate files.

```bash
strobealign -t 8 reference.fa reads_R1.fastq.gz reads_R2.fastq.gz | samtools sort -o aligned_sorted.bam
```

### Single-End Alignment
```bash
strobealign -t 8 reference.fa reads.fastq.gz | samtools view -bS > aligned.bam
```

### Mapping-Only Mode (PAF Output)
If you only need the mapping coordinates and not the full base-level alignment (CIGAR strings), use the `-x` flag to output PAF format.

```bash
strobealign -x -t 8 reference.fa reads_R1.fastq.gz reads_R2.fastq.gz > output.paf
```

### Metagenomic Abundance Estimation
For metagenomic binning, use the `--aemb` mode to generate a tab-separated table of abundance values (bases mapped divided by contig length).

```bash
strobealign -t 8 --aemb reference.fa reads_R1.fastq.gz reads_R2.fastq.gz > abundances.tsv
```

## Indexing Strategies

Strobealign builds an index on-the-fly by default, which is fast enough for human-sized genomes (<1 minute). However, for repetitive runs, you can manage disk-based indices.

### Creating a Persistent Index
The index parameters are optimized based on read length. If you know your read length (e.g., 150bp), specify it during index creation.

```bash
strobealign -i -r 150 reference.fa
```
This creates a `.sti` file next to your reference FASTA.

### Using a Pre-generated Index
```bash
strobealign --use-index -t 8 reference.fa reads_R1.fastq.gz reads_R2.fastq.gz > output.sam
```

## Expert Tips and Best Practices

- **Thread Scaling**: Use the `-t` flag to match your available CPU cores. Strobealign scales well across multiple threads for both indexing and mapping.
- **Read Length Sensitivity**: Strobealign is most effective for reads between 100bp and 500bp. For very short reads (e.g., <75bp), ensure you use the `-r` flag to set the appropriate canonical read length (50, 75, 100, 125, 150, 250, or 400).
- **Memory Management**: Piping to `samtools` is highly recommended to reduce Disk I/O and storage requirements, as SAM files can be massive.
- **Read Group Metadata**: When preparing files for GATK or other downstream variant callers, use the `--rg-id` and `--rg` flags:
  `--rg-id=1 --rg=SM:sample_name --rg=LB:library_id`
- **Secondary Alignments**: By default, strobealign outputs only the primary alignment. Use `-N INT` to output up to `INT` secondary alignments if your analysis requires multi-mapping information.

## Reference documentation
- [strobealign GitHub Repository](./references/github_com_ksahlin_strobealign.md)
- [strobealign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_strobealign_overview.md)