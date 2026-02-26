---
name: py_fasta_validator
description: This tool verifies the integrity and formatting of FASTA files using a high-performance C-extension. Use when user asks to validate FASTA file headers, check for duplicate sequence identifiers, or ensure sequence lines contain only valid characters.
homepage: https://github.com/linsalrob/py_fasta_validator
---


# py_fasta_validator

## Overview

The `py_fasta_validator` tool is a high-performance C-extension for Python designed to quickly verify the integrity of FASTA files. It is particularly useful in bioinformatics pipelines to catch malformed data before downstream analysis. The tool checks for proper header formatting, unique sequence identifiers, and the absence of invalid characters (like whitespace or numbers) within sequence lines. It supports both plain text and gzipped FASTA files.

## Usage Guidelines

### Command Line Interface (CLI)

The primary way to use the tool is via the `py_fasta_validator` command.

**Basic Validation:**
```bash
py_fasta_validator -f input.fasta
```

**Compressed File Validation:**
The tool natively handles gzip compression without requiring manual decompression.
```bash
py_fasta_validator -f input.fasta.gz
```

### Exit Codes and Error Handling

The tool communicates the result of the validation primarily through exit codes. When running this in a script, always check the return value:

- **0**: Valid FASTA file.
- **1**: Header error (the first line does not start with `>`).
- **2**: Duplicate sequence identifiers found.
- **4**: Invalid characters in sequence (contains characters other than `[A-Za-z]`).
- **254/255**: Internal program error.

### Python API Integration

For integration within Python scripts, use the `FastaValidator` module:

```python
import FastaValidator

# Returns the integer exit code (0 for success)
result = FastaValidator.fasta_validator("path/to/file.fasta")

if result != 0:
    print(f"Validation failed with code: {result}")
```

## Expert Tips & Best Practices

- **Sequence Identifiers**: The tool defines the "identifier" as the string between the `>` character and the first whitespace. Ensure your headers are formatted correctly if you expect uniqueness checks to pass.
- **Character Constraints**: Note that this validator is strict. It will fail (Exit Code 4) if sequence lines contain numbers, internal spaces, or special characters (like `*` for stop codons or `-` for gaps), as it only permits `[A-Za-z]`.
- **Performance**: Because the core logic is implemented in ANSI C, it is significantly faster than pure-Python parsers for large-scale genomic data.
- **Environment Setup**: If running in a Conda environment and encountering shared library errors (e.g., `libpython` not found), ensure your `LD_LIBRARY_PATH` includes the environment's `lib` directory.

## Reference documentation
- [py_fasta_validator GitHub Repository](./references/github_com_linsalrob_py_fasta_validator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_py_fasta_validator_overview.md)