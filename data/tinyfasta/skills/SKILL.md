---
name: tinyfasta
description: tinyfasta is a minimalist Python utility designed for handling biological sequences in FASTA format.
homepage: https://github.com/tjelvar-olsson/tinyfasta
---

# tinyfasta

## Overview

tinyfasta is a minimalist Python utility designed for handling biological sequences in FASTA format. It provides an intuitive API for iterating over large sequence files, filtering records based on headers, and generating new FASTA entries without the overhead of larger libraries like Biopython. It is particularly useful for scripts that must remain portable and dependency-free.

## Usage Guidelines

### Parsing FASTA Files
The `FastaParser` class is the primary entry point for reading files. It acts as an iterator, yielding `FastaRecord` objects.

```python
from tinyfasta import FastaParser

# Iterate through a FASTA file
for record in FastaParser("input.fasta"):
    header = record.description
    sequence = record.sequence
    print(f"Processing {header}")
```

### Working with Compressed Files
tinyfasta supports parsing compressed FASTA files (e.g., .gz). The parser handles the decompression internally when provided with a path to a compressed file.

### Filtering Records
The `description` object of a `FastaRecord` includes a `contains()` method for easy header-based filtering.

```python
for record in FastaParser("data.fasta"):
    if record.description.contains("homo_sapiens"):
        # Process only human sequences
        print(record)
```

### Creating and Writing Records
You can programmatically create FASTA records and print them or write them to files. The `FastaRecord.create()` method handles the formatting.

```python
from tinyfasta import FastaRecord

sequence = "ATGC" * 20
record = FastaRecord.create("Synthetic_DNA_01", sequence)

# The __str__ method returns a valid FASTA formatted string
print(record)
```

### Sequence Properties
- **Length**: You can use the standard `len()` function on both `FastaRecord` and its sequence components to get the sequence length.
- **String Representation**: Printing a `FastaRecord` object automatically formats it with the `>` header and wrapped sequence lines.

## Expert Tips
- **Memory Efficiency**: Since `FastaParser` is an iterator, it is suitable for processing very large FASTA files without loading the entire dataset into memory.
- **Header Manipulation**: The `description` attribute is more than a string; it is an object that allows for structured interaction with the FASTA header line.
- **Zero Dependencies**: Use this tool in environments where installing heavy bioinformatics suites is restricted or unnecessary.

## Reference documentation
- [tinyfasta GitHub Repository](./references/github_com_tjelvar-olsson_tinyfasta.md)
- [tinyfasta Commit History](./references/github_com_tjelvar-olsson_tinyfasta_commits_master.md)