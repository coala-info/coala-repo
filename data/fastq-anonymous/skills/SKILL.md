---
name: fastq-anonymous
description: `fastq-anonymous` is a specialized utility for de-identifying FASTQ files.
homepage: https://github.com/wdecoster/fastq-anonymous
---

# fastq-anonymous

## Overview
`fastq-anonymous` is a specialized utility for de-identifying FASTQ files. It allows users to generate "safe" versions of genomic data by replacing real sequences with random nucleotides or 'N' masks while preserving the critical structural elements of the file, such as read lengths and quality strings. This ensures that the anonymized file can still be processed by bioinformatic pipelines to reproduce errors or test workflows without compromising privacy or confidentiality.

## Core Usage Patterns
The tool operates primarily through standard input (stdin) and standard output (stdout), making it highly compatible with standard Unix pipes.

### Basic Anonymization
By default, the tool replaces sequences with random nucleotides and anonymizes headers (identifiers and descriptions).
```bash
cat input.fastq | fastq-anonymous > anonymous.fastq
```

### Handling Compressed Files
Since FASTQ files are typically gzipped, use `gunzip` to stream data into the tool and `gzip` to compress the output.
```bash
gunzip -c reads.fastq.gz | fastq-anonymous | gzip > anonymous_reads.fastq.gz
```

### Nucleotide Masking
If you prefer to mask sequences with 'N' instead of random bases, use the `--mask` flag. This is often useful for testing how tools handle low-complexity or ambiguous data.
```bash
gunzip -c reads.fastq.gz | fastq-anonymous --mask > masked_reads.fastq
```

## Expert Tips
- **Paired-End Data**: When working with paired-end reads (R1 and R2), you must process each file separately. Note that because the tool uses random nucleotides by default, the sequences in R1 and R2 will not "match" in a biological sense, but their lengths and quality scores will remain consistent with the originals.
- **Troubleshooting**: This tool is specifically recommended when reporting bugs to bioinformatics software maintainers. It allows them to see the exact quality score distribution and read length variations that might be causing a crash without seeing the actual sequence data.
- **Metadata Scrubbing**: The tool automatically removes descriptions and identifiers from the FASTQ header lines, which often contain sensitive sample names or instrument IDs.
- **Installation**: The tool is available via Bioconda (`conda install bioconda::fastq-anonymous`) or PyPI (`pip install fastq-anonymous`).

## Reference documentation
- [fastq-anonymous GitHub Repository](./references/github_com_wdecoster_fastq-anonymous.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastq-anonymous_overview.md)