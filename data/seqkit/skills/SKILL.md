---
name: seqkit
description: SeqKit is a cross-platform toolkit for the efficient manipulation and processing of FASTA and FASTQ files. Use when user asks to generate sequence statistics, filter sequences by length, convert file formats, extract subsets by ID or region, search for motifs, remove duplicates, or split large genomic datasets.
homepage: https://github.com/shenwei356/seqkit
---


# seqkit

## Overview
SeqKit is an ultrafast, cross-platform toolkit designed for the efficient manipulation of FASTA and FASTQ files. It provides a comprehensive suite of subcommands that handle everything from basic file statistics to complex sequence transformations and searching. Because it is written in Go and supports multi-threading, it is particularly well-suited for processing large-scale genomic datasets. It seamlessly handles compressed files (gzip, bzip2, xz, zstd) and integrates easily into command-line pipes via STDIN/STDOUT.

## Common CLI Patterns

### Basic Statistics and Inspection
Generate quick summaries of sequence files, including N50, average length, and quality scores.
```bash
# Get summary statistics for all fastq files in a directory
seqkit stats *.fastq.gz

# Tabular output for easy parsing
seqkit stats --tabular sequences.fasta
```

### Filtering and Transformation
Clean or modify sequences based on specific criteria.
```bash
# Filter sequences by length (e.g., longer than 100bp)
seqkit seq --min-len 100 input.fa > filtered.fa

# Remove gaps (dashes) from sequences
seqkit seq --gap-letters "-" input.fa

# Convert FASTQ to FASTA
seqkit fq2fa reads.fastq.gz -o reads.fasta
```

### Searching and Subsetting
Extract specific records or regions.
```bash
# Search for sequences by ID list in a file
seqkit grep --pattern-file ids.txt input.fq > subset.fq

# Extract a specific region (e.g., first 100 bases)
seqkit subseq --region 1:100 input.fa

# Find motifs with mismatches
seqkit locate --pattern ATCGG --max-mismatch 1 input.fa
```

### Set Operations and Deduplication
Manage redundant data and file organization.
```bash
# Remove duplicate sequences by sequence content
seqkit rmdup --by-seq input.fa -o unique.fa

# Sample 10% of reads (reproducible with a seed)
seqkit sample --proportion 0.1 --rand-seed 11 input.fq > sampled.fq

# Split a large file into parts of 10,000 sequences each
seqkit split2 --by-size 10000 input.fq.gz
```

## Expert Tips
- **Piping and Compression**: SeqKit automatically detects compression. Use `-` to represent STDIN. For maximum speed when writing compressed files, use the `.gz` extension in the output filename.
- **Multi-threading**: While SeqKit is fast by default, you can explicitly set threads using `-j` or `--threads` (e.g., `-j 8`) for commands that support it, like `stats` or `grep`.
- **Regex Replacements**: Use `seqkit replace` to rename headers using regular expressions. For example, `seqkit replace -p "(.+)" -r "SampleA_$1"` prepends a sample name to every ID.
- **Tabular Conversion**: Use `seqkit fx2tab` to convert FASTA/Q to a one-line-per-sequence TSV format. This is extremely useful for processing sequences with standard Unix tools like `awk`, `cut`, or `sed`, and can be converted back using `seqkit tab2fx`.
- **Paired-end Matching**: If your forward and reverse FASTQ files become out of sync, use `seqkit pair` to re-match them based on their IDs.

## Reference documentation
- [SeqKit GitHub Repository](./references/github_com_shenwei356_seqkit.md)
- [SeqKit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqkit_overview.md)