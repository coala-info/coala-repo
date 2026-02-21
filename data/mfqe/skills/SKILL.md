---
name: mfqe
description: `mfqe` is a high-performance utility designed for the rapid extraction of sequences from genomic data files.
homepage: https://github.com/wwood/mfqe
---

# mfqe

## Overview
`mfqe` is a high-performance utility designed for the rapid extraction of sequences from genomic data files. Written in Rust, it efficiently processes large FASTA and FASTQ files by matching sequence identifiers against provided name lists. It is particularly effective in bioinformatics pipelines where specific reads need to be isolated from raw sequencing data for targeted assembly or alignment.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::mfqe
```

## Core Usage Patterns

### Extracting FASTQ Reads
To extract reads from a FASTQ file based on one or more lists of names:
```bash
mfqe --input-fastq input.fastq.gz \
     --fastq-read-name-lists list1.txt list2.txt \
     --output-fastq-files output1.fastq.gz output2.fastq.gz
```
*Note: The number of name lists must match the number of output files.*

### Extracting FASTA Sequences
The syntax for FASTA files is analogous:
```bash
mfqe --input-fasta input.fasta \
     --fasta-read-name-lists names.txt \
     --output-fasta-files subset.fasta.gz
```

### Using Pipes and STDIN
`mfqe` supports STDIN by default, which is useful for streaming data from tools like `zcat` or `curl`:
```bash
zcat data.fastq.gz | mfqe --fastq-read-name-lists ids.txt --output-fastq-files filtered.fastq.gz
```

## Advanced Options and Best Practices

### Handling Compression
- **Input**: Automatically detects if the input is gzip-compressed or raw text.
- **Output**: Outputs are gzip-compressed by default. Use the `--output-uncompressed` flag if raw text is required.

### Read Name List Format
- Name lists should be uncompressed text files.
- Each line should contain exactly one read name.
- Do not include comments or the leading `@` (FASTQ) or `>` (FASTA) symbols in the list file; use the raw identifier.
- Empty lines in the name lists are ignored.

### Specialized Flags
- `--append`: Appends the extracted reads to the output files instead of overwriting them.
- `--sequence-prefix`: Allows matching based on a prefix rather than an exact full-string match of the read name.
- `--sequence-name-lists`: A generic alternative to the format-specific list flags.

### Performance Tip
Because `mfqe` is written in Rust, it is significantly faster than many Python or Perl-based extraction scripts. When processing multiple subsets from the same source file, always provide all name lists in a single command to avoid reading the large source file multiple times.

## Reference documentation
- [mfqe GitHub Repository](./references/github_com_wwood_mfqe.md)
- [mfqe Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mfqe_overview.md)