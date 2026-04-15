---
name: cistrome-ceas
description: The cistrome-ceas tool provides automated annotation and statistical summaries of ChIP-seq or ChIP-chip peaks relative to genomic features and gene structures. Use when user asks to annotate peaks, determine the distribution of binding events across genomic regions, or generate average profiling plots of signal intensity across gene bodies.
homepage: https://bitbucket.org/cistrome/cistrome-applications-harvard/overview
metadata:
  docker_image: "quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1"
---

# cistrome-ceas

## Overview
The `cistrome-ceas` skill enables the automated annotation of ChIP-seq or ChIP-chip peaks. It provides a high-level statistical summary of where binding events occur relative to gene structures and conserved elements. This is essential for determining if a protein of interest preferentially binds to specific genomic regions like enhancers or proximal promoters, and for visualizing the average binding signal intensity across gene bodies.

## Usage Guidelines

### Core Command Pattern
The primary executable is typically `ceas`. The basic syntax requires a BED file of peaks and a gene annotation file (SQLite format).

```bash
ceas -b [peaks.bed] -g [gene_annotation.sqlite] [options]
```

### Essential Inputs
- **Peak File (-b)**: A standard BED file containing the genomic coordinates of the binding sites.
- **Gene Annotation (-g)**: A pre-built SQLite database containing gene models (e.g., RefSeq, Ensembl).
- **Signal File (-w)**: (Optional but recommended) A WIG or BigWig file containing the enrichment signal to generate average profiling plots.

### Common Analysis Workflows

#### 1. Basic Annotation
To get a distribution of peaks across genomic features (promoters, downstream, introns, exons, intergenic):
```bash
ceas -b peaks.bed -g hg38.sqlite --name my_analysis
```

#### 2. Profiling with Signal Data
To generate average profiles of ChIP-seq signal around TSS and across gene bodies:
```bash
ceas -b peaks.bed -g hg38.sqlite -w signal.wig --name my_profile
```

### Expert Tips
- **Annotation Databases**: Ensure the SQLite database version matches the genome assembly (e.g., hg19, hg38, mm10) used for peak calling.
- **Promoter Definition**: Use the `--promoter` and `--downstream` flags to adjust the window size (default is usually 3000bp) for defining proximal regulatory regions.
- **Output Interpretation**: The tool produces a PDF report containing pie charts for genomic distribution and line plots for average profiling. Review the `.xls` files for the raw percentages and enrichment scores.
- **Memory Management**: For very large WIG files, ensure sufficient RAM is available, or consider downsampling the signal if only a general profile is needed.

## Reference documentation
- [Cistrome-CEAS Overview](./references/anaconda_org_channels_bioconda_packages_cistrome-ceas_overview.md)