---
name: dnaio
description: dnaio is a Python library for high-speed parsing and writing of FASTA, FASTQ, and unmapped BAM files. Use when user asks to read or write genomic sequences, process paired-end sequencing data, or handle compressed sequence files.
homepage: https://github.com/marcelm/dnaio/
metadata:
  docker_image: "quay.io/biocontainers/dnaio:1.2.3--py313h031d066_0"
---

# dnaio

## Overview
dnaio is a specialized Python library designed for the high-speed parsing and writing of common genomic sequence formats. Originally developed as part of the Cutadapt project, it provides a unified interface for handling FASTA, FASTQ, and unmapped BAM (uBAM) files. It is particularly useful for bioinformaticians who need to write custom processing scripts that can handle large-scale sequencing data without the overhead of more complex libraries.

## Core Usage Patterns

### Basic File Reading
The primary interface is `dnaio.open()`, which automatically detects file formats and compression types based on file extensions.

```python
import dnaio

# Reading a single file (FASTA or FASTQ)
with dnaio.open("reads.fastq.gz") as f:
    for record in f:
        # record.name, record.sequence, record.qualities
        print(f"Read {record.name} with length {len(record)}")
```

### Writing Sequences
When writing, specify the mode as `'w'`. The format is inferred from the filename.

```python
with dnaio.open("output.fasta", mode="w") as writer:
    for record in processed_records:
        writer.write(record)
```

### Handling Paired-End Data
dnaio simplifies paired-end processing by synchronized iteration over two files.

```python
# Reading paired-end files
with dnaio.open("r1.fastq.gz", file2="r2.fastq.gz") as f:
    for record1, record2 in f:
        # Process synchronized pairs
        pass

# Reading interleaved paired-end data from one file
with dnaio.open("interleaved.fastq", interleaved=True) as f:
    for record1, record2 in f:
        pass
```

### Working with uBAM
Since version 1.1.0, dnaio supports reading unmapped BAM files, which is useful for processing raw data from platforms like Oxford Nanopore (ONT) via the dorado basecaller.

```python
with dnaio.open("reads.bam") as f:
    for record in f:
        # Access sequence and tags
        pass
```

## Expert Tips and Best Practices

- **Compression Support**: To enable Zstandard (.zst) support, ensure the `zstandard` Python package is installed alongside `dnaio`.
- **Performance**: dnaio is optimized for speed. For maximum efficiency when processing FASTQ files, avoid unnecessary string manipulations of the `record.qualities` attribute unless required.
- **Memory Management**: Always use the `with` statement (context manager) to ensure file handles and compression buffers are properly closed, especially when dealing with many small files or large compressed streams.
- **Validation**: dnaio performs basic format validation. If you encounter `dnaio.exceptions.UnknownFileFormat`, verify the file extension or explicitly check if the file header matches FASTA (starts with `>`) or FASTQ (starts with `@`) standards.
- **Limitations**: Note that dnaio does not support multi-line FASTQ files (where the sequence or qualities are split across multiple lines). It expects the standard 4-line-per-record format.

## Reference documentation
- [dnaio GitHub Repository](./references/github_com_marcelm_dnaio.md)
- [dnaio Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dnaio_overview.md)