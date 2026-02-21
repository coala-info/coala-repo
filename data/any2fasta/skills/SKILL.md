---
name: any2fasta
description: any2fasta is a lightweight, high-performance tool designed to convert almost any common biological sequence format into FASTA.
homepage: https://github.com/tseemann/any2fasta
---

# any2fasta

## Overview

any2fasta is a lightweight, high-performance tool designed to convert almost any common biological sequence format into FASTA. It was developed to overcome the limitations of heavier libraries (like BioPerl or BioPython) and the ID-mangling behavior of older tools like EMBOSS. It is particularly effective for bioinformaticians who need a fast, dependency-free way to normalize sequence data while preserving complex identifiers containing special characters.

## Common CLI Patterns

### Basic Conversion
Convert a single file (e.g., Genbank) to FASTA:
```bash
any2fasta genome.gbk > genome.fasta
```

### Handling Compressed Files
The tool automatically detects and decompresses gzip, bzip2, and zip files:
```bash
any2fasta sequences.gbk.gz > sequences.fasta
```

### Batch Processing
You can pass multiple files of different formats simultaneously to create a single concatenated FASTA file:
```bash
any2fasta ref.gbk reads.fq.gz assembly.gfa > combined.fasta
```

### Working with Pipes
Use `-` to read from standard input:
```bash
curl -s "URL_TO_SEQUENCE" | any2fasta - > local.fasta
```

## Expert Tips and Options

### Sequence Cleaning
*   **Standardize Nucleotides**: Use `-n` to replace any character that is not A, C, G, or T with 'N'. This is useful for cleaning up ambiguous bases before running sensitive alignment tools.
*   **Case Normalization**: Use `-u` to force all sequences to uppercase or `-l` for lowercase.
*   **Header Cleanup**: Use `-s` to strip descriptions from the headers of FASTA/FASTQ/GFF inputs, leaving only the sequence ID.

### Robustness in Pipelines
*   **Skip Errors**: When processing large batches of files where some might be malformed, use `-k`. This prevents the script from dying on a bad input and instead issues a warning and continues to the next file.
*   **Quiet Mode**: Use `-q` in automated scripts to suppress progress messages and only output errors.

### Format-Specific Behavior
*   **Genbank/EMBL**: Use `-g` to include the `VERSION` string in the FASTA header.
*   **GFF**: any2fasta only extracts sequences from GFF files if the FASTA sequence is appended at the end (standard GFF3 behavior).
*   **PDB**: It can extract protein sequences directly from Protein Data Bank structure files.
*   **Alignments**: When converting Clustal (`.clw`) or Stockholm (`.sth`) files, gaps are preserved.

## Reference documentation
- [any2fasta GitHub Repository](./references/github_com_tseemann_any2fasta.md)