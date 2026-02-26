---
name: debreak
description: DeBreak is a structural variant caller designed to detect and refine complex genomic rearrangements in long-read sequencing data using local assembly and partial order alignment. Use when user asks to call structural variants, perform high-accuracy breakpoint refinement, or identify large insertions and duplications in germline or cancer samples.
homepage: https://github.com/ChongLab/DeBreak
---


# debreak

## Overview
DeBreak is a structural variant caller optimized for the unique characteristics of long-read sequencing data. It moves beyond simple alignment-based detection by incorporating partial order alignment (POA) and local de novo assembly to resolve complex genomic rearrangements. This skill provides the necessary command-line patterns to execute SV discovery workflows ranging from rapid preliminary scans to high-accuracy breakpoint refinement in germline or cancer samples.

## Installation and Environment
The most reliable way to deploy DeBreak is via Conda to manage its dependencies (pysam, minimap2, wtdbg2, and bsalign).

```bash
conda create --name deb
conda activate deb
conda install -c bioconda debreak
```

## Common CLI Patterns

### 1. Basic SV Calling
Use this for a rapid overview of SVs. Note that this mode may miss large insertions and will not provide base-pair precise breakpoints.
```bash
debreak --bam input.sorted.bam --outpath ./debreak_results/
```

### 2. High-Accuracy SV Discovery
This is the recommended "full function" mode. It requires a reference genome and enables breakpoint refinement and specialized rescue modules.
```bash
debreak --bam input.sorted.bam \
        --ref reference.fa \
        --outpath ./debreak_refined/ \
        --poa \
        --rescue_large_ins \
        --rescue_dup
```

### 3. Cancer or Complex Genome Analysis
When working with highly rearranged genomes or subclonal populations, use the `--tumor` flag to allow for clustered breakpoints during the initial signal detection phase.
```bash
debreak --bam tumor.sorted.bam \
        --ref reference.fa \
        --outpath ./tumor_results/ \
        --tumor \
        --poa \
        --rescue_large_ins
```

## Parameter Tuning and Best Practices

### Support Thresholds (`--min_support`)
The `--min_support` parameter is the most critical filter for reducing false positives. If not specified, DeBreak estimates depth to set this automatically, but manual tuning is often superior:

| Sequencing Depth | Suggested `--min_support` |
| :--- | :--- |
| 10x | 3 |
| 30x | 5 |
| 60x | 8 |
| 80x+ | 10 |

Alternatively, provide the depth explicitly to let the tool calculate the threshold:
```bash
debreak --bam input.bam --depth 50 --outpath ./output/
```

### Advanced Modules
- **`--poa`**: Performs Partial Order Alignment using `wtdbg2` to generate a consensus sequence for each SV candidate, resulting in precise breakpoint coordinates in the VCF.
- **`--rescue_large_ins`**: Uses local de novo assembly to identify insertions longer than the actual sequencing reads.
- **`--rescue_dup`**: Re-aligns inserted sequences to the local genomic neighborhood to determine if an "insertion" is actually a duplication event.

### Preprocessing Requirements
DeBreak requires a coordinate-sorted BAM file with a valid index (.bai). If starting from raw FASTQ:
```bash
minimap2 -a reference.fa reads.fastq | samtools sort -o aligned.sort.bam
samtools index aligned.sort.bam
```

## Reference documentation
- [DeBreak GitHub README](./references/github_com_ChongLab_DeBreak_blob_master_README.md)
- [Bioconda DeBreak Overview](./references/anaconda_org_channels_bioconda_packages_debreak_overview.md)