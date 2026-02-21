---
name: mafft
description: MAFFT (Multiple Alignment using Fast Fourier Transform) is a high-performance bioinformatics tool designed to handle sequence datasets ranging from a few dozen to tens of thousands of sequences.
homepage: http://mafft.cbrc.jp/alignment/software/
---

# mafft

## Overview
MAFFT (Multiple Alignment using Fast Fourier Transform) is a high-performance bioinformatics tool designed to handle sequence datasets ranging from a few dozen to tens of thousands of sequences. It is particularly effective because it offers a tiered approach: high-accuracy iterative methods for small datasets and extremely fast progressive methods for large-scale genomic data. It automatically detects sequence types (DNA/RNA or Protein) and supports advanced workflows like adding fragments to a pre-existing seed alignment.

## Core Command Patterns

### Automatic Selection
If you are unsure which algorithm to use, let MAFFT decide based on your dataset size:
```bash
mafft --auto input.fasta > output.fasta
```

### High Accuracy (Small Datasets < 200 sequences)
Use these for maximum precision, especially when sequences have conserved domains or structural motifs.
- **L-INS-i** (Most accurate; recommended for < 200 sequences):
  ```bash
  mafft-linsi input.fasta > output.fasta
  ```
- **G-INS-i** (Global alignment; assumes sequences are alignable over their entire length):
  ```bash
  mafft-ginsi input.fasta > output.fasta
  ```
- **E-INS-i** (For sequences containing large unalignable regions):
  ```bash
  mafft-einsi input.fasta > output.fasta
  ```

### High Speed (Large Datasets > 2,000 sequences)
Use these for large-scale phylogenetics or genomic comparisons where speed is critical.
- **FFT-NS-2** (Default fast progressive method):
  ```bash
  mafft input.fasta > output.fasta
  ```
- **FFT-NS-1** (Very fast; builds a rough tree):
  ```bash
  mafft --retree 1 input.fasta > output.fasta
  ```

## Advanced Workflows

### Adding Sequences to an Existing Alignment
To maintain the integrity of a "seed" alignment while adding new sequences:
```bash
mafft --add new_sequences.fasta --reorder existing_alignment.fasta > combined.fasta
```
For adding short fragments (e.g., NGS reads) to a full-length reference alignment:
```bash
mafft --addfragments fragments.fasta existing_alignment.fasta > combined.fasta
```

### Parallelization
MAFFT supports multi-threading to speed up calculations:
```bash
mafft --thread 8 --auto input.fasta > output.fasta
```

### RNA Structural Alignment
When aligning non-coding RNA where secondary structure is conserved:
```bash
mafft-qinsi input.fasta > output.fasta
```

## Expert Tips
- **Memory Management**: Versions 7.463–7.486 had a bug in the `FFT-NS-i` option causing excessive memory requests. Ensure you are using version 7.487 or higher for large datasets.
- **Input Format**: MAFFT expects FASTA format. It automatically detects whether the input is amino acid or nucleotide.
- **Large Number of Short Sequences**: For datasets with many short sequences, use the chained guide tree options to improve performance.
- **Over-alignment Control**: If your sequences are highly divergent, use the `--ep` (gap extension penalty) and `--op` (gap opening penalty) parameters to tune the sensitivity and avoid "over-aligning" non-homologous regions.

## Reference documentation
- [MAFFT Software Home](./references/mafft_cbrc_jp_alignment_software.md)
- [Bioconda MAFFT Package](./references/anaconda_org_channels_bioconda_packages_mafft_overview.md)