---
name: macs3
description: MACS3 identifies protein-bound regions and open chromatin areas from high-throughput sequencing data such as ChIP-seq and ATAC-seq. Use when user asks to call narrow or broad peaks, process ATAC-seq data, compare differential peaks, or generate signal tracks.
homepage: https://pypi.org/project/MACS3/
---


# macs3

## Overview
MACS3 is the latest iteration of the Model-based Analysis of ChIP-Seq algorithm, designed to identify protein-bound regions or open chromatin areas from high-throughput sequencing data. It improves upon previous versions by offering better support for ATAC-seq, HMM-based peak calling, and improved handling of broad peaks. This skill focuses on the command-line execution of its core modules to process BAM or BED files into statistically significant peaks.

## Core Command Patterns

### Regular Peak Calling (Narrow Peaks)
For standard transcription factor ChIP-seq where binding sites are discrete:
```bash
macs3 callpeak -t treatment.bam -c control.bam -f BAM -g hs -n experiment_name -q 0.01
```
- `-g`: Genome size (e.g., `hs` for human, `mm` for mouse, `ce` for C. elegans, `dm` for fruit fly).
- `-q`: Minimum FDR threshold for peak detection.

### Broad Peak Calling
For histone modifications (e.g., H3K36me3) that cover wider genomic regions:
```bash
macs3 callpeak -t treatment.bam -c control.bam --broad -g hs --broad-cutoff 0.1
```

### ATAC-seq Peak Calling
When processing ATAC-seq, use the `--shift` and `--extsize` parameters to account for the Tn5 transposase insertion site:
```bash
macs3 callpeak -t atac.bam -f BAMPE -g hs -n atac_peaks -q 0.01 --nomodel --shift -100 --extsize 200
```
*Note: Using `-f BAMPE` (paired-end) is recommended for ATAC-seq to allow MACS3 to use the actual insertion lengths.*

## Expert Tips & Best Practices

- **Format Selection**: While MACS3 auto-detects formats, explicitly setting `-f BAMPE` for paired-end data allows the tool to use the actual fragment lengths rather than estimating them via the "shifting model."
- **Effective Genome Size**: If working with a non-standard organism, provide the actual number of mappable bases to the `-g` parameter instead of a shorthand code.
- **Duplicate Filter**: By default, MACS3 keeps one read per genomic position (`--keep-dup 1`). For high-depth experiments or specialized libraries, consider `--keep-dup all` if you have already performed sophisticated deduplication.
- **Fold Enrichment**: Use the `bdgcmp` module to generate fold-enrichment or p-value tracks (BedGraph) for visualization in IGV or UCSC Genome Browser.

## Common Subcommands
- `callpeak`: Main function for peak calling.
- `bdgcmp`: Deduct noise from treatment signals using control lambda.
- `bdgdiff`: Differential peak calling for score-based comparisons between two conditions.
- `hmmratac`: Dedicated module for ATAC-seq peak calling using Hidden Markov Models.

## Reference documentation
- [MACS3 Project Overview](./references/pypi_org_project_MACS3.md)
- [Bioconda MACS3 Distribution](./references/anaconda_org_channels_bioconda_packages_macs3_overview.md)