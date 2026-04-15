---
name: selene-sdk
description: Selene is a framework for developing and training sequence-level deep learning models in genomics using PyTorch. Use when user asks to train models on genomic datasets, perform variant effect prediction, conduct in silico mutagenesis, or sample sequences from FASTA and BED files.
homepage: https://github.com/FunctionLab/selene
metadata:
  docker_image: "quay.io/biocontainers/selene-sdk:0.6.0--py312h0fa9677_2"
---

# selene-sdk

## Overview

Selene is a specialized framework designed to streamline the development of sequence-level deep learning models in genomics. It acts as a bridge between raw biological data—such as genome sequences (FASTA) and functional annotations (BED, BigWig)—and PyTorch-based neural networks. 

Use this skill to:
- Configure and execute model training on genomic datasets.
- Perform variant effect prediction to assess how genetic changes impact model outputs.
- Conduct in silico mutagenesis to identify critical sequence motifs.
- Manage complex data sampling strategies (e.g., random positions or specific genomic intervals).

## Installation and Environment

Selene requires PyTorch (compatible with versions 1.0.0 through 2.3.1). For optimal performance, a CUDA-enabled NVIDIA GPU is strongly recommended, as training on CPUs can take orders of magnitude longer.

- **Conda (Recommended):** `conda install -c bioconda selene-sdk`
- **Pip:** `pip install selene-sdk`
- **Source:** Requires `NumPy`, `Cython`, and `setuptools` to be installed prior to running `python setup.py install`.

## Command Line Interface (CLI) Usage

The Selene CLI is the primary way to run large-scale operations. It uses a single entry point:

```bash
selene_sdk <path_to_configuration_file>
```

### Core Operations
The CLI executes the operation specified in the configuration file:
- **train**: Initializes model training, handles checkpointing, and logs performance metrics.
- **evaluate**: Runs the model on a test dataset to compute performance statistics (e.g., ROC AUC, PR AUC).
- **predict**: Uses a trained model to predict the effects of specific sequence variations or to perform genome-wide scoring.

## Python API (SDK) Best Practices

For custom workflows, use the `selene_sdk` Python package directly.

### Data Sampling
Selene provides specialized samplers to handle the unique challenges of genomic data:
- `selene_sdk.samplers.RandomPositionsSampler`: Samples sequences randomly from the genome.
- `selene_sdk.samplers.IntervalsSampler`: Samples from specific genomic coordinates provided in a BED file.
- `selene_sdk.samplers.MultiSampler`: Useful for combining multiple data sources or handling imbalanced datasets.

### Sequence Handling
Use the `selene_sdk.sequences` module for efficient sequence retrieval:
- `Genome`: Loads a FASTA file and provides fast access to specific subsequences.
- `Sequence`: A base class for handling arbitrary biological sequences.

### Training and Evaluation
- `selene_sdk.train_model.TrainModel`: A high-level wrapper that manages the training loop, including loss calculation, backpropagation, and validation.
- `selene_sdk.predict.AnalyzeSequences`: The core class for variant effect prediction and in silico mutagenesis.

## Expert Tips

- **Memory Management**: When working with large genomic datasets, ensure your `target_path` (BED/BigWig) is indexed (e.g., using Tabix) to allow Selene to perform random access without loading the entire file into memory.
- **Reproducibility**: Selene 0.5.0+ includes improved seeding. Always set the `seed` parameter in your configuration to ensure reproducible data sampling and weight initialization.
- **Variant Prediction**: For variant effect prediction, Selene expects a VCF file or a specific .ref/.alt format. Ensure your reference genome matches the version used to train the model (e.g., hg19 vs. GRCh38).
- **Performance Metrics**: Selene can output a wide range of metrics. For multi-class classification, ensure you are using the appropriate evaluation class to avoid misleading performance summaries.

## Reference documentation
- [Selene GitHub Repository](./references/github_com_FunctionLab_selene.md)
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_selene-sdk_overview.md)