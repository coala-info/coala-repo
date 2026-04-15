---
name: svhip
description: SVHIP identifies functional RNA elements in genomic data by analyzing secondary structure conservation and sequence features using machine learning. Use when user asks to generate training data from alignments, train classification models, slice alignments into windows, or predict functional RNA regions in genomic sequences.
homepage: https://github.com/chrisBioInf/Svhip
metadata:
  docker_image: "quay.io/biocontainers/svhip:1.0.9--hdfd78af_0"
---

# svhip

## Overview
SVHIP (Secondary Structure Conservation-based High-throughput Identification Pipeline) is a specialized tool for identifying functional RNA elements within genomic data. It leverages machine learning to distinguish between coding, non-coding, and other genomic regions by analyzing multiple sequence alignments. The pipeline is modular, allowing users to either use pre-trained models or build custom classifiers tailored to specific organisms or genomic contexts.

## Core Workflows

### 1. Data Generation (`data`)
Prepares the feature matrix required for training. It aligns input sequences using Clustal Omega and calculates structural features.
- **Requirement**: Must provide either `--coding` or `--noncoding` directories containing FASTA files.
- **Negative Control**: By default, it attempts to use SISSIz. Use `--shuffle-control` to fallback to simple column shuffling if SISSIz is unavailable.
- **Example**: `python svhip.py data --coding ./cds --noncoding ./ncrna -o features.tsv -n 100 -l 120`

### 2. Model Training (`train`)
Trains a classifier based on the TSV generated in the data step.
- **Model Types**: RF (Random Forest - default), SVM (Support Vector Machine), or LR (Logistic Regression).
- **Optimization**: Use `--optimize-hyperparameters` with `--optimizer randomwalk` for a faster alternative to grid search.
- **Example**: `python svhip.py train -i features.tsv -o my_model -M RF --optimize-hyperparameters`

### 3. Alignment Windowing (`windows`)
Slices large alignments into smaller, overlapping windows suitable for prediction.
- **Identity Filtering**: Use `--min-id` and `--max-id` to filter out windows with too little or too much sequence conservation.
- **Example**: `python svhip.py windows -i genome_aln.clustal -o windows.aln -l 120 -s 80 --opt-id 0.8`

### 4. Prediction (`predict`)
Applies a trained model to alignment windows to classify them.
- **Genomic Coordinates**: Use MAF input and the `--bed` flag to generate a BED file with merged overlapping annotations.
- **Strand Analysis**: Use `--both-strands` to ensure comprehensive scanning of the alignment.
- **Example**: `python svhip.py predict -i query.maf -o results.tsv -M my_model.model -H hexamer_models/Human_hexamer.tsv --bed --both-strands`

## Expert Tips
- **Hexamer Models**: Always specify a relevant hexamer model via `-H`. If working with non-human data, use `hexcalibrate` to generate a species-specific model first.
- **Structural Filtering**: By default, SVHIP filters windows by statistical significance of structure. If your data is expected to have weak structural signals, consider disabling this with `-S True`.
- **Thread Management**: SVHIP defaults to `CPU_COUNT - 1`. For high-throughput genomic scans, ensure your environment has `viennarna` and `clustalo` in the PATH, as these are external dependencies called by the script.



## Subcommands

| Command | Description |
|---------|-------------|
| svhip.py | Calculates codon conservation scores for SVHIP analysis. |
| svhip.py | Combine feature vectors from multiple files. |
| svhip.py | Processes input data for svhip, potentially generating control datasets and optimizing alignments. |
| svhip.py | Evaluate SVHIP models or make predictions. |
| svhip.py | Calculate features for SVHIP. |
| svhip.py | Options: |
| svhip.py | Index SVHIP data |
| svhip.py | Predicts structural variations using a trained model. |
| svhip.py | svhip.py |

## Reference documentation
- [SVHIP README](./references/github_com_chrisBioInf_svhip_blob_main_README.md)
- [SVHIP Main Script](./references/github_com_chrisBioInf_svhip_blob_main_svhip.py.md)