---
name: sff2fastq
description: sff2fastq extracts read information from binary SFF files and converts them into Sanger FASTQ format. Use when user asks to convert 454 sequencing data to FASTQ, extract trimmed or untrimmed sequences from SFF files, or stream compressed SFF data into a processing pipeline.
homepage: https://github.com/indraniel/sff2fastq
metadata:
  docker_image: "quay.io/biocontainers/sff2fastq:0.9.2--h470a237_1"
---

# sff2fastq

## Overview

The `sff2fastq` utility is a lightweight tool designed to extract read information from binary SFF files produced by 454 genome sequencers. It transforms these reads into the standard Sanger FASTQ format, which is the required input for most modern sequence aligners and assemblers. The tool is highly efficient for data processing pipelines because it supports reading from standard input, allowing for the direct processing of compressed files without the need for intermediate temporary storage.

## Command Line Usage

### Basic Conversion
To convert a single SFF file to FASTQ using default settings (which outputs trimmed sequences):
```bash
sff2fastq input.sff -o output.fastq
```

### Streaming and Compressed Files
`sff2fastq` can read from standard input if no file is specified. This is the recommended pattern for handling gzipped SFF files to save disk space:
```bash
zcat data.sff.gz | sff2fastq > data.fastq
```

### Handling Trimmed vs. Untrimmed Reads
By default, the tool outputs trimmed sequences and quality values based on the clipping metadata stored within the SFF file. To extract the full, untrimmed sequence instead:
```bash
sff2fastq -n input.sff > untrimmed_output.fastq
```

## Expert Tips and Best Practices

- **Output Format**: The tool produces Sanger FASTQ format (Phred+33). Ensure your downstream tools are configured for this encoding, as some older pipelines might expect different FASTQ variants.
- **Default Behavior**: Without the `-n` flag, the tool mimics the behavior of official Roche/454 tools by applying the "left" and "right" clips defined in the SFF header.
- **Piping to Downstream Tools**: Since `sff2fastq` defaults to `stdout` when `-o` is omitted, you can pipe the output directly into aligners or compression utilities:
  ```bash
  sff2fastq input.sff | gzip > output.fastq.gz
  ```
- **Installation**: If the standard `make` fails on older Linux distributions or specific environments, try `make genome` as an alternative build target provided in the source.

## Reference documentation
- [sff2fastq Main Documentation](./references/github_com_indraniel_sff2fastq.md)