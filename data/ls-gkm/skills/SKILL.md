---
name: ls-gkm
description: ls-gkm is a high-performance tool that identifies functional regulatory elements in DNA sequences by training SVM classifiers on gapped k-mer features. Use when user asks to train a sequence-based SVM model, score DNA sequences for regulatory potential, or perform cross-validation on genomic datasets.
homepage: https://github.com/Dongwon-Lee/lsgkm
---


# ls-gkm

## Overview
ls-gkm (Large-Scale Gapped K-mer SVM) is a high-performance tool designed to identify functional regulatory elements in DNA sequences. It improves upon the original gkm-SVM by offering better scalability for large datasets and advanced kernel functions. The tool operates by learning the sequence features (gapped k-mers) that distinguish a set of positive sequences (e.g., ChIP-seq peaks) from negative sequences (e.g., genomic background or non-binding sites).

## Core Workflows

### 1. Model Training (gkmtrain)
The primary step is training a SVM classifier using positive and negative sequence sets in FASTA format.

**Basic Command:**
```bash
gkmtrain <posfile.fa> <negfile.fa> <outprefix>
```

**Key Parameters and Tuning:**
- **Kernel Selection (`-t`)**: 
  - `4` (Default): Center-weighted gkm (wgkm). Generally provides the best accuracy for most regulatory elements.
  - `2`: Standard gkm-SVM kernel.
  - `3` or `5`: RBF kernels. Use these with `-c 10 -g 2.0` for optimal performance.
- **Word Parameters**:
  - `-l`: Word length (default 11, range 3-12).
  - `-k`: Number of informative columns (default 7).
  - `-d`: Maximum mismatches (default 3).
- **Performance Tuning**:
  - `-T`: Set threads to `1`, `4`, or `16` for parallel processing.
  - `-m`: Cache memory in MB. For large datasets, `>4000` (4GB) is highly recommended to significantly reduce runtime.

### 2. Sequence Scoring (gkmpredict)
Once a model is trained (generating `<prefix>.model.txt`), use it to score new sequences.

**Basic Command:**
```bash
gkmpredict <test_seqfile.fa> <model_file.txt> <output_file.txt>
```

### 3. Validation and Evaluation
To assess model performance without a separate test set, use the N-fold cross-validation mode.

**Cross-Validation:**
```bash
gkmtrain -x 5 <posfile.fa> <negfile.fa> <outprefix>
```
The output `<outprefix>.cvpred.txt` contains SVM scores and labels for each sequence in the training set.

## Expert Tips and Best Practices

- **Reverse Complement (`-R`)**: By default, ls-gkm considers reverse complements as the same feature. If the biological signal is strand-specific, use `-R` to treat them as distinct features.
- **Imbalanced Data (`-w`)**: If your positive and negative sets are significantly different in size, use `-w <float>` to adjust the weight of the regularization parameter for the positive set.
- **DeltaSVM Preparation**: To generate weights for deltaSVM (predicting the impact of variants), first generate all non-redundant k-mers using the provided `scripts/nrkmers.py`, then score them using `gkmpredict`.
- **Memory Management**: If the tool crashes on large datasets, ensure the `-m` parameter is set to a value your system can support, as the default 100MB is often insufficient for modern genomic scales.

## Reference documentation
- [ls-gkm GitHub Repository](./references/github_com_Dongwon-Lee_lsgkm.md)
- [Bioconda ls-gkm Overview](./references/anaconda_org_channels_bioconda_packages_ls-gkm_overview.md)