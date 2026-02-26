---
name: assembly-stats
description: "assembly-stats generates summary statistics and continuity metrics for genomic data in FASTA or FASTQ formats. Use when user asks to calculate N50 values, count assembly gaps, or generate summary statistics for sequence files."
homepage: https://github.com/sanger-pathogens/assembly-stats
---


# assembly-stats

## Overview

assembly-stats is a high-performance tool used to generate summary statistics for genomic data. It automatically detects whether input files are in FASTA or FASTQ format and can process multiple files simultaneously. The tool is essential for bioinformatics workflows where you need to determine the continuity of an assembly (via N50-N100 metrics) or identify the prevalence of undetermined bases (Ns) and assembly gaps.

## Installation

The most efficient way to install the tool is via Bioconda:

```bash
conda install bioconda::assembly-stats
```

## Common CLI Patterns

### Basic Usage
To get statistics for one or more files using the default human-readable output:
```bash
assembly-stats file1.fasta file2.fastq.gz
```

### Filtering by Sequence Length
To ignore small contigs or short reads (e.g., sequences shorter than 500bp), use the `-l` flag. This is a best practice for assembly evaluation to avoid skewing N50 values with short, uninformative sequences:
```bash
assembly-stats -l 500 assembly.fasta
```

### Machine-Readable Output
For downstream processing or integration into scripts, use the tab-delimited or grep-friendly formats:
- **Tab-delimited (with header):** `assembly-stats -t assembly.fasta`
- **Tab-delimited (no header):** `assembly-stats -u assembly.fasta`
- **Grep-friendly:** `assembly-stats -s assembly.fasta`

## Interpreting Results

When reviewing the output, pay attention to these specific metrics:

- **N50 and n**: The output `N50 = 1687656, n = 5` means that 50% of the total assembly length is contained in 5 sequences, the shortest of which is 1,687,656 bp.
- **Gaps**: A "gap" is defined as any consecutive run of "N" or "n" bases. This metric helps identify how fragmented the scaffolds are.
- **N_count**: This is the total number of undetermined bases across all sequences.

## Expert Tips

- **Compression Support**: The tool automatically detects compression (.gz, .bz2, or .xz). You do not need to decompress files before running the tool, which saves disk space and I/O time.
- **Format Agnostic**: Since the tool detects format based on content rather than extension, it is robust against unconventional file naming.
- **Batch Processing**: You can pass a long list of files or use wildcards. The tool will provide a separate block of statistics for every file provided in the command.

## Reference documentation

- [assembly-stats - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_assembly-stats_overview.md)
- [GitHub - sanger-pathogens/assembly-stats: Get assembly statistics from FASTA and FASTQ files](./references/github_com_sanger-pathogens_assembly-stats.md)