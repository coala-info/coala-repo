---
name: fastafunk
description: Fastafunk provides a suite of utilities for high-throughput FASTA file processing, including filtering, merging, and metadata annotation. Use when user asks to filter sequences, merge FASTA files, annotate headers with metadata, or subsample datasets.
homepage: https://github.com/cov-ert/fastafunk
---


# fastafunk

## Overview
The `fastafunk` skill provides a suite of utilities designed for high-throughput FASTA file processing. It is particularly useful in genomic epidemiology workflows where sequences need to be filtered, merged, or annotated based on external metadata (like CSV/TSV files). This tool streamlines the "janitorial" work of sequence management, ensuring consistency across large datasets.

## Common CLI Patterns

### Sequence Filtering
Filter sequences based on a list of IDs or metadata criteria:
```bash
fastafunk filter \
  --input-fasta sequences.fasta \
  --output-fasta filtered.fasta \
  --include-list ids_to_keep.txt
```

### Merging FASTA Files
Combine multiple FASTA files while ensuring unique headers or specific ordering:
```bash
fastafunk merge \
  --input-fasta file1.fasta file2.fasta \
  --output-fasta merged.fasta
```

### Metadata Integration
Add or modify FASTA headers using information from a metadata file:
```bash
fastafunk annotate \
  --input-fasta sequences.fasta \
  --metadata metadata.csv \
  --index-column sequence_id \
  --output-fasta annotated.fasta
```

### Subsampling
Reduce dataset size while maintaining specific representative sequences:
```bash
fastafunk subsample \
  --input-fasta sequences.fasta \
  --sample-size 100 \
  --output-fasta subset.fasta
```

## Expert Tips
- **Piping**: `fastafunk` is designed to work within Unix pipelines. Use `-` as an input/output argument where supported to chain commands without writing intermediate files.
- **Validation**: Always validate your metadata index column against your FASTA headers before running `annotate` or `filter` to avoid empty outputs.
- **Performance**: For very large files, ensure you have sufficient memory as some subcommands may load sequence headers into RAM for indexing.

## Reference documentation
- [fastafunk GitHub Repository](./references/github_com_snake-flu_fastafunk.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastafunk_overview.md)