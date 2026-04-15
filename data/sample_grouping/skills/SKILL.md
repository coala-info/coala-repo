---
name: sample_grouping
description: The sample_grouping tool concatenates sequencing reads from multiple FASTQ files into single files based on experimental groups defined in a metadata file. Use when user asks to merge FASTQ files by sample group, concatenate sequencing reads from multiple lanes, or combine library preparations into a single biological unit.
homepage: https://github.com/SantaMcCloud/Sample_grouping
metadata:
  docker_image: "quay.io/biocontainers/sample_grouping:1.0.0--pyhdfd78af_0"
---

# sample_grouping

## Overview

The `sample_grouping` tool (also referred to as `fastq-groupmerge`) automates the process of concatenating sequencing reads from multiple FASTQ files into single, grouped files. By utilizing a metadata file (typically a CSV), the tool identifies which samples belong to specific experimental groups and merges their respective forward and reverse reads. This is essential for workflows where individual library preparations or sequencing lanes need to be analyzed as a single biological or experimental unit.

## Usage Instructions

### Metadata Configuration
The tool relies heavily on a correctly formatted metadata file.
- **Required Column**: You must have a column named `sample_id`. These IDs should match the prefixes of your FASTQ files.
- **Grouping Column**: A column defining the groups (e.g., `treatment`, `genotype`). You specify this column name using the `--group_col` flag.
- **Flexibility**: A single `sample_id` can appear in multiple groups if you need the same sample to be part of different merged outputs.

### Command Line Patterns

**Basic Grouping**
To merge samples based on a specific column in a standard CSV:
```bash
sample_grouping --metadata metadata.csv --group_col treatment_name --output_dir ./merged_fastq/
```

**Handling Custom File Suffixes**
If your files use non-standard naming conventions (e.g., `_R1_001.fastq.gz`), define them explicitly:
```bash
sample_grouping --forward_suffix _R1_001.fastq.gz --reverse_suffix _R2_001.fastq.gz --metadata metadata.csv --group_col group
```

**Using Different Delimiters**
If your metadata is tab-separated (TSV):
```bash
sample_grouping --sep '\t' --metadata metadata.tsv --group_col group
```

### Best Practices
- **Input Directory**: Ensure all forward and reverse FASTQ files are located in the same input directory.
- **Gzip Support**: The tool natively supports `.gz` files and will output gzipped files to save disk space.
- **Naming Consistency**: The output files will be named `{group_name}{suffix}`. Ensure your group names do not contain characters that are invalid for filenames.
- **Global Merge**: If you run the tool without a metadata file, it will merge every FASTQ file in the directory into a single set of forward and reverse reads.

## Reference documentation
- [sample_grouping - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sample_grouping_overview.md)
- [GitHub - SantaMcCloud/fastq-groupmerge](./references/github_com_SantaMcCloud_fastq-groupmerge.md)