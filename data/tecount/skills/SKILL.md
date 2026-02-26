---
name: tecount
description: tecount aggregates RNA-seq read alignments across transposable element hierarchies to generate count tables for subfamilies, families, and classes. Use when user asks to quantify transposable elements, generate TE count tables from BAM files, or analyze TE expression levels across different hierarchical classifications.
homepage: https://github.com/bodegalab/tecount
---


# tecount

## Overview

tecount is a specialized bioinformatics tool designed to aggregate RNA-seq read alignments across transposable element hierarchies. While standard tools often struggle with the repetitive nature of TEs, tecount provides a streamlined workflow to generate count tables for TE subfamilies, families, and classes. It is essential for researchers investigating TE activation, genomic stability, or non-canonical transcript variants in transcriptomic datasets.

## Installation and Requirements

The tool relies on `samtools` (>= 1.14) and `bedtools` (>= 2.30.0). It is most reliably installed via Conda:

```bash
conda create -n tecount -c conda-forge -c bioconda tecount
conda activate tecount
```

## Core Usage Patterns

### Basic Quantification
The primary command requires a coordinate-sorted BAM file and a specific BED6+3 reference file where columns 7, 8, and 9 represent the TE subfamily, family, and class respectively.

```bash
TEcount -b input_sorted.bam -r reference_rmsk.bed
```

### Input Preparation
1. **BAM Sorting**: Ensure your BAM file is sorted by coordinates, not by read name.
   ```bash
   samtools sort input.bam -o input_sorted.bam
   ```
2. **Reference BED**: The reference file (often derived from RepeatMasker) must contain the hierarchical classification in the trailing columns. If using the test datasets provided by the developers, these are typically formatted as `rmsk.bed`.

## Expert Tips and Best Practices

- **Multi-mapping Strategy**: tecount handles reads aligning to multiple TE loci by counting only one alignment occurrence for each specific feature (subfamily, family, or class). This prevents over-inflation of counts in highly repetitive regions.
- **Strand Specificity**: If your RNA-seq library is stranded, ensure you check the strand-specific options using `TEcount --help` to match your library preparation (e.g., dUTP/Forward-Probable).
- **Overlap Filtering**: You can fine-tune the sensitivity of the tool by adjusting the minimum read-TE overlap requirements. This is useful when trying to exclude spurious alignments that only partially cover a TE locus.
- **Output Structure**: The tool generates separate output files for each hierarchical level. When performing downstream differential expression analysis (e.g., with DESeq2 or EdgeR), ensure you select the level (subfamily vs. class) that matches your biological hypothesis.
- **Paired-End Data**: The tool natively supports both single-end and paired-end BAM files. For paired-end data, it correctly handles fragment counts rather than double-counting individual mates.

## Reference documentation
- [tecount - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_tecount_overview.md)
- [GitHub - bodegalab/tecount](./references/github_com_bodegalab_tecount.md)