---
name: midsv
description: midsv transforms sequence alignments into a reference-length-consistent format that represents matches, insertions, deletions, substitutions, and inversions. Use when user asks to transform SAM files into MIDSV format, extract Phred quality scores from alignments, or generate VCF files for variant analysis.
homepage: https://github.com/akikuno/mids
---


# midsv

## Overview

The `midsv` skill enables the transformation of sequence alignments into a specialized comma-separated format called MIDSV (Match, Insertion, Deletion, Substitution, and inVersion). Unlike standard SAM strings, MIDSV provides a reference-length-consistent representation of mutations while preserving original nucleotides. This tool is essential for researchers performing high-resolution mutation calling on long-read sequencing data or targeted amplicons. It also supports the extraction of Phred quality scores (QSCORE) and the generation of VCF files for downstream variant analysis.

## Installation

Install `midsv` via Bioconda or PyPI:

```bash
# Bioconda (Recommended)
conda install -c bioconda midsv

# PyPI
pip install midsv
```

## Core Usage Patterns

### Transforming SAM to MIDSV
The primary function is `midsv.transform()`. It requires a SAM file as input and returns a list of dictionaries.

```python
import midsv

# Basic transformation
alignments = midsv.transform("input.sam")

# Transformation with quality scores and specific SAM fields
alignments = midsv.transform(
    "input.sam", 
    qscore=True, 
    keep=['FLAG', 'POS', 'CIGAR']
)
```

### Working with I/O Helpers
`midsv` provides utility functions to handle SAM and JSONL (JSON Lines) formats efficiently.

```python
from midsv.io import read_sam, write_jsonl, read_jsonl

# Read SAM as an iterator
sam_data = read_sam("input.sam")

# Save MIDSV results to JSONL
midsv_results = midsv.transform("input.sam")
write_jsonl(midsv_results, "output.jsonl")

# Read MIDSV results back from JSONL
data_iterator = read_jsonl("output.jsonl")
```

### Exporting to VCF
You can convert MIDSV-formatted alignments directly into VCF files for variant calling.

```python
from midsv import transform
from midsv.io import write_vcf

alignments = transform("input.sam")
write_vcf(alignments, "variants.vcf", large_sv_threshold=50)
```

## Expert Tips and Best Practices

### 1. The `cstag` Requirement
`midsv` **requires** long-format `cstag` tags in the SAM file to function. 
- If using `minimap2`, always include the `--cs=long` flag.
- If your SAM file lacks these tags, use the `cstag` tool to append them before running `midsv`.

### 2. Memory Management
`midsv` is optimized for targeted amplicon sequences (10-100 kbp). 
- **Warning**: Do not use whole chromosomes as references. This will likely exhaust system memory and cause the process to crash.

### 3. Handling Inversions
MIDSV represents inversions using lowercase nucleotides (e.g., `[acgtn]`). If you need to perform strand-specific analysis, use the built-in reverse complement tool:

```python
from midsv import formatter

midsv_tag = "=A,=A,-G,+T|+C|=A"
revcomp_tag = formatter.revcomp(midsv_tag)
```

### 4. Understanding the Output
- **MIDSV String**: Comma-separated. Length matches the reference sequence.
- **QSCORE String**: Comma-separated Phred scores. Uses `-1` for deletions or unknown positions.
- **Separator**: The `|` character is used to separate multiple nucleotides at a single insertion site, allowing for easy splitting via `.split("|")`.

## Reference documentation
- [midsv GitHub Repository](./references/github_com_akikuno_midsv.md)
- [midsv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_midsv_overview.md)