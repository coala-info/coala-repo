---
name: seqsizzle
description: seqsizzle is a terminal-based pager designed for viewing and analyzing bioinformatics sequencing files with visual cues for base quality and adapter matching. Use when user asks to interactively inspect FASTQ or FASTA files, identify enriched k-mers, or quantify adapter matches in sequencing reads.
homepage: https://github.com/ChangqingW/SeqSizzle
---


# seqsizzle

## Overview
seqsizzle is a terminal-based pager specifically designed for bioinformatics. Unlike general-purpose pagers, it understands the structure of sequencing files, providing fuzzy matching for adapters and visual cues for base quality. It allows researchers to quickly verify library preparation success, troubleshoot unexpected sequences, and perform lightweight k-mer analysis without leaving the terminal.

## Core CLI Usage

### Interactive Viewing
The primary mode for inspecting reads. It supports `.fastq`, `.fasta`, `.fa`, `.fq` and their `.gz` compressed variants.

```bash
# Basic viewing
seqsizzle sample.fastq.gz

# View with predefined 10x Genomics 3' kit adapters
seqsizzle sample.fastq --adapter-3p

# View with custom patterns from a CSV
seqsizzle sample.fastq -p my_adapters.csv
```

### Enrichment Analysis
Use the `enrich` subcommand to identify overrepresented k-mers, which often correspond to adapters, primers, or technical artifacts.

```bash
# Find enriched k-mers and save to CSV
seqsizzle sample.fastq enrich -o enrichment_results.csv

# Sample a specific number of reads for faster processing on large files
seqsizzle sample.fastq enrich -o results.csv --max-reads 50000 --sample

# Detect and merge reverse complement k-mers
seqsizzle sample.fastq enrich -o results.csv --detect-reverse-complement
```

### Summarization
The `summarize` command provides a TSV output of how many reads match specific patterns. Note: Flags must be supplied before the subcommand.

```bash
# Quantify 10x 5' adapter matches
seqsizzle sample.fastq --adapter-5p summarize
```

## Navigation and Shortcuts

While in the viewer mode, use the following keys to manipulate the display:

- **j / k**: Scroll down/up by one line.
- **Ctrl+U / Ctrl+D**: Scroll half a screen.
- **/**: Toggle the search panel to add or edit patterns.
- **i**: Toggle italics for low-quality bases (threshold set by `--quality-threshold`).
- **b**: Toggle background color styling based on quality scores.
- **q**: Quit the application.

## Expert Tips

- **Quality Thresholds**: By default, seqsizzle considers a Phred score of 10 as the threshold for "low quality." Adjust this using `--quality-threshold <INT>` to match your specific QC requirements.
- **Custom Pattern Format**: When using `-p`, ensure your CSV has the header: `pattern,color,editdistance,comment`. This allows you to define specific colors for different library components (e.g., UMI vs. Adapter).
- **Search Panel Efficiency**: In the search panel, use **Tab** to cycle through input fields and **Return** to add the current input to the active pattern list.
- **Terminal Compatibility**: For the best experience with quality-based background colors, use a terminal emulator that supports 256 colors (like iTerm2 or Kitty) and ensure your font supports italics.

## Reference documentation
- [SeqSizzle GitHub Repository](./references/github_com_ChangqingW_SeqSizzle.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seqsizzle_overview.md)