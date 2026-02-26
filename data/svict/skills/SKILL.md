---
name: svict
description: SViCT detects structural variations and gene fusions from targeted sequencing data, specifically for liquid biopsy analysis. Use when user asks to detect structural variants in circulating tumor DNA, identify gene fusions, or analyze cfDNA sequencing data.
homepage: https://github.com/vpc-ccg/svict
---


# svict

## Overview

SViCT (Structural Variant detection in Circulating Tumor DNA) is a specialized computational tool designed for liquid biopsy analysis. It identifies structural variations and gene fusions from targeted sequencing data. While standard SV callers often struggle with the low signal-to-noise ratio found in cfDNA samples, SViCT is optimized to detect variants even when the circulating tumor DNA is highly diluted.

## Installation

The most efficient way to install SViCT is via Bioconda:

```bash
conda install -c bioconda svict
```

Alternatively, you can build from source if you have g++ 4.9 or higher:

```bash
git clone https://github.com/vpc-ccg/svict.git
cd svict
make
```

## Basic Usage

SViCT requires a coordinate-sorted BAM or SAM file and the corresponding reference genome in FASTA format.

```bash
svict -i input.sorted.bam -r reference.fa -o output_prefix
```

### Parameters
- `-i`: Path to the input coordinate-sorted BAM/SAM file.
- `-r`: Path to the reference genome FASTA file.
- `-o`: Prefix for the output files (e.g., `-o results` will produce `results.vcf`).
- `-h`: Display the help message and all available parameters.

## Best Practices and Expert Tips

1. **Input Preparation**: Ensure your BAM file is coordinate-sorted and indexed. SViCT relies on the spatial arrangement of reads to identify clusters of discordant pairs and split reads.
2. **Reference Matching**: Always use the exact same reference FASTA file that was used for the initial alignment of the BAM file to avoid coordinate mismatches.
3. **Targeted Sequencing**: SViCT is specifically tuned for targeted sequencing (e.g., gene panels). Using it on Whole Genome Sequencing (WGS) data may require significant computational resources or may not be as performant as tools designed for WGS.
4. **Output Interpretation**: The primary output is a VCF file. Pay close attention to the evidence tags in the VCF to understand the support (split reads vs. discordant pairs) for each predicted variant.
5. **Low Dilution Handling**: If you are working with samples known to have extremely low ctDNA fractions, ensure your sequencing depth is sufficient for SViCT to find enough supporting reads for a call.

## Reference documentation

- [svict - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_svict_overview.md)
- [vpc-ccg/svict: Structural Variation and fusion detection](./references/github_com_vpc-ccg_svict.md)