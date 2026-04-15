---
name: fqgrep
description: fqgrep is a high-performance, sequence-aware utility designed for searching and filtering FASTQ files using regular expressions or fixed strings. Use when user asks to search for sequences in FASTQ files, filter paired-end reads, count matching records, or identify reverse complement matches.
homepage: https://github.com/fulcrumgenomics/fqgrep
metadata:
  docker_image: "quay.io/biocontainers/fqgrep:1.1.1--ha6fb395_0"
---

# fqgrep

## Overview
The `fqgrep` utility is a high-performance tool designed specifically for searching FASTQ files using regular expressions or fixed strings. Unlike standard `grep`, it is sequence-aware, meaning it searches the base calls of FASTQ records and can handle paired-end data. When operating in paired mode, if one read in a pair matches the criteria, both reads are retrieved and output in an interleaved format, preserving the integrity of the pair for downstream analysis.

## Common CLI Patterns

### Basic Searching
Search a single FASTQ file for a specific sequence:
```bash
fqgrep 'GACGAGATTA' sample.fastq.gz
```

### Paired-End Filtering
Search a pair of FASTQ files. If either R1 or R2 matches the pattern, both reads are output (interleaved):
```bash
fqgrep --paired --regexp 'GACGAGATTA' sample_R1.fastq.gz sample_R2.fastq.gz
```

### Searching Multiple Patterns
Use multiple `-e` flags to search for several motifs simultaneously. A record is selected if it matches *any* of the patterns:
```bash
fqgrep -e 'ATGC...' -e 'TCCG...' sample.fastq
```

### Reverse Complement Matching
Search for the pattern in both the forward and reverse complement orientations of the reads:
```bash
fqgrep --reverse-complement 'GACGAGATTA' sample.fastq.gz
```

### Counting Matches
To simply see how many reads match without streaming the FASTQ records:
```bash
fqgrep -c 'GACGAGATTA' sample.fastq.gz
```

## Expert Tips and Best Practices

*   **Performance Tuning**: Use the `-t` or `--threads` option to specify the number of matching threads. The default is 10, but this should be adjusted based on your CPU availability. Note that reading and writing use additional dedicated threads.
*   **Fixed Strings**: If you are searching for a literal DNA sequence and not a regular expression, use `-F` (`--fixed-strings`) to improve search speed.
*   **Handling Compressed Input**: `fqgrep` automatically detects `.gz` and `.bgz` extensions. If you are piping compressed data from standard input, use the `-Z` (`--decompress`) flag to ensure the tool treats the stream as GZIP compressed.
*   **Pattern Files**: For large sets of target sequences (e.g., a list of barcodes or adapters), store them in a newline-separated text file and use `-f` (`--file`) to load them.
*   **Inverted Matching**: Use `-v` to output reads that **do not** match the specified pattern, which is useful for removing known contaminants or adapter sequences.
*   **Colorized Output**: When exploring data in the terminal, use `--color always` to highlight the exact location of the match within the read sequence.

## Reference documentation
- [github_com_fulcrumgenomics_fqgrep.md](./references/github_com_fulcrumgenomics_fqgrep.md)
- [anaconda_org_channels_bioconda_packages_fqgrep_overview.md](./references/anaconda_org_channels_bioconda_packages_fqgrep_overview.md)