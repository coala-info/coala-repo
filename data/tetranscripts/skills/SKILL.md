---
name: tetranscripts
description: TEtranscripts quantifies transposable element and gene expression by using an expectation-maximization algorithm to optimally distribute multi-mapping RNA-seq reads. Use when user asks to quantify transposable element expression, handle multi-mapping reads in repetitive regions, or perform differential expression analysis of TE families.
homepage: http://hammelllab.labsites.cshl.edu/software#TEToolkit
---


# tetranscripts

## Overview
TEtranscripts (part of the TEToolkit) addresses the challenge of multi-mapping reads in repetitive regions of the genome. While standard RNA-seq pipelines often discard reads mapping to transposable elements, this tool uses an expectation-maximization (EM) algorithm to optimally distribute multi-mapping reads between genes and TE families. It is essential for researchers studying the role of transposons in development, aging, or disease contexts where TE activation is expected.

## Core Usage Patterns

### Basic Quantification
The primary command is `TEtranscripts`. At a minimum, it requires BAM files (sorted by coordinate), a gene annotation file (GTF), and a TE annotation file (GTF).

```bash
TEtranscripts --format BAM --mode multi \
  --treatment sample1.bam sample2.bam \
  --control control1.bam control2.bam \
  --GTF genes.gtf --TE te_annotation.gtf \
  --project experiment_output
```

### Key Parameters
- `--mode`: 
    - `multi` (Default/Recommended): Uses the EM algorithm to redistribute multi-mapping reads.
    - `unique`: Only counts uniquely mapped reads.
- `--format`: Usually `BAM`. Ensure BAM files are coordinate-sorted.
- `--stranded`: Use `yes`, `no`, or `reverse` depending on your RNA-seq library preparation.
- `--min_id`: Minimum identity for a read to be counted (default is 0).

## Expert Tips & Best Practices

### Annotation Requirements
TEtranscripts requires specific GTF formats for TEs. It is highly recommended to use the pre-built annotation files provided by the Hammell Lab (e.g., for hg38 or mm10) which group TEs by family/subfamily. Using raw RepeatMasker output without proper formatting will lead to errors.

### Alignment Considerations
To get the most out of the EM algorithm, your upstream aligner (e.g., STAR) must be configured to allow multi-mapping reads. 
- Set `--outFilterMultimapNmax 100` or higher in STAR.
- Set `--winAnchorMultimapNmax 100` or higher.
- Ensure the BAM file contains the `NH` (number of hits) tag, which TEtranscripts uses to identify multi-mappers.

### Differential Expression
TEtranscripts can internally call DESeq2 or edgeR if the R dependencies are installed. However, for maximum control, it is often better to take the generated `.cnt` (count) file and perform downstream differential expression analysis manually in R, treating the TE families as additional "genes."

## Reference documentation
- [TEtranscripts Overview](./references/anaconda_org_channels_bioconda_packages_tetranscripts_overview.md)