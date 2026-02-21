---
name: snipit
description: `snipit` is a specialized tool for summarizing and visualizing genetic variation across multiple sequences.
homepage: https://github.com/aineniamh/snipit
---

# snipit

## Overview

`snipit` is a specialized tool for summarizing and visualizing genetic variation across multiple sequences. By comparing query sequences to a designated reference, it produces high-quality plots that highlight specific mutations, insertions, and deletions. It supports both nucleotide and protein alignments and is particularly effective for genomic surveillance and evolutionary analysis where identifying specific clusters of mutations is critical.

## Core Usage Patterns

### Basic Visualization
The simplest command generates a PNG plot using the first sequence in the FASTA file as the reference.
```bash
snipit alignment.fasta --output-file snp_summary
```

### Protein (Amino Acid) Alignments
When working with protein sequences, you must specify the sequence type and should use the `ugene` color palette for standard amino acid coloring.
```bash
snipit protein_align.fasta --sequence-type aa --colour-palette ugene --output-file protein_plot
```

### Filtering and Highlighting Specific Regions
You can restrict the visualization to specific genomic coordinates or exclude problematic sites (like primer binding sites).
```bash
# Only show SNPs between positions 100 and 500
snipit input.fasta --include-positions '100-500'

# Exclude specific noisy positions
snipit input.fasta --exclude-positions '10 11 12 50-60'
```

### Recombination Analysis
To visualize potential recombination, use the recombination mode to color mutations based on their presence in two different "parental" references.
```bash
snipit input.fasta \
  --reference Query_Sequence_ID \
  --recombi-mode \
  --recombi-references "Parent_A_ID,Parent_B_ID"
```

## Expert Tips and Best Practices

- **Output Formats**: For publication-quality figures that require manual editing or infinite scaling, always use `--format pdf` or `--format svg`.
- **Sorting for Clarity**: Use `--sort-by-mutation-number` to organize sequences by their genetic distance from the reference. Combine this with `--high-to-low` to place the most similar sequences closest to the reference line.
- **Handling Ambiguities**: If your data contains many ambiguous bases (N, Y, R, etc.), use `--ambig-mode all` combined with `--colour-palette classic_extended` to ensure they are visible in the plot.
- **Data Extraction**: Use the `-s` or `--write-snps` flag to generate a CSV file containing the exact coordinates and base changes alongside your image. This is essential for downstream statistical analysis.
- **Labeling**: If sequence IDs in your FASTA are long or cryptic, provide a CSV mapping file using `--labels` and `--l-header` to display clean, readable names in the final figure.
- **Orientation**: If the default plot feels crowded, try `--flip-vertical` to change the orientation of query sequences relative to the reference.

## Reference documentation
- [snipit: summarise snps relative to your reference sequence](./references/github_com_aineniamh_snipit.md)
- [snipit - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snipit_overview.md)