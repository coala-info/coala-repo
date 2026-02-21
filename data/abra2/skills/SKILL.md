---
name: abra2
description: "Could not get help from Singularity for: abra2"
homepage: https://github.com/mozack/abra2
---

# abra2

## Overview

ABRA2 is a localized assembly-based realigner for next-generation sequencing data. It functions by identifying regions potentially containing structural variation or indels, performing a de novo assembly of reads in those regions, and then realigning the original reads to the resulting contigs. This process significantly improves the accuracy of indel detection compared to standard mapping alone. It supports both DNA and RNA-seq data, scaling effectively from targeted panels to whole human genomes.

## Installation and Requirements

Install ABRA2 via Bioconda:
```bash
conda install bioconda::abra2
```
Running ABRA2 requires Java 8. Ensure the Java heap size is appropriately configured using the `-Xmx` flag based on the size of your dataset.

## Core Workflows

### DNA Realignment
Use ABRA2 to realign DNA reads, typically from BWA-aligned BAM files. For somatic analysis, provide both normal and tumor BAMs simultaneously to ensure consistent realignment across samples.

```bash
java -Xmx16G -jar abra2.jar \
  --in normal.bam,tumor.bam \
  --out normal.abra.bam,tumor.abra.bam \
  --ref reference.fa \
  --threads 8 \
  --targets targets.bed \
  --tmpdir ./temp
```

### RNA Realignment
For RNA-seq, ABRA2 utilizes junction information to assist in assembly. It is optimized for output from the STAR aligner.

```bash
java -Xmx16G -jar abra2.jar \
  --in star.bam \
  --out star.abra.bam \
  --ref reference.fa \
  --junctions bam \
  --gtf annotation.gtf \
  --threads 8 \
  --dist 500000 \
  --sua \
  --tmpdir ./temp
```

## Critical Parameters and Best Practices

### Input Preparation
- **Sorting**: Input BAM files must be coordinate-sorted.
- **Indexing**: Input BAM files must be indexed (`.bai` files present).
- **Reference**: The reference FASTA must match the one used for initial alignment.

### Resource Management
- **Temporary Storage**: The `--tmpdir` directory requires significant disk space, often equal to or greater than the size of the input BAM files. Ensure the path points to a high-capacity volume.
- **Memory**: Allocate sufficient RAM via Java's `-Xmx` parameter. 16GB is a standard starting point for human samples, but whole-genome runs may require more.

### Optimization Tips
- **Targeted Regions**: Use the `--targets` argument with a BED file to restrict realignment to specific regions (e.g., exome targets). If omitted, the entire genome is processed, which significantly increases runtime.
- **Known Indels**: Provide known indels via `--in-vcf` to guide the realigner. This is particularly useful when you have high-confidence indels from DNA that you want to verify or use in RNA realignment.
- **Splice Junctions**: In RNA mode, use `--junctions bam` to identify junctions on the fly, or provide a specific junction file (like STAR's `SJ.out.tab`). Combining this with `--gtf` provides the best results for transcriptomic data.
- **Soft Clipping**: The `--sua` (Soft-clip Unmapped Anchor) flag is recommended for RNA-seq to help anchor reads that might otherwise remain unmapped near junctions.

## Reference documentation
- [ABRA2 GitHub Repository](./references/github_com_mozack_abra2.md)
- [Bioconda ABRA2 Package](./references/anaconda_org_channels_bioconda_packages_abra2_overview.md)