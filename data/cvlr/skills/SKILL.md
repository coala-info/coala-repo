---
name: cvlr
description: "cvlr clusters and visualizes long-read sequencing data based on shared features like methylation patterns or genetic variants. Use when user asks to cluster long reads by CpG methylation, resolve haplotype-specific signals, or generate heatmaps of read clusters."
homepage: https://github.com/EmanueleRaineri/releases/
---


# cvlr

## Overview
cvlr (Clustering and Visualization of Long Reads) is a specialized bioinformatics tool used to group long-read sequencing data into clusters based on shared features, most commonly CpG methylation patterns or single nucleotide variants (SNVs). It allows researchers to move beyond bulk analysis by resolving haplotype-specific epigenetic signals or identifying distinct sub-populations of reads within a sample. The tool typically operates on aligned BAM files and produces both tabular clustering data and visual plots (e.g., heatmaps) of the read clusters.

## Installation and Setup
Install cvlr via Bioconda:
```bash
conda install bioconda::cvlr
```

## Common CLI Patterns

### Clustering Reads by Methylation
The primary command is `cluster`, which requires a BAM file and a reference genome.
```bash
cvlr cluster -b input.bam -r reference.fasta -c region_coords > clusters.tsv
```
*   `-b`: Indexed BAM file containing long reads (with methylation tags like MM/ML if clustering by epigenetics).
*   `-r`: Reference genome in FASTA format.
*   `-c`: Genomic region of interest (e.g., `chr1:1000000-1010000`).

### Visualizing Clusters
After clustering, use the `plot` command to generate a visual representation of the grouped reads.
```bash
cvlr plot -b input.bam -r reference.fasta -c region_coords -o output_plot.pdf
```

### Working with Methylation Data
If the input BAM contains base modification tags (from callers like Megalodon or Remora), `cvlr` can utilize these directly. Ensure your BAM is properly indexed (`samtools index`).

## Expert Tips
- **Region Selection**: `cvlr` is most effective when targeted at specific loci (e.g., imprinted regions, promoters, or known SVs) rather than genome-wide, due to the computational intensity of the clustering algorithms.
- **Read Depth**: For reliable clustering, ensure the region has sufficient coverage (typically >20x). Low coverage may lead to unstable clusters.
- **Haplotype Phasing**: When using `cvlr` for phasing, combine it with a VCF file if available to improve the accuracy of the clusters by anchoring them to known genetic variants.

## Reference documentation
- [cvlr - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cvlr_overview.md)