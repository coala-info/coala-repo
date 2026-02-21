---
name: grepq
description: `grepq` is a specialized, high-performance utility designed to filter FASTQ records based on sequence content.
homepage: https://github.com/Rbfinch/grepq
---

# grepq

## Overview
`grepq` is a specialized, high-performance utility designed to filter FASTQ records based on sequence content. Unlike general-purpose tools like `grep` or `ripgrep`, `grepq` is "FASTQ-aware," meaning it specifically targets the sequence field of a record to avoid false positives from headers or quality scores. It supports compressed inputs (gzip, zstd), IUPAC ambiguity codes, and complex filtering via JSON-defined predicates.

## Core CLI Patterns

### Basic Filtering
Filter a FASTQ file using a simple pattern file (one regex per line):
```bash
grepq patterns.txt input.fastq > output.txt
```

### Output Formats
By default, `grepq` outputs only the matched sequences. Use flags to change the format:
- `-I`: Output sequences and their corresponding record IDs.
- `-F`: Output in FASTA format.
- `-R`: Output in full FASTQ format (preserves quality scores).

### Handling Compressed Files
`grepq` natively handles compressed data. Use specific flags for optimal performance:
```bash
# Read gzipped input and write gzipped output with best compression
grepq --read-gzip --best patterns.txt input.fastq.gz > filtered.fastq.gz
```

### Inverted Matching
To extract records that do *not* match any patterns in the pattern file:
```bash
grepq inverted patterns.txt input.fastq -R > non_matching.fastq
```

## Advanced Features

### Predicate Filtering
Use a JSON pattern file to filter by sequence length, average quality score, or header regex.
Example JSON structure (for reference):
- `regexName`: Label for the pattern.
- `regexPattern`: The sequence regex.
- `minLength`: Minimum sequence length.
- `minAverageQuality`: Minimum Phred score.
- `qualityEncoding`: "Sanger" (Phred+33) or "Illumina" (Phred+64).

### SQLite Integration
Export matches and metadata (GC content, tetranucleotide frequencies) directly to a database:
```bash
grepq patterns.txt input.fastq --writeSQL output.db
```

### Bucketing
Automatically split matches into separate files based on the `regexName` defined in a JSON pattern file:
```bash
grepq patterns.json input.fastq --bucket -R
```

## Expert Tips
- **Performance**: `grepq` is significantly faster than `grep` or `awk` for FASTQ data because it uses a specialized parser. Use it as a drop-in replacement in pipelines to reduce wall time.
- **IUPAC Support**: The tool automatically handles IUPAC ambiguity codes (e.g., R, Y, S, W, K, M, B, D, H, V, N) in your regex patterns.
- **False Positives**: Always prefer `grepq` over `ripgrep` for FASTQ filtering to ensure you aren't matching patterns against the quality score string, which often contains characters that look like DNA sequences.
- **Tuning**: Use the `tune` command to test pattern files and see how many matches each specific regex generates before running a full production filter.

## Reference documentation
- [grepq GitHub Repository](./references/github_com_Rbfinch_grepq.md)
- [grepq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_grepq_overview.md)