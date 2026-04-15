---
name: perl-unicode-normalize
description: This tool transforms Unicode text into standardized normalization forms to ensure consistent character representation. Use when user asks to normalize text, convert characters to NFC or NFD forms, or prepare datasets for accurate searching and deduplication.
homepage: http://metacpan.org/pod/Unicode::Normalize
metadata:
  docker_image: "quay.io/biocontainers/perl-unicode-normalize:1.26--pl5321h9948957_7"
---

# perl-unicode-normalize

## Overview
The `perl-unicode-normalize` skill implements the Unicode Normalization Forms (UAX #15). In many data processing tasks, the same visual character can be represented by different underlying code points (e.g., a precomposed "é" vs. an "e" followed by a combining accent). This skill allows you to transform text into a unique, standardized representation, which is a prerequisite for accurate searching, sorting, and deduplication of text-based datasets.

## Command Line Usage (Perl One-liners)
While this is a Perl module, it is frequently used as a command-line utility via Perl one-liners to process files or streams.

### Basic Normalization
To normalize a file, use the `-M` flag to load the module and the `-ne` flags to process the input line by line.

**Normalize to NFC (Canonical Composition):**
Recommended for most general-purpose applications and web compatibility.
```bash
perl -MUnicode::Normalize -ne 'print NFC($_)' input.txt > output.txt
```

**Normalize to NFD (Canonical Decomposition):**
Commonly used when you need to separate base characters from their accents (e.g., for accent stripping).
```bash
perl -MUnicode::Normalize -ne 'print NFD($_)' input.txt > output.txt
```

### Compatibility Normalization
Use the "K" forms to handle compatibility characters, such as converting formatting variants (superscripts, subscripts, or ligatures) into their plain equivalents.

**Normalize to NFKC:**
```bash
perl -MUnicode::Normalize -ne 'print NFKC($_)' input.txt
```

### In-place File Transformation
To update a file directly without creating a new one, use the `-i` flag:
```bash
perl -i -MUnicode::Normalize -ne 'print NFC($_)' data.txt
```

## Functional Reference
The module provides specific functions for each normalization form:

| Function | Form | Description |
| :--- | :--- | :--- |
| `NFC($str)` | Form C | Canonical Decomposition followed by Canonical Composition. |
| `NFD($str)` | Form D | Canonical Decomposition. |
| `NFKC($str)`| Form KC| Compatibility Decomposition followed by Canonical Composition. |
| `NFKD($str)`| Form KD| Compatibility Decomposition. |
| `FCD($str)` | FCD | "Fast C or D" form; useful for optimizing subsequent operations. |

## Expert Tips
- **Performance**: Using the direct function names (e.g., `NFC()`) is more efficient than using the generic `normalize('C', $string)` function.
- **Character Semantics**: Ensure your environment handles Perl's internal string representation correctly. If your input is UTF-8, you may need to add the `-CSD` flag to the Perl command: `perl -CSD -MUnicode::Normalize -ne 'print NFC($_)'`.
- **Comparison**: Always normalize both strings to the same form (usually NFC or NFD) before performing equality checks or regex matches to avoid false negatives caused by different encoding styles.

## Reference documentation
- [Unicode::Normalize - Unicode Normalization Forms - metacpan.org](./references/metacpan_org_pod_Unicode__Normalize.md)
- [perl-unicode-normalize - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-unicode-normalize_overview.md)