---
name: pupmapper
description: Pupmapper calculates pileup mappability scores to quantify the uniqueness of genomic positions based on overlapping k-mers. Use when user asks to calculate k-mer uniqueness, identify genomic dark matter, or generate mappability tracks for short-read sequencing analysis.
homepage: https://github.com/maxgmarin/pupmapper
---

# pupmapper

## Overview

Pupmapper is a specialized bioinformatics tool designed to quantify the "uniqueness" of genomic positions based on overlapping k-mers. While standard k-mer mappability tells you if a specific sequence is unique, pileup mappability provides a more practical metric for short-read sequencing: it calculates the mean mappability of all possible reads that could cover a specific base. This is essential for identifying "genomic dark matter" or regions where variant calls are likely to be low-quality due to homology or repetitive elements.

## Core Workflow

The primary entry point for the tool is the `pupmapper all` command, which handles the end-to-end process of indexing the genome, calculating k-mer uniqueness using Genmap, and summarizing those into pileup scores.

### Running the Full Pipeline

To process a genome from scratch, use the following pattern:

```bash
pupmapper all -i reference.fasta -o output_dir/ -k 50 -e 1
```

**Key Parameters:**
- `-k`: The k-mer length. This should typically match your intended sequencing read length (e.g., 50, 100, or 150).
- `-e`: The number of allowed mismatches (Hamming distance). Use `0` for perfect matches only, or `1-2` to account for sequencing errors or SNPs.
- `-i`: Input genome in FASTA format.
- `-o`: Output directory for all intermediate and final files.

### Output Formats

By default, pupmapper produces summary files. For downstream analysis or visualization, use these flags:
- `--save-bigwig`: Generates a `.bigwig` file, ideal for viewing mappability tracks in IGV or UCSC Genome Browser.
- `--save-numpy`: Saves scores as compressed `.npz` arrays for custom Python-based data analysis.
- `-p [prefix]`: Customizes the output filename prefix (defaults to the genome's basename).

## Expert Tips and Best Practices

### Interpreting Scores
- **Score = 1.0**: All k-mers overlapping this position are unique. Variant calling is highly reliable.
- **Score < 1.0**: At least one overlapping k-mer is non-unique. The lower the score, the higher the risk of multi-mapping reads and false-positive variant calls.
- **Score = 0**: No unique k-mers overlap this position. This region is effectively "blind" to standard short-read mapping.

### Integration with Annotations
If you have a GFF file for your genome, provide it using the `-g` flag. This allows pupmapper to correlate mappability issues with specific genomic features (like genes or exons).

```bash
pupmapper all -i genome.fasta -o results/ -k 100 -e 2 -g annotations.gff
```

### Troubleshooting Dependencies
Pupmapper acts as a wrapper. Ensure the following are in your `$PATH`:
1. **Genmap**: Required for the initial k-mer uniqueness calculation.
2. **bigtools**: Required if you are using the `--save-bigwig` option.

If using Conda, these are managed automatically:
`conda install -c bioconda pupmapper`



## Subcommands

| Command | Description |
|---------|-------------|
| pupmapper all | Directory for all outputs of k-mer and pileup mappability processing. |
| pupmapper genmap | Generate k-mer mappability values using Genmap (indexing and mapping steps) |

## Reference documentation
- [Pupmapper GitHub README](./references/github_com_maxgmarin_pupmapper_blob_main_README.md)
- [Pupmapper Project Metadata](./references/github_com_maxgmarin_pupmapper_blob_main_pyproject.toml.md)