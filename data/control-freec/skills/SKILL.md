---
name: control-freec
description: Control-FREEC identifies copy number variations and genotype annotations in deep-sequencing data through automated normalization, segmentation, and calling. Use when user asks to detect genomic gains and losses, perform loss of heterozygosity analysis, or identify subclonal alterations in whole genome or exome sequencing data.
homepage: https://github.com/BoevaLab/FREEC
---


# control-freec

## Overview

Control-FREEC (Control-Free Calling) is a command-line tool designed to identify copy number variations and genotype annotations in deep-sequencing data. It automatically performs normalization, segmentation, and calling of genomic gains and losses. While it can analyze single tumor samples for WGS by using GC-content and mappability data, a matched normal control is mandatory for WES or targeted sequencing to account for capture biases.

## Command Line Usage

The primary way to interact with the tool is through the `freec` executable using a configuration file.

### Basic Execution
```bash
# Run using a predefined configuration file
freec -conf myConfig.txt

# Run while overriding sample and control files via CLI
freec -conf myConfig.txt -sample tumor.bam -control normal.bam
```

### Input Formats
Control-FREEC supports several alignment formats:
- **BAM/SAM**: Standard alignment files (recommended).
- **SAMtools pileup**: Required for combined CNA and LOH detection.
- **GZipped files**: The tool can process compressed versions of the above formats directly.

## Configuration Best Practices

The configuration file is a plain text file organized into sections. Below are the critical parameters for effective runs:

### General Settings
- **chrLenFile**: Path to a file containing chromosome names and lengths.
- **ploidy**: Set the expected average ploidy of the sample (default is 2).
- **window**: Size of the window for copy number evaluation. For WGS, this is often calculated automatically; for WES, it should match the target regions.
- **step**: The distance between the start of two adjacent windows.

### Sample and Control
- **mateFile**: Path to the alignment file.
- **inputFormat**: Specify `BAM`, `SAM`, or `pileup`.
- **mateOrientation**: Use `0` for single-end, `FR` for paired-end, or `RF` for mate-pair.

### LOH Detection
To detect Allelic Imbalances/LOH alongside CNAs:
- Set `makePileup = 1` in the config.
- Provide a `fastaFile` (reference genome).
- Provide a `SNPfile` (e.g., dbSNP) to focus on known polymorphic sites.

## Expert Tips

1. **WES Requirements**: Never attempt WES analysis without a matched control. The non-uniformity of exome capture makes "control-free" calling highly inaccurate for exome data.
2. **Mappability Tracks**: For WGS without a control, provide mappability files (created by GEM) to the `gemMappabilityFile` parameter. This significantly reduces false positives in repetitive regions.
3. **Subclonal Analysis**: Starting from version 8.0, the tool can evaluate the level of normal cell contamination and detect subclonal alterations. Ensure your `ploidy` and `maxIter` settings are tuned if you suspect high heterogeneity.
4. **Visualization**: Use the provided R scripts (e.g., `makeGraph2.0.R`) found in the tool's `scripts/` directory to generate ratio and BAF plots from the output files.

## Reference documentation
- [Control-FREEC GitHub Repository](./references/github_com_BoevaLab_FREEC.md)
- [Control-FREEC Wiki and Manual](./references/github_com_BoevaLab_FREEC_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_control-freec_overview.md)