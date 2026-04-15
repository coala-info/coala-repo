---
name: nwalign3
description: The nwalign3 tool performs global sequence alignment for DNA, RNA, or protein sequences using the Needleman-Wunsch algorithm. Use when user asks to perform global sequence alignments, calculate alignment scores, or customize gap penalties and substitution matrices.
homepage: https://github.com/briney/nwalign3
metadata:
  docker_image: "quay.io/biocontainers/nwalign3:0.1.6--py39hff726c5_0"
---

# nwalign3

## Overview

The `nwalign3` skill provides a robust implementation of the Needleman-Wunsch algorithm for global sequence alignment. It is a Python 3-compatible update of the original `nwalign` package. Use this skill to generate optimal global alignments for DNA, RNA, or protein sequences via the command line or within Python scripts, allowing for fine-tuned control over gap penalties and substitution matrices.

## Installation

Install the tool using one of the following methods:

```bash
# Via pip
pip install nwalign3

# Via conda
conda install bioconda::nwalign3
```

## Command-Line Usage

Perform alignments directly from the terminal using the `nwalign3` command.

### Basic Alignment
Align two sequences using default parameters:
```bash
nwalign3 alphabet alpet
```

### Using Substitution Matrices
Specify a built-in matrix (BLOSUM62 or PAM250) or provide a path to a custom matrix file:
```bash
# Built-in matrix
nwalign3 --matrix BLOSUM62 EEAEE EEEEG

# Custom matrix file
nwalign3 --matrix /path/to/matrix_file SEQ1 SEQ2
```

### Customizing Penalties
Adjust the scoring parameters to suit specific biological contexts:
```bash
nwalign3 --match 12 --gap_open -10 --gap_extend -4 SEQ1 SEQ2
```

## Python API Usage

Integrate alignment functionality into Python workflows.

### Global Alignment
The `global_align` function returns a tuple containing the two aligned sequences.
```python
import nwalign3 as nw

# Basic alignment with a specific matrix
seqs = nw.global_align("CEELECANTH", "PELICAN", matrix='PAM250')

# Alignment with custom penalties
seqs = nw.global_align("CEELECANTH", "PELICAN", gap_open=-10, gap_extend=-4, matrix='PAM250')
```

### Scoring an Existing Alignment
Calculate the score of a pre-aligned pair of sequences:
```python
score = nw.score_alignment('CEELE-CANTH', '-PEL-ICAN--', gap_open=-5, gap_extend=-2, matrix='PAM250')
```

## Best Practices

- **Matrix Selection**: Use `BLOSUM62` for general protein alignments and `PAM250` for more distantly related sequences.
- **Penalty Values**: Ensure gap penalties (`gap_open`, `gap_extend`) are provided as negative integers to correctly penalize insertions and deletions.
- **Sequence Length**: Needleman-Wunsch is a global alignment algorithm; for sequences of significantly different lengths where only a sub-region matches, consider local alignment tools instead.

## Reference documentation

- [nwalign3 GitHub Repository](./references/github_com_briney_nwalign3.md)
- [nwalign3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nwalign3_overview.md)