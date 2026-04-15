---
name: fastqe
description: fastqe visualizes FASTQ file quality scores by converting them into a sequence of emojis. Use when user asks to check sequence quality, visualize FASTQ data with emojis, or perform a quick quality triage of sequencing reads.
homepage: https://github.com/lonsbio/fastqe
metadata:
  docker_image: "quay.io/biocontainers/fastqe:0.5.2--pyhdfd78af_0"
---

# fastqe

## Overview
`fastqe` is a specialized bioinformatics utility that transforms sequence quality data into a readable emoji format. It processes one or more FASTQ files, calculates the minimum, maximum, and mean quality scores for every nucleotide position across all reads, and maps these values to specific emojis. This allows for an immediate, intuitive understanding of data quality—such as identifying where quality drops off at the ends of reads—without leaving the command line.

## Usage and Best Practices

### Basic Command Patterns
The tool is designed for simplicity. The primary usage involves passing one or more FASTQ files as arguments:

```bash
# Analyze a single FASTQ file
fastqe sequences.fastq

# Analyze multiple files (e.g., paired-end data)
fastqe read1.fastq read2.fastq

# Process compressed files (if supported by the environment's cat/zcat)
zcat reads.fastq.gz | fastqe -
```

### Interpreting the Output
*   **Emoji Mapping**: Each emoji represents a rounded Phred quality score. Generally, "happy" or "bright" emojis (like 😃 or 🌟) indicate high quality, while "sad" or "warning" emojis (like 😟 or 💀) indicate low quality.
*   **Position-wise Analysis**: The output displays a sequence of emojis corresponding to the length of the reads. If your reads are 150bp long, you will see 150 emojis representing the aggregate quality at each cycle.

### Expert Tips
*   **Triage Tool**: Use `fastqe` as a first-pass filter. If the emoji output shows a sea of "angry" or "low-quality" emojis early in the read, it indicates a potential sequencing failure or the need for aggressive adapter trimming.
*   **Terminal Compatibility**: Ensure your terminal emulator supports Unicode and Emoji characters to view the output correctly.
*   **Data Format**: The tool specifically targets Illumina 1.8+ and Sanger FASTQ formats. Ensure your data is not in the older Illumina 1.3/1.5 format (which uses a different Phred offset) to avoid incorrect quality mapping.

## Reference documentation
- [fastqe - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fastqe_overview.md)
- [FASTQ with Emoji = FASTQE 🤔](./references/github_com_lonsbio_fastqe_blob_main_README.md)