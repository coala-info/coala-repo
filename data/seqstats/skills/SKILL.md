---
name: seqstats
description: `seqstats` is a high-performance command-line tool written in C that provides quick summary statistics for biological sequence files.
homepage: https://github.com/clwgg/seqstats
---

# seqstats

## Overview
`seqstats` is a high-performance command-line tool written in C that provides quick summary statistics for biological sequence files. It is optimized for speed using the `klib` library and can handle both plain text and compressed (.gz) FASTA and FASTQ files. Use this tool when you need an immediate overview of sequence data without the overhead of larger bioinformatics suites.

## Usage Patterns

### Basic Statistics
To get statistics for a single file (FASTA or FASTQ, plain or gzipped):
```bash
seqstats input.fastq.gz
```

### Processing Multiple Files
`seqstats` can aggregate statistics for multiple files by reading from standard input. Use the `-` character to signify STDIN:
```bash
cat sample_R1.fq.gz sample_R2.fq.gz | seqstats -
```

### Wildcard Processing
To summarize an entire set of files (e.g., all chromosomes in an assembly):
```bash
cat chr*.fa | seqstats -
```

## Best Practices and Tips
- **Performance**: For large datasets, prefer `seqstats` over interpreted scripts (like Python or Perl) as its C implementation is significantly faster for parsing sequence headers and lengths.
- **Stream Handling**: When using pipes, always remember the trailing `-`. Without it, the tool will not read the piped data.
- **Native Compression**: Do not decompress files before running `seqstats`. It handles `.gz` files natively, which is more efficient for both disk I/O and CPU usage.
- **Installation**: The easiest way to deploy the tool is via Bioconda: `conda install bioconda::seqstats`.

## Reference documentation
- [seqstats Overview](./references/anaconda_org_channels_bioconda_packages_seqstats_overview.md)
- [seqstats GitHub Repository](./references/github_com_clwgg_seqstats.md)