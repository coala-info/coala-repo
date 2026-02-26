---
name: gci
description: The Genome Continuity Inspector validates genome assembly quality by analyzing long-read alignments to identify errors and calculate continuity scores. Use when user asks to validate a genome assembly, identify assembly issues, calculate a continuity score, or plot depth distributions for specific genomic regions.
homepage: https://github.com/yeeus/GCI
---


# gci

## Overview

The Genome Continuity Inspector (GCI) is a specialized tool designed to validate high-quality genome assemblies. Unlike standard assembly metrics that rely on contig lengths, GCI performs a deep analysis of long-read alignments mapped back to the assembly. By applying stringent filters to these alignments, it identifies regions with insufficient or suspicious support, flags potential assembly issues, and generates a continuity score. It is an essential tool for researchers aiming for "finished" or T2T-level genome quality.

## Core CLI Usage

The primary interface is the `GCI.py` script. It requires a reference genome and at least one BAM file of long-read alignments.

### Basic Execution
```bash
python GCI.py -r reference.fasta --hifi hifi_alignments.bam --nano ont_alignments.bam -o output_prefix
```

### Targeted Analysis
To focus on specific chromosomes or genomic regions:
```bash
# Analyze specific chromosomes
python GCI.py -r ref.fa --hifi hifi.bam --chrs chr1,chr2,chr3

# Analyze regions defined in a BED file
python GCI.py -r ref.fa --hifi hifi.bam -R regions.bed
```

### Visualization
Enable the plotting flag to generate depth distribution images across the genome or specific regions:
```bash
python GCI.py -r ref.fa --hifi hifi.bam -p --image-type pdf --window-size 50000
```

## Workflow Best Practices

### 1. Alignment Preparation
GCI is sensitive to alignment quality. For T2T genomes, use mappers that handle repetitive regions well, such as `winnowmap` or `veritymap`.
*   **BAM Requirements**: BAM files must be sorted and indexed (`samtools index`).
*   **PAF Recommendation**: While GCI requires at least one BAM file, providing a corresponding PAF file is recommended for comprehensive filtering.
*   **PAF Sorting**: GCI requires PAF files to be sorted by target name and position:
    ```bash
    sort -k6,6V -k8,8n input.paf > sorted.paf
    ```

### 2. Haplotype-Resolved Assemblies
When working with phased assemblies (Hap1/Hap2):
*   Perform trio-binning on reads first (using `canu` or `seqkit`).
*   Map binned reads only to their respective haplotype assembly to avoid cross-mapping artifacts that lower the continuity score.

### 3. Parameter Tuning
*   **Mapping Quality (`-mq`)**: Default is 30. Increase this for HiFi reads to ensure only unique, high-confidence mappings are used.
*   **Identity Percent (`-ip`)**: Default is 0.9. For high-accuracy HiFi reads, consider increasing this to 0.95 or 0.99.
*   **Clipped Bases (`-cp`)**: GCI filters reads with excessive clipping (default 10%). If your library has many chimeric reads, you may need to adjust this.

## Utility Scripts

GCI includes several helper scripts in the `utility/` directory:
*   `filter_bam.py`: Used for custom filtering of BAM files based on GCI's logic.
*   `plot_depth.py`: A fast, low-memory script for plotting regional depth from GCI output files.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_yeeus_GCI.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_gci_overview.md)