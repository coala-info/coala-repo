---
name: spydrpick
description: SpydrPick detects co-evolutionary signals in aligned genomic datasets by calculating mutual information and applying the ARACNE algorithm to identify direct genomic couplings. Use when user asks to detect co-evolutionary signals, identify genomic couplings, or analyze mutual information in nucleotide alignments while correcting for population structure and linkage disequilibrium.
homepage: https://github.com/santeripuranen/SpydrPick
---


# spydrpick

## Overview
SpydrPick is a specialized command-line tool for detecting co-evolutionary signals in aligned categorical datasets, such as nucleotide sequences. It utilizes Mutual Information (MI) scoring combined with the ARACNE algorithm to distinguish between direct and indirect genomic couplings. The tool is particularly effective for bacterial datasets because it incorporates sample weighting to correct for population structure and allows users to define linkage disequilibrium thresholds to filter out physical linkage noise.

## Basic Usage
The primary command for running an analysis is:
```bash
SpydrPick -v <input_alignment.fasta>
```
The input must be in FASTA format. Nucleotides (A, C, G, T) are treated as distinct categories, while all other symbols are mapped to a single "gap" category.

## Key Command Line Options

### Genomic Context
- `--linear-genome`: Use this flag if the input represents a linear chromosome; the default assumes a circular genome.
- `--ld-threshold=<int>`: Sets the distance (in bp) for linkage disequilibrium. For bacteria, values between 500 and 20,000 are typical.
- `--genome-size=<int>`: Specify the total genome size if the input alignment does not cover the full genome and the genome is circular.

### Filtering and Sensitivity
- `--maf-threshold=<float>`: Sets the Minor Allele Frequency (default is 0.01). Increasing this to `0.05` can speed up computation with minimal loss of signal in diverse datasets.
- `--gap-threshold=<float>`: Sets the maximum allowed gap frequency for a position (default is 0.15).
- `--no-filter-alignment`: Disables all position filtering.

### Population Structure and Weighting
- `--no-sample-reweighting`: Disables the default correction for population structure (all samples weighted equally).
- `--sample-reweighting-threshold=<float>`: Adjusts the sequence identity threshold used to group similar samples for weighting.
- `--sample-weights=<file>`: Provide a custom file containing white-space delimited weights for each sequence in the alignment.

### Output Control
- `--output-indexing-base=<0|1>`: Sets the index base for output positions (default is 1).
- `--mi-values=<int>`: Specifies the exact number of top-ranking MI pairs to return.
- `--mappings-list=<file>`: If using a pre-filtered alignment, provide a file of original indices to ensure correct distance calculations and output numbering.

## Expert Tips and Best Practices
- **LD Thresholding**: It is safer to err on the side of a longer, more conservative `--ld-threshold`. Too short a distance can significantly skew the outlier and extreme outlier thresholds calculated by the tool.
- **Performance**: The primary bottleneck is the number of positions. Use `--maf-threshold` and `--gap-threshold` to focus the analysis on informative columns. A MAF of 5% (`0.05`) is often sufficient for modern bacterial genomics.
- **Output Interpretation**: The main output file (`*.edges`) contains columns for `[pos1 pos2 genome_distance ARACNE MI]`. The ARACNE value indicates the coupling strength after pruning indirect links.
- **Case Sensitivity**: The FASTA parser is case-insensitive; `a` and `A` are treated identically.

## Reference documentation
- [SpydrPick GitHub Repository](./references/github_com_santeripuranen_SpydrPick.md)
- [SpydrPick Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spydrpick_overview.md)