---
name: safesim
description: SafeSim is a UMI-aware toolkit designed to create realistic synthetic datasets for the Safe-Sequencing System by simulating mutations and mixing BAM files. Use when user asks to insert specific mutations from a VCF into a BAM file, simulate low-frequency variants with allele-fraction overdispersion, or merge two BAM files at specific ratios to simulate varying tumor burdens.
homepage: https://github.com/genetronhealth/safesim
---

# safesim

## Overview
SafeSim is a specialized toolkit designed for the Safe-Sequencing System (Safe-SeqS). It provides two primary utilities, `SafeMut` and `SafeMix`, which allow researchers to create realistic synthetic datasets. Unlike standard simulators, SafeSim is "UMI-aware," meaning it correctly handles molecular barcodes attached to read names, ensuring that simulated mutations are consistent across all reads sharing the same UMI. This is particularly critical for liquid biopsy (cfDNA) bioinformatics validation where low-frequency variant detection is the goal.

## Tool Selection
- **SafeMut**: Use this to insert specific mutations from a VCF file into an existing "clean" BAM file. It is the preferred tool for most validations as it incorporates allele-fraction overdispersion for more realistic data.
- **SafeMix**: Use this to merge two different BAM files at specific ratios to simulate varying tumor burdens. Note that SafeMix performance can be sensitive to the initial DNA quantity/depth of the input files.

## Input Requirements
To ensure the tools function correctly, your input data must meet these specific formatting standards:

### UMI Formatting
Read names (QNAME) in your BAM files must include the UMI suffix using the `#` delimiter:
- **Single-strand barcode**: `ReadName#ACGTAACCA`
- **Duplex barcode**: `ReadName#AGTA+TGGT`

### VCF Requirements (for SafeMut)
The input VCF must explicitly define the Allele Fraction (AF) in the header for the simulation to apply specific frequencies:
- Ensure `##INFO=<ID=FA,Number=A,Type=Float,Description="Allele fraction">` is present.
- If `INFO/FA` is missing, the tool will revert to default allele fraction values.

## Common CLI Patterns

### Spiking Variants with SafeMut
```bash
bin/safemut -i input.bam -v variants.vcf -r reference.fa -o output.bam
```
*Tip: Always verify that your input BAM does not already contain the variants specified in the VCF to avoid confounding results.*

### Mixing Samples with SafeMix
```bash
bin/safemix -1 sample1.bam -2 sample2.bam -f 0.01 -o mixed_output.bam
```
*Note: The `-f` parameter typically defines the mixing fraction.*

## Expert Tips
- **AF Overdispersion**: SafeMut's ability to simulate overdispersion makes it superior to simple read-editing scripts for validating clinical pipelines, as it better mimics the stochastic nature of NGS library preparation.
- **Library Dependencies**: If you encounter "error while loading shared libraries" during execution, ensure `htslib` and `bcftools` (v1.6+) are in your `LD_LIBRARY_PATH` or were compiled with the `--disable-plugins` flag as recommended in the documentation.
- **Unmapped Reads**: SafeSim versions 0.1.5+ include fixes for unmapped reads; ensure you are using the latest build if your workflow involves processing unaligned data.



## Subcommands

| Command | Description |
|---------|-------------|
| safemix | This program mixes two bam files and is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs)) |
| safemut | This is a NGS variant simulator that is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs)) |

## Reference documentation
- [SafeSeqS variant simulator overview](./references/github_com_genetronhealth_safesim.md)
- [SafeSim Wiki and Evaluation Details](./references/github_com_genetronhealth_safesim_wiki.md)