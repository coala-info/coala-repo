---
name: polyat
description: `polyat` is a command-line bioinformatics tool that identifies and counts poly-A/T homopolymer sequences in sequencing data.
homepage: https://github.com/DaanJansen94/polyat
---

# polyat

## Overview
`polyat` is a command-line bioinformatics tool that identifies and counts poly-A/T homopolymer sequences in sequencing data. It is highly efficient as it streams data directly from compressed or raw FASTQ files without requiring full decompression to disk. The tool evaluates each read once and categorizes it based on the length of the longest A/T stretch (≥10, ≥15, or ≥20 nucleotides), providing both a summary table for automated pipelines and an interactive HTML report for manual inspection.

## Usage Instructions

### Basic Command
To process a directory of sequencing files, use the following syntax:
```bash
polyat -i <input_directory> -o <output_directory>
```

### Arguments
- `-i, --input`: Path to the directory containing your FASTQ files. The tool automatically detects `.fastq`, `.fastq.gz`, `.fq`, and `.fq.gz` extensions.
- `-o, --output`: Path to the directory where results will be saved. If the directory does not exist, `polyat` will create it.

### Output Files
The tool generates two primary outputs in the specified output directory:
1. **polyA_counts.txt**: A tab-separated (TSV) file containing the raw counts and percentages for each threshold (10, 15, 20 nt) per sample.
2. **polyA_report.html**: An interactive dashboard featuring a poly-A/T histogram and per-column filters for visual QC.

## Expert Tips and Best Practices
- **Carrier RNA Detection**: If you are using the QIAamp Viral RNA Mini Kit, expect significant poly-A/T signals. Use this tool to quantify exactly how much of your library is composed of these artifacts.
- **Streaming Efficiency**: Do not manually decompress `.gz` files before running `polyat`. The tool is optimized to stream compressed data, saving both time and disk space.
- **Directory-Based Processing**: `polyat` processes entire directories. If you only want to process a subset of files, move them to a temporary directory or use symbolic links.
- **Threshold Logic**: Note that the tool counts each read at most once per threshold. A read containing a 25-nt poly-A stretch will be counted in all three categories (≥10, ≥15, and ≥20).

## Reference documentation
- [polyat Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_polyat_overview.md)
- [polyat GitHub Repository and README](./references/github_com_DaanJansen94_polyat.md)