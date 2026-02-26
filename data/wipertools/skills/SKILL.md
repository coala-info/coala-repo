---
name: wipertools
description: wipertools sanitizes genomic sequencing data by cleaning and repairing FASTQ files. Use when user asks to clean FASTQ files, repair corrupted genomic sequencing data, define allowed sequence alphabets, generate quality reports, split or merge FASTQ files, or aggregate summary reports.
homepage: https://github.com/mazzalab/fastqwiper
---


# wipertools

## Overview
wipertools is a specialized suite of programs (including fastqwiper, splitfastq, and summarygather) designed to sanitize genomic sequencing data. It acts as a "pre-flight" cleaner for FASTQ files, addressing common issues such as malformed headers, invalid sequence alphabets, and broken GZIP streams that often cause standard bioinformatic tools to fail. It is particularly effective at salvaging readable reads from corrupted archives and maintaining proper read interleaving.

## Command Line Usage

### Cleaning FASTQ Files
The primary command for sanitizing a file is `fastqwiper`. It accepts both raw `.fastq` and compressed `.fastq.gz` formats.

```bash
wipertools fastqwiper -i input.fastq.gz -o cleaned.fastq.gz
```

### Advanced Filtering Options
*   **Define Allowed Alphabet**: Use the `-a` flag to restrict the SEQ line to specific characters (default is `ACGTN`).
    ```bash
    wipertools fastqwiper -i in.fastq -o out.fastq -a ACGTRN
    ```
*   **Quality Reporting**: Generate a final quality report summary using the `-l` flag.
    ```bash
    wipertools fastqwiper -i in.fastq -o out.fastq -l quality_summary.txt
    ```
*   **Status Monitoring**: Adjust how often status messages are printed to the console using `-f` (default is every 500,000 reads).
    ```bash
    wipertools fastqwiper -i in.fastq -o out.fastq -f 1000000
    ```

### File Manipulation
*   **Splitting**: Use `splitfastq` to break large files into manageable chunks for parallel processing.
*   **Merging**: Combine multiple FASTQ files while ensuring the resulting file maintains proper formatting.
*   **Summary Gathering**: Use `summarygather` to aggregate reports from multiple `fastqwiper` runs into a single document.

## Expert Tips and Best Practices

*   **Handling Corruption**: If a `.gz` file is unreadable by standard decompression tools, use the `fastqwiper` workflow. It leverages `gzrt` (Gzip Recovery Toolkit) to extract healthy segments and reformat them into a valid FASTQ structure.
*   **ASCII Offsets**: Ensure you are using the correct ASCII offset for quality scores. Most modern Illumina data uses Sanger/Illumina 1.8+ (offset 33), while older Solexa data may use offset 64.
*   **Paired-End Integrity**: When cleaning paired-end data, ensure your files follow the `_R1.fastq.gz` and `_R2.fastq.gz` naming convention to allow the tool to correctly identify pairs and settle interleaving issues.
*   **Resource Allocation**: For large-scale cleaning, running the tool via the provided Docker or Singularity containers is recommended to ensure all dependencies (like `gzrt` and `BBTools`) are correctly configured in the environment.

## Reference documentation
- [wipertools - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_wipertools_overview.md)
- [FastqWiper GitHub Repository](./references/github_com_mazzalab_fastqwiper.md)