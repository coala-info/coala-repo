---
name: screed
description: Screed provides a lightweight database layer for FASTA and FASTQ files to enable rapid random access and efficient sequence parsing. Use when user asks to create sequence databases, convert between FASTA and FASTQ formats, or perform memory-efficient iteration and lookups of sequencing data.
homepage: http://github.com/dib-lab/screed/
metadata:
  docker_image: "quay.io/biocontainers/screed:1.0.4--py_0"
---

# screed

## Overview
Screed is a specialized utility designed for handling high-throughput sequencing data. It provides a lightweight, read-only database layer for FASTA and FASTQ files, allowing for rapid random access to sequences without loading entire files into memory. This skill enables efficient sequence parsing, database generation, and format conversion workflows essential for bioinformatics pipelines.

## Command Line Usage
The `screed` CLI provides tools for database management and file conversion.

### Database Creation
Create a screed database from a sequence file to enable fast lookups:
```bash
screed make_db <input_file.fa/fq>
```
This generates a `.screed` file in the same directory.

### Format Conversion
Convert between common sequence formats:
*   **FASTA to FASTQ**: `screed fa_to_fq <input.fa> <output.fq>`
*   **FASTQ to FASTA**: `screed fq_to_fa <input.fq> <output.fa>`

## Python API Integration
Screed is most powerful when used within Python scripts for custom sequence processing.

### Iterating Through Sequences
The `screed.open` function automatically detects the file type (FASTA or FASTQ) and provides an iterable of record objects.
```python
import screed

with screed.open('sequences.fastq') as seqfile:
    for record in seqfile:
        name = record.name
        sequence = record.sequence
        accuracy = record.quality # Only for FASTQ
        print(f"Processing {name}...")
```

### Random Access via Database
Once a database is created, you can access specific records by their name (key) instantly:
```python
import screed

db = screed.ScreedDB('sequences.fa')
record = db['sequence_id_123']
print(record.sequence)
```

## Expert Tips
*   **Memory Efficiency**: Always use `screed.open` for large files to stream records one by one rather than loading them into a list.
*   **Database Persistence**: The `make_db` command is a one-time cost. Once the `.screed` file exists, random access lookups are nearly instantaneous regardless of the original file size.
*   **Attribute Access**: Record objects behave like dictionaries but also support attribute access (e.g., `record['sequence']` is the same as `record.sequence`).



## Subcommands

| Command | Description |
|---------|-------------|
| screed | Available commands: db, dump_fasta, dump_fastq |
| screed | A shell interface to the screed database writing function |
| screed | Convert a screed database to a FASTA file |
| screed | Convert a screed database to a FASTA file |

## Reference documentation
- [screed GitHub README](./references/github_com_dib-lab_screed_blob_main_README.md)
- [screed Change Log](./references/github_com_dib-lab_screed_blob_main_CHANGELOG.md)