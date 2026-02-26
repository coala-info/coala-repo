---
name: pairtools
description: pairtools is a command-line suite for processing Hi-C sequencing alignments into structured DNA contact lists. Use when user asks to parse alignments into .pairs format, sort contact lists, remove PCR duplicates, filter pairs by genomic distance, or generate Hi-C library statistics.
homepage: https://github.com/mirnylab/pairtools
---


# pairtools

## Overview

pairtools is a high-performance command-line suite designed to process mapped sequencing reads from Hi-C experiments. It transforms raw alignments into a structured, tab-separated format (.pairs) that represents 3D DNA contacts. The toolset provides a modular workflow to detect ligation junctions, remove PCR duplicates, sort contact lists, and filter pairs based on mapping quality or genomic distance.

## Core Workflow and CLI Patterns

### 1. Parsing Alignments
Convert .sam or .bam files into .pairs or .pairsam format. This is the entry point for most Hi-C pipelines.

```bash
# Basic parsing from BAM to compressed .pairs
pairtools parse -c sacCer3.chrom.sizes -o output.pairs.gz --drop-sam input.bam

# Generate .pairsam (includes SAM alignments) for manual inspection
pairtools parse -c sacCer3.chrom.sizes -o output.pairsam.gz input.bam
```

### 2. Sorting
Sorting is a prerequisite for deduplication and merging. pairtools uses the system `sort` utility for efficiency.

```bash
# Sort a .pairs file by chromosome and position
pairtools sort --nproc 8 -o sorted.pairs.gz input.pairs.gz
```

### 3. Deduplication
Remove PCR and optical duplicates. Input must be sorted and "triu-flipped" (which `parse` handles by default).

```bash
# Remove duplicates and save statistics to a YAML file
pairtools dedup --output-stats stats.yaml -o dedup.pairs.gz sorted.pairs.gz
```

### 4. Filtering and Selection
Use `select` to filter pairs based on mapping types (e.g., UU for uniquely mapped) or specific genomic conditions.

```bash
# Select only uniquely mapped pairs (UU)
pairtools select "(pair_type == 'UU')" -o filtered.pairs.gz input.pairs.gz

# Filter by genomic distance (e.g., > 1kb)
pairtools select "abs(pos1 - pos2) > 1000" -o long_range.pairs.gz input.pairs.gz
```

### 5. Statistics and Quality Control
Generate comprehensive reports on the distribution of pair types and mapping statistics.

```bash
pairtools stats -o library_stats.txt input.pairs.gz
```

## Expert Tips and Best Practices

- **Compression**: Always use `.gz` or `.lz4` extensions in output paths; pairtools automatically detects these and applies compression to save disk space.
- **Memory Management**: When using `pairtools sort`, use the `--memory` flag to specify the buffer size for the underlying Unix sort to prevent disk thrashing.
- **Piping**: Commands are designed to work in Unix pipes to avoid intermediate file I/O.
  - *Example*: `pairtools parse ... | pairtools sort ... | pairtools dedup ...`
- **Chrom Sizes**: Ensure the `.chromsizes` file matches the exact chromosome names and order used in the original BAM/SAM header.
- **Complex Walks**: For long-read Hi-C or data with many chimeric alignments, use `pairtools parse2` to identify multi-ligation events.

## Reference documentation

- [GitHub Repository: pairtools](./references/github_com_open2c_pairtools.md)
- [Bioconda: pairtools Overview](./references/anaconda_org_channels_bioconda_packages_pairtools_overview.md)