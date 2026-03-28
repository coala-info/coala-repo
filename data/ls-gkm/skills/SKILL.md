---
name: ls-gkm
description: LS-GKM is a gapped k-mer support vector machine tool used to predict the regulatory potential of DNA sequences. Use when user asks to train a sequence classifier, score genomic sequences for functional potential, perform cross-validation, or predict the impact of genetic variants using DeltaSVM.
homepage: https://github.com/Dongwon-Lee/lsgkm
---


# ls-gkm

## Overview
LS-GKM (Large-Scale Gapped k-mer SVM) is a specialized tool for predicting the regulatory potential of DNA sequences. It improves upon original gkm-SVM implementations by offering better scalability for large genomic datasets and advanced kernel functions. It is primarily used in bioinformatics to identify enhancers, promoters, and other regulatory elements by learning the "vocabulary" of gapped k-mers that distinguish functional sequences from genomic backgrounds.

## Core Workflows

### Training a Model
Use `gkmtrain` to build a classifier. You must provide a positive set (e.g., ChIP-seq peaks) and a negative set (e.g., flanking regions or GC-matched random sequences).

**Basic Command:**
```bash
gkmtrain <posfile.fa> <negfile.fa> <outprefix>
```

**Key Parameters:**
- `-t <0-5>`: Kernel selection. Default is **4 (wgkm)**, which is center-weighted and generally provides the highest accuracy.
- `-l <int>`: Word length (default: 11). Range 3-12.
- `-k <int>`: Number of informative columns (default: 7).
- `-d <int>`: Maximum mismatches (default: 3).
- `-m <float>`: Cache memory in MB. **Expert Tip**: Set this to `4000` or higher (if RAM allows) to significantly reduce runtime on large datasets.
- `-T <1|4|16>`: Number of threads. Only specific values (1, 4, 16) are supported.

### Cross-Validation
To evaluate model performance before full deployment, use the `-x` flag.
```bash
gkmtrain -x 5 <pos.fa> <neg.fa> <outprefix>
```
The results will be stored in `<outprefix>.cvpred.txt`.

### Scoring Sequences
Use `gkmpredict` to apply a trained model to new sequences.

**Basic Command:**
```bash
gkmpredict <test_seq.fa> <model_file.txt> <output.txt>
```

### DeltaSVM (Variant Effect Prediction)
To predict the impact of a mutation (SNP):
1. Generate all possible non-redundant k-mers using the provided python script: `python scripts/nrkmers.py`.
2. Score these k-mers using `gkmpredict`.
3. Use the resulting weights with the `deltasvm.pl` script to calculate the difference in scores between reference and alternate alleles.

## Expert Tips and Best Practices
- **Kernel Selection**: If using RBF kernels (`-t 3` or `-t 5`), it is recommended to set `-c 10` and `-g 2` for optimal performance.
- **Reverse Complement**: By default, the tool considers the reverse complement as the same feature. If your data is strand-specific and this behavior is not desired, use the `-R` flag.
- **Sequence Length**: If sequences exceed the internal `MAX_SEQ_LENGTH`, the tool will issue a warning and only process the first N nucleotides. Ensure your input FASTA sequences are trimmed to the relevant functional window (e.g., 200-1000bp).
- **Memory Management**: For large-scale datasets (hundreds of thousands of sequences), the default 100MB cache is insufficient. Always scale `-m` to the maximum available system memory to avoid heavy disk I/O.



## Subcommands

| Command | Description |
|---------|-------------|
| gkmpredict | Predict functional genomic elements using gapped k-mer SVM (ls-gkm). |
| gkmtrain | Train a Gapped K-mer Support Vector Machine (gkm-SVM) model using positive and negative training sequences. |

## Reference documentation
- [LS-GKM GitHub Repository](./references/github_com_Dongwon-Lee_lsgkm.md)
- [LS-GKM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ls-gkm_overview.md)