---
name: longreadsum
description: LongReadSum is a bioinformatics utility for rapid quality assessment and metric extraction from long-read sequencing datasets including BAM, FASTQ, and raw signal files. Use when user asks to perform quality control on long-read data, summarize BAM or FAST5 files, calculate transcript integrity numbers, or process ONT sequencing summary files.
homepage: https://github.com/WGLab/LongReadSum
---

# longreadsum

## Overview
LongReadSum is a specialized bioinformatics utility designed for rapid and comprehensive quality assessment of long-read sequencing datasets. It provides a unified interface to extract metrics from raw signal files (POD5/FAST5), basecalled reads (FASTQ/FASTA), and genomic alignments (BAM). It is an essential tool for identifying library preparation issues, assessing read length distributions, and evaluating transcript integrity in long-read RNA-Seq.

## Common CLI Patterns

The tool follows a consistent syntax: `longreadsum <subcommand> -i <input> -o <output_dir>`.

### Subcommand Selection
- **Aligned Data**: Use `bam` for WGS, base modifications (methylation), or RNA-Seq.
- **Raw ONT Signal**: Use `pod5` or `fast5`.
- **Basecalled Reads**: Use `fastq` or `fasta`.
- **ONT Metadata**: Use `basecall_summary` for the `sequencing_summary.txt` file.

### Example Commands
- **Standard BAM QC**:
  ```bash
  longreadsum bam -i input.bam -o output_folder
  ```
- **ONT Summary QC (Fastest)**:
  ```bash
  longreadsum basecall_summary -i sequencing_summary.txt -o output_folder
  ```
- **Containerized Execution (Docker)**:
  Ensure local directories are mounted to the `/mnt` path inside the container.
  ```bash
  docker run -v /absolute/path/to/data:/mnt -it genomicslab/longreadsum bam -i /mnt/input.bam -o /mnt/output
  ```

## Expert Tips and Best Practices

- **RNA-Seq TIN Values**: When running the `bam` subcommand on RNA-Seq data, LongReadSum automatically calculates Transcript Integrity Numbers (TIN), which are vital for assessing the quality of transcript coverage.
- **MultiQC Integration**: LongReadSum is designed to work with MultiQC. After generating results, you can aggregate them across multiple samples:
  ```bash
  multiqc . --module longreadsum --outdir multiqc_report
  ```
- **Signal vs. Sequence QC**: For FAST5 files, the tool can perform both Signal QC (raw electrical signal) and Sequence QC (basecalled data within the FAST5).
- **Resource Management**: For large BAM files, ensure the index file (`.bai`) is present in the same directory to speed up processing, though the tool is optimized for speed even with large datasets.
- **Output Formats**: The tool generates both an interactive `summary.html` for manual inspection and a `summary.json` for automated downstream processing.



## Subcommands

| Command | Description |
|---------|-------------|
| longreadsum bam | Summarize BAM files for long reads. |
| longreadsum f5 | Summarize long read sequencing data from fast5 files. |
| longreadsum f5s | Parses fast5 files for long read summary statistics. |
| longreadsum fa | Summarize long read data from FASTA files. |
| longreadsum fq | For example: python longreadsum fq -i input.fastq -o /output_directory/ |
| longreadsum rrms | Extracts read information based on a CSV file and BAM input. |
| longreadsum seqtxt | Processes sequencing summary files. |

## Reference documentation
- [LongReadSum README](./references/github_com_WGLab_LongReadSum_blob_main_README.md)
- [Dockerfile](./references/github_com_WGLab_LongReadSum_blob_main_Dockerfile.md)