---
name: unmerge
description: The unmerge tool splits interlaced FASTQ files containing paired-end sequencing data into separate forward and reverse read files. Use when user asks to 'split interlaced FASTQ files', 'de-interlace paired-end reads', 'separate R1 and R2 reads', or 'subsample interlaced FASTQ files'.
homepage: https://github.com/andvides/unmerge.git
metadata:
  docker_image: "quay.io/biocontainers/unmerge:1.0--h503566f_5"
---

# unmerge

## Overview
The `unmerge` utility is a specialized C-based tool designed for bioinformatics workflows involving paired-end sequencing data. It specifically addresses the need to split interlaced FASTQ files—where R1 and R2 reads are stored sequentially in one file—back into their original separate forward and reverse components. This is a critical preprocessing step for many aligners and assembly tools that require distinct files for paired-end analysis.

## Usage Instructions

### Basic Command Syntax
The tool follows a specific positional argument structure:
```bash
unmerge <file_path> <header_string> [num_reads]
```

### Parameters
- **file_path**: The path to the interlaced FASTQ file.
- **header_string**: The common prefix or identifier found in the read headers (e.g., "@SRR" or "@M0"). This helps the tool identify the start of each record.
- **num_reads** (Optional): The specific number of reads to extract. If omitted, the tool processes the entire file.

### Common Workflows

**1. Full De-interlacing**
To split an entire interlaced file into separate R1 and R2 files:
```bash
unmerge data_interlaced.fastq "@NODE"
```
*Note: This will generate two output files in the working directory, typically appended with suffixes to denote forward and reverse reads.*

**2. Subsampling for Testing**
To extract only the first 10,000 reads from a large interlaced file (useful for verifying pipeline integrity):
```bash
unmerge data_interlaced.fastq "@SRR" 10000
```

### Installation and Setup
If the tool is not present in the environment, it can be compiled from source or installed via Bioconda:

**Via Conda:**
```bash
conda install -c bioconda unmerge
```

**Via Source:**
```bash
unzip unmerge_v1.zip
cd unmerge_v1
make
```

## Best Practices
- **Header Identification**: Always inspect the first few lines of your FASTQ file (`head -n 4 file.fastq`) to determine the correct header string. Using an incorrect header string will result in failed extraction.
- **Disk Space**: Ensure you have at least double the disk space of the input file available, as the tool will create two new files representing the split data.
- **Validation**: After unmerging, verify that the line counts of the two resulting files are identical to ensure the pairing remains synchronized.

## Reference documentation
- [GitHub Repository for unmerge](./references/github_com_andvides_unmerge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_unmerge_overview.md)