---
name: lusstr
description: lusstr is a specialized forensic bioinformatics tool that bridges the gap between raw NGS sequence strings and the structured allele designations required for downstream analysis.
homepage: https://www.github.com/bioforensics/lusSTR
---

# lusstr

## Overview
lusstr is a specialized forensic bioinformatics tool that bridges the gap between raw NGS sequence strings and the structured allele designations required for downstream analysis. It automates the conversion of sequence data into multiple annotation styles and applies forensic-specific filters (such as stutter identification) to generate input files for major probabilistic genotyping platforms. It is essential for forensic analysts working with ForenSeq (Signature Prep or Kintelligence) and PowerSeq panels who need to standardize sequence representations or prepare evidence/reference profiles.

## Command Line Usage

### Initialization and Configuration
Before running workflows, generate a configuration file to define your environment and analysis parameters.
```bash
# Create default config in current directory
lusstr config

# Create config in a specific working directory
lusstr config -w /path/to/workdir/
```

### STR Analysis Workflow
The STR pipeline handles formatting, sequence conversion, and filtering for autosomal and sex-chromosome loci.
```bash
# Run the full STR workflow
lusstr strs

# Common flags for 'lusstr config' to customize the STR workflow:
# --input <path>      Path to UAS reports, STRait Razor files, or GeneMarker CSVs
# --powerseq          Use if processing Promega PowerSeq data (default is ForenSeq)
# --sex               Include X and Y chromosome STRs
# --software <type>   Target output: strmix, efm, or mpsproto
# --str-type <type>   Data representation: ngs, ce, or lusplus
# --reference         Generate reference profiles instead of evidence profiles
```

### SNP Analysis Workflow
For processing identity, phenotype, or ancestry SNPs (including Kintelligence panel data).
```bash
# Run the SNP analysis workflow
lusstr snps
```

### Graphical Interface
For interactive plotting and manual sequence type editing.
```bash
lusstr gui
```

## Expert Tips and Best Practices
- **Input Compatibility**: If using **STRait Razor v3**, ensure you use the specific configuration versions required by lusstr (ForenSeq v1.27 or PowerSeq v2.31) to ensure sequence regions align correctly with UAS standards.
- **Output for STRmix**: When preparing data for STRmix NGS, use the `--strand` flag to specify whether sequences should be reported in `uas` or `forward` orientation.
- **Batch Processing**: Point the `samp_input` in your config to a directory rather than a single file to process multiple samples in a single Snakemake execution.
- **Filtering**: Use the `--nofilters` flag if you need to generate output files for genotyping software but want to bypass lusstr's internal stutter and threshold filtering logic.
- **Custom Ranges**: If your lab uses non-standard sequence boundaries, set `custom: True` in the config and modify the `str_markers.json` file to define specific sequence ranges.

## Reference documentation
- [lusSTR GitHub Repository](./references/github_com_bioforensics_lusSTR.md)