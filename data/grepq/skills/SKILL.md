---
name: grepq
description: grepq is a high-performance utility for filtering and analyzing FASTQ files using optimized regex matching and parallel processing. Use when user asks to filter genomic sequences by patterns or IUPAC codes, apply quality control thresholds, convert FASTQ to FASTA, or export sequence data to SQLite databases.
homepage: https://github.com/Rbfinch/grepq
---


# grepq

## Overview

grepq is a specialized Rust-based utility designed for the rapid filtering of FASTQ files. It outperforms traditional tools like grep or awk by utilizing parallel processing and optimized regex matching specifically for genomic data. Use this skill to perform sequence-based filtering (including IUPAC ambiguity codes), apply quality control thresholds, and organize matched reads into separate "buckets" or databases. It is particularly effective for large-scale sequencing projects where processing speed and memory efficiency are critical.

## Core CLI Usage

The basic syntax for grepq follows this pattern:
`grepq [SUBCOMMAND] [OPTIONS] <PATTERNS> <FASTQ>`

### Common Filtering Patterns
- **Basic Filter**: `grepq patterns.txt input.fastq > matches.fastq`
- **Compressed Input/Output**: 
  - Gzip: `grepq -g patterns.txt input.fastq.gz`
  - Zstd: `grepq --zstd patterns.txt input.fastq.zst`
- **Inverted Match**: `grepq inverted patterns.txt input.fastq` (finds records that do NOT match).

### Using Predicates
Predicates allow you to filter by metadata and quality without needing complex regex for the quality string:
- **Sequence Length**: `--min-len 100` (only keep reads ≥ 100bp).
- **Quality Score**: `--min-qual 30` (average Phred score threshold).
- **Header Filtering**: `-e "SRR[0-9]+"` (regex match against the record ID line).

## Advanced Features

### Pattern Files (JSON)
While simple text files work, JSON pattern files allow for named regex sets and variant tracking.
```json
[
  {
    "name": "16S_V4",
    "regex": "GTGYCAGCMGCCGCGGTAA"
  }
]
```

### Output Formats
- **FASTA**: Use the `-f` flag to convert matched FASTQ records to FASTA format.
- **Bucketing**: Use `--bucket` to automatically save matches into separate files named after the regex names defined in your JSON pattern file.
- **SQLite Export**: Use `writeSQL <DB_NAME>` to create a database containing:
  - Sequence content and GC percentage.
  - Tetranucleotide frequencies (TNF) and canonical TNFs.
  - Regex match positions within each sequence.

### Tuning and Summarizing
- **Tune**: Use the `tune` subcommand to test your regex patterns against a sample. It provides counts of matches and identifies variants found by your expressions.
- **Summarise**: Use the `summarise` subcommand to generate a JSON report of match statistics across the entire dataset.

## Expert Tips
- **IUPAC Support**: grepq natively understands IUPAC ambiguity codes (e.g., R for A/G, Y for C/T). You do not need to manually expand these into regex groups.
- **Performance**: For maximum speed on multi-core systems, grepq parallelizes the search. Ensure you have sufficient disk I/O to keep up with the processing speed.
- **Memory**: The tool is designed to scale to large files (multi-gigabyte) without loading the entire file into RAM.



## Subcommands

| Command | Description |
|---------|-------------|
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| grepq | Searches the sequence line of FASTQ records for regular expressions that are contained in a text or JSON file, or it searches for the absence of those regular expressions when used with the `inverted` command. The FASTQ file on which it operates can be supplied uncompressed or in gzip or zstd compressed format. |
| inverted | Search for PATTERNS in FILE |
| summarise | Summarise records matching regex patterns and variants in the FASTQ file |
| tune | Tune the regex patterns by analyzing matched substrings |

## Reference documentation
- [grepq README](./references/github_com_Rbfinch_grepq_blob_main_README.md)
- [grepq Cookbook](./references/github_com_Rbfinch_grepq_blob_main_cookbook.md)
- [grepq Help Documentation](./references/github_com_Rbfinch_grepq_blob_main_help.md)