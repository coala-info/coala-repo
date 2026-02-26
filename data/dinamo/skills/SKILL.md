---
name: dinamo
description: DiNAMO is a discriminative motif discovery tool that identifies overrepresented IUPAC patterns by comparing signal and control DNA datasets. Use when user asks to discover motifs in DNA sequences, perform discriminative motif discovery, or find overrepresented patterns using Fisher's exact test.
homepage: https://github.com/bonsai-team/DiNAMO/
---


# dinamo

## Overview
DiNAMO is an exhaustive and efficient tool designed for the discovery of IUPAC motifs in DNA sequences. Unlike de novo motif finders that look for patterns in a single set, DiNAMO uses a discriminative approach, comparing a "signal" dataset against a "control" dataset. It employs Fisher's exact test to ensure statistical significance and outputs results in the standard MEME format for compatibility with downstream bioinformatics pipelines.

## Command Line Usage

### Basic Syntax
The minimum required parameters are the positive dataset, the negative dataset, and the desired motif length.

```bash
dinamo -pf signal.fa -nf control.fa -l 6
```

### Core Parameters
- `-pf <file>`: Path to the positive (signal) FASTA file.
- `-nf <file>`: Path to the negative (control) FASTA file.
- `-l <int>`: Length of the motifs to search for (required).
- `-o <file>`: Specify the output file name (results are in MEME format).

### Advanced Search Options
- `-d <int>`: Maximum number of degenerate IUPAC letters allowed in a motif. Increasing this allows for more flexible patterns but increases computation time.
- `-p <int>`: **Fixed-position mode**. Only processes motifs occurring at a specific offset (0..N) relative to the end of each sequence. This is useful if sequences are centered on a specific biological landmark.
- `-t <float>`: Fisher's exact test p-value threshold. The default is `0.05`. Use a stricter threshold (e.g., `0.01`) for high-confidence motifs in large datasets.
- `--no-log`: Suppresses log output to the console.

## Best Practices and Expert Tips

### Dataset Preparation
- **Balanced Lengths**: Ensure that the sequences in your signal and control files are of similar average length to avoid bias in the statistical testing.
- **Control Selection**: For ChIP-seq analysis, use genomic regions flanking the peaks or shuffled versions of the signal sequences as a control set.

### Parameter Tuning
- **Motif Length (`-l`)**: Most transcription factor binding sites are between 6 and 12 bp. If the optimal length is unknown, run multiple iterations with different `-l` values.
- **Degeneracy (`-d`)**: Start with a low degeneracy (e.g., `-d 1` or `-d 2`). High degeneracy values significantly expand the search space and may lead to motifs that are too broad to be biologically meaningful.
- **Fixed Position**: Use the `-p` flag when analyzing sequences that have been pre-aligned or centered on a specific feature, such as a Transcription Start Site (TSS) or the center of a ChIP-seq peak.

### Downstream Analysis
Since DiNAMO outputs in **MEME format**, you can directly pipe or upload the results to:
- **Tomtom**: To compare discovered motifs against known databases (like JASPAR or HOCOMOCO).
- **FIMO**: To scan other genomic sequences for occurrences of the discovered motifs.
- **MAST**: To search biological databases for sequences containing the motifs.

## Reference documentation
- [DiNAMO GitHub Repository](./references/github_com_bonsai-team_DiNAMO.md)
- [DiNAMO Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dinamo_overview.md)