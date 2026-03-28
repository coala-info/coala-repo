---
name: seqsizzle
description: SeqSizzle is a bioinformatics tool for the rapid visualization and exploration of genomic sequence files with syntax highlighting for quality scores and adapter sequences. Use when user asks to view FASTQ or FASTA files, highlight adapter sequences, identify enriched k-mers, or summarize pattern matches in sequencing data.
homepage: https://github.com/ChangqingW/SeqSizzle
---

# seqsizzle

## Overview
SeqSizzle is a specialized bioinformatics tool designed for the rapid visualization and exploration of genomic sequence files (FASTQ/FASTA). Unlike standard text pagers, it understands the structure of sequencing data, providing syntax highlighting for quality scores and allowing for real-time fuzzy matching of adapter or primer sequences. It is particularly useful for quality control, verifying adapter trimming, and identifying unknown contaminants in sequencing runs.

## Core CLI Usage

### Basic Viewing
Open a sequence file (supports `.fastq`, `.fasta`, `.fa`, `.fq` and their `.gz` variants):
```bash
seqsizzle data.fastq.gz
```

### Using Adapter Presets
Quickly highlight common sequencing kit adapters:
*   **10x 3' Kit**: `seqsizzle data.fastq --adapter-3p`
*   **10x 5' Kit**: `seqsizzle data.fastq --adapter-5p`

### Pattern Matching from File
Load a custom set of sequences to highlight from a CSV file. The CSV must contain headers: `pattern,color,editdistance,comment`.
```bash
seqsizzle data.fastq -p my_patterns.csv
```

### Quality Score Visualization
*   `--quality-threshold <INT>`: Set the threshold for low-quality base styling (default: 10).
*   `--no-quality-italic`: Disable the default italic styling for low-quality bases.
*   `--quality-colors`: Enable background coloring based on quality (Note: may make text harder to read).

## Interactive Navigation
Once the pager is open, use the following keys:
*   **Movement**: `j`/`k` or Arrows (scroll), `Ctrl+U`/`Ctrl+D` (half-page).
*   **Search Panel**: `/` or `Ctrl+F` to toggle.
*   **Visual Toggles**: `i` (Italics for low quality), `b` (Background quality colors).
*   **Copy Mode**: Enabled by default in recent versions; allows mouse selection and copying.

## Subcommands for Analysis

### k-mer Enrichment (`enrich`)
Identify potential adapter or primer sequences by finding overrepresented k-mers.
```bash
seqsizzle data.fastq enrich -o enriched_kmers.csv --max-reads 10000
```
*   Use `--skip-assemble` to see raw k-mer counts without assembly.
*   Use `--max-reads 0` to process the entire file.

### Read Summarization (`summarize`)
Generate a TSV report of pattern matches.
```bash
seqsizzle data.fastq -p patterns.csv summarize
```
*Note: Ensure pattern flags are placed before the `summarize` command.*

## Expert Tips
*   **Fuzzy Matching**: When adding patterns in the interactive search panel, you can specify an edit distance to allow for sequencing errors in the adapters.
*   **Saving Work**: Press `Ctrl+S` within the search panel to save your current pattern list to a CSV for future use.
*   **Performance**: For very large gzipped files, SeqSizzle decompresses chunks to a temporary file; ensure you have sufficient `/tmp` space or work with uncompressed files for the fastest random access.



## Subcommands

| Command | Description |
|---------|-------------|
| seqsizzle | A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently. |
| seqsizzle | A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently. |
| seqsizzle | A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently. |
| seqsizzle | A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently. |
| seqsizzle | A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently. |
| seqsizzle enrich | Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences |
| seqsizzle summarize | Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future |

## Reference documentation
- [SeqSizzle README](./references/github_com_ChangqingW_SeqSizzle_blob_master_README.md)
- [SeqSizzle Changelog](./references/github_com_ChangqingW_SeqSizzle_blob_master_CHANGELOG.md)