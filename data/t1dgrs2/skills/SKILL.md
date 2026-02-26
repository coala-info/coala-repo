---
name: t1dgrs2
description: The t1dgrs2 tool calculates Type 1 Diabetes Genetic Risk Scores by integrating non-HLA variants and HLA haplotype interactions from genomic data. Use when user asks to generate genetic risk scores for Type 1 Diabetes, discriminate between diabetes types, or analyze HLA and non-HLA risk components in PLINK datasets.
homepage: https://github.com/t2diabetesgenes/t1dgrs2
---


# t1dgrs2

## Overview
The `t1dgrs2` tool is a specialized Python-based utility for generating Type 1 Diabetes Genetic Risk Scores. Unlike standard linear scoring methods, it incorporates both non-HLA and HLA risk components, specifically accounting for the interaction effects between HLA DR-DQ haplotype combinations. It utilizes 67 T1D-associated variants and supports both GRCh37 and GRCh38 genome builds. This tool is essential for researchers looking to discriminate between T1D cases and controls or to distinguish T1D from other forms of diabetes (like Type 2 or Monogenic diabetes) in clinical and research datasets.

## Installation and Environment
The tool is distributed via Bioconda. It is highly recommended to use a dedicated Conda environment to prevent dependency conflicts.

```bash
# Create and activate environment
conda create -n t1d_env python
conda activate t1d_env

# Install t1dgrs2
conda install -c bioconda t1dgrs2
```

## Command Line Usage
The tool is executed as a Python module. It requires three primary inputs: a PLINK fileset, a configuration file, and an output prefix.

### Basic Command
```bash
python -m t1dgrs2 -b /path/to/input_prefix -c /path/to/t1dgrs2_settings.yml -o /path/to/output_prefix
```

### Arguments
- `-b, --bfile`: Path and prefix for PLINK 1.9 files (must have `.bed`, `.bim`, and `.fam` extensions).
- `-c, --config`: Path to the `t1dgrs2_settings.yml` configuration file.
- `-o, --output`: Path and prefix for the generated output files.

## Best Practices and Expert Tips
- **Quality Control**: Input datasets (imputed genotyping arrays or NGS data) must undergo standard genomic quality control procedures before running `t1dgrs2`. The tool does not perform internal QC.
- **Configuration Setup**: You must download the necessary configuration and data files from the official repository. Ensure that the internal paths within your `t1dgrs2_settings.yml` correctly point to the local directory where you stored the reference data.
- **Genome Build Consistency**: Ensure your PLINK files match the genome build (GRCh37 or GRCh38) specified in your configuration.
- **Monitoring Progress**: The tool generates a `t1dgrs2.log` file in the current working directory. Monitor this file in real-time to track execution progress or troubleshoot errors.
- **Output Handling**: If the `-o` argument is omitted, the tool defaults to creating files named `output_FILE1`, `output_FILE2`, etc., in the current directory. Always specify a prefix to avoid overwriting previous runs.

## Reference documentation
- [t1dgrs2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_t1dgrs2_overview.md)
- [t1dgrs2 GitHub Repository](./references/github_com_t2diabetesgenes_t1dgrs2.md)