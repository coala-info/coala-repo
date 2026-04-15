---
name: fxtract
description: fxtract extracts biological records from FASTA and FASTQ files using format-aware sequence or header matching. Use when user asks to extract sequences from FASTX files, search for motifs using regular expressions, or filter records by header information.
homepage: https://github.com/ctSkennerton/fxtract
metadata:
  docker_image: "quay.io/biocontainers/fxtract:2.4--hc29b5fc_3"
---

# fxtract

## Overview
fxtract is a specialized bioinformatics utility designed for high-performance sequence extraction from FASTX (FASTA and FASTQ) files. Unlike general-purpose text search tools like grep, fxtract is format-aware, ensuring that when a match is found, the entire biological record (including headers and quality scores) is correctly extracted. It supports a variety of search algorithms, including simple substring matching, POSIX regular expressions, and PCRE, making it a versatile tool for sequence mining and dataset filtering.

## Usage Patterns

### Basic Sequence Extraction
To extract records containing a specific subsequence from a FASTA or FASTQ file:
```bash
fxtract "ATGC" input.fastq
```

### Regular Expression Searching
Use the `-r` flag to enable regular expression matching. This is useful for finding motifs or degenerate sequences:
```bash
fxtract -r "A[TG]CCG.*T" input.fasta
```

### Identifying Files with Matches
Similar to `grep -l`, use the `-l` flag to output only the names of the files that contain a match rather than the sequences themselves:
```bash
fxtract -l "GATTACA" sample1.fq sample2.fq sample3.fq
```

### Handling Compressed Data
fxtract natively supports gzip and bgzip compressed files. You do not need to decompress files before searching:
```bash
fxtract "TTAGGG" reads.fastq.gz
```

## Expert Tips and Best Practices

- **Targeted Searching**: While the default behavior is to search the sequence field, fxtract can be configured to search headers, comments, or quality scores. Use this to extract sequences by specific IDs or to filter by quality metadata.
- **Algorithm Selection**: fxtract automatically selects search algorithms (substring, PCRE, hash lookups) based on the task. For simple identifier matching, it is significantly faster than general-purpose regex tools.
- **Multi-Pattern Search**: When searching for multiple distinct sequences, fxtract utilizes multi-pattern searching to maintain efficiency, which is preferable over running multiple passes on the same file.
- **Pipe Integration**: fxtract is designed for bioinformatics pipelines. It can read from standard input and write to standard output, allowing it to be chained with tools like `samtools` or `seqtk`.

## Reference documentation
- [fxtract GitHub README](./references/github_com_ctSkennerton_fxtract.md)
- [fxtract Version Tags and Feature History](./references/github_com_ctSkennerton_fxtract_tags.md)
- [Bioconda fxtract Overview](./references/anaconda_org_channels_bioconda_packages_fxtract_overview.md)