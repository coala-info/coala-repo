---
name: deepfplearn
description: DeepFPlearn predicts associations between small molecules and biological targets using fingerprint-based or graph neural network models. Use when user asks to train machine learning models for drug discovery, predict molecular properties, or convert chemical structures into binary fingerprints.
homepage: https://github.com/yigbt/deepFPlearn
metadata:
  docker_image: "quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1"
---

# deepfplearn

## Overview

DeepFPlearn (and its extension DeepFPlearn+) is a specialized tool for predicting the association between small molecules and multiple targets, such as receptor proteins. It transforms chemical representations into either binary fingerprints or molecular graphs to feed into neural network architectures. Use this skill when you need to perform large-scale virtual screening, toxicity prediction, or structural data preparation for machine learning models in drug discovery.

## Installation and Environment

The tool is available via Bioconda and container registries.

- **Conda**: `conda install bioconda::deepfplearn`
- **Docker**: `docker run --gpus all registry.hzdr.de/department-computational-biology/deepfplearn/deepfplearn:latest dfpl [ARGS]`
- **Singularity**: `singularity run --nv dfpl.sif dfpl [ARGS]`

## Command Line Usage

DeepFPlearn operates in five primary modes. Access help for any mode using `dfpl <mode> --help`.

### 1. Fingerprint-based Models
Use these modes for standard neural networks using topological fingerprints.
- **Training**: `dfpl train --input <data.csv> --output <model_dir>`
- **Prediction**: `dfpl predict --input <data.csv> --model <model_file>`

### 2. Graph Neural Network (GNN) Models
Use these modes to represent molecules as graphs rather than fixed-length fingerprints.
- **Training**: `dfpl traingnn --input <data.csv> --output <model_dir>`
- **Prediction**: `dfpl predictgnn --input <data.csv> --model <model_file>`

### 3. Data Conversion
- **Convert**: `dfpl convert --input <smiles.csv> --output <fingerprints.pkl>`
  - Converts SMILES/InChI strings into a binary format for faster loading during training.

## Data Preparation Best Practices

### Input Format Requirements
- **CSV Files**: Must contain a header row.
- **Required Columns**: At least one column named `smiles` or `inchi`.
- **Target Labels**: For training, include columns representing the targets (usually binary 0/1 for association).

### Performance Optimization
- **Use Pickle Files**: Calculate fingerprints once and save them as `.pkl` files. DeepFPlearn loads these significantly faster than raw SMILES.
  ```python
  import dfpl.fingerprint as fp
  data = fp.importDataFile("molecules.csv")
  data.to_pickle("molecules.pkl")
  ```
- **Custom Imports**: If your data lacks headers or uses non-standard delimiters (like TSV), use the Python API with a lambda function:
  ```python
  import pandas as pd
  import dfpl.fingerprint as fp
  data = fp.importDataFile("data.tsv", import_function=(lambda f: pd.read_table(f, names=["id", "inchi", "target"])))
  ```

## Expert Tips

- **GPU Acceleration**: When using Docker or Singularity, always include the `--gpus` or `--nv` flags to utilize hardware acceleration, as deep learning training on CPUs is significantly slower.
- **File Extensions**: Ensure pre-processed data files use the `.pkl` extension; otherwise, the tool may fail to recognize them as binary DataFrames.
- **Mode Selection**: Use `traingnn` when structural spatial relationships are critical; use standard `train` for faster iterations on well-defined chemical scaffolds where fingerprints are sufficient.

## Reference documentation
- [DeepFPlearn GitHub Repository](./references/github_com_yigbt_deepFPlearn.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepfplearn_overview.md)