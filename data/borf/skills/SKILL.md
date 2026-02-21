---
name: borf
description: `borf` is a Python-based command-line tool designed to identify and extract Open Reading Frames (ORFs) from RNA sequences.
homepage: https://github.com/betsig/borf
---

# borf

## Overview
`borf` is a Python-based command-line tool designed to identify and extract Open Reading Frames (ORFs) from RNA sequences. While it can be used for any nucleotide FASTA file, it is particularly effective for de novo assembled transcripts (e.g., from Trinity) where sequences may be fragmented or missing start/stop codons. It produces two primary outputs: a peptide FASTA file (.pep) and a detailed metadata file (.txt) containing coordinates, strand information, and ORF classifications.

## Installation
Install via Bioconda or Pip:
```bash
conda install bioconda::borf
# OR
pip install borf
```

## Core Usage Patterns

### Basic Prediction
To run with default settings (minimum 100 AA length, longest ORF per transcript):
```bash
borf input.fa
```
This generates `input.pep` and `input.txt`.

### Customizing Output Path
Use the `-o` flag to specify a base name or directory for output files:
```bash
borf input.fa -o results/my_analysis
```
This creates `results/my_analysis.pep` and `results/my_analysis.txt`.

### Handling Strand and Multiplicity
By default, `borf` predicts the single longest ORF on the sense strand.
- **Both Strands**: Use `-s` to check both forward and reverse strands.
- **All ORFs**: Use `-a` to report every ORF passing the length threshold rather than just the longest one.
```bash
borf input.fa -s -a
```

### Adjusting Thresholds
- **Minimum Length**: Change the minimum amino acid length (default is 100).
- **Upstream Buffer**: Adjust the minimum uninterrupted sequence required for `incomplete_5prime` classifications (default is 50).
```bash
borf input.fa -l 50 -u 30
```

## Understanding ORF Classifications
The `.txt` output categorizes ORFs into four classes based on the presence of start (Methionine) and stop codons:
- **complete**: Starts with M, ends with *.
- **incomplete_5prime**: Missing start codon (starts with ALT), ends with *.
- **incomplete_3prime**: Starts with M, missing stop codon (ends with ALT).
- **incomplete**: Missing both start and stop codons.

## Expert Tips
- **De Novo Assembly**: When working with Trinity assemblies, keep the `-u` (upstream length) at 50 or higher. Setting this too low increases false positives from non-coding regions that happen to lack stop codons.
- **Functional Annotation**: Use the `.pep` output as input for tools like HMMER or BLASTP to assign functions to your predicted ORFs.
- **Coordinate System**: Note that `start_site_nt` and `stop_site_nt` in the `.txt` file refer to the nucleotide positions in the original transcript, which is essential for mapping back to the genome or assembly.

## Reference documentation
- [borf - orf prediction using python](./references/github_com_signalbash_borf_wiki.md)
- [borf - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_borf_overview.md)