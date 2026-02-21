---
name: fastalite
description: fastalite is a minimalist bioinformatics utility designed for the simplest possible parsing of FASTA and FASTQ records.
homepage: https://github.com/nhoffman/fastalite
---

# fastalite

## Overview

fastalite is a minimalist bioinformatics utility designed for the simplest possible parsing of FASTA and FASTQ records. It provides a lightweight alternative to heavy libraries, returning sequence records as namedtuples for easy attribute access. It is particularly useful for quick scripts, sequence filtering, and format conversion where performance and simplicity are prioritized over complex feature sets.

## Usage Instructions

### Python API Patterns

The core of fastalite is its two iterator functions which yield namedtuples with `id`, `description`, and `seq` attributes. FASTQ records also include a `qual` attribute.

**Basic FASTA Parsing:**
```python
from fastalite import fastalite

with open('sequences.fasta') as f:
    for record in fastalite(f):
        print(f"ID: {record.id}")
        print(f"Sequence: {record.seq}")
```

**Basic FASTQ Parsing:**
```python
from fastalite import fastqlite

with open('reads.fastq') as f:
    for record in fastqlite(f):
        # record has id, description, seq, and qual
        if len(record.seq) > 50:
            print(f"@{record.description}\n{record.seq}\n+\n{record.qual}")
```

### Handling Compressed Files

Use the `Opener` class to handle transparent reading and writing of compressed files based on their file extensions (.gz or .bz2). This is a drop-in replacement for `argparse.FileType` or standard `open`.

```python
from fastalite import Opener, fastalite

# Automatically detects compression from extension
with Opener()('data.fasta.gz') as infile:
    for seq in fastalite(infile):
        # process sequence
        pass
```

### Command Line Interface

fastalite can be invoked as a module to perform simple manipulations directly from the terminal.

**View Help:**
```bash
python -m fastalite -h
```

**Common CLI Tasks:**
- **Format Conversion:** Convert FASTQ to FASTA by piping or using the CLI options.
- **Sequence Extraction:** Use the CLI to quickly inspect or filter sequence headers.

## Best Practices

- **Attribute Selection:** Use `record.id` for the unique identifier (the string before the first whitespace) and `record.description` for the full header line.
- **Error Handling:** The `fastqlite` parser performs basic validation. Be prepared to catch `ValueError` when processing potentially malformed FASTQ files.
- **Memory Efficiency:** Since fastalite returns iterators, it is memory-efficient for processing very large genomic files. Avoid converting the iterator to a list unless the file is small.
- **Integration with argparse:** When building CLI tools, use `type=Opener()` in `add_argument` to allow your script to accept both plain text and compressed sequence files without extra logic.

## Reference documentation

- [fastalite GitHub Repository](./references/github_com_nhoffman_fastalite.md)
- [fastalite Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastalite_overview.md)