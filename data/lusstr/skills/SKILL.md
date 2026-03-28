---
name: lusstr
description: lusSTR converts raw forensic NGS sequence data into standardized allele designations and filtered outputs for human identification. Use when user asks to process STR or SNP data, generate configuration files for forensic panels, or format genetic data for probabilistic genotyping software.
homepage: https://www.github.com/bioforensics/lusSTR
---


# lusstr

## Overview
lusSTR is a specialized forensic bioinformatics tool designed to bridge the gap between raw NGS sequence data and downstream forensic genetic analysis. It automates the conversion of complex sequence strings into standardized representations and designations used in human identification. Beyond conversion, it provides essential filtering and stutter identification capabilities, specifically tailored for major forensic panels including Verogen ForenSeq (Signature Prep and Kintelligence) and Promega PowerSeq.

## Core Workflows

### 1. Initialization and Configuration
Before running an analysis, generate a configuration file to define your environment and parameters.
- **Generate default config**: `lusstr config`
- **Key parameters to verify in the config**:
    - `analysis_software`: Set to `uas`, `straitrazor`, or `genemarker`.
    - `samp_input`: Path to your input directory or specific files.
    - `kit`: Specify `forenseq` (default) or `powerseq`.

### 2. STR Analysis Pipeline
Process STR loci to generate allele designations and filtered outputs.
- **Standard run**: `lusstr strs`
- **Include sex chromosomes**: `lusstr strs --sex`
- **PowerSeq specific run**: `lusstr strs --powerseq`
- **Custom sequence ranges**: Use the `--custom` flag if you have modified `str_markers.json`.

### 3. SNP Data Processing
Process identity, ancestry, or phenotype SNPs for use in software like EuroForMix (EFM).
- **Standard run**: `lusstr snps`
- **Reference file creation**: Use the `--reference` flag when processing known reference samples rather than evidence.

### 4. Probabilistic Genotyping Preparation
lusSTR can format data specifically for different software packages using the `--software` flag:
- **STRmix**: `lusstr strs --software strmix`
- **EuroForMix**: `lusstr strs --software efm`
- **MPSproto**: `lusstr strs --software mpsproto`

## Input Format Requirements
Ensure your input data matches one of the supported formats:
- **UAS**: .xlsx files (Sample Details, Sample Report, or Phenotype Report).
- **STRait Razor v3**: Individual sample files (ensure config versions `ForenSeqv1.27` or `PowerSeqv2.31` were used).
- **GeneMarker v2.6**: `*_strresults_filtered.csv` files.
- **Custom CSV**: Must contain columns: `Locus`, `NumReads`, `Sequence`, `SampleID`.

## Expert Tips
- **GUI Mode**: If you need to interactively view marker plots or manually edit sequence types, launch the interface with `lusstr gui`.
- **Stutter Identification**: lusSTR can identify stutter using CE alleles, LUS+ alleles, or bracketed forms. Specify your preference using the `--str-type` flag (options: `ce`, `ngs`, `lusplus`).
- **Combining Sequences**: When using STRait Razor data, identical sequences are combined by default. Use `--nocombine` if you need to maintain sequence separation for specific research purposes.



## Subcommands

| Command | Description |
|---------|-------------|
| lusstr config | Create config file for running STR pipeline |
| lusstr snps | Running the SNP pipeline |
| lusstr_strs | Running the STR pipeline |

## Reference documentation
- [lusSTR README](./references/github_com_bioforensics_lusSTR_blob_master_README.md)
- [lusSTR Overview](./references/anaconda_org_channels_bioconda_packages_lusstr_overview.md)