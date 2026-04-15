---
name: pytrf
description: pytrf is a high-performance Python extension for identifying exact and approximate tandem repeats within genomic sequences. Use when user asks to find short tandem repeats, identify generic or approximate tandem repeats, or extract repeat sequences with flanking regions from FASTA or FASTQ files.
homepage: https://github.com/lmdu/pytrf
metadata:
  docker_image: "quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1"
---

# pytrf

## Overview

pytrf is a high-performance Python C extension designed for the rapid identification of tandem repeats (TRs) within genomic sequences. Unlike the original TRF tool, pytrf is a native Python library that provides both a command-line interface and a Python API. It is particularly effective for large-scale genomic datasets where speed is critical. It supports three primary types of searches: Short Tandem Repeats (STRs/SSRs), Generic Tandem Repeats (GTRs) with arbitrary motif lengths, and Approximate Tandem Repeats (ATRs) which allow for mismatches and indels.

## CLI Usage Patterns

The `pytrf` command-line tool operates on FASTA or FASTQ files.

### Finding Exact Repeats
Use `findstr` for standard microsatellites (short motifs) and `findgtr` for longer motifs.

```bash
# Find exact short tandem repeats (SSRs)
pytrf findstr input.fasta > ssr_results.txt

# Find generic tandem repeats (motifs up to 100bp)
pytrf findgtr input.fasta > gtr_results.txt
```

### Finding Approximate Repeats
Use `findatr` to identify imperfect repeats that contain mutations or sequencing errors.

```bash
# Find approximate tandem repeats
pytrf findatr input.fasta > atr_results.txt
```

### Sequence Extraction
The `extract` command is used to pull the actual repeat sequences and their surrounding context.

```bash
# Extract repeat sequences and 50bp flanking regions
pytrf extract --flank 50 input.fasta repeat_locations.txt > sequences.fasta
```

## Python API Integration

For custom workflows, use the Python API. Note that `pytrf` works best when paired with `pyfastx` for sequence parsing.

```python
import pytrf
import pyfastx

# Load sequences
fa = pyfastx.Fastx('genome.fa', uppercase=True)

for name, seq in fa:
    # Find Short Tandem Repeats
    for ssr in pytrf.STRFinder(name, seq):
        print(ssr.as_string())
        
    # Find Approximate Tandem Repeats with custom thresholds
    # Parameters: motif_size, min_seed_repeat, min_seed_length, max_error, min_identity
    for atr in pytrf.ATRFinder(name, seq, max_motif_size=6, min_identity=0.8):
        print(atr.as_string())
```

## Expert Tips and Best Practices

- **Pre-processing**: Always ensure sequences are uppercase if your search is case-sensitive. Use `pyfastx.Fastx(..., uppercase=True)` to handle this during parsing.
- **Performance**: For whole-genome scans, the CLI is generally faster due to reduced overhead. Redirect output to a file rather than printing to the terminal.
- **Memory Efficiency**: `pytrf` processes sequences efficiently, but when using the Python API, iterate through sequences one by one rather than loading an entire multi-FASTA file into memory.
- **ATR Tuning**: When searching for approximate repeats (`findatr`), the `min_identity` parameter is the most impactful for sensitivity. Lowering it below 0.7 may significantly increase false positives and computation time.
- **Motif Lengths**: Use `findstr` for motifs of 1-6bp. Use `findgtr` for motifs larger than 6bp (up to 100bp).



## Subcommands

| Command | Description |
|---------|-------------|
| pytrf_extract | Extracts sequences from fasta or fastq files based on repeat information. |
| pytrf_findatr | Finds tandem repeats in a FASTA or FASTQ file. |
| pytrf_findgtr | Finds tandem repeats in a fasta or fastq file. |
| pytrf_findstr | Finds simple tandem repeats in fasta or fastq files. |

## Reference documentation
- [Pytrf GitHub Repository](./references/github_com_lmdu_pytrf.md)
- [Pytrf README](./references/github_com_lmdu_pytrf_blob_master_README.rst.md)
- [ATR Finder Implementation Details](./references/github_com_lmdu_pytrf_blob_master_atrfinder.py.md)