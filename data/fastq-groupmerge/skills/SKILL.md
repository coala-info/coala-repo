---
name: fastq-groupmerge
description: "fastq-groupmerge automates the concatenation of raw sequencing reads into groups based on a metadata table. Use when user asks to merge FASTQ files by sample groups, concatenate sequencing reads using a metadata file, or combine multiple sequencing runs into single files."
homepage: https://github.com/SantaMcCloud/fastq-groupmerge
---


# fastq-groupmerge

## Overview

`fastq-groupmerge` is a bioinformatics utility designed to automate the concatenation of raw sequencing reads based on user-defined groups. Rather than manually running `cat` commands on dozens of files, this tool uses a metadata table to identify which samples belong together. It supports paired-end and single-end data, handles gzipped inputs/outputs to save space, and allows for flexible file naming through configurable suffixes.

## Installation

Install the tool via Bioconda:

```bash
conda install bioconda::fastq-groupmerge
```

## Metadata Configuration

The metadata file is the core of the workflow. It must be a delimited text file (CSV by default) that follows these rules:
- **Required Column**: Must contain a column named `sample_id` matching the prefix of your FASTQ files.
- **Grouping Column**: A column (e.g., `treatment`, `condition`, or `patient_id`) used to define the merge targets.
- **Many-to-Many Mapping**: A single `sample_id` can appear in multiple rows if it needs to be included in multiple merged groups.

**Example `metadata.csv`:**
```csv
sample_id,group
A1,control
A2,control
B1,treatment
B2,treatment
A1,experimental_subset
```

## Common CLI Patterns

### Basic Grouped Merge
Merge paired-end reads into groups defined in a "condition" column:
```bash
fastq-groupmerge \
  --metadata metadata.csv \
  --group_col condition \
  --forward_suffix _R1.fastq.gz \
  --reverse_suffix _R2.fastq.gz \
  --output_dir ./merged_results
```

### Handling Custom Delimiters
If using a Tab-Separated Values (TSV) file:
```bash
fastq-groupmerge --metadata metadata.tsv --sep '\t' --group_col group [OTHER_ARGS]
```

### Global Merge (No Metadata)
If no metadata file is provided, the tool will merge every FASTQ file found in the input directory into a single forward and single reverse file:
```bash
fastq-groupmerge --forward_suffix _1.fq.gz --reverse_suffix _2.fq.gz --output_dir ./all_merged
```

## Expert Tips and Best Practices

- **Suffix Precision**: Ensure `--forward_suffix` and `--reverse_suffix` exactly match the end of your filenames (including `.gz` if applicable). The tool uses these strings to distinguish between R1 and R2 files.
- **Output Naming**: The output files are automatically named using the pattern `{group_name}{suffix}`. Ensure your group names in the metadata file do not contain characters that are invalid for filenames.
- **Memory Efficiency**: The tool outputs gzipped files by default. When working with very large datasets, ensure the `--output_dir` is on a filesystem with sufficient space for the aggregated data.
- **Pandas Compatibility**: The `--sep` flag accepts any separator string compatible with the `pandas.read_csv` engine.

## Reference documentation
- [Main README and Usage](./references/github_com_SantaMcCloud_fastq-groupmerge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastq-groupmerge_overview.md)