---
name: pupmapper
description: Pupmapper calculates pileup mappability scores to identify genomic regions where short-read sequencing data is difficult to map uniquely. Use when user asks to assess genomic dark matter, calculate k-mer mappability, filter unreliable variant calls, or generate bigwig files for mappability visualization.
homepage: https://github.com/maxgmarin/pupmapper
---


# pupmapper

## Overview

The `pupmapper` skill provides a streamlined workflow for assessing genomic "dark matter"—regions where short-read sequencing data is difficult to map uniquely. It functions by calculating the mean k-mer mappability of all k-mers overlapping a specific genomic position. This metric, known as pileup mappability, is essential for filtering unreliable variant calls and understanding the limitations of short-read Whole Genome Sequencing (WGS) for a particular reference genome.

## Installation and Dependencies

To use `pupmapper` effectively, ensure the following environment setup:

- **Conda (Recommended):** `conda install -c bioconda pupmapper`. This automatically handles binary dependencies.
- **Pip:** `pip install pupmapper`. If using pip, you must manually ensure `genmap` and `bigtools` are available in your `$PATH`.

## Core Usage Patterns

The primary entry point is the `pupmapper all` command, which executes the full pipeline from a FASTA file to mappability scores.

### Basic Pipeline Execution
Run the standard analysis with a defined k-mer length and mismatch tolerance:
```bash
pupmapper all -i reference.fasta -o output_dir/ -k 50 -e 1
```

### Advanced Output Configuration
For downstream visualization or large-scale data processing, enable specific output formats:
```bash
pupmapper all -i reference.fasta -o output_dir/ -k 100 -e 2 --save-bigwig --save-numpy
```
- `--save-bigwig`: Generates `.bigwig` files suitable for IGV or UCSC Genome Browser.
- `--save-numpy`: Outputs compressed `.npz` files for efficient Python-based analysis.

### Integrating Annotations
If you have a GFF file, include it to correlate mappability with specific genomic features:
```bash
pupmapper all -i reference.fasta -o output_dir/ -k 150 -e 0 -g annotations.gff
```

## Expert Tips and Best Practices

- **K-mer Length Selection:** Always set `-k` to match the read length of your sequencing data (e.g., `-k 150` for standard Illumina PE150).
- **Mismatch Tolerance:** Use `-e 0` for absolute uniqueness. Use `-e 1` or `-e 2` to simulate more realistic mapping conditions where sequencing errors or small variants might occur.
- **Interpreting Scores:** A pileup mappability score of 1.0 indicates that every possible read covering that position is unique in the genome. Scores significantly below 1.0 suggest the region is prone to multi-mapping and false-positive variant calls.
- **Troubleshooting:** Use the `--verbose` flag if the Genmap step fails, as this is the most common point of failure due to memory constraints or missing dependencies.
- **Prefixing:** Use `-p <prefix>` to keep output files organized when running multiple parameters (e.g., different k-mer lengths) on the same reference.

## Reference documentation
- [Pupmapper GitHub Repository](./references/github_com_maxgmarin_pupmapper.md)
- [Bioconda Pupmapper Overview](./references/anaconda_org_channels_bioconda_packages_pupmapper_overview.md)