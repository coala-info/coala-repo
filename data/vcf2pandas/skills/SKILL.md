---
name: vcf2pandas
description: vcf2pandas converts genomic variant data from VCF files into pandas DataFrames. Use when user asks to convert VCF files to pandas, load genomic variant data, parse VCF structures, filter VCF data, select or rename VCF fields, or remove empty columns from VCF data.
homepage: https://github.com/trentzz/vcf2pandas
---


# vcf2pandas

## Overview
vcf2pandas is a Python library designed to simplify the process of loading genomic variant data into the pandas ecosystem. Instead of manually parsing complex VCF structures, this tool handles header extraction and field mapping automatically. It allows for granular control over which variants, samples, and metadata fields are included in the resulting DataFrame, making it an essential utility for bioinformatics pipelines that require tabular data for statistical analysis or machine learning.

## Installation
Install the package via pip or conda:
```bash
pip install vcf2pandas
# OR
conda install bioconda::vcf2pandas
```

## Core Usage Patterns

### Basic Conversion
To convert an entire VCF file with default settings:
```python
import vcf2pandas
df = vcf2pandas("path_to_file.vcf")
```

### Filtering and Renaming Fields
You can pass lists to select specific fields, or dictionaries to select and rename them simultaneously.
```python
# Selection using lists (maintains order)
info_fields = ["DP", "MQ"]
format_fields = ["GT", "AD"]
sample_list = ["Sample_A", "Sample_B"]

# Renaming using dictionaries
info_mapping = {"DP": "Depth", "MQ": "MappingQuality"}

df = vcf2pandas(
    "input.vcf", 
    info_fields=info_mapping, 
    sample_list=sample_list, 
    format_fields=format_fields
)
```

### Handling Sparse Data
VCF files often contain fields defined in the header that are never actually populated. Use `remove_empty_columns` to keep the DataFrame lean.
```python
df = vcf2pandas("input.vcf", remove_empty_columns=True)
```

## Expert Tips & Best Practices
- **Column Naming Convention**: Be aware that vcf2pandas prefixes column names to prevent collisions. INFO fields are prefixed with `INFO:` (e.g., `INFO:DP`) and FORMAT fields follow the pattern `FORMAT:SAMPLE_NAME:FIELD_NAME` (e.g., `FORMAT:HG002:GT`).
- **Missing Values**: The tool represents missing data with a `.` string. If you require numerical analysis, perform a post-conversion replacement: `df.replace('.', np.nan)`.
- **Memory Management**: For very large VCFs, use the `info_fields` and `sample_list` parameters to subset the data during extraction rather than loading the full file and dropping columns later.
- **Mixing Inputs**: You can mix and match lists and dictionaries for different parameters (e.g., a list for `sample_list` but a dictionary for `info_fields`).

## Reference documentation
- [vcf2pandas GitHub Repository](./references/github_com_trentzz_vcf2pandas.md)
- [vcf2pandas Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2pandas_overview.md)