---
name: plek
description: PLEK distinguishes between long non-coding RNAs and mRNAs by analyzing k-mer frequencies using a Support Vector Machine. Use when user asks to predict lncRNAs, classify transcripts as coding or non-coding, or train a custom classification model for specific organisms.
homepage: https://sourceforge.net/projects/plek
---


# plek

## Overview
PLEK (Predictor of Long non-coding RNAs and mRNAs based on k-mer scheme) is a specialized tool for distinguishing between lncRNAs and mRNAs. It operates by analyzing intrinsic sequence features through k-mer frequencies and Support Vector Machines (SVM). Unlike many other predictors, PLEK does not require a reference genome or sequence alignment, making it highly efficient for transcriptomes of non-model organisms or large-scale genomic data.

## Installation
The most reliable way to install PLEK is via Bioconda:
```bash
conda install bioconda::plek
```
Alternatively, for source installations, ensure a C/C++ compiler and Python 2.7+ are available, then run `python PLEK_setup.py` within the source directory.

## Prediction Workflows

### Standard Prediction (PLEK v1.2)
Use `PLEK.py` for general-purpose classification.
```bash
python PLEK.py -fasta input.fa -out output_results -thread 10
```
**Key Parameters:**
- `-fasta`: Input FASTA file containing sequences to predict.
- `-out`: Name of the output file. Results are labeled as "Coding" (mRNA) or "Non-coding" (lncRNA).
- `-thread`: Number of CPU threads (default: 5).
- `-minlength`: Minimum sequence length to process (default: 200nt).
- `-isoutmsg`: Set to `1` to see progress details in the terminal.

### High-Performance Prediction (PLEK v2)
PLEKv2 uses a coding-net model and is generally faster and more accurate for specific clades.
```bash
python PLEK2.py -i input.fasta -m ve
```
**Model Selection (`-m`):**
- `ve`: Use for vertebrate sequences.
- `pl`: Use for plant sequences.

## Custom Model Training
If the default models are unsuitable for your specific organism, use `PLEKModelling.py` to build a custom classifier.

```bash
python PLEKModelling.py -mRNA mRNAs.fa -lncRNA lncRNAs.fa -prefix my_model -thread 12
```

**Best Practices for Training:**
- **Sample Quality**: Remove transcripts annotated as 'pseudogene', 'predicted', or 'putative' to improve model accuracy.
- **Balance**: Use `-isbalanced 1` if your training sets for mRNA and lncRNA are significantly different in size.
- **K-mer Size**: The default `-k 5` is optimal for most use cases, but `-k 4` can be used for faster, less granular training.

## Expert Tips
- **Memory Management**: Increasing the `-thread` count in `PLEKModelling.py` significantly increases memory consumption. Monitor RAM usage when training on large datasets.
- **Sequence Filtering**: PLEK is not suitable for organisms with extremely compact genomes. Ensure your input sequences meet the minimum length requirement (default 200nt) to avoid biased k-mer distributions.
- **Temporary Files**: By default, PLEK removes temporary files. If a run fails, use `-isrmtempfile 0` to inspect the intermediate SVM files for troubleshooting.

## Reference documentation
- [PLEK Files and Readme](./references/sourceforge_net_projects_plek_files.md)
- [Bioconda PLEK Overview](./references/anaconda_org_channels_bioconda_packages_plek_overview.md)