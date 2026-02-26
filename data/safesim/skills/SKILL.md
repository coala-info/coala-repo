---
name: safesim
description: SafeSim simulates variants in UMI-based sequencing data by spiking specific mutations into BAM files or blending different samples. Use when user asks to spike variants into a background BAM file, blend two BAM files to simulate variant fractions, or simulate data for UMI-based protocols like Safe-SeqS.
homepage: https://github.com/genetronhealth/safesim
---


# safesim

## Overview
SafeSim is a specialized toolkit for simulating variants in sequencing data that utilizes Safe-Sequencing System (Safe-SeqS) or similar UMI-based protocols. It consists of two primary tools: **SafeMut** for spiking specific variants into a background BAM file, and **SafeMix** for blending two different BAM files. Unlike general-purpose simulators, SafeSim is designed to handle molecular barcodes (UMIs) within the read names, ensuring that all reads belonging to the same original molecule are treated consistently during the simulation process. This makes it an essential tool for validating liquid biopsy pipelines and low-frequency variant detection algorithms.

## Tool-Specific Best Practices

### 1. Input BAM Preparation (QNAME Format)
For SafeSim to correctly identify and process UMIs, the read names (QNAME) in your input BAM files must follow a specific format: `originalName#UMI`.
- **Single-strand barcode example**: `H5G5ABBCC:4:1209:10114:63736#ACGTAACCA`
- **Duplex barcode example**: `H5G5ABBCC:1:3010:10412:33669#AGTA+TGGT`
If your BAM files do not follow this naming convention, you must rename the reads before using SafeMut or SafeMix.

### 2. SafeMut: Spiking Variants
SafeMut modifies read sequences in a UMI-aware manner to introduce variants specified in a VCF file.
- **VCF Requirements**: Ensure that `INFO/FA` (Allele Fraction) is defined in your VCF header. If it is missing, the tool will fall back to default allele fraction values.
- **Overdispersion**: SafeMut incorporates allele-fraction overdispersion, providing a more realistic simulation of biological and technical variance compared to simple linear mixing.
- **Usage Pattern**:
  ```bash
  safemut -i input.bam -v variants.vcf -o output.bam [options]
  ```

### 3. SafeMix: Blending Samples
SafeMix is used to combine two BAM files (e.g., a tumor sample and a normal sample) to simulate specific variant fractions.
- **DNA Quantity Balance**: Be aware that SafeMix performance depends on the initial DNA quantities in the input files. If the two BAM files have significantly different coverage or DNA concentrations, the resulting fractions may be skewed.
- **Usage Pattern**:
  ```bash
  safemix -1 sample1.bam -2 sample2.bam -o mixed.bam [options]
  ```

### 4. Performance and Environment
- **Dependencies**: Ensure `htslib` (1.6+) and `bcftools` (1.6+) are installed and available in your PATH.
- **Help Commands**: Use the `-h` flag for the most up-to-date parameter descriptions:
  ```bash
  safemut -h
  safemix -h
  ```

## Expert Tips
- **SafeMut vs. SafeMix**: Prefer **SafeMut** for clinical simulation tasks where tumor burden or copy-number alterations are unknown, as it is less sensitive to DNA-quantity imbalances between samples than SafeMix.
- **Validation**: When testing new pipelines, use the evaluation scripts provided by the developers at the `safesim-eval` repository to benchmark your results against known truths.
- **Troubleshooting**: If you encounter "error while loading shared libraries," ensure your `LD_LIBRARY_PATH` includes the location of your `htslib` installation.

## Reference documentation
- [SafeSim GitHub Repository](./references/github_com_genetronhealth_safesim.md)
- [SafeSim Wiki](./references/github_com_genetronhealth_safesim_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_safesim_overview.md)