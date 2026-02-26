---
name: preface
description: PREFACE estimates the fetal fraction from shallow-depth whole-genome sequencing data using supervised learning models. Use when user asks to estimate the proportion of fetal-derived cell-free DNA, train laboratory-specific models, or predict fetal fraction from copy number alteration files.
homepage: https://github.com/CenterForMedicalGeneticsGhent/PREFACE
---


# preface

## Overview

PREFACE (PREdict FetAl ComponEnt) is a specialized bioinformatics tool for estimating the "fetal fraction"—the proportion of fetal-derived cell-free DNA in maternal plasma. Unlike methods that require specific experimental workflows, PREFACE works directly with shallow-depth whole-genome sequencing (WGS) data. It supports supervised learning to create laboratory-specific models, which helps eliminate inter-laboratory bias, and can utilize both male and female samples for training.

## Input Requirements

### Copy Number Alteration (.bed) Files
Every sample (training or prediction) must be in a tab-separated BED format with a header.
- **Required Columns**: `chr`, `start`, `end`, `ratio`.
- **Chromosomes**: 1-22, X, and Y (uppercase).
- **Ratio**: log2-transformed ratio of observed vs. expected copy number. Use `NA` or `NaN` for unknown values (e.g., centromeres).
- **Consistency**: All files in a project must have the same number of lines and identical genomic coordinates (loci). A 100 kb bin size is recommended.

### Training Config File
A tab-separated file with a header containing:
- `ID`: Unique sample identifier.
- `filepath`: Absolute path to the sample's .bed file.
- `gender`: `M` or `F`.
- `FF`: The "true" fetal fraction (e.g., calculated via Y-chromosomal read counts for males).

## Command Line Usage

### Model Training
Train a new model using retrospective data.

```bash
RScript PREFACE.R train --config path/to/config.txt --outdir path/to/output/ [options]
```

**Key Training Options:**
- `--nfeat [int]`: Number of principal components (PCs) to use as features. Default is 50.
- `--olm`: Use an ordinary linear model instead of a neural network. Recommended if the neural network fails to converge or for very small datasets.
- `--femprop`: Use this if the provided fetal fraction (FF) labels for female fetuses are known to be proportional to their actual FF. By default, female FF labels are ignored during training.
- `--cpus [int]`: Number of threads for multiprocessing.

### Predicting Fetal Fraction
Estimate the fetal fraction for a new sample using a pre-trained model.

```bash
RScript PREFACE.R predict --infile path/to/sample.bed --model path/to/model.RData [options]
```

**Key Prediction Options:**
- `--json [filename]`: Output results in JSON format. If no filename is provided, it prints to stdout.

## Expert Tips and Optimization

### Optimizing Features (--nfeat)
The `--nfeat` parameter is the most critical for model accuracy. After training, review the generated `overall_performance.png` plot:
1. **Random Phase**: Look for the PCs that explain variance related to the fetal fraction.
2. **Non-random Phase**: These represent Gaussian noise.
3. **Selection**: Set `--nfeat` to capture the "random" phase while excluding the "non-random" noise phase to prevent convergence issues.

### Convergence Issues
If the neural network does not converge:
- Reduce the number of features (`--nfeat`).
- Increase the training set size (benchmarks suggest ~1100 samples for high correlation).
- Switch to the linear model using the `--olm` flag.

## Reference documentation
- [PREFACE GitHub Repository](./references/github_com_CenterForMedicalGeneticsGhent_PREFACE.md)
- [Bioconda PREFACE Overview](./references/anaconda_org_channels_bioconda_packages_preface_overview.md)