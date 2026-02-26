---
name: tn93
description: tn93 computes pairwise genetic distances between aligned nucleotide sequences. Use when user asks to compute pairwise genetic distances, identify closely related sequences, compare distances between two datasets, handle ambiguous nucleotides, filter by sequence overlap, specify output format, or count pairs below a threshold.
homepage: https://github.com/veg/tn93
---


# tn93

## Overview

tn93 is a specialized tool for computing pairwise genetic distances between aligned nucleotide sequences. It implements the Tamura-Nei 93 substitution model, which is more sophisticated than simpler models like Jukes-Cantor because it accounts for different rates of transitions and transversions as well as unequal base frequencies. The tool is optimized for speed and is frequently used in viral genomics to identify sequences that are closely related (e.g., within a 1.5% distance threshold) to build transmission networks.

## CLI Usage and Best Practices

### Basic Distance Calculation
The most common use case is identifying all pairs of sequences in a single FASTA file that fall below a specific genetic distance threshold.

```bash
tn93 -t 0.015 -o output_distances.csv input_aligned.fas
```

### Comparing Two Separate Datasets
To find distances between sequences in two different files (e.g., comparing a new batch of sequences against a reference database), use the `-s` flag.

```bash
tn93 -s database.fas -t 0.05 new_sequences.fas
```

### Handling Ambiguous Nucleotides
Ambiguity handling is critical for viral sequence data. tn93 provides several strategies via the `-a` flag:
- **resolve (default)**: Resolves ambiguities to minimize the distance (e.g., 'R' is treated as 'A' if the other sequence has 'A').
- **average**: Averages the possible distances (e.g., 'R' vs 'A' is treated as 50% 'A'-'A' and 50% 'G'-'A').
- **skip**: Ignores any site containing an ambiguous character.
- **gapmm**: Treats gaps matched to non-gaps as an 'N' (4-fold ambiguity).

### Filtering by Sequence Overlap
To avoid false low distances caused by poor alignment or short overlaps, use the `-l` (overlap) flag. The default is 100 base pairs.

```bash
# Only report distances for sequences sharing at least 500 aligned positions
tn93 -l 500 -t 0.015 input.fas
```

### Output Formats
Control the output structure using the `-f` flag:
- **csv**: `seqname1, seqname2, distance` (Standard)
- **csvn**: `1, 2, distance` (Uses indices instead of names to save space)
- **hyphy**: A matrix format compatible with HyPhy software.

### Working with Large Datasets
- **Counting only**: Use `-c` to only output the count of pairs below the threshold and the distance histogram, rather than writing every individual pair to disk.
- **Quiet mode**: Use `-q` to suppress progress updates to stderr, which is useful for clean logging in automated pipelines.
- **Copy Numbers**: If your FASTA headers contain copy numbers (e.g., `>SequenceName:15`), use `-d` to specify the delimiter (default is `:`) so that tn93 can weight the histogram and mean calculations correctly.

## Expert Tips
- **Alignment Requirement**: All input sequences must be pre-aligned and have the exact same length. tn93 does not perform alignment; it only calculates distances from existing alignments.
- **Self-Reporting**: Use the `-0` flag to include self-to-self comparisons (distance 0). This is helpful when you need to ensure every sequence from the input file appears in the output list, even if it doesn't cluster with anything else.
- **Memory and Performance**: If the compiler supports OpenMP, tn93 will automatically run in multithreaded mode. For extremely large datasets, the `-c` (count only) mode significantly reduces I/O overhead.

## Reference documentation
- [tn93 GitHub README](./references/github_com_veg_tn93.md)
- [tn93 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tn93_overview.md)