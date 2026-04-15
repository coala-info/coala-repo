---
name: fa-lint
description: fa-lint validates FASTA files for correct formatting, biological plausibility, and common structural issues. Use when user asks to validate FASTA files, check for duplicate sequence identifiers, identify invalid characters, or verify compressed genomic datasets.
homepage: https://github.com/GallVp/fa-lint
metadata:
  docker_image: "quay.io/biocontainers/fa-lint:1.2.0--he881be0_0"
---

# fa-lint

## Overview
The `fa-lint` tool is a high-performance validator designed to ensure FASTA files are correctly formatted and biologically plausible. It checks for common issues such as empty files, duplicate sequence identifiers, invalid characters (like whitespace or digits within sequences), and inconsistent line wrapping. It is optimized for speed using multi-threading and natively supports compressed `.gz` files, making it ideal for pre-processing large genomic datasets before they are used in downstream analysis.

## Usage Patterns

### Basic Validation
To perform a standard check on a FASTA file:
```bash
fa-lint -fasta input.fasta
```

### Validating Compressed Files
The tool handles gzipped files directly without needing manual decompression:
```bash
fa-lint -fasta sequences.fasta.gz
```

### Strict Identifier Validation
By default, identifiers are the text between the `>` and the first space. Use `-w` to enforce strict naming conventions (IDs must start with a letter and contain only alphanumeric characters or underscores):
```bash
fa-lint -w -fasta input.fasta
```

### Handling Stop Codons
If your FASTA file contains protein sequences with stop codons, use specific flags to prevent validation failure:
- **Terminal stop codons**: Use `-s` for `.` or `-S` for `*`.
- **In-frame stop codons**: Use `-a` in combination with `-s` or `-S` to allow stop codons anywhere in the sequence.

```bash
# Allow terminal '*' stop codons
fa-lint -S -fasta protein.fasta

# Allow '*' stop codons anywhere in the sequence
fa-lint -S -a -fasta protein.fasta
```

### Performance Optimization
For large files, adjust the thread count. The default is 6, but it can be tuned based on your hardware:
```bash
fa-lint -threads 10 -fasta large_genome.fasta
```

## Best Practices
- **Pre-alignment Check**: Always run `fa-lint` before sequence alignment or database indexing to catch duplicate IDs or illegal characters that cause tool crashes.
- **Strict Mode for Databases**: When preparing files for public repositories or databases, use the `-w` flag to ensure identifiers are compatible with the broadest range of bioinformatics software.
- **Memory Management**: While `fa-lint` is fast, ensure your thread count does not exceed available CPU cores to maintain system stability during large-scale validation.
- **Automated QC**: Integrate `fa-lint` into your initial data ingestion step to verify that downloaded or generated FASTA files are not truncated or entirely masked (all `N`s).

## Reference documentation
- [fa-lint GitHub Repository](./references/github_com_GallVp_fa-lint.md)
- [Bioconda fa-lint Overview](./references/anaconda_org_channels_bioconda_packages_fa-lint_overview.md)