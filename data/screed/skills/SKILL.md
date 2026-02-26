---
name: screed
description: "Screed parses, stores, and retrieves biological sequences from FASTA and FASTQ files. Use when user asks to parse biological sequences, read sequence files, or create a screed database."
homepage: http://github.com/dib-lab/screed/
---


# screed

yaml
name: screed
description: |
  Parses, stores, and retrieves biological sequences (DNA and protein).
  Use when dealing with biological sequence data in FASTA or FASTQ formats,
  especially for tasks involving sequence manipulation, analysis, or database
  creation from sequence files.
```
## Overview
Screed is a Python library designed for efficient parsing, storage, and retrieval of biological sequences, particularly DNA and protein sequences. It excels at handling large sequence files in formats like FASTA and FASTQ, making it a valuable tool for bioinformatics workflows that require quick access to and manipulation of sequence data.

## Usage

Screed is primarily used as a Python library. While it doesn't expose a direct command-line interface for general sequence processing, its core functionality is accessible through Python scripting.

### Core Functionality

The main purpose of screed is to read sequence files and provide an iterable interface to their records. Each record typically contains the sequence identifier, the sequence itself, and potentially other metadata.

### Reading Sequence Files

The `screed.open()` function is the primary entry point for reading sequence files. It automatically detects the file format (FASTA or FASTQ) and returns an iterator over sequence records.

```python
import screed

# Example: Reading a FASTA file
for record in screed.open('sequences.fasta'):
    print(f"ID: {record.name}")
    print(f"Sequence: {record.sequence[:50]}...") # Print first 50 chars
    # Access other potential fields if available, e.g., record.description

# Example: Reading a FASTQ file
for record in screed.open('reads.fastq'):
    print(f"ID: {record.name}")
    print(f"Sequence: {record.sequence[:50]}...")
    print(f"Quality: {record.quality[:50]}...")
```

### Creating a Screed Database

Screed can be used to create a simple, read-only database from a collection of sequences. This is useful for fast lookups.

```python
import screed

# Assuming you have a list of sequence records (e.g., from reading a file)
sequences_to_db = [
    screed.Record(name='seq1', sequence='AGCTAGCTAGCT'),
    screed.Record(name='seq2', sequence='TTTTCCCCGGGG'),
]

# Create a screed database file
screed.write_fasta(sequences_to_db, 'my_sequences.fasta.screed')
```

### Iterating and Filtering

You can iterate through the records and apply custom filtering or processing logic within your Python scripts.

```python
import screed

# Filter sequences longer than a certain length
min_length = 1000
long_sequences = []
for record in screed.open('all_sequences.fasta'):
    if len(record.sequence) > min_length:
        long_sequences.append(record)

print(f"Found {len(long_sequences)} sequences longer than {min_length} bp.")
```

### Expert Tips

*   **Format Detection**: `screed.open()` is intelligent enough to detect FASTA and FASTQ formats automatically.
*   **Memory Efficiency**: For very large files, `screed.open()` provides an iterator, processing records one by one, which is memory-efficient.
*   **Custom Records**: You can create `screed.Record` objects manually for programmatic generation of sequence data.
*   **Integration**: Screed is often used as a foundational component within larger bioinformatics pipelines, where its sequence parsing capabilities are leveraged by other Python scripts or tools.

## Reference documentation
- [Screed Overview](https://bioconda.github.io/recipes/screed/README.html)
- [Screed GitHub Repository](https://github.com/dib-lab/screed)