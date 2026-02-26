---
name: pydna_repeatfinder
description: pydna_repeatfinder detects direct and inverted repetitive DNA sequences in genomic data. Use when user asks to find repeats in a FASTA file, generate GenBank repeat annotations, or identify repetitive sequences using Python.
homepage: https://github.com/linsalrob/repeatfinder
---


# pydna_repeatfinder

## Overview
`pydna_repeatfinder` is a specialized tool for the rapid detection of repetitive DNA sequences. It identifies both direct repeats (sequences appearing in the same orientation) and inverted repeats (sequences appearing as reverse complements). This skill provides the necessary commands and programmatic patterns to integrate repeat detection into genomic workflows, whether for simple sequence analysis or complex annotation pipelines.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install bioconda::pydna_repeatfinder
```

## Command Line Usage
The primary command is `pydna_repeatfinder`. It processes FASTA files and outputs repeat locations and sequences.

### Basic Repeat Search
To find repeats in a FASTA file using default parameters:
```bash
pydna_repeatfinder -f sequence.fasta
```
The default output is a tab-separated format containing:
- Repeat Number
- Lengths of both repeat segments
- Start and end positions for both segments
- The DNA sequence of the repeats

### Generating GenBank Annotations
To output results in a format compatible with GenBank `repeat_region` features (useful for visualization in genome browsers):
```bash
pydna_repeatfinder -f sequence.fasta -o genbank
```
This produces `join()` and `complement()` expressions that can be pasted directly into a GenBank flat file.

## Python API Integration
You can integrate the repeat-finding logic directly into Python scripts using the `PyRepeatFinder` module.

### Implementation Pattern
```python
from PyRepeatFinder import find_repeats

# dna_seq: string containing the DNA sequence
# gap_len: maximum allowed gap between repeats
# min_len: minimum length of the repeat to report
# 0: flag for specific internal logic (usually set to 0)
repeats = find_repeats(dna_seq, gap_len, min_len, 0)

for rpt in repeats:
    print(f"Repeat {rpt['repeat_number']}: {rpt['first_start']} to {rpt['first_end']}")
```

## Expert Tips
- **Orientation Detection**: The tool automatically distinguishes between direct and inverted repeats. In the default output, check the start/end coordinates; if the second segment's start is greater than its end, it indicates an inverted repeat.
- **Visualization**: Always use the `-o genbank` flag if you intend to load the results into tools like Artemis, Benchling, or SnapGene, as it saves significant time in manual formatting.
- **Performance**: The underlying engine is written in C++, making it significantly faster than pure-Python repeat finders for large bacterial or viral genomes.

## Reference documentation
- [Repeat Finder - Finding Repeats in DNA sequences](./references/github_com_linsalrob_repeatfinder.md)
- [pydna_repeatfinder - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pydna_repeatfinder_overview.md)