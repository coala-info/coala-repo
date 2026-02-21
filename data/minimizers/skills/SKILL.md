---
name: minimizers
description: The `minimizers` tool is a specialized utility for bioinformatics workflows that require sequence sketching.
homepage: https://github.com/cumbof/minimizers
---

# minimizers

## Overview
The `minimizers` tool is a specialized utility for bioinformatics workflows that require sequence sketching. By selecting the smallest k-mer (the "minimizer") within a sliding window, it reduces the complexity of large genomic datasets while preserving essential sequence characteristics. This skill provides the necessary CLI patterns to perform extraction, frequency reporting, and parallelized processing of FASTA files.

## Installation
Install the package via Conda or Pip:
```bash
conda install bioconda::minimizers
# OR
pip install minimizers
```

## Common CLI Patterns

### Basic Minimizer Extraction
Extract minimizers of a specific size from a sliding window. The window size (`-w`) must always be greater than the k-mer size (`-s`).
```bash
minimizers -i input.fasta -s 21 -w 31 -o output.txt
```

### Generating Fasta Sketches
To use the extracted minimizers as a sequence database or for further alignment, output them in FASTA format instead of a simple list.
```bash
minimizers -i input.fasta -s 21 -w 31 -t fasta -o sketch.fasta
```

### Frequency Analysis and Filtering
Identify the most frequent minimizers in a dataset. This is useful for finding common genomic signatures or filtering out rare k-mers.
```bash
# Report counts for all extracted minimizers
minimizers -i input.fasta -s 21 -w 31 --report-counts -t list -o counts.txt

# Extract only the top 5% most frequent minimizers
minimizers -i input.fasta -s 21 -w 31 --top-perc 5.0 -o top_5_percent.txt

# Extract the top 100 most frequent minimizers
minimizers -i input.fasta -s 21 -w 31 --top-num 100 -o top_100.txt
```

### Processing Large Datasets
For large FASTA files or multi-record files, use aggregation and parallel processing to improve performance.
```bash
# Aggregate results across all records in the FASTA file
minimizers -i input.fasta -s 21 -w 31 -a

# Use multiple CPU cores for faster processing
minimizers -i input.fasta -s 21 -w 31 -n 8
```

## Expert Tips
- **Window Selection**: A common heuristic is setting the window size (`-w`) to approximately 1.5x to 2x the k-mer size (`-s`) for a balance between compression and sensitivity.
- **Compressed Inputs**: The tool natively supports Gzip compressed files (`.fasta.gz`), so there is no need to decompress data before processing.
- **Standard Output**: If the `-o` flag is omitted, results are printed to `stdout`, allowing for easy piping into other tools like `grep` or `sort`.
- **Aggregation**: Use the `-a` (aggregate) flag when you want a single set of minimizers for the entire file rather than a per-record breakdown.

## Reference documentation
- [minimizers - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_minimizers_overview.md)
- [GitHub - cumbof/minimizers](./references/github_com_cumbof_minimizers.md)