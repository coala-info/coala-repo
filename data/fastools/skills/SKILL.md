---
name: fastools
description: The fastools toolkit provides a suite of efficient utilities for handling common sequence data formats.
homepage: https://git.lumc.nl/j.f.j.laros/fastools
---

# fastools

## Overview
The fastools toolkit provides a suite of efficient utilities for handling common sequence data formats. It is designed to bridge gaps in bioinformatics pipelines by offering fast, lightweight operations for sequence manipulation. Use this skill to perform tasks such as calculating sequence statistics, splitting or merging files, and converting between FASTA and FASTQ formats without the overhead of larger genomic frameworks.

## Common CLI Patterns

### Sequence Statistics
To get a quick summary of sequence lengths, GC content, and N-counts:
```bash
fastools stats input.fastq
```

### Format Conversion
Convert FASTQ files to FASTA format while maintaining sequence integrity:
```bash
fastools fastq-to-fasta input.fastq > output.fasta
```

### Sequence Extraction and Filtering
Extract specific sequences based on identifiers or filter by length:
```bash
# Extract sequences by ID list
fastools extract ids.txt input.fasta > filtered.fasta

# Filter sequences shorter than a specific threshold
fastools filter -m 50 input.fastq > long_reads.fastq
```

### File Manipulation
Handle paired-end data or split large files for parallel processing:
```bash
# Interleave paired-end files
fastools interleave forward.fastq reverse.fastq > interleaved.fastq

# De-interleave a file into two separate files
fastools deinterleave interleaved.fastq -1 forward.fastq -2 reverse.fastq
```

## Expert Tips
- **Piping**: fastools is designed to work with standard streams. Chain commands together (e.g., `fastools filter ... | fastools stats`) to avoid creating large intermediate files.
- **Compressed Files**: Most fastools commands natively support gzipped input, which is standard for raw sequencing data.
- **Validation**: Use the `stats` command as a first step in any pipeline to ensure the input file is not corrupted and meets expected quality metrics.

## Reference documentation
- [fastools Overview](./references/anaconda_org_channels_bioconda_packages_fastools_overview.md)